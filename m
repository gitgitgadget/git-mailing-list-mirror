From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] git-remote-testgit: avoid process substitution
Date: Fri, 26 Apr 2013 17:45:49 -0500
Message-ID: <CAMP44s3j5Bk3eqPeN2qkGTWFLO2NKz0taTGYVNvEut_VM=0NXA@mail.gmail.com>
References: <7vvc7enxco.fsf@alter.siamese.dyndns.org>
	<7vwqrtgi1r.fsf@alter.siamese.dyndns.org>
	<51779052.8020507@viscovery.net>
	<CAMP44s1oX_m0d+2Z3+VkafOhT1bZK_9Z5m1ex456DMdAidEKeg@mail.gmail.com>
	<5177980A.4090305@viscovery.net>
	<5178C583.6000703@viscovery.net>
	<CAMP44s2nWs3XyaLQUnYd=A9u1=8tB7Qp+FN7gf+SrACxmtP8pw@mail.gmail.com>
	<7vobd1udz2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 27 00:45:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVrOu-0005FA-Ga
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 00:45:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755890Ab3DZWpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 18:45:52 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:48921 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755694Ab3DZWpv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 18:45:51 -0400
Received: by mail-lb0-f175.google.com with SMTP id w20so3380986lbh.34
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 15:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=jVzu50L2YjOzj/nwJtAghexK5PzSj3jfOIU/Ifm/2Sk=;
        b=lZ5ojGkAhZQbRmVLSDyfwXqcDlnd0FrhXm0NQORVgozWXfG+rHMsIer5BCGSNfjBm6
         m3kNTZ9xh/lV46Ap7XNBpj8Md3fgw949OCYPYpR9s43Yhd5NTcam9ZSRBmO2YK4zv1M2
         Tz+byGy3joSGiDS649wUkplWPh8lFuwz4Ug3qTPTutir+/9ScABE0Z+5S/Sa3bIwaOMK
         p5Z06l2yEbc+l9Clmsob5TSuXsU/A8ah1ZKbCQYwn9SAAUdXdD/y7C4K5bUXqYzXLKCr
         0Hw55kI64q6GHgVO8hyHOzy1nxDzaQA8QptjBqer67gQnl0BfRt8XVTtE1b47uTCmOv7
         /exg==
X-Received: by 10.112.140.100 with SMTP id rf4mr13888904lbb.82.1367016349960;
 Fri, 26 Apr 2013 15:45:49 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Fri, 26 Apr 2013 15:45:49 -0700 (PDT)
In-Reply-To: <7vobd1udz2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222601>

On Fri, Apr 26, 2013 at 5:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Thu, Apr 25, 2013 at 12:56 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>>> From: Johannes Sixt <j6t@kdbg.org>
>>>
>>> Bash on Windows does not implement process substitution.
>>
>> Nevermind, reporting all the refs creates a lot of irrelevant output,
>> this version is fine.
>
> When $before has this in it:
>
>         refs/heads/refs/heads/master 664059...126eaa7
>
> and your "read ref a" got this in the input:
>
>         refs/heads/master 664059...126eaa7
>
> would the pattern matching by case work corretly?

No, it wouldn't, but I don't think there's any way to do \<\> or \b in globs.

Alternatively, we could use the same $before and $after, and simply
store the output somewhere; $GIT_DIR/testgit-before, for example. This
should decrease the amount of changes needed, but I don't know if
anybody would have problems with the use of 'join'.

Cheers.

-- 
Felipe Contreras
