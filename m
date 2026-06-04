Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9F841C302
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 11:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780572354; cv=none; b=gM2AMD5zbFI7rKV7CahIHGbDOqicTbAYw6R9aQlc6Gn7jTqfUdui23ubbkNk80l4bu3HyfjoDygPEy9ErMGAmdcW+fIi4uJ/5ZLdLB7VFZggwvUVC8iSwLBWrSFTBxEJsYLNOkp/vUJ/Cn4jSgX//OdRwV45HxcsUKrV5C3zVOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780572354; c=relaxed/simple;
	bh=rGRnqbHu/ROOSPoZl2J2KNnO/3KxceShLIDLR7Gfy2c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F79LPQOP14gcTwip4B3h57fMgO24C/r92jKEQIC52dJ7Mbw/cxR6apqHvsp2tMatGyi9uZ13p65pRDjw5/YLpwT99LX2NReixOyNISzRQ0JBBhUI3azqVkwy32XRPcFAtOxFNY4JWT4RNzDtO5g22GXOMX34Vj8t1e5V1nf9lNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DBc+kEsc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gjGv1kW7; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DBc+kEsc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gjGv1kW7"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 765C7EC00CA
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 07:25:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 04 Jun 2026 07:25:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780572352;
	 x=1780658752; bh=iQfUdaX+I86mbG6Tl6sfIclMd4x8k/ojMvRzSVbfbxw=; b=
	DBc+kEscv4/jVVwQ//3qOi8X1toc3Awboa0WxKKlv7599iQ+fEUlmwdygttOh6Uu
	u4mWRDCZm362onCxDyTRZ5wVFsXz81/G/SNic4PNTCkKlY3fixh1ECQegMA5r+xl
	lUYqxXw2Q6vC3QQdUEUEgU4fm59T9WaoPiF05X3I81Jevwx6F2EvpPkpBtqho92I
	yt9xVJYPTF98SgMY1rUUI6wwJJIEk5CGIls8cOxafyWIhGTzU2iMeq1tRrHsq4Mj
	Mwurrl3WWv0mZA+jFBpEVFm55/ItwzJoioTKkqFAWL2sD9acfwG0M0e0znMNU6dx
	6CNQNNRWfu6K/efZm/naPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780572352; x=
	1780658752; bh=iQfUdaX+I86mbG6Tl6sfIclMd4x8k/ojMvRzSVbfbxw=; b=g
	jGv1kW7Oy0G7E+ZicZX/RjChdyX/aZpCASJRt0uWGSOHPZ6erwVagsDP5yzBCd4r
	aM0JjjKs86RwJmU4bfJrEYVPddlo10UKr2XRp/pCYy7lvNVS/GYsit/FFg01TTEI
	zoFcr4SZKdvePJguDMEwo5T/o+4zopKl/XGqdHesOJHGCEfSdJPN7IUBonTxW0hN
	MGWrhot3dRuUt9Yfeytgov0CpCStkCOB1ME7sGAvAB/45PRrLQdQtaawO5Y/rVVA
	ku3Vrguky7srK5p64eU7pSLW5h/oHG3AR1qd81ElDY4VYgMZnBCj1MkosGH4WtCK
	ddCt0B240vWTpBPq24zPQ==
X-ME-Sender: <xms:wGAhajCmf24byXXM580BtZazbspdysHKBFR9MvjTecbsno7DCoN5jw>
    <xme:wGAhagf3iDYID8rMxAQaSyaMI_RWvcq_iphvJpP994Kj-L904C_ZKw5YQUTi8RMWR
    947u-pf9d6voMYAUj8KUr4Ye0LjVzxUIZtT7eLj44J3jtD3uiw>
X-ME-Received: <xmr:wGAhakPj144xMzrdHJXpfFWZbrCqENyInXRfTX0NXhknE-ItcwRSHVNpBNftEfTIUVmLGfhZl8MZ-lkaSdFN-gRZgzhbmjVm-visjmfMkc0>
X-ME-Proxy-Cause: dmFkZTEgCyScvAHJZtwScmArpd3MPVD65pRFEMle7OxDyvGrBgzCBJpJZt/i/e/55qfMB2
    OZ+A4mOijyyVR7BQZ8gApb6Lys3WwA/DRBZO1Z6gq18/NjHv9k/YmqxGulaGbdjpGbGIe8
    TR7oy8jORNRJjZkYPAiPkwIOcJg76HwsAVLzInKh/aA4zWo5I7a3yFoBSrwplR1bXvqyzb
    7cwWjx66LW0j/HaZcKLdC3JWI1rUB6+uoj5Ia8HwsvfkXaZepnJEy9rr0yADWxKwm6t/hJ
    h4TWvBlU4kw/rB+rZbM4p/EdiFJ50OcReCBplYqL1Hq7W/DA0KsY8Jaj3WslUYFsjaCmlf
    wbxhK8YbQ54KNJF5x8PTymzsRIQQGOMBioaYdWhksOvnMtz1F04qTv4Z3NUOQ1ifhM46iV
    1odM6zRTHbDXNHEaIsR3eKv0PMWY44jn/92yDNdL4+F4zjkvNppWhlwefB/BdLSjrl0HEZ
    oQMGLBa9HRWtHJSbZZdXEi5SW8XAGrXLeHqASJzj2GVn8wPh432f89qXJYW0qKlTzCu0v+
    HxqLMMXoKBn+kUv5iKdiMBornRA92CULjTaZAojzIvV542y/e9YfJnrht5Nk4zdQdfoikK
    lPCRXMTH3z8pQNYDMA71qxuk5lA2vypNmMYQLCYv7Oexgq5DudeMFE0g0DUw
