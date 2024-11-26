Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E71B1917E4
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 06:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732603396; cv=none; b=CbdyC4uZaxaWqYOFPOpmgFHWEr0fJDXlLt0M9jHhVxRROhUEtFXKZd6Y8ERk8pEgPMT8Qbw8xKz88Lhszq5+2sSPIKGITiWKAGAKfmdXB3gQeM3GDG8Zg0hLdpIpN1apXvhRrLkLy/o+Rg6obQelUBvytuy/d48mgqzXWrve4uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732603396; c=relaxed/simple;
	bh=R3cDBKXuIRR7EXwXLRGQ4uF8Qsfofxg/vk0M/9T+gqQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RgkkGdG9R18PHHTdZgZpjdTKHH7nBv09tz8ZEiH6U7/b0S5Lto/wkezHh7H/VbPh4a5/xdNWBLEVnCreRNT6zYhBNg/MWEIjIjOou1zRePeYUBM81HuwcUtqiGTt+HY1H0YruRzEjWfUOoiULe3bxdER1lMd1+yJS4giSrrmLzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TDRLpqk/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KnXTOf60; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TDRLpqk/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KnXTOf60"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 0A17413805E8;
	Tue, 26 Nov 2024 01:43:14 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 26 Nov 2024 01:43:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732603394;
	 x=1732689794; bh=V4Pogm/Mo+P/f1Sw/VTI+xc4fMJmcMPGZxoA+Bjidms=; b=
	TDRLpqk/1Sh59aJkjieA9x7No4pjOtoNZIy2v7kxbn9SXg55SXfy0GU4cbn3SSrR
	zfK1E6b4jXD44Gm2MhWGgeCcDO2YzV5oikqpbUoG69ObrEMQLUAbt4rNIy02iqc5
	+K/CmI/p9skF2s6kS8FdoIDIaWaBFiSBvpyauHTRh44I7vn5fUIh04mXwQxxvUwF
	HJJhtRPsBHdAOP7yNEU7ldYgPYVDh1IlZ2yv6/IflgRlykvTRrs23szLIoUdKXlC
	ODLja2cDXa8RuKlky/M0wI3cxTVkWB/9LVqqdvQocglF2lgHG+8Z9C1mx3iCmtIw
	BGKYjnRSHJ33C+43ki0aEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732603394; x=
	1732689794; bh=V4Pogm/Mo+P/f1Sw/VTI+xc4fMJmcMPGZxoA+Bjidms=; b=K
	nXTOf60Pry6DnZcL7NUzKcAR8rXyjrRK/pUIjBYDJ0Yj0kj9qu5XoAkeCavcUNQX
	iDA/ZjjfNdEx8Lklo9CJP6MTb2GUNxuaDDxgvnxE1slCL+QrwRl964Ph72dPyawZ
	BuF0kJuh97BdaB0KZx4UyekDLz/1BqKlEB/MAyZlGrTxGmRQajfpUq5jVxp8UrI9
	jcqAfmthlQuIa6ccLFsCPGBkUGr5aG8GnclPHhS9FhIuw5YmCbodp4n5g8zohKO5
	UvLi9yqzgoV7UeafOzfHcOK5VxiRMlX6pKo8mkXgWKiwLCxYeKTTe+WRAP5wjI/U
	odu+u3eV0KibEn3NHUr4g==
X-ME-Sender: <xms:AW5FZxCjVKac0Kwd6tFYW6oRegahkxCBlJhcoPoF2DPYOeBdk_JBag>
    <xme:AW5FZ_jpP1dH4wUb3fLy9_UqcdJU7RTLIZRuIeKLRKYHh9_lk1LEw2P_Mw4Ym7SpA
    F-mozb7Iy55MMEYPw>
