From: Greg Troxel <gdt@ir.bbn.com>
Subject: Re: rfc - Changing the way gitk and git-gui are managed
Date: Fri, 23 Jul 2010 15:18:02 -0400
Message-ID: <rmi1vauyplh.fsf@fnord.ir.bbn.com>
References: <7vocdygbw0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 23 21:18:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcNl8-0005sN-0E
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 21:18:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757148Ab0GWTSH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 15:18:07 -0400
Received: from fnord.ir.bbn.com ([192.1.100.210]:59894 "EHLO fnord.ir.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752279Ab0GWTSF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 15:18:05 -0400
Received: by fnord.ir.bbn.com (Postfix, from userid 10853)
	id 9A744528E; Fri, 23 Jul 2010 15:18:02 -0400 (EDT)
X-Hashcash: 1:20:100723:git@vger.kernel.org::sls14JHXYe6LBqyz:0000000000000000000000000000000000000000001F24
X-Hashcash: 1:20:100723:gitster@pobox.com::qqmGRl70NmJjSwTQ:000000000000000000000000000000000000000000004w4K
In-Reply-To: <7vocdygbw0.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 22 Jul 2010 19:39:11 -0700")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.2 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151568>

--=-=-=


  The plan (I am not decided to buy into it yet, hence I am sending this
  rfc) is to:

      - remove gitk-git and git-gui directories;
      - add modules/gitk and modules/git-gui submodules;
      - teach the top-level Makefile about the new location of these two
        packages.

  Switching from 1.7.2 to this tree will of course give you a tree without
  gitk and git-gui (nothing a simple "git submodule init/update" cannot
  fix), and switching back from there to 1.7.2 codebase needs manual removal
  of these two directories that will become leftover directories if you want
  to keep the superproject directory pristine clean, but other than that, I
  do not see major downsides.

  I am wondering what people think.  Especially distro people who download
  and package git may be heavily affected.  I haven't adjusted the RPM spec
  file or "make dist" target, so I cannot assess the damage to these people
  myself yet.

(I am perhaps going to be involved in maintaining the git package in pkgsrc.)

In general, the effort to update the package control files is basically
5 minutes per release (to change version, test, and summarize release
notes) plus coping with structural changes in how the package builds and
what it installs.

Perhaps implicit in your mail above:

  create new distribution packages for gitk and git-gui.  These would
  have their own autoconf setup, and be independent packages, depending
  on the base git package.

Assuming that:

  From a packager viewpoint this is good.  That would make it easier to
  have a base git package that doesn't depend on much, and then a gitk
  package that just has gitk, depending on what it needs to.

  (A problem with git now is that it depends on tcl.  I gather Linux
  packaging systems tend to build everything with the full set of
  possible dependencies and then split it into separate binary packages.
  pkgsrc is more focused on source builds and thus we really don't want
  to have tcl installed if the user doesn't want the gui, and a side
  effect of this focus is the lack of support for split packages from
  one build.)

If you don't mean separate distribution tarballs, then could you explain
how the released tarballs would change structurally?




--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (NetBSD)

iEYEARECAAYFAkxJ6uoACgkQ+vesoDJhHiXiRgCgsmCL8yT/xgpiE5ZZqsI/UnCh
VXwAoLevetLmd+1iJwoPkBEa6Gd6ZHQh
=2VzR
-----END PGP SIGNATURE-----
--=-=-=--
