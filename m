Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563771E25E3
	for <git@vger.kernel.org>; Sat,  1 Mar 2025 15:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740843377; cv=none; b=TWA6N1yqjI29wf/904qtZ4K70IYcLlR9HAFS+iOTlP63hAyIGTU7Bgz7CzLR8SqeZB9tKcLIDVK/x2dkQUJ1bhA2ez67mN6SnXrB3cEm/XQNhKKQmMT9mdosNf5M4cEx08KVxQGIVp2ln9rqZ0gKvxOShC/nyNUsenKngKXxSbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740843377; c=relaxed/simple;
	bh=laokikOpz3oBAxLv3Egn2xLlZi/7GeEJLp1L/MkE354=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kv8gwmTE6DackTNJftRNFNgthpSYZqgUeBd6ov09MwG98wpoP03cqmPGZzLEjGtXF1OltTyxeTvxXIOtB4OoIr8VTpLNjLxeFZ6vYczhTR+shm1DyAT/drQ7vc/TwU0/Hrx3xZucwvC96Kpjo7C/OFyevxhWwy1RPpQUdMXDlLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=wvlgNAyS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jEpwDbXR; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="wvlgNAyS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jEpwDbXR"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 558EA11400EE;
	Sat,  1 Mar 2025 10:36:15 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sat, 01 Mar 2025 10:36:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1740843375; x=
	1740929775; bh=Ilxpj4tWfJRzGPuSTzxwrswoRZrBatkK+SOy1Ua78UE=; b=w
	vlgNAySlPE3RvciAWHEy7Xqxec91hdSPYxQThTuAH5eQSxaVZ7fxLwpZOB4KsKSk
	9DcNtWGKi20b1ttSDnUEaoLQGaNShWn7lTQsQGdshAve9MzbNOmaL9QIzAichtOS
	iEKUz1Iw3eXeyh6pALA8nLliJy7MjWlv2WjmgVrUC2cTy0sAd3mPZd8mOFRH/L3p
	aFBzDRMuYvN1chWkRhfC73G+T10i+S92+N1knnOGUCZQfLTKKc87uS+jez2ivuJh
	w1wGNu1oDrvssYxcoBxCRRm2kk9HyUlT9lJxw7uCWlnucDzA8KGwWE2ol70s+9pc
	aEwJywjzL6p+qRuaJAJ5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1740843375; x=1740929775; bh=I
	lxpj4tWfJRzGPuSTzxwrswoRZrBatkK+SOy1Ua78UE=; b=jEpwDbXRJMa3JqILz
	za3dY+mAChdPZPuK383h07kSDdonsmyB9XKJ/S59LPUK3m+C8sXq0KWCwAZ0k8tM
	xb31VMvcWOYfSxCaMfaBNOOFYMY6IyUoxGuCzRV0zaCCjm1Yq5apPV91tEGZLDfH
	3IXdmIA2t0qWIxHWMvPIPFlQNusIr178EO2mqTPOqQw5qHu/q1CdqzmXMlqi/mOA
	ZMjBB/2nktuWo4eMA4bYNZVz/6T0dOJnrhjvPXDi+lRdoJj3CoZXs87jmRQXOgA1
	kQWexaDTmjYfUC6FoqIXKocm19DxCfrUEj5o+a/rBZV11NhmDcm1VGVcXqS5Luc1
	DwAVQ==
X-ME-Sender: <xms:bynDZ6i2hW1jJ-8BdUtXnKpxe8xn0Q06QYF9kNs8mEKH8obIygmjSg>
    <xme:bynDZ7DR3x62QmD-70yfbRyp-jGDqWhg8QtWBPoKTqR9FYmH3nsJEpo41JUnTegcR
    KDhuyukxnGiGaYe_Q>
