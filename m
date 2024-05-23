Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06AB83CBE
	for <git@vger.kernel.org>; Thu, 23 May 2024 19:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716493993; cv=none; b=hAUHBFji7PJCUFtGWDXB/67vhNN1JNjE/oKm9440DWxSkMc1AgeUtSKJmg7vJ5f6q1DwGms2LnBsxekkuAA7CwEvDqqlxQpay3i0JKdDAEi0WlO06uRSgC4HTim3Qb8Aa0UmztCW6VR/lfqgs1lfg7K+KQUfFf1d85Bx3q+viWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716493993; c=relaxed/simple;
	bh=5MDX79NeMx6DTMqkeMDh0RMMXNh9utfLNrKzyPwqiZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E8/8yxrpwEnEpjXuRTAqoYgZclGzCUcwTHcJusqhIl3OHoN/nPUEnnyECjczNkZbZyY7WgPnoy9bhnbteN4c2gGxXvZYALFmU+0MCubIXEJLh7gHyoZlttfYr37U/+jIIUuVOsqQHQPEJsjK5VlLuZLtC1S9nFhxl5xPW66KAlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=heB0dQTl; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="heB0dQTl"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6ab89c8c434so11646966d6.3
        for <git@vger.kernel.org>; Thu, 23 May 2024 12:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716493990; x=1717098790; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6UbHkfJ0VvjW2Z1Yf0u4O1QRynPUCWMFDNIdIIU7UJc=;
        b=heB0dQTlLfalMZUKKj1kIosNVj22XaO5DDOOJMhI5wg67+J/xdTxRJtMnGNTGZvR4M
         haR73EbexlCScRN3uVD6vtZzX23WnIMkJuwWjgQGUdsHxeREQSKjRC+pi13Dk/0hnVjg
         mTmzVRn+0SymGraQCyOcYCW+fhfCgKdweJA0M2sJ2s//hN4EziXoRsZLrUNAh7TRAQ8d
         XP1/8/OEROZBAZQcBxN8oGZ2Wm9KOEEhIhN6MOIp6FVsYnpCqHx5fBBsC32QgPSUxfSj
         HfLI3XclSoZ8UspyOwyJfiP4nC8w/Mz+Km3dyplnq30OMCyLaOVHdrj2fUF/YdDEZe44
         S4gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716493990; x=1717098790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6UbHkfJ0VvjW2Z1Yf0u4O1QRynPUCWMFDNIdIIU7UJc=;
        b=CTkEpSIS79UlXz8SWCZxBypg/Yhl8gGYH4sBbAZlTPW3K8QvDt6UqAIxIg/hLBkWZn
         XgOg4KD9GmTINNXRu2kmIirQe7xL1TCxfwokQbhDllPXS2DNi31vQa+jq6I356YJoMi6
         /0GBUhDHud39aJpB3FrKRtkDyxF5ZUkJAbydpTLAzJ53tC+I/ArbEWuiitqdjxTDzPgm
         IkQoJIw/iHTR4G/3yW9gQgtiTZ2WelfavesXAfuCG+ZoK/hlI0e688uC6o66pGmz3Zxh
         ES8t8VfqFU585/xnxXzl9lcFOcDjZSYmasqoDAYlRUfGIQgovfbiTLViPiDLg05XF+q4
         x16w==
X-Gm-Message-State: AOJu0Ywc8idYMDom+7xe31JS1fLnFU1SbiSPudlZCx9Fs1dLDTCY6l58
	D5lvvWoesmaZ2Qu9+kU4pkFa1pySi2iZsbKYG7eZtLmeuq4ep4DL1AwfFiewkbM=
X-Google-Smtp-Source: AGHT+IFGM4ojfSBWGFRt+LtvOSYRUxbRzJBB2+sQVXAizQPZFAW8wBcFZqF3hrpxw+/7jjwbxzUdfw==
X-Received: by 2002:a05:6214:3d0c:b0:6ab:631d:324b with SMTP id 6a1803df08f44-6abbbc34f4bmr1452676d6.14.1716493990400;
        Thu, 23 May 2024 12:53:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df56b1651sm186905391cf.76.2024.05.23.12.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 12:53:09 -0700 (PDT)
