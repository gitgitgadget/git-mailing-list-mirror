Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EB7281371
	for <git@vger.kernel.org>; Tue,  6 May 2025 14:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746540767; cv=none; b=Ce9ywEbqXJhd76PI7XT5AqVDiFYsZlQ+uFDgQZun9J1LjaKcwFdUIBK8DLNnvvbn1duf4y/jtK/3EwLEx4gHpwm16cAX0wJP5sFZuG+2E7WImmqE51d3J5GT9cMFjKDiQQKHl56+5cQxaCaDYmeDhQICJpJ5vV6MLmrUrkHEHus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746540767; c=relaxed/simple;
	bh=JJbKVFKeov8mYKrpjEPVlujXublQShE1CwJBnJRAM3c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ED1C+giWcpDv52gXElvJeI3giQ/4N5w+cPtKQ0hygN39RocKHqb4ocLW4GC9XJThtsJvK9mwtL+rebe61BaEJ8IpKjSltS720SFMufMemX2g4p3mc26kIqrY4xBDwkpAEG4/GILRxdRcRTnlf73YlubeFjficQJ7RsWsyfX79cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BiPPBLeh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NlbXPwsY; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BiPPBLeh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NlbXPwsY"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id D20261380EF8
	for <git@vger.kernel.org>; Tue,  6 May 2025 10:12:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 06 May 2025 10:12:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746540764;
	 x=1746627164; bh=NsRj8r8J6Xsh1G4j/taG5m97OYFDVPgJE8HDJP92bgg=; b=
	BiPPBLehJhH2djGG+cj1lszPF0+dpbSyD75iJTniijVP15UHVSAgyqioaCSqu9UK
	ZqeJfg0eBhxdipfGf4iwCDiw3t9cxjSi7EExYTcHfz5FhEXw/ALcZG5yUo0HonKS
	4DT6n1xQU7uirytLiN+Bg8rcplkjFiwTRUo8SgUb1Eeo12Ruc4rYKsJ6DHtkKxY1
	kh9gMrCDN0sisV2Rs27Z/OdXj9P5WHY/nu2vUCEbNaxQW9ENyjrtMCdFG0BPqRoE
	l9QbejAh2JoTKXpqfaFuoq+HJ7PQNCEPYe+EACv29hd3PDHpEUuas2LXgxiveSMD
	iLLblxqSZIuZyqZSvPr4mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746540764; x=
	1746627164; bh=NsRj8r8J6Xsh1G4j/taG5m97OYFDVPgJE8HDJP92bgg=; b=N
	lbXPwsY73ZXbxZOCbFicH0PhPme7xPTPDBY89u0lt/4mrv5nBwemnmQzTjLLzBQp
	LqlFkBgGC85SAVN6s679Z2qMy2mKZXPs1p/v3eVPuHUUCaiOdVh3PmgzXad2DVac
	lg8+ytnqqEH0fDZSIT5Rgsx8cTAg0SNYLi6fyiY50vqDQ9YMr4SB/kQMfMN67QRM
	3bl7QIXZPTfwkJIhyN0/cKk2SyRSSkvh0NJsSBw661teN8n9xu/YlK3+gSegFA8A
	wuTjXRbiz+TJk6f/2IrpUNjJ1whA88oI/UdGqcx6DZ4aG8rGtlRfYr18rnLbFUc+
	/Ov5EHzR30iezZiBl6Ujw==
X-ME-Sender: <xms:3BgaaIibRaBL3ypc8M1sDcX9-vYlockqzidxjupsanv59zgaOHr4Iw>
    <xme:3BgaaBCFtWBBCVSrakDZlZpwFTCo2x4mcEVLwfjlZJfE4uj05Bp-FtXsFf_4ISa5g
    wiEVDAKI1u0V2pfFw>
