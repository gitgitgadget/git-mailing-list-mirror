Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834A553E3D
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 22:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705442963; cv=none; b=ciR6Fz/BqZOJPdDVoNAbeM0GgShidNnr3tKTh7sMjsYHYl2jpIZb0DvAiim8yc1KhXmpOb8qt5TQI+uiLDn22bRm3Y3mtyg0aOSFrviH29OWB5WyTAzwJ2hziasbVzE1zT1YdoaD0/2jPoNqbsPnE0Vyy6AoaoZ319/lz16q7hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705442963; c=relaxed/simple;
	bh=7Y0VQbdBTNNvjXd942nxSVtPoM4KcO4E1BPZjX0l+/Y=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=I2HkKBokjzILRImiys5+DfnPFgabyt5LW7gQayANLhf0caj0V9x0g0+BQP9vOXshN37hx68fXlcTvEdqz+0uwn1hEZZFZGe7oQcHN8HjR0hXf9LUUyQ+ajK6Rw87Y7RR5xs4UUihV8S9e2Y+WnvgmULf7RKg1j5q+A8fBwjm5/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=HBYqOrN2; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="HBYqOrN2"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5ff6245c1deso3201767b3.1
        for <git@vger.kernel.org>; Tue, 16 Jan 2024 14:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1705442961; x=1706047761; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VoWSPYAFRBARcZJPhkQSg3t6n6Fl1PB90395KKgCRb8=;
        b=HBYqOrN2oDQjt4LTBMsUGqNmmC6Su82P6se5IThyajCJ/AmAv5EplBF5gJkqHHdg/p
         VOI15bOewSb7MJ36vLNx9OWFOmtj9vi2z7fVchUNEr18cqVih0tjizwa/VrdLakC/zHO
         3R0eQ1BJF+y1H7fV7BEFIIVhIq61/CnQwh1+Q9Tk7VjzHV6kwu0Fqw/qtmy1rY2j2opJ
         uCP3NZxNBxrvO0n6Lof+oWSY5ogyuIw8skpe6MFblDr1fGcR3Xjztqw0aLPBs4c83nqd
         w7Mn0KkXERX8V0sjg0hugKjlRm0dyg97KjiJKzwdn81jVZP9ZYHnuv5Drw++bhFQW6Ub
         R0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705442961; x=1706047761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VoWSPYAFRBARcZJPhkQSg3t6n6Fl1PB90395KKgCRb8=;
        b=cOJDaqTDLQ8hqRDqMHdwAIYVS6OQRck9XRbWw+Fvhog+KcVB+/VBTaaQeCG0GCTRD4
         EXHsLlWZ2I1dmpJT0IYcELdUZQgeFxnbpiivY67dVHRxnLciDY/p8Vwoe7XeAky6MtM4
         Ejmhhu4ro9IKWcFEDDghef6anJhv84hQD0FUZbW1jfNfj7yjZYB+O++7rCOB4Ns7rSY4
         w/PB60FTABS6v3Bnax34YXRxdc4uOGH6bDobZ8hDzwP24oNCX6zO9R//d/wt9Xlpyfwq
         Kuzvwn20Hit64UqTz/j2X5Ch31MQsrkwXTInjHt0N/SefCtH6vQbSorRZ1tbOPBKfPby
         cbjQ==
X-Gm-Message-State: AOJu0YzNGTmEqC2pVW2jaSzuMIdRWwYgA2/0mA9mfIirul/LYHHhQy0a
	IOIRsS+i/QlEukS8SsEHlAkwg0Lr5BV8ZOJ3SjDHAcql+AHWJQ==
X-Google-Smtp-Source: AGHT+IGdetmDZzv3/4o2TXvfiqkayEZgBnIYvKApq1g09G8s7JGh1pvvQC9MOj5B25Ze6ET7hzX4FQ==
X-Received: by 2002:a0d:d80b:0:b0:5ff:6514:d0d1 with SMTP id a11-20020a0dd80b000000b005ff6514d0d1mr73164ywe.99.1705442961254;
        Tue, 16 Jan 2024 14:09:21 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t14-20020ad45bce000000b00681783effa0sm355330qvt.122.2024.01.16.14.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 14:09:21 -0800 (PST)
Date: Tue, 16 Jan 2024 17:09:20 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Jonathan Tan <jonathantanmy@google.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v5 06/17] bloom.h: make `load_bloom_filter_from_graph()`
 public
Message-ID: <03dd7cf30a5c35ad0bffaf5c8141fbf59ae5c84b.1705442923.git.me@ttaylorr.com>
References: <cover.1697653929.git.me@ttaylorr.com>
 <cover.1705442923.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1705442923.git.me@ttaylorr.com>

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
2.43.0.334.gd4dbce1db5.dirty

