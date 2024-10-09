Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32561925A9
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 12:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728475252; cv=none; b=VkRP9pam5c6oRV1MNAcKj1FNrzBUzWlNnFQnMFxHVqvvJYaj8fd6sJhT8S9b5z6XIf0uUgsDzOv/8LSRfBJj5OHWzVtQ9wmYdjmyuYmTXyJy8JxZ6S4GaKVTUp6ZzOLRxUmkMT3qBEQHtwBRKNJyXlrWaKjksbGc2SfQVxJMlK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728475252; c=relaxed/simple;
	bh=U2iakw99Rs/O1X2ajB/3r73vhC7zUTrCUIlwgUIfP5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=reKNFdfXoplkplnx4QKjSZ9DqucYUsSP3I0X4y8oO4tJNzPjnEY+tnDjZwYeHvYJSmy76tB4EsO+HNpYZmZHD7TTfqMb8a+ZCO0EmcPkACNBdi1K7ygbZesqjAZN9uV4F3BCRUBz73mNVvaJVrZHfYmQNcoBqWFI2fVIwCXEBxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3J5nSW5; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3J5nSW5"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71df67c67fcso2815441b3a.2
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 05:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728475251; x=1729080051; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sSWN4apeU2vn2T82bwqcMqiZebJ0O0pEch1H5CIjYiE=;
        b=A3J5nSW5WyJ3LmhuZZ2V+2FOdw+9AKqcHQ7NuPzHP1p9gbrP3XmgaBCXO0/gpAlReK
         Z92dWH/npZK+QHkP9oUP45ZJ8M8WRU5RwHc0LB6+pUggxQa+4prOTkl+H9WbXVfJx+Lm
         AxgBFN1ZnRgwdV+GpY/pSmYyrPjIJ2BRTtSw+fU0ZljR2YFvk03ghOpaT5JUMh9fU5lQ
         w37OKIZsi0B+H5WhaxvEWbDJBBVqL6QheESUoSoM2TgtpMIKrm7Bt6qjF16Og9wa2xH0
         YsEOGjpEc7WRuCQgn/rGqA9CB+ZVM7ReDgGN4k3T2NqFsIAuUv5SObzR8Hw0KbvavxUt
         8snA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728475251; x=1729080051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sSWN4apeU2vn2T82bwqcMqiZebJ0O0pEch1H5CIjYiE=;
        b=ikDSv3c+dbQsTkUxQhvHIEjUfe4TL/JyCmHovfN9rvvbDPEI124733kr0Ruc7WqQ/c
         J/Yl3cjDu70ZaLG664xL+Rzmcpf4Pw9ZUgm26qtxYRj5OzSSYwEHmE8VNlQ1tB+rLiTH
         +Y8U42QH7dY1CexpFPVvOLeT9HlxhBMNXkGUCtRORzPjXwm0RCGIB13HigGGx2wvUITk
         esT3rBMTsyGY4Ib9jr9npMUHLbLfgQ6PAgwNaoiDpE0Bob+H8/c8lrfd1p2EK2vX5Dfm
         0WFGRXkx9UAyassjnKFpOuqe9m7xOY0Y8YvlSc+BHyTZzarBjVQBby9ECm8un2iKfcVk
         33iw==
X-Forwarded-Encrypted: i=1; AJvYcCWstNK2DszXNA+EBWKsFZcuQ6Qio76Jpg+QUKJiL3c9cv82KlsdtIW8Es76kawuy2yy2vQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUEzkj0kFattr/MOHTlmL05nocOn5zkWAggNUAg/XfcCLbwefG
	BHToTeiijtlKWf6AimCByBj3v9iNFF2oyMAH935p/EzWzVOsV2Xl
X-Google-Smtp-Source: AGHT+IHda7V3yAJ1DHcJA+Z3A31I2PIIqNTNH4UlCher07wdXlPyOhPiDbqousNIzrthqV83i0GFzw==
X-Received: by 2002:a05:6a00:2303:b0:71e:21:d2d8 with SMTP id d2e1a72fcca58-71e1db73e07mr3459800b3a.7.1728475250899;
        Wed, 09 Oct 2024 05:00:50 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d7d3b5sm7630666b3a.215.2024.10.09.05.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 05:00:48 -0700 (PDT)
Date: Wed, 9 Oct 2024 20:00:54 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org,
	peff@peff.net
Subject: Re: [PATCH 0/3] object-name: don't allow @ as a branch name
Message-ID: <ZwZwdvlQv9AMRJpI@ArchLinux>
References: <cover.1728331771.git.code@khaugsbakk.name>
 <ZwUxdz_HobRGF9yq@ArchLinux>
 <xmqqjzei1mtb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqjzei1mtb.fsf@gitster.g>

On Tue, Oct 08, 2024 at 11:17:36AM -0700, Junio C Hamano wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > The reason why "git refs verify" will report this error is that in the
> > code implementation, I have to iterate every file in the filesystem. So
> > it's convenient for me to do the following:
> >
> >     if (check_refname_format(iter->basename, REFNAME_ALLOW_ONELEVEL)) {
> >         ret = fsck_report(...);
> >     }
> 
> It may be convenient, but I think it is wrong.  HEAD may be allowed
> at the top, but refs/heads/HEAD is not, and checking only the single
> level name as you descend into .git/refs directory hierarchy and
> find files would not be a good design to begin with (and it would
> not work if your backend is reftable).

In my current work, I will introduce worktree check here and then I will
use the fullname to check and this will not be a problem. Thanks for
reminding here.
