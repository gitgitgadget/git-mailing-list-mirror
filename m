Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B032E091E
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 23:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784330309; cv=none; b=ql8vkmwDdPcqcE8hNXCYgKeMshY698VSRuodAGan1ys1ItBPtA4XpWonyMOrvYd8y22+awFLFYqM55qEF+8t3Ifnx17AE/MAmwXPagqZp88ZMh92o8c3JLtRZ7XsuRCBXNCtlzgebDXej8PwN+9NRiFjeug53SQ2wwgFoUrgmoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784330309; c=relaxed/simple;
	bh=zpw7VqmaAxxEQbAasO5qHe5lcaMO8VQi34IqBlY05VM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nlQEvcu9svWm6cIU2Q0/IPY1AAsKd0PHlozvSarP58T1U2PB9Ea2yvG80AZZjVNKiWeVrpjTPeQ/olIHtxcQIQqcnfwahXpZ1ZDEmN2cTQTLJ1TDv39eU8WvgzvY4tnVoYAZ7Vu2j6VTpxXsQcsWk+yrQIcEXk0HT5AnACWLNXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=blrNFg9z; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="blrNFg9z"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-80cebd41372so80576157b3.3
        for <git@vger.kernel.org>; Fri, 17 Jul 2026 16:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1784330307; x=1784935107; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=La9h+gpoyWMp/CCYqCmIDpWG9QihvsoALX0ydBwWkCM=;
        b=blrNFg9zxLxyUl8f56ocneIKJsWyz3KcXT+0DTr7wzzoAtdktk0V5320G38ry27dFh
         E6XInZ56UErpfOcdXGHF8BtCtQ7cFEwHNsX16LLbStkl+OoDdIGI6gZxe/IIwhq+p/sH
         99D7B+3y+Ne8cf9Um7pLh70nVCqnTC6bnoEeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784330307; x=1784935107;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=La9h+gpoyWMp/CCYqCmIDpWG9QihvsoALX0ydBwWkCM=;
        b=H65EC0GHeKL/QqT2bCjlEyTXQ5nqMlcZre8eoYgcJbfJfE9/Y2SVY5SUPGrjI/Ci0m
         6nEJbiEhe40HVCCLZ8cF/GKMTTUltTipKXYUpy1iJkDKk6FcYnXiTln4I6MPcIlYsZfy
         FXZYWqYGahsbEDxlxWHh1uduBr2HUWt+xOYxthWi2ARx32th7MFyhr8ySvUIAmDe9dz2
         k050L7tGqikHOlHVYp+lPggWnSwMGkgg5tjCIhL5nFCGi5d3pK75Q+Szb3IP6htEw+aK
         NvWpdfNIUDhl30VYqjhIrndx+rctlizR7yYCLOGhzjWgc7lpj4Ua74YtTEmfmuEdKbCo
         zyZQ==
X-Gm-Message-State: AOJu0YwKdlrI9LRsY/gNGjPg1YSIi5U+Abk5zLiDCmTq2uyqy8PmSeIE
	vboQFkY4NLQjpslgx/cijeekJpQJhgGDwLCMLVQNKFRL5ZUGE+Pj0UJnSVwFSHW78KS6Kwdn3OT
	HHdpH84KZuA==
X-Gm-Gg: AfdE7cl40xW9bjP30QFL7O1yrm7oZd029bpc1waJPYe8O/unl36YHYVxYUHajjQ3jWh
	FYaAmKe/lseJIjpDoXVySgsnSWVR5yppQQS0+MxsVvDUCJMEHeKZowvs1mBsS2PaVqA32jwbaub
	TS6EVXRPXB2R0MGRGbNouPKIgTFwW+TWucCuGvjaHCUl++NiwX1DvvzWNiL5L6GLDHEXOdPghG+
	5WTvjxa2nmpSOWeLdUstMNYjIetJUd0QbixderMkhENuCw6wYeUgfaGx5rG5f9W+MZrMujaTim4
	myxXN7K0Pcf8llNNgiPw0aZ8Fa5mrdnQxhhD01f3wnaNdC4gv8i5XqYdmLNr5oiFjPQTsyW9mWy
	xXS3s/oqtKLXqunI5qCg69277QfsH0DzONA0jjESQBC8kGCbLyyJs6SRyYZTJDK5nnnhnwrIVTS
	CNnFjQRE7t9ZFZ4ECm8s7AfrmkcYhAVw6rBtKPGsJTy4rwrFbjFrwxJPzzkZQEUv9d8AAD0Q==
X-Received: by 2002:a05:690c:6f04:b0:81e:bbcd:f1b5 with SMTP id 00721157ae682-81ef2674fcdmr15972577b3.64.1784330307444;
        Fri, 17 Jul 2026 16:18:27 -0700 (PDT)
Received: from com-79390 (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81efe6eb7d7sm7043257b3.28.2026.07.17.16.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 16:18:27 -0700 (PDT)
Date: Fri, 17 Jul 2026 18:18:24 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Gusted <gusted@codeberg.org>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] last-modified: keep per-path Bloom filters for
 wildcard pathspecs
Message-ID: <alq4QN6CtQMz_pU8@com-79390>
References: <20260717-toon-speed-up-last-modified-v1-0-410418f18614@iotcl.com>
 <20260717-toon-speed-up-last-modified-v1-4-410418f18614@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260717-toon-speed-up-last-modified-v1-4-410418f18614@iotcl.com>

On Fri, Jul 17, 2026 at 05:47:02PM +0200, Toon Claes wrote:
> Restore `bloom_filter_settings` after prepare_revision_walk() so the
> per-path check keeps working for wildcard pathspecs.

Could we add a test which actually exercises this?

t8020 never writes a commit-graph with --changed-paths, so these new
Bloom paths remain dormant. The existing "last-modified subdir with
wildcard non-recursive" case passes a/* unquoted, so the shell expands
it into literal pathspecs before last-modified sees it.

Writing a changed-path commit-graph and using a genuinely quoted
top-level wildcard, e.g.:

    check_last_modified -r "*"

, would cover the zero-prefix wildcard case here. -r is necessary
since the default max-depth rejects a true wildcard pathspec.

(To be clear, I don't think that there is a correctness issue here,
but I do think we have a gap in test coverage in this patch.)

Thanks,
Taylor

