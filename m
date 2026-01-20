Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0357447886C
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 15:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768922786; cv=none; b=f7cQkgv4TcP5RMGXGu4+j4IIgeCkfkWVhhEpW5o5Tcf+cSXpM+o6dV+Bj3dRjj2sdhga9D7yfGtYlQDVmdCiEN0sbQ02imIaV+Xi4Y2OdFPQMNFDaGwM7noYRkKhMml9Jv1OVt/XoHXNj/4U54quyRfyDY8C4izD5ojTd9D3DbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768922786; c=relaxed/simple;
	bh=JSPXN7NwtWe59uhrDwxDVCrg7YXPTIS2BLkkjSb0KPg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LhVVB6Do9j67yHs0lR0Vd8sF0KMY27RJtvVPlXAvYnqK8khulwC2wiW2b/yMXWZSSjz6L1p8F/qACOMsIcjCG/eNbPbu+gmeO6GoMr+vjojB0NhAi+9gjKLlV96r6dpuecDT1Q1aq7WYmz2sU9XudZ5Fw3CcmmBeaHwH9/zYXrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TR6y4jgn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oUQxQtsT; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TR6y4jgn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oUQxQtsT"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 27AB57A00C8;
	Tue, 20 Jan 2026 10:26:24 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 20 Jan 2026 10:26:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768922784;
	 x=1769009184; bh=xFLiACMEoR3j+fYNLETlBjk6t4qJHRDIsQSXzI9xGg8=; b=
	TR6y4jgnP6tdJAx4Y3OuPve9XvS1N/UJFUhZ4BZRq1ccZjjJxy6w4IxkfwOoCtSU
	6BW3jerPFZmEAtw59pzpBnuB91VMjjO7cU3pJqYXdIHps+DcneFLtwbkkG79jE2C
	IyWA+Oeb/9V69RFHJdkVqGP0io7O2r7I9UGrxfH0RtVjvekiKeDANUO7+sjt8vyF
	xLaYj1vh9cJ7JyUCBH3UQMh5LUlackqKKqakglPBPeAKVIWhiqH+3yiAIez/RNZB
	pI29Zd27VEmvxnoz+hRBPVSsOx0zLyn0K9/CeTnVWwnen2IYJEajYojNOPRJxpfh
	qeRfRVypTToqGwhktsrENw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768922784; x=
	1769009184; bh=xFLiACMEoR3j+fYNLETlBjk6t4qJHRDIsQSXzI9xGg8=; b=o
	UQxQtsTY6AfYNFohpa7tfWUWyR+/L+A2V9pMIUSnOgFwV8ROsLFP4KvCougxwuA2
	RNvNHmfB5psO3t8EH0pE/TGt+9G0ILOB23SDAqxChqTJTzr3nXb4lb1rMU53dalD
	twY4bdqji+j/zkKO8YygkRyFr9kxv7LXnQJ6E6R8rvKRGPZQCgp5vh8jppG41hMD
	R4Buh05CDZLcXue1VzQIR75H0qmKPPIDIr5szt0Cu9+OezJT69ej2MEBWqkuedaw
	fFwACM+YRNIaiJOpq3bTKgsUyRXUYKa2ZPa3xfORayj7OkGVb2GSGL4gGpgwx1c5
	RxMXFBwf2A2uf7Zy9iRqA==
X-ME-Sender: <xms:n55vabxSsD6CK8SK3FNFQEeB4qTIgk4tnWOIdNIrkchctlJcVD-bWA>
    <xme:n55vaaTi5st6re5fSSQWoawY7ov2YZugyDuavLe24kU-LFVHxX9LnfH8tnvK61YnY
    WWSw7Xx7N0foliNkR6JQupPjkV3zdbnqJCh_YV_xvqH0y8i6jRJ3Q>
