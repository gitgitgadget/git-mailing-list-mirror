Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A15D278750
	for <git@vger.kernel.org>; Tue,  6 May 2025 13:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746538974; cv=none; b=AgsZkAXlntQJn2uAIyGGqwC7Nub/IK+bKbfblA6GaZutPrfyMqKqPjOP8sdn4CwbExm0cwQIKOiyVPwR/UHvxb06/gwpK2YXCWZ/QZwcfUEDsHb765vX/qf72wf3z8GOy/PcY58uJ6QM0R9QZnKlfSPOGleWR+qZXcHf3bVRm38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746538974; c=relaxed/simple;
	bh=gSuOvGOchNgWZEBouAHPJ6o6Rp6meI8xZ/dhXrekkCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ld+Q0oUqjkfvHdj6fkNcLK6+gF0s+o6kCAuiyuNqEjeOLr9Gffgmee5r3S2KbfE+Jom39WtyomOdsDJAY5jiY6fh5JjOdjlB+t7X8Sq01wBLtUreCZ+FdDiOGXJeAMBAHahBLNMvtWCxP0iE8L1cdSqoHFjBNe78Pozkp3ttZVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hn6z63nl; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hn6z63nl"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-af51596da56so4237605a12.0
        for <git@vger.kernel.org>; Tue, 06 May 2025 06:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746538972; x=1747143772; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hAPx8dcaocbZV7NNSGr6VsRyw5TIPDLDcDVo5Ta8WGY=;
        b=Hn6z63nlJNa/5qv8xZWjP/dSzo0UIH9Mw9gSsK7Pu94V6O+1QCQ7bouE/Gfj0wssmD
         w/E3JvMauCCZ3cRjG4r4m4Jsi1PSCSQkKUc9LxWERQa26sR2n0SAfOUtYJwz79kIBtcX
         9aCsdwYiCFp51rFRBixMb0gFlD9o75tJcxoKNSMG6YrgmvA5/1suRsBkYs6g2ClpljdJ
         vDHCSYdvLGCgDFBRrqNlJ0JwMatlx64e9HdXx/ZyQe2JXujoMzPOplEVLf3HfuxMcF48
         PwEyTvP9knzCA7T+zdnSJ+c3JcB+MzHrcabdQzbgLzMpsW/1Gn8N8bDx1D+H6adi8Cwx
         Duow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746538972; x=1747143772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hAPx8dcaocbZV7NNSGr6VsRyw5TIPDLDcDVo5Ta8WGY=;
        b=XOOP/abz1xzPzqMatorRgPYhdybBrEduMvnRrII7lhMTTUYy1oMTOjhacDTvRPHfam
         eVpfzzoPjW2u70b8bMxplYvC+N3IPaxAwmjuhpRez2yqRtky7Q2PAlSFMBy8YwnO1KdE
         pY9xdfCPzAE1QlHTWmDZ+3rrIXN07nEYLZzyBmwocgoQqL5yYQNerbELAeFrYdGxCUVZ
         qQ7k97MmyyNt/NqfHX9JeQeSzBxqsvh06hZcacjc1K/iWhtx177//kQGCqCT4lNyBgE8
         sFD9mfC63Z7XcyvtaBSUPXVqQEyPvmyWwI4qVUJmDsu4VrdSV+Bnc8CbG6+gNV3iurJw
         mlvQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7RZRlJUOGmVkA0JzYivaGmbERIqUYbyZ53tss+PFlksCAwsORbm80eVoRjYOPQnuDxY8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7rjN7ssB7pDknNMI8A656bQ8cej95GAq+wRlnhrDELTuKiIgM
	V+4879+h7vK5HPPmBlHWnWh7BUaSOwYE5Ki0pXMZRUkg+9UO+rgThjfoSAlR
