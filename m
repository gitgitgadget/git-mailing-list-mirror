Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBC02DEA68
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 18:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771959580; cv=none; b=i2lF9z58FHUekol2/63JHxgKsxk0y0vbgPVQAHCO5hQx/3EsoCqi5Xyc1RmHomRM5rCzbAXWS2VeJwr4zFEy6x0kDxyKiuPUlBQzvgBirndM4TtDISCHnfQa/LgeYDK/8b+lB/oQlSrKjV1eriJVFqLMf37Uuf59nBkh0ps8O2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771959580; c=relaxed/simple;
	bh=R2mAlmO+j/gfxhZChm/HJW8F7ivo5KneYJSOSKASKiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQGOSHu3dGbMDMhek1x40CsGIb/Bmaq/ZG46mcIWdy1SrhI6Ps3N42YUbflMWgMLp58rFzIgzONlqTjrZ8pC1h6PzJKxlo2LaDwTBpwpY2TDxP8ew3T+Zmr6RNAv3wlrLv6es1gwAk5Yix/1tYzqMk060HQKFEV60RQ8wyCnvyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=C+ezPkPV; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="C+ezPkPV"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-899b676b5d2so537156d6.1
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 10:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1771959578; x=1772564378; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qm15wYqbxb51bd6vH5UrINPi0m0FP1V+cLUjAE/lJH4=;
        b=C+ezPkPVbGk20aofdxKvRBpd/iwW1xXPY5KBiFaYyVdVi7QKM2lAhiOHvLDWClu4S2
         0IOQod3sM0g9Eb8h3LBSNr21TM9UXfmVyjVrBoWJMBVXQcNbU0MSMz+HvfE5rMv9kdLS
         v2V8gYrcSlVUAPmEtG2ofLR3g5lkd8dT+X+aduWmpQ6NwOQegqOUIgL1hS0+p0kDbcKO
         UomFg9mCDRrYbtd301KlE52XsTc0g4Fq362kbZTsgq94lUK/B4sXghrRzYkXLgFGrO6b
         jjgci8h4FT1oSbk+teE7xB4UFMZ7J+EwtCUZnArWIVZfwRVSZl22AnAIWmUETVk1bsNl
         CfQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771959578; x=1772564378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qm15wYqbxb51bd6vH5UrINPi0m0FP1V+cLUjAE/lJH4=;
        b=QKGmEbvaviiy802ucrerriPfiL0Ll9focoXWb4zMvVgzRh7iJHAEADXZm7cv1yGnsl
         d5avLvx2z7D49RDD3Kx6pRPXtu5UJepAfmyjU+UpZ8LG/ECgPCL2IwAqpE4h/3sRWQq6
         C138JKj/CNa6e4yDnGY+P7dKbauJnRrF56tNgg+r0EcdpspxuTpRDaOoHdXH6w5ChtD3
         vjUBnv10MT7VrfgzdtOu5uFEBwzuOKoH2YxxQgw4PLpsb8KFEPSSz7r77TsUnLX6GNxL
         IuvzBMnZtOcRcHrvN7GtBvTl3vuC0bfAW40yBU+ZqnlN/BU0wqotALVm/u8wmTsoSDcm
         4FSw==
X-Gm-Message-State: AOJu0YwB3+yIJ3UHTNMQCpIjIFcuEsNPf/BJQXnEfV2eI6l8JlX1pEPI
	nshNFMPZ/mEwa/hzFNHkq8K/0Rz6fwkMQrulVTvbN9kRcQVMi6PrxyN1XNnfZMIcSWNpZQgYEmV
	8h8bBKJWsZw==
X-Gm-Gg: ATEYQzxesaLowV5I8YH/rThl2kJlA2rTgp0w+tsFfA4vZ2rVt+QWloWB+nfbsw63FYs
	COCSp++KmNUZyskc4y1CAF4X0PGc4RqRysC+RHJO8u9XcLN5cnXnUJnIQim2J6bcd9cA+lpPaQz
	VFQMR5M2r3SFmGE7mAYRCMVeIKoxdWwIXNAfJvXk0vR1jIo8t5HSdd4F1budsSPZ6Pgan+LuPRm
	jGnbDVGx5Dq+NiAJHMLRH7KcsDBaM+ildkWoyEF65k0UrPifvUE4gP0kUtM5AXcPheR59MtyZeC
	OBlcxTOu8Tn92ROz7wEEm66KwhuG13yZ5pqUDYCVd0QdFRxBfx5leDPIAdJBX/79GAs1MVpiK/w
	3acyWd/Y3HpT6Auyot5p61iTUDNLmh1dxP+VXC2emlKtcBDV7/885vDwM5onYsGmVdhEinOBfDN
	lIY8bEygwXqcHRfVenuPB+iYhcqXIAoebOmJbfyvNjvRDkQYZ0zjnaLlAraLPB6zpMslWaF2UJq
	7tmhaQFLEPb0pIJxSd1Wus55DAk5w==
X-Received: by 2002:a05:6214:da9:b0:895:3ec:9e6c with SMTP id 6a1803df08f44-89979c5612amr197940806d6.1.1771959577803;
        Tue, 24 Feb 2026 10:59:37 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997e62ffdbsm110866886d6.43.2026.02.24.10.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 10:59:37 -0800 (PST)
Date: Tue, 24 Feb 2026 13:59:34 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 01/17] midx: mark `get_midx_checksum()` arguments as const
Message-ID: <61045c604c046c40434f98b81cc039be06f79f2d.1771959555.git.me@ttaylorr.com>
References: <cover.1765053054.git.me@ttaylorr.com>
 <cover.1771959555.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1771959555.git.me@ttaylorr.com>

To make clear that the function `get_midx_checksum()` does not do
anything to modify its argument, mark the MIDX pointer as const.

The following commit will rename this function altogether to make clear
that it returns the raw bytes of the checksum, not a hex-encoded copy of
it.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 2 +-
 midx.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/midx.c b/midx.c
index a75ea99a0d4..2a6b18954c5 100644
--- a/midx.c
+++ b/midx.c
@@ -24,7 +24,7 @@ void clear_incremental_midx_files_ext(struct odb_source *source, const char *ext
 int cmp_idx_or_pack_name(const char *idx_or_pack_name,
 			 const char *idx_name);
 
-const unsigned char *get_midx_checksum(struct multi_pack_index *m)
+const unsigned char *get_midx_checksum(const struct multi_pack_index *m)
 {
 	return m->data + m->data_len - m->source->odb->repo->hash_algo->rawsz;
 }
diff --git a/midx.h b/midx.h
index 6e54d73503d..7c7e0b59121 100644
--- a/midx.h
+++ b/midx.h
@@ -85,7 +85,7 @@ struct multi_pack_index {
 #define MIDX_EXT_BITMAP "bitmap"
 #define MIDX_EXT_MIDX "midx"
 
-const unsigned char *get_midx_checksum(struct multi_pack_index *m);
+const unsigned char *get_midx_checksum(const struct multi_pack_index *m);
 void get_midx_filename(struct odb_source *source, struct strbuf *out);
 void get_midx_filename_ext(struct odb_source *source, struct strbuf *out,
 			   const unsigned char *hash, const char *ext);
-- 
2.53.0.171.gde83996e422

