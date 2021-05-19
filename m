Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA5CC433ED
	for <git@archiver.kernel.org>; Wed, 19 May 2021 19:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EE736108D
	for <git@archiver.kernel.org>; Wed, 19 May 2021 19:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbhESTO6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 15:14:58 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:37411 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229979AbhESTOw (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 19 May 2021 15:14:52 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 59BE25C0105
        for <git@vger.kernel.org>; Wed, 19 May 2021 15:13:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 19 May 2021 15:13:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=fm1; bh=OM+CcW43VMgIM/sbQSc191cpo6QdgLsdz6cAA1l/
        vYU=; b=YzNA6LiIIlmR7Qbo8Acj8Uoihf6eVkPhzG75fdlkn6rjfmzRL5m5K9Q0
        Btd1lyifRxpAzS/1aGUyDvuukqTJKzX5tdW30vYlLmq8yawdQc9kzKPVBE3DX7Fs
        m3qZ92Y0DChF+qJp9d9JARcUmYfitHYcJsHa8eIEOCNu9uU6lcq+SRFNe6UfkcOg
        NDjndrrM4ixFyrKtZeNZN3V6m7E/4Q7k6YmLrmWno5SybySqW7BmZeSxzmkq3Wvp
        SJPSWALenZczIRmWiWomsPXC0yhxgVF9/YZAcajpBPje7L7VMdLSjym5fytl8fct
        L2uAw56iDqPb7QTUuzP9rHlXQNMjFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=OM+CcW
        43VMgIM/sbQSc191cpo6QdgLsdz6cAA1l/vYU=; b=CNqK+vnhcOdR6F+f77L6RY
        /6JMSZ1s9shDQCxF/39Bq6ce/8fmh3TFzazZt31AcUGHyjqjtIdrY2dsIO4DBbex
        cbnA1T/yjXVRHihfMiUD0Rsx6dUBvxJogIDfNXKC27nSKG2IMSCYMCJfl6dgKtPl
        QwssBhsO6M1g6VmYX3aUKtpfxucwniGFu+H5a7Dn8Yjbahy/98altlgqmsCPOBT1
        jojRsFY+SLsg2zlwPy4UbYQIiaGApeYrAqNsK/t6YAGmQbjqB1YxVYoXfKlbFzZN
        mvReOpTbJQxfQ4PrpMAw1tQIo0Y9cN3fcWejY/Sg8b+y4xLWODW0HoUdf8SQIsbw
        ==
X-ME-Sender: <xms:XGOlYHzBl69eSQz5j_w0uYOalenajXUcfPXFWI-iayR8cPjkAJmt1w>
    <xme:XGOlYPTluElLZ-7lIpz8EBVgLmkF9BS2gagXEDVysAW2_g7cUgvuBJO3e4F5JDUwi
    KOqhw2miu3IeBsqKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeiledgudefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucfkphepjeejrddukeefrdefjedrudehieen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:XGOlYBV5ow518CI42mRrJRvV-LYye_Mt1OAE3BdCrPMaJmQJOyJc2g>
    <xmx:XGOlYBjYojS-wkdJVSw1LepRmg7Te8E9Bbnlteb9dZ2UqXnaMXmwFw>
    <xmx:XGOlYJBW3_ki39oGVC188-zdYKCVbGVKg2LTwPhfcGfykQp3s3CkrQ>
    <xmx:XGOlYMNf-GrQBT9mjdX-72aD5QbInd2me90Y5jqhYSQZKOgpDEt7oA>
Received: from vm-mail.pks.im (x4db7259c.dyn.telefonica.de [77.183.37.156])
        by mail.messagingengine.com (Postfix) with ESMTPA
        for <git@vger.kernel.org>; Wed, 19 May 2021 15:13:31 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 0b1b9e74 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Wed, 19 May 2021 19:13:28 +0000 (UTC)
Date:   Wed, 19 May 2021 21:13:27 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 2/8] p5400: add perf tests for git-receive-pack(1)
Message-ID: <f248b41d6e2df2d34a4304e2655df8cb094483e9.1621451532.git.ps@pks.im>
References: <cover.1621451532.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RRuvv8I/c8qhTYq/"
Content-Disposition: inline
In-Reply-To: <cover.1621451532.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--RRuvv8I/c8qhTYq/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We'll the connectivity check logic for git-receive-pack(1) in the
following commits to make it perform better. As a preparatory step, add
some benchmarks such that we can measure these changes.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/perf/p5400-receive-pack.sh | 74 ++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100755 t/perf/p5400-receive-pack.sh

