Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B2A1F5846
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 20:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730752568; cv=none; b=h3Ehftn9Q0H78Cl8/U4OU3GPUEp72KFEBhSEvw0tMR8jEh5fwUBG59xHPs5s63kJr4Ik9ZF/RuYlBzjPzx2ZRbr4CCRffiO/2wwnVlxnvWgoYAy20+3ZEh1In+R6oGS7bjVzyOV37S5hHwam4rVXsOVCOqxxY5D84ZLUf/YmhC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730752568; c=relaxed/simple;
	bh=cJGIYhVBqX7ztSuIxXaC3QyftVjPu5WJ4qaI3J9K+Nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3/qiRzn1JjoEs+wv51BHcbx5fP8dViGXP9oS9QhuJ64GSyMB+cRgc9vpWyeNVzaCFf7q1OmgksmrFNo8AzbOe4ERiOvI4xwHEJg4ZLEKHCf8c8xU4hxweliVpP7a5Lp52zsIPbSjE43as/CZsxbc4RR3OZgFsehVwyWRLpcL44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=lwA39agA; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="lwA39agA"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e291cbbf05bso4479610276.2
        for <git@vger.kernel.org>; Mon, 04 Nov 2024 12:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730752563; x=1731357363; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0zfGqOaNShT/HZy0GrNDW0aRyF5Wmo/nnTqIp1AqJAg=;
        b=lwA39agAQyjrt6NFdQswSgumYOAkubfftK31cpG0nTx4yPh3aH/1mEvhJ5c1xZD9X6
         V2xJ3OyZJxd+izHX8GozMkUroI953f3XE0V3IPOl9fSBYEYKvxQkW8P6l2QjLTR8SK3Q
         YLgRFAppsW+ILyTPCtDxNyqjkCGJpTGJTVvb+ivn4NXfeD+hhzD7xPog/vQz7mYKBhQ/
         2Yv+mtfJ8EJ8WTQmcdqIyjwecjMb5CRGBmOIZHLw2ZmP0yM3Pl+8kDIr74l8NhVmtJVI
         RZXnaKJFBeApZFNUdsOv6NTzAkUkOf3K8M3mBQKp6iV9WMi4mslHU1Wcrfy3g5sWGnkx
         mIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730752563; x=1731357363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zfGqOaNShT/HZy0GrNDW0aRyF5Wmo/nnTqIp1AqJAg=;
        b=B4HEs0W7ERo6ViT2+7/1+0HTLuIamcqVYcjpIAcSOgyMxWJOhH9WKElP0s8h4g34yJ
         +GU9SHYDrjN7EMx0uMCkhVOiq9p2A9OcmFZycs3+DeTowsYWt72hkf0KPMP8McLmiqxe
         FEQ7icHWaK+SdmCas+mr7APAMCXmZDrIJ67s7wN3ioLN5ujRDHOdXROpSFxe99Z5uba9
         MeNHJf45rhj0N0X3y+Nt5DP8bfCrmLry0xlhnTxVetsp0unwXf9XThzwhaezLTR4pbOI
         gCOO8YsKPa0/j/WXzIUYlG6RfiNNgI/hgTwmAisMYcNm5jw8kp6MBx4dYbVz+9fM2Yzg
         2wQw==
X-Gm-Message-State: AOJu0Yy23supT4PTvjB1uRiv9co3KS6ksyFPFNhZaZdk4KylKWNH0zr4
	8B2d0b7EbUJNJxj4LCwKw78aMO/y8cdZFARxAKhGqCCY+LRM94IC5dEwbydjDpOMb06q+TepBlF
	5GOY=
X-Google-Smtp-Source: AGHT+IHMYL9TXnPC5ENkmyum5+PTzPS6RJi1A1w/qEXHvZok/MEjDg5gOMgu/ESf4NQPeG+9f+fpOg==
X-Received: by 2002:a05:6902:2388:b0:e2e:2b1b:fa8d with SMTP id 3f1490d57ef6-e30e5b24a32mr15650088276.38.1730752563297;
        Mon, 04 Nov 2024 12:36:03 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e30e8a9ccabsm2180708276.38.2024.11.04.12.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 12:36:02 -0800 (PST)
Date: Mon, 4 Nov 2024 15:36:01 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 07/11] write_reused_pack_one(): translate bit positions
 directly
Message-ID: <ZykwMW3PIpsPjbwz@nand.local>
References: <cover.1728505840.git.me@ttaylorr.com>
 <94e5c96f6859479e0206d6d775eacf54b3639ee5.1728505840.git.me@ttaylorr.com>
 <20241011081615.GE18010@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241011081615.GE18010@coredump.intra.peff.net>

On Fri, Oct 11, 2024 at 04:16:15AM -0400, Jeff King wrote:
> Ah...hmm. This is all being copied from the earlier function. So I think
> the culprit may be patch 6, which swaps:
>
>   if (reuse_packfile->bitmap_pos)
>
> for:
>
>   if (bitmap_is_midx(bitmap_git))
>
> which is what makes the BUG() text confusing. But then, what about this:
>
> > +	} else {
> > +		/*
> > +		 * Can use bit positions directly, even for MIDX
> > +		 * bitmaps. See comment in try_partial_reuse()
> > +		 * for why.
> > +		 */
> > +		return pos;
> > +	}
> > +}
>
> This "even for MIDX" is not really accurate, as we know this else block
> is for the non-midx case. Are we losing the optimization that the first
> pack in the midx can be treated the same as the single-pack case (we
> know that its pack positions and the start of the midx bit positions are
> identical, which is what the comment it mentions explains)?

Great catch.

We indeed lost that optimization when converting "if
(reuse_packfile->bitmap_pos)" to "if (bitmap_is_midx(bitmap_git))".
Let's restore that by keeping the conditional unchanged, which:

  - makes the BUG() make sense as written, and

  - preserves the optimization where the first pack in a MIDX can be
    treated the same as if it came from a single-pack bitmap, and
    bypass the bit position translations.

Thanks for spotting.

Thanks,
Taylor
