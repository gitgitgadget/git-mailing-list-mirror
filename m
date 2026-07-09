Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B2A3F0AA4
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 08:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783586178; cv=none; b=fzCmnzsLOP/ZTdlE2DwxzU6wTTbGTZtgKB3IEoJ8rQUa3A8Sx1/qjk4ROuao5vLd7Q7yjCPAobTVP0Z9Awb1nm1sI67I6fALS9ELLhrl+MxVsIe6BQCBkhcIGerb3TXKL9FyecaqyFEy6ukK3f4ef2mkvbYuhO9O84NuJVokCbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783586178; c=relaxed/simple;
	bh=LEODIFXeE3AwE8gu63dPuyOiHLVns0JmFd/D0/rFr+Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Go50kX0W122TPrUvWDW1kP3y7xubEn3b6DBzK0ZCr+dv8j9kxlqR3GsT5FWlvm3oa8C4lAbvRZ0cAGKni6ZZ6ZDFJm6ExTd1OboRJnwaNKH44+jsRDC4t3IdHH1Mtsy0SLkWonjcalIQS+Y3WxUHMSY9Cw3OXMnbLgN+gNsB3kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Mt4KllvD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pc3V2+39; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Mt4KllvD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pc3V2+39"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ADC0C7A0097
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 04:36:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 09 Jul 2026 04:36:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783586176;
	 x=1783672576; bh=jT+HC6lpz2DrOAlmnSdUGT4WuE+216XowrigIR0d/mg=; b=
	Mt4KllvD547rj3tZYwAzFJsA4Gv6qr++NA52cet4ZBQMDQTOxTdTAx77mmPzY8TB
	ChqUVupjEc+Z3BpdhI+91y7jyRP4Ez88c8ISQz3wNjdOv0U8R2ZZr2rqHqubOF91
	Ld9JJ7GgXeexqCLzaHQhpWjVnboMV4kJKpTT7XLULqdhA3pkTH5RtRU+AvWmhhJ/
	6QC9kLjPhBwOPqYzf4GBGZphlLQ0LkHdRy6aPIdyfqYczRCGNtcSzkm8zDic6aHi
	diIYZ165tOjfjxGfQLt6a2t4FQV9Q7mJoHkkXyUpT40nkDJ/ZUAt4LS0t5eh7NxZ
	3vCPO5Swn2irhfPojm2trw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783586176; x=
	1783672576; bh=jT+HC6lpz2DrOAlmnSdUGT4WuE+216XowrigIR0d/mg=; b=P
	c3V2+39KSlPl81/WMHfIvoqtW3YoBK1BW897xxNyeG2gsnZaFAak+24hc6RXnlCx
	rP+kmTb3fl0ehDpXeq9WtQDwYa09/u/SaMix/ZndzqqoHM1cpJs7CT8QUMdMED5q
	MMZIhQbmxwU+x1QO1YdkVf1CRxKAsQcvN7Osk/r7CtztOhqXvCG9FvGTVMT6Lm5G
	pr3UDuIzfj2+CjkcowEGYOiMxcXGKU6XiwCGrbZmuUYLjx3FogXrshjh2x01GQSf
	JQ6AhJJiy/iL1FMu95PIt2pLYBhvwJRvK6Bh2lRG80gRfv6NIg+vgISrq0+i5IX6
	yrcgpi66cAGqRERoLLXNw==
X-ME-Sender: <xms:gF1Par5qYK-B30_ATFjsEkl1-Gzd2tX825HvhYOeNNTye0Wyn0ATBw>
    <xme:gF1Pan07vB3qYCFNOu4RwSvVjRISDlKTJinwqCF45JRPxTVGjZd9uG2jIZPFmfdT2
    GRBOWlO68quYN7kt05-msN3LmwvMANq7jFtNYDFCJMlEjfff9v3Ug>
X-ME-Received: <xmr:gF1PaoEN9n9iECyRVE4IGfEKWd4phCA0_8hfmxvrYNDuljfsaEtlBzo6LqU34wz4AkzqiTnNG2Wn27fdr86U3-7efFbWGFzEUy3lYuy9Pw>
X-ME-Proxy-Cause: dmFkZTGVX3wGpxpiSCWJAJLYw56uc7AsI8lzGGtirC1PyeoNkmCS9OJmVpj2C4zgT0w4Bv
    fRRIRvb2Zgw11cWYDofZgFH3L8ZF9LsrJVYGp6LyzbEvhWT3LGZdU4A11BhGzHT71Yozqo
    8bJhwHECnddG8lIqfrPNfvCfxUxE/oS1mFXHxRylUQj1j9URASU8hVG3yejfXf6fflQiuS
    bLeSzH21T8lGztv+qF6FixffIjzLX7LOEToB+wMzSeOPg+ZmdRQOrM2RnxJ5HFz8KjjTBj
    pcZnHacq2D3zm2wPW5y60IfhSgZnCjs5gOfOMOVVOkwDcsrHxYXboZUOONGkZnkoLLnIB3
    sdxMKvfU9FOQgFZ9lldOmTOXAvx+NN8x8tqRQJnAVR9M7Wb9EQE/MsWbMxGT56ek3sqKsa
    U8al9fppaD9Ep7zsdbtWGEORlsGfhUaQ5i+VpDmLZiqEqJshZHu0Nsgqw3cZeDzssGM5Rp
    O79LA+jriqyKEUgN1YDdvLCTOG16UAzn6UmoFDsTZZ6tpmKsq+zjOIfqfRJpM9lShUnOF6
    FtNGUAyEBnwW/Qu8C0xtvysA72qB2eCYLpXKP8IsdnmOwHUmOtKZthGZQuhPAg0c6/D8ra
    jrpHH6MrW93KZMA3QKEX8QHZDe4u1upmFcRw0VDySWIFKLofLtKe2NN3siBg
