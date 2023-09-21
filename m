Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA6AE7D0A4
	for <git@archiver.kernel.org>; Thu, 21 Sep 2023 17:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjIURLC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Sep 2023 13:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbjIURKb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2023 13:10:31 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989B6A5C8
        for <git@vger.kernel.org>; Thu, 21 Sep 2023 10:05:54 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 691C93200954;
        Thu, 21 Sep 2023 06:06:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 21 Sep 2023 06:06:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1695290760; x=1695377160; bh=Hbr1tZykJTOAiGFPqksBfoAtI
        ht40g1HVvHPhEtY/F4=; b=OtPn/tP+qTWAEMlfL8+nSrzvp4oIePhwhf0DjIaTE
        hAEZ6GtVa0dKSAyY8OsShgPdMxfJ+Dls/TdAhxiflfVHbltthtScr+hQFSs5xcfv
        fbIKe0Kl0ZEox5/N8iadjWjtI/rVveuTwwDlQoQbG0cZS9kd1v68LP6tfBAEJT3R
        9X56i8gSTzNIcGem/9Fs7J48fvE54zg+OgB5SqSeYC7wnTek9E++VwVK68Ggl15P
        zdcPlRdQbO+A9TGMjzLBlKOT6+zUb7z4cfhGX5H5ldE3bgF8O2oqYgVfqzEujpZC
        I4nf5LXKaYJYLSrPrMvr+RDEVmtS4T3jkvYy24my5UA8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1695290760; x=1695377160; bh=Hbr1tZykJTOAiGFPqksBfoAtIht40g1HVvH
        PhEtY/F4=; b=jZA8jDAsVv6PaoLJcDGywJktfODWfxRdQ0Ds9feVV1UFzXyHK7R
        dnrppB9sNGt2O2fNTrvFN7dKxXgnGfbiID6Dyg2kqEUzv+mmzeLpOch4njhyQEmn
        rVzqF/t8yMRTyZVXI2OjY3SOXLL1bkZp49qwOErmxtcwu2REw2wBydh//48eBi8m
        RMpLc5P+CUMDitY+Cfeom2IGllAzLwA8QSkdn69+YhsTKc6YVODLygRfhz4VZQZ4
        1ln8TPl0urEloUMe0xOP+nb3wqFyW3ZgPhziLG4trX7cGsQyuZor3RIkdhvAVAQg
        Y+uWwTiT95Bkk6RmDOm/6wzsHjPyw5PcCNw==
X-ME-Sender: <xms:iBUMZWEwM49V_0_ru2HSZOvC_npzQuJ4828deLTnvDWKYRnLA1rhSw>
    <xme:iBUMZXXbpPX6lHDW8h1crJma2KnSfxSXYU3ei_TnBZ4AlIQWw1qf6r6OIxIFxYt-k
    YTWY_UwTX-rFL_iGw>
X-ME-Received: <xmr:iBUMZQLnmHEmnxlikFDvI8WDuouqbUklqMnLP9Q2lJnugoy12bsuAHC_xoGXWmW1T1VPqQaHExQojNa1IKmqWrSZQpXJ9Lfs4WFuEgmJb5kiBbx2pQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekiedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkgggtugesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epuefguedtueeiheetleevgedujeekjeehleejjefhhffghfevgfekueekjedtieejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:iBUMZQGUYbS_-zfilwH53nnvT5qMPkal2IFYBSpr1KnhYbYynbM1DA>
    <xmx:iBUMZcWutAPuNFSmA9lWBO9MfwsBaaclWWDdQJe-DJ4xNcHX8cdTXg>
    <xmx:iBUMZTMEdl2xyLVYtFxOEI8QpVdHRntSvYdUsaXkJZCxzXmVcOdz6A>
    <xmx:iBUMZVcix2UTLyParmiqUF0vcqFQjSsDLq0fWviW6z4xGLKjZgrtGA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Sep 2023 06:06:00 -0400 (EDT)
Received: by vm-mail (OpenSMTPD) with ESMTPSA id 14269305 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 21 Sep 2023 10:05:58 +0000 (UTC)
Date:   Thu, 21 Sep 2023 12:05:57 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>
Subject: [PATCH] revision: make pseudo-opt flags read via stdin behave
 consistently
