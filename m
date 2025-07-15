Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EC21DDC0F
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 22:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752617117; cv=none; b=YihXzKE41zFSJ/dlIou4bPQccNM6NeHm5fxG+c+yHuZB3dkNat04jM39/QICKteCJpuCv3aeZQPcHDMwrnV3+Pmc6AsBPSNnzMUqJ+6PgDknxzC80F1dSLhm9lZFv4FiPoyLFtSqGrdOgCKjUamFEcnWouAo/ACOuLGiKMQSS1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752617117; c=relaxed/simple;
	bh=JH/oVHdrZsIwuyhPsO3ngFaYD4p/xewsunp19U5y/bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VpbvEe2KAKInpXKz+q3wMPJ5coFV9MW7M15s9EkXpsqQqHqitgo6hxoqVaWOLZsycaLVBOaipTQYhbTHAi322IcRE3L3DiR0ebs2e+uzAEBJzDg46KHPrvBhdpGB23qihxO2QY3ozrYy2t57t2Cq2hhV+MgAtSrQkC6a3GbJywk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJipNjy7; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJipNjy7"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-41baecbdd33so693965b6e.1
        for <git@vger.kernel.org>; Tue, 15 Jul 2025 15:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752617114; x=1753221914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gy6fq/LdMKP28lXlnCzJmr3hnRdy/Xsoi40/7A/Rqd0=;
        b=AJipNjy7y05JQL7HbpcopfEwABVAQTAY4PFVuLyM2hLmlmt0pT8jtHBta3ItiZiupc
         FbC6elJs99qpGNOaArsqH/T8zZJ1KteUmgSF6z9mLgSr8K2H5yNnEHcW7mUDVJcPf6Cs
         IUabAZv9LNcdIOszIE4uhenFP86tJ2625LZia9VsACBVhdCrVJCHE854Gr56Vbiomql7
         7r7JLLEWh2ihm60a66bbcGESph6ieDA0h2BA0tCBu3I2WWvjWXsnNtOb11LM3sli0K2u
         EOpMjlgAxUVginhvV0aC6Q9Fd4CiBtLxgg+YTr8W9t7vU8WyutdEaQe9WL0ZJlysy5zp
         n9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752617114; x=1753221914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gy6fq/LdMKP28lXlnCzJmr3hnRdy/Xsoi40/7A/Rqd0=;
        b=NZCZY/K2Bmll4bCRrfaA494dhp+TLBTb3FREEtGD72KN7MZf0zRXpk85YNbkNyoVRR
         G7O0VCyrFF6fElye/66JZx5Tbk3xjPvQRSVKxoCo1aPx/y8CkHZUGftASz+zKwJUGeiP
         K4lu91FbOeaH5GpFJB88Nqrv3Emn+PMzqBCFsoqV57cHUGorYLbopv7Huj0epEOmMhRB
         yq/s2s9h4ocO6KcvmLYkyc8PdA7kbVEc5tSGDWsCr1qgyz/KKW5ed0FKhjT7VOFVGTPr
         /WiFxaWEn14ePKGciP63GHywsQ/7eaDFYkdRpMCn6q5F0a+DFHBggZLodY4Pdt6y91O1
         jvIw==
X-Gm-Message-State: AOJu0YyCk4Ce6iW3UmFkFWHUchMh7mBm5Vuz5XEvDwVAf2LO8U4nC+IC
	lbP+RKHoibcRYuIi1vM7dHXa5QF2VvTDUEwWj7fuKnahNTFqWjgvT4BC
