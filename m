Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF75153BF8
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 14:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721743555; cv=none; b=Wpwxui5Vc8ZnYJRdAmDcs8WTV7oY4cO4zqfoeVXDmN6+kgpZVunFoyWyz5eoZfHxabQuIAuUtRKVqdzmN/9ycyaCSIoHJdPzf+G7oKJuoMe8wcLWNV1qosuzE1p3qVuzr3ildQlC9cH6pBP58DzgR5Dx9vZljnNKksnySInXLko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721743555; c=relaxed/simple;
	bh=BZ9jJhKQ2EWJ4VSn7Mt134hDjIV8FnvGQqZ2HvOyv9s=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sbETIRPFjQ2rKZtYFaGmhXclVA+uEBmYkR3BB4UQxCv2JiUXeDOrW0muUVZQmM71jwxCQJLfx2EY9TNqZf1BPx3XFQ7XRApCPRVi6VrC2HkkTJ7FMXy9eIhJmBSeU0LZcrcaPElbltyrKlb8lf3nO1BSs0Xt8gkeQPWIqDnEhDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=A6VYnkpe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QQu/PbaG; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="A6VYnkpe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QQu/PbaG"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 959321380172
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 10:05:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 23 Jul 2024 10:05:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721743550; x=1721829950; bh=TrV2h2sIW8
	a7sTnPC17P8ipt7dhnYhv4Mt0ak05jhJ8=; b=A6VYnkpeK2Hf3YSQN3fscaLRIx
	mN3srTTGZgMdvCw4evv4Po/nPl/EDV8I34gFspT/ZYfCMqGvCdVo1FQwCMrVoFF+
	v6WzPhnWGJxPhFKK1pkw2Wqy/JtZy7DtEji1UtCS9hRhmncqIqRPaW5FtIzvAug8
	RyfyUn72XbCVoRMyyF2VNq4TcRJYGUNZsuHePAAL6A95WerlcM7M9tsCesZvaGfl
	/zTpP83/6VpvMLigZQNlIqVh4ZdFvV9hDe7ezgQXkQz2gvoEzz0EpouC2grJVMrT
	lm1+vayuZYpGE6Cr/nurOF0zlahoZtV1qYQc+z+7S5I1nmPBiFHRgfof9Rzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721743550; x=1721829950; bh=TrV2h2sIW8a7sTnPC17P8ipt7dhn
	Yhv4Mt0ak05jhJ8=; b=QQu/PbaGnTlOfRhdC0+6QEUxWbqxO1Q3Kf8q6Uxx5mAj
	F639DdLNDnAWbOnJ2Rx6rvht3KjKiionjuY1u5nf8RvyHJGssn/xwfIhx7D561W2
	Pe2q2T0F6wjLYr7Eybw2YprAGOLaa9uRl4BJkNIKOhKnAD8lrUQYhQJ82uLnh16f
	iylg3IZvru8qvDkVk/mE1CSCw0IPZRFGq+nH7FuCtR1VKbvqsGJ+PL/jAtLaz/x8
	xfOELwHDvvfGM2814CVpRRhK9tjHsurW/Xlyhisa0urMpa2ysofC8hprMdJxOpLQ
	H3aHrP08qWWP7WzCK/f7j2z9lnwlbEDw9WmbC80d1Q==
X-ME-Sender: <xms:vrifZqi8AML2S-OpseqHNwt4PSjwfi6m1q-4SmksUnJmOSigPbJnXQ>
    <xme:vrifZrBfpSbXS8eOQcW12G8EP1Bz6vQNrkzDxwMZqRB36349u57V2O9M-jabhc5nl
    KeHhqA9HBiDcdYTQg>
