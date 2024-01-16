Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF1C20B0C
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 22:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705442949; cv=none; b=b78f8HrEMPMFHp1KUjzyOrwh/Ti8kfTpo9Kz6TUP+7JVKQiO5i/8W03i0hED2Rprnc9/6Vqu3bjAyPKU40C5UuzIP93St3Fg06qfC77QPoRWDN/8O4W1i9NRTES9rrbQxzPRWNdyHxYsgewJjERc09JdH9w5Gno3vVi9sg6C0YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705442949; c=relaxed/simple;
	bh=6QabK8iOkfVQ8hAGV/TkKsGiqU6EhL/BjlUs3t2FC0A=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=CjicT3bH/oBIUJ6sfPA75xM/IgfVeHgkBCzLb3ibmmfuEIw0BsH4RAquXgkQD0Oe/bETOLnpuEi21eQ/45rv7OX3cdJivxxMLjafa4whnq/LU0QlV8zPnwWSxY84QIGi98l7x5UGzpL2NP03jV+4oe2uVpVjA8G4r+H3tm4kaEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=DVAB2bzk; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="DVAB2bzk"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-680a06cc763so66642966d6.1
        for <git@vger.kernel.org>; Tue, 16 Jan 2024 14:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1705442947; x=1706047747; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7G+r5rzKbT5AgMVhSAburbO0Bdu+mDyRx3iT4gSvO6o=;
        b=DVAB2bzkiF0ada92tzan9iaSLencsepwGYjg38j80BR9QhepgwvOLuZW6YowlCNAuP
         Pkj1TPiib0ZKNYqx2r4Fcy9slyzdAPxaLBobTHa9G7Cy8kiJ6ZmYMPr90fhZ+94zOHKO
         5WiVFBM12XjgQkOtvHUyJuOVuWdeLhA+Cn98Exj3jQ9G9g038ygC6QUcTqGyeGZOaLfd
         lLJIspHzkSTcfolMAYK72ApHpR6BYYuS0/P3EIS1M5mklGcQL4G89htAIVU1Uhv4HMCv
         tBPH+sX+w4fn8hy4qrHsTIqQvp9U84Db/5qkKmYbQ3cb43Zt6HdBCfoX+6Nraz9u0sYP
         U+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705442947; x=1706047747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7G+r5rzKbT5AgMVhSAburbO0Bdu+mDyRx3iT4gSvO6o=;
        b=UgtsWWuv7JlypX90z78G4ydxevM9+UZAFBFeTvk0xJil6hg5L/KqkA+ZF2B813bT/S
         XeUMknsi/4rigkJPJOGIqRWYMqDCjDEaQhY0crA2JXoH2BFiNg/S5JEHsFbQnNsFMmXs
         UL9l9LH8KcxuoSVPDhlJv96BSwiJb799IHGFeyjlksB/MvfT3p6d4MkP5N7DTvMcnSCQ
         zOyErWgWG42l79pzXrkckHWwvdFGXK876YU8kwWhStK9+ks0zJArTvJOD3SwpezLXWJE
         R2qDKaAWb/XvQgGo6ShI7LHrzB1wFYbVVwukOC1IEx0m54Qg02UQsKviWGnZbKKKZJvo
         w+jA==
X-Gm-Message-State: AOJu0YyQpPIDsIuZA3Hh7Pfz77893iFk+p3ejH4Jc8klND5RuwhLjN5m
	2bjC/JGx3I1x7AfgWBFn3svohXiO/1a408mZIpD12WRr06rNNg==
X-Google-Smtp-Source: AGHT+IFbxgfCeuELFKL/LXIQhIPkoF378X5SZvY+cbZQG/KHyEWFup2Qf/94AsqwVBjL0L3wdIIXaA==
X-Received: by 2002:a05:6214:5290:b0:681:68dc:58eb with SMTP id kj16-20020a056214529000b0068168dc58ebmr2609587qvb.88.1705442947201;
        Tue, 16 Jan 2024 14:09:07 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x4-20020ad440c4000000b0068111bbd2ccsm4463334qvp.143.2024.01.16.14.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 14:09:07 -0800 (PST)
Date: Tue, 16 Jan 2024 17:09:06 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Jonathan Tan <jonathantanmy@google.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v5 01/17] t/t4216-log-bloom.sh: harden
 `test_bloom_filters_not_used()`
Message-ID: <c5e1b3e507b3cb8fd3faac7056ada82d45cb7a03.1705442923.git.me@ttaylorr.com>
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
2.43.0.334.gd4dbce1db5.dirty

