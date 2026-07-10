Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E933BB110
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 22:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783723290; cv=none; b=Zb2FUlq6PJxcZTSIsnfI0b5s5k+hukUisBcBbz/9K0urZnefrfNsgDOiNfh9eOOmc6drl3Edw05DdZY6hqFKrZQWmbx/OUGzAu/q50xaWySbXV1zF089oPn2uBAZ7VFKH6rOiSqr+ih9XC8WuNXc5LNBCPgURCT9j9RCzIzj14Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783723290; c=relaxed/simple;
	bh=AZdbPo1lPLQhlVjDhXsf8Igi2uQ2OPaq1j49JYbZl+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BlzKhIagoEiAD932fgMZfGJ9Ot20tP+a8LHrIX7C8gLqhdDM6S9PwGMKW/jMlqSa/7M7ZvhZmYfSF6ZNXiIBK+CARbydLIO3I8WCeNQoSdKxIZY6KD/VBmF7mTqYcJOQ61vcvA77bO76m5zLwj7yHsoGdBoZMs5fZ0q1ChMxyxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=IO9trlqW; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="IO9trlqW"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c21495722so6933301cf.3
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 15:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1783723288; x=1784328088; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AZdbPo1lPLQhlVjDhXsf8Igi2uQ2OPaq1j49JYbZl+4=;
        b=IO9trlqW2Nz1V7vmHuMZfn+39iNe1DHs1eTc11u4IaYmlnf+COejknI4uqeKFcdNua
         1fji+h45jxzOHuT3HQcIczFlmkDjhqEIOix0ibWdQNCklBzqmvCliK6keH+qlp995TId
         8UFENNHkk5Je/RgyYMuQlknYYbI73zJBMOEPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783723288; x=1784328088;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AZdbPo1lPLQhlVjDhXsf8Igi2uQ2OPaq1j49JYbZl+4=;
        b=RTUj8hmMzQy3gPILuIGC/jQowRxUQtF69cSBOvHrUdU+DmrYwaopxYKdLTlT+s8Xj9
         le9jBFCxIlHMyYh5W2iosCUmxD4Z2tQN59tMdnjSKXKmrraarywQxp1VEwcF8+DOjPLE
         Nz4syhx1SRwX8V9SE39Oh0BwHCDghU08ft3bV32CXh0jsdz9/8Mk/ZwCXuUqacwdGZOn
         m6T8I6PJGmXtw2DvljiYEkXdCMpqLXOcpmsjIDcTuFcvKUr3/GHHLoSBZgqVt72oMM7l
         rTuYIS96zA1SY1GtDqSp+EdIS5vpY9war/gcP6K8NkgELsBQdrA8h8Nod6NgWVW2u4qJ
         RlgQ==
X-Gm-Message-State: AOJu0Ywb+JRUmmz7DjPAYLMF11LVVFdVEIU9/CxjWVOEcRxMP1DItw2k
	HNtRrcFq3lKdZz2irt3uCkQW77OoAJw5Svm8U2m5W2Zh0PxFibDMAu6LHj2FeVNZkqY=
X-Gm-Gg: AfdE7clfsOB8/DTJXv+yDjInea9S98GoZRdW9nJ7StsFDTj0OvnThaJTt5gaa35MIjA
	klz1u5hhz2Jzb+LGEGZmHD4Mxo0tjyR1K08DyYZ8wOxAvMVY6EjNDwm1jA2AFrx4zF2o7TPBFES
	iOxXWPVaBfiwJaV9jO/qVxJYdtoMZjCvBrP407xj2If0tReKnPYAs8XZsR4D0q46nAHkpnZevLy
	6J28M1I7Mr+3uyybNwwfVgOlebPt28MpXFbkVhRplcrQ3RHYPkQk37j4Bl3EZ+Co6zk3QTcE6WI
	euItzzumn40wqNB4ovmhwGPvfbrMJ9r8dmnUIdepTKE5dmOkvsci5CPevBLrioSjenluZLvMb/Y
	axMsWSLsAOIrLmmUASrahnra942pkt4rT4mMNMQELK/FMO4GFX4+HMeKme5m2yFDvcKXI/lybqc
	iutL1gFsCXGbK3DQUyo9voAQbOCuyISZdKynA=
X-Received: by 2002:a05:622a:303:b0:51c:ba4:d837 with SMTP id d75a77b69052e-51cbf0df218mr9375651cf.18.1783723287812;
        Fri, 10 Jul 2026 15:41:27 -0700 (PDT)
Received: from com-79390 ([209.249.37.133])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51cba49439dsm11304021cf.27.2026.07.10.15.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 15:41:27 -0700 (PDT)
Date: Fri, 10 Jul 2026 15:41:23 -0700
From: Taylor Blau <ttaylorr@openai.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/8] pack-bitmap: drop `_1` suffix from functions that
 open bitmaps
Message-ID: <alF1E3rKH2lsax84@com-79390>
References: <20260710-pks-odb-for-each-object-filter-v2-0-3710a9cc165a@pks.im>
 <20260710-pks-odb-for-each-object-filter-v2-5-3710a9cc165a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260710-pks-odb-for-each-object-filter-v2-5-3710a9cc165a@pks.im>

On Fri, Jul 10, 2026 at 10:48:57AM +0200, Patrick Steinhardt wrote:
> In the preceding commit we've refactored how we open bitmaps. As part of
> the refactoring we have consolidated `open_pack_bitmap()` as well as
> `open_midx_bitmap()` into `open_bitmap_for_source()`. Consequently, we
> only have their `open_pack_bitmap_1()` and `open_midx_bitmap_1()`
> variants left over, where the `_1` suffix doesn't really make much sense
> anymore.
>
> Drop the suffix.

Makes sense. Thanks for keeping this in a separate commit.

Thanks,
Taylor
