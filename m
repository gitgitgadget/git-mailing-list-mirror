Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470FA30674E
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 22:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783721356; cv=none; b=l6zx6O4At6zzCBi9bU2Pxi0nxNzU7sCVuA0JLLxX2+RAV/HWGOXQgsjwQxfzjkHe2XG6jJWHlD8iS3w8rfCN34AZxSgBTIwuHmrI/NVQyHu+/4ECI0LNVbpudNEZxUQa4nj3REEH0GyGkwOp1WrgRUmlYU7/2RAQd6i1uFM7FhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783721356; c=relaxed/simple;
	bh=7XHBbDRhLShFD631Hy/I+fJc/GhoeWittKsRZAHCjKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nCCUK2GGpQfobYt9v8R5iFqom9rGMQLg6rvhmYviazUxSP+f9tQ7uYfYm/aeKCkBh4K93B4fN4hghxgffkHNd/Dk3UIf11812vFQTLWwLjx9tnfI8mqPOjAPiB/V+69M/Gw/KKMmBgbPDdKZV8JdlQgc/EEPR7sn4fQ+pyob1ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=P40uNKPO; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="P40uNKPO"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92e5c9211d2so107526585a.1
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 15:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1783721354; x=1784326154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SijVEUTeuvBHU1WrSjXhCosXg9PTdEQN+veaQBj7K3w=;
        b=P40uNKPO5Q5qZ/Utxj0I0uAYN35TZbkbhWW9yGOWQRNOFPGfZI2FxpisyJk/lpEKAn
         VHuDYxjvNGxv4TIuFaYlH7MGbzT6/MuVxTQHv3z/agIPK0cJHqGGX1Jjm5ztqmh6oTY7
         m9VsU0nXAwKxfg+FCeTFknamPhSd/oY5icxhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783721354; x=1784326154;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SijVEUTeuvBHU1WrSjXhCosXg9PTdEQN+veaQBj7K3w=;
        b=CcQnQYRAFqQnbx2wCTdXjrTU9r6ql0OZK5zOIfkeu3zkKRfRMNqiCshZKqteLu0biA
         UEqPQ0xsegH1ZBUqvGmczx1CtpvjwjllbfXh84yA2jqdEyGfH+FmL5d3fTU5zU1qYBT5
         Ni6XlIN9D91/vXkgUY4O+1tmW/irCJz/w1oYU8GckPZ+LLqbdm2zWwNrW39gWHek+oil
         BAwWB0FD4tuN9Xx6nEvHH7bKjCwB/PF0rRKV9GVGT5yyPm9mcgDw266KlhIcqeTyMUZg
         xm8bs+52C/oOCQFQK8egECrhDQwxYXo12feKeb2v1ThXADCRELkbLTsPUOzKbeqS1b+L
         tF6A==
X-Forwarded-Encrypted: i=1; AHgh+RqXdtUINWwYExOvhehUC3ETS7+FPqJeaV/FijN4sLT5EWsQzn6wfa2Jl8B6dUEeZNA/ZOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQY+5QlWYH28JAFdB3EVhBA44peSgo7EtYLI9z7Y3TqEkt9yFk
	BBBEVqtrHZQJP4RoVAGiic9Z7Cbd3dpkDTT1BhL3tkyA2cHrgVq7Ma0gzgECbA54w1E=
X-Gm-Gg: AfdE7cnfuecaQ4GLSrZvdU7aFchoZ2cVUIGjIUL0iGRtSFblSB+49kdLNIhNxOQUkxZ
	C0ACmHMF099kFZo1BXNHPqBcDMmqh4CtLCJ6QqZFwNA4uLuxWkmqz8atA1ZfRaWeHRHVvNLxspc
	2xYWkpuVEIuPpkMdyYzLnUmFL8YkwMilXU9Q900NviJTAHCYgv/MBFvCd1A7Esp0XTLee5jy6iP
	Tbqk32T7O1JEHCquqog1m2ytyWd74836d8G/BUanHwja4Dmvvtg0oLBBK9BuoQ73MkZoDZDXqn0
	fncjfEZ/pW8Bwo3/a2FPOGAwmIy3ai9MYx8rw1Yx8eEyAU6Ov+JWzcPXGwfuGLJTTQCEL0RBRnA
	q2LFwaSftVmWEgnv6HhjdshWMvFHC+s+PP1Px9lfH9g0C8RJ36Ccc5Hc+biOycQHyKFMEytjgtV
	JgGCLI6IpDTW5M2UFfh94ma/oR
X-Received: by 2002:a05:620a:1a08:b0:92e:e58e:ac1f with SMTP id af79cd13be357-92ef2b7cdbbmr105625885a.25.1783721354040;
        Fri, 10 Jul 2026 15:09:14 -0700 (PDT)
Received: from com-79390 ([209.249.37.133])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d30f38sm291378785a.34.2026.07.10.15.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 15:09:13 -0700 (PDT)
Date: Fri, 10 Jul 2026 15:09:10 -0700
From: Taylor Blau <ttaylorr@openai.com>
To: Kristofer Karlsson <krka@spotify.com>
Cc: Taylor Blau <me@ttaylorr.com>,
	Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 1/2] commit-graph: add trace2 instrumentation for
 generation DFS
Message-ID: <alFthqGQjsowvpEz@com-79390>
References: <pull.2170.git.1783418384.gitgitgadget@gmail.com>
 <b865c2bcff53a32637aac426dd2c6ef4a4c27077.1783418384.git.gitgitgadget@gmail.com>
 <ak0DUx5Y/5y1OINz@nand.local>
 <CAL71e4PuD9D8LRbP3mfxxeMrM+1q--3sCp6oJs=hezdasZUPMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL71e4PuD9D8LRbP3mfxxeMrM+1q--3sCp6oJs=hezdasZUPMw@mail.gmail.com>

On Tue, Jul 07, 2026 at 04:08:36PM +0200, Kristofer Karlsson wrote:
> > Instead of writing "# BUG ..." and then an incorrect assertion, I
> > would suggest that you write the assertion you expect:
> >
> >     test_trace2_data commit-graph generation-dfs-steps 1 <trace.txt
> >
> > , but mark the test as "test_expect_failure".
>
> I started with this actually and then changed my mind in order
> to demonstrate exactly how the counter changed, not just that it
> changed from failure to success. But I'd be happy to change this
> too if needed - it would effectively reduce the second commit to
> just the bugfix line and switching from test_expect_failure
> to test_expect_success.

Yeah, I think this would be ideal.

Thanks,
Taylor
