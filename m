From: Greg Troxel <gdt@ir.bbn.com>
Subject: Re: [remote rejected] master -> master (n/a (unpacker error))
Date: Thu, 13 May 2010 08:05:00 -0400
Message-ID: <rmiy6fo3t3n.fsf@fnord.ir.bbn.com>
References: <AANLkTinV2U6Lbbl0N7jVAESEi0mZQ_D3slMEYa68vRT4@mail.gmail.com>
	<20100513005218.GA20655@progeny.tock>
	<AANLkTilz_gbHl_RLyOuvEIdjPoUDIfZTUCpnswdHTiej@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: "git\@vger.kernel.org List" <git@vger.kernel.org>
To: Robert Buck <buck.robert.j@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 13 14:05:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCXAB-00073w-DV
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 14:05:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758836Ab0EMMFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 08:05:04 -0400
Received: from fnord.ir.bbn.com ([192.1.100.210]:61290 "EHLO fnord.ir.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754911Ab0EMMFC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 May 2010 08:05:02 -0400
Received: by fnord.ir.bbn.com (Postfix, from userid 10853)
	id 504735747; Thu, 13 May 2010 08:05:00 -0400 (EDT)
X-Hashcash: 1:20:100513:git@vger.kernel.org::nDXSVRwjTxjXBgtP:00000000000000000000000000000000000000000018Wc
X-Hashcash: 1:20:100513:buck.robert.j@gmail.com::I8BBYkcr+h36O8ja:000000000000000000000000000000000000001zGX
X-Hashcash: 1:20:100513:judge.packham@gmail.com::nDXSVRwjTxjXBgtP:000000000000000000000000000000000000009uTp
X-Hashcash: 1:20:100513:jrnieder@gmail.com::I8BBYkcr+h36O8ja:0000000000000000000000000000000000000000000Cm9s
In-Reply-To: <AANLkTilz_gbHl_RLyOuvEIdjPoUDIfZTUCpnswdHTiej@mail.gmail.com>
	(Robert Buck's message of "Thu, 13 May 2010 05:30:43 -0400")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.1 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146995>

--=-=-=


Robert Buck <buck.robert.j@gmail.com> writes:

> Yes, the repository is shared by several people, and in geographically
> different locations, ssh-ing to the same host, under different groups.
> So your recommendation would be to use --shared. But this won't work
> so well out in the wild will it? Meaning, what if people's accounts
> are NOT under the same group that is?

Git simply rides on filesystem permissions.  So you choose a group to
control access to the repository, chgrp -R the repo to that group, and
config shared=0660.  Then you put people in the group to give them
access; it doesn't have to be their primary gid.  I don't follow your
objection; you seem to want to use groups to control access yet not set
up a group for the repo.

On some systems (e.g. BSD), directories automatically inherit the parent
dir's group.  On others, you need setgid bit.  I have the impression
that git will deal with this all correctly if you simply have
"sharedrepository = 0660" under [core] in config; I would expect it to
chgrp new files/dirs as needed to match the repo dir's group.

I don't see how chroot would change the issues above.


--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (NetBSD)

iEYEARECAAYFAkvr6uwACgkQ+vesoDJhHiVsawCbBTkzGRdl/hWwIXokDkjqy9Hw
vJIAoJEUMgTbC6wetb7BWaJ9opwdjMt7
=AOdy
-----END PGP SIGNATURE-----
--=-=-=--
