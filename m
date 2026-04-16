Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0507E391831
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 11:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338371; cv=none; b=WWl3dd4bn5FLy+InSBWDZV+ZHVM+EBhm/vusiuuzxk5/4IulRoQkNwbYmR8eD3wMoMadOO3y2Egf/bDmbDb5JEE+3B0JyaOgKucLtWivVbZytIk7A9DC3hWfxBtpRKfZTcr8HLkbk/AFsp2c/uTFMH+fxAM6C5pYjWDhntBJNbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338371; c=relaxed/simple;
	bh=YXT7/poVCz51SQ52IQLErSmPA1zRE6DtveYVXQBFA0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c83HoBHvDueb0xEVGso2RQLIYamnkFzwYd4Bu1uM6J17XQe/TaXtLnnTi8RvaDpT28eQsFOQqCppoRXbh6ctVD9lvj7ucz6XspgwRyUZOyQDh2xMUCrLlUCUoAEb7Z/z8gfx3ou24+HwFY8UrYnL/s+TpKAhN4DijfmZskpq0IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DJZjDlZq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XWWVqFQr; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DJZjDlZq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XWWVqFQr"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 622481D00246;
	Thu, 16 Apr 2026 07:19:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 16 Apr 2026 07:19:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776338369;
	 x=1776424769; bh=mMwjZrEM95Od0bQugABsmaEZIyZWB4R542aDuTUvirA=; b=
	DJZjDlZqCqr4qJT2O6UH+OhiRAJ/i24gW6lxQsI9p/i8gjvtWzqrIVuxWZf5yClM
	mP9SjTi200bHupzXFhFjHsotMeU6ntkNjLVRz0TeIpsXu5QTQgcQTh2qADD9V1bg
	JYKCR90j2aL3fWn3DamRCIhENbDswSWWbBTMf6iDcHPqCvSvCstwZhC0ugHOlc7y
	u2wsP3MTM4lKsmM/6kSe2TW5JRwT4aYq/Js8DmEccmhs/QcCNfjZINR5sRwolDvo
	JJFQwyO3+Y7MhJChqYEy0LONuOz2qseGHHiNH29v6LGbhXrhzMoveCIfUGveKByN
	/1ALxxps8uh9iRAvqrobJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776338369; x=
	1776424769; bh=mMwjZrEM95Od0bQugABsmaEZIyZWB4R542aDuTUvirA=; b=X
	WWVqFQrcZrb48UcJixyVJvtw9hMl/zc+WgFBi7BZcdGdHTb/G+DuZIt1DyP7qMPl
	su7qloPQarmto4o7muGMkPsR0fRugu9W3UYSYY03z2O+bjVyaT2x+MkH+bCqErPy
	r93+WgX4HFm6+XqnM4JGiHde/H3eNh4pWgzwsXIQydxzEStNSVNowvKga2LI325j
	Vyv9XN4MTrXchnTua+VY6T6Hb3MooVC9VHyXHLe96IcKATmmWulnUsbQxq7EqFKS
	e7s1qIAeI6UHeXlloEINoWgq67/7iVqwruVZuf4e2iUDAYKNyRLBeyTvvotau5nF
	Tz0a2+TGGzftAjVLvczcQ==
X-ME-Sender: <xms:wcXgaQZ1UyvwRpNDnJUvRLLRNMo3bu321iZA54e4MhpBjv35h0JcPA>
    <xme:wcXgaS0vBjWUP10vWeLu7_qw4ksJ286sdK_AZ9P7wEaSCVAOOApCDAIN_X9J3wFIU
    SpKvFuDKHgHs67Pxf7monsU0plqT8ONNFqZXhFTIi-H8KywlL1AiA>
X-ME-Received: <xmr:wcXgaYWM_tn9rv7H5StAdvm4bG6TUr6q4T6U-INmdgrBha9tlQA8aQxd2isTPnAu6Drt_H6adEcTcEJF8juJY2xAY2cLaWBeovRoEBkeVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegieekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:wcXgaUXWB035Knn-yBJKlSqfEjm9yU2EfM3Izo2rmOSINdjA3omw9g>
    <xmx:wcXgafe01Z4kFRKXsxYZKxXk2ZAXxP7df6MqhCpn5hSXQX8kirOQeA>
    <xmx:wcXgaVV42bEUmYiMqbF6E9z8SzTFBErBz2oW2yvua3sn3HmnOawd6Q>
    <xmx:wcXgaQek4y1vx9odKNVU2VO6Hr9u7GCQXmx1sh2kHIPT_BrxgYcVvw>
    <xmx:wcXgaZmy-aGxXrxdfAqaX11XmmfEyQGfzPihMvtlO7RVZzIgdZBlJwrd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Apr 2026 07:19:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a6627dd8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Apr 2026 11:19:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 16 Apr 2026 13:19:18 +0200
Subject: [PATCH v3 01/12] t: prepare `test_match_signal ()` calls for `set
 -e`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-b4-pks-tests-with-set-e-v3-1-7a90e5dccadd@pks.im>
References: <20260416-b4-pks-tests-with-set-e-v3-0-7a90e5dccadd@pks.im>
In-Reply-To: <20260416-b4-pks-tests-with-set-e-v3-0-7a90e5dccadd@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.15.1

We have a couple of calls to `test_match_signal ()` where we execute a
Git command and expect it to die with a specific signal. These calls
will essentially execute the process in a subshell via `foo; echo $?`,
but as we expect `foo` to fail this will cause the overall subshell to
fail once we `set -e`.

Fix this issue by using `foo && echo 0 || echo $?` instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0005-signals.sh | 4 ++--
 t/t3600-rm.sh      | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t0005-signals.sh b/t/t0005-signals.sh
index afba0fc3fc..84319cf169 100755
--- a/t/t0005-signals.sh
+++ b/t/t0005-signals.sh
@@ -42,12 +42,12 @@ test_expect_success 'create blob' '
 '
 
 test_expect_success !MINGW 'a constipated git dies with SIGPIPE' '
-	OUT=$( ((large_git; echo $? 1>&3) | :) 3>&1 ) &&
+	OUT=$( ((large_git && echo 0 1>&3 || echo $? 1>&3) | :) 3>&1 ) &&
 	test_match_signal 13 "$OUT"
 '
 
 test_expect_success !MINGW 'a constipated git dies with SIGPIPE even if parent ignores it' '
-	OUT=$( ((trap "" PIPE && large_git; echo $? 1>&3) | :) 3>&1 ) &&
+	OUT=$( ((trap "" PIPE && large_git && echo 0 1>&3 || echo $? 1>&3) | :) 3>&1 ) &&
 	test_match_signal 13 "$OUT"
 '
 
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 1f16e6b522..a371ea690e 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -260,7 +260,7 @@ test_expect_success 'choking "git rm" should not let it die with cruft (induce S
 
 test_expect_success !MINGW 'choking "git rm" should not let it die with cruft (induce and check SIGPIPE)' '
 	choke_git_rm_setup &&
-	OUT=$( ((trap "" PIPE && git rm -n "some-file-*"; echo $? 1>&3) | :) 3>&1 ) &&
+	OUT=$( ((trap "" PIPE && git rm -n "some-file-*" && echo 0 1>&3 || echo $? 1>&3) | :) 3>&1 ) &&
 	test_match_signal 13 "$OUT" &&
 	test_path_is_missing .git/index.lock
 '

-- 
2.54.0.rc2.529.gd9106f7525.dirty