Date: Thu, 23 May 2024 15:53:08 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 30/30] t/perf: implement performace tests for
 pseudo-merge bitmaps
Message-ID: <Zk+epE2S4KErPyVk@nand.local>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1716318088.git.me@ttaylorr.com>
 <6a6d88fa512ba344543f5f0df33d5a61e406f3db.1716318089.git.me@ttaylorr.com>
 <20240523105422.GF1308330@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240523105422.GF1308330@coredump.intra.peff.net>

On Thu, May 23, 2024 at 06:54:22AM -0400, Jeff King wrote:
> On Tue, May 21, 2024 at 03:03:17PM -0400, Taylor Blau wrote:
>
> > Implement a straightforward performance test demonstrating the benefit
> > of pseudo-merge bitmaps by measuring how long it takes to count
> > reachable objects in a few different scenarios:
> >
> >   - without bitmaps, to demonstrate a reasonable baseline
> >   - with bitmaps, but without pseudo-merges
> >   - with bitmaps and pseudo-merges
> >
> > Results from running this test on git.git are as follows:
> >
> >     Test                                                                this tree
> >     -----------------------------------------------------------------------------------
> >     5333.2: git rev-list --count --all --objects (no bitmaps)           3.46(3.37+0.09)
> >     5333.3: git rev-list --count --all --objects (no pseudo-merges)     0.13(0.11+0.01)
> >     5333.4: git rev-list --count --all --objects (with pseudo-merges)   0.12(0.11+0.01)
>
> That's not a very exciting result.

I suspect some of it might have to do with:

--- 8< ---
diff --git a/t/perf/p5333-pseudo-merge-bitmaps.sh b/t/perf/p5333-pseudo-merge-bitmaps.sh
index 4bec409d10..2e8b1d2635 100755
--- a/t/perf/p5333-pseudo-merge-bitmaps.sh
+++ b/t/perf/p5333-pseudo-merge-bitmaps.sh
@@ -20,12 +20,12 @@ test_perf 'git rev-list --count --all --objects (no bitmaps)' '
 '

 test_perf 'git rev-list --count --all --objects (no pseudo-merges)' '
-	GIT_TEST_USE_PSEDUO_MERGES=0 \
+	GIT_TEST_USE_PSEUDO_MERGES=0 \
 		git rev-list --objects --all --use-bitmap-index
 '

 test_perf 'git rev-list --count --all --objects (with pseudo-merges)' '
-	GIT_TEST_USE_PSEDUO_MERGES=1 \
+	GIT_TEST_USE_PSEUDO_MERGES=1 \
 		git rev-list --objects --all --use-bitmap-index
 '
--- > 8---

Sure enough, that shows us a little gap between the "no pseudo-merges"
and "with pseudo-merges" case:

```
Test                                                                this tree
-----------------------------------------------------------------------------------
5333.2: git rev-list --count --all --objects (no bitmaps)           3.54(3.45+0.08)
5333.3: git rev-list --count --all --objects (no pseudo-merges)     0.43(0.40+0.03)
5333.4: git rev-list --count --all --objects (with pseudo-merges)   0.12(0.11+0.01)
```

> I have a feeling that your git.git is not a very interesting test
> case. We'd want a lot of refs, and ones that are old and have bushy
> history that is not included in the more recent branches. So something
> like a bunch of old unmerged pull request heads, for example. ;) Do
> you have more interesting numbers for something like that?

Indeed, here's one for a private repository which meets that criteria:

```
Test                                                                this tree
---------------------------------------------------------------------------------------
5333.1: git rev-list --count --all --objects (no bitmaps)           122.29(121.31+0.97)
5333.2: git rev-list --count --all --objects (no pseudo-merges)     21.88(21.30+0.58)
5333.3: git rev-list --count --all --objects (with pseudo-merges)   5.05(4.77+0.28)
```

Thanks,
Taylor
