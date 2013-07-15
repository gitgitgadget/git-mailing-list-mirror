From: Greg Troxel <gdt@ir.bbn.com>
Subject: repo consistency under crashes and power failures?
Date: Mon, 15 Jul 2013 13:48:23 -0400
Message-ID: <rmiy597iujc.fsf@fnord.ir.bbn.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 15 19:48:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uymsw-0000UH-O3
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 19:48:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752441Ab3GORs1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 13:48:27 -0400
Received: from fnord.ir.bbn.com ([192.1.100.210]:59640 "EHLO fnord.ir.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752176Ab3GORs0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 13:48:26 -0400
Received: by fnord.ir.bbn.com (Postfix, from userid 10853)
	id F0AB0B858; Mon, 15 Jul 2013 13:48:23 -0400 (EDT)
OpenPGP: id=32611E25
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/23.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230498>

--=-=-=
Content-Type: text/plain


Clearly there is the possibility of creating a corrupt repository when
receiving objects and updating refs, if a crash or power failure causes
data not to get written to disk but that data is pointed to.  Journaling
mitigates this, but I'd argue that programs should function safely with
only the guarantees from POSIX.

I am curious if anyone has actual experiences to share, either

  a report of corruption after a crash (where corruption means that
  either 1) git fsck reports worse than dangling objects or 2) some ref
  did not either point to the old place or the new place)

  experiments intended to provoke corruption, like dropping power during
  pushes, or forced panics in the kernel due to timers, etc.

Alternatively, is there somewhere a first-principles analysis vs POSIX
specs (such as fsyncing object files before updating refs to point to
them, which I realize has performance negatives)?

(I have not done experiments, but have observed no corruption.)

    Thanks,
    Greg

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iEYEARECAAYFAlHkNecACgkQ+vesoDJhHiXwKACfZkFRIWIpbPQ+AJvC3M93ig+l
Zs4AnR0G3Ay/UuyWc1EMAQCoEHFbMN/V
=fqeK
-----END PGP SIGNATURE-----
--=-=-=--