X-ME-Received: <xmr:vrifZiE2AtaRuwHdiHjZzEqd4RRnFt5SVnyREfZX4cpXdRv7A3HJOPg_FhXSTUAxzkTzFMlGJI04qB-5wjg5bsLTWy5hhoQ-Y8n3yEp5hnHCoeBV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrheelgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:vrifZjQe4uTSZYu5dbvCSY5EShSQcor-apQfY4Wnh9uiDrRopjFsxg>
    <xmx:vrifZnxYncfa4N7-3d0C9jLONGIyeUTQpgq2STnaEc6FUdheOxegNg>
    <xmx:vrifZh6xtPZ6Zr_yxIkKM9uqP5poQXkSEKF7NcR2qFc0XC8I0Ua50Q>
    <xmx:vrifZkzvVSDhTJiKd7VoRU3lDNdeeAR4c6hisxl8n4eLEyfd7Su_XQ>
    <xmx:vrifZgo8w7ZuGVxu9A8xMYVr0-q7FDZIpN9-bmbltUxWqlZKwINShEYW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 23 Jul 2024 10:05:49 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id a720a038 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 23 Jul 2024 14:04:34 +0000 (UTC)
Date: Tue, 23 Jul 2024 16:05:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 3/3] t98xx: mark Perforce tests as memory-leak free
Message-ID: <d0a80ba403a59d2d3f05b8336f229ff27caaa9d3.1721740612.git.ps@pks.im>
References: <cover.1721740612.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sG3Mi5AsVgn3VNSG"
Content-Disposition: inline
In-Reply-To: <cover.1721740612.git.ps@pks.im>


--sG3Mi5AsVgn3VNSG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

All the Perforce tests are free of memory leaks. This went unnoticed
because most folks do not have p4 and p4d installed on their computers.
Consequently, given that the prerequisites for running those tests
aren't fulfilled, `TEST_PASSES_SANITIZE_LEAK=3Dcheck` won't notice that
those tests are indeed memory leak free.

Mark those tests accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t9800-git-p4-basic.sh                     | 1 +
 t/t9801-git-p4-branch.sh                    | 1 +
 t/t9802-git-p4-filetype.sh                  | 1 +
 t/t9803-git-p4-shell-metachars.sh           | 1 +
 t/t9804-git-p4-label.sh                     | 1 +
 t/t9805-git-p4-skip-submit-edit.sh          | 1 +
 t/t9806-git-p4-options.sh                   | 1 +
 t/t9808-git-p4-chdir.sh                     | 1 +
 t/t9809-git-p4-client-view.sh               | 1 +
 t/t9810-git-p4-rcs.sh                       | 1 +
 t/t9811-git-p4-label-import.sh              | 1 +
 t/t9812-git-p4-wildcards.sh                 | 1 +
 t/t9813-git-p4-preserve-users.sh            | 1 +
 t/t9814-git-p4-rename.sh                    | 1 +
 t/t9815-git-p4-submit-fail.sh               | 1 +
 t/t9816-git-p4-locked.sh                    | 1 +
 t/t9817-git-p4-exclude.sh                   | 1 +
 t/t9818-git-p4-block.sh                     | 1 +
 t/t9819-git-p4-case-folding.sh              | 1 +
 t/t9820-git-p4-editor-handling.sh           | 1 +
 t/t9821-git-p4-path-variations.sh           | 1 +
 t/t9822-git-p4-path-encoding.sh             | 1 +
 t/t9823-git-p4-mock-lfs.sh                  | 1 +
 t/t9825-git-p4-handle-utf16-without-bom.sh  | 1 +
 t/t9826-git-p4-keep-empty-commits.sh        | 1 +
 t/t9827-git-p4-change-filetype.sh           | 1 +
 t/t9828-git-p4-map-user.sh                  | 1 +
 t/t9829-git-p4-jobs.sh                      | 1 +
 t/t9830-git-p4-symlink-dir.sh               | 1 +
 t/t9831-git-p4-triggers.sh                  | 1 +
 t/t9832-unshelve.sh                         | 1 +
 t/t9833-errors.sh                           | 1 +
 t/t9834-git-p4-file-dir-bug.sh              | 1 +
 t/t9835-git-p4-metadata-encoding-python2.sh | 1 +
 t/t9836-git-p4-metadata-encoding-python3.sh | 1 +
 35 files changed, 35 insertions(+)

diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
index 4e95622670..00b5bdd727 100755
--- a/t/t9800-git-p4-basic.sh
+++ b/t/t9800-git-p4-basic.sh
@@ -5,6 +5,7 @@ test_description=3D'git p4 tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./lib-git-p4.sh
=20
 test_expect_success 'start p4d' '
diff --git a/t/t9801-git-p4-branch.sh b/t/t9801-git-p4-branch.sh
index c598011635..cdbfacc727 100755
--- a/t/t9801-git-p4-branch.sh
+++ b/t/t9801-git-p4-branch.sh
@@ -5,6 +5,7 @@ test_description=3D'git p4 tests for p4 branches'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./lib-git-p4.sh
=20
 test_expect_success 'start p4d' '
diff --git a/t/t9802-git-p4-filetype.sh b/t/t9802-git-p4-filetype.sh
index 557e11b16c..4f8cb4a768 100755
--- a/t/t9802-git-p4-filetype.sh
+++ b/t/t9802-git-p4-filetype.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'git p4 filetype tests'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./lib-git-p4.sh
=20
 test_expect_success 'start p4d' '
diff --git a/t/t9803-git-p4-shell-metachars.sh b/t/t9803-git-p4-shell-metac=
hars.sh
index 2913277013..ab7fe16266 100755
--- a/t/t9803-git-p4-shell-metachars.sh
+++ b/t/t9803-git-p4-shell-metachars.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'git p4 transparency to shell metachars in filenames'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./lib-git-p4.sh
=20
 test_expect_success 'start p4d' '
diff --git a/t/t9804-git-p4-label.sh b/t/t9804-git-p4-label.sh
index 3236457106..c8963fd398 100755
--- a/t/t9804-git-p4-label.sh
+++ b/t/t9804-git-p4-label.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'git p4 label tests'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./lib-git-p4.sh
=20
 test_expect_success 'start p4d' '
diff --git a/t/t9805-git-p4-skip-submit-edit.sh b/t/t9805-git-p4-skip-submi=
t-edit.sh
index 90ef647db7..72dce3d2b4 100755
--- a/t/t9805-git-p4-skip-submit-edit.sh
+++ b/t/t9805-git-p4-skip-submit-edit.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'git p4 skipSubmitEdit config variables'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./lib-git-p4.sh
=20
 test_expect_success 'start p4d' '
diff --git a/t/t9806-git-p4-options.sh b/t/t9806-git-p4-options.sh
index c26d297433..e4ce44ebf3 100755
--- a/t/t9806-git-p4-options.sh
+++ b/t/t9806-git-p4-options.sh
@@ -5,6 +5,7 @@ test_description=3D'git p4 options'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./lib-git-p4.sh
=20
 test_expect_success 'start p4d' '
diff --git a/t/t9808-git-p4-chdir.sh b/t/t9808-git-p4-chdir.sh
index 58a9b3b71e..342f7f3d4a 100755
--- a/t/t9808-git-p4-chdir.sh
+++ b/t/t9808-git-p4-chdir.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'git p4 relative chdir'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./lib-git-p4.sh
=20
 test_expect_success 'start p4d' '
diff --git a/t/t9809-git-p4-client-view.sh b/t/t9809-git-p4-client-view.sh
index 9c9710d8c7..f33fdea889 100755
--- a/t/t9809-git-p4-client-view.sh
+++ b/t/t9809-git-p4-client-view.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'git p4 client view'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./lib-git-p4.sh
=20
 test_expect_success 'start p4d' '
diff --git a/t/t9810-git-p4-rcs.sh b/t/t9810-git-p4-rcs.sh
index 5fe83315ec..15e32c9f35 100755
--- a/t/t9810-git-p4-rcs.sh
+++ b/t/t9810-git-p4-rcs.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'git p4 rcs keywords'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./lib-git-p4.sh
=20
 CP1252=3D"\223\224"
diff --git a/t/t9811-git-p4-label-import.sh b/t/t9811-git-p4-label-import.sh
index 5ac5383fb7..52a4b0af81 100755
--- a/t/t9811-git-p4-label-import.sh
+++ b/t/t9811-git-p4-label-import.sh
@@ -5,6 +5,7 @@ test_description=3D'git p4 label tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./lib-git-p4.sh
=20
 test_expect_success 'start p4d' '
