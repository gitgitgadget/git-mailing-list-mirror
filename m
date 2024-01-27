Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299BE13ADC
	for <git@vger.kernel.org>; Sat, 27 Jan 2024 04:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706328054; cv=none; b=Ewf2HP6U7ubfbEhYYyl5/T6NlxR+UdYyRwiCj7b7nkmYbkkMhVwJ5M6EGq1SeZDTYuiPfSM9UcmPTkiyqzjDdtW4EYEOaAxZ5bQWuowQIP4EAwxdSKReP1prdptRXNlcJp1PCtNLVe+o6k8asVZKtZbCbHNgC6Qt1MBDr1o1Tmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706328054; c=relaxed/simple;
	bh=FbntF8jxD/4UpCSrxO820Lm3mVcwNnX9FPjH1vURlNE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ciYR0iFgDJytRZs0o9y3H+QJrF/zs2Mc3Xa3cPXqEqlhu+NMmzSbOwTJW0gTfxef6rvcTogU1t98t1LYEAcelwkc1EMnJtYZsNVJECG9Amtf+2XCIHDvwM9fFAcLvZZcM4HCiXIZF9j+NJeswJ5jQcWV3LwcYy4HHECDlRaob8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=aIvRwjT8; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="aIvRwjT8"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6818d263cb3so6519486d6.2
        for <git@vger.kernel.org>; Fri, 26 Jan 2024 20:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1706328052; x=1706932852; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TManQ/+rrRxxaRpHczlIqpL263Rmf6uU/Jcu4IUUqwE=;
        b=aIvRwjT8Q49bU4Nxlpqm+x0/DSsalP1P/17EFCVaM0VH52B4O0WzuIMUwSo5uRfRUT
         MOWdErWmS4+yCX9oLBqszeLbl0XrxwzIOVSB+DSAWWuPGu0hRX9enQv8GXWYQ9eLJtmt
         eGtxdjtbu/ooLBjBSlzRX/IPCzR4AWXpbraQi3MEztXgYrD//9783JdKx9yw1ld9AsGQ
         xH9HQTMAwumVcinCKIfWPaBTl//48YZNllw4AvLAZkQqkML6sMXDgn00HNdOXDBwormG
         EnvHK+LR98CCwjIWc1xsWMRASptUb9V4VAVSt6Mkgpw+NdyUWMC9GC/n8RyMsaW02zWe
         IY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706328052; x=1706932852;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TManQ/+rrRxxaRpHczlIqpL263Rmf6uU/Jcu4IUUqwE=;
        b=u2mWBQcBf1PK1PLFI4xQLMjNi6GOcRreOGGTTG2mel7v3ttGSXnCkmlPCzfw2CLKMW
         FmPcwMeZd/rRVAACvFjVYg0ZDZJT3naJBCE14P5U9vOdl27eb4suBzXDJLBw3LNYpytl
         MACf/AGKazuSZC0/FF7YqWG7w7Q5UfuwsfC5VXjxgj5HxsmQr7Ts0AkrmWM9obtkjUue
         dxopcViS2P39P+/+snznNSuxtJo+wCfkB3HFmPlTxhYvPfLrFmZLSd1YhCbzBREC5F6B
         zMdFsTkrlqxfjjxA7FzmzQ7Fac50foMcSExbIXWbYAKC7Ff5lKPFVYlElA06ao78yo51
         XFPg==
X-Gm-Message-State: AOJu0YzPGq34WFnbWcanKzURFWlLnQNV2tV2ytVf7SZ1e8kdhTTrjVCM
	q7feVFCa7KPZyFAlQRtu7r354yBJgNzaMKIcAp91jti9tDAyWetIiX4HQKoNIT+QNU8RZ1al8bz
	jekU=
X-Google-Smtp-Source: AGHT+IFV+xdsXGCC2/uwH55O5C7RYd46HY+vbaUGdYxHE2ChV76Qqn7+ftBTBbjEVwxQGjZiDLjmmA==
X-Received: by 2002:a05:622a:34b:b0:42a:8c7f:2c1d with SMTP id r11-20020a05622a034b00b0042a8c7f2c1dmr641134qtw.88.1706328051863;
        Fri, 26 Jan 2024 20:00:51 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id bc13-20020a05622a1ccd00b0042a67ff45a0sm1151896qtb.36.2024.01.26.20.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 20:00:51 -0800 (PST)
Date: Fri, 26 Jan 2024 23:00:50 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] pack-bitmap: drop unused `reuse_objects`
Message-ID: <0bbaf9a3591765161872fb71383263edb0c7ef83.1706328008.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

This variable is no longer used for doing verbatim pack-reuse (or
anywhere within pack-bitmap.c) since d2ea031046 (pack-bitmap: don't rely
on bitmap_git->reuse_objects, 2019-12-18).

Remove it to avoid an unused struct member.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
I noticed this while reading code in this area working on a new topic to
store "pseudo-merge" bitmaps, which can be used to accelerate bitmap
traversals when all commits in a given pseudo-merge appear on either
side of a traversal.

 pack-bitmap.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 229a11fb00..2baeabacee 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -51,13 +51,6 @@ struct bitmap_index {
 	struct packed_git *pack;
 	struct multi_pack_index *midx;

-	/*
-	 * Mark the first `reuse_objects` in the packfile as reused:
-	 * they will be sent as-is without using them for repacking
-	 * calculations
-	 */
-	uint32_t reuse_objects;
-
 	/* mmapped buffer of the whole bitmap index */
 	unsigned char *map;
 	size_t map_size; /* size of the mmaped buffer */
--
2.43.0.386.ge02ecfcc53.dirty
