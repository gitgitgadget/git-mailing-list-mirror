Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC8DEB64DB
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 12:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233887AbjFNMTE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 08:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244267AbjFNMSq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 08:18:46 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF91D19AC
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 05:18:45 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 6A2283200947
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 08:18:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 14 Jun 2023 08:18:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1686745125; x=1686831525; bh=0o
        fBIgRsyldkwZAWkl9E/PKqow6J0UtjHRAjcPXVcsg=; b=rKKHBfUL21bVGSIJum
        V9YEFXD9pnsicfsqHhnspFFwWpQ0WzZPgyQDTcO4JA1xWpe+p8ZtyuWVT+AMLb+2
        fIiECNena/LaSMxkrfqaTNCnmjtpG4dwk9CXliJXGM7opiJ8UFT9S5g9UiAxn2zL
        HSwM57V3D9j1xZ7LAulrEi5xQ0W9wwHlf7dWwz61YzMbJ6h+DukrYWx21k3dWFcZ
        xpz+kfrk4tdb2kzzqYAazzEYhDBuwRqczRk9jd5sXVsKV8R2ijbWEGxOAsRnJWW5
        fzyIpKtrnAyDRjmdXF6rUbIn4G7Zl4XCw0UJqVRnYxMY59ZC8YTCgT82H0qVJCle
        C5uQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1686745125; x=1686831525; bh=0ofBIgRsyldkw
        ZAWkl9E/PKqow6J0UtjHRAjcPXVcsg=; b=XaynKL+7vA2Z2HXqOyeQZ6gh3Acgy
        hUGzZR6u9FS0uJtsbsSQxXVm4CGNb9X3lhe/HAuCgUnBr5Dd/u9btseyDtEFtqiu
        Ht2IkhgycfxssiC8Jne76iQTZHMm6AZjpZcq3pTuBPAmeavIjE8kmoOoTKwj8yzl
        nof/lR7UYsX4U3Wj+sPqaZoLzU5h9vQIJHi3rtGSlorQpj5ymKYG/hDPloYPSd6G
        Q8giAXYjYZPRqzBiPfH5rUSk3OntpQ6iTao55KXYnRqYddFS/GoH67iF8QDLWSO7
        BBGCuwghcmIzq9MFTFDluPFqgla/IKT8inqU4rEXeXJmw+2gJX8NEOQog==
X-ME-Sender: <xms:JLCJZAQBlqeoAqFK3PeKuQXZyEVpjJUqOau-R1w1AHgsuGLwilcv9g>
    <xme:JLCJZNwibs-QjDSl3sIbGtEKyvUiAavZH8jtHNzHJ7ucIlqaUrhU106XNt6S4-rLe
    gqIi7gGy_j_z7xjjQ>
X-ME-Received: <xmr:JLCJZN3XZiczARgKJLi8ftUlnzN6IOXjRICfN-j-CkJ3ws9Z97WSFtKL3q1fjjCbpsFwNJLW5NRED4C8DckSlkmDAoXs9UwBZ8r6B6P7fzNfWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedvtddgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:JLCJZEDjWRedxoPoxkRzX59oubSB7bDJ8o_FgJprCapqqF_R3jUuHg>
    <xmx:JLCJZJgGte6SqvXVfLTC4ss5YC0SVhjkaDAvr-id64WeoknkC1Q7Cg>
    <xmx:JLCJZAr7BqxLugfyUhiAgzDkRegVJ2ojJ5pJsnyI-_UF93CrlkQ2Fw>
    <xmx:JbCJZDdVaUKIQj1jpZ7WGbvQATtqGksiZVBDjU9uCgIP5NBBlCVA9w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 14 Jun 2023 08:18:44 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id c6a94baa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Wed, 14 Jun 2023 12:18:41 +0000 (UTC)
Date:   Wed, 14 Jun 2023 14:18:42 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 3/3] revision: handle pseudo-opts in `--stdin` mode
Message-ID: <457591712799719f23fa47e59d5a3c1cd497e802.1686744685.git.ps@pks.im>
References: <cover.1686744685.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6okf7w3imvooldbr"
Content-Disposition: inline
In-Reply-To: <cover.1686744685.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--6okf7w3imvooldbr
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
 Documentation/rev-list-options.txt |  9 +++++----
 revision.c                         | 12 ++++++++---
 t/t6017-rev-list-stdin.sh          | 32 ++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 7 deletions(-)

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
index dcb7951b4e..b90794cca4 100644
--- a/revision.c
+++ b/revision.c
@@ -2784,7 +2784,8 @@ static int handle_revision_pseudo_opt(struct rev_info=
 *revs,
 }
