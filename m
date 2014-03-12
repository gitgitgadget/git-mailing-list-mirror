From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4] install_branch_config: simplify verbose messages logic
Date: Wed, 12 Mar 2014 18:49:51 -0400
Message-ID: <CAPig+cRviwyxDa3xNt6JgmRURFC-AbLRS8NnBQ4SAnm3g=Cc7g@mail.gmail.com>
References: <1394584412-7735-1-git-send-email-pawlo@aleg.pl>
	<CAPig+cTmdF06PrWboJFNFEGKLCa=3rmGrcPusSsYZxdtfSEewA@mail.gmail.com>
	<xmqqob1bjcti.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?UTF-8?Q?Pawe=C5=82_Wawruch?= <pawlo@aleg.pl>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 23:50:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNryJ-0001RX-AR
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 23:49:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752426AbaCLWty (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 18:49:54 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:40588 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977AbaCLWtw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 18:49:52 -0400
Received: by mail-yk0-f170.google.com with SMTP id 9so555748ykp.1
        for <git@vger.kernel.org>; Wed, 12 Mar 2014 15:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=3m3xcpGw2EbugXvaWtzcEaZkntpO9vAB5z9aqkXQxUQ=;
        b=nPK8+p3vghAhNm7vTY3m2Mpa7BkreC/h6F5Fn2WFSRIWpJ7jbaaYpNdgKMS3q1X8Kp
         tqf0stn8YK0hw+xScUR17tdnLfreqI9nwLe4BWzYpuXpPzTmZ7tYF38y3Hgx842dJcyH
         LJdLYUL1DOc3Ae4VvvODUh+5Fqse/nDzwmyFnyAazT+8bprxca9CYOQ5iTYeVixN3tla
         xqhAreqQYo1JADJQosSnKv7OEX4OBMmgUVYmA4jx1MBmdUJdd6A3EfCqv29WrDcSEV7Z
         mBomJG9NOMlO8wS0C9m1YtzJj1EsMRBOe9aUPZ1YWB9vacIy9ub6dZvwRJROzbXaQNQN
         aXag==
X-Received: by 10.236.114.43 with SMTP id b31mr235367yhh.30.1394664592001;
 Wed, 12 Mar 2014 15:49:52 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Wed, 12 Mar 2014 15:49:51 -0700 (PDT)
In-Reply-To: <xmqqob1bjcti.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: f7rOQ6cZ1667Q1iLBAyqdbzCH-I
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244007>

On Wed, Mar 12, 2014 at 6:02 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>>> +               if (origin && remote_is_branch)
>>> +                       printf_ln(_(message[!remote_is_branch][!origin][!rebasing]),
>>> +                               local, name, origin);
>>>                 else
>>> -                       die("BUG: impossible combination of %d and %p",
>>> -                           remote_is_branch, origin);
>>> +                       printf_ln(_(message[!remote_is_branch][!origin][!rebasing]),
>>> +                               local, name);
>>
>> Shouldn't this logic also be encoded in the table? After all, the
>> point of making the code table-driven is so that such hard-coded logic
>> can be avoided. It shouldn't be difficult to do.
>
> Hmph.  Is it even necessary in the first place?  Does it hurt if you
> give more parameters than the number of placeholders in the format
> string?

It's not necessary, which is why my question was posed: as a clue. By
asking GSoC applicants to think about how the logic can be
table-driven, it is hoped that they will arrive at the realization
that it is okay to pass in more parameters than placeholders. With
that idea in mind, the code can be simplified whether table-driven or
not.

(I suspect Michael had this in mind when he composed this GSoC
microproject and asked students to consider if it would make sense to
make the code table-driven.)
