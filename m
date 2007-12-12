From: Robert Schiele <rschiele@gmail.com>
Subject: exit with error for "git remote update"
Date: Wed, 12 Dec 2007 07:17:22 +0100
Message-ID: <20071212061722.GI4167@schiele.dyndns.org>
Reply-To: Robert Schiele <rschiele@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yr/DzoowOgTDcSCF"
Cc: git@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Wed Dec 12 07:17:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2Kum-0002Nq-1b
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 07:17:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753196AbXLLGR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 01:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbXLLGR1
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 01:17:27 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:15408 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773AbXLLGR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 01:17:27 -0500
Received: by nf-out-0910.google.com with SMTP id g13so99064nfb.21
        for <git@vger.kernel.org>; Tue, 11 Dec 2007 22:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent:from:reply-to;
        bh=GzRwz4MT4xAybRSUSRNhk3nCZIuKeyE26iTP33V/1WA=;
        b=ZzRw0Bq4jF1i+qL7yRUY8pgLw9nVM1YvXHVriRETkxlR7iIzBOP1m0klvd2Yr3WewiAeQtnRwcH+C+TP9lCDTnIOpHKtsbr5138Sv2f9o6YngUipE2zd++3llKs3DDrgy7zwztBz1UmgI23WLFzGIR1qCgNpoxXSwdRJHhNfLOI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent:from:reply-to;
        b=prbyvJGUZI55z93SWy/w7a3eodbOOMuw7rcfcbwrEJ7nxumB4GRB9HNLl2XE3RVKFxPqfCnB+8k9bomUK1GuFyb4y/zaoIRR7QjR1Wlobmybv+ILoCKr+wGuj7RC4E/51aO3Z6Uu7Hz6k8yPBm4zVyCV1lAgLxY0z5DrUc6z5NI=
Received: by 10.86.96.18 with SMTP id t18mr312438fgb.13.1197440245507;
        Tue, 11 Dec 2007 22:17:25 -0800 (PST)
Received: from sigkill.schiele.dyndns.org ( [91.18.78.15])
        by mx.google.com with ESMTPS id 4sm3747752fge.2007.12.11.22.17.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 11 Dec 2007 22:17:23 -0800 (PST)
Received: by sigkill.schiele.dyndns.org (Postfix, from userid 1000)
	id C17E937696; Wed, 12 Dec 2007 07:17:22 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67999>


--yr/DzoowOgTDcSCF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

When I call "git remote update" without an additional parameter it always
returns with an error, even when all fetch commands processed without a
problem.

This is because of the exit(1) in the following code:

elsif ($ARGV[0] eq 'update') {
        if (@ARGV <=3D 1) {
                update_remote("default");
                exit(1);
        }
        for ($i =3D 1; $i < @ARGV; $i++) {
                update_remote($ARGV[$i]);
        }
}

Shouldn't this exit(1) be an exit(0) instead or just rewrite this part of t=
he
code as

elsif ($ARGV[0] eq 'update') {
        if (@ARGV <=3D 1) {
                update_remote("default");
        } else {
                for ($i =3D 1; $i < @ARGV; $i++) {
                        update_remote($ARGV[$i]);
                }
        }
}

Robert

--=20
Robert Schiele
Dipl.-Wirtsch.informatiker	mailto:rschiele@gmail.com

"Quidquid latine dictum sit, altum sonatur."

--yr/DzoowOgTDcSCF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)

iD8DBQFHX3zyxcDFxyGNGNcRApwTAJ4/QuaZL1m/Dp9J8x/nbcCHH2xsWQCcDTrJ
yU/2RgeNmVy1cFR1l4mAWqQ=
=uI25
-----END PGP SIGNATURE-----

--yr/DzoowOgTDcSCF--