=20
 static void read_revisions_from_stdin(struct rev_info *revs,
-				      struct strvec *prune)
+				      struct strvec *prune,
+				      int *flags)
 {
 	struct strbuf sb;
 	int seen_dashdash =3D 0;
@@ -2799,12 +2800,17 @@ static void read_revisions_from_stdin(struct rev_in=
fo *revs,
 			break;
=20
 		if (sb.buf[0] =3D=3D '-') {
+			const char *argv[2] =3D { sb.buf, NULL };
+
 			if (!strcmp(sb.buf, "--")) {
 				seen_dashdash =3D 1;
 				break;
 			}
=20
-			die("options not supported in --stdin mode");
+			if (handle_revision_pseudo_opt(revs, argv, flags))
+				continue;
+
+			die(_("option '%s' not supported in --stdin mode"), sb.buf);
 		}
=20
 		if (handle_revision_arg(sb.buf, revs, 0,
@@ -2890,7 +2896,7 @@ int setup_revisions(int argc, const char **argv, stru=
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
index 05162512a0..11cb27c3ed 100755
--- a/t/t6017-rev-list-stdin.sh
+++ b/t/t6017-rev-list-stdin.sh
@@ -60,6 +60,11 @@ check side-1 ^side-7 -- file-2
 check side-3 ^side-4 -- file-3
 check side-3 ^side-2
 check side-3 ^side-2 -- file-1
+check --all
+check --all --not --branches
+check --glob=3Drefs/heads
+check --glob=3Drefs/heads --
+check --glob=3Drefs/heads -- file-1
=20
 test_expect_success 'not only --stdin' '
 	cat >expect <<-EOF &&
@@ -78,4 +83,31 @@ test_expect_success 'not only --stdin' '
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
+test_expect_success 'unknown options' '
+	cat >input <<-EOF &&
+	--unknown=3Dvalue
+	EOF
+
+	cat >expect <<-EOF &&
+	fatal: option ${SQ}--unknown=3Dvalue${SQ} not supported in --stdin mode
+	EOF
+
+	test_must_fail git rev-list --stdin <input 2>error &&
+	test_cmp expect error
+'
+
 test_done
--=20
2.41.0


--6okf7w3imvooldbr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmSJsCEACgkQVbJhu7ck
PpThqg//RHLhcNZPQiI7b9b4cdjduhqG651ovNskJlbSy+W/btkhbIpGu73BzSnC
TsMVc3eIt1FyH1AzQAi8NyZtLNTY+vj+j005XPg9KjlNr27/0VMsmHG5gfiKSy6B
0z0coTLlHBYaaBlVtY4EZMEDR8IZpywJv5k71HLxpDFsy7rRFUu2/6Luxl8sVcl+
vqfZljWA1v/OmJlfP6BISlqzTLVDwxH26c7F7VipNN864r2PIC6eW/feEQxUnKvd
mViEjtIA1DryOoU35Z/mkAXqPf1vPN0C8Rlv0zWvm4Oexics9QlvhiD4zSlczNKa
pgrZvzZQNHowukkH9ULsLYbGDjxrIJI7xpVm6+E6lRB0DS3tHHuCpOwSsyiiBOnu
OMdcPTzhBD+9sX5+eRO4WwkG6DvksZAlNXZM/AO+5KZefuXv/7OYMD9ULCP9A8Fw
rU7VFMdm0i9m5hNH8/i0EEooFBnkNTD7SPeHCU5leotEdewuuA1JGPAJEC0h7qAx
dEQHMQIdQG5snCA9XOa/fJeexJpJgB+SU8TYFqZgI91bFFDo2I/Bk6HxAS79OpWV
ChvoAGSo1YbGph60pucbP6rOnOR2Q57O42I38YK4pDJxArSbCTPu+3nsy1J2niUO
s0naGP+LlOM/AD1bGnAJWLIF8JWbQyo2G4Z9yioTpQhR4y1J+RQ=
=ASfu
-----END PGP SIGNATURE-----

--6okf7w3imvooldbr--
