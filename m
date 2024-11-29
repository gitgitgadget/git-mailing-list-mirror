Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFC64D8DA
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 18:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732906371; cv=none; b=Nt7WlLt9/hXxoDfrHdyutXWbVLHyMo5Ty9dzp+w/LgcNSfb/TOd7FUrijpYnh55uQCiR/pUbMNdhJh3AFIVCAPYwSaKV2FAVc+5qFCnAJykDFDlMwn8oVc5ADYbxwDIdxjDFVFEH0sCX9ZSi8CSGhdWEY97UsS8EMBLQeXZGcck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732906371; c=relaxed/simple;
	bh=4ZtCHf7Y/wkGLAQJVHCo8mLp3qzPmyKiUQcVPIpHE/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mfnU7wQ7bXAl7JOKWVVVxB968OtbJIN2QZtZVKVO0NWQLuHK66w0GDBI6XUAxH7NMFt2k9TrUtGsu539wTIJwFU7MtlejYZPFddVQbji+FFCGQyJelwMlfNYgcefos9QmxZnfvIlHx6cklqKYeD24M1za9IE/ReblYU6N0llivk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=hVjo5/l+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zLMdS/PF; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="hVjo5/l+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zLMdS/PF"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 2EE441380255;
	Fri, 29 Nov 2024 13:52:48 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 29 Nov 2024 13:52:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1732906368; x=1732992768; bh=1k
	nuIgu8fzBrUuCkIkyPO6zhAnPG15fc8E43qhfJiiY=; b=hVjo5/l+XQa6NehJk9
	jdVI2OkMjARUlzEgYLqc/P0eXGEF5UQ2ZoR8+Og0xA0ijB1p3UPpJs5W/dUD+ZlP
	JHS8/h1WsVHowO/zp+UbycrBCv+CMTT0pBwtFQoPAaGCySp3LiYVCM9picHRnUL4
	R3fwH+wz7Jweqf3HWiX7NFLRDVNmdsbKLD4NHur4U8wSInL4BfxggUmUbtE3UtyF
	b4n4xwM+TJRct2TSVvt2MUu22HvORQbHRChr0P8APDU/LT6Da1GnKQiJcuUTCa8P
	ZPSspAtu/fwZ7rAwH+OWy+MNwhhpoFXMaBEWbF2iTdq9z0oSwkhCN2OF9JDgltf8
	KezQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1732906368; x=1732992768; bh=1knuIgu8fzBrUuCkIkyPO6zhAnPG
	15fc8E43qhfJiiY=; b=zLMdS/PFPvEDK3ZH9HzJOmkXT6OOSbtabSi1H/Icickz
	WHWg+gLSGb/4LKCcbYrc9X/gRTaGmEDWA7IfjbS+5S0Q25Mh4Oh2EVAo2YYxWfPo
	vgdzVsnK5ppBQWDfSGADDl7nGrYH7zv7DfY90ISpPeE7k+749t6JCnt94T2SNpuJ
	AvnS2GLNzoT07MZvCJMsDHq0zloOGarwlAqmW6zvHBCW7WwV54ZGSqLSJDAjfhxE
	7bHjbh5KL2SSYF2AQlMj5/7QWB09EY/UQ/dca//1r+EJkq68C7z7Xb/SJYy2Xy3H
	ZkN/M98Aovxj9Uvoww2kddyBGSMGG5niAjMNMoAbHw==
X-ME-Sender: <xms:fw1KZ9WW0jOSf2gWacgXRDbXtiwt5CAjjyxcdHm3nptRFhTHD0CKI8k>
    <xme:fw1KZ9myf07ysFI03ssFF6GLZFAtpyggcchGTETDre-vrdDW4M7v0du4mMo5Ppkn2
    inmWHUxJpPsOMNNMQ>
X-ME-Received: <xmr:fw1KZ5Z0eiwiAtoV7_Ai5vx2OV_NIsSuu5SPjY-rcZcOF-jz-gJ3XAz8JmvkG2BZEtsd4hUt9chIe3L6eML7yEnTxyCY2qgCUrVfQ-K6J_SrBSBspm3gCHP2zQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheefgdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffogggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhepheelhefhie
    euheejveeftdfgiedtueevhfdugedvheekvedvuedtueeffeeigeevnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghi
    lhdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvges
    khhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:fw1KZwXUDchNQ5qkVDgTBX4VnvUU0H2EATj5bfxu-k9hTPuV4ShEFw>
    <xmx:fw1KZ3mIP6HZU9_mcr7ZqHzlTa6hzCNSa6CWixMBUBDZ1BMtEabELQ>
    <xmx:fw1KZ9dtHPuEkVLym2oyuNs2C2WygaZXm0ssHdDW82MB9fvPYhR8Sw>
    <xmx:fw1KZxGAm5wQcJ6OjRP_biXy2VpfpKQecZzVTiXpW0GtSMAxm5Hkvw>
    <xmx:gA1KZ8zLO9xkgj_HDy2seP34bmTZyD5ZTgtRoSHxR68yOgj5LqRBAUXt>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Nov 2024 13:52:47 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH] Documentation/git-update-ref.txt: add missing word
Date: Fri, 29 Nov 2024 19:52:29 +0100
Message-ID: <6cc7a9d60216c966bcf77675aa22a39cfa8993e2.1732906187.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Add missing word “that” in the phrase “after verifying that”, like
what was done in 1b2dfb70504 (Documentation/git-update-ref.txt: drop
“flag”, 2024-10-21)

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    I found this while on a v1+ version of the topic kh/update-ref and
    didn’t want to disrupt it with a new patch.
    
    https://lore.kernel.org/git/cover.1729017728.git.code@khaugsbakk.name/
    
    I found no other “verify” phrases with such a missing word.

 Documentation/git-update-ref.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index 8a4281cde9f..9e6935d38d0 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -93,11 +93,11 @@ update::
 	ref does not exist before the update.
 
 create::
-	Create <ref> with <new-oid> after verifying it does not
+	Create <ref> with <new-oid> after verifying that it does not
 	exist.  The given <new-oid> may not be zero.
 
 delete::
-	Delete <ref> after verifying it exists with <old-oid>, if
+	Delete <ref> after verifying that it exists with <old-oid>, if
 	given.  If given, <old-oid> may not be zero.
 
 symref-update::
@@ -110,11 +110,11 @@ verify::
 	<old-oid> is zero or missing, the ref must not exist.
 
 symref-create:
-	Create symbolic ref <ref> with <new-target> after verifying
+	Create symbolic ref <ref> with <new-target> after verifying that
 	it does not exist.
 
 symref-delete::
-	Delete <ref> after verifying it exists with <old-target>, if given.
+	Delete <ref> after verifying that it exists with <old-target>, if given.
 
 symref-verify::
 	Verify symbolic <ref> against <old-target> but do not change it.

base-commit: cc01bad4a9f566cf4453c7edd6b433851b0835e2
-- 
2.47.0

