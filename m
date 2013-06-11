From: Greg Troxel <gdt@ir.bbn.com>
Subject: Re: Tracking vendor release with Git
Date: Tue, 11 Jun 2013 13:29:04 -0400
Message-ID: <rmi38so1rq7.fsf@fnord.ir.bbn.com>
References: <1370970410-7935-1-git-send-email-ydroneaud@opteya.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: git@vger.kernel.org
To: Yann Droneaud <ydroneaud@opteya.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 19:29:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmSNc-0002gg-5g
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 19:29:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753310Ab3FKR3H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 13:29:07 -0400
Received: from fnord.ir.bbn.com ([192.1.100.210]:53912 "EHLO fnord.ir.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752182Ab3FKR3G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 13:29:06 -0400
Received: by fnord.ir.bbn.com (Postfix, from userid 10853)
	id B9971AFCA; Tue, 11 Jun 2013 13:29:04 -0400 (EDT)
OpenPGP: id=32611E25
X-Hashcash: 1:20:130611:git@vger.kernel.org::rwCiM5EBMMUNu/ZQ:00000000000000000000000000000000000000000005rO
X-Hashcash: 1:20:130611:ydroneaud@opteya.com::PBMWfyZwrdmeiSgj:0000000000000000000000000000000000000000043FY
In-Reply-To: <1370970410-7935-1-git-send-email-ydroneaud@opteya.com> (Yann
	Droneaud's message of "Tue, 11 Jun 2013 19:06:50 +0200")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/23.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227473>

--=-=-=
Content-Type: text/plain


  I'm trying to setup a workflow to track vendor releases (upstream).
  Each new release are provided as an archive of source code, data,
  documentation, etc.

I've been doing more or less this.  A few comments:

  I suggest that you not view CRLF->LF as a "patch".  I would do EOL
  hygiene as a preprocessing script, with a checked-in script, after
  unpacking the tarball or whatever, and before 'import'.  Otherwise
  it's just going to be too messy.

  I use "vendor.foo" as the branch name.

  If your repo is only for this program, you can ignore this, but
  otherwise you way want to use subtree merge so that vendor.foo: maps
  to master:foo (putting foo in a subtree in master).  This lets you
  have multiple upstreams in one repo, which is useful for system
  building more than maintaining.

  I would avoid rebase.  You are essentially merging someone else's
  branch (that they aren't putting in git, but you are with the
  vendor.foo) into your master.   With regular merge, you can still
  diff, but the natural history will be right.  With rebase each "local
  version" as you call it will have different commits that will not have
  clear ancestry.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iEYEARECAAYFAlG3XmAACgkQ+vesoDJhHiUi2ACfUVqDygtlIFY0XkPz7HVP+MUI
zKUAn1MECztSDWOD3/cQkzBndXYFzmDz
=mtNq
-----END PGP SIGNATURE-----
--=-=-=--
