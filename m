Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1147722E3E9
	for <git@vger.kernel.org>; Tue, 12 May 2026 00:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778546833; cv=none; b=b96qebYOlWFH1bIeVEf7Hpaf0rEtyf2UroIUZlAnbzt9wX6jbMixRXgQAYHj0NAQtxKqpCkdr8sKaYxIz+0yHbLFc0YSAzNkNfRYcw+hK0p3wJOoJU4iklfh8NWmEXLuN6e0Nj4Qvjzjy1WEbiVeZR3hYIkY9LbQbwKu68Plx/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778546833; c=relaxed/simple;
	bh=J1PtvfFnfV5Sx3H+g/Hs+CMdfBhnSNzUS4/Q/+wWMog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAYiZgdklhfPib/sYZv914uc1oogAiJMh/6wr+tL/zp3LGQpsAjUHxeFGs4mGLk4r9P4C+eMw27XUwILHtDFy/huMnt2gMqc/LFaXRSdQIuebeGjQRCD+D7wrLvh4y3KBz9Cb+GbXSBAdk89OerChULUqPPyK/tBpJuVlTUu9oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=kPcCz8aU; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="kPcCz8aU"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7b4ee3a88e1so50055697b3.1
        for <git@vger.kernel.org>; Mon, 11 May 2026 17:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1778546831; x=1779151631; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2RJIk0yRLSu+FOLupYSEVr2GplJz8D6gwlzXdjknUxI=;
        b=kPcCz8aU77IhlSKKr0eSSHjiL9hkNvmf8Mp/+noYMSv8apfSpiDJeKrD1bBXa3aqQN
         5gpQwLQmEvK+4V817ezdO2aWBUD8x8AHyQShHQ2+5pCa8vsCZTv+hfXRH80h3WMj9GFb
         ReRNbb7gwIqUIZGAjYV9k/scbT2bLzEw9LVrhHNsUi5YyCdhWTG3UpmGWT+6h0tfLv2A
         lfwzu/OtovhJXhr1CnSti1U6Pz+QHovJe8bJjU7UbVFDBZRlY47UDC2VLpSDfB8g9VLw
         oH/+1/W2NHYsGP4mLX7kTlozlUV/SKXCq5fy9620j48skLqC2yWWXWpFGP1MsOpnTEFf
         zHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778546831; x=1779151631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2RJIk0yRLSu+FOLupYSEVr2GplJz8D6gwlzXdjknUxI=;
        b=RT2rHuWFebre5mD8zNliFcTmPA0aitu77vGBhoip8STqcBnkudLF3A/V7++lU9zvS6
         dAUxO4Ccrb1dVB3AXewKZ6jiTflhbCkCoXM1pKkI/koCGnWHtFd9y3uDd9eH/UNzU8oS
         iNRq3JHVIuv8DLkUUSnb3sjPZvcwmeHSkmkd6e+cueimIlJotV5j6USBVKjDrXhCQW97
         z6yDQvSXbAsV6MRAg4NwjN6MK8ojcud2u3RosMWV/tlF/tW6xG9998Vyi8gnasKx9zj0
         Io+4LLSNOu5jXLtmnOLysogFA5tXuDRPCvomGKdcEXaZt1weQOKuFlZ+6u0Ex0mIYPyp
         77AQ==
X-Gm-Message-State: AOJu0YwR+7a2VJxu1dbhHiF4GzEDLEMppXX0xLwkxOKMTbPQD+3EC27p
	5/JmgCwIcoAzubhKhJDiKjTYqDRQP72fLrUkAtBm7P98O5Kf2b2JIdP8FSEgsoMZxIN9I8DLpzn
	ZaN1ZcshUCA==
X-Gm-Gg: Acq92OG7sLjoroURf7WGr8nbRcuH97Mq0MWXEqPraQX21loPrRzd0XjYfzOVoJS2E7u
	VQjWtcKdE2YLByE95NrVqf1EhG+coWtz59Wxk+YibrsqGI/NIIe4YOPHOs1QX141cUsRNbeabkQ
	CtS8aRgDvGELRJQd8FSgU8UFeJNy35w33wasO9LulFdEcW8aD/Ijh6nHpp+ZOmYSZUCXqx8rZmP
	K211enjo+P1OS6hVPAJaMWZ8QzLrKkuf5gdlN8zwhsZGP/fo+J2WITLmkFAlkqfB6PoFvR0q3SR
	cFQTQlsXmQm9opdaBLsh+Xudqazon1N6SlXw0lCQ102EtDqYdOF8wxDgfZK2Ea2+m3jmjD6WPjT
	8e7Anx9mSFIBzQIdjN6VxG6KQebM+wBv54+iqdhogdrV1Hn+kgosoW4zKISMrKwTxPEWoO3AOKn
	UHQJevOITOw4oaTjU0XOAvDxlE+Q42YwdJ5pSQlYTFrjdzzqz809231lHUhy1Snfwcchc2ZIjWZ
	hEv3e4gKEFeJ6fHy3VylCrHbBA5ODH9Qc4fyeZIIm0sglaKKY+6LWV29oa+8IdMMXcQyiTJl9Rg
	JHQbZDcs5lmjFvua
X-Received: by 2002:a05:690c:6e86:b0:79f:3b8c:a7fc with SMTP id 00721157ae682-7bdf5efb295mr271697977b3.39.1778546830863;
        Mon, 11 May 2026 17:47:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6686fbcdsm155212237b3.40.2026.05.11.17.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 17:47:10 -0700 (PDT)
Date: Mon, 11 May 2026 20:47:09 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 8/9] Documentation: fix broken `sampleRate` in
 gitpacking(7)
Message-ID: <46d0ee2f168a404d5f8832f60c0b2cc241dd0cfa.1778546804.git.me@ttaylorr.com>
References: <cover.1776124588.git.me@ttaylorr.com>
 <cover.1778546804.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1778546804.git.me@ttaylorr.com>

The documentation explaining some sample configurations for bitmap
pseudo-merges incorrectly uses a sample rate outside of the allowed
(0,1] range.

This dates back to faf558b23ef (pseudo-merge: implement support for
selecting pseudo-merge commits, 2024-05-23), and was likely written when
the allowable range for this configuration was the integral values
between (0,100].

Fix this to conform to the actual allowable range for this
configuration.

Noticed-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/gitpacking.adoc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitpacking.adoc b/Documentation/gitpacking.adoc
index a56596e2d1d..e6de6ec8249 100644
--- a/Documentation/gitpacking.adoc
+++ b/Documentation/gitpacking.adoc
@@ -150,7 +150,7 @@ with a configuration like so:
 	pattern = "refs/"
 	threshold = now
 	stableThreshold = never
-	sampleRate = 100
+	sampleRate = 1
 	maxMerges = 64
 ----
 
@@ -177,7 +177,7 @@ like:
 	pattern = "refs/virtual/([0-9]+)/(heads|tags)/"
 	threshold = now
 	stableThreshold = never
-	sampleRate = 100
+	sampleRate = 1
 	maxMerges = 64
 ----
 
-- 
2.54.0.76.g9b17dab2cf7

