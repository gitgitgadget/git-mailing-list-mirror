Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B314A24A17
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 21:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="KHF4/oT2"
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22350D64
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 13:18:26 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-77bc5d8490dso10416085a.2
        for <git@vger.kernel.org>; Thu, 09 Nov 2023 13:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1699564705; x=1700169505; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0gBkPSLzhzMEfn+idT2ktg0SjT8HVWf41sTr8bghcG8=;
        b=KHF4/oT2KRoNh0PwpYbkZhCg0tHczd9Nb1Hhss7MkbVFu3bYKGVY8WEBKL0oDQHqA1
         9D6nR+n35PTcS5vOep1mos8fYJIxU8eXd4y5y/5oTkVUm+CJK3g8MmCU4skiO2pSISdn
         HImvp2GnxyJXdwZP07aaAMqE9lEi/cKtuximWn+NECjgKyqQSEW+Sqlzp9SccaSHds4Q
         g/SjTl5seya/KCiW2q5iwfUbiQZ7/fF3+lwaNWnQZ/Z0ia0hqe3NA+UaD73UDVTkmlzt
         UmPNhg1aIUp/4ZFHG7gyQTsnWDFU5BedfSyrBFPsNv+sf6KoBUjt7w5vFYTydZ8wSIAW
         ibRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699564705; x=1700169505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0gBkPSLzhzMEfn+idT2ktg0SjT8HVWf41sTr8bghcG8=;
        b=Qclv9raWe0q/QU2MHa2ADC1rcuie3rdmBepftkj25rZcl84dw5AO3DByE8B49YFkYJ
         NtCkGau6yYVaAvV2q22N9WA5StnmpgqOPb9ha85NXtsKnE4mvgDwPZNrH3tECqi0yxMe
         TpEXAwCgZiIqr1pWNfmyEDKpi+RSJJ9XvkJYJbozQJPEDDHH78Lgn6b970srJvRB41v0
         L+75XvKyIcGseqrmKGCgWA5hxujP5hyJ31Cmaa9HWWApGHTVROK/vZKr7b3COXrWLoos
         OB6C3xUjcCkz1+HWvsbp9L5cJMxfGV3b0fLMxG8Y1S+smHu9RHT1ghhVDXTN9Q4jW7Qa
         hJog==
X-Gm-Message-State: AOJu0YwzMQeboLfWSmXe/zOr2VtIeWaTl+kkhDTSU1ubGkGOzHiRfjrc
	VtByEcdzUsVcjypS2XtEhBlfpQ==
X-Google-Smtp-Source: AGHT+IGcTkV+OswAU0HBMNF0x3H07dXKBKYhOxhAvaHYCgXnEenssCUbRKUDL6tYzpPzUANFfuhUTg==
X-Received: by 2002:a05:620a:198e:b0:779:efb4:73ad with SMTP id bm14-20020a05620a198e00b00779efb473admr6750788qkb.53.1699564705170;
        Thu, 09 Nov 2023 13:18:25 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id pw7-20020a05620a63c700b0076c96e571f3sm208115qkn.26.2023.11.09.13.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 13:18:24 -0800 (PST)
Date: Thu, 9 Nov 2023 16:18:24 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/9] commit-graph: abort as soon as we see a bogus chunk
Message-ID: <ZU1L8qdIjz/OIAfR@nand.local>
References: <20231109070310.GA2697602@coredump.intra.peff.net>
 <20231109071711.GE2698043@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231109071711.GE2698043@coredump.intra.peff.net>

On Thu, Nov 09, 2023 at 02:17:11AM -0500, Jeff King wrote:
> The code to read commit-graph files tries to read all of the required
> chunks, but doesn't abort if we can't find one (or if it's corrupted).
> It's only at the end of reading the file that we then do some sanity
> checks for NULL entries. But it's preferable to detect the errors and
> bail immediately, for a few reasons:
>
>   1. It's less error-prone. It's easy in the reader functions to flag an
>      error but still end up setting some struct fields (an error I in
>      fact made while working on this patch series).
>
>   2. It's safer. Since verifying some chunks depends on the values of
>      other chunks, we may be depending on not-yet-verified data. I don't
>      know offhand of any case where this can cause problems, but it's
>      one less subtle thing to worry about in the reader code.
>
>   3. It prevents the user from seeing nonsense errors. If we're missing
>      an OIDL chunk, then g->num_commits will be zero. And so we may
>      complain that the size of our CDAT chunk (which should have a
>      fixed-size record for each commit) is wrong unless it's also zero.
>      But that's misleading; the problem is the missing OIDL chunk; the
>      CDAT one might be fine!
>
> So let's just check the return value from read_chunk(). This is exactly
> how the midx chunk-reading code does it.

All very well explained. I hit that same snag as you did when I was
working on the few patches I proposed we put on top of your earlier
chunk-format hardening series.

I'm glad to see this getting cleaned up, and I'm very happy with the
post-image of this patch.

Thanks,
Taylor
