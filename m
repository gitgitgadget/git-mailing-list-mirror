Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DD31581EE
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 03:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740714450; cv=none; b=pvvaajB/jGJmwZidBfsjkAtkBGN86i3ZaIrMYm76SVfzO0ov7HqcNoM+flElKa3lLXkABI9X1Dgr4mB9hQ4wVzuHDqttu+flGLkwgkjwxZTTmtIRrEczHWq0xi3YF3EMIs0e4FGSTn93HDtQ1ft2h5hIV7RX/nOUDxttm433BtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740714450; c=relaxed/simple;
	bh=2hqyjFLqtBPDGjesliViJBTev2Nc681939gi/iFms+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QvSwK0ClAZpdOuSmC1XVg4yC4qYDfbAGaHf7BldheM8VB+Z46mexbMj2TwM17q3tmxKhGTHqs01jfomt9113rwFhwOl9JOYMhu//nD/fzrhDL8QNOQey01RFxZP58svCPBz/2YUc4791O5ukuxr/1iQU8eocmyOi1EBk9Dp1FzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=wZGX7zRq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=4Sr7uU6d; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="wZGX7zRq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4Sr7uU6d"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id CE946114015D;
	Thu, 27 Feb 2025 22:47:27 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 27 Feb 2025 22:47:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1740714447; x=
	1740800847; bh=Sl1GsjiAvBzMBV/8YOpS0gPWoV7Baor7G27uTgjYypc=; b=w
	ZGX7zRqrTSH7CJQovoczVWkscj0c6M9ctzE+a2P/KwKc0HCqwAFJrfHY5lxrzbny
	QnO9CFyyVpBOOzZ6t7aPAVfPJMg2aiakjAhy52OUipj6pQWXEBQeUgtTF6S9aPXo
	aWFXtHHxE2ZwDu0mrQOCQ9PK1fPXWh+qkAyk3LKB5gqiQ8CuyAM0Ve7idd6oiS7v
	uaOT7mcStB+Vgrn/nbWJitdaxEK/xZk4VJ6f3ICQXdMqE16FPIKaanWILIhBq4gV
	TUujJSDlyEWJq1bMlUB0X1MJEgyUdlCYu71g1DAD0zi2u2T7dMmWp8qtX0bebKNV
	Zwg6HZEW6k/5eZEGioEFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1740714447; x=1740800847; bh=S
	l1GsjiAvBzMBV/8YOpS0gPWoV7Baor7G27uTgjYypc=; b=4Sr7uU6d8QMZwl4ov
	Lcyy1+OmC+SbS0S87SpOQs5VP1RWCpYs24NnS5qhHgVlVU5tML3fzKegyNTZohTs
	iDtGgb9u7SC0zCdKjn4GYYCdDpb2ti8FkiAWVRCJb18DQkgEPpj/uui+H37jUqR0
	/xqFXYHpvloFQoez1008AUh4oEGbqANZohk571gch9j+YmPm9+Q2cl6UxDoj2Wne
	UCwwvKHdj2wvt0nma7xUeBYaLaNaTlfgOx5+aOBj+yQ+tYjuPi5KNylS9HJfoQYA
	wtVyyXzxuupexqOzBt+etKD1/ZZyDvYJT1FKXp9i8Tu0VIwSgh2d1qhnrpgR3zUe
	CG+Jg==
X-ME-Sender: <xms:zzHBZ2xBtFYTyVf3fk6OYCJ0Ecvrhuz9-HcesbQPXgQIrKn2oWW6sA>
    <xme:zzHBZyT_DB3AT873rVGnqro1BbNTSuNukqS2E13v6xnY6OS7mv0n5oF9PrKoRFpPq
    GXV8Msc72OdaonC9w>
X-ME-Received: <xmr:zzHBZ4VSU3Bl32ivyq3fIl7jVyVCp8Zg-BiMCGeCgv4Gq1YOpL9bD_Wmxvetu9HLjwANceMu_HMhiCzLvFEXwwO8bNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekleefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpefvohguugcukghulhhlihhnghgvrhcuoehtmhiisehpohgsohigrdgtoh
    hmqeenucggtffrrghtthgvrhhnpeejuefggfehieeugeeuheevgfegudetheetuedvveeu
    ueeileeuhfeigeefkeekieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehtmhiisehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehsrghnuggrlhhs
    segtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:zzHBZ8gMHV3f3H5RypgipyJe3WSkKrNiQ_oux_kcoNB37ShvxSk_xw>
    <xmx:zzHBZ4DlfTMHFD3g_viVInXxTCAktN-G2lnHNTGG91BMNyJCXWQa4w>
    <xmx:zzHBZ9JTshsnYnlb16OqxG64erv4ok1vzPj5XAtQ3aJkygP66zCKxw>
    <xmx:zzHBZ_DtcdbW1fnQCx_1-12-N_asX9DdI_ae4kk_3jMTMDBCeH6Spg>
    <xmx:zzHBZ7OhDsUxawcKMUtDbiLhugefbQ_QDDu5l0S_ZelS4QYLVzwV2INQ>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Feb 2025 22:47:27 -0500 (EST)
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 3/3] contrib/subtree: rename .txt to .adoc
Date: Thu, 27 Feb 2025 22:47:06 -0500
Message-ID: <20250228034713.203461-4-tmz@pobox.com>
X-Mailer: git-send-email 2.49.0.rc0
In-Reply-To: <20250228034713.203461-1-tmz@pobox.com>
References: <20250228034713.203461-1-tmz@pobox.com>
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
 2 files changed, 1 insertion(+), 1 deletion(-)
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
-- 
2.49.0.rc0