diff --git a/t/t9812-git-p4-wildcards.sh b/t/t9812-git-p4-wildcards.sh
index 254a7c2446..46aa5fd56c 100755
--- a/t/t9812-git-p4-wildcards.sh
+++ b/t/t9812-git-p4-wildcards.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'git p4 wildcards'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./lib-git-p4.sh
=20
 test_expect_success 'start p4d' '
diff --git a/t/t9813-git-p4-preserve-users.sh b/t/t9813-git-p4-preserve-use=
rs.sh
index fd018c87a8..0efea28da2 100755
--- a/t/t9813-git-p4-preserve-users.sh
+++ b/t/t9813-git-p4-preserve-users.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'git p4 preserve users'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./lib-git-p4.sh
=20
 test_expect_success 'start p4d' '
diff --git a/t/t9814-git-p4-rename.sh b/t/t9814-git-p4-rename.sh
index 2a9838f37f..00df6ebd3b 100755
--- a/t/t9814-git-p4-rename.sh
+++ b/t/t9814-git-p4-rename.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'git p4 rename'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./lib-git-p4.sh
=20
 test_expect_success 'start p4d' '
diff --git a/t/t9815-git-p4-submit-fail.sh b/t/t9815-git-p4-submit-fail.sh
index c766fd159f..92ef9d8c24 100755
--- a/t/t9815-git-p4-submit-fail.sh
+++ b/t/t9815-git-p4-submit-fail.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'git p4 submit failure handling'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./lib-git-p4.sh
=20
 test_expect_success 'start p4d' '
diff --git a/t/t9816-git-p4-locked.sh b/t/t9816-git-p4-locked.sh
index 5e904ac80d..e687fbc25f 100755
--- a/t/t9816-git-p4-locked.sh
+++ b/t/t9816-git-p4-locked.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'git p4 locked file behavior'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./lib-git-p4.sh
=20
 test_expect_success 'start p4d' '
diff --git a/t/t9817-git-p4-exclude.sh b/t/t9817-git-p4-exclude.sh
index ec3d937c6a..3deb334fed 100755
--- a/t/t9817-git-p4-exclude.sh
+++ b/t/t9817-git-p4-exclude.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'git p4 tests for excluded paths during clone and sync'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./lib-git-p4.sh
=20
 test_expect_success 'start p4d' '
diff --git a/t/t9818-git-p4-block.sh b/t/t9818-git-p4-block.sh
index de591d875c..091bb72bdb 100755
--- a/t/t9818-git-p4-block.sh
+++ b/t/t9818-git-p4-block.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'git p4 fetching changes in multiple blocks'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./lib-git-p4.sh
=20
 test_expect_success 'start p4d' '
diff --git a/t/t9819-git-p4-case-folding.sh b/t/t9819-git-p4-case-folding.sh
index b4d93f0c17..985be20357 100755
--- a/t/t9819-git-p4-case-folding.sh
+++ b/t/t9819-git-p4-case-folding.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'interaction with P4 case-folding'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./lib-git-p4.sh
=20
 if test_have_prereq CASE_INSENSITIVE_FS
diff --git a/t/t9820-git-p4-editor-handling.sh b/t/t9820-git-p4-editor-hand=
ling.sh
index fa1bba1dd9..48e4dfb95c 100755
--- a/t/t9820-git-p4-editor-handling.sh
+++ b/t/t9820-git-p4-editor-handling.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'git p4 handling of EDITOR'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./lib-git-p4.sh
=20
 test_expect_success 'start p4d' '
diff --git a/t/t9821-git-p4-path-variations.sh b/t/t9821-git-p4-path-variat=
ions.sh
index ef80f1690b..49691c53da 100755
--- a/t/t9821-git-p4-path-variations.sh
+++ b/t/t9821-git-p4-path-variations.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'Clone repositories with path case variations'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./lib-git-p4.sh
=20
 test_expect_success 'start p4d with case folding enabled' '
