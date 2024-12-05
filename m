Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9099921323B
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 20:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733429511; cv=none; b=N40vpkJLUSkvfmoiS4xPyq10giqoCIZuUIhObHF9gQ18VlztJG2XbEeAswb2+C6pBLM/7lviSMMb3dNL/dIEV/ubtnof+JRVs78fz9EKTzTdh38dJEjvdoiCAVJXdzlB0Pmh6TS79rYSeTBMdEQevyU4z85UYkIGEnrKzbtCrAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733429511; c=relaxed/simple;
	bh=65EwtbhSKYk1XpTb1yd062r1U5mew9aemlcGZ9TmKtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1uXHM/hmSkMa3rtWrNayJwE5097DR+r9wuamGPSpB0PI/VQMPZifuSIhXAQCHrl47Nhyn5zUYSPeG1QV2r/dQOvCh8scS0FDwucMIlTgb6j3JoFCLqtgnxTY1lgBY/uf8bd+HCg8RKlgyqmAliCRfb+aNmWwnNWoCz1aHrVpbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bhly5AYR; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bhly5AYR"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2154dc36907so33355ad.0
        for <git@vger.kernel.org>; Thu, 05 Dec 2024 12:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733429509; x=1734034309; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Lta3qwAp1PnphLf65D3T4dcmmFiyeGFfIN1SX2VNqo=;
        b=bhly5AYRBL1dua6UAvQZnZ2T4YZsyPvSawzTQwuyI1IYmvXWatgked+R+y7IXoAwGE
         f8i1zd6XC/AMRlqmMLSQlxY0/s2rGIxCcR5out/pQDy/0//aGNFL7y5p4ma/z5SvuPt5
         mqYGvJu1YnywFeUEs4DdjyBYJVJPaUJzaQt8tefPFMyCxPluhy+5ay9t7DK7Gf9OWCyI
         L7DKKRkklmdvdg78Ls5EkI6YCiQD9f8xwQ88sJOCFXvMBJWWcSdIdMbUxyhNVhcbRkSa
         yfLuqag+A40os17OrEmAuZXidtmeuYHfffm5lPWdWVivMKyOteHxOkytkGbIK31g2WVf
         dt9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733429509; x=1734034309;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Lta3qwAp1PnphLf65D3T4dcmmFiyeGFfIN1SX2VNqo=;
        b=Gwm5r/KcRx3Be8dTNDfOGMfBQDeqFJjZmRKCIVy9opZ0WEFq/PwO4nw1Vdy3guv3wR
         3iPzZePRS+9Ue4OZe7+FyM6HG9fjtmLaQTUa6zO9n8+j7Md7bx9fr5JwF2P3I7U5FTBO
         tjP3RSsKao4pgo4KTCq1buBAj1bFC4NC1Q6Aolefd/O6MTVrRxjIZXc8wYC5PKn/KuHc
         SNQRU2o3PrZuNxmmU7bRg05en64xFeZCaKqmAntwTebRgWDPEvu4foTcU0TKSApvpNSf
         OUEwFG3Gvoeyx1bYweQg3OdP47pPNefnGlLJF1N0LWcGfB88WjwjRQwRaoXSj8ZwlTEx
         R+7w==
X-Gm-Message-State: AOJu0YyHXQsqGq1rGdO7OTXyHsjiyUhCG/hN13FamGZaxh8WoBueo3Sh
	ocJM4djLoifmXd0HWg+eR9hxUIiMNcVyrC1x4zQxttL/nJEvAbg/yYeFxGmi0A==
X-Gm-Gg: ASbGncvoel3hEe9brevrjDebE4wPGG8aKQ8i8eAwvVwFc4fJjsi7+dfXfEYaA6QpEEj
	0Gkwn5qoXnWxnzYTCEneVBjQVxDb9KyBMebovWMy9ly3rGBFtlJIHjogYoeChjiqfhGXQNwwEqc
	4eTvr4gBPpkLe6fNwBPMiS9qr9/J0X1WAVRcAs6IhyBuPntlPcmZ4w7VgpdSm3ufPsDvv9vwpzN
	BoQU8MfBGSSAFlDaJC4Gzk9QZ2uxjYjX2S2q/eYWj1yv20V
X-Google-Smtp-Source: AGHT+IHZuI0co/vy+rdLoyqiRoD14b7ZQuQegkOMUl8dW38WulbEnlIgkMlsFT8iN/hKe3xPNbgHQg==
X-Received: by 2002:a17:903:2382:b0:215:a7f6:2c19 with SMTP id d9443c01a7336-216138a9f75mr302565ad.9.1733429507057;
        Thu, 05 Dec 2024 12:11:47 -0800 (PST)
Received: from google.com ([2620:15c:2d3:204:80c2:988f:e15c:5983])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef2701d9a2sm3694757a91.28.2024.12.05.12.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 12:11:46 -0800 (PST)
Date: Thu, 5 Dec 2024 12:11:41 -0800
From: Josh Steadmon <steadmon@google.com>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk, 
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Junio C Hamano <gitster@pobox.com>, karthik.188@gmail.com, Taylor Blau <me@ttaylorr.com>, 
	Patrick Steinhardt <ps@pks.im>, jonathantanmy@google.com
