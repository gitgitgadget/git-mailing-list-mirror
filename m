Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5841D29374E
	for <git@vger.kernel.org>; Mon, 12 May 2025 12:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747052679; cv=none; b=L0K1pgiStoVjwl4Y+MglvOka6aD6aRjbSvdNmv5u0X7YhtK6H7LaqJK3oO22g3wM7c2SiM/HYQUcFDklV8IvbJGdqBVbDgqe67YhgVgJtv/Dk+XDj5thgG94tCrscmbN6qRBFuby+ypS4d1W70dz6eyqMoJJNCC9fR5XONBQJuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747052679; c=relaxed/simple;
	bh=W7HR/6OSVCkW8IsCjw2bDqdxRgVP4LmLlXfi9lIBTbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jNR7Zb8oeEQdKdrMwibc3esw9TH/sNtLnMQCXIbrjHGshontxJnewQEu+o4bKFBQT3VzhzAOB8LiAxjfIItM28aB0+dzXMPnY1MFPuf533/iPJwrnGcFzssV8srnyAs1yWvYRLJEJ7Z1qWZ3AYAE4XoCsvKd71xqlh0Vmto6j2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4Ofph5j; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4Ofph5j"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-30ab344a1d8so4141672a91.3
        for <git@vger.kernel.org>; Mon, 12 May 2025 05:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747052677; x=1747657477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6fy7cl42/sfPmKO7r14/Cs5Dl6YaRE+rhhPuEJoq/TM=;
        b=Y4Ofph5jij4huZEviweYn2F9Q5PpT+7WkYYLHnHj5WL47xaHss5ZsBNihT/nu/IYRj
         D30bDMfJvRHOY+XEPmHy2o9N2biIs3uxHrtafTXPYSfvu2XMkLLTuGeq1mcAuzWNadhI
         HWOj2eiF8rmAL+dcAgHTfUqKlU45N3l240u9PKif24df2X3FtXNaokLvQ2FNMfy/URaJ
         iBqyoEX+V0zl9GeUd9eFNcaWay6mirhHpz27Aspvyqq9lqDTdl4zT8vhRDwjd8scAO4q
         VkTdm4b1nNOzPFhxC9hgR2KhhlrODr59Jpn2AJsLrVuWrCYzReCHDuk5pYjeOwWukd6x
         yINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747052677; x=1747657477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6fy7cl42/sfPmKO7r14/Cs5Dl6YaRE+rhhPuEJoq/TM=;
        b=ctNJwbZ5/2LE7/vQHALcXUENKzcex4frkSeX3VBjGZHGzNtV8jr90Db6ouT2fvSwT+
         +yi5T7JrAI3PF4QAIMeqUdqQcCr/hy8USVDlcuta0BBflLGlmCdD+1IHFHYwIZy4yIQo
         JtcANu+DxeIYnVHYuHt5uWxDmqnTJOWU+c9rklb6sRSyWWMY2bLTg02m2oqgKQuqw7un
         2lJCQZVL0UCC1aRX865qhMXcomVWIWeopdfCIYwI7Zz2dA0/PgDC1izQ7N+5k3fgpqKP
         C8W/+lC1qQOdHvR4yrEeAczzJKhFt+w7V1+e9+k1zOiK5sX2FYq3naIPi9feYrAGz84U
         JW3g==
X-Gm-Message-State: AOJu0YzgtbwlIGBnnQB8PAng+SARiEckuHvWCd/bfl5GaJFAdGZoOQ9W
	8pGcfINq/YdjX2OMEYJCYy13MIU8M+qQWibJzNJwn4Z4hunox8nR
