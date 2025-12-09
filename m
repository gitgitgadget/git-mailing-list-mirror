Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA3721D3E4
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 02:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765246057; cv=none; b=phqZVtqCRcdTtajZvz9b9byDdRQSv5dTVv1nI9/eyJ96UDJ4/9YNvG+up7lcGoBMef/eCi71hEpJPyTFc53b77d6Ty7gf3Pvikz0k5bpciKmJHjjD5aIn/I+eb2sFVn1kZReO9V4cQWSEChDQ1GmYVhMrolTguWQdaG79csO+tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765246057; c=relaxed/simple;
	bh=gtaTYzmp5P3Mn/4OZ8wPyFH/GmkCIHO2tyjzmNIk5Pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=daWrceI7Y67b04s6dmynUedt+aM68MGyM2UpBl1kAl5e8ADWgFwrBKHKUkqzoandTuCTbOH0luZf+a8TOi4XYjc6y6b1ijcVcHin5Vt/B05vJNz3GaVNMH9+EpiDeFIpa8CWzuL4ZOOT0V5XEb4DPjO/P2jbg+rbGUc4JYTVpCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=VPzBjfN9; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="VPzBjfN9"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4edb6e678ddso69182841cf.2
        for <git@vger.kernel.org>; Mon, 08 Dec 2025 18:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1765246055; x=1765850855; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gtaTYzmp5P3Mn/4OZ8wPyFH/GmkCIHO2tyjzmNIk5Pc=;
        b=VPzBjfN9Fc7Hgil1ixhorLQkBcxDfJzgBllDeRkbI+wkyrROnl2p0doFxvN01oeeRt
         PqrmNnb4tbJfkzIC0cOqeWDuqaUtjKte6WlftkWL1rJjXGQVEOSai3WWAxhpvyDeZsQK
         4+I4Ht0gkf6FgaQJRtgYNTXEtFnY19UKNhLk+0LMYbWKGGp0CbE3SZ9RKk8av5xEz5TG
         uGBzYZAIHGIXJCLeASsMqshFDwMmjzn2bwNx1OOev2j1n7Pn6Bz41bBQPwS8XWLukpPC
         XOye0tPg4fplt/t2HjxGBRfuC653Pnz6TJwBAx7Z2qHfyHywCGLLswvopD5qbV2RCwDV
         BT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765246055; x=1765850855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gtaTYzmp5P3Mn/4OZ8wPyFH/GmkCIHO2tyjzmNIk5Pc=;
        b=XfTeXresBwwsk6p55HjpJyD577PW4wGFi73/xFXyxCKcWvXu+awsGJ9r7eXhVMkwh+
         hCc56jD3ym5Fp1ZTUTlTJE9WblMkQ+VCTtvF8G5gHPmKCJWpXWFmDY5BhdVbNtra6gK1
         5HQqp2BpIvwraoOa5cIwqAuj6/ABTdZ+j6ZrjQwSKwK+ENH4VaM30+Y8+DQ061TQHbrZ
         mGWpnrU9SsNLTQcHvtbcI8xlJMqqb3cnxyxaXn2aQM8ARumlUsdwxFuqqLeo2QDYPHOF
         YejmbF9gjri+GAabEkgteCuJWiQvNtEQnjrZRX9Si7b494L0L9g8PvEIYuXjScguIOLQ
         n90w==
X-Gm-Message-State: AOJu0YzLn/Qf5sOxjV49PkWTcsE2dqwBY8LpSKNN/vBQZVXc0kpJ0Knr
	/5NLoTOBKMtRgmZMlj0vQIcqKBDw/Svro3ZMm5t0Wjov7pjU6B4bsS+bFem+W8uZcz8=
X-Gm-Gg: ASbGncsPAc42PNjk/QYlqtCzUoaxdU2mmc682+fCpgVdl5GtfPRvqvLEvcF64qEkv8M
	fCRDRBg/0vd9cUkXj1G9Eb4g6mWD0KUijc4YSNJLUjjIFOEchQT19+mcHY65LqBV5C8ajCQ8qo+
	CZjjWe7ZXUcz+JKE14pzqutwinTZimA+gfKdLXoDoguLumW3eVpPHHYU+kHhdJROlg+st3RBTnI
	Z7+Lz8RvxwEo84/isAYTiNTVxSgS3b8T53Eej3pGAsbmySl6AiBLEAONZ1UrqZf07aXhi+jITVt
	uetAEJ0LVEpAMIZffmao1ZETzL0LKU2jjgWiitpWVVw8QJLj6CKpkTlgbniiWzFO1SBqKnZatGB
	lD6t3BDjZdlA5gTsvz4kMzhPkXJAlXsJz5YA4DOityOFzKWw5gOn1ddWfaWOdwsdt/LOGlKn9IH
	aDI5BW/XRPl6FirZxAUKDiGVjfSMeQ1cV0P3F48wZFuBTAYhan9/6jQiN07WMYbsXtzAEdC4bPC
	SXONrNrUw3QmiphMA==
X-Google-Smtp-Source: AGHT+IHvw2OnhHfgh3+Aq+nGwxHXqpS5+7yLUy+yGdQeKyWVJ11BpSBgyTmINy3xf700UbphE0HSIg==
X-Received: by 2002:a05:622a:155:b0:4ee:197a:e80a with SMTP id d75a77b69052e-4f03ff2c8c0mr148847051cf.77.1765246054828;
        Mon, 08 Dec 2025 18:07:34 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4f02766991fsm93415381cf.2.2025.12.08.18.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 18:07:34 -0800 (PST)
Date: Mon, 8 Dec 2025 21:07:33 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/17] midx: do not require packs to be sorted in
 lexicographic order
Message-ID: <aTeEZX4036A9YecX@nand.local>
References: <cover.1765053054.git.me@ttaylorr.com>
 <d5389a93b16a4933b0c54f78f2d5ce84b9ecac53.1765053054.git.me@ttaylorr.com>
 <aTcYbRt-aUIcym77@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aTcYbRt-aUIcym77@pks.im>

On Mon, Dec 08, 2025 at 07:26:53PM +0100, Patrick Steinhardt wrote:
> On Sat, Dec 06, 2025 at 03:31:25PM -0500, Taylor Blau wrote:
> > Note that this produces MIDXs which may be incompatible with earlier
> > versions of Git that have stricter requirements on the layout of packs
> > within a MIDX. This patch does *not* modify the version number of the
> > MIDX format, since existing versions of Git already know to gracefully
> > ignore a MIDX with packs that appear out-of-order.
>
> Interesting. Did you verify how other implementations of Git behave if
> we start to relax this requirement? It seems like a somewhat dangerous
> assumption to me that this will just continue to work.

That's a great point. It looks like current libgit2 assumes[1] that the
list is sorted and complains loudly if it is not. Presumably other
implementations behave similarly.

I think that is a compelling enough argument to swing us towards
bumping the version number to avoid compatibility issues.

> Also, is there a reason why you prefer this over bumping the version
> number?

I was trying to avoid having all existing Git clients be unable to read
v2 MIDXs for such a seemingly minor change, but I think the above
compels us to.

> I assume that it cannot happen that we append to the array of MIDX'd
> packs after we have sorted. It would mean that the MIDX somehow changed
> its representation or was amended to, which isn't possible.

That's right.

Thanks,
Taylor

[1]: https://github.com/libgit2/libgit2/blob/v1.9.2/src/libgit2/midx.c#L75-L76
