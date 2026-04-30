Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F1D18C2C
	for <git@vger.kernel.org>; Thu, 30 Apr 2026 00:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777508026; cv=none; b=VQwAV66huqQlEJ7mt3JDb2cCV2edzlfoqqZKfdAjpuB3PZgIRvUl6laFMUIlE+9QCtIN1bYjWWLD4UAJjYvB8nVJZ+wLVBHLURBLSKpXPFUFkPeMBVXsixY83LtOP7lKla5IXCQv4+B/XpBQs/wSvaLltoPX3Iag/muYNImCt1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777508026; c=relaxed/simple;
	bh=bXkXHqPGtCj10ZiF1fHPuS04cYJAV5SyGse9bdTb5YU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oPPQHv84sg/Qh936AgIRpWJ1ieCyWNXAAltCLX73ozHHRwhQA8G4pZ5ibiVZ9HB70D97YuS54+Uilovllqd2WppiwM16+eKTvIplt+v4hWLTPti1PII8XjJczUgGjniSp+axHen0FGpsPZtyfwdEQyH5HVg4195T7G1hS5Otg4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=mSA1k+YM; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="mSA1k+YM"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-79a7109f568so3964617b3.1
        for <git@vger.kernel.org>; Wed, 29 Apr 2026 17:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1777508024; x=1778112824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DzuJdPzcVePIV1yAa18SQsaQ95BVG/xq9tybqrXP1Q8=;
        b=mSA1k+YMbQeNYAR0RQ3hxfPlvkyN4XiRWkSl0HrxG1lsdIoC+GhxvZDxDZ4PUN5GRi
         svCtVnah6bNJpXABHG2SVBQXIeyGerjopTn/6soqsQ6Dbt0m9t2yvt1TBoQ1b/yEg0FM
         9Xb4aX33mfxO27ONLwqpyZo7/WEi6YOZOFobXY7H5r/2qwPGcaHWon6tFOvkjjl9ZDcG
         wH4nsrGm/FxOMLScYtBx7yNlT8Bnzp8mc1uUWnkdFsbA5TvdR+XydGA3BLuE5FeJ/Wtu
         uaNZgN6GuX2AuUVBg/k0AH5z+OW5dbFlqFdXjFkFSeH1jOpD1HrAio+TPJaBFhs0r+Y6
         u+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777508024; x=1778112824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DzuJdPzcVePIV1yAa18SQsaQ95BVG/xq9tybqrXP1Q8=;
        b=oxz7QwvdHW1L8ymxXjPKUTkvxN59FqzLqvRXj3IAPw9UrC8XQrlvtwzuBpK+fK9gUs
         8Ar6RfaGnTwn8IOenzQx7B4raEcsNobZ40GN0njzv2whWZFflDHNfW2Rwmez2HR5wEYO
         Cj9OG0P2pKqJ01mE90Hqp5GiSzIe2jmYDQpW/Le7V1fbAFAUWbN/igm+GNCXL+JM3KMh
         W9j20Z6g9AHjZABMoh/IeWRgm3dKDqpLfb6QI8QbB+ss8+vGnUjml99kyqdJBx/uZ7Sb
         bTw0EP7Ur8zd9e243m23SJI88cSev0wBPhuhbPh+qKVkWdMl+gGS7cWsgFrKvAa1tU/L
         p5hQ==
X-Gm-Message-State: AOJu0Yws+WS425apP4gG1cbxGaUFSSOTa4V+F7ghcgk/GiIqJyqyxVxJ
	FKPxpbsy7jLcRIprl2jukvnAtNrQlSnQ9pcD3NfTB7/qTSbwtP3rzlzGIy0C/iRd0RpCy8D7K3N
	kV7E00kjAnQ==
X-Gm-Gg: AeBDiesVuYDaUj24/I8xVNek5RXuRRM2neaVQ3S48J7HEuJN9z7B7sGKn6p7BRToJjk
	xvXxpsRISrYhaFXBZpUk64jbAAjQqyBNobsRySvzKLDknwi/xhcOqOqfjvkKR5uFlrLjeCFWqtj
	ncpXRFgBgReZqwW1sGhCBlEzJ4EtG/rRjARodnoMeXbT/xbinJ+eN/2uRuB8/IXK49BkvxlZclx
	rd/TNvD8a9j2C+YFBa+vqdzxA6HKd0ZEzWcp8JtO7YtKkETZ+A6Ax5VrkxgC4LT7esoQMZ26Pq/
	gKsA4sZCfzs0vxHP164+vOZsqGLS006GD835yI7S4olWVdmfvnmDRZpmfDyGFQa1HBwTbuvLi83
	yxVxE7fXGWjPVxQ8YITbN/n27A8eSOu9jUsFb2RYBDsnEEbaRlYD5vBMLkJ9rQ2B9XF0nQfQPCr
	eMLunZ/ItaaF3FglGi5c7E8A/aiYy658aS94t+jBasS8zp2swClPCOCf6IDPuLw/LqKYsfQopMO
	jP1LWHRtGkL3nK7T4S4POI/vHqHchE3pNswxB1yXzjbkIANCJZgWLoGvM/Poc+fygeJ9JYMXomY
	7WD9No+pIu0IDAkVheu7ML+lO1Y=
X-Received: by 2002:a05:690c:9b10:b0:7b2:bf20:cdc3 with SMTP id 00721157ae682-7bd524ef249mr10197757b3.0.1777508024454;
        Wed, 29 Apr 2026 17:13:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd54b332fcsm1824637b3.16.2026.04.29.17.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 17:13:44 -0700 (PDT)
Date: Wed, 29 Apr 2026 20:13:43 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 13/16] packfile: ensure `close_pack_revindex()` frees
 in-memory revindex
Message-ID: <b155f25d53c20b59c662c012a70bb33f8446e620.1777507303.git.me@ttaylorr.com>
References: <cover.1774820449.git.me@ttaylorr.com>
 <cover.1777507303.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1777507303.git.me@ttaylorr.com>

The following commit will introduce a case where we write a MIDX bitmap
over packs that do not themselves have on-disk *.rev files.

This case is supported within Git, and we will simply fall back to
generating the revindex in memory. But we don't ever release that
memory, causing a leak that is exposed by a test introduced in the
following commit.

(As far as I could find, we never free()'d memory allocated as a
byproduct of creating an in-memory revindex, likely because that code
predates the leak-checking niceties we have in the test suite now.)

Rectify this by calling `FREE_AND_NULL()` on the `p->revindex` field
when calling `close_pack_revindex()`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 packfile.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/packfile.c b/packfile.c
index b012d648ada..a1e88fdb223 100644
--- a/packfile.c
+++ b/packfile.c
@@ -420,6 +420,8 @@ void close_pack_index(struct packed_git *p)
 
 static void close_pack_revindex(struct packed_git *p)
 {
+	FREE_AND_NULL(p->revindex);
+
 	if (!p->revindex_map)
 		return;
 
-- 
2.54.0.16.g1c05dfce579

