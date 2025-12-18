Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A228B2264C0
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 02:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766026656; cv=none; b=FDErivMyj7l74Cl7hROs8nbNIuwGHaKEm7hOxjzobhXkFoBP4uHBIFAULGGo1MLZ5bl21a+lTdEqzlg6FDKRleAFkdrX30jd4Qu+kaQcMMfrx0T+W1PkT+z+hgZ3+n+1zDb7QtGOEFhgQJ3+qSbr5feEG4QeM9uK+g3IuK2gBlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766026656; c=relaxed/simple;
	bh=jWk1AADiKgrRVDPEXeSrrwe1y5PwszT71E49NjFuKdc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YMJssAqQyptjA5qO92aaqMvqBwJTNPb6wZ5tFH/xvqENn9zUL9JqwGu1Jk+/yshjL0RxF4cE2EvafmkE8Fur9DKq13O0Dw6LlulMpixM9a0keMBuCJHWvDRZ42jnYDDLj4b8+aPDPuI/whgLSLxWb5GWmcnEqNCF/yRpAYVMKqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VFDh/UI9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pv1VliLb; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VFDh/UI9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pv1VliLb"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id BFB1AEC016D;
	Wed, 17 Dec 2025 21:57:32 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 17 Dec 2025 21:57:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1766026652; x=1766113052; bh=i6nW+KjEck
	3wZQdgaUqrMzlbaFbG/ci0qPoSE59HrWU=; b=VFDh/UI9Js+1slbR5conOJE9uS
	aSL565BI7/0Cn2aDGfQPF9ADUT7sDawrwDY8E7raDbJ6IAih3B49v220UuXNONq4
	HDhfvskbiTLZ6mbNTs9aTj8kjlX36eUfmpMl78Q+xQlXbRqvdr6jqmd0Xcn/icWf
	LSFjo8hZhmyo0DmiXy4URJc3CqfhoouIIcS8W2KGS9eLWEPYpsyBAfCbkpc9RYF9
	TXprbfujk19+Oagrf8FIbCdpcU8iixKKBdaPEg3daQImb5ke4NqPdXkOUK30enzs
	AmWIlurCuMZyLL7UeVcm7Et9irRr6rXB3j4EGRDlAVOn1FaYZzjx4mS6018w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766026652; x=1766113052; bh=i6nW+KjEck3wZQdgaUqrMzlbaFbG/ci0qPo
	SE59HrWU=; b=pv1VliLbo9xrdON0hNCYnM/2LQPZFwida2WOdGcfXGnYthQlX1t
	50Wka4cxlXgEgxT3fu9uA1cyjxNMld1L1HLSg2ZNnTVSCZGJ6sdUPpCmqjv56Ec3
	rzGr/bKuJavHgy9WU2u3NJw5dFR3Ec7oqhmfqySNzUh23OQLcCze1OErPnjj+yqr
	SizUb+yuhhqHIqwSEP/A5uNmI8NV6NJr5HlfJozLn8MRlqepWeHN2uBHu6bLtHgr
	HhwJCFsjVqeKjv0YYBXXgoeukCU48F4P7mzDM0LKc23uMpEcpR9wIpPU14EcdF9q
	phNB2bfAItkzLwZijbfrXSKRzdVuk6NLbJg==
X-ME-Sender: <xms:nG1DaVL6tZyz42XFG7h639xhoauxV58_ALnxN94GI0eUnoBz3pSJrw>
    <xme:nG1DaYIBKHuMM2BOULv96kI0007cnpdcU1grx5K9wkDrU2nAWVFTXBQwiDUGwgFCA
    CqklH_gXGYYEQX00TzMFBLP9loXLJolBnJzuHavQq_M93gYfhyP4w>
X-ME-Received: <xmr:nG1DaSt-Je-FFc0wgB_xWkIjxkEy6kpn-Gz0jsPMUme98FITO54hfr19tMd1dhjNStakV0AvMUVREFVFB_aJaIVntCaOnoxpBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeggedvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeduledvteegfffhledvgeekgfduueehlefguddutddutedvieeljeethfejleef
    tdenucffohhmrghinhepohgsjhgvtghtqdhfihhlvgdrtgifpdhouggsrdgtfidpphgrtg
    hkfhhilhgvrdgtfienucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpd
    hmohguvgepshhmthhpohhuthdprhgtphhtthhopegrphhlrghtthhnvghrsehnvhhiughi
    rgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:nG1DaVRoFfV7Cyj67WNNo6i9va_o5Z4p9hxQV2NBf5V6fClE-MyIPA>
    <xmx:nG1DaYMZikiW_cHVUOaR2EvvFpjETjdc-0IViBFcpnccxiJ0N2OCyA>
    <xmx:nG1DaabcEmOe_o9uTza-PCGtKMdVjKVtYIgmQQjGP0SCPNEyTnDPDA>
    <xmx:nG1DaSwqOAZOn-hulzXd70uxX_I6AW8OIPYs9auQxNo378HLQ7zyrA>
    <xmx:nG1DadyBrfKYqb45-Lhm6faUP714BQMZVbCXnLyI2T94OZmzDeqRiprd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Dec 2025 21:57:32 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Aaron Plattner <aplattner@nvidia.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: What's cooking in git.git (Dec 2025, #03)