X-ME-Received: <xmr:bynDZyHAUCHv5ERQzkN0wePOCq4a43vRnsxAyO45kCsflsr3lyGEtqY2pFTJI0cqUl9wqS_DMDSfAJocIUkgzenWV_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelfeeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpefvohguugcukghulhhlihhnghgvrhcuoehtmhiisehpohgsohigrdgtoh
    hmqeenucggtffrrghtthgvrhhnpeejuefggfehieeugeeuheevgfegudetheetuedvveeu
    ueeileeuhfeigeefkeekieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehtmhiisehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehsrghnuggrlhhs
    segtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:bynDZzTgTr31q8mFEHM1D00G_YoM-65yshUx32aGTC4cM7idI9kMcw>
    <xmx:bynDZ3zyN3xrHIeSZgXSNZ8jOfWuOZAqppJ87wZk0_YtwqgatwReCw>
    <xmx:bynDZx5D5LqEHpmotc2VWsc6v0bgno9SGak2nk0PLck5RevnJpn-5w>
    <xmx:bynDZ0wZw_1qTQUawjvcNcSmgPx_5GPcD5v6CmtLuUn4dBHLGxlA2w>
    <xmx:bynDZ5sFyhPlFRSqYt9b9riAZWjPc9awtsCIZsPFXdrVTCg6mnwoDeRA>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 1 Mar 2025 10:36:14 -0500 (EST)
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/3] contrib/subtree: rename .txt to .adoc
Date: Sat,  1 Mar 2025 10:36:04 -0500
Message-ID: <20250301153607.95746-4-tmz@pobox.com>
X-Mailer: git-send-email 2.49.0.rc0
In-Reply-To: <20250301153607.95746-1-tmz@pobox.com>
References: <20250301153607.95746-1-tmz@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The .txt extensions were changed to .adoc in 1f010d6bdf (doc: use .adoc
extension for AsciiDoc files, 2025-01-20).

Do the same for contrib/subtree.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 contrib/subtree/Makefile                              | 2 +-
 contrib/subtree/{git-subtree.txt => git-subtree.adoc} | 0
 contrib/subtree/meson.build                           | 4 ++--
 3 files changed, 3 insertions(+), 3 deletions(-)
 rename contrib/subtree/{git-subtree.txt => git-subtree.adoc} (100%)

diff --git a/contrib/subtree/Makefile b/contrib/subtree/Makefile
index 8fe0bfd401..c0c9f21cb7 100644
--- a/contrib/subtree/Makefile
+++ b/contrib/subtree/Makefile
@@ -50,7 +50,7 @@ GIT_SUBTREE    := git-subtree
 
 GIT_SUBTREE_DOC := git-subtree.1
 GIT_SUBTREE_XML := git-subtree.xml
-GIT_SUBTREE_TXT := git-subtree.txt
+GIT_SUBTREE_TXT := git-subtree.adoc
 GIT_SUBTREE_HTML := git-subtree.html
 GIT_SUBTREE_TEST := ../../git-subtree
 
diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.adoc
similarity index 100%
rename from contrib/subtree/git-subtree.txt
rename to contrib/subtree/git-subtree.adoc
diff --git a/contrib/subtree/meson.build b/contrib/subtree/meson.build
index a752a188df..9c72b23625 100644
--- a/contrib/subtree/meson.build
+++ b/contrib/subtree/meson.build
@@ -32,7 +32,7 @@ if get_option('docs').contains('man')
       '@INPUT@',
     ],
     depends: documentation_deps,
-    input: 'git-subtree.txt',
+    input: 'git-subtree.adoc',
     output: 'git-subtree.xml',
   )
 
@@ -63,7 +63,7 @@ if get_option('docs').contains('html')
       '@INPUT@',
     ],
     depends: documentation_deps,
-    input: 'git-subtree.txt',
+    input: 'git-subtree.adoc',
     output: 'git-subtree.html',
     install: true,
     install_dir: get_option('datadir') / 'doc/git-doc',
-- 
2.49.0.rc0

