Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138E326B942
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 23:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757634006; cv=none; b=i+fE2Ac2E6rYY8584pWG3zV9DFlHDwWRqzdqhbk9xyrd9WXeU3yKvuo+ezzJbfgMZdinsksyrZF2APHt8Nz+2ao/vNpHN4mXQD6q9I12fBTx9aZ1BMs6YO6l5Wab8/XiDohXRImp4foczWzP7h6HtoC2lfTGIvYJsx46BpY7QqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757634006; c=relaxed/simple;
	bh=ZQyXjuRzrD30TnL6VPO+O+BRATeFPSeNZJY1GiC7zl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ecAMnkHl+xR4zaX4ngELgS87gCL+pRl/R2SQLdizYEx78p0XZy5RXmwhG+E2M5pwNum18qpksBSYZe8IDaF4XIxrJAofuyh02WLXHBM9EakKAa9Xq3u6XbhjYFiGVP7319dDxBo3Xr7pwt0c9rhV8yB2XHpZQ81mbo337Bk09fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=n2eab3oA; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="n2eab3oA"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-62470472ebaso592032d50.1
        for <git@vger.kernel.org>; Thu, 11 Sep 2025 16:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1757634004; x=1758238804; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bwENK3ciSlUULVaGAWwDij29tUFEYPMdkcPAVrDyEg8=;
        b=n2eab3oAreHf+enz5qgdWxxqjZ+Is2IOh36vvdWRUcRL0GZdDT05dWjSfqPDA17TQr
         Pxuh0Kz3k7TQOoLwHv6EF9EEc2+2+FmbGHYOfHsAobOTC7vileF7TrXHJe2O54TTvFWy
         ANnEfqRsST/uhi+FMM/K6N/2pnBACy+pq64+yQ5Xq4GcWT7S7HOdJKvmch0cjO12FrpT
         dfiMbq6C6bK4XXMtBw675+8OV4IFbUKiAbwGmZW9iGfngk2i2mTRIhOOyFCPFPeUD/qU
         SPAGTULL5I3tICb4XGiMWCbRWe9A1hgQTqn/qdXVdQOXBOotbILdHGzEpr+DoEMgU1LN
         y5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757634004; x=1758238804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bwENK3ciSlUULVaGAWwDij29tUFEYPMdkcPAVrDyEg8=;
        b=d/Ia0NDurzdEovS6g8WnTVH70YD8E99izZeRkTLjyg7ooPKNbODWA6GLGYlylGgnX4
         sZGJG5SjZMWONsODaG7RO+EOtW1aD4dOXDVZEp017/ZaOolXo0DQBahHgwMUJF0nhWdc
         jkjVbOwCUa5+7x8kVqryIvYlF0F70hnqdzU2PAxr5Eg1avSMpzcMHwC9kD13UkpVriPE
         9ztb7XX8drlP1GbZw2K0b17dZSFluj4Z5cFfjRFVjJ3Bbps2dvF9sTxrRQ2UhjICHLrj
         UWiCdqnlnYLO0uQxYbdNvE85cBKvqlb9+vwm7hy9O2RYvnxmaNi87Rbfbj2tsK6YovzJ
         XTGw==
X-Gm-Message-State: AOJu0YyEZdTVxNVwv5FajdDakLas8lakclu1nwxuVmenUC7IiFDiXRam
	/fz6myGMmmVXriTWyqzppVj5JZU+HTvxF1rhuWwFeHZBwIl1kh+dqvm01Ey8tv2Uufg=
X-Gm-Gg: ASbGncvJETUWdLFd6owIMBdKs0qzpKoDneiPBgsijFObaR0IeWgHMnf+U0JoLKaerS4
	/TMvlE5Yp0bnc9e+9I5gcc/zDv0019+gUjwnQIzFD2f0S2bEfMw1ZfbH8uzzXqzFKRZE/EaR5o8
	XbRvP3IMvT6pGH4/e7lgUhwtqi5CE+RNeJSVA32qohVJOaOZx2okH+8wAstX8o452p2FVQmykbL
	MXgAyAT4RSPGG6Wg50RVhMQPHcgFhSnNDBPrKA7LW4H3WvJIidWrvRg0tUkl5cl66EbDMb+eOk4
	33ogEqJq3+Ar9iYXStyArBofZDMH+pHrvYBSDJiEzs8IzNtX//8+5CNy1tmEzMmnBIYj5skylUV
	czOr/REJLvyZDZt0SkwAMuCvSphJY36XZDdSA6CikLuOaD/q8TEM37A7pVcI3iLrzAITVFSV0lx
	2LVR6VHbt2XvVVjsV3DHFPLOVnLf+0B7RgnWPP
X-Google-Smtp-Source: AGHT+IFTdZBzsvbxZmRqQTaqc3gkvzIPg4QD86eMjU94ueoAMbYiusU+lvK8QNPiZ4ufsDKFO9HEHA==
X-Received: by 2002:a53:aec7:0:b0:600:7e6b:c05a with SMTP id 956f58d0204a3-627235eb87amr965278d50.35.1757634003023;
        Thu, 11 Sep 2025 16:40:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-ea3cf00a9cdsm889674276.14.2025.09.11.16.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 16:40:02 -0700 (PDT)
Date: Thu, 11 Sep 2025 19:40:01 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 00/15] packfile: carve out a new packfile store
Message-ID: <aMNd0RkdaW4cWMtw@nand.local>
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
 <20250909-b4-pks-packfiles-store-v4-0-151c4ba3619f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250909-b4-pks-packfiles-store-v4-0-151c4ba3619f@pks.im>

On Tue, Sep 09, 2025 at 01:02:59PM +0200, Patrick Steinhardt wrote:
> Changes in v4:
>   - Small code style improvement as suggested by Junio.
>   - Some commit message improvements as suggested by Karthik.
>   - Link to v3: https://lore.kernel.org/r/20250902-b4-pks-packfiles-store-v3-0-6925278efeda@pks.im

Thanks for these changes. I think that this series is getting closer,
but I do not think that it is quite ready yet.

The largest outstanding topic is that this round claims that
get_all_packs() behaves identically to get_packed_git(), but this is not
the case. I mentioned in a response to the patch that removes the latter
function, but I think we should:

 - Permit both get_all_packs() and get_packed_git() to coexist for now.

 - In a follow-up series, transition get_packed_git() callers one-by-one
   to use get_all_packs() instead. Each of these commits should include
   IMHO a justification that the change is safe as-is, or include fixes
   to make it safe. I think any "fixes" here are limited to "if
   (p->multi_pack_index) continue;".

 - Once there are no longer any callers of get_packed_git(), we can
   remove it.

If you want to pursue that in this series, I am happy to review and
discuss it, but IMHO there is already enough going on here that I think
it makes more sense to do that in a separate follow-up.

Thanks,
Taylor
