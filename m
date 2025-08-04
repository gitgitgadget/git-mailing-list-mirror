Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA2C1EA7CF
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 09:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754300442; cv=none; b=pUeImft5Op+huIlj72voM5f/iU2Tng27S0Fe1qAemxIe8Yuxyo1o9FZxrdy3H1tb0iq7VVHWjg0GcXGLaSUzHBU9VI7ytlsH3duTOg5rQqxfMpvRD3ZhpfqgUBaHLxl25ZNzucPYH+bP45kTZ/vsv2duu/1+nw2iNJK5lsR86lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754300442; c=relaxed/simple;
	bh=YwoWHjUaSISqUZfjbDwmPCMWhaKXJeE2qlr9wInmGHk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hrt0bsULuZ16+7i62SvsyhRvIbVCsXUnEINbSyDsYlMcEoqSWLBeV2r1045GwiyfeQYaH/KhWinKO5tLc4hcEdjJnsWFKyqpvrMVdOJA7+3qzZsM1cmq6OvCnGhBp2Qqhx7R7LCDLjw7rdsIbNRF3DjqYxITF+3pSFmZSCmne5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NL6jQCuX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j7UoxkKX; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NL6jQCuX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j7UoxkKX"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 5B5041D000F0;
	Mon,  4 Aug 2025 05:40:40 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 04 Aug 2025 05:40:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754300440;
	 x=1754386840; bh=blTH7rOHOOxXv13GzyGn/0YOTsPQHZJ/bY19yxY42Hs=; b=
	NL6jQCuX6hIAiGQup0UFdX1CaJbMarsjj0n8OiJMeYPH7wMQjaPBZtPa0jge/lTk
	TJ/iYbsiyW/s0FqHdhMKU9P+mRPLsAaKEHM74bNO+hTSWV81RnVXrCpLCTnY2yev
	uhb2wOwFuJeEhbAjBM5b4zFEF84++9DRKqRmeWMxI2/AlFFbUZw0kr3XPYW/x6KE
	koSbHAPtmPotG0rXnWgiGBVvhpJUP9OoxmWNUXS9jHC49lh2IIxHM+4wGoKB9u7u
	rCnttlpDrqVhuYZegq7yT4kteyzVxn/5/8do+H64fLAVCs//6WqRmAUkLYGNRky1
	BKwucyhZKR6kErsXvNu1BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754300440; x=
	1754386840; bh=blTH7rOHOOxXv13GzyGn/0YOTsPQHZJ/bY19yxY42Hs=; b=j
	7UoxkKXRulDzH5xjxeH034BtiiHSdXWzBrNgeWuOzbV/39DsJ0ys9Dnir1rtOp/a
	AOnlC36eI9tpVutAJ4HKmASv2Bk7WyWlMUhVsGd1zK615sCkJOcNnGuAfyrhDj9o
	szi7WOGjdk0pAmp0UmQE0J85+tysrCDsUGRn0w97pt5NpnlS+QLQUQ24k8RUzUPq
	2yiyYxgse9hxK7A3tUmYfpGSTwworVsg/kJOnJ6+i2hVAHDD2Pa356RcROoyYLjM
	8OqpVI0Y/F7hGh5o634lPgsknjIFgL1+ecE1S4WUzev2xVhy55gc/ABDAPGjRY3w
	Mj3alHo7Nk2/F4iEpUt6A==
X-ME-Sender: <xms:F4CQaO0VsKN3xz9xDLbIuW0EzC21RYw2fyUTmKwV8PieAT8bSOV7AA>
    <xme:F4CQaBQ6cdaCIWfrpUeOEBDO7SbXlfYm-CcMRNTrWT7BRQyFx65gfFUexhE1MEAxu
    pSfo2X6NHed18U1_g>
