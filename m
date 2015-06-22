From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 04/19] for-each-ref: add '--points-at' option
Date: Mon, 22 Jun 2015 12:24:57 -0700
Message-ID: <xmqq7fqvh7g6.fsf@gitster.dls.corp.google.com>
References: <CAOLa=ZS_vn8ZNrb7mtqZKU4Y3RCZojcbeMYfbx=3X-aVjhdpSA@mail.gmail.com>
	<1434919705-4884-1-git-send-email-karthik.188@gmail.com>
	<1434919705-4884-4-git-send-email-karthik.188@gmail.com>
	<CAPc5daVNapbjAHwiUq5PXfCnWii4Cs1v6dvDAGFfnVkAJhFZnA@mail.gmail.com>
	<CAOLa=ZSd8KftLrRHBXY7Ch2KpVuFSb2DzCq0eLibAx1+bR9M1Q@mail.gmail.com>
	<vpqpp4nblc2.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 22 21:25:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z77LA-0000VU-4y
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 21:25:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbbFVTZB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 15:25:01 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:36757 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900AbbFVTY7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 15:24:59 -0400
Received: by iecvh10 with SMTP id vh10so25826007iec.3
        for <git@vger.kernel.org>; Mon, 22 Jun 2015 12:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=iIcClYkEsTrA6ALHJbUFJIMygRc+B6zeThlr67+k9Mg=;
        b=RNLgZW0gPPKv0FqPDgN3gnFMUDTtOxDY1CY7KOv9ZEmLAKG2JQZPv6iVobTsvq51aM
         5W3P9jzcge+V05i+juSH7W9YDHMKsHcjFz5ZkoQHuyMN5oXK6Xi4800xGjWQ6YvdTKXk
         d0DuAkbQI8xDwfJNpQ9x9qMqCdnKKBQxDz2nOWLug+U1bpWzXSUYzZr1YwCP8hgyd7z/
         c6w7uU3rs31QfbO8uQwvUnmhMrbTax4q5VzdKqgec/NKsYabQic0M+HFfDFm+KN7oZcV
         2njhttbPkoEVitJc+W/Qjuz6xELUD1ao0W8PklcD+qiq21rYsgcy791y5L7E1+Ss5I4M
         gpdw==
X-Received: by 10.107.165.210 with SMTP id o201mr41908699ioe.2.1435001099112;
        Mon, 22 Jun 2015 12:24:59 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b0be:ae3d:b206:8e25])
        by mx.google.com with ESMTPSA id l128sm13359410iol.1.2015.06.22.12.24.58
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 22 Jun 2015 12:24:58 -0700 (PDT)
In-Reply-To: <vpqpp4nblc2.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	22 Jun 2015 21:21:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272405>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> On Mon, Jun 22, 2015 at 6:15 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>>  3 & 4 as a single patch may make more sense, if we were to tolerate the
>>> "let's copy & paste first and then later remove the duplicate" as a way to
>>> postpone touching "tag.c" side in order to first concentrate on for-each-ref.
>>>
>>> I have not formed a firm opinion on what the right split of the series is, but
>>> so far (assuming that the temporary duplication is the best we can do) what
>>> I am seeing in this series makes sense to me.
>>>
>>> Thanks.
>>
>> That would mean squashing 3&4, 6&7 and 10&11 also on similar lines.
>
> I have a slight preference for keeping the pairs not squashed. This way,
> we have a clear separation "write reusable library code" / "use it". But
> I'm fine with squashing if others prefer.

As I cannot firmly say that "copy & paste first and then later
clean-up" is bad and we should split them in different way, I
am fine with leaving them separate as they are.