X-Gm-Gg: ASbGncsvyEeNBaiDvMm9c/MhUQGAnuhzw53dh9uGQg3r7/2qIeWHMYV9FBj+AkMoDbQ
	rrwis4XD560Nx6jzbPKDJfBzvSH7gZd/OhJT7vfZ0GjRvpyUjSqO3LvpHxGiOAVE1O24y4h/ZUC
	FtTtxc/zl6AH6cHArCuuv7HvW7qJz3xwiCnS5fb1+2GXP26Zqp+S9e8kSRLFkJvhE14GrJRx1cd
	Zyw4fyJdPnn6zSQegEWdMRl7CJ6lLQggHLiAt3b9hO0osDatAdu+QOeTdkiM3/Wa4HSNmoHi+Be
	Em67fEFfrYuAWrJwA7HKqMiqMk+70Nx02B/G
X-Google-Smtp-Source: AGHT+IGUH+EKKVnL9kACT50UVneqOxw+26MEzac0ETkdqATfHsARez1qVrHVcOxPD4MZoLxAT+/5ww==
X-Received: by 2002:a17:90b:1f84:b0:2ff:62f8:9a12 with SMTP id 98e67ed59e1d1-30a61a2be01mr13232848a91.23.1746538971447;
        Tue, 06 May 2025 06:42:51 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22e1521fa1csm73781065ad.133.2025.05.06.06.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 06:42:50 -0700 (PDT)
Date: Tue, 6 May 2025 21:43:14 +0800
From: shejialuo <shejialuo@gmail.com>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Collin Funk <collin.funk1@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] wrapper: Fix a errno discrepancy on NetBSD.
Message-ID: <aBoR8hrcpK6CzbA3@ArchLinux>
References: <20250502233403.289761-1-collin.funk1@gmail.com>
 <aBVp51yLwxBpRskt@tapette.crustytoothpaste.net>
 <20250503133158.GA4450@coredump.intra.peff.net>
 <xmqqtt5zoyg9.fsf@gitster.g>
 <20250505180311.GA29783@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505180311.GA29783@coredump.intra.peff.net>

On Mon, May 05, 2025 at 02:03:11PM -0400, Jeff King wrote:
> On Mon, May 05, 2025 at 08:43:18AM -0700, Junio C Hamano wrote:
> 
> > But for other kind of requirements, we want to fulfill them on all
> > platforms that we claim to support.  Using open_nofollow() to
> > achieve hard atomicity requirement would be a bug in such a
> > situation.  Should we somehow warn our developers against its use?
> 
> The comment above the declaration says:
> 
>   /*
>    * Open with O_NOFOLLOW, or equivalent. Note that the fallback equivalent
>    * may be racy. Do not use this as protection against an attacker who can
>    * simultaneously create paths.
>    */
>   int open_nofollow(const char *path, int flags);
> 
> though that may not be enough. 00611d8440 (add open_nofollow() helper,
> 2021-02-16) discusses a way that it could be made less racy, at a
> slightly increased cost.
> 
> IMHO that is somewhat orthogonal to the issue here, though, which is
> purely about the case where O_NOFOLLOW does exist (ironically, our
> racy fallback code consistently returns ELOOP ;) ).
> 
> The issue at hand is that particular errno responses are not always
> portable. The patch discussed here improves that. My point was more that
> I'm not sure to what degree we should care about errno consistency in
> our wrappers (which is inherently a bit whack-a-mole as we find new
> cases), versus trying not to care too hard about specific errno values
> in calling code.
> 
> I can see arguments either way (and as I said, an argument for making
> errno values consistent even if we try to rely on them less). Mostly I
> was just a little surprised to see open_nofollow() being used in this
> way (especially since we have to end up stat()-ing anyway to check for
> other cases).
> 

IIRC, we wanted to try our best to make our code consistent. In the very
early implementation, I actually firstly checked the file type and then
opened the file.

However, there is a chance that the raw "packed-refs" file could be
converted to symlink between checking the filetype and opening the file
to get the fd. Although, in fsck, we may just ignore this. But during
the review, I found out that using "open_nofollow" could avoid race in
some platforms. Sadly, I haven't realized that this would break
compatibility ;)

Because using "open_nofollow" could only check whether the filetype is
the symlink, we also need to use "stat" again to check whether the
filetype is OK. I agree that it is a little redundant.

Since the patch from Collin would solve the problem. I won't change the
logic. I'll focus on using `mmap` to open the "packed-refs" file.

> -Peff

Thanks,
Jialuo
