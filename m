Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7471E32CD
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 21:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738186971; cv=none; b=ubvl1ELUBst0eJR+RsfDBYdkpysRqE+zXQTsl+iCCv2M6Y2HI2dGPxySkflpOqZeJbWA/X0xC/Ks7vcu/yW51FwMBXQ2OND3uzdD7yLKQsPpsGChvRL7TribbLvWTkqK/rZEqJ64u4R/Z+WHINmssH3HYqXO7PchlwFXHrCDXKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738186971; c=relaxed/simple;
	bh=HXB9XS/NENwNBxLUS9b2zADf/49y1Gsa0lYxap+e5mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1kvaSLygoDfi3ODs1TNGSbFzyykvpqMaKmsMp+eWSa5grxzieozf1tlw+VQ08liyVNujmHDfBcL6uZPWnw+XuG4TaQSs2mfpz0fRQ+LVRGUaplFZvqvs4Okq18GOBESEsTqF6iCvKEb6z+OvYOTAjlnHZRSpJW6otI66jO3xd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AP4TzrO6; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AP4TzrO6"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2163affd184so12715ad.1
        for <git@vger.kernel.org>; Wed, 29 Jan 2025 13:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738186970; x=1738791770; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BMceSE3ffFhwPrh3kFR+x95aP6VXK0raqVHqmiOJapY=;
        b=AP4TzrO6JoMAN4hL/pW5nQ8DLY1NXxp67X+P1+5cbslrzxL6wqP7TYS4UXObZrmi3j
         Hl4Alb1jvBOMWD2JlVrwNtu5MRg0U2zOPi+4DSY08J/peXCZARcuc2i3CVLqQptegRjs
         r+4Or5Bffi5tRvvsdAiwFPmDHdXGKo5k/zhlbgheB+ANigoD3qzL4KFLoO1/B8Q7j7as
         PDTkMrikWBT0UhUMKUaHEOtKlPq4uaeHDDsCSIMJXoLIlb4zGYdX/YOv4YBl84KJtgrL
         cWR6knsJCymHjGs/Iak/GxeL34y0Ck3RmVqDgEyhqxVV2z5CJ1sZoMRUsWuMe2WTWVkT
         MppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738186970; x=1738791770;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BMceSE3ffFhwPrh3kFR+x95aP6VXK0raqVHqmiOJapY=;
        b=cwryoOUnjsmqlvHsCaeoV3ka4m/Hvh2Cv1AyelhxIGJNLuC/PtJ2uLstt5xgt5jySe
         JAzyxCAopbgCP5jqnEIkZydoyvJm0kB0bmbbvamNqIsExb7OMTTBPXdNnAs1FybQ+C/d
         tFvZisL2j8YHt6XBHXnopUfPW9sR5t9IgsOoy0LrF3uw2WGL8W/Cs78mvu55ZBd/MFGZ
         jG0jkbXT8gvAWV1ATUOgiwyI/cjTxqL301trArwQZ0zrWxIshRFgTFySKmmRW1RLqi1S
         f1KnRsYQSQINf//jrtU60NOTfn3ztY9SnXWNM6ekTBOqhnXk9ieYaW0/PlbV0gOQXu1I
         RZkw==
X-Gm-Message-State: AOJu0YySbPRuuGX261MNrE0vzvuIN+3rjQa4MuvN/l3/9fPe+KdBRhWn
	9bwwP6eLasdvjSa3hFAVZHUqq6qkhSDfJiNsL8midTR2pCbEj0cPiKsqng7aeu1C/AIiheIsOf0
	ZnA73
X-Gm-Gg: ASbGncvrgMxrJnWvj2EtHXWeTdyo/xlLSgF3+PvYSdsmAIsKVIa4N9B+48Ho/aW5fLf
	SQOwoRI16pPeC+/nYwWVLzKtckRpMixSJNEAuvQ/B0Nr3pb9UXKu14Pv40gkhgOwkUZOc3bSmxR
	eQ7MiEGSmBK7YmXFdQNaM7UR11WgehhZTFry3E3Y67pmG6QxunyRKVLW1Z+N0LcxMwTZeDmoFWa
	xSxF8kl2uUnaSitbiMh1OUau4rw9yWq6zYWU+LmVOSCRpET1NOmkiChnpadiSCm/K9GctiVbQSk
	gSYAzeiNSG3EsA==
X-Google-Smtp-Source: AGHT+IFbpXgEHtbpkDEj8Vng4T2n/sf7Mj0qSvdAnmcFpxxOtiAuBZVycAfPGrOf3mTbuR1Vz0maBg==
X-Received: by 2002:a17:902:7d93:b0:215:f0c6:4dbf with SMTP id d9443c01a7336-21de23c7913mr694335ad.14.1738186969610;
        Wed, 29 Jan 2025 13:42:49 -0800 (PST)
Received: from google.com ([2620:15c:2d3:204:5d5a:f768:336e:8f6b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a6b403asm12006283b3a.68.2025.01.29.13.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 13:42:48 -0800 (PST)
Date: Wed, 29 Jan 2025 13:42:44 -0800
From: Josh Steadmon <steadmon@google.com>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, calvinwan@google.com, nasamuffin@google.com, 
	emrass@google.com, gitster@pobox.com, sandals@crustytoothpaste.net, ps@pks.im
Subject: Re: [PATCH v8 0/4] Introduce libgit-rs, a Rust wrapper around
 libgit.a
Message-ID: <5g5wvfoyi7avilbex54m77ds3llwymgawk35o67szrzeffgctm@dvg6vl4a25my>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	phillip.wood@dunelm.org.uk, git@vger.kernel.org, calvinwan@google.com, nasamuffin@google.com, 
	emrass@google.com, gitster@pobox.com, sandals@crustytoothpaste.net, ps@pks.im
References: <cover.1723054623.git.steadmon@google.com>
 <cover.1738101256.git.steadmon@google.com>
 <6ed6cf83-070c-4be2-b58d-398006cbb072@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ed6cf83-070c-4be2-b58d-398006cbb072@gmail.com>

On 2025.01.29 15:24, Phillip Wood wrote:
> Hi Josh
> 
> On 28/01/2025 22:01, Josh Steadmon wrote:
> 
> Thanks for re-rolling, the range-diff looks good to me apart from
> 
> >       +void libgit_configset_free(struct libgit_config_set *cs)
> >       +{
> >      -+	git_configset_clear((struct config_set *) cs);
> >      -+	free((struct config_set *) cs);
> >      ++	git_configset_clear(&cs->cs);
> >      ++	free(&cs->cs);
> 
> Which I think should be "free(cs)". In practice it does not matter because
> we pass the same value to free() but it seems a bit odd to pass the address
> of the first member of the struct rather than the address of the struct
> itself.

Yep sorry, got a bit careless with search-and-replace. Thanks for the
catch!

> I'm looking forward to seeing this merged soon
> 
> Best Wishes
> 
> Phillip
> 
