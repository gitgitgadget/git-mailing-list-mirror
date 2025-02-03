Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E238B1FAC3E
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 08:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738569830; cv=none; b=vBVkJv5kTTrvlou+yZDsOW4Pk8Il4tZm7/QdNRVkqybA6EU/AyEKwhNFpGKEkjGn4DgZlWql/geZX5SGGzRwZKsBvXINfDECYR+5a6TTHSPrpJbH40MMVW3M9yTAk+fFekxZ40EsJSduqxA/a3fEt3Im56N0v8MBh2DW64fXw28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738569830; c=relaxed/simple;
	bh=wxEI87iGTIa3+kw620bKbSDitIJdM3cdzEv2ghKd3aI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JX2fRp/tYYXySzPYl7UDAo1AvFCJhN06MQ9K/+qSnEZLmEhpiidwDW50lrvSUKDZ8SX8n4oMFucG7PEHyWGmiyDXbQMIjxfLNMvNzP6UTRAmCINeEBvvJSR8haMtqCgwquPVCejXHJU7w6TQL8Px8SzA4jKVpYJF7YwxxG7DuP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=edORGTNp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D55ja2ER; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="edORGTNp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D55ja2ER"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id F129F138084D;
	Mon,  3 Feb 2025 03:03:47 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 03 Feb 2025 03:03:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738569827;
	 x=1738656227; bh=/UdAJ2VcwUlfo8plhFrFpBaMwXYGrKhpXmO0teJzpsE=; b=
	edORGTNpCdJK/P6Rq3D8rJs9I5MWKhuRGZ6rj44qAIurHXt7a2ZtOsctR+ypOwpk
	ZGJGZjgleMrm70Sm9R5xQm+WrxUd+p2nA+tjpjGhA4Rwi4NHNkiuxyaIQD/h/XNU
	gur7mrvXN7WPl413m9YtTScsBab9MKjwpxiEFFoAHQqsmlAKHfE6FmmB1M+TUESh
	ktOLoCdR7xmLtXZSyviGsKEQLyhCtSgCA2VH1c5fBcbkOH6e/d6JuckxFSVC6vUx
	U5j6ArJYLfey/TpaLeCxG0BPeGArEMxngmWJeHU3xh1wzU8sKOY+IHeov5LJJ7bQ
	I+IwdOYXXdgJVGYTkfNjSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738569827; x=
	1738656227; bh=/UdAJ2VcwUlfo8plhFrFpBaMwXYGrKhpXmO0teJzpsE=; b=D
	55ja2EREMespczXq6gcTuHG+p+AoDb8sZgH61QsFcb+t16UlkWM35KK2g1MGWfoa
	12P5JB67ijMYTtEJUPrIGg0um4NxNxLk+VuD/s2zYx56W6wjKis/InqWlzQHmi2n
	pXbQ1kBDaZ40L3vnO9PezHRWPdocA4cAmkP/3hy//rAfzgVVF6D+3cRCerITV+km
	cf3dcr2pG8GUhpS/HNUvTqS6E9x35N5TgoWuVM2HNTkYozmu8Hk6PJcmXrfPwipX
	Qt5usSTmmxahDtq8cg6LFlhGXIHB2RJEiKbYwgnSUGFjdjegO++n32Uw5avCnAT8
	V6ZOckP7OcB09cXotiYuw==
X-ME-Sender: <xms:Y3igZ6YsSGthGJzxN0dsjfJJNoCWyG6CkVFN8I60P_NWBGPIfr-9uA>
    <xme:Y3igZ9ZC1urwvvboXTV3tDpNP2qBqRn-ZKJGwXVdE0ocyK8ljtJ2DGBKiMBygqxSy
    jWBGoqidZ_mJUKeNg>
X-ME-Received: <xmr:Y3igZ08R76W2WkdQhyUUWLGI59S19ihH9IERXKZ2EEzvOWLhyKXR-3xXOWCNhIEhzgVWGWaBaSaPdAiaMbl9O_bYtAZfydHdq47z8jFPoEY83g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvght
    hhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhrtghpthhtohepjhhlth
    hosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Y3igZ8rEDiy42aYVInd4_HCJJxXpoLsogEnJ_3WEpa1Cm5fY6qPd4Q>
    <xmx:Y3igZ1oKk9nN86BzZ-hnUrm7-apYNXhhb-9kH_qTpEivKJrwqJ-vQw>
    <xmx:Y3igZ6TgxtYyoWBpaMPmtyePNlQExgw1r-qpOBxoZbfM4nuvWq7R9g>
    <xmx:Y3igZ1qPTuLCVFwMLyrXCTuB5u0jK72ZD1xxd-arbEDvSKTbXWXePA>
    <xmx:Y3igZ2nvHOpEx_PPTK4efSJW1GnZV5IdHaitjbPbB24o2g01IrPoXWOK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 03:03:46 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 811f9c53 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Feb 2025 08:03:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 03 Feb 2025 09:03:35 +0100
Subject: [PATCH v3 04/18] reftable/record: stop using `COPY_ARRAY()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250203-pks-reftable-drop-git-compat-util-v3-4-446c9ed4ee9e@pks.im>
References: <20250203-pks-reftable-drop-git-compat-util-v3-0-446c9ed4ee9e@pks.im>
In-Reply-To: <20250203-pks-reftable-drop-git-compat-util-v3-0-446c9ed4ee9e@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Drop our use of `COPY_ARRAY()`, replacing it with an open-coded variant
thereof. This is done to reduce our dependency on the Git library.

While at it, guard the whole array copy logic so that we only copy it in
case there actually is anything to be copied. Otherwise, we may end up
trying to allocate a zero-sized array, which will return a NULL pointer
and thus cause us to return an `REFTABLE_OUT_OF_MEMORY_ERROR`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/record.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/reftable/record.c b/reftable/record.c
index 8919df8a4d..2c0cc32cbd 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -504,11 +504,17 @@ static int reftable_obj_record_copy_from(void *rec, const void *src_rec,
 	if (src->hash_prefix_len)
 		memcpy(obj->hash_prefix, src->hash_prefix, obj->hash_prefix_len);
 
-	REFTABLE_ALLOC_ARRAY(obj->offsets, src->offset_len);
-	if (!obj->offsets)
-		return REFTABLE_OUT_OF_MEMORY_ERROR;
-	obj->offset_len = src->offset_len;
-	COPY_ARRAY(obj->offsets, src->offsets, src->offset_len);
+	if (src->offset_len) {
+		if (sizeof(*src->offsets) > SIZE_MAX / src->offset_len)
+			return REFTABLE_OUT_OF_MEMORY_ERROR;
+
+		REFTABLE_ALLOC_ARRAY(obj->offsets, src->offset_len);
+		if (!obj->offsets)
+			return REFTABLE_OUT_OF_MEMORY_ERROR;
+
+		memcpy(obj->offsets, src->offsets, sizeof(*src->offsets) * src->offset_len);
+		obj->offset_len = src->offset_len;
+	}
 
 	return 0;
 }

-- 
2.48.1.502.g6dc24dfdaf.dirty

