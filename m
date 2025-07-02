Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB29224B01
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 19:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751485142; cv=none; b=PbcH0H8Crnwt7orc/j6eA+oQ1gk3xemzqW/lX/GoYrLb4j6RsGLQNzORTQJquBxO4sdSDWa0DVw7mO2maDV/r6fNjLwLUO3Wfqblb+0C42tZgLcJTyjfu/+Z0mfLpDmKIapfA5kfqbAjlghs8iCz54fO2yDKGZTG9UT4Zw0S7UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751485142; c=relaxed/simple;
	bh=Dd4bhJA2uzRwyi+XUiHeYqp05OxxzK0MgVKeRc+DjW8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=EZCJeEgZAoaPze1NlC+njhBKZuzjAYi3sh4nGntLmax7Yl1ZV37gfiCg9alVviCEI3vIHhAy8OSx1s9grWVbgfnpdTSqkBdHscZf1NheXCPOT99FpxrDbw8M0KVLCZ4jyQrwIlyNjkxO8TC8XbG8NHhxTOWbfcnY5OFxEH44wvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MoVX9HhR; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MoVX9HhR"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7d45f5fde50so290678385a.2
        for <git@vger.kernel.org>; Wed, 02 Jul 2025 12:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751485139; x=1752089939; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EvVzYjCXljRuh5IXuXB83NrN94fTHylqw2JiA8BYV8I=;
        b=MoVX9HhR0sfgH44mc8Kivf6CcfCorY75HEKIzwo5ltf3eSe1ivMPhWUvizEfXjeGu9
         uU96XTLBHGsirAjVMUOKhHqJiqKfOBQsUysoYtTaP6LX0M3a8E/yFmQdh2CKAPEOR0zG
         tTgxb//bJ6me9IGKdq1pJVXkOYXv+rFpAuY3W6LvPEjUVzh8s8XL/jgx+3sPWvmcXWC4
         owHO6mYvTloiNgF1tAWq49cxrg0WbI+wkz3ZRCBH4UqPuXZ/Qia+4m9adlE5astNo6w3
         BsvvJxCMt2DV6cHlXEAEDjWnrecAd/7UBmGElAd+HPUBsaFiYU1zBQVxN0TLEwRkxIMo
         ECcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751485139; x=1752089939;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EvVzYjCXljRuh5IXuXB83NrN94fTHylqw2JiA8BYV8I=;
        b=j/D7BYNZWEhbs+AjbUv5UtdGiAUxhqQrSsm96ZIA65dSy145W+wloNkHCoBzt2T/Uz
         W2IZMHvu1393/jbfqsq6h3WTWzPRtiv1WBtfEpvZXaS4LNa4l6UdH2vVl0Uun4qz40Ey
         U6vTGnM+tqNGDSziM3uDjnr2iE5ofOnbRMrbBiGOQ9CPLK60WsRvcd7DpJQxzGbAZ6Bo
         qoGRMW7EOkvmNfHFG13CxRq7WmaDz2Ul5nxoGPIU7QfveSowGmnFET1CN+Dm+iDomyW0
         baTjU/XncWTX6+MhEj2OkGx7Dbdzd8i71rrsjbfYpRVGF5OGkVBlwI5HURYLzgQRbQ6q
         nLGw==
X-Gm-Message-State: AOJu0YxHZ6xoQTFIzYs0+HhvxuNPYBwUq1CwuniswJ+hC+TwaTS74qLX
	GMcb85582/Zr8AraxSIYKVg5ti/o4W4NKxziPNnzO5p9xajJfVSJZz91
X-Gm-Gg: ASbGncuKL9X4eo9W4iZWrbdi4hpVaCBJZeU8zSf1tKbf89JEtKT7ikn7cA2fuxyHnzx
	CqhqeYjpddj2Boc0+24lyT2bhKVswS10bA9cW4O5oKMJ3CrpfdVlvVD8VjIYh8KOmK5cnydSGaH
	cJB80IPc+Po6cPeARAgsXnXeBS5mMSaLo7TcwxXuzTZ9sHGTo5+IuLaYh3cO7TYzhsorQthuRhj
	uqPze2qbkogzyTTjJgTGiyYGG/Yh0iTn4JoVdhhcrdZGiv+ifc5j1dwzDBE2yZgh8/XhnxpKqXO
	k5TNKo1xFdH+TmtPcfgM+EKa8pYTp347S+QtxWtjJ724+siUUdL0ZePvqa063HctRLr1wvwDH5Y
	APYl7v7HXUA==
X-Google-Smtp-Source: AGHT+IFsg9zaRwUS76omZ+voV9ebYteLMnItFJxkf7TxtPuqtzrQMOXtvBiCijSLubdN4y3MMNjobg==
X-Received: by 2002:a05:620a:2684:b0:7d4:5db0:5b95 with SMTP id af79cd13be357-7d5c47643bamr535143485a.58.1751485139283;
        Wed, 02 Jul 2025 12:38:59 -0700 (PDT)
Received: from smtpclient.apple ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d44318800bsm985457485a.52.2025.07.02.12.38.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jul 2025 12:38:59 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: Feature Request git snap, Lightweight Commit Workflow for
 Iterative Development
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <CAPGv+4ZT774b-LGMFpyv3cJYUrpWPMpkCGn25AfwD7MHskbV=g@mail.gmail.com>
Date: Wed, 2 Jul 2025 16:38:44 -0300
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <5662B201-C668-4D40-99BC-4C499813730A@gmail.com>
References: <CAPGv+4ZT774b-LGMFpyv3cJYUrpWPMpkCGn25AfwD7MHskbV=g@mail.gmail.com>
To: Suraj Bhadrike <surajbh2233@gmail.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)


> Hi Git contributors,

Hi!

> The rise of AI assistants and agentic AI workflows has changed the
> pace and nature of coding. A developer might cycle through dozens of
> variations of a function or component in a short period while
> collaborating with an AI.

The use case for this features looks very clear to me!

> The current Git workflow presents friction in this type of workflow.

However, I still don't see that friction.

Even though it's desirable to have a healthy commit history, when we
are developing it's ok to create temporary and dirty commits and fixing
them later.

Looking specifically to each of the problem in the "problems" section:

1. Commit Overhead: I can't see what's the difference between the WIP
commits and the proposed snaps, which seems to be commits with empty
messages (that can be created with `git commit -m ''
--allow-empty-message`);

2. Indeed, that's not the purpose of stash;

3. Manual rebasing: another option without rebasing + squashing is: 

```
git reset <last useful commit>
git add -A
git commit -m "useful commit message"
```

and thinking from the user perspective, currently we need to learn
`git rebase -i`. Creating another command would make us learn the
new command and its use cases while we would still need to learn
`rebase -i` for the other use cases.

Looking to the features itself, the only one that looks new to me
is the numbering from the oldest to the newest snap/commit. We can
still do that using HEAD~<n> but it counts from the newest commit
to the oldest. We also can't (as far as I remember) list the commits
using the ~/^ syntax.
