Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08912D3202
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 11:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752059891; cv=none; b=UjM39vdoGNQ8F2KhqzNX5FP7DD5RNrR2SgZEQBrMmQGbzxcGC7HemNIwqbthceHJgyKcUzW7NKXEJK4LYP/O9sN0/63W85fMRnuR+UK4HgcJAUr9oZxuzZQLp50Uq88ddAbRwHaDUbiQ2LAGnM6aTuPF2U6vQxd0xLzNOwLd6p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752059891; c=relaxed/simple;
	bh=bK+mXAE78dHzcS0nLwuGAhNPlSlhXa7iAfRWKNFcj/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q1ViSbmhASOis0pJV+gXQDNEcvrIMLDBtZMo4B102mZhJvCc49izSDQwVfZo+IYamJX1d0konKXpSQKejrijyEDNljsAKthNjmbSv6A3OHc8Kcad5GQtx2zXsaY10i36+O7QXcXxTFaHSwzd1w/y7o7wpY2wGlr4zfqetzgLsL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BIcHNlkl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YY7Ve6b8; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BIcHNlkl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YY7Ve6b8"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0D0871400360
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 07:18:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 09 Jul 2025 07:18:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752059889;
	 x=1752146289; bh=UoVIgvSqSr3rBz94Mq2vHziTXbhzCUysvi7sbb3TIgg=; b=
	BIcHNlklJC8ydJPxOAPY4/4oTrfd0mFO4SZXYY3HVqQT+Z12LELMJus2w+X3g6vF
	Qv9wusxlsbnLeG2BTHId57If9TQw419riBSHDRP5iQ1ikygXFp46RKNMSxUopnCZ
	1bIdVdQb3P5nCbr5Q8jLRs3nQDQpUSfUY53DB+V/r5RKQFMUO1ixXj99Yai7Gb4C
	bkrEfoaTt7FXi5+GlpjZobR1lLMgPDIkhvkMdQ3xmnopjSJClMC+AQl2mBItELmf
	q8g06He3bwc+Mq2HRap4PnJWVE+UT/RVtfKws9Ep02PH0Vghk9ipFnbqh9yVO1Sj
	bR8QI7D1G276HGncKbupEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752059889; x=
	1752146289; bh=UoVIgvSqSr3rBz94Mq2vHziTXbhzCUysvi7sbb3TIgg=; b=Y
	Y7Ve6b8BDqnMByic8P1YF5qUFg3VAOuiewi5LQ0dRR3Eu6l/pMxiXLItJsCbEbC3
	kaYORKK6O0PQ/Fm6iP1CNVaUrOSlexByacoedGmTd+O6vW6/Hrwh/E+vUGq1Nn3X
	KmRXtoTmyV5glHbhv9vW0/OQxAb7csGvOC8uIQSyxlqiT8g7MqmgBLIE+CPv1eoc
	ZWoxjNR4IFKqEm6IQIawnBVagVpVnG5YrbvQeXBEl5bG8kchjFvdEDfjtOTlBNJv
	BviWgiLZpNKmZz2mcxL5LEWSDXAivfyM3TO+5/pEZ6JEoO9D3rjIE9033DhRQW6L
	CVYraD1Gz05jS6oZ1AjbQ==
X-ME-Sender: <xms:8E9uaCDDD8pbkMm-VJnxwYkAz4mFGmK2zKOxJ7Vw7uZ8uYazQJ6NGA>
    <xme:8E9uaOg_p0-YjT0TtTSS2g3hNhyfGsR69cwHqMVK0UyK0EcUQhsMg-iQU9RvLNLg4
    NUR78GCoWer8aAEbQ>
X-ME-Received: <xmr:8E9uaO8m9q90s8yxVvIKFHDx6L07r5njdYYCBFOarU-Q7MHlKtO2N6Qn7J0aCjcahLv5Y8ntIy7lXoFcBl8KcuqN-oExn1FQttT-eCGhT0x85Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:8E9uaC9DQtqIOyJDTVvmgZFDTadXrGbGubDgqUwmiWFT-F1-LKLq9A>
    <xmx:8E9uaPDBken2bXZ4SmY_hNCcImhiCRpwxhLaHQCIEIQsq5ytRD-lAA>
    <xmx:8E9uaKw8jF9GJSSJEXVTeHoaLX3HcV5zyum09stCkHepcC673WFo9A>
    <xmx:8E9uaMT8W5xj0lnDdtc9lYgqrtovGv006FmBnw5aVuJQP6ci_6UuTQ>
    <xmx:8U9uaN6R0NJWoso9ji-RDaHll5Sk7yOjffyUPBuZx_VOSR09pR3GJVjO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 9 Jul 2025 07:18:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4800174d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 9 Jul 2025 11:18:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 09 Jul 2025 13:17:26 +0200
Subject: [PATCH 16/19] object-file: get rid of `the_repository` in
 index-related functions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-pks-object-file-wo-the-repository-v1-16-62627b55707f@pks.im>
References: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
In-Reply-To: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Both `index_fd()` and `index_path()` still use `the_repository` even
though they have a repository available via `struct index_state`. Adapt
them so that they use the index' repository instead to get rid of this
global dependency.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/object-file.c b/object-file.c
index e9152d9e04c..2bc36ab3ee8 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1257,7 +1257,7 @@ int index_fd(struct index_state *istate, struct object_id *oid,
 		ret = index_stream_convert_blob(istate, oid, fd, path, flags);
 	else if (!S_ISREG(st->st_mode))
 		ret = index_pipe(istate, oid, fd, type, path, flags);
-	else if ((st->st_size >= 0 && (size_t) st->st_size <= repo_settings_get_big_file_threshold(the_repository)) ||
+	else if ((st->st_size >= 0 && (size_t) st->st_size <= repo_settings_get_big_file_threshold(istate->repo)) ||
 		 type != OBJ_BLOB ||
 		 (path && would_convert_to_git(istate, path)))
 		ret = index_core(istate, oid, fd, xsize_t(st->st_size),
@@ -1291,12 +1291,12 @@ int index_path(struct index_state *istate, struct object_id *oid,
 		if (!(flags & INDEX_WRITE_OBJECT))
 			hash_object_file(istate->repo->hash_algo, sb.buf, sb.len,
 					 OBJ_BLOB, oid);
-		else if (odb_write_object(the_repository->objects, sb.buf, sb.len, OBJ_BLOB, oid))
+		else if (odb_write_object(istate->repo->objects, sb.buf, sb.len, OBJ_BLOB, oid))
 			rc = error(_("%s: failed to insert into database"), path);
 		strbuf_release(&sb);
 		break;
 	case S_IFDIR:
-		return repo_resolve_gitlink_ref(the_repository, path, "HEAD", oid);
+		return repo_resolve_gitlink_ref(istate->repo, path, "HEAD", oid);
 	default:
 		return error(_("%s: unsupported file type"), path);
 	}

-- 
2.50.1.327.g047016eb4a.dirty

