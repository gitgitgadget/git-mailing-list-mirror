Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ED221B9CD
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 19:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755977939; cv=none; b=G9PDugRekexj91VcdUoSl5HU1OpoUW6Fu245myWXP3LWgktRd0yduHlppRsHBlf/lUjioWcmvF2J0t3Y/FRMP1eOTbO83/yKl+i0X6Xm+zUGLatZhkntsSYRnEQFsfP7CvZxhf3lbjKCdvUl8eFzHWB7f574zerfjG/NwOmP6B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755977939; c=relaxed/simple;
	bh=f3geSHLQVNFneL5VN/QVwNuavkqbgjYFFgWyoU03jFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZeuPQsJFSxbbjMy9xjdCJuoW5X7QTWmrt20xPUl/VDgSBrMS4DqfNUF8mzaCsXjJsLJ0bW8MJ8f53e+HVa1NmKdvJQgZu2TayQJ/BNDRGA5e7N6Zyl/oHAcOKT4XxrLnvb1iUbzUIOhEJ9FpA91Zvn1BPRS/Mr7MXLgs7bpqEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIzT0lPx; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIzT0lPx"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so2834872b3a.0
        for <git@vger.kernel.org>; Sat, 23 Aug 2025 12:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755977937; x=1756582737; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uBZPMhDos5CVDN8LiWrO9HKGIkFH6C9IPD5QJwVFndI=;
        b=fIzT0lPxGyWu/HyKOQzctngFYVLaitGCAjkGMIHfkwnFVD4iWip7qUuxPXliu3ZeuS
         PQiocUTwVHe4Dr5O6Qw78kZMDQVaIoy+xM/E1mDdIDE1KURvqBSFnSPihoydfJSOAU03
         H5tEGApQP5zTMVhD+uRc9RczyS/iICjgGghc/pTzQEdONpGJPgYUgql2uwffIpMM5nbk
         GJflJ2vsrhT+htE9YKdF9zn1+PyGV1/k8O0cX6Xhp3Wd4hH4AJ+Kx7kV81ytbEr4aaHl
         tm2ThBWe6eCDHwBUR5buYsXZ0OX7RhmVfbScpwzdg6EvIxb+KPUeLBxhKjJfBofX1V2P
         1mHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755977937; x=1756582737;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uBZPMhDos5CVDN8LiWrO9HKGIkFH6C9IPD5QJwVFndI=;
        b=KTN8E0ZkMBiGjLbGAu5EqVmZrH6XzZA5jcg2Elpxg8wW1fjaX2xcdkP+g9QTc2tQaf
         g1TMlTw1YVnfDYIAnJIRHPsyAiiTk+Y3/vOLbCeenO6vEbGXyWOpB+kicrjN7DJnlVkA
         wQKzbTWsYppR/jyCd5m4Iz28M3F79yeoS968BGYdAiQpR7zzGVHh7WTroXatMuGVbpMq
         BZKhRrWTf2qGp0IFV6MC54eVv3EfNGZqGJrljFtC8ZzIHQV+gUQb/q7FT+uQTWeoUv4o
         PYb070zVOlmtNIKXsfi2T5amnJsAnGJxIjRdjGUlxNW/KaVQmXxDAlqo2a5BAkTLOE3b
         yEDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZxHXadBntOMd8+v44xmqT89/Fq4tVXz3jqUMpAJ394DHURnerES3mvjwxlppUPaaLKEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNVci8n6qEjuPIrPLfkQD71HSo5QzHXcX/4pbW8+Gew9zolHbp
	V6miDTY5NdAtH3PBvGeWWPbbzm3LaT6L/MtaDWWSywB4lhCfPEQiLUrm
X-Gm-Gg: ASbGncv8+NKr74o6I5mQ+mMnjL0V30NAexUS+Jgb2sGWfL4gHhnEeHQBlmQMoYbhnV9
	PWk1/Krw8RbsnVyTJwCvk8i8z6wpGnbhJatoF1bl42I186Ly1KxNeLZMWy1sMuSwVgGbxme59hm
	+1DGSQeqtaqDRUVkjpRh67BQEcWRx2wWr+LLzZOw9swZFYfgm9GVcd/wtoO+InSSipt6t+1crIx
	wL/AnnObG7HlsMk9JQnfum5z+mpLJqC75V0MSCw3VFuhO3IYZkIun+wuKiQxyeh2Jy8Zpz2HmP4
	yhymzyMxJCOEwTjugClLypP4kOjMaSw1KtUPVsgL5chvKgeoXtuwzmDUrr2sEgNlbRV1yIC2oMp
	Y1R4EQ4QcHQz7ES7euIyFlA31IebpKFMNvMl59ZS8Pl5JDDK9+7IzuADw+u6ZEXUIYNNlYpjfKA
	==
X-Google-Smtp-Source: AGHT+IErho1QzJPvfcNlipOlADIAj/lhuA29V2e4eOy+j+78cxlUTwQHSDzzc4klceIuRXq+mAae6g==
X-Received: by 2002:a05:6a20:a122:b0:23d:4777:49ca with SMTP id adf61e73a8af0-24340db08c3mr10177101637.34.1755977937324;
        Sat, 23 Aug 2025 12:38:57 -0700 (PDT)
Received: from Reys-MacBook-Air.local (c-73-70-17-6.hsd1.ca.comcast.net. [73.70.17.6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7703ffb9d3bsm3153832b3a.23.2025.08.23.12.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 12:38:56 -0700 (PDT)
Date: Sat, 23 Aug 2025 12:38:55 -0700
From: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>, 
	Nicolas Pitre <nico@fluxnic.net>, 
	Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/2] progress: replace setitimer() with alarm()
Message-ID: <ubouc4oefkouvoikedo2lcui3wgjgjovbilxnf67g76gmrp75e@ujkfg5asyy76>
References: <pull.1960.git.1755955377.gitgitgadget@gmail.com>
 <86bf04c7-6315-46ef-8297-42efc3ed322d@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86bf04c7-6315-46ef-8297-42efc3ed322d@kdbg.org>

On Sat, Aug 23, 2025 at 06:24:57PM -0800, Johannes Sixt wrote:
> Am 23.08.25 um 15:22 schrieb Carlo Marcelo Arenas Belón via GitGitGadget:
> > The first patch does the minimum changes required to swap the underlying
> > function, but introduce a race condition that is addressed in the second
> > patch.
> > 
> > A third patch that does further changes to the Windows compatibility layer
> > was punted.
> > 
> > Carlo Marcelo Arenas Belón (2): progress: replace setitimer() with alarm()
> > progress: add a shutting down state to the SIGALRM handler
> > 
> After having looked at the progress code for a bit, see this:
> 
> We use SIGALRM to raise a flag that tells the progress code to act in
> some way. The progress code does not act asynchronously, but only when
> there is an opportunity to look at the flag, i.e., it acts synchronously
> in response to a third party (SIGALRM) that told it that it's time to
> act.
> 
> But we can change the progress code to do the time keeping itself.
> Instead of looking whether a flag was raised, we can let it look at the
> wall clock and check whether an interval has elapsed.

This is an even better approach indeed, and will lead to an even nicer
cleanup in the Windows emulation code.

> A prototype implementation looks like the patch below. It works quite
> well for `git clone` on Linux. I have even lowered the interval to 1/8th
> of a second to get more frequent updates. After a change like this, we
> can remove all the creepy SIGALRM/alarm/setitimer stuff.

Would you mind cleaning it up and making it a patch I could rebase on?, or
would you rather finish it off, since you also know the Windows parts better?

Carlo
