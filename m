Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FE0EB64D9
	for <git@archiver.kernel.org>; Thu, 15 Jun 2023 14:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344104AbjFOOkN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jun 2023 10:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345116AbjFOOkF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2023 10:40:05 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23ED3170E
        for <git@vger.kernel.org>; Thu, 15 Jun 2023 07:40:03 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 6844F5C01B7;
        Thu, 15 Jun 2023 10:40:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 15 Jun 2023 10:40:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1686840003; x=1686926403; bh=fE
        CaL1BKqc/dvlUFtrd0X2kw27A+8NsUzsddEHdDJXc=; b=akAg/67E5/Bpdiq8F+
        3387Fw49iIknLg7ITUoHgWjfxvtKWcvdpAycSpdUIISYk3xSo7/MlHzZ4/PvtTHN
        ypQptJpnlIMPObZmnYAkjVxNaREga7aLR9cKejyec/UZ9DhhTgPU6qDSYNGGqzza
        dmnAfJ/yd1m6unppy62msn+EHmPjrLeDvOm1OK4Jq9YfBnqys5c+H/y9V6t3BMSW
        IfS1v+7N+J2oEFa61z1eoLaX+CeKEgJVvuvQOTsuRX4iDzm+qWlKaUUd8f2YqaFz
        kRRsNBm/tDpAVKNXcol9ATO2wHuN9DVSYuXZlX9hW6QhR6Vdlg6jaJCZyXVnm03Z
        E5uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1686840003; x=1686926403; bh=fECaL1BKqc/dv
        lUFtrd0X2kw27A+8NsUzsddEHdDJXc=; b=KEDPbgwyMSrSlg5uFv1/UEm9KOzo+
        PSDnFBvbwmQ5uUyVVj9yIibDa4kzVm4T9M+UaOXfdoM/hJOveKyNAGSGFUPpjlg0
        ZvTtmbfre3PUHPV4KO+jrVxzYMUuHu0naUssq9ErKWD3ZC19kcktwm+V62MXLbTP
        JlQgX7eYVhrLIhQoTX75nzDimZivVJbZFNaguU1En4M2MhuTnk13YSb1H8DsNm8k
        46DmhOoC73xHKML1G9AOkLEkNgddZtcDC6Lu86ZX51yoP+Q4gSz72oXuVAY4tl6I
        jO5EoZ9mmqsGC+pRCDyKMb0DwRnpgCmRhnmNqFlFt0/5Nf7mh6gTiJKXw==
X-ME-Sender: <xms:wyKLZJepD0WDPprpmMR0AFuyhsifFVnpiUfZcMYIwnrDjQzPa2p7zQ>
    <xme:wyKLZHP7Mgs0k6cz3nT1pJOGF6wRT90B9nj-aN1T0Zz40AlpN-Ub6aAqFVLOoKVdO
    MX-lXgrkYO1n7wWPQ>
X-ME-Received: <xmr:wyKLZCi6AhJbd91LOkj96kpIwOcevZ5RWmKqnz-BH_YJuHIUJwtk8HTVyYkKF7EIvFsMmD_UaQcMV7tWHvltMkEK1XF9uUe8oseFWtl5s4FZFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedvvddgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:wyKLZC-fLLCE9D4Q4pJisnNvSdRhfXrE-2TjWzPEZ58XvEOKRJiD2w>
    <xmx:wyKLZFvFm9dNA_V6HhWubK5QAotD95nVGvD50VMltd8H-6x9JpLPxw>
    <xmx:wyKLZBFmbRtPrVI3Hcq7CjGaPUbPP2aOqigk08_PV-qcCZGREL9hgQ>
    <xmx:wyKLZD30Dey_u1J3tMVIeVfHppqxK3P8SbQxEUPxzWoGYsgWo8ygWg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jun 2023 10:40:02 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id f7711bd5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 15 Jun 2023 14:39:56 +0000 (UTC)
Date:   Thu, 15 Jun 2023 16:39:59 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/3] revision: handle pseudo-opts in `--stdin` mode
Message-ID: <0cf189b3787ec7a8999da202eae902ec7e912d39.1686839572.git.ps@pks.im>
References: <cover.1686744685.git.ps@pks.im>
 <cover.1686839572.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jzuowsq2eqdi5eax"
