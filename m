Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3AC1DE3C5
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 06:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734417866; cv=none; b=W57xgJ38KX2AypbBdlB7Blu8Nugg+lEUsnJsfizyPaOBz6f7kmmZeCpLbEQItG/QYudHFmsohrrrhWep8al9KpXHGWepY5x0SmRTLwAzqgI4SsuXC3/plEMS/MN6rBaEaW4jjQLfVH9E+PRSlPw6nl+COK5fB7rGu4bxz/cwoV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734417866; c=relaxed/simple;
	bh=7ky9XOX+QYdS1sOceH9N7sswTSHY+E41+aklsPe93Qk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ITGjkwvkiwfSfDaVScxyn9heCQXqymC+3OjiPvsnf6SA/sFbxsgF981uHiPov4NCBqPAb0tKqQhEk9kDwrQSwHfhbtH7L5NAEN3Wgew/FlLUFYLD6zzNIRbQ4rG/xjxVdW7X07bBoLIs2kJ56hxsyLOPqPbYsQp1xlowKbLP4NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JWuJxDIm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rle+2Hyn; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JWuJxDIm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rle+2Hyn"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 6BD2B13801DA
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 01:44:23 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 17 Dec 2024 01:44:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734417863;
	 x=1734504263; bh=t94Benq85tji0zagDkUVlzLbPOSm4piOSi6MU23kS3E=; b=
	JWuJxDIm0NdrHy8cW2Oteyvu8DYc1tzGrXNlx1oHaUR4PjL1FzitGt8alGyYmG/A
	rjvoPanBSk7nEl8cyO9Tzmi/K34zeDfUFfmJo278F5pSgiGtHOZZSnJuqALlMu1Y
	2EzInaHQdkHoyk2gDee7x0nVN4mY6xyDZJbT6RrCllnQWN3BqIdVqOwXkYpAg1Zc
	TcjVuig4atzU/vE2CDENpi0phlVasgYBdyeBalNZEYlVZSPD8SzzvGFIoEYIOR2f
	Tu2/Lfh4t0sE8BXzkiMiAGkmK4Sg9OlU9rhkX/LazRYGVYFS/OKALaKEP3GESzuK
	9gzmYJvw73Lf8lN/7gAw/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734417863; x=
	1734504263; bh=t94Benq85tji0zagDkUVlzLbPOSm4piOSi6MU23kS3E=; b=r
	le+2Hyn9/84ZTTUeaGDBqt3AEk5wQN8Q6+wSuHdjCevCATyuKUgqeLTK0vub2JZE
	gh6MdeHivHnh+knKAul2sEho8KK5AhfgHTmisVQHG7FhCeqdUMeU8ENa4lfELKzn
	p46j3zdPowBf5Ubo+Jk8UQT/jk9Kx/kiGGNbl+RXSy1GPGvas5axxPur4yhkYvY8
	2vHHZ5fwJ+B1/WlQB3GtZQO/x3oK6Bj+NcnmpaDyyd5u5qb7DRLbs5nfqY0NgXPp
	dKEbP++c/eKZK2a1ycQ1vyFFTjP2hESsoCp0s0dWFeHFfpShyg/EbaVWkfvhtVMh
	6MA0a/9V4OQFhF01MAbZQ==
X-ME-Sender: <xms:xx1hZ0lcD4V46pLHCeJdcDgCYaxIDEMBfeimj_RsoIt1Kl7qIkvabQ>
    <xme:xx1hZz39tR3tdCLv7Cf8hdHHdfgWyR826TY9EDr-YhgRuQ7c8CQEyj_fMLB1loxtm
    UGu_A_PB2eFTJM_TQ>
X-ME-Received: <xmr:xx1hZyr5nXnqhnsuHmDYzwFgItMxwes6IH2z-GIEYQypqUax7b9BBSHgbY2DIreBSKHK_2he00Eb8GTMdt2N06HTkZnYmILqojrFN1mngBgPJqo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleeggddutddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:xx1hZwk_uhkLlAgDj7ChlTZWJphlQnlJjdhmK-kUoNtDM9dkxwyMNQ>
    <xmx:xx1hZy2xfm_KxKYSk5vLSsGw93mcLViZux_72xk883bfPUi53HMGlg>
    <xmx:xx1hZ3t6gigvmIIsrHHcW_bK1TKQbA6bIvg5mWuxx7znjOuvr2pZGQ>
    <xmx:xx1hZ-U5mn-7_Ltw9icF9jl5AWom0c-vVtfLbLylhhkGTvjaP1GGYA>
    <xmx:xx1hZ3_CzMw-0KSMuB_RVhuiqIkH_bM-unnfx5umlqQh1vji0STcbNP1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 17 Dec 2024 01:44:22 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0d313f2b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 17 Dec 2024 06:42:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 17 Dec 2024 07:43:57 +0100
