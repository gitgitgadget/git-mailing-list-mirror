Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D975A1AAE20
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 10:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722422282; cv=none; b=V4aoO9XYeoc47f56cjb87yEJRFvnZ48Vtumns1TcjrfYwAb5jRLXgCksfz6NQ3JjiGU1ZwuFPcDK1qmgp3Vw3IweGrA4GYjHSapvxnCyln9tttx0Jx3t0+dqILOL/ryTOOvxm4CrwuFrpP+g70uVxY4QyJp8gRd5Jq3DpWOGl/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722422282; c=relaxed/simple;
	bh=BEb0YhyDhUzvJZHP403j+SuTCeofzB3C+Ck6dnxwW74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eh74oZ0PmDZqJ+lW6p9GpsWEeCxydOCZlFgeyxwvZOIDzjjc4UFGoCm9GKk/tgIGZly+P/Ln+WtDyE8PJR6soK2rgTT1MRqbRWmC2a3evAtmnBm4vwQlZEn1B+B47mYqVokspwOYAW+vL8MtZKZVSNGg70LUQU67HFFluvSIaXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eqxLC27r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cHfzeryF; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eqxLC27r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cHfzeryF"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 066841382331;
	Wed, 31 Jul 2024 06:38:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 31 Jul 2024 06:38:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722422280; x=1722508680; bh=dtND8ad3iC
	3J6QjCExUXowqOkEum6B3MKmXrvfJfyWs=; b=eqxLC27rh7cAIPm9T8hXOKGDOm
	Jnh6lXAFqIOvzpYFwQ9CeR/T/2yFJVcphFvv2tDlwDFPNAuJFMr7BMxZH1Xmspkd
	8mnH0gXTxL+fbYJz/3KQ5SAtFXfh5dhbKuhj+zaTFTP134hDd6krmtAeSqh96u/s
	YUU0zdRqCLmVYrHiquMuCSCNZ8WjMQCCuDHbpQkAeggeVMQdgvnr/mLBvSIFNqbL
	2LSNpJdv6l9CYmUP8cYM8QS/oWuF0df8CglSFghfSDg7QzugJ6tbnCkRTgLMgLxp
	pgB4TyksoHjRbSFs//x7HEMWhtWowOQtuUWvhKaKD9EHNX8nDtjq58/goG/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722422280; x=1722508680; bh=dtND8ad3iC3J6QjCExUXowqOkEum
	6B3MKmXrvfJfyWs=; b=cHfzeryFI438T9xeUYkszwsrV1SYIeKk6pddQHV/S30P
	ricSHJqGvccFx4mk9yc9mXPlHIXW5th+649KaZ7CHPONaiEdJ3ynYjr3b8K9p0YR
	oNiMIskh1Lf09dNLPgnU7YxYQmcVOGl+tWDGYtf/KR9JYuBDwUUQQo375lLhTR0S
	eoGqyQ+fJzcXSFRjvMmks6EFXjGWh2VZ+z67cn1NJ1VE/zRHDOouP6JbML2/cpiN
	AiHJko4AFBr/E48EEelE34aGz0bM7CrJqW26wt5OOOjxzUkD1AThC/tgvzjtZ6Li
	lMRjsL1GXpwNam58K5+vP9SOX/TCF1QeepGYf8lglA==
X-ME-Sender: <xms:BxSqZvxzza5CKvtwQ3m_ujRMjjFP_qm9XxwN_CshCPwPipkEV7X6Ow>
    <xme:BxSqZnTm9L_JxtGcuFcM7wYYw2EXdPFvxpezW-kCTu8PtUXqYI59DiHSIwq-7lJv8
    iQmKQktbZJbfCsHmQ>
X-ME-Received: <xmr:BxSqZpWvosSXUTIyJPONnQ4emQ3-RQg5K_NPmS_qBBlePe7WqoJXNcFsvjuZJppMj-RNp3ijntUn1KULiQ0Cht5wSOYmwCPgdYMfKQZa8JvKyFTl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeigdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:BxSqZpgMRDvKOcazVgtQekRlzlXoerldVhywxhCA3xVVEHzPMfNarg>
    <xmx:BxSqZhCxrQf2exqn57w1YhljF1JpTBvTeyGO8duIgJfrdB9i3ILOaA>
    <xmx:BxSqZiJgr-0vPor2cACm_741IJKEFUviMo9Fr2uYOVIHmb_EHWEXjA>
    <xmx:BxSqZgAMAFJsoRJubsAtKCQRbwIZSJ7q84lib3R1EhxGFVjFDNfsUw>
    <xmx:BxSqZs8aZ6q63_3FBjLjJnAg-xFJaQPLGmaDt9pondzAxnUFWOTK0WQn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Jul 2024 06:37:58 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id c597b14e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 31 Jul 2024 10:36:29 +0000 (UTC)
Date: Wed, 31 Jul 2024 12:37:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/3] t98xx: mark Perforce tests as memory-leak free
Message-ID: <bf03405db9764360cb75ce780c3fa22e013fb992.1722421911.git.ps@pks.im>
References: <cover.1721740612.git.ps@pks.im>
 <cover.1722421911.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lfIJxCDRFIwTKhMN"
Content-Disposition: inline
In-Reply-To: <cover.1722421911.git.ps@pks.im>


--lfIJxCDRFIwTKhMN
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
index 0816763e46..3e6dfce248 100755
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
index df01a5d338..1bc48305b0 100755
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
index 6a60b32349..d0b86537dd 100755
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
2.46.0.dirty


--lfIJxCDRFIwTKhMN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaqFAQACgkQVbJhu7ck
PpTsvw//VSJJpVbfsNM32RC+Y5UedsQOwt5Dw2skPcnyxMwgxvY38ZFFgIUUgqJ4
0lkBfJLjM2NT/f8HbrIq/dnrYGr4wf9JcMfv0JkhJaE36kRv85ZNfPvjg6UqNKVT
t1P2Kkc0B72A9hMmglEmGOjszgX9RCE2JnsdS7vT1Zwr9m80sYNauw2mO99n3Ywo
d3ZTF5BdWH21n8rn9heHoloUGBwr8kWPWd8lJXwVAafm06xAx2uhFGlVjr4BNHIP
za2bK2C7zT/Bgle0UrreUqk+IQ+dNh5QBNPDEh5ynelBf6fCSqRxSZ8NgGx6/8si
TNcXDYgpQDOa/h5YYenVJ6wQcDMd/k/Qpv4s2s9xO3fRy7L6HxgCwtWPUbH7r2TH
+lLYYvKFW2SylAG/q3Cf2IOO2P1/wXPa3ajAWoh6xWxd8u/aJWRwng/E17FAeNCI
BmTektYHX0UjWHj7ts1/9B4ZK4OQgQORvE3mFk/gZ5NXw5rjxxgrRFpkva0g+5yv
BCdqz9WJ4Kt6V7umv4ugxzASX+FQJBZ2j8DYn8/Vo6M1iPJRv1ZEjh2N5UmbFrlo
Wo6Y2Mwife+yvPJFrVvt27VC9Cd3rW/PzS7JSaRzrJ1HA9YIAK6hXuBtv32Tl8xU
w0yFSLydnDcqltjwDQfiIVjN1043v4BrTjxJaNcNoMZ5fewE13c=
=Mai0
-----END PGP SIGNATURE-----

--lfIJxCDRFIwTKhMN--
