Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCF83F0ABB
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 08:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783586170; cv=none; b=tIWLz0K1ZAkp7hU0xY1aTMFF2SF0g2XrqW0US6CCEswHhUX2UhS7SnWtvEQxgKHcd2oF6AhBBLakx6BvJ10LTpzJ22hVaxhs+0A028X0/ZKkQa45pDwCdyvRpkM/ysYS6jzIw9kjGvBpQqLkY7ZZV2jAFL1abFsmG9yMxrX5GLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783586170; c=relaxed/simple;
	bh=bcJFjCtIIxzyXkoz5DvakKDxw8t0bDfoQ0sFbJ6YqZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ri7XSU9iZSLEmRRPRTutL4MAyWvWGCYMO5CUgjis9NDRJ7UCm3VQlqgzPqv7MOsk3D5wo3c+IlkxD5XiZaHwDO2txfAgRebjZjVIE9f9Kqbwf2QNlPNC16UBBk42kDxtvv6hkd/QhenGMpGvJ7E12VoYU3qBFQtEbPchw3+phWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QTjwKbDw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LIDdXiqs; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QTjwKbDw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LIDdXiqs"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id C93AC1D000B3
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 04:36:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 09 Jul 2026 04:36:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783586168;
	 x=1783672568; bh=AUNcbGYSojlQavIAFnAtsYbjX18JcU35efgZO8ESrkE=; b=
	QTjwKbDwQziFiaSXPEWtvFblmS81YDhKbzwh4vQVV5JxcSbpQgM7GrVppJ5gUsVO
	RfDTBAjInW9bPDhiB+rGgak1JzEJAhcsuNMQMednDSfrQlFHsLoJgC2ZbBnKqzZc
	ANh6M2Yb+VkzMEl1EFECNMsjZM75jdDvEYVo6JivGexPFPxrMLBtyQ9iE9Sy1JaA
	TI/wkGeC3y72PvLJJ1Wu3+oTKt7PFJfKS6f0+yIgIsjzeWkHI9McmFbrCz0zu2Rm
	p3r/xtRe/Yuz655zvIox/21VpxvToHTxiDsqmaFu1+E8Zl8RvUwZRsJQ2W1kTKcG
	vaqyLS06I7oG38+lkeOIjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783586168; x=
	1783672568; bh=AUNcbGYSojlQavIAFnAtsYbjX18JcU35efgZO8ESrkE=; b=L
	IDdXiqsMmn+RsFJpldOLhrG+65EG+XTI1sSp4xMS0L2kmS1jy7PkS7QQ8Y9fuMqC
	hF3uv0uJ3dajWnt7jaz7cIOkyRDpGLOEEJCm1apcrSckt6E0xA8ajO01kk6Z+uIy
	haqSpBAwjm9k0D6+BmvlLyKmz0y/4q69LCATGLBjyj+b/h0JA1+pFkybwSYFxwqm
	qWBzOFdfUBQA0wI6gvP4PFc7O2sAupPQ56uRMeVFs/FhSBu1y4K5L/KeWWysc0mf
	OcfNlPU1WwZPmqF8MZYurkEIGJ0bpo2vPVoCeOooaMgdUXeOveXMh2MtRfBSdVlm
	TcYnsM5lc69TnE5FfYc6g==
X-ME-Sender: <xms:eF1PahjEFMD0Z-yJHm5_85Ihzw264_quUvKt7c3i8x-Sdi-SH4zFqA>
    <xme:eF1Pas8ixa0KYr43F78GM_zJcQakpILGHSoEa_um20eTDSGl34Qjq2q4TG-ruCGfh
    TiiyE3jUkIEX5nugKhVMDwUjzoBI48ZLZ0feQC_t7THtsNHREjBaA>
