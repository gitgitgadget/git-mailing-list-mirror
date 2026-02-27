Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BCE3043A2
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 03:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772161369; cv=none; b=BoOxgsBvAGia5O05WgFqlp3l7C3J9MiC8Z7XUvg7x9w3M6nEwqv4bC+6oTbVY/4kGiDHUCnxYYvag3QNA6t2pvZ+6TPdvcJy2XE9EYBGHr7fDeyRCC/LtmgUwy5ylsjBMxylNEK2ENY47nMolKszqraKzsSpPmgF9ZUPDXS+15M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772161369; c=relaxed/simple;
	bh=YouwgXep/Cx0hcGrMSCIqBZMAMPGf8mZhfPtaUXgXrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=taig24DL8ZsO58vtzK3ri8q4NF7a70doXIwkXhcbBaE4wgmauFxx5AGU6ansU7YOTmbg+p/51olwk2Aio7M5LT6GlRiWcgp9eLHIveQ0ceDO6WLuTQF67xVVaTdh8iTaJtNKoG//cDKTbZ73xkF8t0ecPM2iIweSCzquZwNSkIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=mvH0cW5v; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="mvH0cW5v"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7986e0553bdso14622327b3.2
        for <git@vger.kernel.org>; Thu, 26 Feb 2026 19:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1772161367; x=1772766167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YouwgXep/Cx0hcGrMSCIqBZMAMPGf8mZhfPtaUXgXrI=;
        b=mvH0cW5vScZbs7LhCFaH/2A+FVsaHb+ckftUVIskqvD2WH3RWm3g/JzgKKxaiYnDq4
         jUCFUYtU2Ggtam/6eGwgWfhJ3Zq11ItWEa5uQLbQ6PtnfJPZIVufFUwbPgk2M5g4+Otq
         uKHLeIpjjBm1a4r8JrFTjJKqTx2LR+S7TjiVFaYchXJGiUfo0uHH+cfEuBN7/1cEUkhF
         9KTS82ZU9Gu1hdk6Gsa5nUbG7UfETcjTjLw675jvz4782jMv5YBEfyXNnPWcxk8b5IYV
         3+ViWieqHAsry6Ux0GMdbWcnFA3itB3tqojp8S72yNQh9bRn2YGEkgf37nDuqzXSHd4Q
         D+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772161367; x=1772766167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YouwgXep/Cx0hcGrMSCIqBZMAMPGf8mZhfPtaUXgXrI=;
        b=wwT1xe3wRRfBdY4rAH7SxJjgTdlKoKgJvBbIssMbzOtpzw68OEouZje/DNUNs2UJo6
         9abNZNwAx3z5qp095t1jLSc2d3M8NEyXhchYSf6JrbCmP9fIgHRPa8bFJL/SK/bdJl8+
         VK5o610noEpmqXtAiR0p4Wv9MRlpgjInT5HadKbQUts0jw6/Gw8Q5MpDlFx87QnGHTjc
         A9yDSqr3yah8kjF5VYd3PIegZusvPua+pCuTRSHc+5Mp0gWBMV7Z90YmIo710IyU92cG
         Jn4SNkexcBcADFH81XFsdQPcZKa91P6+/UjMFd5zfmEaN1wiPVroEaFtQ0wUG8v7itvT
         D70Q==
X-Gm-Message-State: AOJu0Yy6WTJst+weMyf/qoSx5JBD5PVV+hXpr+1XRAs6xi7LtZd5c/T+
	wgt7zRuZq2XNWKgguQLiKidHidKZIKtThoV2rWOKutzJLJnqcO3RdU71KLP2gRQ4nfE=
X-Gm-Gg: ATEYQzwio9//TIC9N3FZOH3A4WRNKmYwq1ZbMdZF4a5fVcV4E1FxYHQEnTrry0FKsYp
	2VDPp+K5VXMNXUk/+TSKoBZ5x75UWskNhtXYjXlInV2lai76Twc0PXaXVIEk5lr058Mte6qPyE/
	OslgWoWazmjl/cesbYYX18IgY01EnoL2Njc8Qch5WCHh6TD2cPM73Bbt82/V4LT2r30UhzNAvg6
	mqUCfZDaR+pJDwYm/WK18Inle4pjYJImZyr7/B3PA1qeJ0lc1nfo3/CgJr5oxEuuWfQVNaXBXDf
	c590b5EF1arBeyLoI1vLS1SnakpzdPJzhe0BBknvKrlM+4PgkuJkcv693YK8f734vqxuzfPwLBL
	/56CIqAnnRW6Lk9HiVmLeqndcm149gOBJ7rqh3XVDOSl8wWdSe3lPw+mjIEQCHWR+t0vBo1erQG
	lOnPOxDMYkX6V1G4p3TszVonD6A7PXmKqfXbqRNSyHg/5TPY5WpeOnoQbXC9K3dY501EJCdX3+T
	uK9W4YoX+APESlqdrtUijWVkmfTgG8tMBphx2f+
X-Received: by 2002:a05:690c:4c12:b0:798:6542:3112 with SMTP id 00721157ae682-798856495bemr14185617b3.65.1772161367334;
        Thu, 26 Feb 2026 19:02:47 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79876ca3953sm16062897b3.51.2026.02.26.19.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 19:02:46 -0800 (PST)
Date: Thu, 26 Feb 2026 22:02:44 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [RFC PATCH 01/14] midx: use `string_list` for retained MIDX files
Message-ID: <aaEJVDoUyL/QbY9O@nand.local>
References: <cover.1771978829.git.me@ttaylorr.com>
 <d64a799afd620363c1940d7c2e634e78ea553cb6.1771978829.git.me@ttaylorr.com>
 <xmqqldgf1c65.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqldgf1c65.fsf@gitster.g>

On Thu, Feb 26, 2026 at 12:29:22PM -0800, Junio C Hamano wrote:
> > Replace the bare array with a `string_list` which can be passed around
> > as a single parameter. Though it improves lookup performance, the
> > difference is likely immeasurable given how small the keep_hashes array
> > typically is.
>
> And if it the lookup performance turns out to be an issue, we can
> switch to strmap or something more appropriate.

True. In practice these should have at most tens of entries, so I
suspect the string_list will be completely fine.

If we are cleaning up so many stale MIDX files that we need a more
efficient data structure just to keep track of those files, we likely
have far greater problems to worry about ;-).

Thanks,
Taylor
