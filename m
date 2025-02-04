Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DB85588F
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 02:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738636093; cv=none; b=C4CFYD+HRzqWRMAd4bfpGlpormjA4M0OdA7b6wegwNN6tJ2at9Gwywott8zUNIHfT9ZSNAoeMxlvPCPJmLTEARMXQtsYlczsJZ6UhhQSzRmaSkCFDGRiziX+L9+43tWytj98TEaP2xpQnaD35cq2LwnVPw4bwTEcw03gCbkd1g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738636093; c=relaxed/simple;
	bh=3AG5+4fk0R1gYytZATQ7Dd7emHjxz5F4Ob9ikoBMaLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cL21QbiGo2QNy76b3cy6hsIYNp4c2WRjRHC2/dlsZmmvuqp5zNOyg4U6JZc0MtQ/hxVktnXfed0VPJF+fouoq28rrzxg/nkGlPTC0ePr5UIrQXz31Sy0fqpMvf6T6X9nuHNrLZU32giTN0g9lBDLZIuOKScmQ/gyHE7jh2S9x+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INhUUlx7; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INhUUlx7"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21f0444b478so2656495ad.0
        for <git@vger.kernel.org>; Mon, 03 Feb 2025 18:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738636091; x=1739240891; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g3EjYOQwoAQoPz9Va6RyfDmv7lD/ikqbrn7pXltZpCg=;
        b=INhUUlx77ddBaa0pZt7IP3un6yL1D+Ljwrnmt5fpT7jq3FqPkBYH+PoRG8RY3TUyw5
         MnL/f9hxg86WpMPemKP+umDxyihm+3clqN/WQlTuV+WIlRRJ+GPmCXVrY/J2qHOATLPK
         HybyFmj6LzFB1o0s98lCUAZBvjxWjh2Y26B2kYkSbacSeaj4tZ50Brb69JfZJanZwmUM
         u31Do7AgT+Rpl3i0hmF9ya98IyR+YofiWHJhW9TBBl4fxeQLYPo0+2LMpvRpqf8kDeaK
         i74uGQzt0CByx55TjqkByy3kCsuul6gMqa4Cx1S19N/ujH8Fw4FsQS6RIaQKdjK4y/gt
         OlAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738636091; x=1739240891;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g3EjYOQwoAQoPz9Va6RyfDmv7lD/ikqbrn7pXltZpCg=;
        b=CowU13EVTyOgNaDCcfN4BEbZRmwBduDDD9vPNkVaaiZS1lHRilPWTJK+GRx9N/bGhT
         /0CJaHLi2cUx96YEENKHyFeV8uV1u/RTIL9lJDSZqf++JLupPkWDBaw9N8EAcbU9hkaT
         OjYr/Nee7NIRMUeaCtSVLUXjxUCYvpvyMckhQWLl25F0BChHn171Vfd7D4SZWGPFQ6g6
         oWCJgJpJSTTkcEDb/L3rfFWiPsM5xs62JPRk0ikQdK+8quNFPHHpCkh4jLulN9IDEENJ
         wNWIP5j5SoDPubPxHbA+rzPsJQrY0xCGyb2yBC3FTFzF2H4dRdZn1vlS3yDN0FZYyhKU
         Oo4g==
X-Forwarded-Encrypted: i=1; AJvYcCXfTnU/kEQ1ZX2B6LpDF8ju8vcb0+QaLYzSdvjiOQdD8uC6UUrRGZiev4AfhR823DwVaB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYhptfpyH3CxNPMso+/ulmNCXr9BVNirwzxJv+dBzvtoiIFPWX
	6w4wO5XHxFDk/ewLScaJEHRLL1sKq3r3KXn3fasYUqmptQt3S05LMqK+Mp71
X-Gm-Gg: ASbGncvw55rDKbtIA9nnKQNKBgHi2LvO5GwZ40JcX3c/H25/0zap2iE9Fl7LY51rhbg
	fama7ehwhxikVjR4DcldhpqVGL19YjSezTotz3DBtvYh10k29zCtu2ijyeCumuz3wB2maZBLFcM
	7AtFnLaQfK9f3jNB5s6NI1rDtcv4CKb4lbrq/Cfl0FjHZpzcYQ7LSZi2PYLCC/zT3Ol+zuWAFCR
	8X0e542Afk1L2hTf4uUshg+/sxrnNHdDYONK8kasRjwb37mWq4Jz5ZGH/m/YzmbA3A/yg==
X-Google-Smtp-Source: AGHT+IGilN9XfQdEXxlunUjjyVLI+GS4FcFiaMNiM3+mrEDV6KYwiLslNqDdWq6rxglpS2foZCiabg==
X-Received: by 2002:a05:6a00:2149:b0:72f:d50a:9096 with SMTP id d2e1a72fcca58-72fd50a921dmr30275001b3a.8.1738636090620;
        Mon, 03 Feb 2025 18:28:10 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-72fe64275dasm9254167b3a.72.2025.02.03.18.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 18:28:10 -0800 (PST)
Date: Tue, 4 Feb 2025 10:29:50 +0800
From: shejialuo <shejialuo@gmail.com>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,
	Christian Couder <christian.couder@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: Git in GSoC 2025
Message-ID: <Z6F7ntBsp1CSflkL@ArchLinux>
References: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com>
 <Z432QXJb_TfzNBa2@pks.im>
 <c39c5424-71d0-4b6d-90b1-a6a70f2ee61b@gmail.com>
 <cd90cf17-6113-4634-a774-6df707b73e95@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cd90cf17-6113-4634-a774-6df707b73e95@gmail.com>

On Sun, Feb 02, 2025 at 05:22:05PM +0530, Kaartic Sivaraam wrote:
> Hello Christian, Karthik, Jialuo, Patrick and all,
> 
> On 28/01/25 23:00, Kaartic Sivaraam wrote:
> > 
> > Thank you for suggesting these ideas, Patrick! I've incorporated them
> > into a draft ideas page for now. You can see them here:
> > 
> > https://git.github.io/SoC-2025-Ideas/
> > 
> > Kindly suggest any corrections to the description, project size /
> > difficulty as necessary. I've mentioned potential mentors based on what
> > I'm aware of so far.
> > 
> > Patrick, Christian and Karthik, kindly mention the ideas that you're
> > interested to mentor.
> > 
> 
> Gentle reminder that the ideas list needs completion. Specifically, the
> following ideas only list Patrick as a potential mentor:
> 

Thanks for the reminder.

>   - Refactoring in order to reduce Git’s global state
> 

Although I never code for this, I have reviewed a lot of patches others
work on. So, I think I could co-mentor this.

>   - Machine-Readable Repository Information Query Tool
> 
> The following idea mentions Karthik and Patrick as potential
> mentors.
> 
>   - Implement support for reftables in “dumb” HTTP transport
> 
> The following idea mentions Jialuo and Patrick as potential
> mentors.
> 
>   - Consolidate ref-related functionality into git-refs
> 

I am OK wth this.

> It would helpful if you all could chime in to let me know if the
> existing allocation is fine and to what other projects you need
> to be mentioned as potential mentors.
> 

In conclusion, I could cover two projects as a co-mentor.

Thanks,
Jialuo

> --
> Sivaraam