X-Gm-Gg: ASbGnctj7X2CUpckPxxOOWlYkQJo82EBPwIzxzNhS2k0XMxtwRNKpTktrsvS/ANp7/c
	cpqrSCQ2S8Ykz/MRRbK8oti5QNh2aDzANinE0WV5d0+Z4joZ57Ljx3NYU1NGbyJBA8df7R4P14c
	5Tsg9cFjLEKW5uNegYMu2PSoQk9c+UALv0tCgXr9VUm/5ps+gIiSKLwdbm2+6F4EbxN5li1js1L
	FopF3T605qArmkT8Kw1LjnsQ+MpGigrKG/XdBqnmVzZrcFGp9aZGCAxugrS31tqT+aNxE2ZMB6Z
	IUJeLVdmg4betSMTZ8WnNbrjP7BHr37qisZIcpXrjHU2xMk=
X-Google-Smtp-Source: AGHT+IH2WugIFE3Nga9mwTweMManwN3TZfJKlYaU4MOerEgKEb5hk0cSyJRkU5nZKlVET86+C6JKCA==
X-Received: by 2002:a17:90b:3907:b0:2ee:f076:20f1 with SMTP id 98e67ed59e1d1-30c3b910265mr25607083a91.0.1747052677401;
        Mon, 12 May 2025 05:24:37 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-30c39dd5899sm6548801a91.12.2025.05.12.05.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 05:24:36 -0700 (PDT)
Date: Mon, 12 May 2025 20:25:06 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/3] packed-backend: fsck should allow an empty
 "packed-refs" file
Message-ID: <aCHoovrKiSUemBCL@ArchLinux>
References: <aCCtQDnWII-knmEc@ArchLinux>
 <aCCtx2mqihlc0M7H@ArchLinux>
 <aCGzIlLH_ESNg6-v@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCGzIlLH_ESNg6-v@pks.im>

On Mon, May 12, 2025 at 10:36:50AM +0200, Patrick Steinhardt wrote:
> On Sun, May 11, 2025 at 10:01:43PM +0800, shejialuo wrote:
> > During fsck, an empty "packed-refs" gives an error; this is unwarranted.
> > We should just skip checking the content of "packed-refs" just like the
> > runtime code paths such as "create_snapshot" which simply returns the
> > "snapshot" without checking the content of "packed-refs".
> 
> I think this doesn't quite answer the question whether this is a _good_
> idea though. The question that we need to answer is whether there are
> any writing code paths that may end up writing a "packed-refs" file that
> is completely empty. Modern Git would at least write the packed-refs
> header, wouldn't it?
> 

That's right. In the current codebase, we would always write the header
which could be easily reproduced by using the following command:

    git init repo
    cd repo && git pack-refs
    cat .git/packed-refs

And in "packed-backend.c::write_with_updates", we would always write the
header.

> The reason why I'm a little sceptical is that there is a common problem
> with ext4 caused by its delayed allocation [1]. If you:
> 
>   1. Write data to a temporary file.
>   2. Rename the file into place.
>   3. The host system crashes.
> 
> Then it may happen that the renamed file is now completely empty.
> 
> The root cause is a bug in the application: before renaming the file
> into place it _must_ fsync the file to disk. Git does that by default,
> but it is extremely easy to get wrong and we had bugs around this until
> ~2 years ago, if I remember correctly. We hit the problem several times
> in our production systems.
> 

I see. I agree that in the most situation, an empty "packed-refs" file
means that there is an issue.

> So I wonder whether ignoring empty files would cause us to miss such a
> common error. But I guess if there are valid cases where we may end up
> with an empty "packed-refs" file we cannot do anything about it.
> 

I somehow think we would always write header in the Modern Git. But
"create_snapshot" accept an empty existing "packed-refs" file at
runtime.

And header is introduced in 694b7a1999 (repack_without_ref(): write peeled
refs in the rewritten file, 2013-04-22). At this commit, we would always
write the header into the "packed-refs" file.

But in runtime, we accept empty file or no header of the file content as we
want to keep compatible. In my humble word, I think we should allow
empty file at now. Then, In Git 3.0, we tighten all the rules (there
must always be a header etc) and also update the runtime behavior.

> Patrick
> 
> [1]: https://thunk.org/tytso/blog/2009/03/12/delayed-allocation-and-the-zero-length-file-problem/

Thanks,
Jialuo
