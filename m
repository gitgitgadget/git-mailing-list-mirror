From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH 1/2] Update the bash prompt from 'applied' instead of the obsolete 'current'
Date: Tue, 22 May 2007 15:29:27 +0200
Message-ID: <20070522132927.GA12626@diana.vm.bytemark.co.uk>
References: <20070520204627.GR19253@nan92-1-81-57-214-146.fbx.proxad.net> <20070520211103.17468.21373.stgit@lathund.dewire.com> <20070521074838.GA32510@diana.vm.bytemark.co.uk> <b0943d9e0705210231j75ef2e57o922f7899f4b5814b@mail.gmail.com> <20070521101540.GB32510@diana.vm.bytemark.co.uk> <20070521113915.GA3090@diana.vm.bytemark.co.uk> <b0943d9e0705210817n35e50a6bgb519b693984b3a4b@mail.gmail.com> <20070521153952.GB6474@diana.vm.bytemark.co.uk> <b0943d9e0705220511u2b3ed46fg220af2cce26fef96@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, ydirson@altern.org,
	git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 22 14:35:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqTaJ-0005vI-Cm
	for gcvg-git@gmane.org; Tue, 22 May 2007 14:35:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756034AbXEVMfY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 22 May 2007 08:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755149AbXEVMfY
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 08:35:24 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4308 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756034AbXEVMfX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 08:35:23 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HqUQZ-0003eZ-00; Tue, 22 May 2007 14:29:27 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0705220511u2b3ed46fg220af2cce26fef96@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48101>

On 2007-05-22 13:11:13 +0100, Catalin Marinas wrote:

> On 21/05/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> > My suggestion was to have a small stand-alone C program that could
> > do some operations that need to be really fast, such as
> > top/applied/unapplied. It need not have a nice user interface
> > since it's only going to be called by scripts (bash-completion and
> > the like), and it should only handle those operations that _must-
> > avoid the Python startup penalty. And for sanity reasons, it
> > should share code with stgit.
>
> There is one more case to consider - people using NFS-mounted
> directories. The applied/unapplied commands would be even slower and
> the language overhead be negligible.
>
> Another workaround would be to always generate the applied/unapplied
> files when the stack structure changes.

Yes, we could do that. These files would only be accurate when the
stack was last modified with StGIT and not plain git, but that might
be acceptable.

Hmm. Since the only way plain git modifies the stack is by changing
HEAD (we assume the user doesn't manually mess with the patch refs),
we might also write down the value of HEAD for which the
applied/unapplied files are valid, so that the caller could call "stg
applied" if the applied file was out of date. But that's quite a
hassle to have to reimplement every time.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
