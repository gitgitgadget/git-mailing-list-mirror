Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4A72F3651
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 22:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750890299; cv=none; b=iwiv6cDBh2BwicVYz3keCaNaZJ+dwB1Oup8PuCPRShdAD1fe1xi1JgDBJ3487p+ogvvujsHa324gXc35XlDzDnFcyDKmil50cCFC4IF7uaE341A4l5YFDJ9CUW0GxV1193tHERHqSON5Ya4Im16SjP7jVtxkjofNRbpSsQianpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750890299; c=relaxed/simple;
	bh=vSGxLt9goB+EGSnt55k5/t82Q5H5UGHQzd0rVZcIdOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D1CeUgfBEBxKCuOVD5xrqAWa0xikpJSh4/7jHhu3C/q/xxoxd7zuwq5yiolyLUySPkdJaYvH0JY4YQ3xwxKUyUUNeB4/Ay3C9boza7psP4sknQ8KyW+db2loJIiOzZEbMO0kQqAkM6+7gm4pONzfD92bTnSOlSOSLU1J33QJsVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZroiAn1; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZroiAn1"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2363e973db1so13602445ad.0
        for <git@vger.kernel.org>; Wed, 25 Jun 2025 15:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750890298; x=1751495098; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gV2o++rm3yrq9MnkHIrivDGGSggGYIzTb0tet0faCj0=;
        b=VZroiAn1v4tH/KyamA4dHncOfpMXN77g6uVheLBQgRSm3a+NMX5hCS8clbpfmYwgQt
         HThXQz9xATYHp3ubSl9/5WHftNBbIPeHx8ZUODFBGIOYPo+pnOvraziayo0BtoAI/054
         HG+ejG7xOQ9vhRxjTQr3mXNmgZFPz4ENoBrsxRQLayL7YOTRjdgQvHW7Dab/DlJBHB7x
         7ptK4/7JWmSxfkTDc6VftMG3sG/7DcFQt4hfE7LSO7+J68k8dnoIWh+e3zvrs2W+CpRt
         axakGPZV7YQqIzuj2xuU9nQb1iFFWgqQO6R8h1bhTS6RY79lmPgaTCurleIS+DBLz+1Y
         IWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750890298; x=1751495098;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gV2o++rm3yrq9MnkHIrivDGGSggGYIzTb0tet0faCj0=;
        b=h3C7pp0bvvjK53rBr8MpF+r6RMnOgGW2sejajL92O+0wAjNonrd/nl94n45cRVLMFP
         FKxvhU/K5cegn9M4JI6egXA+A3ItWJ4PufAZphhSxCD5eO93G+ANLoDQHz4w7ac+OTmG
         H86TC+rinuzWDXjVJOFDWzOchxAqqB6HxQVi6+xKGLuoKBP71btlyq7z282gVCHiUoPj
         anXbJdICayJCPn93xxVNAz21PZxIBuqAn0UVPdMRwmBbKj/w1ngy6cuKJmvenYKD6YTZ
         jTHiJiR+fEQhcjrml16T+pDmdpgLsrCVP4Vjd2TzqQvRe+GL+RNjIyx6gse2aSTm0f6B
         BU6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXrTYncgNkd6qPSB13KMWr/J1kKc29FLn5DN2phVb6cNe/AZyYYVZFDHsrcCic78nOBfBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrZe3ZJkC9PuJPtX//TRs7FveakHy/n0PXkI/WIpD0i0SvJPYS
	3ARbYYgxJ6DdBaAQ94nhXu5vNXzph5lDRAzQt+t9iYSk0JYsA15f6EzB
X-Gm-Gg: ASbGnctZQ4hRDlIIzOM9J3d0jdD3RpfehTAN15yZAzhOZ/WRm5/hoPll7QodcX71xrG
	ObxjG35Zp+6N1VkZRTGsZNP/qu1jRsSLwjU/1m+59FG9iLVsNOf489qsb91qCeERttoWShFWJwq
	Ovz/n7ux0/JPcH1FdZ/4TzxCA20KbXtl3k/887q2CFxRNqErAnrGlSnTPmuemwizqgkr+GwSbWb
	LfaolDHXyNIPhhEQ5R2qoTp6rvOE6EcTjzsWJ3IMEDuw/H1vVa4QdSTH9iJtfho6UtQdfeeSujk
	+yjguRoYBAeEHr/VroKlYM9wY9VrHjd6Qz5bJGrMCeH6H1cRCHOInLsQUOXVkC0FErJjijhjEuI
	do2bKrxGu30kFPBf34+DOv9k=
X-Google-Smtp-Source: AGHT+IFGjverihbI6JW50dWiaeekQAj20d0ZqllNF8wp83STE3zgBjFwu9s36H70J7mjtbZmV2ejbw==
X-Received: by 2002:a17:902:f54a:b0:235:e1e4:edb0 with SMTP id d9443c01a7336-2390a54b7dfmr17989805ad.22.1750890297795;
        Wed, 25 Jun 2025 15:24:57 -0700 (PDT)
Received: from Carlos-MacBook-Pro-2.local ([2601:640:8e80:3680:a1d3:1456:244b:d366])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d864a9d2sm140243775ad.149.2025.06.25.15.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 15:24:57 -0700 (PDT)
Date: Wed, 25 Jun 2025 15:24:55 -0700
From: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= via GitGitGadget <gitgitgadget@gmail.com>, 
	git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 1/3] compat/posix.h: track SA_RESTART fallback
Message-ID: <4oh4eatsp4wo4ur6rluy6ickfy5jfpuarg435vplrqzvk3eaiz@jbtnnwqnz2yi>
References: <pull.2002.git.git.1750774122.gitgitgadget@gmail.com>
 <pull.2002.v2.git.git.1750836928.gitgitgadget@gmail.com>
 <e82b7425bbc2540fa5ef3fd4584e6f902485d064.1750836928.git.gitgitgadget@gmail.com>
 <xmqq4iw3yfd8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq4iw3yfd8.fsf@gitster.g>

On Wed, Jun 25, 2025 at 09:07:15AM -0800, Junio C Hamano wrote:
> "Carlo Marcelo Arenas Belón via GitGitGadget"
> <gitgitgadget@gmail.com> writes:
> 
> > +# Define USE_NON_POSIX_SIGNAL if don't have support for SA_RESTART or
> > +# prefer using ANSI C signal() over POSIX sigaction()
> > +
> > +AC_CACHE_CHECK([whether SA_RESTART is supported], [ac_cv_siginterrupt], [
> > +	AC_COMPILE_IFELSE(
> > +		[AC_LANG_PROGRAM([#include <signal.h>], [[
> > +		#ifdef SA_RESTART
> > +		#endif
> > +		siginterrupt(SIGCHLD, 1)
> 
> This is curious.  What is this #ifdef/#endif doing that does not
> have anything in it?

It checks that `SA_RESTART` is defined in `signal.h`, which should
fail at least in QNX, NonStop and Windows.

Carlo