Content-Disposition: inline
In-Reply-To: <cover.1686839572.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--jzuowsq2eqdi5eax
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

While both git-rev-list(1) and git-log(1) support `--stdin`, it only
accepts commits and files. Most notably, it is impossible to pass any of
the pseudo-opts like `--all`, `--glob=3D` or others via stdin.

This makes it hard to use this function in certain scripted scenarios,
like when one wants to support queries against specific revisions, but
also against reference patterns. While this is theoretically possible by
using arguments, this may run into issues once we hit platform limits
with sufficiently large queries. And because `--stdin` cannot handle
pseudo-opts, the only alternative would be to use a mixture of arguments
and standard input, which is cumbersome.

Implement support for handling pseudo-opts in both commands to support
this usecase better. One notable restriction here is that `--stdin` only
supports "stuck" arguments in the form of `--glob=3Dfoo`. This is because
"unstuck" arguments would also require us to read the next line, which
would add quite some complexity to the code. This restriction should be
fine for scripted usage though.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/rev-list-options.txt |  9 +++---
 revision.c                         | 21 +++++++++---
 t/t6017-rev-list-stdin.sh          | 51 +++++++++++++++++++++++++++++-
 3 files changed, 72 insertions(+), 9 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-op=
tions.txt
index 3000888a90..e6468bf0eb 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -236,10 +236,11 @@ ifndef::git-rev-list[]
 endif::git-rev-list[]
=20
 --stdin::
-	In addition to the '<commit>' listed on the command
-	line, read them from the standard input. If a `--` separator is
-	seen, stop reading commits and start reading paths to limit the
-	result.
+	In addition to getting arguments from the command line, read
+	them for standard input as well. This accepts commits and
+	pseudo-options like `--all` and `--glob=3D`. When a `--` separator
+	is seen, the following input is treated as paths and used to
+	limit the result.
=20
 ifdef::git-rev-list[]
 --quiet::
diff --git a/revision.c b/revision.c
index 3a39f41bb8..a0b147913f 100644
--- a/revision.c
+++ b/revision.c
@@ -2784,10 +2784,12 @@ static int handle_revision_pseudo_opt(struct rev_in=
fo *revs,
 }
=20
 static void read_revisions_from_stdin(struct rev_info *revs,
-				      struct strvec *prune)
+				      struct strvec *prune,
+				      int *flags)
 {
 	struct strbuf sb;
 	int seen_dashdash =3D 0;
+	int seen_end_of_options =3D 0;
 	int save_warning;
=20
 	save_warning =3D warn_on_object_refname_ambiguity;
@@ -2803,8 +2805,19 @@ static void read_revisions_from_stdin(struct rev_inf=
o *revs,
 			break;
 		}
=20
-		if (sb.buf[0] =3D=3D '-')
-			die("options not supported in --stdin mode");
+		if (!seen_end_of_options && sb.buf[0] =3D=3D '-') {
+			const char *argv[] =3D { sb.buf, NULL };
+
+			if (!strcmp(sb.buf, "--end-of-options")) {
+				seen_end_of_options =3D 1;
+				continue;
+			}
+
+			if (handle_revision_pseudo_opt(revs, argv, flags) > 0)
+				continue;
+
+			die(_("invalid option '%s' in --stdin mode"), sb.buf);
+		}
=20
 		if (handle_revision_arg(sb.buf, revs, 0,
 					REVARG_CANNOT_BE_FILENAME))
@@ -2889,7 +2902,7 @@ int setup_revisions(int argc, const char **argv, stru=
ct rev_info *revs, struct s
 				}
 				if (revs->read_from_stdin++)
 					die("--stdin given twice?");
-				read_revisions_from_stdin(revs, &prune_data);
+				read_revisions_from_stdin(revs, &prune_data, &flags);
 				continue;
 			}
