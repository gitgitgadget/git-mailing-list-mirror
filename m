Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111D33B191
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 22:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706741558; cv=none; b=at/bByWI58IDoiTbEsbdbaFmHBslEp7ZFq6BOUKpJZgPjonUo05319SdLSTe5p+fmR1CZx+F7jGGN4v662vLuamZi7iulayQvEgFGhnVmLFbpoA48nAy8RoAcYx9dynxv1QhF7TIT7tPLg7q7LvBSeVQlPMJZYelakRt8TidRls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706741558; c=relaxed/simple;
	bh=siryQCCwKmp0FcIkCQGjRg7gCrnrAyHd+X131cmCfow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GYknztDZuh9wG9dHtx5y4tnB3tla6hh2Yn73+YjDs6lvHsc0SlG8uA9zhqwpaTv4UA8IU8bL9OBZp+ogQwDCSquTbw3JXv6tZRvLtFyecnBs36F/g71BgTTgbsrgmcbyonxX61B7J9orztRN1eMJq5MFY9K2V70iErCzxFGZob4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=LGs2XdOr; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="LGs2XdOr"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-783f0995029so21845585a.1
        for <git@vger.kernel.org>; Wed, 31 Jan 2024 14:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1706741555; x=1707346355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B+yx99PTfiTSh93zIKTfSShNWWIupRnP2PqqMJweWww=;
        b=LGs2XdOrLR1A0v6R+bj2cRJ1Mk1UdrlMn6gPQRCGArXiRyf9O6i1HMZ4tDbiZ42xei
         Ev1nkCKZ89bKdXKV3XhKpU0+v+haClGr1xS2fdOJZFq8SNmd6Ohg1HxmMRaPSlmXgn/P
         OHUT6P6kUvlShRA0dajQxXYtmD8nD7iEDiB1S4x9x7sp7OK95PmWTWUOqDSqRZcdC4Rf
         q+TxgcmQnNsXAWUDKRe4DN8RW1owP88nZY62MFSnmijHPT4vy8kiHjzdcxFcOnmQaCUY
         sbVnhlFW4s1hU8LT1oEyK3xpSI5keyS9gOoInWGvyVnkj9nUC1lczliDRuBJoiJFmRpi
         bF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706741555; x=1707346355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+yx99PTfiTSh93zIKTfSShNWWIupRnP2PqqMJweWww=;
        b=VoIFMcqob9LbwPMnKeJPL1CB5CGe1PDyMF1JUYtQ0UxUfYii/sL6AR9ujSYE0SJCHQ
         zzzdg1ecojLg9MTUM4Sts5mzLYpS9OX8mLbue+NK0DkFq+TijVsOIx/5lvOCXNMNqXVU
         ucXy02+toqeeOZKhtbPdWG2NViG5cuEFjMYli8NwufB0F178PKRAd+M276nA4ZCcBj5t
         o/7YEdLvEKRTfU5nT7NC1PRqYVXv1Itlbit5icDJGJNxqRMNH4RBc+Dh6YduAzjEpeo/
         OvNI9bmcHDvVWcLPvzDlsuy3tTY66MuuiBv414hj4g5MQe7ir+ilerJJ+RXeGO3BPQhL
         bL4g==
X-Gm-Message-State: AOJu0YyAkwFGlmN0LamvquPC9dmjWHeIOql8JvVg4geFqTxKo0s0e4Bo
	iDihKxriZZcoxsJpIrIvPWvT8NedrhHbf/tPm9C4qNrgGqejmL3xlKzXzFIjTkt0X2Y1pzcqtrX
	l2HM=
X-Google-Smtp-Source: AGHT+IHpTfBlTZA6kCryB/aRGeeGYvYwYkORXVaIT+HHBaNEPIveeEo5hDUlpWFZVwPlm+VhDP9pNQ==
X-Received: by 2002:a05:620a:55b2:b0:785:3422:8353 with SMTP id vr18-20020a05620a55b200b0078534228353mr823674qkn.22.1706741555638;
        Wed, 31 Jan 2024 14:52:35 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c8-20020a05620a11a800b00783ff37c473sm2855449qkk.103.2024.01.31.14.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 14:52:35 -0800 (PST)
Date: Wed, 31 Jan 2024 17:52:34 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v6 06/16] bloom.h: make `load_bloom_filter_from_graph()`
 public
Message-ID: <48343f93a27eababbbf5ab1355906229d151a8b7.1706741516.git.me@ttaylorr.com>
References: <cover.1706741516.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1706741516.git.me@ttaylorr.com>

Prepare for a future commit to use the load_bloom_filter_from_graph()
function directly to load specific Bloom filters out of the commit-graph
for manual inspection (to be used during tests).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 bloom.c | 6 +++---
 bloom.h | 5 +++++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/bloom.c b/bloom.c
index e529f7605c..401999ed3c 100644
--- a/bloom.c
+++ b/bloom.c
@@ -48,9 +48,9 @@ static int check_bloom_offset(struct commit_graph *g, uint32_t pos,
 	return -1;
 }
 
-static int load_bloom_filter_from_graph(struct commit_graph *g,
-					struct bloom_filter *filter,
-					uint32_t graph_pos)
+int load_bloom_filter_from_graph(struct commit_graph *g,
+				 struct bloom_filter *filter,
+				 uint32_t graph_pos)
 {
 	uint32_t lex_pos, start_index, end_index;
 
diff --git a/bloom.h b/bloom.h
index adde6dfe21..1e4f612d2c 100644
--- a/bloom.h
+++ b/bloom.h
@@ -3,6 +3,7 @@
 
 struct commit;
 struct repository;
+struct commit_graph;
 
 struct bloom_filter_settings {
 	/*
@@ -68,6 +69,10 @@ struct bloom_key {
 	uint32_t *hashes;
 };
 
+int load_bloom_filter_from_graph(struct commit_graph *g,
+				 struct bloom_filter *filter,
+				 uint32_t graph_pos);
+
 /*
  * Calculate the murmur3 32-bit hash value for the given data
  * using the given seed.
-- 
2.43.0.509.g253f65a7fc

