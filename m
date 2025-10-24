Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48AC3101D3
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 09:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761299805; cv=none; b=gdptyZLTERPAq0vKv3F+AIxCwhVLIHzRdyLaRSlrhnfVP0lqmbz5y/QHQ8DZHi9QfRhTf/vNlywkNn2pfb6opj8umuCkpwd/tKS0l8y6IwgezJJZwSimqa9z1cnzo47f+lYrw+LKSkRmBqsBngNZN1kXmZSA0gAqYUetiJgiZg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761299805; c=relaxed/simple;
	bh=7t540GAVeT1Hdyr+V1+Ync12vFEIhQsPC1tTbU5RA+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PQ7loIxNXlAHiWdKiJsSlnPOuc1Nk1YTdB6ad5sXFMMXM4Lbv/H+L0icaOfNFtPWmFUuviddf9++R5kRIE93/MvyzbTzQio0Haqt8qXt1VtEchgJHEQsVfTNM8p8HPvEfxtEnkJDrlIKVKaCaBxCkxvGhFjwtXyN0hiAqOzCYao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Zw/oVSlO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aTVd9+p4; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Zw/oVSlO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aTVd9+p4"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CB15D14001D1
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 05:56:42 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 24 Oct 2025 05:56:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761299802;
	 x=1761386202; bh=hICRk2Zl740Q2nLpAwqeQ45WalG9AqZJfbZ+OB+Aw/o=; b=
	Zw/oVSlOuTEiS1Et3Db2M17pvRRKcHUTMrWdfnBFPYMLW8Z9JwPDVXvCZT8b7wN2
	+BtkFbFJqVTpBdurQXDF8VzaTNvx9ntL07H5W6EHuC7muQA0vjByp7LQ2QBtkDFo
	VLo/SgZNY1ocjPIe0Oxz+R7k7g0r1zjRxu3+9eyO46Sj0sNwaxj+S3fyOdsNBwJX
	R9P77Gp5ByB64T1GuZw0BsVxeMKUKB/PCjXGmWtv+v/shwS2UrgFBYrwQ1VO02Rz
	LDUyuFNEIcMVSMNtY672/9EyqE1JFE9Wo4YmCDb68Z2QC5ryNZ22THHX7VlH3/nP
	Vawj+1FSuie02JaL58lLKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761299802; x=
	1761386202; bh=hICRk2Zl740Q2nLpAwqeQ45WalG9AqZJfbZ+OB+Aw/o=; b=a
	TVd9+p4Ii1rXXapLZy2VO/sSR5gnzaRg2myAeMDRZfRw5ar8EC0GLEPpBnYBo42b
	NNeVjh2LbfKgsW546/WNCTBXsMevSJyhWPvKcr5xtATFuFwLyCPJrfvk3Av2rNGf
	fd7tdOoNw7x1GGVfLnMtXB0V1L1lZN6Hxs4xvafgXnJbZjblpnuzqY3fyKXLWP2O
	AaM5m8AqLlDCVBKkmv2v2fEPCafhMTeznnRR5WpZ1xcBSigjDIcqiG5J0msfGCp6
	LvYDwVfDrzlDQ0pwegWoyx1oCgs5lfq3RNBalOXamNaZmZ4lSxpzM1c78hqTlPIv
	GY7Z2nb0cVRjup4XkWq6g==
X-ME-Sender: <xms:Wk37aA0S90Kxl0MJUkkvNDkjcU_ECiah54QB-npPGbIC6wTxrFpJ6A>
    <xme:Wk37aCByBg6riZwIlDV2gcQ2ixIO0ZBRrU79gJwOR5Az-4WlU0n4vVbHlk5ch7NVj
    DWGQ3tqMflf6C461KwbZG2f4NcrPc5vSsaK8UyDe9A1x24bJSfGlg>