X-ME-Proxy: <xmx:wGAhaq52U8wOcGD2BvDQLVOibtbJt5Fi-ljTrhLkNquwbJ4hZUwzKw>
    <xmx:wGAhaoLRtukHtUdCtRQ7k1AeB7C71uWX3Fqv95p8Zzbxb7Lq3xIWMg>
    <xmx:wGAhakftlGS3pKeN67xTKv3f-5Za77CRBctQ_U8jCE1BgqOJAU5iQw>
    <xmx:wGAharfaCf_iXLR9MSBRdWBNbYav44yIz956U2baogN1ZJmIbt9Pbg>
    <xmx:wGAhaqDN6vCpZFfzmF4OTPLEbrq7wCCeiRvLzm6NPedPrzN7RnNB4UHn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 4 Jun 2026 07:25:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3a3019dd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 4 Jun 2026 11:25:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 04 Jun 2026 13:25:32 +0200
Subject: [PATCH 05/16] odb/source-packed: wire up `close()` callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-pks-odb-source-packed-v1-5-2e7ab31b4b5c@pks.im>
References: <20260604-pks-odb-source-packed-v1-0-2e7ab31b4b5c@pks.im>
In-Reply-To: <20260604-pks-odb-source-packed-v1-0-2e7ab31b4b5c@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Wire up a new `close()` callback for the packed source and call it from
the "files" source via the generic `odb_source_close()` interface.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c  |  2 +-
 odb/source-packed.c | 16 ++++++++++++++++
 packfile.c          | 12 ------------
 packfile.h          |  6 ------
 4 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index 3608808e7c..9b0fa9ccdc 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -38,7 +38,7 @@ static void odb_source_files_close(struct odb_source *source)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
 	odb_source_close(&files->loose->base);
-	packfile_store_close(files->packed);
+	odb_source_close(&files->packed->base);
 }
 
 static void odb_source_files_reprepare(struct odb_source *source)
diff --git a/odb/source-packed.c b/odb/source-packed.c
index f81a990cbd..74805be1dd 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "chdir-notify.h"
+#include "midx.h"
 #include "odb/source-packed.h"
 #include "packfile.h"
 
@@ -16,6 +17,20 @@ static void odb_source_packed_reparent(const char *name UNUSED,
 	packed->base.path = path;
 }
 
+static void odb_source_packed_close(struct odb_source *source)
+{
+	struct odb_source_packed *packed = odb_source_packed_downcast(source);
+
+	for (struct packfile_list_entry *e = packed->packs.head; e; e = e->next) {
+		if (e->pack->do_not_close)
+			BUG("want to close pack marked 'do-not-close'");
+		close_pack(e->pack);
+	}
+	if (packed->midx)
+		close_midx(packed->midx);
+	packed->midx = NULL;
+}
+
 static void odb_source_packed_free(struct odb_source *source)
 {
 	struct odb_source_packed *packed = odb_source_packed_downcast(source);
@@ -42,6 +57,7 @@ struct odb_source_packed *odb_source_packed_new(struct odb_source_files *parent)
 	strmap_init(&packed->packs_by_path);
 
 	packed->base.free = odb_source_packed_free;
+	packed->base.close = odb_source_packed_close;
 
 	if (!is_absolute_path(parent->base.path))
 		chdir_notify_register(NULL, odb_source_packed_reparent, packed);
diff --git a/packfile.c b/packfile.c
index 8fefc4358e..3cff3b8ffa 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2832,18 +2832,6 @@ int parse_pack_header_option(const char *in, unsigned char *out, unsigned int *l
 	return 0;
 }
 
-void packfile_store_close(struct odb_source_packed *store)
-{
-	for (struct packfile_list_entry *e = store->packs.head; e; e = e->next) {
-		if (e->pack->do_not_close)
-			BUG("want to close pack marked 'do-not-close'");
-		close_pack(e->pack);
-	}
-	if (store->midx)
-		close_midx(store->midx);
-	store->midx = NULL;
-}
-
 struct odb_packed_read_stream {
 	struct odb_read_stream base;
 	struct packed_git *pack;
diff --git a/packfile.h b/packfile.h
index d6814b564e..23af47f0c1 100644
--- a/packfile.h
+++ b/packfile.h
@@ -67,12 +67,6 @@ void packfile_list_append(struct packfile_list *list, struct packed_git *pack);
 struct packed_git *packfile_list_find_oid(struct packfile_list_entry *packs,
 					  const struct object_id *oid);
 
-/*
- * Close all packfiles associated with this store. The packfiles won't be
- * free'd, so they can be re-opened at a later point in time.
- */
-void packfile_store_close(struct odb_source_packed *store);
-
 /*
  * Prepare the packfile store by loading packfiles and multi-pack indices for
  * all alternates. This becomes a no-op if the store is already prepared.

-- 
2.54.0.1064.gd145956f57.dirty