=20
diff --git a/t/t6017-rev-list-stdin.sh b/t/t6017-rev-list-stdin.sh
index 05162512a0..a57f1ae2ba 100755
--- a/t/t6017-rev-list-stdin.sh
+++ b/t/t6017-rev-list-stdin.sh
@@ -48,7 +48,9 @@ test_expect_success setup '
 			git add file-$i &&
 			test_tick &&
 			git commit -m side-$i || exit
-		done
+		done &&
+
+		git update-ref refs/heads/-dashed-branch HEAD
 	)
 '
=20
@@ -60,6 +62,12 @@ check side-1 ^side-7 -- file-2
 check side-3 ^side-4 -- file-3
 check side-3 ^side-2
 check side-3 ^side-2 -- file-1
+check --all
+check --all --not --branches
+check --glob=3Drefs/heads
+check --glob=3Drefs/heads --
+check --glob=3Drefs/heads -- file-1
+check --end-of-options -dashed-branch
=20
 test_expect_success 'not only --stdin' '
 	cat >expect <<-EOF &&
@@ -78,4 +86,45 @@ test_expect_success 'not only --stdin' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'pseudo-opt with missing value' '
+	cat >input <<-EOF &&
+	--glob
+	refs/heads
+	EOF
+
+	cat >expect <<-EOF &&
+	fatal: Option ${SQ}--glob${SQ} requires a value
+	EOF
+
+	test_must_fail git rev-list --stdin <input 2>error &&
+	test_cmp expect error
+'
+
+test_expect_success 'pseudo-opt with invalid value' '
+	cat >input <<-EOF &&
+	--no-walk=3Dgarbage
+	EOF
+
+	cat >expect <<-EOF &&
+	error: invalid argument to --no-walk
+	fatal: invalid option ${SQ}--no-walk=3Dgarbage${SQ} in --stdin mode
+	EOF
+
+	test_must_fail git rev-list --stdin <input 2>error &&
+	test_cmp expect error
+'
+
+test_expect_success 'unknown option without --end-of-options' '
+	cat >input <<-EOF &&
+	-dashed-branch
+	EOF
+
+	cat >expect <<-EOF &&
+	fatal: invalid option ${SQ}-dashed-branch${SQ} in --stdin mode
+	EOF
+
+	test_must_fail git rev-list --stdin <input 2>error &&
+	test_cmp expect error
+'
+
 test_done
--=20
2.41.0


--jzuowsq2eqdi5eax
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmSLIr4ACgkQVbJhu7ck
PpS5oQ/6AhpN/leRn+AtBEN1x5SW575ZngWGs+y89bK6ELK5MrMKYy1PovEEFET+
HSvVfUY4/3Y/QQP+N4OVN6kXydH2nrhE/4GZIjyOvkqvTu92cDajoXvz/GJG8C9h
UCfFz2VUq2quQDny64NIg+lg9MMth0nMNVKFrq7z1VL3+wS0TZJ4i43UftmMc+vq
ZGHVqECEjTYg5S8M2ZnTaVghek/vp516WpMLSZsGUPazancKT2qMe9hFz+VIoKAr
17xs7U+L4Y1ZfZiyEusbzGzOfCYIQpMCZwR+cDVgudZRmvQf+rxajWCHBPZHa+Jd
kgqMe6IqjZNu/JjoWwgAxb+HiD9TUr3BTUiqDEoCGZGZEjnuD7yp3GAr6mjH+uO/
c4p/IS3bOM1VyffOTvQG4CW6ZwP20U8dnaUz1hQCztB58rlBaDNlke4kafEv8l1U
nlUH6WOwxQclp1pjSrVQ+nDMZGY0GirNcZKh5JVSNMfZpisBnijVCCupJFGNbAru
3fbpkT2Nf3/XQdlDaNbAlDhyaxK10GVDjvdfqyG7OLtThl8M5O/go/MoiBHNGTyX
YRS16V9NQL8N4CTI5pzWtzfZsE8ewfW65oQq0WNUcTBBlVx/ItjFhtch/+PqfXpn
DJD13aaay5rA3OpMa9sq/mU3WViR/Fe24O3kFpc4R4B/MfVfYK8=
=tVTI
-----END PGP SIGNATURE-----

--jzuowsq2eqdi5eax--