X-ME-Received: <xmr:F4CQaIv7rRJ2R0jvnpTin1hohn6hJL5SsgIU3bpPWtUBmXm2R_wW6iSJdn39cn9f4ZwuyoL5hMDVxEXIlvCXwgPxIfqmLsoKtnBojqyzY2k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudduleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhunhhshh
    hinhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:F4CQaOZ5_ZuiBTpnwLGloz2fhnZo55woosT6TvtitbS-mLZo3scMJw>
    <xmx:F4CQaFt2EZiUEjd6sX2zR-8AyKUDe_rLGguw8d7ZpYb2KP3VVYm2Vw>
    <xmx:F4CQaIHZPVGglmgfCu4Ni8eY3cnFBxpWPDh5I61aVx8yxSGqOM5SVA>
    <xmx:F4CQaIx5fTtWFQE7Y0Y8f0v3LGWeBwlAiR4CRInn2lQedhYXU-hR0w>
    <xmx:GICQaMM9Q0CR12faOt9j1X1yrD-qbfoMqkelQDd-e4mlisB-a30h32Xo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 05:40:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2af1aeb7 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 4 Aug 2025 09:40:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 04 Aug 2025 11:40:22 +0200
Subject: [PATCH v2 1/6] reftable/writer: fix type used for number of
 records
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-pks-reftable-fixes-for-libgit2-v2-1-fef06209a984@pks.im>
References: <20250804-pks-reftable-fixes-for-libgit2-v2-0-fef06209a984@pks.im>
In-Reply-To: <20250804-pks-reftable-fixes-for-libgit2-v2-0-fef06209a984@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: b4 0.14.2

Both `reftable_writer_add_refs()` and `reftable_writer_add_logs()`
accept an array of records that should be added to the new table.
Callers of this function are expected to also pass the number of such
records to the function to tell it how many such records it is supposed
to write.

But while all callers pass in a `size_t`, which is a sensible choice,
the function in fact accepts an `int` as argument, which is less so. Fix
this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reftable-writer.h |  4 ++--
 reftable/writer.c          | 17 +++++++++--------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/reftable/reftable-writer.h b/reftable/reftable-writer.h
index 0fbeff17f4..1e7003cd69 100644
--- a/reftable/reftable-writer.h
+++ b/reftable/reftable-writer.h
@@ -156,7 +156,7 @@ int reftable_writer_add_ref(struct reftable_writer *w,
   the records before adding them, reordering the records array passed in.
 */
 int reftable_writer_add_refs(struct reftable_writer *w,
-			     struct reftable_ref_record *refs, int n);
+			     struct reftable_ref_record *refs, size_t n);
 
 /*
   adds reftable_log_records. Log records are keyed by (refname, decreasing
@@ -171,7 +171,7 @@ int reftable_writer_add_log(struct reftable_writer *w,
   the records before adding them, reordering records array passed in.
 */
 int reftable_writer_add_logs(struct reftable_writer *w,
-			     struct reftable_log_record *logs, int n);
+			     struct reftable_log_record *logs, size_t n);
 
 /* reftable_writer_close finalizes the reftable. The writer is retained so
  * statistics can be inspected. */
diff --git a/reftable/writer.c b/reftable/writer.c
index 3b4ebdd6dc..5bad130c7e 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -395,14 +395,15 @@ int reftable_writer_add_ref(struct reftable_writer *w,
 }
 
 int reftable_writer_add_refs(struct reftable_writer *w,
-			     struct reftable_ref_record *refs, int n)
+			     struct reftable_ref_record *refs, size_t n)
 {
 	int err = 0;
-	int i = 0;
+
 	QSORT(refs, n, reftable_ref_record_compare_name);
-	for (i = 0; err == 0 && i < n; i++) {
+
+	for (size_t i = 0; err == 0 && i < n; i++)
 		err = reftable_writer_add_ref(w, &refs[i]);
-	}
+
 	return err;
 }
 
@@ -486,15 +487,15 @@ int reftable_writer_add_log(struct reftable_writer *w,
 }
 
 int reftable_writer_add_logs(struct reftable_writer *w,
-			     struct reftable_log_record *logs, int n)
+			     struct reftable_log_record *logs, size_t n)
 {
 	int err = 0;
-	int i = 0;
+
 	QSORT(logs, n, reftable_log_record_compare_key);
 
-	for (i = 0; err == 0 && i < n; i++) {
+	for (size_t i = 0; err == 0 && i < n; i++)
 		err = reftable_writer_add_log(w, &logs[i]);
-	}
+
 	return err;
 }
 

-- 
2.50.1.723.g3e08bea96f.dirty

