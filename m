From: "Sverre Hvammen Johansen" <hvammen@gmail.com>
Subject: Re: [RFC/PATCH] Fast forward strategies only, common, fork and path
Date: Tue, 5 Feb 2008 19:46:35 -0800
Message-ID: <402c10cd0802051946l4e6a7a97qd2231a92c154e1fc@mail.gmail.com>
References: <402c10cd0802031654r3e0275a8s1d2163af9525e7d2@mail.gmail.com>
	 <402c10cd0802032251y626f373eke66c35b200ccf5b1@mail.gmail.com>
	 <7vwsplkwuq.fsf@gitster.siamese.dyndns.org>
	 <402c10cd0802040006yb654688l8dfc7140c507bc26@mail.gmail.com>
	 <7v8x21ku6b.fsf@gitster.siamese.dyndns.org>
	 <402c10cd0802042332i4e49cdaxf1fa1a7fc09c15b9@mail.gmail.com>
	 <7v7ihjd9lq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 04:47:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMbFv-0001Tm-Vq
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 04:47:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756882AbYBFDql (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 22:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756604AbYBFDql
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 22:46:41 -0500
Received: from fk-out-0910.google.com ([209.85.128.184]:52019 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756511AbYBFDqk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 22:46:40 -0500
Received: by fk-out-0910.google.com with SMTP id z23so2530668fkz.5
        for <git@vger.kernel.org>; Tue, 05 Feb 2008 19:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=2pg0lttbNWBqEI5OZaxZs8M5joVgeinss5UQ0AiRZcU=;
        b=LTRTdY+P3KI0Ym7c3CuDK4mmir3Z17BC3BYX8yquQL7LnKECPHFd+F9MIrpk3TAq+zxqfTfKP8e9uBBDFtDmw5m8WmWT+GtmIN5r5aJ/xZpBiEioEhaon9ogmU6uLbDtCPRQSqLIVkq96DkxIbxR77plzGCrp/37rmb+bMhFbm8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fSZzZOnh7QFbqL7YYUYkZPkflzdi+kb8wSUcmQwR6L8+USVVaLH1qFXtkMCB0NeIrhgYEZyk+iThYli8s7tyu/GHkG0J+3Jah2cRPQZSAQVyVi6AzzZESSq9AuKt5OlaKBk35h3bXyJCooPXknhQfZrI4KHfWdisxzCucRKuT7c=
Received: by 10.82.174.20 with SMTP id w20mr16945186bue.21.1202269595677;
        Tue, 05 Feb 2008 19:46:35 -0800 (PST)
Received: by 10.82.156.13 with HTTP; Tue, 5 Feb 2008 19:46:35 -0800 (PST)
In-Reply-To: <7v7ihjd9lq.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72752>

On Feb 5, 2008 1:40 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Just to avoid confusion by making sure I understand.  Earlier
> you said two plus an observer above but the example is about one
> observer and three other repositories, and the "merge" operation
> happens inside the observer's one.

There need to be at least 2 + 1.  There is no difference between
--ff=common and --ff=path when there are 2+1.  I used 3+1 in the
examples.

> That is unfortunately hard to arrange in git workflow if you do
> not use topic branches and/or if you rebase often (but would be
> more natural match to darcs's world view).  Even if you have a
> set of changes in the same spirit (i.e. "the same patch text"),
> the committer and the author information would make the actual
> commit objects different, so you would need to identify
> different commits that introduce the same change for this to be
> really useful.

And I  have no intention of doing that.  This patch will keep it
simple.  I imagine that these features will not be used by most users
and we should probably not document them in the tutorials.

> > The observer is interested in changes up to the point where someone is
> > known to disagree.  He can merge as follows:
> >
> >   git merge --ff=fork X Y Z
>
> If --ff=common fast-forwards to the commit all of X, Y, and Z
> have in common, that means commits on X, Y or Z that are beyond
> that point are the ones these three do not agree with.  How's
> that different from --ff=fork?

Lets say X is on the path before the fork point before Y and Z.  X is
then the common ancestor, otherwise there will not be any difference.

> >  The observer is interested in any give path up to one of the true
> > parents.  He can merge as follows:
> >
> >   git merge --ff=path X Y Z
> >
> > This will give priority to X then Y.
>
> "Any given path up to one of the true parents?"  Path from
> where?  How is "true parent" (as opposed to untrue ones?)
> defined?

The path from HEAD.

Consider a number of distinct parents, then we can define it as
follows.  An untrue parent is a parent that can be fast forwarded to
at least one other parent.  A true (or real) parent is a parent that
can not be fast forwarded to any other parent.

> > This + only are all the interesting cases for fast forward.  Some work
> > flows between more than two repositories in the general case would
> > require additional features for rebase:  Rebase on any patch, the fork
> > point, or common ancestor of the remote branches.  This is something I
> > would like to discuss at some later time.
> >
> >> > --ff=never will turn this off together with fast forward.  Maybe we
> >> > should have --ff=traditional that is the old behavior.
> >>
> >> Sure, and I mildly suspect that it should be the default.
> >
> > I would argue that it should not be the default, simply because we
> > already use the real parents when only two branches are involved, This
> > is most convenient for most users.
>
> Sorry, I referred --ff=traditional by "it".  Are we talking
> about the same thing?

What I mean is that the commit should only record the true parents.
That may already be the case by use of git show-branch --independent.
I am not sure what that option does.  However, the merge strategy
itself is picked based on the parents specified.  That part need to
change.  It could be that the patch could use the above option to find
the true parents.  Someone need to explain to me exactly what that
option does.

I am not exactly sure how a work flow between commiters would be.
With one coordinator it would be as follows.  The coordinator would
merge using any of the --ff options.  He would use --ff=same,
--ff=only, or --ff=common if everyone needs to agree.  He would use
--ff=fork when less care needs to be taken and --ff=path when he
essentially don't  care.  Everyone else needs to rebase on his work or
something else based on his work.  --ff=same is not included in the
patch.  It requires everyone except for HEAD to point to the same
commit.

I  am really busy for about three weeks and will not be able to do
much before beginning of March.

-- 
Sverre Hvammen Johansen