X-Gm-Gg: ASbGnctXapPrYw34LMQHmmujBk3MI/1eBHgr5gHFugOrPdD3NG+vQl2eB2eD9MI8PA/
	AgcKKZdKMS5tdp4ADaDsduPcWqwNzMyA4a5pT40WLkHdBidVNfSvGTzlUEaHWTaaAsczetK8l6y
	CJ0VQOIxdpol2xOaS+UCUSYqQH8yzYBRclcnzZsVzevMCQjBq2uns6cwN3I6C4CWwm0HtD9Px/G
	k4HTBn+hw/1Tkmyvb+boojLFtYnfzfjnZpL3ejBfLNDo+8it2BeKQeXpMwJY8HCOjM/r2raE//e
	ziV719P91bwSYgrxpSLILHRB9wWatu/CNMgya+3Lelid04b/Wha/uSh4fKoIyEasN+SXDYyBR+0
	ne7kOaC945cHqHAE=
X-Google-Smtp-Source: AGHT+IEEnvCdKWRjHLVf2LUqotxK6ORTZg7B3b54hPZ4K4esZ7/B8WgFwVchEAAF0Uh3dtjODbJAdA==
X-Received: by 2002:a05:6808:178f:b0:41c:e74b:1f16 with SMTP id 5614622812f47-41d049967d3mr309969b6e.19.1752617113944;
        Tue, 15 Jul 2025 15:05:13 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-6159d720ca8sm345064eaf.12.2025.07.15.15.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 15:05:13 -0700 (PDT)
Date: Tue, 15 Jul 2025 16:59:31 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>, 
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/7] odb: track multi-pack-indices via their object
 sources
Message-ID: <dhfzgevg4bpv42tmtjkhjdvfiy35qh5wcue4x3b7dwjjwju4q6@2kmwfyr5g3yj>
References: <20250709-b4-pks-midx-via-odb-alternate-v1-0-f31150d21331@pks.im>
 <20250715-b4-pks-midx-via-odb-alternate-v2-0-b0ca0b4b516e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715-b4-pks-midx-via-odb-alternate-v2-0-b0ca0b4b516e@pks.im>

On 25/07/15 01:29PM, Patrick Steinhardt wrote:
> Hi,
> 
> multi-pack-indices are tracked via `struct multi_pack_index`. This data
> structure is stored inside `struct object_database`, which is the global
> database that spans across all of the object sources
> 
> This layout causes two problems:
> 
>   - Multi-pack indices aren't global to an object database, but instead
>     there can be one multi-pack index per object source. This creates a
>     mismatch between the on-disk layout and how things are organized in
>     the object database subsystems and makes some parts, like figuring
>     out whether an object source has an MIDX, quite awkward.
> 
>   - Multi-pack indices are an implementation detail of how efficient
>     access for packfiles work. As such, they are neither relevant in the
>     context of loose objects, nor in a potential future where we have
>     pluggable backends.
> 
> This patch series thus refactors the codebase to stop tracking MIDX's
> globally. Instead, they are being pushed down one level so that every
> `struct odb_source` has an optional MIDX itself. This simplifies some of
> our code and will make it easier in a future iteration to move the data
> into a packfile-specific object source backend.
> 
> Changes in v2:
>   - Changed the base of this series. It is now built on top of
>     a30f80fde92 (The eighth batch, 2025-07-08) with "ps/object-store" at
>     841a03b4046 (odb: rename `read_object_with_reference()`, 2025-07-01)
>     and "tb/midx-avoid-cruft-packs" at 5ee86c273bf (repack: exclude
>     cruft pack(s) from the MIDX where possible, 2025-06-23) merged into
>     it.
>   - Re-explain the split between object databases and object sources
>     to help readers out a bit, given that this is a rather recent
>     change.
>   - Rename `struct odb_source::multi_pack_index` to `struct
>     odb_source::midx`.
>   - Fix some overly long lines when looping through the individual
>     sources.
>   - Drop the patch that guards re-loading MIDXs, as we already have the
>     guard via `packed_git_initialized`.
>   - Remove some while-at-it changes to make the diffs easier to read.
>   - Link to v1: https://lore.kernel.org/r/20250709-b4-pks-midx-via-odb-alternate-v1-0-f31150d21331@pks.im

Thanks Patrick! From the range-diff, this version looks good to me :)

-Justin
