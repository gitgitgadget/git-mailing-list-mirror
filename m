From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix power checking on OS X
Date: Fri, 12 Jun 2015 07:54:56 -0700
Message-ID: <xmqqr3phdlj3.fsf@gitster.dls.corp.google.com>
References: <1434033445-35903-1-git-send-email-pastith@gmail.com>
	<CAPig+cRzKpCePO0gXy7Rok4X7=r6tas28tv48g92YzP9tVP2AA@mail.gmail.com>
	<CACvVhd7sKiz+gTDY_RVjFf1i3Rt2pYWVsgjewyPHL1ajS5LTcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Panagiotis Astithas <pastith@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 16:55:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3QML-0003Qp-Gc
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 16:55:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754881AbbFLOzA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 10:55:00 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:34728 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753564AbbFLOy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 10:54:59 -0400
Received: by igbhj9 with SMTP id hj9so14341013igb.1
        for <git@vger.kernel.org>; Fri, 12 Jun 2015 07:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=VfKlPp0VirahbnlB9l/8I3pIX8byCiNIclQ2wBeuwq4=;
        b=QAAlQT+Z2WW7rNz4eRNc3mSl7IOVCmJB1v9ZsDh9PkCd2Rg135YuH8/89pqleBgw8s
         KNgW3aex5cNbG261pS7tAyCabnkht3Fl9D+EHaPXH7FkrvFYr00WTYazh5bJwqU9Qa/E
         1j1XwSosDUIcrGlq8EQCIZ2nzxl2wKcTc+GpOahwgFRDF46Wa7cDGcF2KAm/5HlTgKMB
         kACXpv93116OGLjF4SNbEGZSt8T8vXr6n/sBK4GwfKRp1B0m2GtF6Hu0RkKWihHteT5r
         kj4IBYYBb0Fq8LdzWEdfiUwD0gjKCyLizc/igrWeKVGpH5ICh6/fq1CIWNlrwBaZTYcx
         fvAA==
X-Received: by 10.107.31.134 with SMTP id f128mr18655364iof.19.1434120898566;
        Fri, 12 Jun 2015 07:54:58 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:ac40:153c:ed59:12ce])
        by mx.google.com with ESMTPSA id u38sm2625167ioi.0.2015.06.12.07.54.57
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 12 Jun 2015 07:54:57 -0700 (PDT)
In-Reply-To: <CACvVhd7sKiz+gTDY_RVjFf1i3Rt2pYWVsgjewyPHL1ajS5LTcQ@mail.gmail.com>
	(Panagiotis Astithas's message of "Fri, 12 Jun 2015 11:53:32 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271490>

Panagiotis Astithas <pastith@gmail.com> writes:

> On Fri, Jun 12, 2015 at 6:46 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Thu, Jun 11, 2015 at 10:37 AM, Panagiotis Astithas <pastith@gmail.com> wrote:
>>> The output of "pmset -g batt" changed at some point from
>>> "Currently drawing from 'AC Power'" to the slightly different
>>> "Now drawing from 'AC Power'". Starting the match from "drawing"
>>> makes the check work in both old and new versions of OS X.
>>
>> Would it make sense to try to future-proof this further by searching
>> only for "'AC" (including the leading single-quote) or just "AC"
>> (without the leading quote)?
>>
>> (Genuine question. I don't have a strong feeling about it.)
>
> It's a reasonable idea, although I'm wondering what are the odds of
> pmset changing to output a string when running on battery in the
> future, containing something like "no longer on 'AC Power'". That's
> probably too far out though.

Once they start drawing from USB-C, they may stop referring to AC
altogether; unless you have a crystal ball, it is futile to spend
too many brain cycles to try futureproofing.

Prediction is very difficult, especially if it's about the future.