diff --git a/t/t9822-git-p4-path-encoding.sh b/t/t9822-git-p4-path-encoding=
=2Esh
index 572d395498..e62ed49f51 100755
--- a/t/t9822-git-p4-path-encoding.sh
+++ b/t/t9822-git-p4-path-encoding.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'Clone repositories with non ASCII paths'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./lib-git-p4.sh
=20
 UTF8_ESCAPED=3D"a-\303\244_o-\303\266_u-\303\274.txt"
diff --git a/t/t9823-git-p4-mock-lfs.sh b/t/t9823-git-p4-mock-lfs.sh
index 88b76dc4d6..98a40d8af3 100755
--- a/t/t9823-git-p4-mock-lfs.sh
+++ b/t/t9823-git-p4-mock-lfs.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'Clone repositories and store files in Mock LFS'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./lib-git-p4.sh
=20
 test_file_is_not_in_mock_lfs () {
diff --git a/t/t9825-git-p4-handle-utf16-without-bom.sh b/t/t9825-git-p4-ha=
ndle-utf16-without-bom.sh
index 8e34f72198..4d1d4fa5f3 100755
--- a/t/t9825-git-p4-handle-utf16-without-bom.sh
+++ b/t/t9825-git-p4-handle-utf16-without-bom.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'git p4 handling of UTF-16 files without BOM'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./lib-git-p4.sh
=20
 UTF16=3D"\227\000\227\000"
diff --git a/t/t9826-git-p4-keep-empty-commits.sh b/t/t9826-git-p4-keep-emp=
ty-commits.sh
index fd64afe064..54083f842e 100755
--- a/t/t9826-git-p4-keep-empty-commits.sh
+++ b/t/t9826-git-p4-keep-empty-commits.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'Clone repositories and keep empty commits'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./lib-git-p4.sh
=20
 test_expect_success 'start p4d' '
diff --git a/t/t9827-git-p4-change-filetype.sh b/t/t9827-git-p4-change-file=
type.sh
index d3670bd7a2..3476ea2fd3 100755
--- a/t/t9827-git-p4-change-filetype.sh
+++ b/t/t9827-git-p4-change-filetype.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'git p4 support for file type change'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./lib-git-p4.sh
=20
 test_expect_success 'start p4d' '
diff --git a/t/t9828-git-p4-map-user.sh b/t/t9828-git-p4-map-user.sh
index ca6c2942bd..7c8f9e3930 100755
--- a/t/t9828-git-p4-map-user.sh
+++ b/t/t9828-git-p4-map-user.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'Clone repositories and map users'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./lib-git-p4.sh
=20
 test_expect_success 'start p4d' '
diff --git a/t/t9829-git-p4-jobs.sh b/t/t9829-git-p4-jobs.sh
index 88cfb1fcd3..3fc0948d9c 100755
--- a/t/t9829-git-p4-jobs.sh
+++ b/t/t9829-git-p4-jobs.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'git p4 retrieve job info'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./lib-git-p4.sh
=20
 test_expect_success 'start p4d' '
diff --git a/t/t9830-git-p4-symlink-dir.sh b/t/t9830-git-p4-symlink-dir.sh
index 3fb6960c18..02561a7f0e 100755
--- a/t/t9830-git-p4-symlink-dir.sh
+++ b/t/t9830-git-p4-symlink-dir.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'git p4 symlinked directories'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./lib-git-p4.sh
=20
 test_expect_success 'start p4d' '
diff --git a/t/t9831-git-p4-triggers.sh b/t/t9831-git-p4-triggers.sh
index ff6c0352e6..f287f41e37 100755
--- a/t/t9831-git-p4-triggers.sh
+++ b/t/t9831-git-p4-triggers.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'git p4 with server triggers'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./lib-git-p4.sh
=20
 test_expect_success 'start p4d' '
diff --git a/t/t9832-unshelve.sh b/t/t9832-unshelve.sh
index 6b3cb0414a..a266775408 100755
--- a/t/t9832-unshelve.sh
+++ b/t/t9832-unshelve.sh
@@ -6,6 +6,7 @@ last_shelved_change () {
=20
 test_description=3D'git p4 unshelve'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./lib-git-p4.sh
=20
 test_expect_success 'start p4d' '
diff --git a/t/t9833-errors.sh b/t/t9833-errors.sh
index e22369ccdf..da1d30c142 100755
--- a/t/t9833-errors.sh
+++ b/t/t9833-errors.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'git p4 errors'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./lib-git-p4.sh
=20
 test_expect_success 'start p4d' '
diff --git a/t/t9834-git-p4-file-dir-bug.sh b/t/t9834-git-p4-file-dir-bug.sh
index dac67e89d7..565870fc74 100755
--- a/t/t9834-git-p4-file-dir-bug.sh
+++ b/t/t9834-git-p4-file-dir-bug.sh
@@ -6,6 +6,7 @@ This test creates files and directories with the same name =
in perforce and
 checks that git-p4 recovers from the error at the same time as the perforce
 repository.'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./lib-git-p4.sh
=20
 test_expect_success 'start p4d' '
diff --git a/t/t9835-git-p4-metadata-encoding-python2.sh b/t/t9835-git-p4-m=
etadata-encoding-python2.sh
index 036bf79c66..ad20ffdede 100755
--- a/t/t9835-git-p4-metadata-encoding-python2.sh
+++ b/t/t9835-git-p4-metadata-encoding-python2.sh
@@ -6,6 +6,7 @@ This test checks that the import process handles inconsiste=
nt text
 encoding in p4 metadata (author names, commit messages, etc) without
 failing, and produces maximally sane output in git.'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./lib-git-p4.sh
=20
 python_target_version=3D'2'
diff --git a/t/t9836-git-p4-metadata-encoding-python3.sh b/t/t9836-git-p4-m=
etadata-encoding-python3.sh
index 63350dc4b5..71ae763399 100755
--- a/t/t9836-git-p4-metadata-encoding-python3.sh
+++ b/t/t9836-git-p4-metadata-encoding-python3.sh
@@ -6,6 +6,7 @@ This test checks that the import process handles inconsiste=
nt text
 encoding in p4 metadata (author names, commit messages, etc) without
 failing, and produces maximally sane output in git.'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./lib-git-p4.sh
=20
 python_target_version=3D'3'
--=20
2.46.0.rc1.dirty


--sG3Mi5AsVgn3VNSG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmafuLkACgkQVbJhu7ck
PpTanxAArKHwLiH12avhiUb9efrmR5cyL+5tkU+lDaj1sSBZceRb7QbkMe+yQdsI
zjdk5+yWbLjlJCJBAPgphmR6oXD4TcTiHe4QESQbwqR+KcSAKBG9Zf57roKyQ+sq
rrHYrdWq7LgQK9DhTjPbdlhxutrt4tl3IGJcyHdYOR+9/AHDg8+453zu0xO5BZy9
17gpG9Q6SygX67fVduwnUo/XrNiiXXpvqbi3mJMOdfESfCo/SzoNtkO4Jun1k/Qk
mz6geMwZO3GSqUQYwvX5IeMsCHo0WmtXEFRveSZoiG/Y7t7ARzQcQgp9vjNsXHc4
5+e+8WALypdJrIWyQj0nKjm1d0vL0Y8pt1AME70d7pc34vI8/V3jnjcbKhiBbdvM
GLRvm5wmPwscND/NejovC6GzjcmgcYRycjcKqmiZB5TGJLW71ICZtKmPAMQSvIHK
2EIfSSGAqX+KZh6rKKmx0ltFfzouJWUaS9eTUBJc2AZhRogkPa+Sg7Q0zwU3tMo1
P+hzLP/E8moMTWpPv0+xZoFwRuMq8127Q/F3TORY2dBdcPKy/T+lUvX38KLa3WOj
b7zRcZCpI//L47gJLAOQ6twruIRtoJBiWo0qFJUvzTAJRRAasQhAPQrdRfqCL2ru
F7QSpvag0jFEt4tctGZuPKQ6HXDUcXP2LzspuCt4oqudLSYotxc=
=qJwt
-----END PGP SIGNATURE-----

--sG3Mi5AsVgn3VNSG--
