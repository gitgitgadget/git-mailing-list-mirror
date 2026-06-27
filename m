Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C12C373C00
	for <git@vger.kernel.org>; Sat, 27 Jun 2026 06:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782542463; cv=none; b=lz9RTLUN2tA7ZzgYNCVRJ3aTveW4/xD2oVgaYAlTSjAeqOz3SDuRE5mCAJcmfUn8kuGhs+JFr+egzH+bRny+dc2saCHhjHeijtF5Ktuvp0ZVloIVVEXxEK745pzU83ViFEe2JAi+YmqijcOjaPz84a1eQs6fC38ulqZ0A0dFMM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782542463; c=relaxed/simple;
	bh=rHw6CgSceROGPakDVfF6MrkWL5CjZLb92hJnTZS6V9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UpJP4G5EdI11HHhPV6kLX6jBH9L+WicIgV0IMTLnCtf4gVkv9b3AUP8HdzUUxl5RO4KhyK5vczeAnTNfZc2AO3wCqefMg+6tpNqhO4aF9tTzGKOGEXNQI1usMDov+hsic4nzRZC1sagoMoB2+F7sFcyM2QZECQFEQy7cg4dNWoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=miH/GZC3; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="miH/GZC3"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4926046fbc5so18674665e9.0
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 23:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782542461; x=1783147261; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Aj0dHb2NkaLH/lkYAdx1oqJv9B3trUq60ABI99fgKoU=;
        b=miH/GZC3HFLaIVbcIuWq5ZJMnkJsNf4NFVNV6vfpTL4on0T4Q/AXcP165Ol6ojEQS0
         y5p3V3iNlmXudsdQJ0I/aCo8z0/7/ASoGU3ir4MSvoT7VeWBdAxw8ZPwDmPHlp5vOhBw
         m1u4lidVXLNSLi5wrAkClBGThNWdyA+QD8a4EbKW6kZ9bE3LAB00auObHhvJwJFd49BL
         zc47pAgy8FvudKXB4jHW98SfW7Ig4fZsaSF/edN0Oie8KppfYTWIee1t1F7AZsdUGNpR
         nCX+XG+q+31numOOmpG3l6eR1TYRcbCM/JbopHTyCWceMzmhfTFrnz7bxDmo448UGmKH
         mjjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782542461; x=1783147261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aj0dHb2NkaLH/lkYAdx1oqJv9B3trUq60ABI99fgKoU=;
        b=aY36Ch2fgYEP1zoqAf/6jKNGM1klgskRPIShxLOt+v4ENC8rCW1NHbBas5LUVqvVGB
         CdDS1maRGxcinIhOcAba3wUzSbUpU32L4rz4Cz6TKrlbrOC/GcYOpG3rX3cGtogouq6o
         xFN2Xms8dro6eWeaotmvODCoTY30CtzaS1simrx8nMOkLKhXvIpwClaBJMaA1KSPBYAT
         HQTDy2+OnuhSgOBFyxwcQqt5a43xaIv7DlzWzjq7hwo78VnjePNMj5cJlixDH6zwRHbm
         gFATqByIXPGhA8V5R2/EIwDFd/OEecEkI3UK1gnpxGKwFIkh9yn9Gd28f6H+Rb+Ty1jh
         Z9XA==
X-Gm-Message-State: AOJu0YyhIKaOBtgloNT83ff+ZY6FHfKnMFcVT00kbyOjC1P74ZD30Wou
	1JfCzPYzqB3OFW6PQY1e+cs7MO1/K1Hp/AT1WW4ErKFzTsC/bzN8xrLC
