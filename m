From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: Walking commits from the first
Date: Mon, 15 Feb 2010 17:03:14 +0530
Message-ID: <e72faaa81002150333r4eb27a15t7de6b3c820eb4bc2@mail.gmail.com>
References: <e72faaa81002142037g7f5f518erb9fefbb239124bc5@mail.gmail.com>
	 <e72faaa81002142039h5531a19y354d24e595295bb1@mail.gmail.com>
	 <20100215080646.GD5347@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 15 12:33:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgzCb-0004ep-51
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 12:33:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755421Ab0BOLdP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Feb 2010 06:33:15 -0500
Received: from mail-yw0-f197.google.com ([209.85.211.197]:49252 "EHLO
	mail-yw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755408Ab0BOLdP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Feb 2010 06:33:15 -0500
Received: by ywh35 with SMTP id 35so3725201ywh.21
        for <git@vger.kernel.org>; Mon, 15 Feb 2010 03:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=uNUbRdjViza9jog34cRDyZAecdyvASws2B+sX/K4hOE=;
        b=B+bv5N0jGMdqwYIvp1YWghQ8IIo+5O/6SQxam4hFVRceGhe4RE1cXMJelHz3lRuC9g
         jeMTv1rq7Xajsj2xNKeO+PRM9GFYcVa+e4XFt+gxknbKMxtKeSohVTkuTMOdIOv23WGB
         9iSsyv0gFcUrli1T3WXRatZjd3z/6hgdcA3Io=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=bqSn6UCR7oJUFN5x65j2qhv7g+ryhilV7kmomwvw1U3mTTqb9P6uUgo22vDPBVOWWb
         Qh/jsBNK3pHj1zwdmRZto8ejgtud7qpXXWPobHmKm1syMyxPm8SpWcvrvgQRERdXYxgg
         UhdQhFcFW7HSSN3WNK2BhPm2pLcKnq0YoVBKA=
Received: by 10.150.236.2 with SMTP id j2mr9676276ybh.44.1266233594118; Mon, 
	15 Feb 2010 03:33:14 -0800 (PST)
In-Reply-To: <20100215080646.GD5347@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140004>

> In most repositories, you can do this:
>
> =A0git checkout `git rev-list --reverse HEAD | head -n 1`
>

Thanks for the command

> It is not as simple as that, for two reasons.
>
> For walking backwards, you can take multiple paths from merge commits
> (which have multiple parents). So there may actually be several "firs=
t
> commits" if unrelated lines of development were merged together. For
> example, in git.git:
>
> =A0$ git log --format=3D'%h %p' |
> =A0 =A0grep ' $'
> =A016d6b8a
> =A0cb07fc2
> =A0161332a
> =A01db95b0
> =A02744b23
> =A0e83c516
>
> There are six root commits. You can see what they are by piping the
> above into "tr -d ' ' | git log --no-walk --stdin".
>
> For your "--next" suggestion, it is even worse. There may be an infin=
ite
> number of commits that point to a given commit as the parent. So ther=
e
> is no such thing as "what came next from X". You can only ask
> "leading up to some commit Y which is a descendant of X, what was the
> commit that came after X". But while there are a finite number of
> answers, there is not necessarily just one. If two branches diverged =
at
> X and then remerged before Y, they are both equally "next".
>
> -Peff
>

My bad. I never thought of branch merging while writing this
So, if i want to get the second commit, Is this enough or will i get
the problem of branch diverging, if there is a branch diverging from
there.

git checkout `git rev-list --reverse HEAD | head -n 2`

Even though we have the problem branches to travel reversely, we can
do it in another way. As, we have the timestamp for every commit, then
it will be easy to implement --next. Take the next commit in timeline
and checkout. Even though it's completely different branch, no problem
as long as we are going in order.

Also we can have git checkout --next --same-branch to checkout the
next commit in timeline of the same branch.