X-ME-Received: <xmr:eF1Pams3LC8UO0JfxH4KXutWY2AH4OoNOaOJSGg_TRy7dVmMo4V0ZdKCrQ93HU_-Gmvh9s0EWIgUNwQZuPNZ6kXggqdN8m4z-hBuV_oLYg>
X-ME-Proxy-Cause: dmFkZTGVX3wGpxpiSCWJAJLYw56uc7AsI8lzGGtirC1PyeoNkmCS9OJmVpj2C4zgT0w4Bv
    fRRIRvb2Zgw11cWYDofZgFH3L8ZF9LsrJVYGp6LyzbEvhWT3LGZdU4A11BhGzHT71Yozqo
    8bJhwHECnddG8lIqfrPNfvCfxUxE/oS1mFXHxRylUQj1j9URASU8hVG3yejfXf6fflQiuS
    bLeSzH21T8lGztv+qF6FixffIjzLX7LOEToB+wMzSeOPg+ZmdRQOrM2RnxJ5HFz8KjjTBj
    pcZnHacq2D3zm2wPW5y60IfhSgZnCjs5gOfOMOVVOkwDcsrHxYXboZUOONGkZnkoLLnIB6
    cp6xOZ8DL7DOYd9B9q3zurHku+cxOJwGfRdUPHE/JIEi1UtsAHM1yv6HpFP5o7O65VFXq1
    Swh9bBKL6S3asn+oIo+WoonXmXxFM1eUiY5S5R51nfPnEDsuh1mrDNNZQ10XgcuYNTy22M
    YD+dcMCw1wAVnhOORSEYt57msn3Iqf78FYd+AgfMMhcvZuamd/pdZKKRNXwgfUkPNhxYl+
    XMgUxf8Ce09aJWB0l98PcoUF6tuXCYYf+Prehrq+xFCRHXNjpo8B0eW5yyeUuKxr61TPYe
    Gy6fq0Tz4IGWY5+Q5TOt0YaeTk7M7EzYpxfUGcCy3Cz2snQsd2o7j0/sIbXA
X-ME-Proxy: <xmx:eF1ParY7txjo1WKkM6S_wRlQceHilchCvvAsI0Kp0Mx4ro0kwJhbMw>
    <xmx:eF1PaurllqZ-3m61bmRLwAT_x4JA23l2iK5SxJWh7AoxgEqDEN5MRQ>
    <xmx:eF1Pao8NMyJ4msTA_FZgVcXgjvbakuf4iSC0-TVdD-csRznBFAmJIw>
    <xmx:eF1Pal9Jvv5grZYkkZqrrW7PW0FM1TepRWsKXFgOZ_s72eTElDjYVQ>
    <xmx:eF1PaqjkaWXW6FJh3hB2TlX6RgiXwm2-ykj3y1z8eRvEtiyXx2qSI1hO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 9 Jul 2026 04:36:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6bd26805 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 9 Jul 2026 08:36:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 09 Jul 2026 10:35:22 +0200
Subject: [PATCH 2/7] pack-bitmap: mark object filter as `const`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-pks-odb-for-each-object-filter-v1-2-82fe014b12b3@pks.im>
References: <20260709-pks-odb-for-each-object-filter-v1-0-82fe014b12b3@pks.im>
In-Reply-To: <20260709-pks-odb-for-each-object-filter-v1-0-82fe014b12b3@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The function `for_each_bitmapped_object()` accepts an optional object
filter. This filter is never modified by the function, but is not
declared as `const`. Fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 pack-bitmap.c | 6 +++---
 pack-bitmap.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 35774b6f0c..a47c231632 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1976,7 +1976,7 @@ static void filter_bitmap_object_type(struct bitmap_index *bitmap_git,
 static int filter_bitmap(struct bitmap_index *bitmap_git,
 			 struct object_list *tip_objects,
 			 struct bitmap *to_filter,
-			 struct list_objects_filter_options *filter)
+			 const struct list_objects_filter_options *filter)
 {
 	if (!filter || filter->choice == LOFC_DISABLED)
 		return 0;
@@ -2027,7 +2027,7 @@ static int filter_bitmap(struct bitmap_index *bitmap_git,
 	return -1;
 }
 
-static int can_filter_bitmap(struct list_objects_filter_options *filter)
+static int can_filter_bitmap(const struct list_objects_filter_options *filter)
 {
 	return !filter_bitmap(NULL, NULL, NULL, filter);
 }
@@ -2058,7 +2058,7 @@ static void filter_packed_objects_from_bitmap(struct bitmap_index *bitmap_git,
 }
 
 int for_each_bitmapped_object(struct bitmap_index *bitmap_git,
-			      struct list_objects_filter_options *filter,
+			      const struct list_objects_filter_options *filter,
 			      show_reachable_fn show_reach,
 			      void *payload)
 {
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 19a8655457..47935eb24e 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -96,7 +96,7 @@ struct list_objects_filter_options;
  * not supported, `0` otherwise.
  */
 int for_each_bitmapped_object(struct bitmap_index *bitmap_git,
-			      struct list_objects_filter_options *filter,
+			      const struct list_objects_filter_options *filter,
 			      show_reachable_fn show_reach,
 			      void *payload);
 

-- 
2.55.0.175.ge4962bd3d5.dirty

