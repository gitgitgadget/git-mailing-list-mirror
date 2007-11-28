From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: stgit: lost all my patches again
Date: Wed, 28 Nov 2007 10:06:57 -0500
Message-ID: <9e4733910711280706j45fe9c17t928396eb8e1de8bf@mail.gmail.com>
References: <9e4733910711271417l32ed9a77p9915aa34a780665b@mail.gmail.com>
	 <9e4733910711271512g790364e0ka4839b2be9fd4935@mail.gmail.com>
	 <20071128093403.GB12977@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 16:07:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxOVV-00084G-1C
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 16:07:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755961AbXK1PG7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Nov 2007 10:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754892AbXK1PG7
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 10:06:59 -0500
Received: from wa-out-1112.google.com ([209.85.146.182]:21489 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754522AbXK1PG5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Nov 2007 10:06:57 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1762696wah
        for <git@vger.kernel.org>; Wed, 28 Nov 2007 07:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=YR/IpzpohvVgDj27bbPbWkgD84U5utTSmjR7LSLsazs=;
        b=gLJf8DWdwOsKj96lA/sT/g+wZ//ZTyO4QaITCQFmHcZQiqbw+6/+irOn6nbvV28w3Blqso/6edU0mZyRmkmDinsMiOIj8jlVvAtqRlEQPdJIli3TeyNU0ZuryTlMuCzpMA4TlmB2+PxGUcpSCdVgEsRgc1OcDVtBQvm4izcGBQs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=shiEwZH/L/c6cwFGN8VEochhb75z2oO6emTGa5fucTzH22tiOzTzUmkctzNi3IKc9I94ei7KiBgoyjx3FaSnt08TI1GFg20w//8MA0B+v8c0mo2xuT8VEoBxKRzjrVCR+AAdGeATFlqS3oJIAFdhGEkw7JVLHgROhViJ1440eMo=
Received: by 10.114.103.1 with SMTP id a1mr162321wac.1196262417510;
        Wed, 28 Nov 2007 07:06:57 -0800 (PST)
Received: by 10.114.160.3 with HTTP; Wed, 28 Nov 2007 07:06:57 -0800 (PST)
In-Reply-To: <20071128093403.GB12977@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66353>

On 11/28/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2007-11-27 18:12:49 -0500, Jon Smirl wrote:
>
> > As Jakub pointed out to me "git reset --hard $(cat
> > .git/patches/<branch>/orig-base)" would have recovered from the
> > rebase command. But I had already typed 'stg repair' which
> > compounded the mess.
>
> Unless it has a bug, the only thing "stg repair" will do is
>
>   * create some new applied patches out of commits reachable from HEA=
D
>
>   * mark some applied patches as unapplied
>
>   * mark some unapplied patches as applied

I did 'stg repair' after doing 'git rebase'. After the repair half of
my patches were marked as being applied and half not. The ones that
were applied were all empty. They were probably empty because my
original patches were still commited by stg in front of the rebase. I
couldn't figure out how to recover so I extracted the pre-rebase
commits manual, built a series file and started again on a new branch.

When I applied the patches to a clean branch none of them had conflicts=
=2E

> in order to make sure that the applied patches are precisely those
> that are reachable from HEAD, and that the sequence of applied patche=
s
> doesn't have "holes" in it (that is, commits that aren't patches).
>
> In particular, it should not ever modify your existing patches, and i=
t
> will never move the branch head. Just resetting the branch head to
> wherever you want it to be (and then running repair again) should fix
> literally all problems.

I did this:
all pataches were applied
git rebase
stg repair -- partial repair, some patches empty, half are pushed
moved HEAD back in front of rebase
stg repair - it show all my patches as popped, but when I started
doing command it complain that some commits that stg needed were not
there.

The complaint was caused by the first repair. The first repair altered
some of the stg state to point at commits past the rebase. That why I
wanted check point. At this point I could move the HEAD back without
also reverting the stgit state in .git/*


>
> > This is way too easy to do. One simple mistype of 'git' for 'stg'
> > and you're in a mess.
>
> You're right, this is not user friendly. A pre-rebase hook sounds lik=
e
> a reasonable idea.
>
> It would also be convenient with a post-commit hook that turns new
> commits into patches automatically. And gives "git commit --amend" th=
e
> semantics of "stg refresh".
>
> --
> Karl Hasselstr=F6m, kha@treskal.com
>       www.treskal.com/kalle
>


--=20
Jon Smirl
jonsmirl@gmail.com