Message-ID: <b93d4c8c23552abab64084b62f27944e7e192c0c.1695290733.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="blMJypwoJ7C+xH9x"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--blMJypwoJ7C+xH9x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When reading revisions from stdin via git-rev-list(1)'s `--stdin` option
then these revisions never honor flags like `--not` which have been
passed on the command line. Thus, an invocation like e.g. `git rev-list
--all --not --stdin` will not treat all revisions read from stdin as
uninteresting. While this behaviour may be surprising to a user, it's
been this way ever since it has been introduced via 42cabc341c4 (Teach
rev-list an option to read revs from the standard input., 2006-09-05).

With that said, in c40f0b7877 (revision: handle pseudo-opts in `--stdin`
mode, 2023-06-15) we have introduced a new mode to read pseudo opts from
standard input where this behaviour is a lot more confusing. If you pass
`--not` via stdin, it will:

    - Influence subsequent revisions or pseudo-options passed on the
      command line.

    - Influence pseudo-options passed via standard input.

    - _Not_ influence normal revisions passed via standard input.

This behaviour is extremely inconsistent and bound to cause confusion.

While it would be nice to retroactively change the behaviour for how
`--not` and `--stdin` behave together, chances are quite high that this
would break existing scripts that expect the current behaviour that has
been around for many years by now. This is thus not really a viable
option to explore to fix the inconsistency.

Instead, we change the behaviour of how pseudo-opts read via standard
input influence the flags such that the effect is fully localized. With
this change, when reading `--not` via standard input, it will:

    - _Not_ influence subsequent revisions or pseudo-options passed on
      the command line, which is a change in behaviour.

    - Influence pseudo-options passed via standard input.

    - Influence normal revisions passed via standard input, which is a
      change in behaviour.

Thus, all flags read via standard input are fully self-contained to that
standard input, only.

While this is a breaking change as well, the behaviour has only been
recently introduced with Git v2.42.0. Furthermore, the current behaviour
can be regarded as a simple bug. With that in mind it feels like the
right thing to do retroactively change it and make the behaviour sane.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
Reported-by: Christian Couder <christian.couder@gmail.com>
---
 Documentation/rev-list-options.txt |  6 +++++-
 revision.c                         | 10 +++++-----
 t/t6017-rev-list-stdin.sh          | 21 +++++++++++++++++++++
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-op=
tions.txt
index a4a0cb93b2..9bf13bac53 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -151,6 +151,8 @@ endif::git-log[]
 --not::
 	Reverses the meaning of the '{caret}' prefix (or lack thereof)
 	for all following revision specifiers, up to the next `--not`.
+	When used on the command line before --stdin, the revisions passed
+	through stdin will not be affected by it.
=20
 --all::
 	Pretend as if all the refs in `refs/`, along with `HEAD`, are
@@ -240,7 +242,9 @@ endif::git-rev-list[]
 	them from standard input as well. This accepts commits and
 	pseudo-options like `--all` and `--glob=3D`. When a `--` separator
 	is seen, the following input is treated as paths and used to
-	limit the result.
+	limit the result. Flags like `--not` which are read via standard input
+	are only respected for arguments passed in the same way and will not
+	influence any subsequent command line arguments.
=20
 ifdef::git-rev-list[]
 --quiet::
diff --git a/revision.c b/revision.c
index 2f4c53ea20..a1f573ca06 100644
--- a/revision.c
+++ b/revision.c
@@ -2788,13 +2788,13 @@ static int handle_revision_pseudo_opt(struct rev_in=
fo *revs,
 }
=20
 static void read_revisions_from_stdin(struct rev_info *revs,
-				      struct strvec *prune,
-				      int *flags)
+				      struct strvec *prune)
 {
 	struct strbuf sb;
 	int seen_dashdash =3D 0;
 	int seen_end_of_options =3D 0;
 	int save_warning;
+	int flags =3D 0;
=20
 	save_warning =3D warn_on_object_refname_ambiguity;
 	warn_on_object_refname_ambiguity =3D 0;
@@ -2817,13 +2817,13 @@ static void read_revisions_from_stdin(struct rev_in=
fo *revs,
 				continue;
 			}
=20
-			if (handle_revision_pseudo_opt(revs, argv, flags) > 0)
+			if (handle_revision_pseudo_opt(revs, argv, &flags) > 0)
 				continue;
=20
 			die(_("invalid option '%s' in --stdin mode"), sb.buf);
 		}
