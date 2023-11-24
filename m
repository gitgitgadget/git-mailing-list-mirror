Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Greylist: delayed 521 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 24 Nov 2023 01:48:25 PST
Received: from outbound.soverin.net (outbound.soverin.net [IPv6:2a10:de80:1:4091:b9e9:2212:0:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58E710E7
	for <git@vger.kernel.org>; Fri, 24 Nov 2023 01:48:25 -0800 (PST)
Received: from smtp.freedom.nl (c04cst-smtp-frd02.int.sover.in [10.10.4.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by outbound.soverin.net (Postfix) with ESMTPS id 4Sc91S0zbvz1Fq
	for <git@vger.kernel.org>; Fri, 24 Nov 2023 09:39:40 +0000 (UTC)
Received: from smtp.freedom.nl (smtp.freedom.nl [10.10.4.108]) by freedom.nl (Postfix) with ESMTPSA id 4Sc91R4cwnz2xCF
	for <git@vger.kernel.org>; Fri, 24 Nov 2023 09:39:39 +0000 (UTC)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freedom.nl;
	s=default; t=1700818779;
	h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:mime-version:mime-version:
	 content-type:content-type:content-transfer-encoding:in-reply-to:
	 references; bh=tPOIXTEJVuVCNcJ7ddV+C1RhlLEulSBvjGy5Hby/YiI=;
	b=EzDwBOdveKl7ax7jhP7jkcWSxhhj2lfshTupJnuyeZ82NElFIusGIVycQ0PooutJjMpIdr
	BN+8rKj4bqW913Cd+izjDiSAVSRPvbyv+cLIPfQXjEqqnryfQ+iPlMuJShR2t7htCctznv
	5dUj0HRJVzFyBzRPF7tekFBha9F5a7k=
ARC-Authentication-Results: i=1;
	smtp.freedom.nl;
	auth=pass smtp.mailfrom=linux@tux.freedom.nl
ARC-Seal: i=1; s=default; d=freedom.nl; t=1700818779; a=rsa-sha256;
	cv=none;
	b=OCZyxS+N9tKUPnoAzhGBOPvIBUyFeqiRc16FlYxjx5sGoDGd7yswwPbGOS5ujES285DF10
	yq5K8pHALFTcAk25I+F3k8BlE3iuW7gfSkDo8fkv2AAlPSHUvsmn/xqUUGcq9yA9RZwPCZ
	Uu7u7cHIffUwt+hFJrk2qXU+RwrMRCA=
Date: Fri, 24 Nov 2023 10:39:32 +0100
X-Soverin-Authenticated: true
From: "H.Merijn Brand" <linux@tux.freedom.nl>
To: git@vger.kernel.org
Subject: Fix git-send-email.perl w.r.t. recent Getopt::Long update
Message-ID: <20231124103932.31ca7688@pc09>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/a+K/exH2=9=/mC+QK5.iX6g";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/a+K/exH2=9=/mC+QK5.iX6g
Content-Type: multipart/mixed; boundary="MP_/BCzNSkghtbb35uQlCqX+osz"

--MP_/BCzNSkghtbb35uQlCqX+osz
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Patch attached

=46rom the Getopt::Long changes:
```
Changes in version 2.55
-----------------------
* Fix long standing bug that duplicate options were not detected when
  the options differ in case while ignore_case is in effect.
  This will now yield a warning and become a fatal error in a future
  release.
```

Current version is 2.57


```
git-2.43.0 =F0=9F=90=A7 perl -Iperl git-send-email.perl --help
Duplicate specification "cc-cover|cc-cover!" for option "cc-cover"
Duplicate specification "no-cc-cover" for option "no-cc-cover"
Duplicate specification "to-cover|to-cover!" for option "to-cover"
Duplicate specification "no-annotate" for option "no-annotate"
Duplicate specification "no-format-patch" for option "no-format-patch"
Duplicate specification "no-signed-off-cc|no-signed-off-by-cc" for option "=
no-signed-off-cc"
Duplicate specification "no-signed-off-cc|no-signed-off-by-cc" for option "=
no-signed-off-by-cc"
Duplicate specification "no-validate" for option "no-validate"
Duplicate specification "no-chain-reply-to" for option "no-chain-reply-to"
```

`"option!" =3D> \$value`

*automatically* supports both `--option` and `--no-option` and `--nooption`

See the docs for Getopt::Long:
```
 The argument specification can be

 !   The option does not take an argument and may be negated by
     prefixing it with "no" or "no-". E.g. "foo!" will allow "--foo" (a
     value of 1 will be assigned) as well as "--nofoo" and "--no-foo" (a
     value of 0 will be assigned). If the option has aliases, this
     applies to the aliases as well.

     Using negation on a single letter option when bundling is in effect
     is pointless and will result in a warning.
```


--=20
H.Merijn Brand  https://tux.nl   Perl Monger   http://amsterdam.pm.org/
using perl5.00307 .. 5.37        porting perl5 on HP-UX, AIX, and Linux
https://tux.nl/email.html http://qa.perl.org https://www.test-smoke.org
                          =20

--MP_/BCzNSkghtbb35uQlCqX+osz
Content-Type: text/x-patch
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename=0001-perl-Getopt-Long-now-issues-warnings-for-duplicate-o.patch

=46rom 206ace60f7045e309e506a1b9de775f4e9a43b46 Mon Sep 17 00:00:00 2001
From: "H.Merijn Brand - Tux" <linux@tux.freedom.nl>
Date: Fri, 24 Nov 2023 10:27:35 +0100
Subject: [PATCH] perl Getopt::Long now issues warnings for duplicate options

$ perl -Iperl git-send-email.perl.org --help
Duplicate specification "no-validate" for option "no-validate"
Duplicate specification "to-cover|to-cover!" for option "to-cover"
Duplicate specification "no-signed-off-cc|no-signed-off-by-cc" for option "=
no-signed-off-cc"
Duplicate specification "no-signed-off-cc|no-signed-off-by-cc" for option "=
no-signed-off-by-cc"
Duplicate specification "no-format-patch" for option "no-format-patch"
Duplicate specification "cc-cover|cc-cover!" for option "cc-cover"
Duplicate specification "no-annotate" for option "no-annotate"
Duplicate specification "no-chain-reply-to" for option "no-chain-reply-to"
Duplicate specification "no-cc-cover" for option "no-cc-cover"

"option!" =3D> \$value

*automatically* supports both --option and --no-option and --nooption

 The argument specification can be

 !   The option does not take an argument and may be negated by
     prefixing it with "no" or "no-". E.g. "foo!" will allow "--foo" (a
     value of 1 will be assigned) as well as "--nofoo" and "--no-foo" (a
     value of 0 will be assigned). If the option has aliases, this
     applies to the aliases as well.

     Using negation on a single letter option when bundling is in effect
     is pointless and will result in a warning.

Signed-off-by: H.Merijn Brand - Tux <linux@tux.freedom.nl>
---
 git-send-email.perl | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index d24e981d61..125f49cd08 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -491,7 +491,6 @@ sub config_regexp {
 		    "bcc=3Ds" =3D> \@getopt_bcc,
 		    "no-bcc" =3D> \$no_bcc,
 		    "chain-reply-to!" =3D> \$chain_reply_to,
-		    "no-chain-reply-to" =3D> sub {$chain_reply_to =3D 0},
 		    "sendmail-cmd=3Ds" =3D> \$sendmail_cmd,
 		    "smtp-server=3Ds" =3D> \$smtp_server,
 		    "smtp-server-option=3Ds" =3D> \@smtp_server_options,
@@ -506,36 +505,27 @@ sub config_regexp {
 		    "smtp-auth=3Ds" =3D> \$smtp_auth,
 		    "no-smtp-auth" =3D> sub {$smtp_auth =3D 'none'},
 		    "annotate!" =3D> \$annotate,
-		    "no-annotate" =3D> sub {$annotate =3D 0},
 		    "compose" =3D> \$compose,
 		    "quiet" =3D> \$quiet,
 		    "cc-cmd=3Ds" =3D> \$cc_cmd,
 		    "header-cmd=3Ds" =3D> \$header_cmd,
 		    "no-header-cmd" =3D> \$no_header_cmd,
 		    "suppress-from!" =3D> \$suppress_from,
-		    "no-suppress-from" =3D> sub {$suppress_from =3D 0},
 		    "suppress-cc=3Ds" =3D> \@suppress_cc,
 		    "signed-off-cc|signed-off-by-cc!" =3D> \$signed_off_by_cc,
-		    "no-signed-off-cc|no-signed-off-by-cc" =3D> sub {$signed_off_by_cc =
=3D 0},
-		    "cc-cover|cc-cover!" =3D> \$cover_cc,
-		    "no-cc-cover" =3D> sub {$cover_cc =3D 0},
-		    "to-cover|to-cover!" =3D> \$cover_to,
-		    "no-to-cover" =3D> sub {$cover_to =3D 0},
+		    "cc-cover!" =3D> \$cover_cc,
+		    "to-cover!" =3D> \$cover_to,
 		    "confirm=3Ds" =3D> \$confirm,
 		    "dry-run" =3D> \$dry_run,
 		    "envelope-sender=3Ds" =3D> \$envelope_sender,
 		    "thread!" =3D> \$thread,
-		    "no-thread" =3D> sub {$thread =3D 0},
 		    "validate!" =3D> \$validate,
-		    "no-validate" =3D> sub {$validate =3D 0},
 		    "transfer-encoding=3Ds" =3D> \$target_xfer_encoding,
 		    "format-patch!" =3D> \$format_patch,
-		    "no-format-patch" =3D> sub {$format_patch =3D 0},
 		    "8bit-encoding=3Ds" =3D> \$auto_8bit_encoding,
 		    "compose-encoding=3Ds" =3D> \$compose_encoding,
 		    "force" =3D> \$force,
 		    "xmailer!" =3D> \$use_xmailer,
-		    "no-xmailer" =3D> sub {$use_xmailer =3D 0},
 		    "batch-size=3Di" =3D> \$batch_size,
 		    "relogin-delay=3Di" =3D> \$relogin_delay,
 		    "git-completion-helper" =3D> \$git_completion_helper,
--=20
2.42.1


--MP_/BCzNSkghtbb35uQlCqX+osz--

--Sig_/a+K/exH2=9=/mC+QK5.iX6g
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEGolmczWuFi3lJEbAA6FHoT5dwJgFAmVgb1QACgkQA6FHoT5d
wJgz6gf+J9cd55085hlLLjTggcI9bCpOLeCHAXgiDtRsW35+D4LVW3mPtDLmsSO8
gsLFJCAhjOOL/wRabk32+nT+jIq9AMuqbEM014HjUWHh+1hl56vjx/BJ071lI7MG
AegX4rC8lUvav+BcxfHhv7rlq75R3SEy/GnZDNn8+IIMq2Kv397AeN3nk8W/0z65
N+6N27XQeY5QMNuP0t3juYqH7D/sHfXAwj/8/LWZJsLSMR0TGxgtwlEmZlKnR9pp
CgVetM3gFKcvVIEbuWr9C7eEfTUyQrMR7UXV0Rv6P1Szk0bjBM2Mx4z++wci0omN
V8SxAexmzvzsxOaMhSDqabSGtzLZFw==
=1xZ4
-----END PGP SIGNATURE-----

--Sig_/a+K/exH2=9=/mC+QK5.iX6g--
