Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98D72063F7
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 12:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734697394; cv=none; b=koRezb1+s+eGLYBqPIibK20ivyIBWl3ko/Eq2TYP/ABTS8Fmbp4hr9yOHOahWqsVbGzQZLUplSuukj4se572yr3AWMQey/zFPESUmuN/AjlYgXFZbc1C2HKuXOKHY0I1hBduitEEB39jxya/KM0Wh29lpENbBvImXfiJyHS02+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734697394; c=relaxed/simple;
	bh=qlcr1aexgNWPKNRgEroH12nFd6axCzrmVs2ziB6pU28=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BjSo/DzZFDCPsdZmf8fXjfyBwinFKc04CRwHoCrDbZ9eekF29EfmNvRi4n0cY5yg4B3PFyZIxv5IhQnaZU1ddnUKy1cZZyachPbd6YU5i0khBo0AlOjMJrXpQHfz1qwDdqtvpxZGklR02B2jxSJEcaqgsoKEwN5W+n6Oiweg6m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SSfwE5eU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wkx5Uxk7; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SSfwE5eU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wkx5Uxk7"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id B2F051380232;
	Fri, 20 Dec 2024 07:23:11 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 20 Dec 2024 07:23:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734697391;
	 x=1734783791; bh=WziJjMIxdX/teIpw2Otk8BIHCq+qz2JUdoKl0gFTuaY=; b=
	SSfwE5eUEQyYNN5IPEQ3nyeScC9U317mLq/uelBlbQmgCiJQMS0YdAI/Ec4CRmNV
	2AtT6PisiBWtTOYmkaErHCkhC4CxRCBqGYyslZ/I7XGa8A8nRHe6Po0SCvzxcsZA
	eZwWH3nx1SnOgQwjyk8GpCUOkO2K4rjGEBgN6YqTrJ8sgxq5Z1Tno4zfhksyjZ/6
	rF16z5u4Y3LhvV7F80nIR+3+Hl8ANLCH9SReAQ8ctK/XQXR49Z9MxLkYwZOfypB6
	6WOEvadiANT9iLetyJaIsynwihiZ7aczSI5J0H/qeVVl/731m53wIG2YF/XL51nC
	844kneTkE4dw7Lunb729oQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734697391; x=
	1734783791; bh=WziJjMIxdX/teIpw2Otk8BIHCq+qz2JUdoKl0gFTuaY=; b=W
	kx5Uxk7JvSInpEnegVRfFkBsP/NEK49TVZH0TPIYmYcItG5CNmt/DI0SrcdeiH/Z
	pEOVEkFb3J7NaYnzJNuP7en25AiTByPlnXIn4h69549o90mFI69nb+uoEOlA0Yj1
	yIwikObZ+Q9NsEpZUTwxNYduBPcRRPZGOVGRDzyOvrtkDeSlh8SyKZyCHebnZSzK
	REQIK/OFt0YeuUYF0PDgkWkiGoL5fSclCI69dtbgUN477jy/Ve4HZEHxQRyCkPA5
	oAVpVp9xG2oK+sTT8QBZof4IEgItkHeCL5n+JhiSWDCgPiH4PHvrI45zlzU7XN60
	IcWgjwhcKHFtRYIFHtY9w==
X-ME-Sender: <xms:r2FlZxo_VTx37BG5nRB9UEeLT18KyXhTFFdwe3nDJeI5ZTdNxMtnNA>
    <xme:r2FlZzpW60Z4zVuPbFH8sv_B6DSw_-NfrsxTtTHUeXOZpMchsvUTFfmEp1tmijhbR
    xgYCb7yLTheZjrGFg>
X-ME-Received: <xmr:r2FlZ-MqhGKDoNW605h6WF3Wl5Q5iQS422eNmhTBX60ldhHp8wJdLmauMyxSi2NdO0I-1QhhvetLH2Oz5ZviBxa0lxmixWoEFTRyMAr43kkmijQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtvddgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepudelvedtje
    duleekueetkedvhfeuuddvkeeugeelieekveejtefgfeeivedttdehnecuffhomhgrihhn
    pehrsgdrihhnpdgtohhnfhdrihhnnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshhpvggt
    thhrrghlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:r2FlZ86g9ViJYW6VFd3uNQiNT_rEXAUsTz1McAqzYvIyqNKdTpCDCg>
    <xmx:r2FlZw5QOq06Sq5PSVm_fxmvYF9nT1VCurLm-JQUZcVT891Ajf846g>
    <xmx:r2FlZ0hGj5cBkFl9n0FHmE45-_EQL6qVmNiKUoq8CDKTB7Pyzaijow>
    <xmx:r2FlZy4uI-4p-81uPx62VvqhNi_WNW5Etw4mjjl3uBHAG9WkzqJOoA>
    <xmx:r2FlZ70Uzx8gqNEOpxSLYTmkYK9zK4UlNtCpozKx5bEuIhtfjrTohGKD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Dec 2024 07:23:10 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3526b290 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Dec 2024 12:21:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Dec 2024 13:22:48 +0100
