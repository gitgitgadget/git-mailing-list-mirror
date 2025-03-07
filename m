Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F290721B8EC
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 14:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741357152; cv=none; b=GyhtFNtDNhLWEhdyNNEUzOavgGCgiq/imZY5K+XNP+3W+YYwkRypoG+q+Fw4vMYTDT3huw/ZolK+QxaPOrJeCmW4B0ItktyF/tdqg+RYWbxmPqWk72L4P5IZkTSQCTK+vQxvYs5KuZMXPL/jP7NXFVTD8Xu4fTMOua3fVOef3qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741357152; c=relaxed/simple;
	bh=Y06ZJsenirOvU9kZ9ISpu/hzQiKBR14rqnNvWeJkJYA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LxDQCpYPliJGi01BQvBI4AbPMB4gyy8ij4+qku8o7jNYwsmgG6Uxv6+ytoaBpCvbTLcKelLv8Oru7Ek0izCyMkReifmyn20nr5pK4z8CT9OSlOab67Qc9XgVvbbgvIh9orWkNmXGwf0hP8Xq9zmQm3BWbXIBU2tcu5jsb/a2Y/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oaG1xNNM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LPRjogkr; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oaG1xNNM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LPRjogkr"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EF02725401C7;
	Fri,  7 Mar 2025 09:19:09 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 07 Mar 2025 09:19:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741357149;
	 x=1741443549; bh=jpBSH3DZ3AlfRc82KzjeqO+6RH1esmGSh/mj7elDb4E=; b=
	oaG1xNNMRYvUG4xsUTzdgyv8DgEUPpwJcot19tJT5LE8OiLQlm8tOAO8ZOJQD5QU
	yrQS1cVWh3tHVAqFgOgOQ94QMOXY37eB0EDXwXnQWWmjVvlzu/pNcB528bKQ+CFk
	QHLh/6YkMNQM6YTbL3usin+m1GL4nDuCRFJCwttIf79o/k/ApHiCWhp1E8VdFhSZ
	QIrkg1AjGp7KW/C5VSJWAu4XBvVqZgq21q7pnqV/YVCKg9++Q96cPG76LC0is91/
	85ofYrRCvxHKpZKsJLGMQEGQwd7A8mkjdR42zc1ymNv22pIfAtkzZcHdNipB/hKw
	vIqmY4P7hKlEC7xzlSK4zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741357149; x=
	1741443549; bh=jpBSH3DZ3AlfRc82KzjeqO+6RH1esmGSh/mj7elDb4E=; b=L
	PRjogkrgE9+YJhomKeG5eXlKxGYIEyjSQzWarYDzNwNRKq6Oi/8s202rVCREh0HH
	B26d9zOMTpVVXhQ9HrpfQF12gxPR47ivKkw3d/2u11QfrgRcYZAmBGn/hRV+4/Ip
	pGtE30h+vyGw0XAObjSSRyxxZ1zyKohuPpSn8ViILdxEG2XwpUpAIgGxyMVVcxr6
	fhocPbzUfxuravWbWLMG9mOiVWR+f+zG447QMwZJl5PCIMofV2PcNqeNkaGfn/tt
	QXH6ULfM1T4lbRn2TFWSKV8GsTqSxBsV1ohQlEPv+1+7cJi1lgEkzEjtvkBbTPlv
	2MafXZ8tLpXzqMdU6ERRA==
X-ME-Sender: <xms:XQDLZwHou8nR7LJI9BbL-4pwrZs5OqWX1zNZRuZU7QQEJWmS7TGwew>
    <xme:XQDLZ5XKVL6-ggMtS_KCZ-9IgxN0-mJ6v6cvrj1DU_aJVgFzPF1_adm8hgaudy9_i
    01nFWjsY72ymqko7w>
X-ME-Received: <xmr:XQDLZ6J32CYN8Fnt6juPC4JuQD_U26a_rIRQebEGr0RtvZ-SJjsqq-iCp8NAyGC8D8JH7p4o7ZVm2vPAVyUdp_SLDOCLuHl1__46CJWa43hF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddtkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:XQDLZyHo4Q87IMYJ650Ic7QDs1HSKkwo1jn6WBEBBb9K4TbnsaxicA>
    <xmx:XQDLZ2VAbZKFvriB17aDfla8pt8wIXab4PhTPbeXflXsaEwJoOK3BQ>
    <xmx:XQDLZ1PFYfQW4P1oHoNCw3cu_yMyXYlsJDeIKHKd4qg-Vc5CzjrCoQ>
    <xmx:XQDLZ90nCzrGYKtf3kRaVxc6BOjK7xpN089sN967Mr1T1ot8h7kkkA>
    <xmx:XQDLZ1Ri0DFLNnfVP1s0TPx9dpxCkMs3Vn63FAdlIjRSeEwYC6x8y4J9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 09:19:08 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d91af272 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Mar 2025 14:19:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 07 Mar 2025 15:19:04 +0100
Subject: [PATCH v3 11/12] hash: fix "-Wsign-compare" warnings
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-b4-pks-objects-without-the-repository-v3-11-7bccf408731e@pks.im>
References: <20250307-b4-pks-objects-without-the-repository-v3-0-7bccf408731e@pks.im>
In-Reply-To: <20250307-b4-pks-objects-without-the-repository-v3-0-7bccf408731e@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

There are a couple of trivial "-Wsign-compare" warnings in "hash.c". Fix
them.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 hash.c | 12 ++++--------
 hash.h |  2 +-
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/hash.c b/hash.c
index dd5ac9d0eb2..4d9f98f72c2 100644
--- a/hash.c
+++ b/hash.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "hash.h"
@@ -246,10 +245,9 @@ const char *empty_tree_oid_hex(const struct git_hash_algo *algop)
 
 int hash_algo_by_name(const char *name)
 {
-	int i;
 	if (!name)
 		return GIT_HASH_UNKNOWN;
-	for (i = 1; i < GIT_HASH_NALGOS; i++)
+	for (size_t i = 1; i < GIT_HASH_NALGOS; i++)
 		if (!strcmp(name, hash_algos[i].name))
 			return i;
 	return GIT_HASH_UNKNOWN;
@@ -257,17 +255,15 @@ int hash_algo_by_name(const char *name)
 
 int hash_algo_by_id(uint32_t format_id)
 {
-	int i;
-	for (i = 1; i < GIT_HASH_NALGOS; i++)
+	for (size_t i = 1; i < GIT_HASH_NALGOS; i++)
 		if (format_id == hash_algos[i].format_id)
 			return i;
 	return GIT_HASH_UNKNOWN;
 }
 
-int hash_algo_by_length(int len)
+int hash_algo_by_length(size_t len)
 {
-	int i;
-	for (i = 1; i < GIT_HASH_NALGOS; i++)
+	for (size_t i = 1; i < GIT_HASH_NALGOS; i++)
 		if (len == hash_algos[i].rawsz)
 			return i;
 	return GIT_HASH_UNKNOWN;
diff --git a/hash.h b/hash.h
index 4367acfec50..55d67ed83f3 100644
--- a/hash.h
+++ b/hash.h
@@ -325,7 +325,7 @@ int hash_algo_by_name(const char *name);
 /* Identical, except based on the format ID. */
 int hash_algo_by_id(uint32_t format_id);
 /* Identical, except based on the length. */
-int hash_algo_by_length(int len);
+int hash_algo_by_length(size_t len);
 /* Identical, except for a pointer to struct git_hash_algo. */
 static inline int hash_algo_by_ptr(const struct git_hash_algo *p)
 {

-- 
2.49.0.rc1.455.g4cd33545ba.dirty

