From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: jgit and ignore
Date: Sun, 1 Mar 2009 09:16:48 -0800
Message-ID: <20090301171648.GB14365@spearce.org>
References: <9e4733910902280831j70448ce9h7239f14e13b92b76@mail.gmail.com> <20090228172622.GC26689@spearce.org> <49AA5F64.6070207@pelagic.nl> <9e4733910903010454u662eb5afob45f608321660500@mail.gmail.com> <49AA884D.1050806@pelagic.nl> <49AA8ECD.4090302@gmail.com> <49AA91F0.7050008@pelagic.nl> <49AAA2B3.40808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>,
	Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Tor Arne =?iso-8859-1?Q?Vestb=F8?= <torarnv@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 01 18:20:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdpKs-0001rG-93
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 18:20:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753605AbZCARQu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Mar 2009 12:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753581AbZCARQu
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 12:16:50 -0500
Received: from george.spearce.org ([209.20.77.23]:44465 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752932AbZCARQu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2009 12:16:50 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 8BFD238210; Sun,  1 Mar 2009 17:16:48 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <49AAA2B3.40808@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111857>

Tor Arne Vestb=F8 <torarnv@gmail.com> wrote:
>=20
> But, with that said, I think of EGit as a standalone Eclipse-plugin
> implementation of the git porcelain -- not just a wrapper around the
> command line porcelain.

Yes, exactly.  JGit is about keeping on-disk and on-network binary
compatability with git-core.  But we don't necessarily need to keep
UI or behavior always the same within the porcelain that uses that
library, aka EGit.
=20
> To me that means that EGit should focus just as much on integrating w=
ith
> Eclipse properly as it does on keeping command line porcelain
> interoperability.

Yup, I agree completely.  I think Robin would too.
=20
> The core.excludesfile is one such case, and I think my proposal is a
> good compromise.

IMHO, we should honor ignores in EGit as:

  per-directory .gitignore
  per-repostiory GIT_DIR/info/exclude

  per-repository core.excludesfile (yes, really, it can be per
  repository, which overrides ~/.gitconfig setting of same)

  Eclipse global team ignore patterns

Skipping the core.excludesfile in favor of only the Eclipse global
team ignores feels wrong to me, as we may be missing something
the user has configured.  FWIW, I think core.excludesfile is a
lot less frequently used then .gitignore and GIT_DIR/info/exclude.
If there is a core.excludesfile, the user is a pretty advanced user
and they really want that behavior to be honored by Git poreclain.
EGit should honor it.

But likewise with the global team ignores.  I think most people set
up ignores in their VCS, so they are distributed to everyone on the
project automatically.  But if you do twiddle your own workspace
settings, we should honor them.

--=20
Shawn.
