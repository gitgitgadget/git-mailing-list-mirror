Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6864C2D60C
	for <git@vger.kernel.org>; Wed, 15 May 2024 20:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715805409; cv=none; b=Lh8IuBWjUga6cjyxfUCCPmrmw2M9ev4+bsR6wE7pjH2n/WWVitZcQlQcLKcMmwjQS6xLVUJ40AU88yCZNEnDDWSjHic8FH3/1jqIsH/c/rA0qlxmEp60K6CP65I6IPyAsQ9sIklC3K5/13QP8xhWHXq0A5iwc2IcbGMWMzHZL/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715805409; c=relaxed/simple;
	bh=R899kHYq5Sj6ZD9vcL4qV/hmRwbrzDzuIZ3r4U8Htz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQTJ730RFcQuoDI7paks97VJbWClg2pBcEzi3dIN3NhWewYNmIxawoKod++asNgsz/VcDWYGvWRZJuUDjiGgn7bryPoT4vYT/MJMyRR//prFOCJ9SQsUBPradxnOFGyEE1SX3ue0EaXArl97kPeD6/YQ5qN4Amc3o+VncICDjjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NLnxUYQC; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NLnxUYQC"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5dca1efad59so5417913a12.2
        for <git@vger.kernel.org>; Wed, 15 May 2024 13:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715805407; x=1716410207; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZfzpZl6AhTM+r/ZrmU1mOw6D05AnVJ9h06nS2hsXOFw=;
        b=NLnxUYQCFaZz/PC3FsIYEgZ3CVtXdXMK6LJwJcrGfF6Emx7beDWXmfg85u1HGD1Z+8
         3/80ZAUYaU2WXat1VZpd5EWOqKDDJobGSvskupHdWmdDWISpS0BusC+45sNbIfUmJ2Ny
         jBspt9IWvzeuifSXWco2lN0NSCZCMnz5w0T7X//w2uT5DGeb6Wz1Rj5XsxWR/mSLdk9W
         nASgODVOf7C/1ZwDBkJCaqnQfr2E7fPQGMlgCV/MJfzW7Rtq98rF3v4GCI3tHYjflH7M
         ppVXjfK0K8s4hwVUv0EohMI2PJZCihOBU1ZPKsrXZPpFs4D3XlRV6pgaNL+eQFm9zKva
         T2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715805407; x=1716410207;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfzpZl6AhTM+r/ZrmU1mOw6D05AnVJ9h06nS2hsXOFw=;
        b=VMm76QN2yD/gIcMPvlRO4n1g3Iky2+Cb4UmXRMMIVW8aJuLmVBDje7az/gJO0+zsve
         qGito8JlVwIyVQoSiGqyLB2LXKVnBRtTXTB6zYyEPOsSgkAToPCXGfRVm7i/t49Q29Vv
         KvyBSTyu61/5cePxXd09oXncAYNCHiJfkejG0EahaInM6PSQ/HnXsNChaDJ+VC5ZJqMr
         8vlN92tIUPOGOVdQctWT8cXgPg+/I5exaklG4y/IygO97vhc3RXRBkgqsjz+tWZMmV2W
         70vVvKYdjjRx3gz+iy7G4wXuOIBul4OFbPMCnpkb/Ttq1pjKkOu+kqTQFJL732FCFpyM
         mlYg==
X-Gm-Message-State: AOJu0Yxx/0R6mr0bOfIDTlui9ZL9+DYocb1ErmkvFbRPU91NCpiLRFmh
	/tuFn8ud8vm0+eI2En/WbHaP/FObTgh+RNwOeV7peXRmqrDQtedk2TicmTzBcgIoeQ9sc5p2M+g
	uHz27
X-Google-Smtp-Source: AGHT+IHYcCjOvN4qt5pFQqOZkswyb91XobFvZbt5ZcPYJwfz8uV47+5S9WFfW6/SiiZliG+lfnat1g==
X-Received: by 2002:a05:6a21:2d84:b0:1af:f89d:831c with SMTP id adf61e73a8af0-1aff89d8494mr12292838637.37.1715805407352;
        Wed, 15 May 2024 13:36:47 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:49d2:d87e:dff4:5956])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4fcb6e14asm6680393b3a.185.2024.05.15.13.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 13:36:46 -0700 (PDT)
Date: Wed, 15 May 2024 13:36:42 -0700
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] decisions: focus on larger scale issues
Message-ID: <absdyh7wwpmzw67yrqa7c6ph4czekl2t2ro24muhk4k5pmqysk@b757bukiowtl>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20240510165526.1412338-1-gitster@pobox.com>
 <20240510165617.1412642-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510165617.1412642-1-gitster@pobox.com>

On 2024.05.10 09:56, Junio C Hamano wrote:
> Remove "General Patch Series" section, as its contents should be
> fully covered by the SubmittingPatches document, and make this new
> document primarily about decisions at a larger scale.  Adjust a few
> sentences that used to refer to an earlier description on patch
> discussion to refer to the SubmittingPatches document instead.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/DecisionMaking.txt | 86 +++++++-------------------------
>  1 file changed, 19 insertions(+), 67 deletions(-)

Looks good to me. I'll squash this in to the next version I send out.