Subject: [PATCH 10/14] resolve-undo: stop using `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-pks-use-the-repository-conversion-v1-10-0dba48bcc239@pks.im>
References: <20241217-pks-use-the-repository-conversion-v1-0-0dba48bcc239@pks.im>
In-Reply-To: <20241217-pks-use-the-repository-conversion-v1-0-0dba48bcc239@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Stop using `the_repository` in the "resolve-undo" subsystem by passing
in the hash algorithm when reading or writing resolve-undo information.

While we could trivially update the caller to pass in the hash algorithm
used by the index itself, we instead pass in `the_hash_algo`. This is
mostly done to stay consistent with the rest of the code in that file,
which isn't prepared to handle arbitrary repositories, either.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 read-cache.c   |  4 ++--
 resolve-undo.c | 14 +++++++-------
 resolve-undo.h |  6 ++++--
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 38c36caa7fef4d44da74c29e059839d88426df15..d54be2c17268728caf3e1e3ef94a5832d2cbfa60 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1754,7 +1754,7 @@ static int read_index_extension(struct index_state *istate,
 		istate->cache_tree = cache_tree_read(data, sz);
 		break;
 	case CACHE_EXT_RESOLVE_UNDO:
-		istate->resolve_undo = resolve_undo_read(data, sz);
+		istate->resolve_undo = resolve_undo_read(data, sz, the_hash_algo);
 		break;
 	case CACHE_EXT_LINK:
 		if (read_link_extension(istate, data, sz))
@@ -3033,7 +3033,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	    istate->resolve_undo) {
 		strbuf_reset(&sb);
 
-		resolve_undo_write(&sb, istate->resolve_undo);
+		resolve_undo_write(&sb, istate->resolve_undo, the_hash_algo);
 		err = write_index_ext_header(f, eoie_c, CACHE_EXT_RESOLVE_UNDO,
 					     sb.len) < 0;
 		hashwrite(f, sb.buf, sb.len);
diff --git a/resolve-undo.c b/resolve-undo.c
index b5a9dfb4acc51173b1d9b7b1b044a1fc611d3f74..52c45e5a49463656a48fc036749ee2749debaaac 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
@@ -34,7 +33,8 @@ void record_resolve_undo(struct index_state *istate, struct cache_entry *ce)
 	ui->mode[stage - 1] = ce->ce_mode;
 }
 
-void resolve_undo_write(struct strbuf *sb, struct string_list *resolve_undo)
+void resolve_undo_write(struct strbuf *sb, struct string_list *resolve_undo,
+			const struct git_hash_algo *algop)
 {
 	struct string_list_item *item;
 	for_each_string_list_item(item, resolve_undo) {
@@ -50,18 +50,19 @@ void resolve_undo_write(struct strbuf *sb, struct string_list *resolve_undo)
 		for (i = 0; i < 3; i++) {
 			if (!ui->mode[i])
 				continue;
-			strbuf_add(sb, ui->oid[i].hash, the_hash_algo->rawsz);
+			strbuf_add(sb, ui->oid[i].hash, algop->rawsz);
 		}
 	}
 }
 
-struct string_list *resolve_undo_read(const char *data, unsigned long size)
+struct string_list *resolve_undo_read(const char *data, unsigned long size,
+				      const struct git_hash_algo *algop)
 {
 	struct string_list *resolve_undo;
 	size_t len;
 	char *endptr;
 	int i;
-	const unsigned rawsz = the_hash_algo->rawsz;
+	const unsigned rawsz = algop->rawsz;
 
 	CALLOC_ARRAY(resolve_undo, 1);
 	resolve_undo->strdup_strings = 1;
@@ -96,8 +97,7 @@ struct string_list *resolve_undo_read(const char *data, unsigned long size)
 				continue;
 			if (size < rawsz)
 				goto error;
-			oidread(&ui->oid[i], (const unsigned char *)data,
-				the_repository->hash_algo);
+			oidread(&ui->oid[i], (const unsigned char *)data, algop);
 			size -= rawsz;
 			data += rawsz;
 		}
diff --git a/resolve-undo.h b/resolve-undo.h
index 89a32272620f2b9e93102039204c72c7886306b3..7ed11a1c59b8192df9bdc9bdad560e06d9f0b9e5 100644
--- a/resolve-undo.h
+++ b/resolve-undo.h
@@ -14,8 +14,10 @@ struct resolve_undo_info {
 };
 
 void record_resolve_undo(struct index_state *, struct cache_entry *);
-void resolve_undo_write(struct strbuf *, struct string_list *);
-struct string_list *resolve_undo_read(const char *, unsigned long);
+void resolve_undo_write(struct strbuf *, struct string_list *,
+			const struct git_hash_algo *algop);
+struct string_list *resolve_undo_read(const char *, unsigned long,
+				      const struct git_hash_algo *algop);
 void resolve_undo_clear_index(struct index_state *);
 int unmerge_index_entry(struct index_state *, const char *, struct resolve_undo_info *, unsigned);
 void unmerge_index(struct index_state *, const struct pathspec *, unsigned);

-- 
2.48.0.rc0.184.g0fc57dec57.dirty