Subject: Re: [PATCH v15 09/10] fetch: set remote/HEAD if it does not exist
Message-ID: <hpaekjhdpcovhdptdntdligp5jcdp7mygh5brnggu7itf5grzp@vl4l7uwnb3n7>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Bence Ferdinandy <bence@ferdinandy.com>, git@vger.kernel.org, phillip.wood@dunelm.org.uk, 
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Junio C Hamano <gitster@pobox.com>, karthik.188@gmail.com, Taylor Blau <me@ttaylorr.com>, 
	Patrick Steinhardt <ps@pks.im>, jonathantanmy@google.com
References: <20241121225757.3877852-1-bence@ferdinandy.com>
 <20241122123138.66960-1-bence@ferdinandy.com>
 <20241122123138.66960-10-bence@ferdinandy.com>
 <wmu5ld4xsfjz2tpp54jmxqroma423t5nn2jh3q5gq2wswr6fkm@vrlhigyuxfzu>
 <444kgiknevb3kwtypjjc2glryaav27t5fafgyzqq5257w7o4pf@4fngcyfmvfcp>
 <D641F472LOV5.223NEPZXKIL4Q@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D641F472LOV5.223NEPZXKIL4Q@ferdinandy.com>

On 2024.12.05 21:09, Bence Ferdinandy wrote:
> 
> On Thu Dec 05, 2024 at 20:50, Josh Steadmon <steadmon@google.com> wrote:
> > On 2024.12.05 10:58, Josh Steadmon wrote:
> >> On 2024.11.22 13:28, Bence Ferdinandy wrote:
> >> > When cloning a repository remote/HEAD is created, but when the user
> >> > creates a repository with git init, and later adds a remote, remote/HEAD
> >> > is only created if the user explicitly runs a variant of "remote
> >> > set-head". Attempt to set remote/HEAD during fetch, if the user does not
> >> > have it already set. Silently ignore any errors.
> >> > 
> >> > Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
> >> 
> >> At $DAYJOB, we noticed that this breaks `git fetch --tags`, although I
> >> haven't had a chance to figure out what causes the error just yet.
> >> 
> >> I was able to bisect down to this commit using Jonathan Tan's
> >> reproduction script:
> >> 
> >> rm -rf test_tag_1 test_tag_2
> >> GIT=~/git/bin-wrappers/git
> >> mkdir test_tag_1 && cd test_tag_1
> >> REMOTE=$(pwd)
> >> $GIT init .
> >> touch foo.txt
> >> $GIT add foo.txt
> >> $GIT commit foo.txt -m "commit one"
> >> $GIT tag foo
> >> cd ..
> >> mkdir test_tag_2 && cd test_tag_2
> >> $GIT init .
> >> echo fetch --tags
> >> $GIT fetch --tags "file://$REMOTE"
> >> echo regular fetch
> >> $GIT fetch "file://$REMOTE" 'refs/tags/*:refs/tags/*'
> >> $GIT --version
> >> 
> >> 
> >> Prior to this change, the first `$GIT fetch --tags "file://$REMOTE"`
> >> fetches the `foo` tag; with this change, it does not.
> >
> >
> > FWIW, moving this:
> >
> > @@ -1643,6 +1703,8 @@ static int do_fetch(struct transport *transport,
> >                                     "refs/tags/");
> >         }
> >
> > +       strvec_push(&transport_ls_refs_options.ref_prefixes, "HEAD");
> > +
> >
> > to just above the prior `if` block fixes our issue and doesn't break any
> > tests. However, I'm not sure yet why the order of ref_prefixes should
> > matter here.
> 
> Thanks for looking into this! I think the issue is with 
> 
>  $GIT fetch --tags "file://$REMOTE"
> 
> instead of adding a proper remote. Tbh, I've never seen the above syntax before, so first I just ran your script, which reproduced the issue for me, but then I modified it to use a proper remote which works as expected:
> 
> rm -rf test_tag_1 test_tag_2
> GIT=~/git/bin-wrappers/git
> mkdir test_tag_1 && cd test_tag_1
> REMOTE=$(pwd)
> $GIT init .
> touch foo.txt
> $GIT add foo.txt
> $GIT commit foo.txt -m "commit one"
> $GIT tag foo
> cd ..
> mkdir test_tag_2 && cd test_tag_2
> $GIT init .
> $GIT remote add origin $REMOTE
> echo fetch --tags
> $GIT fetch origin --tags 
> echo regular fetch
> $GIT fetch origin 'refs/tags/*:refs/tags/*'
> $GIT --version
> 
> So I'm assuming this is why also the tests never caught this, since probably
> all of them are using `git remote add`.
> 

Yeah, I think the issue is that we check the `--tags` flag first, but
only add the ref_prefixes entry if it's not empty already. Then after
that we unconditionally add HEAD. So that's why moving your strvec_push
earlier fixes it. I'll send a fix + test patch in just a minute.
