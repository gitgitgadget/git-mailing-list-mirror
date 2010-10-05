From: Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH] tag,verify-tag: do not trip over rfc1991 signatures
Date: Tue, 5 Oct 2010 16:42:02 -0400
Message-ID: <20101005204201.GF7629@inocybe.localdomain>
References: <4CAB46C0.9000807@drmicha.warpmail.net>
 <5cea498f34522d603a1561bfe69e2f92caa39ced.1286293083.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="24zk1gE8NUlDmwG9"
Cc: git@vger.kernel.org, Stephan Hugel <urschrei@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Oct 05 22:42:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3EL6-0006k6-MF
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 22:42:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752070Ab0JEUmN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 16:42:13 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35917 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754639Ab0JEUmM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 16:42:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A2A3DC62E;
	Tue,  5 Oct 2010 16:42:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
	:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=sasl; bh=xOQHED2ycuzjarl+BdV+YsSh+8U=; b=npgySNu
	w6FRqyVOqxm4zSAtUuUdjlqcvyonRcyzChA8VKqiJNS9hs3oifuojtVd8SD0tK92
	yI+YJDp+batAl/cHf9Qb/Fu3QeNuA2r08qBtDYzEH7Khmjuw4s/1hr1r+9GA4kqD
	bkiXSxp+swR2AKMiyNU6EzTy2BPVAMdTQM7w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
	:subject:message-id:references:mime-version:content-type
	:in-reply-to; q=dns; s=sasl; b=RCAdvr2U5dHtmu0RsunP1ucT7nq/+Je4q
	yJXNsW/yBqAF5eWxp1OEyq5J57oJOC5SAnQt+TJjNIGhsTXqTGg7pN3W4SJ/mYq8
	SHxNvQiWTx6G8gNfsr7ebxm+A/0D3Wc540ccdIKqXAdFHxb3k7pp4BxUKulcWaIa
	8VlB8l7jg0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 452FEDC62D;
	Tue,  5 Oct 2010 16:42:07 -0400 (EDT)
Received: from inocybe.localdomain (unknown [98.117.251.177]) (using TLSv1
 with cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9D2D3DC629; Tue,  5 Oct
 2010 16:42:03 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <5cea498f34522d603a1561bfe69e2f92caa39ced.1286293083.git.git@drmicha.warpmail.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Pobox-Relay-ID: 04D24FDE-D0C1-11DF-9133-030CEE7EF46B-09356542!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158237>


--24zk1gE8NUlDmwG9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Michael J Gruber wrote:
> Currently, git expects "-----BEGIN PGP SIGNATURE-----" at the beginning o=
f a
> signature. But gpg uses "MESSAGE" instead of "SIGNATURE" when used with
> the "rfc1991" option. This leads to git's faling to verify it's own
> signed tags.
>
> Be more lenient and take "-----BEGIN PGP " as the indicator.

Another way to go might be to add --gnupg (or --openpgp) to the gpg
options used for tagging.  That overrides an option like rfc1991 in
the gnupg config file.

Whether that's preferable to accepting these older-style messages is
debatable.  Using rfc1991 implies pgp-2.x compatibility, which means
using md5 as the algorithm.  It could be seen as a weakness to accept
such signatures.

(Oh, and you probably saw this already, but s/faling/failing. ;)

--=20
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
The best cure for insomnia is to get a lot of sleep.
    -- W.C. Fields


--24zk1gE8NUlDmwG9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQFDBAEBCAAtBQJMq42VJhhodHRwOi8vd3d3LnBvYm94LmNvbS9+dG16L3BncC90
bXouYXNjAAoJEEMlk4u+rwzjqrwH/AsfSBigciC+SHJ/YDaH0za+IiUk4+iB8VG4
qNv4WKoHuNoKV99p35duNiSS8Qmlb2msBPt0hUVNNV+hRYTMZKaNfPmx1I0U6iC/
fmh2EjkKN4LlpJ3qxSu5KaNElizVBiGK6m1yl0KjPOApABsRnpi9S/qpOXmBv8Ui
64LHoJvET6ih8mj5jgDmhn+WoOc1Lmkuh9ud6ayw2FzWZq2j4aqjd5ERUV+IbNZR
/zOQtzFxcWXi9Sn2zD7cHFVaa2uaSu4Tf9VbDUZWXYV21yoEHIQL7URAYgE0UWo+
uEv5+PNEQ131M912UnG1eHg5puNlxlyGzKJm3AcRAtSEZUuzVww=
=IMpP
-----END PGP SIGNATURE-----

--24zk1gE8NUlDmwG9--
