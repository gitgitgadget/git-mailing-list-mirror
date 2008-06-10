From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: stg pull/rebase
Date: Tue, 10 Jun 2008 12:42:44 +0200
Message-ID: <20080610104244.GC30119@diana.vm.bytemark.co.uk>
References: <20080607172202.GA5179@diana.vm.bytemark.co.uk> <b0943d9e0806100302j159f5b7fq6d970316b902b39b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 12:43:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K61KM-0001Ra-Dh
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 12:43:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904AbYFJKmw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jun 2008 06:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbYFJKmw
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 06:42:52 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1269 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884AbYFJKmv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 06:42:51 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1K61JN-000825-00; Tue, 10 Jun 2008 11:42:45 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0806100302j159f5b7fq6d970316b902b39b@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84494>

On 2008-06-10 11:02:18 +0100, Catalin Marinas wrote:

> However, I found some these policies useful. For example, I just do
> a "stg pull" from a Subversion repository with the config below:
>
> [stgit]
>         pull-policy =3D fetch-rebase
>         fetchcmd =3D git svn fetch
>         rebasecmd =3D git svn rebase

Looks useful.

But what exactly is "rebasecmd" useful for, when you already have
"fetchcmd" and a built-in rebase?

> 2008/6/7 Karl Hasselstr=F6m <kha@treskal.com>:
>
> > What I think I'd like is the following:
> >
> >  * Just one command, stg pull. stg rebase is removed.
>
> I still find "rebase" useful and use it in some situations when I
> don't need a pull. As Jakub mentioned, maybe we could keep the
> "rebase" functionality outside of the "pull" command (make it part
> of Stack with a corresponding Branch.rebase?) and have "rebase" use
> it.

Yes. We could have "stg rebase" =3D=3D "stg pull --rebase --no-fetch".

> >      2. Depending on the configuration (overridable by the
> >      --fast-forward, --rebase, and --merge options), one of these
> >      three things happen:
>
> But "pull" always suggests fetching something. Adding "--rebase"
> would mean that it doesn't fetch. Shouldn't we leave this
> functionality to "rebase" only?

These two things are orthogonal:

  1. Whether and how to update the branch we're pulling from
     (fetching).

  2. How to do the actual pulling (rebase, fast-forward, or merge).

I envision (1) being controlled by the branch config (and overridable
with a --no-fetch option or something), and (2) being controlled by
another part of the branch config (and overridable with
--fast-forward, --merge, and --rebase).

> >         1. We pop all patches, fast-forward to the new base, and
> >            push them back. If it's not a fast-forward, we error
> >            out.
> >
> >         2. We pop all patches, reset to the new base, and push
> >            them back.
> >
> >         3. We pop all patches, merge with the other branch, then
> >            push the patches back.
>
> These are OK, with the comment on have rebase functionality in
> "rebase" only.

Why? I don't see the difference between rebase and the other two that
would motivate such a separation.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
