From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: stgit truncates binary files to zero length when applying patches
Date: Wed, 16 Nov 2005 14:03:33 +0100
Message-ID: <20051116130332.GA6744@diana.vm.bytemark.co.uk>
References: <20051115144223.GA18111@diana.vm.bytemark.co.uk> <b0943d9e0511160311k725526d8v@mail.gmail.com> <20051116115449.GA5933@diana.vm.bytemark.co.uk> <b0943d9e0511160431r6c852e5fn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 16 14:05:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcMwt-0007Wx-Fh
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 14:03:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030309AbVKPNDg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 16 Nov 2005 08:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030312AbVKPNDg
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 08:03:36 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:37892 "EHLO
	diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S1030309AbVKPNDf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2005 08:03:35 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1EcMwn-0001p0-00; Wed, 16 Nov 2005 13:03:33 +0000
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <b0943d9e0511160431r6c852e5fn@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12024>

On 2005-11-16 12:31:27 +0000, Catalin Marinas wrote:

> On 16/11/05, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> > On 2005-11-16 11:11:56 +0000, Catalin Marinas wrote:
> >
> > > Unfortunately, git-apply doesn't fail for patches including
> > > binary files and simply creates an empty file. I think git-apply
> > > should be changed to fail to apply this kind of patches.
> >
> > Yes, at least if stgit is going to continue to use it like this.
> > Refusing to handle binary files is somewhat disappointing, but
> > still OK; agreeing to handle them and then silently wiping them is
> > a bit less OK.
>
> A workaround for this would be to add a config option for StGIT to
> always use the three-way merge for pushing patches. The problem with
> this is speed since git-diff-tree | git-apply is much faster (and
> pretty safe since fuzzy patching is not allowed) and most of the
> patches would apply cleanly with only this.

The proper fix has to be to convince git-apply to either handle
patches with binary files, or to make it fail; in both cases, stgit
will be fine. If the former is somehow intractable or undesirable, and
the latter would break existing callers (and/or inconvenience users),
perhaps it could fail on binary files only when a --text-only flag was
given.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
