From: Daniel Hahler <genml+git-2014@thequod.de>
Subject: Bug: relative core.worktree is resolved from symlink and not its
 target
Date: Tue, 04 Feb 2014 11:20:39 +0100
Message-ID: <52F0BEF7.5020600@thequod.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="XWOQsdQH578dIbRCIJhwFbQkX3k33HN3b"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 04 11:29:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAdFu-0006iP-Gu
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 11:29:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbaBDK3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 05:29:23 -0500
Received: from hahler.de ([188.40.33.212]:54034 "EHLO elfe.thequod.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753167AbaBDK3U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 05:29:20 -0500
X-Greylist: delayed 516 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Feb 2014 05:29:20 EST
Received: from localhost (amavis [10.122.1.24])
	by elfe.thequod.de (Postfix) with ESMTP id DE1BB62116
	for <git@vger.kernel.org>; Tue,  4 Feb 2014 11:20:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=thequod.de; h=
	content-type:content-type:subject:subject:mime-version
	:user-agent:from:from:date:date:message-id:received:received; s=
	postfix2; t=1391509239; bh=hFf2tDZxxBBonTOmRH4UIpXktKilXH+cNwc+H
	ngVPoY=; b=Mf3mVvEj4AxifGbV6lAx8K6l7pFKBFRHEMqh9YS7PFOPBUw8APyEk
	cYxi5A1TwX7+mXwbDQmz8nrtsSpG4YFnbz/0LidD+kT9jKavmkMzMi19hAUblyz3
	KPRC+nSu8ccqE3TCZbOflfdqluiPVCD/knlzIysgqpq6ODt6/OHjKA=
X-Virus-Scanned: Debian amavisd-new at amavis.thequod.de
Received: from elfe.thequod.de ([10.122.1.25])
	by localhost (amavis.thequod.de [10.122.1.24]) (amavisd-new, port 10026)
	with ESMTP id EY5LLnsvVq2J for <git@vger.kernel.org>;
	Tue,  4 Feb 2014 11:20:39 +0100 (CET)
Received: from lenny.thequod.de (24-134-92-193-dynip.superkabel.de [24.134.92.193])
	(Authenticated sender: daniel@hahler.de)
	by elfe.thequod.de (Postfix) with ESMTPSA
	for <git@vger.kernel.org>; Tue,  4 Feb 2014 11:20:39 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241519>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XWOQsdQH578dIbRCIJhwFbQkX3k33HN3b
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

when using a submodule "sm", there is a relative worktree in its config:

   .git/modules/sm/config:
   [core]
    worktree =3D ../../../smworktree

git-new-worktree (from contrib) symlinks this config the new worktree.

=46rom inside the new worktree, git reads the config, but resolves the
relative worktree setting based on the symlink's location.

A fix would be to resolve any relative worktree setting based on the
symlink target's location (the actual config file), and not from the
symlink.

This is with git version 1.8.5.3.

Please consider fixing this.

(I know about various workarounds, e.g. copying and adjusting "config"
or manually setting $GIT_WORK_TREE; more relevant discussion would be
at http://comments.gmane.org/gmane.comp.version-control.git/196019)


Thanks,
Daniel.

--=20
http://daniel.hahler.de/


--XWOQsdQH578dIbRCIJhwFbQkX3k33HN3b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iD8DBQFS8L73fAK/hT/mPgARAuSXAJsE0+ixTsGJvzL5lKppvZPxsfKsgACdG/U4
uZ5iaJTD7yYa+JuhWFv6czg=
=Vszf
-----END PGP SIGNATURE-----

--XWOQsdQH578dIbRCIJhwFbQkX3k33HN3b--
