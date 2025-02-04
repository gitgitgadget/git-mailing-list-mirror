Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046983232
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 03:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738641389; cv=none; b=U4VVEF1Pfzm2JXFlAgE9WOwm3DttFefJqrztlirhuZB97yuFI7qKLf+pnELHhOhV32L5k9GzZMmEd+AHihXaFqKqyUI1mW2bZGUP+l73UErjRZn8UfNfBWXrxCohFoiFFMZ3a0npuwQ9wFvXB+1wPKBCT6iOD1stUxib7lBdZZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738641389; c=relaxed/simple;
	bh=Zq2OJGdjqT99xzVQwJfUIPRhdFKzIthbIn/JyY6DAyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzQJtJsP0gE3l7XLPBHMTlwEWByE5lzh0IkbGFYFKNBtqlBjBRQX+CxjmgGe1P1/Whl8STlpbMyN8EP3CmVQd8lFuGWQqopvH/1pTQe+6PcYpUFHnyFVr9cbPzTQQjScha0LAgFo9kwSvFoM0OcD95EbRZhp5CdrlUU64Gugi6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZX2MiDLK; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZX2MiDLK"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2163dc5155fso90101865ad.0
        for <git@vger.kernel.org>; Mon, 03 Feb 2025 19:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738641387; x=1739246187; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fXWqTCYJs7lmHN/mzb+gO/xe/XUrCZRwJqI33OZAsMI=;
        b=ZX2MiDLKEc6v6GxmNyyVh7A96v/e0U33wAjM501dccmI3upw/5ZVifnqmZ7DEJwlGp
         9X2/zv1VSwYUB00bXfYP0ROurah3rLLBb1/IHROI9I29RYJn9yaGWbKwxheb9MKCdJPb
         HaYoqO73Xn0C/ownivmbyoNSvZTsb8grH4Acqd1ZyHtMwk2ZkUF2GejeYABLQIf/tw5q
         qyQL7SYLi+VWl4d4nEqpUWNfwNb6KTZr4PPjR6xQGj7R5uuZLJ07eXmufd+O5pxUos5Z
         9H/wcGdIvl55c8Ya5OZhDvwFfMQclBdqG7wmG+PR1D4Engm8gOoc1B7dsHDY1gj88PFp
         aZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738641387; x=1739246187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXWqTCYJs7lmHN/mzb+gO/xe/XUrCZRwJqI33OZAsMI=;
        b=oOgIfddPOv3HBGNtOhQnGyK0QoPKuQO75bzDLXIsB+QwwPVMr5b2y+ApLtpWDS1OfW
         BZ+Jj8YlZH0HqV9jCRPNA+tylWxrDSkJWfwXn43oPUaQlQFWrP6QDBk3ZqD/e0tTCRXX
         gp/VOo9f38XnXnSgdNQdleUKuisjBHSh29YfeyoqnUREiEbT1/s/uDXcpk7UfMfU3qSi
         9hlwpJJ9S6zILteYDooqhbE4NlXqpSYrRJm93wPuvyqPLJrpFwgZULcQbzMTo/wIl2I5
         73ufkbtYuJwshNKKNh0SUJnJcO6Rf310JF3ishHSByUSrtuocOueOymDPmgILZ0cE1FX
         UUiQ==
X-Gm-Message-State: AOJu0YxDOyhaM6BpjL9+r5yPmebcVh5t/RQ9+m9kcNUvEDgH3AVFVjWD
	E+eXiFjMmB53ymbVtd/a22UOXGRn/lg8Az1VLfcGmCU7skQbufxT
X-Gm-Gg: ASbGnctIQcO4RlGSa3QtB/MXIPZvjdMdOn2JI5lJ180nUMVNaODeVTv/3PvrfmmmPwF
	Dj7rJlj9baftxAJh0ZjSDBahB2Z+ojemxwARGvC0X1EVGekEUspx2LScacn/0e2yU0Xlm7D5dhT
	8WHr/FEJjDgAi6tVgTS1Z6CcBvOH5fCMWRy9oEQ6NxjMpyzSYOvNq0MoagnouDNhSaxvstxaW0q
	00diYoAtTF736KH5FPdsbKV5IZlOlxXyDuvcE5I/9XsX/WOliYGp0jXsvHoHRhfp30IFQ==
X-Google-Smtp-Source: AGHT+IFGiuR4j5JG8F3vvm7CBZDqIpIB76j9Hkys2SQav4+B4nREasRhlGi/3TCFSqKXcyixyOJBgg==
X-Received: by 2002:a17:903:2348:b0:219:e4b0:4286 with SMTP id d9443c01a7336-21dd7d82bdbmr395251825ad.29.1738641387104;
        Mon, 03 Feb 2025 19:56:27 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2f83bfbf166sm13476702a91.43.2025.02.03.19.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 19:56:26 -0800 (PST)
Date: Tue, 4 Feb 2025 11:58:04 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 3/8] packed-backend: check whether the "packed-refs"
 is regular
Message-ID: <Z6GQTLxLVtTG6FkY@ArchLinux>
References: <Z5r6ZnLH3Ee8IQnN@ArchLinux>
 <Z5r6-52eBgT4TUYG@ArchLinux>
 <xmqqplk4duuk.fsf@gitster.g>
 <Z5zWE1M4u3NrROI-@ArchLinux>
 <xmqqikpv9cq3.fsf@gitster.g>
 <Z53triurDqskbRaA@ArchLinux>
 <xmqqseou239w.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqseou239w.fsf@gitster.g>

On Mon, Feb 03, 2025 at 12:15:39PM -0800, Junio C Hamano wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > On Fri, Jan 31, 2025 at 08:20:36AM -0800, Junio C Hamano wrote:
> >> shejialuo <shejialuo@gmail.com> writes:
> >> 
> >> >
> >> > As I have said in the previous comment, we cannot detect the error if
> >> > "HEAD" itself is corrupted. However, we will check the referent in the
> >> > later. So, we don't need to do this.
> >> 
> >> I still think you absolutely need to diagnose and tell the user
> >> about the broken HEAD.  With your "don't check HEAD because a
> >> repository with a broken HEAD is not a repository", a check run in
> >> such a place may find everything else in the repository perfectly
> >> fine, but because the user wanted "git refs verify" to tell them
> >> about breakages, you would want to somehow tell them about it.
> >> Either it is missing, malformed, whatever.
> >
> > Yes, that's absolutely correct. However, I don't want to do this in
> > this series. Actually, there is no check for root ref. I will add checks
> > for root refs later.
> 
> Another thing I just thought of is that what is your plans for
> repository discovery when HEAD is iffy.  In the working tree of our
> project, you go to a subdirectory, say "t/", and then corrupt the
> HEAD, would "git refs verify" still recognise that ../.git/ is the
> "repository" the user is interested in, but it has a broken HEAD?
> 
> setup.c:is_git_directory() would say "no", so I am not sure the
> discovery would work without changing that, and I am not sure if it
> is worth doing (i.e. when the user knows the repository's HEAD is
> broken, it is OK to disable discovery and force them to say
> GIT_DIR=/this/directory).

I have to say I am not so familiar with the "setup.c" code. Thanks for
the direction here, I will dive into to figure out a solution.

Thanks,
Jialuo
