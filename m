Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8982D5C87
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 11:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752059878; cv=none; b=CKWCVp2Vff68bpKp5/jsNqFCsf7ck71hq9xjBeSY0LDWNV3eUKyQAhJaH+pTp5bfIemjK5YeFR106caH857dQ+aQvLyayvwczyS44l1X3B9EQlBxEhVVCnrbknIfY9mQYljQSJA0qa0wQp47B7/+tZAi7mMklo+Pm4SB+myWT+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752059878; c=relaxed/simple;
	bh=tlSLOTNGz2h7uSEQE2IG2X942+fqy6m/27Iz/AIkNQs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WVi9ttyN0kEgLyOEGe2xZwnDqG8RTvTB7bagi6NPjQR+5Lgh6hCL2LZ9ZyOzB4olRYbr4CrBFNz1GonWBBCsVoIWX1q8q6yUhanX9K9gOdupcWWmvaKoqvQHcnyYiwNlHwbP+gHbbbZaS+z5jOXB49EISPJf5GsGDqwISE9cPPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HS1DYaVB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FWlOB/2M; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HS1DYaVB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FWlOB/2M"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EDF981400342
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 07:17:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 09 Jul 2025 07:17:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752059875;
	 x=1752146275; bh=cMvJlbVjtz7fwyB+6QZAOrjpK1K1wHyb1u3ldUAZtjA=; b=
	HS1DYaVBamhDRTv3PhhEDlvG/SefybkRH2qmGWkcNuwid9KQlNNYzfSzIX0nqef+
	xxyZnwqB4/SSxQ3vSXTmcoXuoN8WmuuG0j/DmsAdlJfKb4whZRPB/j+BQnMgVNh4
	d1UbhyFOvgbTupPIKWqlkfGeyyMi9cNAy+TY36ggYQCXzrsg5fS9o2+5Jl68Zr4m
	3J4SWts32XAPFO46szfVWKBliR1S6KkykoeTjquPnpn1lxVLcSStWYyfwBp71qoX
	aGoMssY9N6U1uFujYNZTnCUtV6KBF/lmwpQBVoKEQi2cVPgtdvLKwWp0pMDZl+d+
	fOGVMJBp9inu7Pkpa/DXsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752059875; x=
	1752146275; bh=cMvJlbVjtz7fwyB+6QZAOrjpK1K1wHyb1u3ldUAZtjA=; b=F
	WlOB/2M0z5eFJW6S39zRDViuo4kbctAot1AMXQkG/3p7LcQ55HJzDS7ZmzYmONlY
	IYyxJR/MVXEnbOFyWwbAvRBSu3ClbXix8kCc94VOHvfBLxIGdXwPp3K/Vp/lLWid
	Ki6RxhJKGCRhOWnybCByuDeutcyWAiHa6BEDPh2gIiD+ciUgGo3W1UXaUTMsQn5f
	4UI0uoeNCW32yvMje3J22QCqgphMNBKlTeIkg40oaXJQXpIs8f6kJ/o2gKyav0EQ
	V2ZfRynK55w0kb4yRrr1gGbDudinUGXSlN891IrYC4jRdu+uAYNgA4aLcipVIrL1
	W04J8aHDC8SXRZiFMNNDQ==
X-ME-Sender: <xms:409uaPQrV_OhTNTHe8rbHQd4ZqmNPXvJ-ABFG9Lo4VqxE1N8LfbHdQ>
    <xme:409uaCxarYbag9ogJ5IhUULUJGsZ7VSsgZClSifBWHHzhrsXJTdRHCvok8ZHPT-Bd
    MhZk5gizCfgD-ax0w>
X-ME-Received: <xmr:409uaONt2Mca9IbTlws6Be0pYtm5wqCQod3VEGO_33yJVHESQMWs8l6VTRO3H1XR02bLkZKoyhEY0LkrVibLltM3vdlX6zQI7Ydd8493csAAdQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:409uaBOxSVLIq2cBRWkuWGe64LHOvTZfuhQaUIhT-wZam1-4FCqrqw>
    <xmx:409uaARkprfkGvDG9aUppnRR04rkiGd7e0wtbpJQ5ydMtkZd6LCKKg>
    <xmx:409uaDA3Y2oh4GGqU0pamUwxy_yLsWHsq3Ar46lSNTzipTxKxXcNbQ>
    <xmx:409uaPg-p8hrsUfTqA8hacrWwxOK8uoCHTPIyTYzi3HWGXslFVeLeg>
    <xmx:409uaMJA36bQNl5vvqCbOUlWe3kEKiI-FVT1q3uerRmxaDMBYUqB4Dve>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 9 Jul 2025 07:17:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 907ffa51 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 9 Jul 2025 11:17:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 09 Jul 2025 13:17:22 +0200
Subject: [PATCH 12/19] object-file: remove declaration for
 `for_each_file_in_obj_subdir()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-pks-object-file-wo-the-repository-v1-12-62627b55707f@pks.im>
References: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
In-Reply-To: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The function `for_each_file_in_obj_subdir()` is declared in our headers,
but it is not used anywhere else than in the corresponding code file
itself. Drop the declaration and mark the function as file-local.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 14 +++++++-------
 object-file.h |  7 -------
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/object-file.c b/object-file.c
index 5a936f17148..bd93f17dcfe 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1318,13 +1318,13 @@ int read_pack_header(int fd, struct pack_header *header)
 	return 0;
 }
 
-int for_each_file_in_obj_subdir(unsigned int subdir_nr,
-				struct strbuf *path,
-				const struct git_hash_algo *algop,
-				each_loose_object_fn obj_cb,
-				each_loose_cruft_fn cruft_cb,
-				each_loose_subdir_fn subdir_cb,
-				void *data)
+static int for_each_file_in_obj_subdir(unsigned int subdir_nr,
+				       struct strbuf *path,
+				       const struct git_hash_algo *algop,
+				       each_loose_object_fn obj_cb,
+				       each_loose_cruft_fn cruft_cb,
+				       each_loose_subdir_fn subdir_cb,
+				       void *data)
 {
 	size_t origlen, baselen;
 	DIR *dir;
diff --git a/object-file.h b/object-file.h
index eca323f9736..d52b335e85b 100644
--- a/object-file.h
+++ b/object-file.h
@@ -86,13 +86,6 @@ typedef int each_loose_cruft_fn(const char *basename,
 typedef int each_loose_subdir_fn(unsigned int nr,
 				 const char *path,
 				 void *data);
-int for_each_file_in_obj_subdir(unsigned int subdir_nr,
-				struct strbuf *path,
-				const struct git_hash_algo *algo,
-				each_loose_object_fn obj_cb,
-				each_loose_cruft_fn cruft_cb,
-				each_loose_subdir_fn subdir_cb,
-				void *data);
 int for_each_loose_file_in_objdir(const char *path,
 				  each_loose_object_fn obj_cb,
 				  each_loose_cruft_fn cruft_cb,

-- 
2.50.1.327.g047016eb4a.dirty

