Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7033438BA
	for <git@vger.kernel.org>; Sat, 15 Aug 2026 23:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786835221; cv=none; b=kcKqrsYG24YBcu8oMJew2h9oUC4Xw/ERnu546FCIc32v7RtTkWL1gHvsqrP6bLKMwclnSBw6bwO16135xsGrarR+bF/fYsq/DXrgDGnrZwcZ0fHiJcK4eYMKdi+Px19x6EaeOrb8nEFERjt0BiXPcySBcWrSiWyYkKrvE5OnU50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786835221; c=relaxed/simple;
	bh=aNx8SfXSPBMFEoS5XWOFJhPYwrYEzs6lkpm28Hl7hGQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=aPzujXXVKB5e5c552X9aMokvRiuaWNkOv+tbKrA4D7/m5FdUyn/g3fVp21/FyymRDDZ2bU/pRDZKVenzzwC2Xg3upX+jTGoC/zYb6lgerytyQtw9xPrZ/rQqPmMdmeNyPikffN9dYHvSxdjKkd8/OmKke2wkQp1qzqE8PPt4lCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IcEPjS22; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcEPjS22"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38e041ea211so2307110a91.0
        for <git@vger.kernel.org>; Sat, 15 Aug 2026 16:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786835219; x=1787440019; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0/PM9Yf61UvwYuUkHACW2B2ehG3TdjJYn5cwgzU6X84=;
        b=IcEPjS2294I12Pk4Xg9OMD/ScXpRMc5VkLDu3v+HvgywdrDCVS5LFXirMUPmh2XR9U
         n+OXZI2NA0DwYIyZ8tvlKmkXZh20hCr0v+DQt6dOBDqg1Tj+kQxlIZk88fh9HmmvJ06E
         Ctumek28eRsU5T8NVck4IgqrHx+UxkqaGEj+hhuV20iAuo8iVPTmXSQhDxIebzAR5rM1
         h0FIaWGlvQtRTfmPKHpg8Q8R90xr5jNeQQXcyiLKpeG05N7B9lekFG8VN5HXme9ZUXpn
         G5/TIPwIl4ybVea82TYUTyXAfF5xBEJfcsMKGaqerDwi9WK0T/1iFORk0a8NdwBBS4/L
         igrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786835219; x=1787440019;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0/PM9Yf61UvwYuUkHACW2B2ehG3TdjJYn5cwgzU6X84=;
        b=OR0fJwfRqOtxmlR2hYcyIcFk5iKSWRQW5DpJ+KcqlkSJjLaIRuFfG8B7CSHZtlMwou
         1u06EOoV5vyN9vvCzcPKFjr1hM6BM42tdC1+15jpUFKvXWAYVF7IFT9OnnZR8aXhkQNP
         m4pQxE5uOPxXf35vWDRuocWFQqUBwxLIyruKKslZZo1OobwT6IQB929D6aQJVknzeycN
         9yKTxmSXfbDQlWGW//HNLQDT1+KTDfSJKmBidlqrwtrdU4NcBQU4pFWnjKD2XaYDYf/9
         jg2LF5GABGm28hD/xi8KjIzJDSRbvxRZuPoGb0s8DcE8gpj8k3BM1GPOwcJ6OFSrb3eb
         TNAQ==
X-Gm-Message-State: AOJu0YzqSTlgbcn0DCs9lmMyquNVS98a4mmARa5AUM+BY8bwMNUOwPM2
	Rn7/5Tccp20RUsTo22K7vz0m1G29b0VrvaSSPEOxhQNM437GVWmf39YG
X-Gm-Gg: AR+sD10BwPZjZPpder164Wr6oR+JDfaD2MZRMws0OFoyVRKz834MfieTJBBa2b1LPcf
	sZgWu4lIC4WB3OCAJfELqSX4Ho9D/IOAqcOkE3QPntRuAI4L4X/XzIL5UzpVbaJ63g/rBzU09xj
	FZTRqMl3GXZIFDgxAZs9xH1yvPGhBupiU7iin1WG3B+IM5bhnMUuXkQb+4pX7rd2BIph/AxlkCe
	PwcSpZzaGzvBPobXu6IICEtjsNNqJ9NdvAd7EcVBHjOrhn9Dzi3pfuENEQO0xnU62oUoGQz5tW1
	cO0oAHK8tOo56tLkavy6FP93RGGT2p0xRCiepSijqLoT9CvS2DHbPwn0c0jsR+8DHCAdhV3m02d
	aVcKCikOeYAULJe7OeG9Oy3CeW9uVKg5yiRsT3gCxn/0b5gFRrW7S0PQWkF5d2E2OQ2n3e0fRrs
	3X1NTwqGO237pqx4eCEPidunz7ATsv/ssR8+bD7zhzI8S27rUjqNw8+JPWb5Mz9zP9syVHajLXV
	JY6R+ojZMF0Dn+ybGUCzhEzhh76
X-Received: by 2002:a17:90b:1850:b0:37f:bfd6:8b40 with SMTP id 98e67ed59e1d1-3933b751fecmr16661314a91.5.1786835219488;
        Sat, 15 Aug 2026 16:06:59 -0700 (PDT)
Received: from smtpclient.apple ([177.33.87.130])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320ea90010bsm20486254eec.30.2026.08.15.16.06.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Aug 2026 16:06:59 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: Re: [GSoC Patch 1/7] repo: add path.toplevel with absolute and
 relative suffix formatting
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <20260716012138.6714-2-jayatheerthkulkarni2005@gmail.com>
Date: Sat, 15 Aug 2026 20:06:45 -0300
Cc: git@vger.kernel.org,
 jltobler@gmail.com,
 Junio C Hamano <gitster@pobox.com>
Content-Transfer-Encoding: 7bit
Message-Id: <749F5FAC-5803-4E7A-AEC8-BA653D329EE2@gmail.com>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260716012138.6714-2-jayatheerthkulkarni2005@gmail.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
X-Mailer: Apple Mail (2.3864.700.51.1.1)


> 
> +test_expect_success 'path.toplevel absolute and relative' '
> + test_when_finished "rm -rf repo" &&
> + git init repo &&
> + (
> + mkdir -p repo/sub &&
> + cd repo/sub &&
> +
> + ROOT="$(test-tool path-utils real_path ..)" &&
> +
> + echo "path.toplevel.absolute=$ROOT" >expect.abs &&
> + git repo info path.toplevel.absolute >actual.abs &&
> + test_cmp expect.abs actual.abs &&
> +
> + echo "path.toplevel.relative=../" >expect.rel &&
> + git repo info path.toplevel.relative >actual.rel &&
> + test_cmp expect.rel actual.rel
> + )
> +'

Question: why not use `test_repo_info_path` here?
