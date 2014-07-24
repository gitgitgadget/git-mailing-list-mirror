From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH 1/7] config.c: fix accuracy of line number in errors
Date: Fri, 25 Jul 2014 00:10:07 +0530
Message-ID: <53D15307.4060601@gmail.com>
References: <1406140978-9472-1-git-send-email-tanayabh@gmail.com>	<1406140978-9472-2-git-send-email-tanayabh@gmail.com>	<xmqqegxbd9u0.fsf@gitster.dls.corp.google.com>	<53D10B37.3000403@gmail.com> <xmqq1ttaa9sa.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 20:40:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XANwD-00081v-Do
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jul 2014 20:40:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934364AbaGXSkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2014 14:40:15 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:47654 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933437AbaGXSkO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2014 14:40:14 -0400
Received: by mail-pa0-f51.google.com with SMTP id ey11so4474412pad.38
        for <git@vger.kernel.org>; Thu, 24 Jul 2014 11:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=YUHXSi2yVWhSnj1+XrirxfY3vvcvEyGamltGyx1cY2o=;
        b=RxfPlGHODYzmmi1MFl6fKJO0zfej9hIThcuTquo/4n5G/uC6bLsx+8ZGmh8TMLkkC3
         iI8YmZHQD6K7n53pA6sOF5poG8OsxN6DPkgIaDufc2qE9hn8lWY4TK/b+ij1/w1TQf8j
         OMabELe0qq4i28R1/z4zjrTdP6C9gQSJ9ooTrYu/8q5WtHRsrwc/y1ORHzJTaKCExVSi
         1UO74y4/V/lXF7urrvmLQcqA2pAveIXV2ZNR//UP5oY+drv0ev0EgVgKb476L6w7uZMI
         EZk9egcaEV5l3v7PmVfDVNtO7aEnj1UfRz4ApVpT4eOfFE3hGo9jyZjBCNa67peixqeL
         4woA==
X-Received: by 10.66.123.36 with SMTP id lx4mr12962394pab.21.1406227213652;
        Thu, 24 Jul 2014 11:40:13 -0700 (PDT)
Received: from [127.0.0.1] ([117.96.50.136])
        by mx.google.com with ESMTPSA id i10sm23363577pat.36.2014.07.24.11.40.11
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 24 Jul 2014 11:40:13 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqq1ttaa9sa.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254175>



On 7/25/2014 12:01 AM, Junio C Hamano wrote:
> Tanay Abhra <tanayabh@gmail.com> writes:
> 
>> On 7/24/2014 3:19 AM, Junio C Hamano wrote:
>>> Tanay Abhra <tanayabh@gmail.com> writes:
>>>
>>>> If a callback returns a negative value to `git_config*()` family,
>>>> they call `die()` while printing the line number and the file name.
>>>> Currently the printed line number is off by one, thus printing the
>>>> wrong line number.
>>>>
>>>> Make `linenr` point to the line we just parsed during the call
>>>> to callback to get accurate line number in error messages.
>>>>
>>>> Discovered-by: Tanay Abhra <tanayabh@gmail.com>
>>>> Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>

This patch should have looked like,

From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>

<commit message>

Commit-message-by: Tanay Abhra <tanayabh@gmail.com>

>>>
>>> Thanks.
>>>
>>> I am not sure what to read in these two lines.  Was the fix done by
>>> you or Matthieu?
>>>
>>
>> I misunderstood the meaning of the message trailers. I will correct
>> it in the next re roll.
> 
> Well, that does not really answer my question, and it does not tell
> us if you now understand the meaning of trailers correctly, or
> replaced an earlier misunderstanding with a different
> misunderstanding ;-)
> 
> More importantly, it would not help me interpret what you mean when
> you write a sequence like this:
> 
> 	From: tanay
>         S-o-b: matthieu
>         S-o-b: tanay
>

Actually it was because that patch contained fixup patch from Matthieu
squashed into it, that is why there were two signoffs.

> which does not quite make sense and leave the reader puzzled.
> 
> If the patch was authored by you and helped by matthieu, the first
> S-o-b would be lying.  If the patch was written by matthieu and you
> are merely relaying, then the authorship From is lying.  If the
> patch was written by you and matthieu is relaying, then the two
> S-o-bs are in incorrect order.
> 
