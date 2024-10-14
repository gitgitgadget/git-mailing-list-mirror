Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685A2231C88
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 22:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728944224; cv=none; b=tLlJc1A4Hii1S8ed3a2KGZixiFQloWj0t8k3AszXTCnSEk8RQVihscmd/G9/nkVpD4AzNyQQ8857d4LZZN+GdntWQCzGggkTzp1/rsjwCmMRhi7zT4v4GNvah7heoj+M2jZI2RLM8rtmrewFTI1KTMSJHQKQ1izNRToKP4y2Cns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728944224; c=relaxed/simple;
	bh=Kv45jnFkpnSRipqOtwgJvB8+h9oRUG0+5IUOhMY3qrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qplswDgC0O3z/tCfsms7tcgNkR0TjQm9RK962Q+43R9Q6hSXAYh4BBE5drTNxe/8WiioHFwO5tpELfFZ2CRub9ptkpFTAekA9aWSUEOGIEhJwWsR3x5Zs20jQs1viQtLynvF21x61BWBhZhUCXUyQid+FdeCUbcCpVpxxtusV7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=va7K9jwN; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="va7K9jwN"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6e377e4aea3so14957327b3.3
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 15:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728944222; x=1729549022; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Kv45jnFkpnSRipqOtwgJvB8+h9oRUG0+5IUOhMY3qrM=;
        b=va7K9jwNPSrEwpOXaHPEJfPojlgZFecCHcfvUQFfklq8rYs9zsU6+Nf9W0bfd7bCvM
         zMORxEWTdOcdCiUQQ2w/OqV/zIs8UfQt/6JNtM+emElJyz1kjXdVsdW383aJeJ2h7uOu
         fNxN1mC+rIB2ktHkcPByhLGSpvQj6qmjQZ/mbhXlApi2gOIrdsHVNavIKITujrPNahqq
         M1pa/WY8xHbNKSQBrAXhCcmGEh9xrwM5enZt4+8sxus0AvcR3ayxSMRWt+5b15aIc0rc
         XmXVKuuzz24StJzmTPEZplfXs3QvIguS0iGZ00E7h1roghx2cb4lhah8blwGYkuM3MKy
         ttow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728944222; x=1729549022;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kv45jnFkpnSRipqOtwgJvB8+h9oRUG0+5IUOhMY3qrM=;
        b=QSJlgIV6Toq3/WngZQAbBYtiIdsU6Sja7lSbF3tUX6E7gVrhsPFPGcOKuaAoMwpvpR
         O64x4m8qVfIeWGNEee8LvHYvy9UZ3PSsGAZk1OEk5p48CeCu70HF7svXEiXfknZqMaFr
         zSNPvKtssVTrfEcKnm2U3/JEnGFdCvVnY8e/3Nb18kKZVPjsV/aqV1wwWuR9RloZ2Y38
         AhUOpMAA14BKhN8qp+HNsv636f7AOnFfeOWUwJEPHBuyUDtzaMIV7F8m/OSUgMmh2dkr
         3oPd3U6Fc3w+Klcvg8rc3a8/ypGR5yKLBkYYGd08Pzr3m5Vtm05A6WPKdvHuN1TbKjLJ
         B6Tw==
X-Gm-Message-State: AOJu0YxFYsl3pDk+dUdEseZmYl9k22ruZfrIsON3mqsQPn6B9pdHg4LU
	fJ8NvWZ1YgXVxoAOQJZfYexaewLWTxtVkRJbZqtIuD+R/6K6QFTXhWh0QK430xI=
X-Google-Smtp-Source: AGHT+IHKGTOy4yOgz28yo210m4h0MTMn8+8xz+SvuTlvcRw8XzutiNZ2n5bLRzIPXy+2UGVZ/zLsyQ==
X-Received: by 2002:a05:690c:640b:b0:6c3:7d68:b400 with SMTP id 00721157ae682-6e36413fc77mr82753807b3.10.1728944222507;
        Mon, 14 Oct 2024 15:17:02 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e3c5ae1904sm92517b3.20.2024.10.14.15.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 15:17:02 -0700 (PDT)
Date: Mon, 14 Oct 2024 18:17:00 -0400
From: Taylor Blau <me@ttaylorr.com>
To: =?utf-8?Q?imme=C3=ABmosol?= <will+developer@willfris.nl>
Cc: git@vger.kernel.org,
	=?utf-8?Q?imme=C3=ABmosol?= via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH v3] diff-highlight: make install link into DESTDIR
Message-ID: <Zw2YXD6XEiQVKj9j@nand.local>
References: <pull.938.v2.git.git.1728754230466.gitgitgadget@gmail.com>
 <pull.938.v3.git.git.1728764613835.gitgitgadget@gmail.com>
 <20241012205506.GA55242@coredump.intra.peff.net>
 <CABOUa4bqPiUM+=6dxW5TTHOdMzXiFD02vWoVJcgAQDhZs8DoXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABOUa4bqPiUM+=6dxW5TTHOdMzXiFD02vWoVJcgAQDhZs8DoXg@mail.gmail.com>

On Sun, Oct 13, 2024 at 01:41:06AM +0200, immeëmosol wrote:
> Thanks to all of you for the introduction into how contributions to
> git/git are handled.

> Though it has been quite an informative introduction, and i can
> understand the suggestion of making it a install-target like other
> contrib-parts, i am currently not spending more time on this. Thanks
> again, and have a good day=

It is a bit sad to hear that you do not have time to bring this patch
over the finish line, having received some useful pointers from others
on the list.

Any takers who might want to pick this up instead?

Thanks,
Taylor
