Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104CF18E74A
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 21:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721250756; cv=none; b=MM48K08pfVDasHIp882zVG1GFpySdlCHHF0cnyF7PeUXHnSV8r+d91gFIbVfqohAFQ8oOM+kbdJqeDPaJeZLp6Bulan1rnEpPbVxZ5TEWUFrBMa9EB9yIHUmvKmP2Y5doviZ4xfPRtmvbnrpMI0DICdRpC3t1RYRElx3ePpUH/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721250756; c=relaxed/simple;
	bh=snH9jUej4F5TP+BHwD5nYi44yOSVOmO6I+N5WAng/D8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSs3gEa3TwhCE8CCt/4jktdOBgldpKnsD9G/cA+QMAMPonaRbdQOqrcB1ENP6HtTI/MZK8ZMq6T9jmrBSmlaKIF9l5dgrjXG7UhRsu47jWzKvH2AufsHp4jAsEYkqITKieudLqnMYAwV6RQXyx9hNRI3EPZAe1N+HuZhoATq3M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Q4p1BE8B; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Q4p1BE8B"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-64789495923so949967b3.0
        for <git@vger.kernel.org>; Wed, 17 Jul 2024 14:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1721250754; x=1721855554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w+Wi3QtJrRlEnE0BlHCFAXiBSHl4UPUjPzhPjhJGito=;
        b=Q4p1BE8BwIAJboqKUpsjZpFy4qiylMi1YBuzthLzfwDbfBH9+lenL85cZNrDBSL/A9
         dM2diTZKQj4EKi/hV1sH6OA91q/dq4RjSwmW0pvHBH4sDguns4xMkxipt7NcgJbhbpkT
         VxV+l0eIjOpXoTtKik8k5HYBpXsh4dxZ+c7Jog5zOohdq84AwGj2BgBeNBtqTJkVEPw8
         CBvjULiMpGhS3Ujla25r6eEjKjzg4YkuWKiUMa8j+j99ObUHpaslOUblP843J2ziaP3P
         TVGn9btU5hIltfPyQcwtyVFDTEoi/pRSJZjJCZgw+bdFgxp5ZBHMBkDMKYxQV6elbNDE
         QoQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721250754; x=1721855554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+Wi3QtJrRlEnE0BlHCFAXiBSHl4UPUjPzhPjhJGito=;
        b=PC/sTRpx1+R+xpw8NALSTC0GZcqhM/ThgA3T7zErDto4+mOF56Vh+KuGWMPCfvXZEQ
         3s5KZCA2IOfIa69iFtr5S4Udjzz8vmggK5CC98aKZdFq9vPtOxEt9UdlkyXeFNQB+g6X
         s4U2ahZ25VoUEfZI4vHvNonrmwxoyett8ZSk9HnSC6N+a9Mp6JsGF/y4sfhr3jGUggcM
         dzP8zrwJbbYrQ52zTzYUu7YbN7DD4t+RhquvBrvJtS2B/ZqbG252DVagWsa75w5psx2Q
         +qur3l32dqvxQmsvdNgNPrestCdFABp8Hp2yTAdKBpVeARGt3UFpsH1yYg+FzKfdaNSi
         ZsZg==
X-Gm-Message-State: AOJu0YwXLq9E7y/KtPKWsXiuNkv1+vV9Fn6NfkGFxVZlYmjUWKs48L/R
	zsgunWDT+RknZRxxJeWbXwGAn9lqPY8uN2SOLleL7B0m57jfyy2bqFRY/zQxg4YpGnydp1ZbVgh
	A
X-Google-Smtp-Source: AGHT+IHuve/AoLa7CZB54hUu1HxvB2kGwCynBReOZhw3pP9qdNBjcdyVLcCLKxSO5hU1wlPGHKPYbQ==
X-Received: by 2002:a05:690c:ec8:b0:64b:3e44:e4f4 with SMTP id 00721157ae682-666016fd79emr10230127b3.7.1721250753753;
        Wed, 17 Jul 2024 14:12:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-666025869e8sm760327b3.69.2024.07.17.14.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 14:12:33 -0700 (PDT)
Date: Wed, 17 Jul 2024 17:12:32 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 12/19] midx: teach `midx_contains_pack()` about
 incremental MIDXs
Message-ID: <fb60f2b022d1dc8c0e6df53253dc924f8d00a382.1721250704.git.me@ttaylorr.com>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1721250704.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1721250704.git.me@ttaylorr.com>

Now that the `midx_contains_pack()` versus `midx_locate_pack()` debacle
has been cleaned up, teach the former about how to operate in an
incremental MIDX-aware world in a similar fashion as in previous
commits.

Instead of using either of the two `midx_for_object()` or
`midx_for_pack()` helpers, this function is split into two: one that
determines whether a pack is contained in a single MIDX, and another
which calls the former in a loop over all MIDXs.

This approach does not require that we change any of the implementation
in what is now `midx_contains_pack_1()` as it still operates over a
single MIDX.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/midx.c b/midx.c
index 59097808a9..0fa8febb9d 100644
--- a/midx.c
+++ b/midx.c
@@ -465,7 +465,8 @@ int cmp_idx_or_pack_name(const char *idx_or_pack_name,
 	return strcmp(idx_or_pack_name, idx_name);
 }
 
-int midx_contains_pack(struct multi_pack_index *m, const char *idx_or_pack_name)
+static int midx_contains_pack_1(struct multi_pack_index *m,
+				const char *idx_or_pack_name)
 {
 	uint32_t first = 0, last = m->num_packs;
 
@@ -488,6 +489,14 @@ int midx_contains_pack(struct multi_pack_index *m, const char *idx_or_pack_name)
 	return 0;
 }
 
+int midx_contains_pack(struct multi_pack_index *m, const char *idx_or_pack_name)
+{
+	for (; m; m = m->base_midx)
+		if (midx_contains_pack_1(m, idx_or_pack_name))
+			return 1;
+	return 0;
+}
+
 int midx_preferred_pack(struct multi_pack_index *m, uint32_t *pack_int_id)
 {
 	if (m->preferred_pack_idx == -1) {
-- 
2.46.0.rc0.94.g9b2aff57b3

