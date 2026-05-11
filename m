Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32CC4A139A
	for <git@vger.kernel.org>; Mon, 11 May 2026 18:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778524727; cv=none; b=tDMULOIaE1oWMrGBDEAiAbxpoMTmNUpuG6QnYNR1zDVBqRc+err7GV/+A6w/Wp7P5crZ1De86wotbF4KxiuPsMlqCS4yp9LaulMI8y/FhPdCGnPcNWGszo4XOaNFRNMPCELn5D1t3iKpNBnhy5dvGonwfvYDS2Qj2a2CuZWlcpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778524727; c=relaxed/simple;
	bh=RIjaRPkNacibCVJRb3Yc0gM7IE+Z55Ft/Kg3DdIGSxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sgcs4KvGAmo/7z3ZHMQm8KRRJ13fACjp84nATYlHmLsKhvtVi8kZNtK9Ri8sQnMgraarj1/nCDJtIfQ0gOqo5mHjuLkGDIDCyImu+0V6f4sMUnzaGJPJ9bya1MPTyVnn4TZvBbHzgyMeV7e6AwQ567z3ePSY3IWBhDXf+DAB9NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=NZBS7dqt; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="NZBS7dqt"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-654672a6d68so5014230d50.0
        for <git@vger.kernel.org>; Mon, 11 May 2026 11:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1778524721; x=1779129521; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MHCJS+H7zitVOP/31IvQKQ6XvwtL4b23Gx7JGO1HGcE=;
        b=NZBS7dqtRx/9BqUh2RloPMdsWpi8VLMGefDzkrX5ItA6LBEErq1sS0OAs8X2eoIITY
         +G+SZi8sX358zXrJbxlJO/NP6E8Z9MtRgBBHs6soGutIrJN2a5MGFRmU9i+I6jlVRexW
         MS/0HdF3EHeFWNJiBpNQnaiVbyURnURgnsw/j2rjC9EtTbMH2i6eaMPSEI3ZSyM/NyMy
         56kgyKFnNJ0FkXrxN38C4kRD1YooB63NvmEtkNujbNCLN4r3043Wjr9E+LAhDS+4IRDj
         t+Wsv4MIytoIbmkMu7Qf1qGOJ+Vq8av1WSd1bh28CgfZXx+OZOU9sa0j1KYFahNwrKPg
         XW3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778524721; x=1779129521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MHCJS+H7zitVOP/31IvQKQ6XvwtL4b23Gx7JGO1HGcE=;
        b=E5DKxyPhlrbZIgKXz2HH7c61GQkPtRhztsL4tLt4WHAez/+05buBb6XWMDKRSfzMbM
         MVYqDsKN2o15Ado+iOFZcXHmCNHruMqw3T19+e33guiqIyrqBoZRovUHfLE6ToftE+Bv
         2xw9XBgjDM7RnuVvS9g0NsfgB5Z5lCOTqphh0UOCXJ1qjjcgFuF8YwD6d2Vu+9II06kH
         bChTT6ZaBe7d/alz4+EkxCrE1k+ZFGniuKlGIs6//HduxbTQWMG+UuLJdHjARN5+rZuf
         Pp3jdzW+3ANx1YumofIIkwXAB6RMVxQi5rYUbHqbZp4ifajj7ctaVYX0xnJMQXBq0jp9
         /A0w==
X-Gm-Message-State: AOJu0Yz5QwhifTRxgRjUCQkk6kA5CGsIaJEkSD1FalH6KSPfOFX5lLzN
	sxyudNVJx0yI33xmKaPWxl3lqEX6yTCRyfJGzYP9rZy1n7AtawUL0lbsIOewFJnS50w=
X-Gm-Gg: Acq92OFNen56/wtEs9g4Gd1JeWDwE+t+KfTclctdV7cAqR20SubjUfeq7HT714WnAT1
	650xkJK7zQUwBSjyrZ2dqo5nYrt8FVpVdi7p5zW8/kEDVk+ZeoTE5mK82HX545XNvG1U41rS2pN
	fDjgi5YMP5/bOkxg8L0BUlAHOFA1L8FzYl9b0a867TGxnTJyLJTtn1wp6DhVjy1HhzB5Aj6bEaW
	J/VAKzdkepaANraYNCKwLK7Q8F7/92CmNbPoPELi/Sw5AFg4EchNcUOp1p619OgzLbXI6xYfS4V
	wwZ0w16vacwyEOT5PsQIrMQbPiesxnH8waa4PRwMYwMSolU1hH7503ZDOPNxlNSr3+CQG4U8pbB
	WCtLSgr3B90wlcJxPX25aL5SGPLL2KXed1sAnwln8WkRWag7NNlQFOBhXIrLzNt/FuLKEymiAyL
	N4tk91/dTjQIFugmn13izJIrsosLAYrW9HO+XRasCJYyH27CZ4VDPvw//3hV1DXLIVonJCiPclx
	vqLVP/f/Qvh5Ng+TfWzTL9Pp7psyLgFZeYCAKz+fV5fPoSagfJJzfmkgJWNc6b3HiD4YMph0VgX
	4WdXgLmaSqsr65Ip
X-Received: by 2002:a05:690e:4193:b0:65d:81d3:c1c8 with SMTP id 956f58d0204a3-65d81e30af0mr17711779d50.45.1778524721393;
        Mon, 11 May 2026 11:38:41 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65d96c0e243sm5678527d50.19.2026.05.11.11.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 11:38:40 -0700 (PDT)
Date: Mon, 11 May 2026 14:38:39 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
	johannes.schindelin@gmx.de, johncai86@gmail.com,
	karthik.188@gmail.com, kristofferhaugsbakk@fastmail.com,
	newren@gmail.com, peff@peff.net, ps@pks.im,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 05/12] path-walk: support blobless filter
Message-ID: <agIiL3jBvBBLHJWD@nand.local>
References: <pull.2101.v2.git.1777926079.gitgitgadget@gmail.com>
 <pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
 <b2deb7f81939d6ed03f0ea5c8be5ec515c1c99ab.1778523189.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b2deb7f81939d6ed03f0ea5c8be5ec515c1c99ab.1778523189.git.gitgitgadget@gmail.com>

On Mon, May 11, 2026 at 06:13:02PM +0000, Derrick Stolee via GitGitGadget wrote:
> diff --git a/Documentation/git-pack-objects.adoc b/Documentation/git-pack-objects.adoc
> index b78175fbe1..917045d5c3 100644
> --- a/Documentation/git-pack-objects.adoc
> +++ b/Documentation/git-pack-objects.adoc
> @@ -402,9 +402,9 @@ will be automatically changed to version `1`.
>  	of filenames that cause collisions in Git's default name-hash
>  	algorithm.
>  +
> -Incompatible with `--delta-islands`, `--shallow`, or `--filter`. The
> -`--use-bitmap-index` option will be ignored in the presence of
> -`--path-walk.`
> +Incompatible with `--delta-islands`. The `--use-bitmap-index` option is
> +ignored in the presence of `--path-walk`. Whe `--path-walk` option
> +supports the `--filter=<spec>` form `blob:none`.

s/Whe/The/ ?

Thanks,
Taylor