X-ME-Received: <xmr:n55vaaXlB9adhkg3sTRJvqOWKMxC6XLEImZ0Z30nE42O-DPlgK9_5tqGgbfiFbb1pyUnuh42neIkcmrXKRCvQQKbixWIgX-U3wOI3XfeTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedtjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhlthhosghlvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:n55vaUYT69wCPgFaHASsSRJNyWpUPAkXwEQBSm043QF5PGoXgzsUKw>
    <xmx:n55vaY1OMWmUwKeSkDsiz18vb2FbTTTeoXd628IybPMkwlhTTCQnkw>
    <xmx:n55vaehtIxW-XhNZLxe8Dcf1dU0GRs78etRn18fyY_GEsngPIXZXBA>
    <xmx:n55vaUZPn95q6036wkSeN9ZyZkCwyPJaE6ZC4Y6Hx0vnWAvykHzGLw>
    <xmx:oJ5vaR2sn3wwNaICCcAha39Rwgk4xZKX7iNj293PKvK3984YNhnNCELl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 10:26:22 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 58674bb9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Jan 2026 15:26:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 20 Jan 2026 16:26:02 +0100
Subject: [PATCH v2 06/14] packfile: introduce function to iterate through
 objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-pks-odb-for-each-object-v2-6-d05cbfd3d6f8@pks.im>
References: <20260120-pks-odb-for-each-object-v2-0-d05cbfd3d6f8@pks.im>
In-Reply-To: <20260120-pks-odb-for-each-object-v2-0-d05cbfd3d6f8@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

Introduce a new function `packfile_store_for_each_object()`. This
function is the equivalent to `odb_source_loose_for_each_object()` in
that it:

  - Works on a single packfile store and thus per object source.

  - Passes a `struct object_info` to the callback function.

As such, it provides the same callback interface as we already provide
for loose objects now. These functions will be used in a subsequent step
to implement `odb_for_each_object()`.

The `for_each_packed_object()` function continues to exist for now, but
it will be removed at the end of this patch series.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 packfile.h | 14 ++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/packfile.c b/packfile.c
index d15a2ce12b..cd45c6f21c 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2360,6 +2360,54 @@ int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
 	return ret ? ret : pack_errors;
 }
 
+struct packfile_store_for_each_object_wrapper_data {
+	struct packfile_store *store;
+	struct object_info *oi;
+	odb_for_each_object_cb cb;
+	void *cb_data;
+};
+
+static int packfile_store_for_each_object_wrapper(const struct object_id *oid,
+						  struct packed_git *pack,
+						  uint32_t index_pos,
+						  void *cb_data)
+{
+	struct packfile_store_for_each_object_wrapper_data *data = cb_data;
+
+	if (data->oi) {
+		off_t offset = nth_packed_object_offset(pack, index_pos);
+
+		if (packed_object_info(pack, offset, data->oi) < 0) {
+			mark_bad_packed_object(pack, oid);
+			return -1;
+		}
+	}
+
+	return data->cb(oid, data->oi, data->cb_data);
+}
+
+int packfile_store_for_each_object(struct packfile_store *store,
+				   struct object_info *oi,
+				   odb_for_each_object_cb cb,
+				   void *cb_data,
+				   unsigned flags)
+{
+	struct packfile_store_for_each_object_wrapper_data data = {
+		.store = store,
+		.oi = oi,
+		.cb = cb,
+		.cb_data = cb_data,
+	};
+	int pack_errors = 0, ret;
+
+	ret = packfile_store_for_each_object_internal(store, packfile_store_for_each_object_wrapper,
+						      &data, flags, &pack_errors);
+	if (ret)
+		return ret;
+
+	return pack_errors ? -1 : 0;
+}
+
 static int add_promisor_object(const struct object_id *oid,
 			       struct packed_git *pack,
 			       uint32_t pos UNUSED,
diff --git a/packfile.h b/packfile.h
index 447c44c4a7..ab0637fbe9 100644
--- a/packfile.h
+++ b/packfile.h
@@ -343,6 +343,20 @@ int for_each_object_in_pack(struct packed_git *p,
 int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
 			   void *data, unsigned flags);
 
+/*
+ * Iterate through all packed objects in the given packfile store and invoke
+ * the callback function for each of them. If given, the object info will be
+ * populated with the object's data as if you had called
+ * `packfile_store_read_object_info()` on the object.
+ *
+ * The flags parameter is a combination of `odb_for_each_object_flags`.
+ */
+int packfile_store_for_each_object(struct packfile_store *store,
+				   struct object_info *oi,
+				   odb_for_each_object_cb cb,
+				   void *cb_data,
+				   unsigned flags);
+
 /* A hook to report invalid files in pack directory */
 #define PACKDIR_FILE_PACK 1
 #define PACKDIR_FILE_IDX 2

-- 
2.53.0.rc0.250.g0ac79233d6.dirty