In-Reply-To: <f4ba7e89-4717-4b36-921f-56537131fd69@nvidia.com> (Aaron
	Plattner's message of "Wed, 17 Dec 2025 12:26:58 -0800")
References: <xmqq4ipwc7y2.fsf@gitster.g>
	<f4ba7e89-4717-4b36-921f-56537131fd69@nvidia.com>
Date: Thu, 18 Dec 2025 11:57:30 +0900
Message-ID: <xmqqtsxoxzs5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aaron Plattner <aplattner@nvidia.com> writes:

> I'm pretty sure the problem is when do_oid_object_info_extended() 
> substitutes the blank oi here:
>
> 	if (!oi)
> 		oi = &blank_oi;
>
> and then packfile_store_read_object_info() compares it to its own local 
> blank oi:
>
> 	static struct object_info blank_oi = OBJECT_INFO_INIT;

Ahh, that's an unusual mistake.

The following was done on top of 'seen', but would it help?  We
shouldn't have to use the stand-in "blank" thing to begin with.

Besides, explicitly handling the NULL case would reduce the
potential chance of errors that somebody accidentally writes into
blank_oi, making its contents dirty.




 object-file.c |  8 ++++----
 odb.c         | 29 +++++++++++++----------------
 packfile.c    |  3 +--
 3 files changed, 18 insertions(+), 22 deletions(-)

diff --git c/object-file.c w/object-file.c
index af1c3f972d..6280e42f34 100644
--- c/object-file.c
+++ w/object-file.c
@@ -426,7 +426,7 @@ int odb_source_loose_read_object_info(struct odb_source *source,
 	unsigned long size_scratch;
 	enum object_type type_scratch;
 
-	if (oi->delta_base_oid)
+	if (oi && oi->delta_base_oid)
 		oidclr(oi->delta_base_oid, source->odb->repo->hash_algo);
 
 	/*
@@ -437,13 +437,13 @@ int odb_source_loose_read_object_info(struct odb_source *source,
 	 * return value implicitly indicates whether the
 	 * object even exists.
 	 */
-	if (!oi->typep && !oi->sizep && !oi->contentp) {
+	if (!oi || (!oi->typep && !oi->sizep && !oi->contentp)) {
 		struct stat st;
-		if (!oi->disk_sizep && (flags & OBJECT_INFO_QUICK))
+		if ((!oi || !oi->disk_sizep) && (flags & OBJECT_INFO_QUICK))
 			return quick_has_loose(source->loose, oid) ? 0 : -1;
 		if (stat_loose_object(source->loose, oid, &st, &path) < 0)
 			return -1;
-		if (oi->disk_sizep)
+		if (oi && oi->disk_sizep)
 			*oi->disk_sizep = st.st_size;
 		return 0;
 	}
diff --git c/odb.c w/odb.c
index 01a9d2e70f..8278ef39a0 100644
--- c/odb.c
+++ w/odb.c
@@ -680,34 +680,31 @@ static int do_oid_object_info_extended(struct object_database *odb,
 				       const struct object_id *oid,
 				       struct object_info *oi, unsigned flags)
 {
-	static struct object_info blank_oi = OBJECT_INFO_INIT;
 	const struct cached_object *co;
 	const struct object_id *real = oid;
 	int already_retried = 0;
 
-
 	if (flags & OBJECT_INFO_LOOKUP_REPLACE)
 		real = lookup_replace_object(odb->repo, oid);
 
 	if (is_null_oid(real))
 		return -1;
 
-	if (!oi)
-		oi = &blank_oi;
-
 	co = find_cached_object(odb, real);
 	if (co) {
-		if (oi->typep)
-			*(oi->typep) = co->type;
-		if (oi->sizep)
-			*(oi->sizep) = co->size;
-		if (oi->disk_sizep)
-			*(oi->disk_sizep) = 0;
-		if (oi->delta_base_oid)
-			oidclr(oi->delta_base_oid, odb->repo->hash_algo);
-		if (oi->contentp)
-			*oi->contentp = xmemdupz(co->buf, co->size);
-		oi->whence = OI_CACHED;
+		if (oi) {
+			if (oi->typep)
+				*(oi->typep) = co->type;
+			if (oi->sizep)
+				*(oi->sizep) = co->size;
+			if (oi->disk_sizep)
+				*(oi->disk_sizep) = 0;
+			if (oi->delta_base_oid)
+				oidclr(oi->delta_base_oid, odb->repo->hash_algo);
+			if (oi->contentp)
+				*oi->contentp = xmemdupz(co->buf, co->size);
+			oi->whence = OI_CACHED;
+		}
 		return 0;
 	}
 
diff --git c/packfile.c w/packfile.c
index ce6716fbea..3ffd6c7240 100644
--- c/packfile.c
+++ w/packfile.c
@@ -2132,7 +2132,6 @@ int packfile_store_read_object_info(struct packfile_store *store,
 				    struct object_info *oi,
 				    unsigned flags UNUSED)
 {
-	static struct object_info blank_oi = OBJECT_INFO_INIT;
 	struct pack_entry e;
 	int rtype;
 
@@ -2143,7 +2142,7 @@ int packfile_store_read_object_info(struct packfile_store *store,
 	 * We know that the caller doesn't actually need the
 	 * information below, so return early.
 	 */
-	if (oi == &blank_oi)
+	if (!oi)
 		return 0;
 
 	rtype = packed_object_info(store->source->odb->repo, e.p, e.offset, oi);