diff --git a/t/perf/p5400-receive-pack.sh b/t/perf/p5400-receive-pack.sh
new file mode 100755
index 0000000000..2b0c89d977
--- /dev/null
+++ b/t/perf/p5400-receive-pack.sh
@@ -0,0 +1,74 @@
+#!/bin/sh
+
+test_description=3D"Tests performance of receive-pack"
+
+. ./perf-lib.sh
+
+test_perf_large_repo
+
+test_expect_success 'setup' '
+	# Create a main branch such that we do not have to rely on any specific
+	# branch to exist in the perf repository.
+	git switch --force-create main &&
+
+	TARGET_REPO_CLONE=3D$(pwd)/target-clone.git &&
+	git clone --bare --dissociate --branch main "$(pwd)" "$TARGET_REPO_CLONE"=
 &&
+	TARGET_REPO_REFS=3D$(pwd)/target-refs.git &&
+	git clone --bare --dissociate --branch main "$(pwd)" "$TARGET_REPO_REFS" =
&&
+	TARGET_REPO_EMPTY=3D$(pwd)/target-empty.git &&
+	git init --bare "$TARGET_REPO_EMPTY" &&
+
+	# Set up a pre-receive hook such that no refs will ever be changed.
+	# This easily allows multiple perf runs, but still exercises
+	# server-side reference negotiation and checking for consistency.
+	mkdir hooks &&
+	write_script hooks/pre-receive <<-EOF &&
+		#!/bin/sh
+		echo "failed in pre-receive hook"
+		exit 1
+	EOF
+	cat >config <<-EOF &&
+		[core]
+			hooksPath=3D$(pwd)/hooks
+	EOF
+	GIT_CONFIG_GLOBAL=3D"$(pwd)/config" &&
+	export GIT_CONFIG_GLOBAL &&
+
+	# Create a reference for each commit in the target repository with
+	# extra-refs. While this may be an atypical setup, biggish repositories
+	# easily end up with hundreds of thousands of refs, and this is a good
+	# enough approximation.
+	git -C "$TARGET_REPO_REFS" log --all --format=3D"tformat:create refs/comm=
it/%h %H" |
+		git -C "$TARGET_REPO_REFS" update-ref --stdin &&
+
+	git switch --create updated &&
+	test_commit --no-tag updated
+'
+
+while read name repo
+do
+	refs=3D("create updated:new")
+
+	# If the target repository is the empty one, then the only thing we can
+	# do is to create a new branch.
+	if test "$repo" !=3D "$TARGET_REPO_EMPTY"
+	then
+		refs+=3D("update updated:main" "reset main~:main" "delete :main")
+	fi
+
+	while read desc ref
+	do
+		test_expect_success "setup $name $desc" "
+			test_must_fail git push --force '$repo' '$ref' \
+				--receive-pack=3D'tee pack | git receive-pack' 2>err &&
+			grep 'failed in pre-receive hook' err
+		"
+
+		test_perf "receive-pack $name $desc" "
+			git receive-pack '$repo' <pack >negotiation &&
+			grep 'pre-receive hook declined' negotiation
+		"
+	done < <(printf "%s\n" "${refs[@]}")
+done < <(printf "%s\n" "clone $TARGET_REPO_CLONE" "extrarefs $TARGET_REPO_=
REFS" "empty $TARGET_REPO_EMPTY")
+
+test_done
--=20
2.31.1


--RRuvv8I/c8qhTYq/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmClY1YACgkQVbJhu7ck
PpT+wBAAn6/KR13pBvbU8gBi9SmWJ1OUdF8kLK7HybtbLkISu5x4tUiOMyJHN6xH
m4gah5hfRqSjkBIGPEc4cviJQhGp8H+RKpyr2KTWTmHjueedZMg8uH1keCLA9mb5
8FdhrZwrr1TkcF05ewcQanv3Q++0ML01FACM/lvUu8rB0jqPtZ6TJ0o8D5mlQuz+
98Bge1FqJ0lNQhwGfEHhoaQUd5mDImv95BrOg4vcfexBI9DHcHsfpJf6pk3qxAug
Q26Q5nujeTL8tlnZx+BpYdIlIUs7LXxwS1/80fcZiAyHjqPIx+ZiPDhSy6gcxG1Y
OGsU4o2cwg7lVruA2mqHAlCrmNU5yU+gaLmFa0+kIEGRZJr3xb0RmtKGMBkP+q8k
uiEnAY0hrZBjdflDbvjd5fhq80diz+NmI1J4BjsyfSzJmbT3mmTj8q9WrepZGWKo
6CeaT1conaOZpaXTZ0dnQxSPrzcz4FJtJgehoYzA+OefDt+SOI+H+iPhwzK8aUQu
IzCIMP02iYIlDzAK0UCwf4EPcCNKkQk+Oi1DiTNYyAkN0ZkopXqQ0kP0pLkOci5q
Yu7mJaDfC82Fp0Fa/pkd6iI47HWIuidCkLu2rIZIiG0sL5ryTdKFooS4nv1VJTCM
8/9pN8tcsqxa6DvmnS4Q0JHwHLMjcbwyytzHLu4yjXrY0exG6RA=
=24yQ
-----END PGP SIGNATURE-----

--RRuvv8I/c8qhTYq/--
