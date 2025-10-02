Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A9C29A2
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 02:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759373526; cv=none; b=fsZupPZqogVfHFifRIHwN8QFMYzxyiE3LqlvFFEo9s+OM8SBSKMlPFtV3MQPtV7QiweJCod79PaWCEd3rU+vL7uqUamLCLLyLxFEQ1v1hahWTblAMsfJOgUfUhAEpUpoQpITYZ1s+FXSts+M2e8W4r2IcHSRy0I/XLZKg72rJzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759373526; c=relaxed/simple;
	bh=saqudHbFOm0xEykzWaQgw9GNLspSh3W7ZZvxgCwCrDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jl6/bxlp6+kR7t+TjCdckNJA8Q4PZeXgO64gsMNp58yTmKwRaPSIFF1CTlengpK6ZNLIq34nOE+pIAl5yEcmBZmMeZJun5vd13oSbfmxNX9V/wFVk9cBMVtD75VNjQ3RYs0B9xLDwbNytznjoWR5cBMbnlfMpAsDc7TKL/f/cz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DjezdIHy; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjezdIHy"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b55197907d1so355981a12.0
        for <git@vger.kernel.org>; Wed, 01 Oct 2025 19:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759373522; x=1759978322; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K6CSTJikdHW91wsolaAxmkLkYyk7Kyi4DXV3EKo4E+o=;
        b=DjezdIHyd2bEmrfU1lpc8PwnDGC+UHdnEx9ka3BDVXw/GV/tU7imkHjH71WmfmopjF
         VE88rIu0Gfdrw1++K30LKG5OsuYxlxCPlsiqe94qzwCkFTV+qQsbtTZu/o3inN45lbpv
         LkTNLrHCvfUYmMa+82jaoIEPt1LOvu6Wz6hq2JV4WMPVLEG0LrVdZixVg7A/4jlBtRD2
         ovMJZc3NDTy0CMj7pk7vDd65zuOg8ZDFH4vAzy3oVLQ4N2SSGMR5G8EiL79Lc/nn8NxU
         GLRI20fUDzPPeaPC4tSemy2aBqI9qeA91Ptmab+rijEfy1cB/XKyFZqleRjnYGpHqznX
         4Gqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759373522; x=1759978322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6CSTJikdHW91wsolaAxmkLkYyk7Kyi4DXV3EKo4E+o=;
        b=IrKSX6S5/SqFpuVjxKPUqsZdaOkSUXE1VugDk6xYCmqjWzmls4ehYYZhEf1XXLppjc
         xjmhrGFA99+mqt8hMdV1Rs6jCY61eP1Ee3v+8gAftL50XDQQv+plBsYBrNHZXE35zIZL
         rQMg23/rrxTLCbnDSTEmV4XD/y1JaoZq+9xHIaxc0tt68QnQSXlKxSpYqsnUZjcXzqEy
         pNcFIFNPM+mlUkmVDGsMDGssPwOH0Fx58C/WoIemXFlu8jhblcHkLFxL2wAenjuCJbQg
         HOVv/MUp9PKEJq0tdPKokUHtvUVT7wWoXre9E60zTmbwoGXyZy/ZVBTGXUgLp2UkmUUE
         x9cw==
X-Gm-Message-State: AOJu0YxEYHPZVE8jdkyCyaIZBHd0EnBsS/J/QYKDEpA1GE3///YgCev+
	FJj+H3v5aEkTvyN4sh9CrosJTmLl7frsyI8QosY8+q6UpRfg4f/VpXlP7IVQgi0M
X-Gm-Gg: ASbGncuacpBIHq7xuBEaKRPdZ141xH0LAIKpO+xQ4D/zGAzG1maY+0itWuEVCAXrliT
	vX+DraihvUEC0xrTftoHN22HMggSOb4c5UHmvz2yX3WRKMHmfY3WANsYZdbeGqFIgz8Ix9ClFQK
	xKjB0rtL852AOFdpMGNGqzbHw5qjMc+kFgE0mS20GVI0qLHU4wDGnppXWfGL4XzTXkDY6ABYlcp
	R92489rkOFMzLyNtUnV1WwhR4C7qts60pvWBYwI/nRz9gJdHxaXHEi6rYJbgPJcn0xOrYhP/vkA
	5VxRbf2QcX9pO1717YqTi0l6BgoedQLm3f97I8PB84vUxndXEfh6n3KtuuKnowmnAbA7p8iRgDP
	vGKLoUMLgK4Ev4PoJe4jGJfqTjiXpMV4uoNQ1n5tEkvxOa64mYcgsPgJG
X-Google-Smtp-Source: AGHT+IHg/fmSNhnV/gmw8s/+LSp0DFjPxr7YeUDMprU3plJ3QvM5nBETHYaCWSX0g5fpeJwpqEIzyg==
X-Received: by 2002:a17:903:1a2e:b0:277:9193:f2da with SMTP id d9443c01a7336-28e7f27dab1mr75984885ad.5.1759373522497;
        Wed, 01 Oct 2025 19:52:02 -0700 (PDT)
Received: from localhost ([2804:248:fd27:1700:3748:9d8c:286:76f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1280c9sm10484165ad.53.2025.10.01.19.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 19:52:02 -0700 (PDT)
Date: Wed, 1 Oct 2025 23:51:58 -0300
From: Henrique Soares <henriquegogo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: How mantainers check Git diffs and patches?
Message-ID: <aN3ozlH_pPnvdWPn@localhost>
References: <aNygY8Cm7LEaBzV6@localhost>
 <xmqqh5wi3779.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh5wi3779.fsf@gitster.g>

On Wed, Oct 01, 2025 at 09:41:46AM -0700, Junio C Hamano wrote:
> Patches are medium for reliable transmission.  Once you apply the
> patch to your tree (perhaps giving it its own topic branch, perhaps
> to a detached HEAD with the full intention that you will discard it
> after you are done inspecting the change the patch brings in), you
> can use any regular tools you use while developing and reviewing
> your own code.

It makes totally sense. So I suppose you avoid to review the code just
checking the e-mail patch in e-mail client, but first applying locally
and then check it in your code editor in a separate branch, worktree or
whatever, then back to e-mail thread and comment the code, right?

-- Henrique