X-ME-Received: <xmr:3BgaaAFg9sQYrsmXpSJYRQaTLArwSobfqaBU48b-YOuSsVAKgb6_U0X-nVsdjOMPJ1PZ--nPRoxHde35QGBVTX_UmrJ8ViUnnGgHGyLK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeegudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepfefgve
    dtvedufedutedugffhjefgleegheehffelgfegffehieegvdfgfeehuefgnecuffhomhgr
    ihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:3BgaaJQy99pla-iDcF3k_xsqa-sbIyoqEeVAdalz8ZZGVuib2HWWXw>
    <xmx:3BgaaFxFZYeLcHLvOq1whSw38eLSQXI1wW2A_pBlTpMGUj_zXcB1PQ>
    <xmx:3BgaaH7MJdz4C2UkuLrVk7tMhZOHqbS3jeJjiNjqR2eGUZOIuXT60g>
    <xmx:3BgaaCzXluzyj5xlIifLE2mMROWwDUQPxUCyeRn-y8b_SfrVZz01nA>
    <xmx:3BgaaFcgTg_s-J4aAPe0eA5I-B8vWOOZH7AoMQDjHDf0FtYuGJPSbFLy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 6 May 2025 10:12:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fb2df491 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 6 May 2025 14:12:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 06 May 2025 16:12:36 +0200
Subject: [PATCH 03/10] contrib: remove remote-helper stubs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250506-pks-contrib-spring-cleanup-v1-3-e6d5ddd79a72@pks.im>
References: <20250506-pks-contrib-spring-cleanup-v1-0-e6d5ddd79a72@pks.im>
In-Reply-To: <20250506-pks-contrib-spring-cleanup-v1-0-e6d5ddd79a72@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The "remote-helpers" directory contains two remote helper scripts for
Mercurial and Bazaar. These scripts have since been converted into stubs
in b2c851a8e67 (Revert "Merge branch 'jc/graduate-remote-hg-bzr' (early
part)", 2014-05-20) as the helpers have been moved into their own
upstream projects [1][2].

Given that these stubs have been created more than a decade ago it is
very unlikely that anybody still tries to use them. Remove them.

[1]: https://github.com/felipec/git-remote-bzr
[1]: https://github.com/felipec/git-remote-hg

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 contrib/remote-helpers/README         | 15 ---------------
 contrib/remote-helpers/git-remote-bzr | 11 -----------
 contrib/remote-helpers/git-remote-hg  | 11 -----------
 3 files changed, 37 deletions(-)

diff --git a/contrib/remote-helpers/README b/contrib/remote-helpers/README
deleted file mode 100644
index ac72332517a..00000000000
--- a/contrib/remote-helpers/README
+++ /dev/null
@@ -1,15 +0,0 @@
-The remote-helper bridges to access data stored in Mercurial and
-Bazaar are maintained outside the git.git tree in the repositories
-of their primary author:
-
-    https://github.com/felipec/git-remote-hg (for Mercurial)
-    https://github.com/felipec/git-remote-bzr (for Bazaar)
-
-You can pick a directory on your $PATH and download them from these
-repositories, e.g.:
-
-  $ wget -O $HOME/bin/git-remote-hg \
-    https://raw.github.com/felipec/git-remote-hg/master/git-remote-hg
-  $ wget -O $HOME/bin/git-remote-bzr \
-    https://raw.github.com/felipec/git-remote-bzr/master/git-remote-bzr
-  $ chmod +x $HOME/bin/git-remote-hg $HOME/bin/git-remote-bzr
diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
deleted file mode 100755
index 1c3d87f8619..00000000000
--- a/contrib/remote-helpers/git-remote-bzr
+++ /dev/null
@@ -1,11 +0,0 @@
-#!/bin/sh
-
-cat >&2 <<'EOT'
-WARNING: git-remote-bzr is now maintained independently.
-WARNING: For more information visit https://github.com/felipec/git-remote-bzr
-WARNING:
-WARNING: You can pick a directory on your $PATH and download it, e.g.:
-WARNING:   $ wget -O $HOME/bin/git-remote-bzr \
-WARNING:     https://raw.github.com/felipec/git-remote-bzr/master/git-remote-bzr
-WARNING:   $ chmod +x $HOME/bin/git-remote-bzr
-EOT
diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
deleted file mode 100755
index 8e9188364c6..00000000000
--- a/contrib/remote-helpers/git-remote-hg
+++ /dev/null
@@ -1,11 +0,0 @@
-#!/bin/sh
-
-cat >&2 <<'EOT'
-WARNING: git-remote-hg is now maintained independently.
-WARNING: For more information visit https://github.com/felipec/git-remote-hg
-WARNING:
-WARNING: You can pick a directory on your $PATH and download it, e.g.:
-WARNING:   $ wget -O $HOME/bin/git-remote-hg \
-WARNING:     https://raw.github.com/felipec/git-remote-hg/master/git-remote-hg
-WARNING:   $ chmod +x $HOME/bin/git-remote-hg
-EOT

-- 
2.49.0.1045.g170613ef41.dirty