Subject: [PATCH v2 4/5] Makefile: respect build info declared in
 "config.mak"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-b4-pks-git-version-via-environment-v2-4-f1457a5e8c38@pks.im>
References: <20241220-b4-pks-git-version-via-environment-v2-0-f1457a5e8c38@pks.im>
In-Reply-To: <20241220-b4-pks-git-version-via-environment-v2-0-f1457a5e8c38@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Kyle Lippincott <spectral@google.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

In preceding commits we fixed that build info set via e.g. `make
GIT_VERSION=foo` didn't get propagated to GIT-VERSION-GEN. Similarly
though, setting build info via "config.mak" does not work anymore either
because the variables are only declared as Makefile variables and thus
aren't accessible by the script.

Fix the issue by exporting those variables via "shared.mak". This also
allows us to deduplicate the export of GIT_USER_AGENT.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/Makefile | 4 ++--
 Makefile               | 2 +-
 shared.mak             | 7 +++++++
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index cee88dbda66265141b87d5e5c16bf86df22fa4ef..4c652dfa14f6af2c1374e2f83d3311b36dd297c4 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -211,10 +211,10 @@ XMLTO_EXTRA += --skip-validation
 XMLTO_EXTRA += -x manpage.xsl
 
 asciidoctor-extensions.rb: asciidoctor-extensions.rb.in FORCE
-	$(QUIET_GEN)GIT_USER_AGENT="$(GIT_USER_AGENT)" $(SHELL_PATH) ../GIT-VERSION-GEN "$(shell pwd)/.." $< $@
+	$(QUIET_GEN)$(SHELL_PATH) ../GIT-VERSION-GEN "$(shell pwd)/.." $< $@
 else
 asciidoc.conf: asciidoc.conf.in FORCE
-	$(QUIET_GEN)GIT_USER_AGENT="$(GIT_USER_AGENT)" $(SHELL_PATH) ../GIT-VERSION-GEN "$(shell pwd)/.." $< $@
+	$(QUIET_GEN)$(SHELL_PATH) ../GIT-VERSION-GEN "$(shell pwd)/.." $< $@
 endif
 
 ASCIIDOC_DEPS += docinfo.html
diff --git a/Makefile b/Makefile
index 695a9d9765daf864605002d572129bae7a8c4e40..788f6ee1721850e75f19fe2181f578ad2e783043 100644
--- a/Makefile
+++ b/Makefile
@@ -2512,7 +2512,7 @@ pager.sp pager.s pager.o: EXTRA_CPPFLAGS = \
 	-DPAGER_ENV='$(PAGER_ENV_CQ_SQ)'
 
 version-def.h: version-def.h.in GIT-VERSION-GEN GIT-VERSION-FILE GIT-USER-AGENT
-	$(QUIET_GEN)GIT_USER_AGENT="$(GIT_USER_AGENT)" $(SHELL_PATH) ./GIT-VERSION-GEN "$(shell pwd)" $< $@
+	$(QUIET_GEN)$(SHELL_PATH) ./GIT-VERSION-GEN "$(shell pwd)" $< $@
 
 version.sp version.s version.o: version-def.h
 
diff --git a/shared.mak b/shared.mak
index 29bebd30d8acbce9f50661cef48ecdbae1e41f5a..8cd132b5a03b85d4eabc3819eb3d1f64d39afa47 100644
--- a/shared.mak
+++ b/shared.mak
@@ -116,3 +116,10 @@ endef
 define libpath_template
 -L$(1) $(if $(filter-out -L,$(CC_LD_DYNPATH)),$(CC_LD_DYNPATH)$(1))
 endef
+
+# Export build information so that variables defined in config.mak can be read
+# by GIT-VERSION-GEN.
+export GIT_BUILT_FROM_COMMIT
+export GIT_DATE
+export GIT_USER_AGENT
+export GIT_VERSION

-- 
2.48.0.rc0.184.g0fc57dec57.dirty

