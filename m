Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00061F5E6
	for <git@vger.kernel.org>; Thu, 23 May 2024 18:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716488587; cv=none; b=guJUJZ3QSaUCS4n5N8N9RPR1W1PQ3ABhIXZnGTDiwJjMZTsNuFfSnL35zR7aylxGiSo6MAXsf+rLmto0Zt4on/fgG8uFQaABprzgIjbRghO/8DOb0dnMTOOI2traU+M7rXd1S7ldBgOB4vFT3gwcWcmsD7cDiixMO6hIkczmpnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716488587; c=relaxed/simple;
	bh=EFWAmYTVGYwA1zAqARF4ZYtC7PtOfTubdjKb6ae8+JM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LvKHVd62h4+/aLHLk5TyUIf2BmGAg0ZCt24i5Xk1fQNk8p+xAj6tV1nEH2slx0cda9c9CyTgu2V44v3yyPZYX5ykjrPPEqRWNkgDIpPU3zjoKJ9DJC+A6NNzVdVQIlpzQmcU3H5LKAMd7DQu31gDwZGV9fFDdynWSy/YMvW+xuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=yNQ49EeC; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="yNQ49EeC"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6f361af4cb6so1718510a34.3
        for <git@vger.kernel.org>; Thu, 23 May 2024 11:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716488584; x=1717093384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K5BbMSUgV416ExUlZ4f3mOl3XmMOieYRAkjQMUO5N1g=;
        b=yNQ49EeCx2NU3fdY2gRr0auxsX6ad6prXGXtz0ofD8fXXSNgijOqkvW6sZoDrBtxfI
         UyOHmnxLGJAMBjC4m4a4G0HGC2gB8XTyQG7/60pVpQ/IpdtWgrhgcyXm4fNZ7js+9DMO
         P1q/9UYJBzw3tdG+opcaTRIIWTiXtQyL8RHe3kh1vQch7iMSs2h5AC4mFaQ1aHHmbS8A
         AcmwMJyZugVcAZCLB9z9HiRaVOWKl7p1ZePJhX41Yq/tHOG4CkbgDHCuOHAHhRgvdxr+
         NgazJYQfUDly5R57NQpvfxePfk2InXVgqwuJbNH08C4ObRjZYaT7vYdbNIMUl0uJsizc
         mdnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716488584; x=1717093384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5BbMSUgV416ExUlZ4f3mOl3XmMOieYRAkjQMUO5N1g=;
        b=lCchLsXbffLj+5gshlOH7S4DouzemzxObqQ7f+MmHHf3Bb2bmsSoMnoNE/78bq6+FK
         PynOw8EG6e9zTrW9/wVtmWFMhpHy5BjKShG+taOQKP/dmSu5htM1O3kZIotnStMN2/sg
         nTFgyPBBY9wNSn/dGEf9Vi7gq2dT4oVkJUuWus+IDK3PAEZ/rc4X82bmDcKxApVsZBwi
         ZU9NsCt4nBEFcCqkibW50soMSVZWFBLFXnaF0PPYvFfm3OIGvbIWpQewVdVJwQ2vzw6X
         yo/x+av6rLOioTicE7rWWqWe8WjoAcP3TrDQt+vPYH67JfE6gnetpeD+/pBqNZR9r3Yj
         bV6w==
X-Forwarded-Encrypted: i=1; AJvYcCXIx3eWQmVtTWc0M6YkChSf//2CV8+k9exMf5S5OKuJGdfjRi/optPMe0VXDMn6B21ufxK9AhV5NRsJxBn6JQz6RYzN
X-Gm-Message-State: AOJu0YxnDLfIknIpf8fxOLU/HRaKT/HrsztfYocK5yoHM9+V2O3g1Ca2
	9YjOBbQxZeaji2KdpE04yr+OQIF7eLUAVJNr57XuKnM5qzrA1ueWR15yDuW3EDY=
X-Google-Smtp-Source: AGHT+IGQNTbEbzAtWiEvzFKr2aCTHD0mCk7HwKXoq3olZW5B51jCAAfhKcADO9KkJP2tYs1dZxhktg==
X-Received: by 2002:a05:6871:7824:b0:241:98e4:5590 with SMTP id 586e51a60fabf-24ca105dc6cmr85171fac.5.1716488584743;
        Thu, 23 May 2024 11:23:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df54d638fsm185470641cf.25.2024.05.23.11.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 11:23:04 -0700 (PDT)
Date: Thu, 23 May 2024 14:23:03 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 25/30] t/test-lib-functions.sh: support `--date` in
 `test_commit_bulk()`
Message-ID: <Zk+Jh50esXx7DSbL@nand.local>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1716318088.git.me@ttaylorr.com>
 <890f6c4b9deb9e3bf02aa180c7ad4ced7f7b6a80.1716318089.git.me@ttaylorr.com>
 <20240523104224.GD1308330@coredump.intra.peff.net>
 <xmqqfru8wmzv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfru8wmzv.fsf@gitster.g>

On Thu, May 23, 2024 at 08:45:24AM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>
> > On Tue, May 21, 2024 at 03:02:59PM -0400, Taylor Blau wrote:
> >
> >> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> >> index 862d80c9748..16fd585e34b 100644
> >> --- a/t/test-lib-functions.sh
> >> +++ b/t/test-lib-functions.sh
> >> @@ -458,6 +458,7 @@ test_commit_bulk () {
> >>  	indir=.
> >>  	ref=HEAD
> >>  	n=1
> >> +	notick=
> >>  	message='commit %s'
> >>  	filename='%s.t'
> >>  	contents='content %s'
> >> @@ -488,6 +489,12 @@ test_commit_bulk () {
> >>  			filename="${1#--*=}-%s.t"
> >>  			contents="${1#--*=} %s"
> >>  			;;
> >> +		--date)
> >> +			notick=yes
> >> +			GIT_COMMITTER_DATE="$2"
> >> +			GIT_AUTHOR_DATE="$2"
> >> +			shift
> >> +			;;
> >
> > This gives all of the bulk commits the same date. Which is kind of
> > unrealistic.
>
> Yeah, giving this helper function a "--notick" option, without
> adding this "--date" option, is a better design, I suspect.

Agreed. Thanks, both.

Thanks,
Taylor
