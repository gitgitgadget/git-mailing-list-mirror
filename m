Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81BF135A69
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 17:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719337154; cv=none; b=aLS/eNhCRkWht+jcqKbLCpJOJFcPXwQ33ba9jzfx7Bc/wEwKWxbX0YSzFQT+aifmd6HtnKPg0nu0+JkN/PZzRohIdOAGv9Y7He6Py0xNduxKMdNR6fPxedBEJcTm8WwLu7bA+e06aZJLJKBcWVrvXnjKIi0+gI1roL5wFOZtRk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719337154; c=relaxed/simple;
	bh=6gXO+totGY31SES4g4eYJku+FGPuNNE4sEfNSfhE6Jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkaiOZWApKUX4FKwY9anLlpWjYznzvhSyYYSjdl/XZ+hog5OWA30dRTS6Jls/G5tVCTI5NLC7tmee3v8+yv37/gvZGO25Nz1ySxwcV+9MMK3a17cTmxPo7VdnCamjtEnR55gYQCICPQH3AEpytA8jZAOGYNtD4MCbGSVfBuoc/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=npgE7I0R; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="npgE7I0R"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6ae093e8007so11556336d6.3
        for <git@vger.kernel.org>; Tue, 25 Jun 2024 10:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1719337151; x=1719941951; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C4qEkFni4Bgh7sDrKVW8ET9ia4dpoUkZqZUPnBjt8qk=;
        b=npgE7I0RjvdoUdRV6HcCiYy3sWLx0I5QRq/T+ckftNe+Cms2IFi0aR+hyZC/Dj/jCQ
         /Uh+r+IpygWKA4vujv8ZHRLoquYo6UNIi/0GjS0mwepaEnJ7qp/wqrnk6K7UsNKQaX4S
         j3YF+QyJGn1KwBVWizGwI1lyB8JVjBBBrn+baPOeqX3CATvOAvgSFJCit2oFwdsBmy5u
         Fy8Iqov9SWwLAQfJLMtlsn1GC2+jWCLKeR/0nCNEpFdJrG76pzPZp5LvDS1U54UfH47k
         L5dxenqImC9vNc+lfciow7FYoV1rerj7i67cW7brWI4bzyuT5zYg8xFBmVaXAItFT//3
         TBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719337151; x=1719941951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C4qEkFni4Bgh7sDrKVW8ET9ia4dpoUkZqZUPnBjt8qk=;
        b=VHLPqRdxqwrlBhkx4K3hD1VfZW6703/N6kRSjXakYLOPNmpg55Yw+UGzaW6OYPE6l7
         2XXif+OyKo75EwqhJaBZY7AyGwPdQJrgIbJqCtUt9DVEFuE/cw6JxtqUrM2TD2FaU48x
         Jdj+MdrHV5AWiNGhoDVm2gMyTvcWMdrHzUt86mp6eGejPHCmmJqQZDlL0tJ3+KKnb0ni
         xk1BTBqt5zhIeBoVSJnATGYIun1N6Zra8nNHfM+07v7V+G9hF3jR+Krs4Dc9Di52UP5D
         BUZdYgJEUpD2q7dmD0brluq4nm7r422pNW7E0Gj5rl2Df9Fm1KS7ls9wb4I4gbr4Yr/1
         a9Vw==
X-Gm-Message-State: AOJu0Yz6elBr16pAmcxf0SSgxNdxyFb8sDhPmpIWy4sYYdV59RamwzFC
	j6At1fJhBUwzexXb73M1DwXpGmXWPrnknJkfXgUqUqNSZaVwlqQnQeiYph5z4RhdPVT8dcuvtFe
	zOVY=
X-Google-Smtp-Source: AGHT+IGAjt2q9A1E3krz6oWzVECbz02egwoZSOn9hEAZEQgRkZYqU+Gc8nVxBMdlskRJPcfjKM7L9Q==
X-Received: by 2002:a05:6214:5d2:b0:6b5:eea:dc00 with SMTP id 6a1803df08f44-6b53baaac92mr83567256d6.21.1719337151254;
        Tue, 25 Jun 2024 10:39:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ef30e6fsm46575376d6.84.2024.06.25.10.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 10:39:10 -0700 (PDT)
Date: Tue, 25 Jun 2024 13:39:09 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Jiang Xin <worldhello.net@gmail.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v7 01/16] t/t4216-log-bloom.sh: harden
 `test_bloom_filters_not_used()`
Message-ID: <ee651fee33d5788295ae8ca785d5a283c92481e7.1719333276.git.me@ttaylorr.com>
References: <cover.1706741516.git.me@ttaylorr.com>
 <cover.1719333276.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1719333276.git.me@ttaylorr.com>

The existing implementation of test_bloom_filters_not_used() asserts
that the Bloom filter sub-system has not been initialized at all, by
checking for the absence of any data from it from trace2.

In the following commit, it will become possible to load Bloom filters
without using them (e.g., because the `commitGraph.changedPathVersion`
introduced later in this series is incompatible with the hash version
with which the commit-graph's Bloom filters were written).

When this is the case, it's possible to initialize the Bloom filter
sub-system, while still not using any Bloom filters. When this is the
case, check that the data dump from the Bloom sub-system is all zeros,
indicating that no filters were used.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t4216-log-bloom.sh | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index 2ba0324a69..b7baf49d62 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -82,7 +82,19 @@ test_bloom_filters_used () {
 test_bloom_filters_not_used () {
 	log_args=$1
 	setup "$log_args" &&
-	! grep -q "statistics:{\"filter_not_present\":" "$TRASH_DIRECTORY/trace.perf" &&
+
+	if grep -q "statistics:{\"filter_not_present\":" "$TRASH_DIRECTORY/trace.perf"
+	then
+		# if the Bloom filter system is initialized, ensure that no
+		# filters were used
+		data="statistics:{"
+		data="$data\"filter_not_present\":0,"
+		data="$data\"maybe\":0,"
+		data="$data\"definitely_not\":0,"
+		data="$data\"false_positive\":0}"
+
+		grep -q "$data" "$TRASH_DIRECTORY/trace.perf"
+	fi &&
 	test_cmp log_wo_bloom log_w_bloom
 }
 
-- 
2.45.2.664.g446e6a2b1f

