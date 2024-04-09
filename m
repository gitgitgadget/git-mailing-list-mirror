Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A867C6D4
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 21:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712698486; cv=none; b=SGgOVOjB2r4x8QhVe+Q1T/OaEecpJb9kdyw0hMuo4ko7+lXxQGUz9lq2w/yxgBge6IVmPeGHlWCmeZ4ZGIyXwCUXxrzZQmR6Dk3zZKaoEXqAAJYsh/mxVWonQU1L0CXI5lYhbR3zFGpLpLX3TjTiw+9DDFa7VCnjSbXfqaQCuts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712698486; c=relaxed/simple;
	bh=wupdxHJnnexgWfYYDmQQ83kuzyUoT7RowxKhmgEFKlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1w1oe9pbCHU+Bok7RossBA4D0zM1ZA99Jgh+/2QZqNbeXS//OxuUvEMSBLxT0vOK4LaDhM7SDjC7t2Zj0JccILNYjsdlNIfsIqMRwIXmiwzJQu4+Gd2ocdiaIfjKs/n/NqPxuDaIHGUqMLIIvqqp2tUjf5Po/jD3ac7UwCzsns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MK/V7Dyf; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MK/V7Dyf"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5aa318db8a0so1944876eaf.1
        for <git@vger.kernel.org>; Tue, 09 Apr 2024 14:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712698484; x=1713303284; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=grOnhfqRG3BA+g22JnS21Rxx/pY4+0zApo7yWN3pPdU=;
        b=MK/V7DyfPQn3gy3EEHJrMVnzs4d2SM8uImZb9w9Ini8kwNpjMgMcab2fAZRPZl592V
         h39UffbEGMNKvMDTh5KQgyg6ZseoO22AMj0pdwyPaJrMTXXLudJYaaJGgwo06qNlQLiv
         eD+fa2MJwFB/wK1alEAMmy0tZFQo9IVtjY62HjJGCXvjpCWuHjc859SGDDJGPBrSs5H+
         7UuqFMzX8n3fxuoBW9fCjStXIDeU0yDB+m8PmLzwLTcflG9scn4511+2olGzTQNHlYmt
         AbtEwmZ702QjwpcnE7FQpGEfBK+hOWEi3bMtYb+wLsFEo3qqZmtyNfAs7dc+PKby1LK8
         c92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712698484; x=1713303284;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=grOnhfqRG3BA+g22JnS21Rxx/pY4+0zApo7yWN3pPdU=;
        b=lHQF+kSzuGMEsF5UOn55/6pdpEBSXZuz00hhHbPphj72QBAOU3BIF2kOuoGqIRhKxU
         HUkv0K+7ywdPRb7BPNbbK4J1vN26Bnlek1lssSAlMaCWOcyqwJ0c+pYk5Zow7lnSGKBb
         zu/SgJ4K8hs1ETKvrhAbZQQX+T/Q4Zut5t9Qj/3S4YC9Xb9U74fS1Hjx5Go1FqkdFY0K
         9uQjVBIq4cFNMbvhaFXBmN9xjx8wMfSlyJCK9rtYr2woTLaAytrq5czfPebH0vyx/w+v
         dm4UtYbIY39hMGEQfBYuiXy+3YBO524kTConyhvCXTrnxsRU4UMYhwhhVLTMQ6stpFPr
         Lq0A==
X-Gm-Message-State: AOJu0YxTkKjxrJ3wzZ0GHwTjQOwh13XqtL0fwg/XVCAjbKn6q703aDL5
	m3cInoUxCatqiY95YwQkYUtR1pvvEC9fRLBVCd75dPWECR2mDxL9mRL0PLtDa0dI/uXqkvgaD/3
	EgQ==
X-Google-Smtp-Source: AGHT+IGrsobzjzBJsxTfcRulFq3myj399moQ8o/7TvnrkUcN+SPOS1qvelYKrLLnlMg05qSXP5qeBg==
X-Received: by 2002:a05:6359:5707:b0:185:fc1f:23ab with SMTP id kz7-20020a056359570700b00185fc1f23abmr1263857rwc.6.1712698483777;
        Tue, 09 Apr 2024 14:34:43 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:4457:b729:59d8:3a21])
        by smtp.gmail.com with ESMTPSA id e9-20020a63db09000000b005dc98d9114bsm8726119pgg.43.2024.04.09.14.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 14:34:43 -0700 (PDT)
Date: Tue, 9 Apr 2024 14:34:38 -0700
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/2] fuzz: build fuzzers by default on Linux
Message-ID: <ZhW0bm3gAxuvMnzi@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <cover.1709673020.git.steadmon@google.com>
 <xmqq1q7w8xx6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1q7w8xx6.fsf@gitster.g>

On 2024.03.26 14:51, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > Increase our protection against fuzzer bit-rot by making sure we can
> > link the fuzz test executables on Linux. Patch 1 is a small CI config
> > improvement to fix compiler feature detection. Patch 2 is the Makefile /
> > config.mak.uname change to add the executables to `make all` on Linux.
> 
> This has seen a handful of review comments but they haven't been
> responded nor resulted in a new round.  Can we wrap this up anytime
> soon?
> 
> We would expect a review comment to be at least responded to either
> rebut or admit the issues raised.  It may be that a reviewer's point
> were missing the mark and the patches themselves were perfectly
> fine.
> 
> But all other cases, even when the reviewer's comment were missing
> the mark, such a confusion may have been the result of the patch
> text or the proposed log message being unclear.  Of course, the
> review comments may have been pointing out an actionable issue.
> They would hopefully lead to an improved version of the patches
> posted sometime later, so that we can conclude a topic and move
> ahead.
> 
> Thanks.

Sorry for letting this sit for so long. I'll be addressing comments and
sending a V2 soon.
