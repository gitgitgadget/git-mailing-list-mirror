Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B632136E497
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 11:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768475120; cv=none; b=sl6XxGVvuR97ZtMYjdV9+qMO6RCbqsawjRhkifEBGs+p8SyoSCOOiui2Xeu8k+/hqrA3V35llSxnGi5Mvvrm9TgwgRFLA5xXfQDoEkfHSr7Bh/fKVkguvqNop4z+dsICnoIVOpdXSk5eDG6IkilJB9Yz4GKd0sVXd9evGylD85s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768475120; c=relaxed/simple;
	bh=jSW+9BIi4vvCajZaEYPV0c4JEvgJ5R6NExSx62+Zj/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ELn5Bhu/YoN1tRjHZaCO8P7EIfwlx4/3DspUXwBX8fMfCP2Ydhg+Q2Ha26elrh9GKQjVpW2MxIeZkW+9jVttCHLVH1XN/KFpTSDaNheJjeMBozUJLREfsgumlANezuziSr2Vb2yaIhynSQGKSuipshTWNBSYWWfI8l6AfsLmb1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V/0P1oF1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zXNfo28q; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V/0P1oF1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zXNfo28q"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 037521D000E9
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 06:05:13 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 15 Jan 2026 06:05:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768475113;
	 x=1768561513; bh=/MNY+qr5bilXKNMl5yXaeg/g6g+3jHc5ElbIXzGVfqI=; b=
	V/0P1oF1xuu+gIqI4g1YJDZzUUOz1dyDz2aB/xp1POA3e06ndVyT6AYKSxDNVx+E
	O2xAEedIdksueHmLctQ8RVYpf8nUd9bUfcqA/OpIUh480A/aMuRv3KxPiLTWvl8H
	bP7bSGNSQD5xoYTMGpqgghBvPdgQkVF25hidHJ1WJ0LQoyItwKyKN2KtVg5AbFyf
	McmYVD4nOHq+51XplNrTtDQu1FJq18dLphwaBGYDzb7LPC3iMSWsIqj/qpDsRAJ+
	Xw3DwArTKLYgOaM78Ncz+Qn3a9VFOrVuLhyesVcV2/9EoHZCuTctIsnWyzrE1BYI
	kDzhz34Q8uhYAeoHMfp4/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768475113; x=
	1768561513; bh=/MNY+qr5bilXKNMl5yXaeg/g6g+3jHc5ElbIXzGVfqI=; b=z
	XNfo28q60g/2vsw6ZjbV5h20sWGpekKpz1i0k/QAZ6RNhxRW+0+VyMNyqgaotAIM
	JzLO/e58J+UQGoTPOfOvRb8CYkVW1eAS8J2FATesjpEWXzeOlbLMpM5MaEJj9xfU
	jZSkulVN9M1dLFcYtKix85Lj4EJQOPIhIgP1rm+RsZ6mTAqh2XNCOsBjYn5vcc1J
	gXeGVPjZpDBxtLPTyeDjU4ZEBVtJW2TXgZKtTc+cdIqbHhMLB3W8sBEshf3MCbIy
	+TzwT1+zMtq5FVsodXdbmhnBpmHSwKjyHm6fxVU4bHHG+/qr1HpVP3YXsr7PNf73
	3pACpYQO9s/mpy4HCvk1g==
X-ME-Sender: <xms:6cloaR4nHdDezlIogp_SHEHjTddMT-squkdkTqSuGHA_jBbIWyQBlA>
    <xme:6cloaV2w1oc2rVIG0Dwr7E1MkuXsQpFtx2xTDMUJ1seUQaOHOMIXhY43Xja7zMiia
    DxN4bMkzGaITVN9CzJFW43xLi8u4x0kqrPjLwaVs4kc9Q4L5XKRHw>
X-ME-Received: <xmr:6cloaeEQu3BrXajTNwYOnzkrysLjll0ZGLmt1KJPAfO8SCJf7Zwl6ntAxQnKSipe2vQyb19rFrQK_Q0PpSY7Rlu9EYzDriZMsYcYzVW-YCC9wg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdehkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:6cloafTWsSbb1FD1NWtHBuA_MfLqVXm79ojQF1nQFfgcmPbK3MBdXQ>
    <xmx:6cloaVCz7KJYijHwCsQnFPvCQz7ZHf8m0l7YZNAVkrsIkYBKkw_fHQ>
    <xmx:6cloaf0lTXcBna4DLPhpkm0uXkNEn4-Huh2oiICQYA9xeYudlFSm9w>
    <xmx:6cloaTWENZbWAgHbusHot0OXoJptjsD7vagyBUtZIplwshNnPhDmVg>
    <xmx:6cloaWbLWX_BVXUEeE2mHb5n4Kowz86igkBNUx4IUI6c_frfMyLZMQvo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 15 Jan 2026 06:05:13 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e1617a10 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 15 Jan 2026 11:05:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 15 Jan 2026 12:04:36 +0100
Subject: [PATCH 07/14] odb: introduce `odb_for_each_object()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-pks-odb-for-each-object-v1-7-5418a91d5d99@pks.im>
References: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im>
In-Reply-To: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Introduce a new function `odb_for_each_object()` that knows to iterate
through all objects part of a given object database. This function is
essentially a simple wrapper around the object database sources.

Subsequent commits will adapt callers to use this new function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c | 27 +++++++++++++++++++++++++++
 odb.h | 17 +++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/odb.c b/odb.c
index ac70b6a099..65f0447aa5 100644
--- a/odb.c
+++ b/odb.c
@@ -995,6 +995,33 @@ int odb_freshen_object(struct object_database *odb,
 	return 0;
 }
 
+int odb_for_each_object(struct object_database *odb,
+			struct object_info *oi,
+			odb_for_each_object_cb cb,
+			void *cb_data,
+			unsigned flags)
+{
+	int ret;
+
+	odb_prepare_alternates(odb);
+	for (struct odb_source *source = odb->sources; source; source = source->next) {
+		if (flags & ODB_FOR_EACH_OBJECT_LOCAL_ONLY && !source->local)
+			continue;
+
+		if (!(flags & ODB_FOR_EACH_OBJECT_PROMISOR_ONLY)) {
+			ret = odb_source_loose_for_each_object(source, oi, cb, cb_data, flags);
+			if (ret)
+				return ret;
+		}
+
+		ret = packfile_store_for_each_object(source->packfiles, oi, cb, cb_data, flags);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 void odb_assert_oid_type(struct object_database *odb,
 			 const struct object_id *oid, enum object_type expect)
 {
diff --git a/odb.h b/odb.h
index f97f249580..8f6d95aee5 100644
--- a/odb.h
+++ b/odb.h
@@ -475,6 +475,23 @@ typedef int (*odb_for_each_object_cb)(const struct object_id *oid,
 				      struct object_info *oi,
 				      void *cb_data);
 
+/*
+ * Iterate through all objects contained in the object database. Note that
+ * objects may be iterated over multiple times in case they are either stored
+ * in different backends or in case they are stored in multiple sources.
+ *
+ * Returning a non-zero error code will cause iteration to abort. The error
+ * code will be propagated.
+ *
+ * Returns 0 on success, a negative error code in case a failure occurred, or
+ * an arbitrary non-zero error code returned by the callback itself.
+ */
+int odb_for_each_object(struct object_database *odb,
+			struct object_info *oi,
+			odb_for_each_object_cb cb,
+			void *cb_data,
+			unsigned flags);
+
 enum {
 	/*
 	 * By default, `odb_write_object()` does not actually write anything

-- 
2.52.0.660.gd05f3a8ea5.dirty

