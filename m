Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA28E17C215
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 08:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725955277; cv=none; b=gw0dwFi83D8KxI8IB9zkQDL7JIT9wlqNQgh1PjkTUlg5iarPPIyatuqRC11MMr3/noWvGYF13Clu1t8HlSMrYEkCNR25wHOyr5G0Va8TUQ+y7X8c9zcAlIHhJKEtJnw91ZzXZQNRkSmjJZSwaAKd8mTKVH9+GoqH2ZQz/P4gKDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725955277; c=relaxed/simple;
	bh=pAn3VkjHYOQkfU7+nFdVTSPuFo3V7CtLGaBlP+NLkvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2QRMjg9wAgZYvZUR+yABpG/FEXUJAMSnAnYkWFdpdW6iupd47DFLdZK1SvAe11g1idYKvQDCCov/5xd1nEyLPt6Caq9TDRDzDu7FYZRtm/cB5Za4nWFSqfTJHg6w8eOplxmkLz7gPBdXiAE25vJrqWvYppKNilcpqkefHzLKkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nldFr+if; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nldFr+if"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-718e11e4186so468013b3a.2
        for <git@vger.kernel.org>; Tue, 10 Sep 2024 01:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725955275; x=1726560075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bU/rUCPM+L+Z/WxNfMOpeFK5OOReQHBI95juUONxIQU=;
        b=nldFr+ifZrLhSMFgJoL0iySNV+M+Mhr+ANPxbDiYZtEEs/mxqN4HFOrT83LS6SWMFU
         HXL7bmAPnFAjYHHDU+ZHSBLLLUOSwxdSGpbojbJKjTJNz79VtJc6/FkWBkPPMLzdkVyS
         kAdvDz/03YbmxjMeQIf0+8hlmbpyjGRFayTrcsLhBVT+t5NKxTITbJ/hXvbZd7p5uIcA
         W6bZ8f9PmNV1dQp/hhA+vRinGWTi0+bE/AhvJYUhUIeckgx//bdmOV50rWVNb6d37Jqb
         6XY+C1R+2IrQaqIhP+ARf7z69LhZ6sbPJO6NDVemr62jYx/4Ii5hDCQxUtjYtBsRYxNf
         p1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725955275; x=1726560075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bU/rUCPM+L+Z/WxNfMOpeFK5OOReQHBI95juUONxIQU=;
        b=USFjaZpvdyQGadcIFeWUH5e/B336S5Uja36ZxVHiTO7Zyn9NGPX5Qi4ZXL1QwKiHPh
         2mRHSFcwI2drWuVFrFWzA2YPc0GALYSzm03GTG7eifnXhD4vTsSFGY6j/6kD7OB5Nqvp
         nDLHCHtU9KoO0MdFe1uF7a5bfiTG/LC7HfX4UNe2TSE4K5/wjiWbpg6Sxdagj8m1tmG3
         gYap6J162go7C5rLunekcPnvNpG+/hC7O16S/KxFzcbcu3MsKmIp0ykg+SHXRjtzq/Du
         EsrZFiZiMs/kDQ1r/TVApxTL26wkJ6oVZTIJGQtOEfKANOrcMq2VWzcfaXXzFlrScdMr
         3edA==
X-Gm-Message-State: AOJu0Yzv/jNjmz5jUQERChItSPT+Rs5SZsAbAT99SVEdwNheq7TFMBPb
	ehldqkeo1X30Jh0THpFGjhSWHzuWWqLRkWDHi55mQniYCqPCZnLt
X-Google-Smtp-Source: AGHT+IFyKc1M03Yqdhf0ypvUYLZKpxUeIpOGLrw0nxkp+SXjMUpUCT3BRurDn1n4vtMTyzwFjAO6ew==
X-Received: by 2002:a05:6a00:2d1c:b0:717:900d:7cbd with SMTP id d2e1a72fcca58-718e335281amr12053244b3a.5.1725955274806;
        Tue, 10 Sep 2024 01:01:14 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71909092560sm848363b3a.138.2024.09.10.01.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 01:01:14 -0700 (PDT)
Date: Tue, 10 Sep 2024 16:02:19 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/4] ref: add symref content check for files backend
Message-ID: <Zt_9C1LbqO4oT70w@ArchLinux>
References: <Ztb-mgl50cwGVO8A@ArchLinux>
 <Ztb_JuMjaoAbIZXq@ArchLinux>
 <Zt8Oa4-N_8QMqUNJ@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zt8Oa4-N_8QMqUNJ@pks.im>

On Mon, Sep 09, 2024 at 05:04:11PM +0200, Patrick Steinhardt wrote:
> > In order to provide above checks, we will first check whether the symref
> > content misses the newline by peeking the last byte of the "referent" to
> > see whether it is '\n'.
> 
> I'd still argue that we should do the same retroactive tightening as we
> introduce for normal references, also with an INFO level at first.
> Otherwise we're being inconsistent across the ref types.
> 

Actually, for above situations, we will use the same fsck error message
ids introduce in [PATCH v3 2/4]. And I think we must refer to this in
this commit message.

But it makes me wonder should we use a new commit to introduce these
two fsck message ids?

> > diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
> > index 06d045ac48..beb6c4e49e 100644
> > --- a/Documentation/fsck-msgids.txt
> > +++ b/Documentation/fsck-msgids.txt
> > @@ -28,6 +28,10 @@
> >  `badRefName`::
> >  	(ERROR) A ref has an invalid format.
> >  
> > +`badSymrefTarget`::
> > +	(ERROR) The symref target points outside the ref directory or
> > +	the name of the symref target is invalid.
> 
> These are two separate error cases, and we even have different code
> paths raising them. Shouldn't we thus also have two different diagnostic
> codes for this?
> 

I agree. I will improve in the next version.

> > +	if (!skip_prefix(referent->buf, "refs/", &p)) {
> > +
> 
> There's a superfluous newline here.
> 
> Also, you never use the value of `p`, so you can instead use
> `starts_with()`.
> 

Thanks, actually I have searched the code with "is_prefix". Well, I
didn't think about "starts_<>".

> > +	/*
> > +	 * Missing target should not be treated as any error worthy event and
> > +	 * not even warn. It is a common case that a symbolic ref points to a
> > +	 * ref that does not exist yet. If the target ref does not exist, just
> > +	 * skip the check for the file type.
> > +	 */
> > +	if (lstat(referent_path->buf, &st))
> > +		goto out;
> 
> We may also want to verify that `errno == ENOENT` here.
> 

I agree, if "errno != ENOENT", we should report to the user about this
ref-unrelated failure.

Thanks,
Jialuo
