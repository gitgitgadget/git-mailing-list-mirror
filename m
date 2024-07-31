Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664FE45027
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 20:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722459092; cv=none; b=eAd3BGOjRmGpAQ6c9gg+4kUMxGTgl31YIgmFuhLFvvM+CaOCUt+770IeIas9GiGDnW+2/MgNW4IpWKQSdAa+tuOmbNQ84t9HVrYyZIe1doQjwczGgehDqmIBVNAbJRjlO+iLxjyqOim4vAX8vcER0Xe1NSxjObDagKwOnnrbKMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722459092; c=relaxed/simple;
	bh=uHYdclB2I8zpb7sav3bwyQYzieU9en0dE2PG+lDtS4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TiAvvewkAYfQjdvJD0fzyi2Bpk5JsQVeI8bOWp4MZmwlEuUGO/FJNTXtjVJd0W1RXi56OalgCghRqvr26z3wrguDtJG13J2SHhI8s44qDhoJ7Xs76hjmCH0r2DCDQl/Ucx8vIt2aMAAr/jBD+U6GruSk8uoxEV2rbtUEY9cr8hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mA1mrmhU; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mA1mrmhU"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5c691c6788eso3256973eaf.2
        for <git@vger.kernel.org>; Wed, 31 Jul 2024 13:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722459090; x=1723063890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=442hGYEBQ9RPiAWxep2lYZhbPwCL1b2g40mthErmvkQ=;
        b=mA1mrmhUMj2+YDPtrEOmHX8efh5gZ1hjxyh7tHTZzu4+WDQwWy+BAEWaOB1N5WWVy0
         ufEZrvSaU/NbeGUowQhisz4huYfN0+lDZH+s111H1SAa/pxteZk7h7S1c8uNSSHBduqT
         /1riKFp+FsKQbAvW0wdW8e9loPojCELKqYaG6kpXUW6Vv2QTiZyfEkrkQ2B1qML5spPu
         nMqh9pMEqhnd89xLdEfOAeo56v1H2p6s0Gzu7UPge7hsef1l2YZC6rBe1FnEynRXHZLv
         J5AfFvpgfYcOZu4fwRSWCwVicwVkck2s9dlaOXJTgBc0mdoq7tCvrxaBvKho/GwI7wNZ
         ojyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722459090; x=1723063890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=442hGYEBQ9RPiAWxep2lYZhbPwCL1b2g40mthErmvkQ=;
        b=YrVpz/wfDdbyyzsagqBrDU5LpG72duzI/DwPz+9orm6ohW64BqzJQ+dJ8Ju8foFfSr
         JigjuiGlrUwbszZkT5cgEnFQbQXWv+QBSK3JMe6BkQ0Ed1MGKGsp2W8MDtZU6QqGmBgC
         6UXA/CHoWKkQ3HT1/cGXI4C6aYfCwP87ews8Vtcib51HchLBrlZmgn44yNAmrDsAywpP
         e5st4iNmDV9xbhYZKEFkPnaoEG/bWvBs5xkwMIEB5Ky/1Tf8/MTzv/gz1vxPZ3DWKnra
         5Frzbccyg7kPPYUI14e6CKjCjKeQS63/f7kL8IVowK02b4ASuAKyI66B2D4HMHeKyP/o
         bwkQ==
X-Gm-Message-State: AOJu0YxL+nTCBpnUaCJ9hOvWN5I6VDH3E5ThlLZ5fpsEOZoLJC55dbS4
	ZLTzU5eMssSaCeDQz7225qDOoLaKFP9R5nXgtSrCWfYjuqmZ8y/F
X-Google-Smtp-Source: AGHT+IGW+HNEZxil3D/7qE5nD3x0sAHg6iNHHuj5Kx+5bgEkqznEPAmHIOet1QHWwSy8kwHDi2DRzw==
X-Received: by 2002:a05:6820:1689:b0:5c4:68b8:e27f with SMTP id 006d021491bc7-5d61eb523aemr729967eaf.6.1722459090350;
        Wed, 31 Jul 2024 13:51:30 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7095ad69048sm1064044a34.18.2024.07.31.13.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 13:51:29 -0700 (PDT)
Date: Wed, 31 Jul 2024 15:50:32 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/3] Improvements for Perforce tests
Message-ID: <na5mwletzpnacietbc7pzqcgb622mvrwgrkjgjosysz3gvjcso@gzxxi7d7icr7>
References: <cover.1721740612.git.ps@pks.im>
 <cover.1722421911.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1722421911.git.ps@pks.im>

On 24/07/31 12:37PM, Patrick Steinhardt wrote:
> Hi,
> 
> this is the second version of my patch series that improves Perforce
> tests a bit. As with the first version, the main intent is to mark all
> tests as leak free. The other two patches polish the Perforce tests such
> that they work on my machine, which has a more recent version of
> Perforce than what we have been testing with in CI.
> 
> As discussed, despite these patches I consider Perforce to be basically
> unmaintained, and my patches do not change that. But given that I don't
> think we can rip out git-p4(1) just so without any kind of announcement
> up front, I still think that these patches are worth it to help my own
> cause, namely plugging all memory leaks hit by tests in Git.

Agreed that proposing a removal of git-p4(1) is more of a separate issue
here. For now, these patches make sense so we can get closer to making
the tests memory leak free. :)

> 
> Changes compared to v1:
> 
>   - Fix some typos.
> 
>   - Add in-code comments explaining what the compatibility case
>     statements are about.
> 
> Thanks!
> 
> Patrick

From looking at the range diff, this version looks good to me. Thanks

-Justin
