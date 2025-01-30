Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82811EBFE6
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 14:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738248261; cv=none; b=MD4r2YlO58IrbZxZwfxgeIpmdLX4vChvxCB/seXLAEZwMvQPwg6qChYSpl8GlFWziKDpexQfV/ZXe274JCH/55e7RuKEUpH2ITbHItwbQAZnCeQRA9OlZC5FXrqPhimnLrSONfv4QMEev7hrI+N4m+5XjGPy9Reg6Zw7jwNZ+hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738248261; c=relaxed/simple;
	bh=YVBQaxHA4TMLpJqu4HGQc+QBjeb4zXwHzie1EjaQr+g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QtejxVsACSaTHsXiOjNW78jgWMEpK23vvZt0KY4ibRhLHJp13XSOOm+iQtrP8rLW7fg72hesgn+BtnIpltZiyo3qNjhqq8O/yJCA4Ffs7iS6qGzbMxZ4qbGESd5tYpSmbkApLxB9kNHdsMYASxlGC4qJOy/2WfYyak8eCmtpens=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iugTVsjk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R9vuChUm; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iugTVsjk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R9vuChUm"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 03C7611400D8;
	Thu, 30 Jan 2025 09:44:19 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 30 Jan 2025 09:44:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738248259;
	 x=1738334659; bh=ebid+RuAPCLE6gF4yLXZxns8LPzVBwigFd19d2sNtns=; b=
	iugTVsjk6tb5RenqEAvn4pWYicBWYHBYGeKWH3l1TssBnKmsKBFSYO9l/VG26nCS
	KFcsGJvZwZicD46LWaX8WJ6jibHVmj7WBgesfX+gvBQMlzJE/O88dGq8AIPdkBp2
	wPBOVUGCiFOuyH1HViofO4y+Tc+ZCaY61+Ox4HhSvToAdM73CNobF3Y1GdAT5+QG
	B5dFbiZBXRyd6UpjSRgKJhQ2Xb2HOjbolRYQVHVvMrc4H4xjCCZo0qt8XLFBAtBv
	+o32pJ0EbzdoA+OX20rzlERELvbmH08qHX/8wCxeiN4d4elVv8ck+ux00F2sOGxR
	P9PSsDtV4EJ39s9LkYOklA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738248259; x=
	1738334659; bh=ebid+RuAPCLE6gF4yLXZxns8LPzVBwigFd19d2sNtns=; b=R
	9vuChUm4En8/5z9JlR0rcDgKxqKByOHYtE4wAEiLVZIVOSN6pHQK5GRLuthyAnm1
	5pl7vK6jVQ23Ru2K4EkRIBDsk7I1lfVUWh1YaKi7AT3QSXwSzcL6N7SsF78D0s38
	LshrEFXMeyVB8HWuKOKeT6wOjt3nsPkg9T+gFH7q/XTdI0opVHTdxceJnjnDKNiH
	wVXxoMjNJUM+M6XmHGRS1ItPxqbm+d9tQMRN8Jo4XCbHYJJEJQsTcrq2H5HxZTI5
	POlKsHdm+mWQvKI7IGzuQ1Q+lhc9wq1V0iBY7uIFjmns3b7ktleaDQKv7Cv5W0cb
	JktnOJl/P+gpJa3iI//iA==
X-ME-Sender: <xms:QpCbZ94cQSy5AxSDAySINS4ImXwFc5Tynz332G6i0aEgbeBEk6vgmw>
    <xme:QpCbZ67aRsAald0Dhw1SkmBq2K_H1nnb9vJsxLHunkROi98RQRBVFsFGo0H9VLSuM
    sILjsDvvyWpqDMdQA>
X-ME-Received: <xmr:QpCbZ0fIa_quMLO8H25vOMx5LztRxeB6NxHQ3mC4TXBbinDZrxTXAYhjrQ8SdQHjDMg1urSwq4i5qShQpf3V5UqSdisUjXxBN9sYrVIzhbo6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeitdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:QpCbZ2J8K-5qqgB5I3aJdQdaAi0nIs_RCz64FsY9Gs_ETip3RH-hLA>
    <xmx:QpCbZxLG31w4rfC48o1Lk6q2xWe410iPcNoCvDMIGycRAMPzanrOyw>
    <xmx:QpCbZ_wdukyZCUK096WvPfHiK8AgETmlQRKtikEQ3yujNqdAl-_o6Q>
    <xmx:QpCbZ9K9HIGzAdrdr-qwJ-Caq9CEphLrSPy3wy62nwkC9zAM683CfQ>
    <xmx:QpCbZ4XDQoARbprskcHJJan5bLbVwzOfSbq89pmkgmGKwURVTTgVnZRB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jan 2025 09:44:18 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dfb5d749 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 Jan 2025 14:44:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 30 Jan 2025 15:44:02 +0100
Subject: [PATCH v2 10/13] meson: prevent finding sed(1) in a loop
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250130-b4-pks-meson-improvements-v2-10-2f05581ffb44@pks.im>
References: <20250130-b4-pks-meson-improvements-v2-0-2f05581ffb44@pks.im>
In-Reply-To: <20250130-b4-pks-meson-improvements-v2-0-2f05581ffb44@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

We're searching for the sed(1) executable in a loop, which will make us
try to find it multiple times. Starting with the preceding commit we
already declare a variable for that program in the top-level build file.
Use it so that we only need to search for the program once.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/howto/meson.build | 2 +-
 meson.build                     | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/howto/meson.build b/Documentation/howto/meson.build
index c023c10416..92a08b13ee 100644
--- a/Documentation/howto/meson.build
+++ b/Documentation/howto/meson.build
@@ -41,7 +41,7 @@ custom_target(
 foreach howto : howto_sources
   howto_stripped = custom_target(
     command: [
-      find_program('sed'),
+      sed,
       '-e',
       '1,/^$/d',
       '@INPUT@',
diff --git a/meson.build b/meson.build
index 7180fd58fd..b5e8aca288 100644
--- a/meson.build
+++ b/meson.build
@@ -201,11 +201,12 @@ endif
 cygpath = find_program('cygpath', dirs: program_path, required: false)
 diff = find_program('diff', dirs: program_path)
 git = find_program('git', dirs: program_path, required: false)
+sed = find_program('sed', dirs: program_path)
 shell = find_program('sh', dirs: program_path)
 tar = find_program('tar', dirs: program_path)
 
 # Sanity-check that programs required for the build exist.
-foreach tool : ['cat', 'cut', 'grep', 'sed', 'sort', 'tr', 'uname']
+foreach tool : ['cat', 'cut', 'grep', 'sort', 'tr', 'uname']
   find_program(tool, dirs: program_path)
 endforeach
 

-- 
2.48.1.468.gbf5f394be8.dirty