X-ME-Received: <xmr:AW5FZ8nGa0ozrhm0IpgVtgBqwOgwtVHlTZnFdMeJgU4agsc7bi__Jw2SLf3h-0WoCW8SCFurzUD46kob-l3AiRzxioHm_q-Vq5sb-14JsF7tuXXv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeigdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:AW5FZ7ylq1iwzwtOOxnLsttzH5KfqCdC5LCfeSOm1MfQfsr0UvooGg>
    <xmx:AW5FZ2Q9kAXhsyuX0iw4ZQ_8OAY49RtM443p4FP2fFc0DVE6ls5c4g>
    <xmx:AW5FZ-aXqMbqAj_wIPArR02P52YsZgicGFrszLJmr9NcHLp2CvkJhw>
    <xmx:AW5FZ3Ti5vzOBDrGui96bK7NPinOEwB6ITWQldyBcVDECkSoQAYTOA>
    <xmx:Am5FZ0fU-QXXhDx4PJRuE3amLe42nfYF0aF6W-OOk96PpmmR0LY6oYlf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Nov 2024 01:43:12 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 192deba0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 26 Nov 2024 06:42:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 26 Nov 2024 07:42:58 +0100
Subject: [PATCH v4 07/10] refs/reftable: refactor reflog expiry to use
 reftable backend
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241126-pks-reftable-backend-reuse-iter-v4-7-b17fd27df126@pks.im>
References: <20241126-pks-reftable-backend-reuse-iter-v4-0-b17fd27df126@pks.im>
In-Reply-To: <20241126-pks-reftable-backend-reuse-iter-v4-0-b17fd27df126@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Refactor the callback function that expires reflog entries in the
reftable backend to use `reftable_backend_read_ref()` instead of
accessing the reftable stack directly. This ensures that the function
will benefit from the new caching layer that we're about to introduce.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 2d06620ac8b1b7f07783cd5873dbe0fe67b84bd6..b6638d43028d11ae7621dcd4e0dbf1d3174743b7 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -2444,14 +2444,15 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
 		reftable_be_downcast(ref_store, REF_STORE_WRITE, "reflog_expire");
 	struct reftable_log_record *logs = NULL;
 	struct reftable_log_record *rewritten = NULL;
-	struct reftable_ref_record ref_record = {0};
 	struct reftable_iterator it = {0};
 	struct reftable_addition *add = NULL;
 	struct reflog_expiry_arg arg = {0};
 	struct reftable_backend *be;
 	struct object_id oid = {0};
+	struct strbuf referent = STRBUF_INIT;
 	uint8_t *last_hash = NULL;
 	size_t logs_nr = 0, logs_alloc = 0, i;
+	unsigned int type = 0;
 	int ret;
 
 	if (refs->err < 0)
@@ -2473,12 +2474,9 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
 	if (ret < 0)
 		goto done;
 
-	ret = reftable_stack_read_ref(be->stack, refname, &ref_record);
+	ret = reftable_backend_read_ref(be, refname, &oid, &referent, &type);
 	if (ret < 0)
 		goto done;
-	if (reftable_ref_record_val1(&ref_record))
-		oidread(&oid, reftable_ref_record_val1(&ref_record),
-			ref_store->repo->hash_algo);
 	prepare_fn(refname, &oid, policy_cb_data);
 
 	while (1) {
@@ -2545,8 +2543,7 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
 		}
 	}
 
-	if (flags & EXPIRE_REFLOGS_UPDATE_REF && last_hash &&
-	    reftable_ref_record_val1(&ref_record))
+	if (flags & EXPIRE_REFLOGS_UPDATE_REF && last_hash && !is_null_oid(&oid))
 		oidread(&arg.update_oid, last_hash, ref_store->repo->hash_algo);
 
 	arg.refs = refs;
@@ -2571,11 +2568,11 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
 		cleanup_fn(policy_cb_data);
 	assert(ret != REFTABLE_API_ERROR);
 
-	reftable_ref_record_release(&ref_record);
 	reftable_iterator_destroy(&it);
 	reftable_addition_destroy(add);
 	for (i = 0; i < logs_nr; i++)
 		reftable_log_record_release(&logs[i]);
+	strbuf_release(&referent);
 	free(logs);
 	free(rewritten);
 	return ret;

-- 
2.47.0.366.gd4f858ca17.dirty

