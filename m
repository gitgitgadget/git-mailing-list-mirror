Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4E73A278
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 22:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706741544; cv=none; b=Eemvp0BDbZIk6HlMcCKBvYQTxK0GFD03Eo/12Xc/xVRwRbwSPIZEGXJBNWDSW1WwkLSNpGJ1GpcWX1QGthfMj2viP/YquJoTCZzQH81s0lV3mSI/JOoCxbeVPv19yYSwlFVa8yuB5pZPkgr55nrFELkoc0l3eVA6mvhIamMN9Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706741544; c=relaxed/simple;
	bh=wF/EljokfllV1dedwfgR+L1vbdImHtnhGOWcacTY1B8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPrwIKebyaRHqw/1jBgaDCi3T309z9ZT5wdoyxFJn8IfckFtWBinyNa9BaZSLfdqn6iJM8LYGvNtdx6NGH9ytnj5upiT1q6ukcRL1knM9AtVSEMUnZ/wdFf9bnnJ3A011r9HjNnaAUVafNYpDOfoakvmxN56iKAojlFq1KmEnfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=UMa9QGvf; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="UMa9QGvf"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7838af983c1so25733285a.3
        for <git@vger.kernel.org>; Wed, 31 Jan 2024 14:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1706741541; x=1707346341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YGwE8+t5LRl8gqzZPTWr8hA4p69o91574PxxOFbiavs=;
        b=UMa9QGvfQ8bpkl+jRMgemLT/YyA5exCiHSGGeeB1NbDUCXXntNE9xqc8ksolqZ41nW
         5utDiVGeI8Luggh4oa2bCU348TwBpvlz9sOpci5DT6rFSw+skDam/eirZGT29NwxaEwU
         IhWy8NZudIWcCrpp7IJbWiwijZjKl4QqlcwLEeywxI4Tu5kdJiYuX9o8/LkXTCEIS//c
         AHTIfi5TBYjsfLts2uFnP1bHz4O9ixmdE9qRfWfx9ro0LWuTY+38waiNA5miaRdlQCGI
         iszQMs84N8EgZDgez/V4UdNbeRgZHDD+I9EYryysCoT3Bh0rPkQsg9L/o+llsHkpOl7/
         nQmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706741541; x=1707346341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGwE8+t5LRl8gqzZPTWr8hA4p69o91574PxxOFbiavs=;
        b=adwkVuJOES+ehRf7z9eiONHHwHpqeemXN6Bc4anmrhuHrQS5Q5jvZWLP0KpQT0haeL
         s3i2SnhNzzUR80yQhi4h8YJ/wDqMFdOfz8BKUZ18wtK4Hs4IdrjUwNIC50+TT2bHizcQ
         ecn0LrnAbntlQdaB0GkQwL2ZFQjPRy/KXH5lzQxjoz6+xfavbnDeA1836435961jlwe9
         2/dnHMCMAY4xC2uoLLmldmTtdakN5LxcvOkfZ1zCcn8osljZFGeJUrw0LKpSBz8rrgn9
         CCsHJqWryZlHMiON3W40AJdGnuo1ULZYQVb8cUXLqZhfXzHAUtQ0xTHKMCYaJ9ize+q+
         m6tw==
X-Gm-Message-State: AOJu0Yyhc6uIi+LRZiRl4E6bkr03fVFutbOVU7dFWbeewG3gAUSplCDZ
	vp7dncNQlpq/SmA2nLu1rLT3PlaiAzUdQ8u79tSbV052ZT4qEjJ9MVYdypsbu4EtQ6UKg10C5E7
	ahb0=
X-Google-Smtp-Source: AGHT+IG9v3hUdbVuFQe3qf5swz6uAph33xwE/e/47GN3QvrSQibpwa5/g+LEWiiuAJObdKCOgkKCXA==
X-Received: by 2002:ae9:e913:0:b0:783:81b4:c156 with SMTP id x19-20020ae9e913000000b0078381b4c156mr840907qkf.48.1706741541644;
        Wed, 31 Jan 2024 14:52:21 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a27-20020a05620a02fb00b00783f388ff13sm3756714qko.56.2024.01.31.14.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 14:52:21 -0800 (PST)
Date: Wed, 31 Jan 2024 17:52:20 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v6 01/16] t/t4216-log-bloom.sh: harden
 `test_bloom_filters_not_used()`
Message-ID: <9df34a2f4f588c3ce998bbcd51fc83b93726787e.1706741516.git.me@ttaylorr.com>
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
2.43.0.509.g253f65a7fc