X-Gm-Gg: AfdE7clPNND4qRvGXs6hxD25H8FpTS3xNQmzeOBbfZjTnpBVBWw7eEkWbgelp4166xK
	BvnQhb2uGj0KMhnLPBbw7l22gR5vTJ4jyuWmjjMaxKu8PrHXiLb4E7mxH8Z/Rvpki1T/AxO/Pjm
	lP6MFJ5Y+DC7sAT0v0p7sNWHInIFiTXZK5Dmou816D3ToM1GvFduQRwCPx7wZnjg4EpMByGEGaU
	p1leNUnGSGXPtGpG+cokTtQOWlO0ZM8CrjFAQCGXSQM1533Y+52HWvOJBvx7qRm4DvO2oXaHUCr
	U1UJklEvcf1gRQFHGUHPIPf4gQT9fmxKR09mBMjb/USkaOEBGoz/FDtdy5Ld8un65iiJNpOy72G
	4lX2PNndxAOfwLGR7695piTgwQX5hR8vQFZhC6kaNls6rkv3Xwlcow+3RlpUZgsvaRqS0+0WA8P
	YkqMuH1pr/p9/7as80/KzDN7yT/uLZRmzUr5qEP996+f6CqD2siO/UwF6MilYehrJVSPjmYWo6w
	A==
X-Received: by 2002:a05:600c:c493:b0:490:e180:2e0 with SMTP id 5b1f17b1804b1-492663d6dbamr122408545e9.3.1782542460703;
        Fri, 26 Jun 2026 23:41:00 -0700 (PDT)
Received: from localhost (20014C4D24E33B0043387749135D9649.dsl.pool.telekom.hu. [2001:4c4d:24e3:3b00:4338:7749:135d:9649])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49268fce60fsm127171685e9.1.2026.06.26.23.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 23:41:00 -0700 (PDT)
Date: Sat, 27 Jun 2026 08:40:48 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH RFC v2 2/2] Move libgit.a sources into separate "lib/"
 directory
Message-ID: <aj9wcFEb6oCRnfn2@szeder.dev>
References: <20260622-pks-libgit-in-subdir-v2-0-cb946c51ee7b@pks.im>
 <20260622-pks-libgit-in-subdir-v2-2-cb946c51ee7b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260622-pks-libgit-in-subdir-v2-2-cb946c51ee7b@pks.im>

On Mon, Jun 22, 2026 at 12:38:22PM +0200, Patrick Steinhardt wrote:
> The Git project is not exactly the easiest project to get started in:
> it's written in C and POSIX shell, with bits of Perl, Rust and other
> languages sprinkled into it. On top of that, the project has grown
> somewhat organically over time, making the codebase hard to navigate.
> 
> These are problems that we're aware of, and there have been and still
> are efforts to clean up some of the technical debt that is natural to
> exist an a project that is more than 20 years old. Furthermore, we
> provide resources to newcomers that help them out like our coding
> guidelines, code of conduct or "MyFirstContribution.adoc".
> 
> But there is a rather practical problem: finding your way around in our
> project's tree is not easy. Doing a directory listing in the top-level
> directory will present you with more than 550 files, which makes it
> extremely hard for a newcomer to figure out what files they are even
> supposed to look at. This makes the onboarding experience somewhat
> harder than it really needs to be. This isn't only a problem for
> newcomers though, as I myself struggle to find the files I am looking
> for because of the sheer number of files.
> 
> Besides the problem of discoverability it also creates a problem of
> structure. It is not obvious at all which files are part of "libgit.a"
> and which files are only linked into our final executables. So while we
> have this split in our build systems, that split is not evident at all
> in our tree.
> 
> Introduce a new "lib/" directory and move all of our sources for
> "libgit.a" into it to fix these issues. It makes the split we have
> evident and reduces the number of files in our top-level tree from 550
> files to ~80 files.
> 
> This is still a lot of files, but it's significantly easier to navigate
> already. Furthermore, we can further iterate after this step and think
> about introducing a better structure for remaining files, as well.

Please also discuss the drawbacks of this proposal, and try to argue
convincingly that the benefits outweigh the drawbacks.

I, for one, see myself being rather annoyed by regular 'git log
lib/foo.c' stopping at the rename barrier, and by the limitations of
'--follow'.

In my opinion this patch just trades one annoyance to an other, and,
therefore, it's not worth the churn.