=20
-		if (handle_revision_arg(sb.buf, revs, 0,
+		if (handle_revision_arg(sb.buf, revs, flags,
 					REVARG_CANNOT_BE_FILENAME))
 			die("bad revision '%s'", sb.buf);
 	}
@@ -2906,7 +2906,7 @@ int setup_revisions(int argc, const char **argv, stru=
ct rev_info *revs, struct s
 				}
 				if (revs->read_from_stdin++)
 					die("--stdin given twice?");
-				read_revisions_from_stdin(revs, &prune_data, &flags);
+				read_revisions_from_stdin(revs, &prune_data);
 				continue;
 			}
=20
diff --git a/t/t6017-rev-list-stdin.sh b/t/t6017-rev-list-stdin.sh
index a57f1ae2ba..4821b90e74 100755
--- a/t/t6017-rev-list-stdin.sh
+++ b/t/t6017-rev-list-stdin.sh
@@ -68,6 +68,7 @@ check --glob=3Drefs/heads
 check --glob=3Drefs/heads --
 check --glob=3Drefs/heads -- file-1
 check --end-of-options -dashed-branch
+check --all --not refs/heads/main
=20
 test_expect_success 'not only --stdin' '
 	cat >expect <<-EOF &&
@@ -127,4 +128,24 @@ test_expect_success 'unknown option without --end-of-o=
ptions' '
 	test_cmp expect error
 '
=20
+test_expect_success '--not on command line does not influence revisions re=
ad via --stdin' '
+	cat >input <<-EOF &&
+	refs/heads/main
+	EOF
+	git rev-list refs/heads/main >expect &&
+
+	git rev-list refs/heads/main --not --stdin <input >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--not via stdin does not influence revisions from com=
mand line' '
+	cat >input <<-EOF &&
+	--not
+	EOF
+	git rev-list refs/heads/main >expect &&
+
+	git rev-list refs/heads/main --stdin refs/heads/main <input >actual &&
+	test_cmp expect actual
+'
+
 test_done
--=20
2.42.0


--blMJypwoJ7C+xH9x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmUMFYQACgkQVbJhu7ck
PpRVyg//bQ25X6Wr2RKRkiTxaFK0ua6dKSJc+7eqyTnDJNOsO4+ah8rctEu+Y3Gj
xjXVKFggI5kfMMjC/17olNlIPvoNQk5C90OARERQqVV3vJ5OQfIvraRhdbV9Uzfq
uz7mipKQqJe8B+1Rc9SJXAfoeeYBbl9RToOV4s8uGSmXkNc6xgYCvguy8ZQNHvaF
tsOL1Y0kP+waSmlmvPZnKfbqIKNrRl9wzrFxNtAtZ8Hp7YjsLD4ugdgFeP3lPAK6
GgvAneMvQRFDPNGKX2lQSypeXBBNuN7zaN1lccXcxmR/kS1C4EmuR8ehV/HRHddN
wznLYu1v+mlTmeEv4C9Z4JWP876vqq1eqFXOKxqAtO3/xv/yXTTmqt1c9DyLqrp1
s7wtsFgYox47JIi8HDq5B6+iIGiTvsa2RRXzofexhPC+nU5m2LV9EIJHVbP0Enwj
Ah0xQa1K3Bh+O6LMQLfWqoIoXmTDxrqYZIiO17zZbjGqipbwdUIZ0NtA/ySWXbmr
gmTeg2/7hVWukICBmgsLp5Y3it8yQLqbMMlgDr0jGr3up6D0u0grQ84UQ1OMuK4f
vVJjoKwUGkeSIg/wV28FYkH5caK/bg3lLj1KLKvPw/9w3z4Tx3rMdN3rIvNuTKaC
idTKCtRpdmlU1UwwvUYZVN2vtF47w+3T1p6SckU0LaCEafBR/Mk=
=sfwB
-----END PGP SIGNATURE-----

--blMJypwoJ7C+xH9x--
