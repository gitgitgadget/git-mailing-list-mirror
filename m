From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 09/13] Clear up the semantics of Series.new_patch
Date: Mon, 8 Oct 2007 15:25:24 +0200
Message-ID: <20071008132524.GA11253@diana.vm.bytemark.co.uk>
References: <20070914222819.7001.55921.stgit@morpheus.local> <20070914223154.7001.12254.stgit@morpheus.local> <b0943d9e0710080616r36142946m3e24d2f6893287c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 15:25:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IescE-0002M4-T1
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 15:25:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbXJHNZi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Oct 2007 09:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbXJHNZi
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 09:25:38 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2554 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbXJHNZh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2007 09:25:37 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Iesbs-0002xt-00; Mon, 08 Oct 2007 14:25:24 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0710080616r36142946m3e24d2f6893287c9@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60322>

On 2007-10-08 14:16:10 +0100, Catalin Marinas wrote:

> On 14/09/2007, David K=E5gedal <davidk@lysator.liu.se> wrote:
>
> > +        assert commit or (top and bottom)
> > +        assert not before_existing or (top and bottom)
> > +        assert not (commit and before_existing)
> > +        assert (top and bottom) or (not top and not bottom)
> > +        assert not top or (bottom =3D=3D git.get_commit(top).get_p=
arent())
>
> The last assertion here prevents the use of 'stg pick --reverse'.
> This command creates an unapplied patch with top and bottom reversed
> and pushes it to force a three-way merge.
>
> It seems to work OK if I comment it out but I wonder whether it will
> break in the future with the planned removal of the top and bottom
> files.

I think the assert represents a real constraint, namely that there has
to be a 1:1 correspondance between patches and commits.

Couldn't "stg pick --reverse" create a new commit and use that? That
is, given that we want to revert commit C, create a new commit C* with

  tree(C*)   :=3D tree(parent(C))
  parent(C*) :=3D C

Creating just one new commit object seems like a cheap thing to do.

And shouldn't there be a test for this? :-)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
