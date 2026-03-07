Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D5619AD8B
	for <git@vger.kernel.org>; Sat,  7 Mar 2026 14:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772895491; cv=none; b=QPhSp572NvD9/6nGTmGFYo7ohZUu6rjcrvGKSCaKuYMD3hiTbKDwfiJ9GTBDeUaDa3YQIoCgzWb6ZM+Sp9m6Wdf1+cc50DkkCvSExCuwjmHuOtXurFlyRMCG/fUEyih428cT20t8odXEMX2JO4lkB6VUzgFZdDQ4JxL/ThhXOSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772895491; c=relaxed/simple;
	bh=8gmWWGCBKaNgsAPhQ4+xVCbhs0Y8AeUGyS3j2G1qHjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PmVHovHEXkSa+nWabyh868MH8LK4HfMyrIoh6z03TBz8ekhnu3z834EoZJJwUu1Nxv8N27xDRBZ1LJ7RID6EDA5DSqpaN5/HfkGJupB5attNOljjEhfWvj6oYRiNKgEqrRzB4H54Nk1B5x6d8sgKaWpjwRDoA42BTUOV63tWEK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NstyU4EI; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NstyU4EI"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4806f3fc50bso110669595e9.0
        for <git@vger.kernel.org>; Sat, 07 Mar 2026 06:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772895488; x=1773500288; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JPo4aemH4rdUBnOn+yZgRxodphFblAbQnhhBzE/YENU=;
        b=NstyU4EIcIRx525khMOuyT5pE76iWiPtNVY1we1GpGn90t3Obq9qb+RULhjUE64Enh
         djt81y7t/MS8ho91IV8HY5kx9cQeCipd5hZYO3gX7vjFzUquMlqcUymUT1L66dxrTq0A
         ZFivAFdUM6XQafm1KqPhvQ/khmFqOlmggazcU6g+Ly1PqJEWlr+r8xZk/FmDy/WRKUuu
         4FJ7DXShhKpgRRwFVokRUpLJrydyAj3Y4kKqG8/fd4Jo9NirRtZZRpFtRCplsANAGs/4
         fglWYi5z4J9gQQtyf9kGhDZYSSxXDKTP1iniEc5mI1vRKn8xoCUyNnfbGGZ83bprwcdF
         WZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772895488; x=1773500288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JPo4aemH4rdUBnOn+yZgRxodphFblAbQnhhBzE/YENU=;
        b=tp61Nf2OUVIHOko/S5dHpiDUYEC1EzeE34zqj8HsO/vj4FKbooHzqALoW2C8/6xR4O
         KPS8TP0SXWIMbUuzf/qoUdLK3IEoLNVE5zO2ppdgpLFXd9KPDWTSgE6eZJD8zmi9Z0uH
         Oy1EpD/7JHEuqUoh6vCX1wdxMmOuBZ6XXpj0eBH18L2dDsq+rGgYx8oqPhzYt8RfGb7U
         Y2pZUB0/iqWKtGu/JErJFhaoiDlN+ki9j7huHNzUcYoO1UuMb+U/AUaQRc6zI0d25a2D
         fUFN+X0Hma8V2e7Wg+22227pEH5TmhxavNEvvmwrn5NIBgPeOnhZso1jQ7ou1JMnsZxg
         majA==
X-Gm-Message-State: AOJu0YzZSrdhTG86LiQLFeiUgWzOKA1O7nTinDpobHAQVkS0RcbuIsJc
	elB3y3TmykWuqvpktpGD9nPvBK/kyn5t7TdqY497oiJ1NSTWPvNU13cwyQMaMg==
X-Gm-Gg: ATEYQzwerOBkO7pW3ng/7dU5zwogCCWbqwGJp9Htj+xIC70axiQV0p3cC1/5EdfFYr0
	zCkqiAb8OQFsPR099E6UON5Ku9O/+IeyiUIwiOtjVRrVPXHypp5ZC75yBrfqm/WuLl6CuCLi4h4
	x/ncLqheiShshHC0QuwL/MsPW3BZYAGOGihP1r7nR/jD33fZcJ6KFtbXoSNLs3n0esWib7UlU+S
	x8R6CEFGe8le1GB7NLFPqDgkuicAcc78fcy8NfDRqipkl1ApUfQ4IqNtnDyRdC6Dz1B7P9+i0Lh
	xGmqopYlKpwCP/DXC9uCz/E31XE1I85PmrknZujjVMdgUhTFFVvrGadu2moB3rSFLdZOCOPOndm
	c/VXRcHYEysKOSi9Kc/TLkdvnt8J9ba8ndwtMIgdUwh/Ud8Z4fK8U2U0PhRSmlbUZWX8au6EpEk
	1FJx8cgDhfr/ntzI5dCUQbdUq/NLGSZ6MASe0=
X-Received: by 2002:a05:600c:1382:b0:485:3423:727d with SMTP id 5b1f17b1804b1-48534237536mr6591765e9.26.1772895487744;
        Sat, 07 Mar 2026 06:58:07 -0800 (PST)
Received: from lorenzo-VM ([84.33.163.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851fb3668csm319806185e9.13.2026.03.07.06.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 06:58:07 -0800 (PST)
Date: Sat, 7 Mar 2026 15:58:05 +0100
From: Lorenzo Pegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSoC] extensions.partialClone and promisor remote fetch order
Message-ID: <aaw8_U0hOEag4WDO@lorenzo-VM>
References: <aavvwfZllMWUwIl3@lorenzo-VM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aavvwfZllMWUwIl3@lorenzo-VM>

On Sat, Mar 07, 2026 at 10:28:33AM +0100, Lorenzo Pegorari wrote:
> Hi everyone. In the past weeks I deeply studied the documentation
> regarding the GSoC'26 idea "Implement promisor remote fetch ordering". I
> am preparing a proposal that is as detailed as possible, and that tries
> to answer to as many questions as possible. I am also experimenting a
> lot with multiple promisor remotes configurations, and creating some
> examples that I will showcase in my proposal.
> 
> 
> I have a question regarding the interaction between the config
> "extensions.partialClone" and a possible fetch ordering mechanism:
>  * from my understanding, and from my personal tests, it looks like
>    "extensions.partialClone" is not essential when working with multiple
>    promisor remotes. Having these promisor remotes setted up with
>    "remote.<name>.promisor" and "remote.<name>.partialCloneFilter" seems
>    sufficient. In this case, the promisor remotes will be tried one
>    after the other, in the order in which they appear in the config.
>  * if "extensions.partialClone" is present, then the promisor remote
>    configured using the "extensions.partialClone" config var will be the
>    last one tried when fetching an object.
> 
> 1. is what I explained correct?
> 2. when the fetch ordering mechanism will be added, this config var will
>    not be useful anymore. How should it be handled? It probably can't
>    just be removed, so the fetch ordering mechanism should be flexible
>    enough to handle a situation where "extensions.partialClone" is
>    present, correct?
> 
> 
> Thanks,
> Lorenzo

Also, I see that "extensions.partialClone" is already necessary "to
prevent older versions of git from failing mid-operation because of
missing objects that they cannot handle".

This is one of the last issues that I still have to iron out before I
can send a satisfactory proposal draft.

[1]: https://git-scm.com/docs/git-config#Documentation/git-config.txt-partialClone
[2]: https://git-scm.com/docs/git-config#Documentation/git-config.txt-partialClone
