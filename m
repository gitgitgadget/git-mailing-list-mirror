Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07623276D14
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 00:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740702071; cv=none; b=G0zuV7o6SdG7UVcISIioooUQeNT9KQyK4p/JlgwpkaLAVJ5f74G3u0N9bJtTdLl4e9MpeHrvTvDDJV9K4b5BF2ABAGmAaZEAemOTxT6JBQvb7CxLHNnLR1pdJ87KzO0hx7tTjKvjy58nBVwbHWKIKlGb9uOks5w7ngxSVClFpmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740702071; c=relaxed/simple;
	bh=GY0HYCIlpb9+qotxoZyfMWuUf/N2Hv1LK9JHNIPo7o8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jgyrlS73S2UyTr+FXRFE6fBY2zNb7JlWUUJN4R8QklgQpJXydfq0C42eAJzL1Zs6l+yP2wNsAhIiWD8wIsf7N5QV5ovBJHPrm10bs3sKnwsM12Mu/wtHbako4yxAIILuYjaHr0+49dES8xnHTKUem65NROYHXzoRFu76I3ihRFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=2RS71WKZ; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="2RS71WKZ"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e589c258663so1851663276.1
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 16:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1740702068; x=1741306868; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T6iBfn3Xu0ht+PDg+t68pid5kO0/b4fO5EE2e4ZqTcc=;
        b=2RS71WKZXRGUGD3V7h1y9AFcUirUMY/qrGgCwJZkHWXtqS1L9lSFeX57QdPJ47oTsT
         6c/T9/QCuKy/Jqf7s4VxmXgeihlkUfSkgigPVEHoiR6PJL9D0XdzN98B1L+hin9xiNvc
         QIDK8saHE4lQxqUc2NB1GB2BhPcb4pC1jg2ge9g+ZAEOKIRfWElP4yAcum6+KK/VZUlY
         ZO7+ePXozuUWVvvvMnyrxMfRaVD2uiv6XhhyPpApHN0jE4p605t+l5oGsHbh6frpwz4s
         xYJWFj+YzSExn7ljZ+AOWa7Ao+71elHyaFeTJNP/hLa6Vg2A6VFzhePtNTlMYiKY1tfo
         sZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740702068; x=1741306868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6iBfn3Xu0ht+PDg+t68pid5kO0/b4fO5EE2e4ZqTcc=;
        b=XfIvE1wDYZfTYjk39fUh40WmzC2NEn4QATV+z4A7RDJIeKrLcQe8+vTy+wGhoKuhmc
         FtkrTHelhXHXsEqoXHRAA/Ot+7XsLtzKTN/jQl4Y5TLswf4eOizkg83JtnunH2PcTc+Z
         CbDWJLr0gfpMl83ve/NltxGKDBKLzwd0Xw4OzzA2qYzXEPDcLl4k4ELeWCofOiDbP3Lr
         LLAgBe/ZGMRJ/vvGG8di/0zS3lZCv5DRpPon7aLShpbWcYiKhqHy+fiucwMSC+UpFk0O
         R9l6i6fVEXrDM4Vpilx/LmZa5VuFf6z3wgAMW1QPsL4p88WsWQAd8wRb80q/TIRJmhxv
         7uOA==
X-Gm-Message-State: AOJu0Yx3LtHQBluhEzqfR4v9P6j471Gnm5S0tja+EYvewl8+qhhJB9pN
	kuraH/y8Y6tfdUyVqIuUXLGKgGrXz5YWR6JHrZn0c3fzIQ91ovqNoaRL67asMX0=
X-Gm-Gg: ASbGncveXp+ZZiBDv15ofR7TNuQr8XelksESoS7k+O5wGNP/MMKsaqlPtcYQEIdnTkT
	5+Pt/tFTNa04s5+smGGEKPMt4JnpJ04WYr2RtS8WTGcAX4/M6Voj2F7wjBV/rG7pEbt8aghvfCu
	gERqvD1gyrxjJCwV0f/V6A5mYc9+7agjn0tFRuf66V7y6WhmQ8cExj6XFKl8wjE8idPX+T83sj0
	6RQwaPHogbjCy1Q66+m7qPupG6XuXDUiYcDcQlK3ZvbcIuvY+5NDXNvBOdxN3cVX4ukLP9IGn5q
	vH2okrREa9sOlIcv5aQ5CLP3HvpH0oshPL8RlJN8NuI7xDbb4u/GscQR0a8uFurDRbVLQrJF3A=
	=
X-Google-Smtp-Source: AGHT+IHJ05RzqpNAOAdhD3EJ/PWBpGCxovLLSjCJAFKWMxDZ32pZVnk6dBHOr//WdNIdkXG4TK7/Gw==
X-Received: by 2002:a05:690c:3349:b0:6fd:369c:637e with SMTP id 00721157ae682-6fd4a0e960bmr24716047b3.14.1740702067947;
        Thu, 27 Feb 2025 16:21:07 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6fd3cbc4885sm5178667b3.124.2025.02.27.16.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 16:21:07 -0800 (PST)
Date: Thu, 27 Feb 2025 19:21:06 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 04/10] unpack_loose_header(): fix infinite loop on broken
 zlib input
Message-ID: <Z8EBcqgn60tmXDGj@nand.local>
References: <20250225062518.GA1293854@coredump.intra.peff.net>
 <20250225062958.GD1293961@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250225062958.GD1293961@coredump.intra.peff.net>

On Tue, Feb 25, 2025 at 01:29:58AM -0500, Jeff King wrote:
> Co-authored-by: Taylor Blau <me@ttaylorr.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  object-file.c       |  2 +-
>  t/t1006-cat-file.sh | 19 +++++++++++++++++++
>  2 files changed, 20 insertions(+), 1 deletion(-)

I don't have much more to add here having helped write this patch and
reviewed an early copy of it on the git-security list. So the series up
to this point LGTM, let's keep reading on...

Thanks,
Taylor