X-ME-Proxy: <xmx:gF1PahQnR0WBrSRwN0UR2ETaAbIFuF3HeNVlUbOcBsx6_cSMc3rveQ>
    <xmx:gF1PavCQ_GtY4TYUfrPWWDekipRDEidd0WfnGBflDUkpLKFHe-Swqg>
    <xmx:gF1Pah1DrGP0rN0JHyqWo00-eR_xn28yFZrca6dNkBKleJMOSXsUmQ>
    <xmx:gF1PatWqX0g-AF_vrGv1BMfIztD2WIc7pbCb4qCwOwRgwOZnzdxX3g>
    <xmx:gF1PaoZjY7x5kw-WzTJYv7MH4AqhrG9sMr62l7ZF9-Lcuqc-1A4CJrWZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 9 Jul 2026 04:36:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 311dfa30 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 9 Jul 2026 08:36:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 09 Jul 2026 10:35:24 +0200
Subject: [PATCH 4/7] pack-bitmap: iterate object sources when opening
 bitmaps
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-pks-odb-for-each-object-filter-v1-4-82fe014b12b3@pks.im>
References: <20260709-pks-odb-for-each-object-filter-v1-0-82fe014b12b3@pks.im>
In-Reply-To: <20260709-pks-odb-for-each-object-filter-v1-0-82fe014b12b3@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

When opening a bitmap for a repository we perform two steps:

  - We first look for a multi-pack index bitmap in any of the object
    sources connected to the repository.

  - We then look for a packfile bitmap in any of the packfiles of any of
    the object sources.

Both of these steps thus iterate through object sources themselves, one
via `odb_prepare_alternates()` and one via `repo_for_each_pack()`. This
layout makes it hard to introduce a way to open the bitmap of one
specific object source, which is functionality that we'll require in a
subsequent commit.

Reverse the loop so that we instead loop through all sources in the
outer loop, and then for each source we try to load its bitmap via
either the multi-pack index or via a packfile.

Note that this changes the precedence of bitmaps in one specific edge
case: when an earlier object source only has a packfile bitmap, but a
later source has a multi-pack index bitmap, we now pick the packfile
bitmap of the earlier source. Previously, a multi-pack index bitmap from
any source would have taken precedence over all packfile bitmaps. Given
that object sources are ordered such that the local source comes first,
this arguably is an improvement, as we now prefer local bitmaps over
bitmaps in alternates. Furthermore, we already warn about repositories
that have multiple bitmaps, so this setup is broken and thus arguably
not worth worrying about too much.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 pack-bitmap.c | 65 ++++++++++++++++++++++++++---------------------------------
 1 file changed, 29 insertions(+), 36 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index eda38a5433..0e3e18a557 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -680,60 +680,53 @@ static int load_bitmap(struct repository *r, struct bitmap_index *bitmap_git,
 	return 0;
 }
 
-static int open_pack_bitmap(struct repository *r,
-			    struct bitmap_index *bitmap_git)
+static int open_bitmap_for_source(struct odb_source_packed *source,
+				  struct bitmap_index *bitmap_git)
 {
-	struct packed_git *p;
+	struct multi_pack_index *midx = get_multi_pack_index(source);
+	struct packfile_list_entry *e;
 	int ret = -1;
 
-	repo_for_each_pack(r, p) {
-		if (open_pack_bitmap_1(bitmap_git, p) == 0) {
-			ret = 0;
-			/*
-			 * The only reason to keep looking is to report
-			 * duplicates.
-			 */
-			if (!trace2_is_enabled())
-				break;
-		}
+	if (midx && !open_midx_bitmap_1(bitmap_git, midx))
+		ret = 0;
+
+	for (e = packfile_store_get_packs(source); e; e = e->next) {
+		/*
+		 * When tracing is enabled we want to keep looking to report
+		 * duplicates even if we have already found a bitmap.
+		 */
+		if (!ret && !trace2_is_enabled())
+			break;
+
+		if (open_pack_bitmap_1(bitmap_git, e->pack))
+			continue;
+		ret = 0;
 	}
 
 	return ret;
 }
 
-static int open_midx_bitmap(struct repository *r,
-			    struct bitmap_index *bitmap_git)
+static int open_bitmap(struct repository *r,
+		       struct bitmap_index *bitmap_git)
 {
 	struct odb_source *source;
-	int ret = -1;
+	int found = 0;
 
 	assert(!bitmap_git->map);
 
 	odb_prepare_alternates(r->objects);
 	for (source = r->objects->sources; source; source = source->next) {
 		struct odb_source_files *files = odb_source_files_downcast(source);
-		struct multi_pack_index *midx = get_multi_pack_index(files->packed);
-		if (midx && !open_midx_bitmap_1(bitmap_git, midx))
-			ret = 0;
-	}
-	return ret;
-}
-
-static int open_bitmap(struct repository *r,
-		       struct bitmap_index *bitmap_git)
-{
-	int found;
 
-	assert(!bitmap_git->map);
+		found |= !open_bitmap_for_source(files->packed, bitmap_git);
 
-	found = !open_midx_bitmap(r, bitmap_git);
-
-	/*
-	 * these will all be skipped if we opened a midx bitmap; but run it
-	 * anyway if tracing is enabled to report the duplicates
-	 */
-	if (!found || trace2_is_enabled())
-		found |= !open_pack_bitmap(r, bitmap_git);
+		/*
+		 * The only reason to keep looking after having found a bitmap
+		 * is to report duplicates.
+		 */
+		if (found && !trace2_is_enabled())
+			break;
+	}
 
 	return found ? 0 : -1;
 }

-- 
2.55.0.175.ge4962bd3d5.dirty

