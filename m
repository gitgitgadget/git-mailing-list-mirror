Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F2C30DEAD
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 09:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761299780; cv=none; b=lag1flod+xrnp1pWLd+WNcEURmxCeezoTYEF2bk+l+IxtdVhi0hFizH7jsvVzjC3lJhyLbaLxRiOnCRNIaF8h6aF9HtSTOTW6gvIiMlFB/4Ay+1Of1gOX/Z05Ve2AaS0Qurz/nGtxRTwdVX5O7s4De2LA7rMzMYLF9iy+AmXTWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761299780; c=relaxed/simple;
	bh=GLH7jn8LscRHV8j3CYj3F5tkDH2LLJgQJCywa3ph8yA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G/t1Ypqycih/xZn2O90jxLsaG25ok9Q5giVED67COeM98z5RKx/n98EFkPaQQB2z6o1BTFfi3XNSP1atCkjJ6RtK5E8rLQii6PgFs8mxPB4FvgFVa8+Pp+1vtVBUihsSbzYDU4pHFB+qPZm+n2hqMjy+HtG1iO0PZ5vK+n3bc+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=edgIyPUi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hiM0wtOc; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="edgIyPUi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hiM0wtOc"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 607DEEC02A0
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 05:56:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 24 Oct 2025 05:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761299778;
	 x=1761386178; bh=bKEKHp1KXHzAmQqDCjDI+xDMan7ZSBHEA6Zijr2FRoE=; b=
	edgIyPUi4fOmWq2Ba/IEx0zvm1OrAV7JWFN3+sWFzdnvshZLPKDjDOhfBcdhqhJh
	6pmne/ji5KutYSK1u8pAU6qeTbSuhvDNuRcuSzY6uE+5BRSjBoY8TVsPIfXb7WML
	HrjtoXv+XHwyB8l+3vVh+cvt1LKT6CuAqOmlvArG+K5Bk/cb66QxUkQsVatM6rFN
	68419dQG7hEP3YKqiUG19JhlO9IpTiTGiJeR2XMRXVIbnX1BtiT2efL7jBlbt67+
	Q2cSDFc01MkuShzKTALI4ghG6Pi+kwlS/ggDB4Ftk2wuvY/RAF+tWKXR8i+24OL6
	Uhwhj/q3gb5j+l9tViXUmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761299778; x=
	1761386178; bh=bKEKHp1KXHzAmQqDCjDI+xDMan7ZSBHEA6Zijr2FRoE=; b=h
	iM0wtOcHlRrRd/iHuifAmM4/J2Ny51mhQRhSh5jBzvDCe6tzHedBZ2CDBEcXznL3
	xfQhTj5aI+qVPriRPTKZKljp6heU7FGSmX6OZbztk4WLDl+VR5wpEw+4NgxmpS9s
	ZGBfdU4/Jll2i5ytsTYG7UwXRqvyMuxL6c+kE0vYJ2ELTpcRGbxrh07IKduo5wAY
	NAa/2JTpkuWf89prs4flXiOqN5octaHTTT2Z61iljfTi0fiMwd5cBHc9q9t/0iWU
	wDKwQa9ajHCC+IbFN4jHc0/G8alnJ6oVrIwjy5AITAgE9jcWvEIr8lQusdLqJmQy
	qKxGFo+tK8HfU9BAoNb0A==
X-ME-Sender: <xms:Qk37aNOj0a49mJl1GjT5gauywrGHbN2__ir4UFOoBbbq9zjypo_kEg>
    <xme:Qk37aG5nlm8-UkbqBJIhudlISOoBZu9XKoqQIe2DXJvs1GBuZ68_RsJBEGxZnVfK2
    uK60HMmSgYnzWdVEROUNJuvnpbq_3ZUTzKyXfh-eDWBjb39Ne39>
X-ME-Received: <xmr:Qk37aB5Jgd26XDvgKk3cc9QM-2TtB2D-icWQ8Ja9meB6As8bfu3QpEkKDgh8qjGvKJMoCyn2ucXFygUkBmLgj9FOftgZBQeH9FipMSvGKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeeltdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:Qk37aO2W2kucwC0wCMKndV7XG8vPj-EWqacdrZJYGkNrkFoXdusLBA>
    <xmx:Qk37aFUmTPmCQyG_aeK_GuB2yeU0RmzzDRqnDqjySDUcy-ZUqciBfg>
    <xmx:Qk37aB6d413V9FauUN7j8hxd-fwPQI7y0OcrMSBx1SLBIaPyJEeD6g>
    <xmx:Qk37aELjuWN6xBolZy93jbY0f9mw9auQmT9Tw363c_f6LKXgMji0Bw>
    <xmx:Qk37aJ97Bp1aEHt5VVyIMt8ZaaWXgz8IsGrkdSJC_0ZFToSdDqmav5Er>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 24 Oct 2025 05:56:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c3d35610 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Fri, 24 Oct 2025 09:56:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 24 Oct 2025 11:56:03 +0200
Subject: [PATCH 04/13] object-file: move `fetch_if_missing`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-b4-pks-odb-loose-backend-v1-4-1a4202273c38@pks.im>
References: <20251024-b4-pks-odb-loose-backend-v1-0-1a4202273c38@pks.im>
In-Reply-To: <20251024-b4-pks-odb-loose-backend-v1-0-1a4202273c38@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

The `fetch_if_missing` global variable is declared in "object-file.h"
but defined in "odb.c". The variable relates to the whole object
database instead of only loose objects, so move the declaration into
"odb.h" accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.h | 8 --------
 odb.h         | 8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/object-file.h b/object-file.h
index 3fd48dcafbf..097e9764be1 100644
--- a/object-file.h
+++ b/object-file.h
@@ -7,14 +7,6 @@
 
 struct index_state;
 
-/*
- * Set this to 0 to prevent odb_read_object_info_extended() from fetching missing
- * blobs. This has a difference only if extensions.partialClone is set.
- *
- * Its default value is 1.
- */
-extern int fetch_if_missing;
-
 enum {
 	INDEX_WRITE_OBJECT = (1 << 0),
 	INDEX_FORMAT_CHECK = (1 << 1),
diff --git a/odb.h b/odb.h
index 2bec895d135..2346ffeca85 100644
--- a/odb.h
+++ b/odb.h
@@ -14,6 +14,14 @@ struct strbuf;
 struct repository;
 struct multi_pack_index;
 
+/*
+ * Set this to 0 to prevent odb_read_object_info_extended() from fetching missing
+ * blobs. This has a difference only if extensions.partialClone is set.
+ *
+ * Its default value is 1.
+ */
+extern int fetch_if_missing;
+
 /*
  * Compute the exact path an alternate is at and returns it. In case of
  * error NULL is returned and the human readable error is added to `err`

-- 
2.51.1.930.gacf6e81ea2.dirty

