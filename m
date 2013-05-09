From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/3] fast-export: add new --refspec option
Date: Thu, 9 May 2013 18:32:16 -0500
Message-ID: <CAMP44s1d_9iT7nqtu3gTy=kX-Kapnf0AUZJ-Z-MpLkBuWxBgSw@mail.gmail.com>
References: <1368063095-22861-1-git-send-email-felipe.contreras@gmail.com>
	<1368063095-22861-3-git-send-email-felipe.contreras@gmail.com>
	<7vvc6r7pii.fsf@alter.siamese.dyndns.org>
	<CAMP44s2yoBFZU+LzHWT30ijbQ2rknmV1ZoB9qDDYvvme2chB7g@mail.gmail.com>
	<7v38tv7n5y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 10 01:32:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaaJz-0007Vc-4e
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 01:32:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754335Ab3EIXcT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 19:32:19 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:50642 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754301Ab3EIXcS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 19:32:18 -0400
Received: by mail-la0-f53.google.com with SMTP id eo20so3368707lab.26
        for <git@vger.kernel.org>; Thu, 09 May 2013 16:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=kXaLk/cDK+y3zIb2XLYD3mFpYfXWql7ceiAEKGl+gao=;
        b=JUM7ceHLS5xNAH5MG2d0EAmndhIuYHfq66/ZcMsfyddd3PcCb+D0GH6/aPE58rsWnJ
         eXyq7g8hODJccupd74AcJbiRA5hO9iUYxH5lcnGiqAcWBxKIag9s2IBAbnOtLW3yrIwS
         lAZ8h/mxarjeK3S8ZYOggVnhjhtAOnGz6tZwovrE4OZq2ZMxmsH2v/02rEL3HD3kMUw6
         r6N3TghmVGt1R7Cgxq1ABMlOX9rqYI1HvuRLrTJYVkpunhMAklXEjGqy3Acn0Bmh4dh6
         hQaHFbMCF5x2nbWvkeZiK9dFFFEKEQ6qHS/WxuObatDaCiJX1dsbs9E+MUbxvgu/ZSI4
         +VRA==
X-Received: by 10.152.87.69 with SMTP id v5mr6512786laz.24.1368142336717; Thu,
 09 May 2013 16:32:16 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Thu, 9 May 2013 16:32:16 -0700 (PDT)
In-Reply-To: <7v38tv7n5y.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223805>

On Thu, May 9, 2013 at 6:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Of course, but how do you implement that? That's mixing refspecs and
>> revlist arguments, which AFAIK don't mix:
>
> Simple.  You treat everything as refspecs and form revision ranges
> out of them.  Note that that is exactly the reason why "git push"
> can take "master" as a short-hand for "master:master" [*1*].

And how do you implement that?

>> % git fast-export ^next:new-next master:new-master --not
>> refs/tags/*:refs/tags/backup/*
>
> I thought you stopped mentioning the bottom of the range
> (e.g. ^next) in the output from export stream at around 49266e8a11cf
> (fast-export: don't handle uninteresting refs, 2012-11-28).

That doesn't prevent the rev-list parsing from working.

> What does ^next:new-next (or mapping after "--not" in general) even
> mean?  They would not make sense, would they?

They don't, which is precisely my point.

> So I would imagine you would be spelling that as:
>
>     git fast-export master:new-master --not next refs/tags/*
>
> or something, no?

rev-list doesn't accept 'refs/tags/*'.

-- 
Felipe Contreras