X-ME-Received: <xmr:Wk37aOjC6TQUWQq87OHLT-NDHLgm9U9jZsaCAaEWfc7QVwMvdDuF6rVjNkcNEb7cIzG3AkU6tJp1SHIiT7Df-ef3ZoBZfTk8QqL8KXkuhA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeeltdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:Wk37aO_t-dI1cDgYmbEk-7nLKdCHnMm9vwBgQmxhXJhAmNny9Cpycg>
    <xmx:Wk37aC_-p5uLB4RoJxm5rfmHeO3AJY-HSAdXWshREQnU80KzB39uow>
    <xmx:Wk37aPBg5AtANFFP5B88ocjnxeVjOzCEUjZD0AVWfeYfR46N_NTRCQ>
    <xmx:Wk37aKzvk8sKdruIDjKVvqot_BpDrIM9XuAsM9hZc8r4WRZhbXIVvA>
    <xmx:Wk37aCGXkVdKI1xG6tDoYG-vq5Tiu8m001R6Lzs96M-Gah97UjY3CbOB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 24 Oct 2025 05:56:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d084c06a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Fri, 24 Oct 2025 09:56:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 24 Oct 2025 11:56:11 +0200
Subject: [PATCH 12/13] object-file: rename `write_object_file()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-b4-pks-odb-loose-backend-v1-12-1a4202273c38@pks.im>
References: <20251024-b4-pks-odb-loose-backend-v1-0-1a4202273c38@pks.im>
In-Reply-To: <20251024-b4-pks-odb-loose-backend-v1-0-1a4202273c38@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Rename `write_object_file()` to `odb_loose_source_write_object()` so
that it becomes clear that this is tied to a specific loose object
source. This matches our modern naming schema for functions.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c |  8 ++++----
 object-file.h | 10 +++++-----
 odb.c         |  3 ++-
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/object-file.c b/object-file.c
index 2ca90adc2c7..67be5371346 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1084,10 +1084,10 @@ int stream_loose_object(struct odb_source *source,
 	return err;
 }
 
-int write_object_file(struct odb_source *source,
-		      const void *buf, unsigned long len,
-		      enum object_type type, struct object_id *oid,
-		      struct object_id *compat_oid_in, unsigned flags)
+int odb_loose_source_write_object(struct odb_source *source,
+				  const void *buf, unsigned long len,
+				  enum object_type type, struct object_id *oid,
+				  struct object_id *compat_oid_in, unsigned flags)
 {
 	const struct git_hash_algo *algo = source->odb->repo->hash_algo;
 	const struct git_hash_algo *compat = source->odb->repo->compat_hash_algo;
diff --git a/object-file.h b/object-file.h
index b27c08380d8..78f0e650d72 100644
--- a/object-file.h
+++ b/object-file.h
@@ -62,6 +62,11 @@ int odb_loose_source_has_object(struct odb_source *source,
 int odb_loose_source_freshen_object(struct odb_source *source,
 				    const struct object_id *oid);
 
+int odb_loose_source_write_object(struct odb_source *source,
+				  const void *buf, unsigned long len,
+				  enum object_type type, struct object_id *oid,
+				  struct object_id *compat_oid_in, unsigned flags);
+
 /*
  * Populate and return the loose object cache array corresponding to the
  * given object ID.
@@ -168,11 +173,6 @@ enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
 struct object_info;
 int parse_loose_header(const char *hdr, struct object_info *oi);
 
-int write_object_file(struct odb_source *source,
-		      const void *buf, unsigned long len,
-		      enum object_type type, struct object_id *oid,
-		      struct object_id *compat_oid_in, unsigned flags);
-
 struct input_stream {
 	const void *(*read)(struct input_stream *, unsigned long *len);
 	void *data;
diff --git a/odb.c b/odb.c
index 6f8f665351b..432011b4dac 100644
--- a/odb.c
+++ b/odb.c
@@ -1021,7 +1021,8 @@ int odb_write_object_ext(struct object_database *odb,
 			 struct object_id *compat_oid,
 			 unsigned flags)
 {
-	return write_object_file(odb->sources, buf, len, type, oid, compat_oid, flags);
+	return odb_loose_source_write_object(odb->sources, buf, len, type,
+					     oid, compat_oid, flags);
 }
 
 struct object_database *odb_new(struct repository *repo)

-- 
2.51.1.930.gacf6e81ea2.dirty

