Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F8A3064B5
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 14:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783433330; cv=pass; b=pQIm1SY8TTCIkmpntSStAYpgTZHRMkHl7VuB76Am4fTUFqz+WNCD+ism/V7+PhXzt+q9cqt+I5BijtamuFXWWxSEAfIHREZFNSkMv/z86efUfIKWhGiTSi5nEKP1crMgcnw5hnhr9023+07oI/pEzjoM0rMebSG44+sCunIfO1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783433330; c=relaxed/simple;
	bh=390p7bJ+sQVRic7xSAK+kBgs1wuA4zOAEtffN1HpFqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fNqM+H3jKSGeVZTcKahYVe0FyctOQ0p4EvgXBy/dHfnadvMO+YcMUqoe3KbPbmnqkPFjovhypNnubMHHj6+FB2I8hbb1lzaq1WIYdMl0w213OB//L4lMPe4Sqth7aOj/pCe7NdzL8D+StV5v6LtU+gy4W+w5V4edX9bwoCbULu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=SWFRlglK; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="SWFRlglK"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-664b05d408bso3476403d50.1
        for <git@vger.kernel.org>; Tue, 07 Jul 2026 07:08:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783433328; cv=none;
        d=google.com; s=arc-20260327;
        b=eZwF2vzWiMeyC8tU3QtZUijo2/hfVZoDD+yKUybM/9DLcr9nJPO+fJhUun2Bl1nctT
         fIcjCv9pCNSajr9AlU2PLE/sn5fRF71iIWJczj5TwSKQxFMRVujLIcVQEmAJgDGRAGFI
         Z0vatU29rLkJay9gBih5ldYdMFBY6V9nMIoJA91w4oBY4xbbhaD6s0ZbXl4GaJ5kN9dw
         l55E8dvu/NjvG/wjz3z8FrEZPTGwQXlNCkPiajnrPjcMYcVSUnduQ/d/jcDQVbB3edOr
         YAd7Ro+4aMZVjqtqlIU8ZfYNDfMx2OLauey6YoBrceLweFmb6XYAesAXPZUGuEM6GeqW
         4Brg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wU5hoHcS0fjFW/J132NtSAfCZEQjMpHiH4UbFN+xUxs=;
        fh=7KVH3el6cu3e/RaT16tgm9sdldShLsrg3o/OpASKJQ8=;
        b=oekXbZxdpOuHUdY5XsuD+ClqL7snAqE9bxusnCFBSMbjxwnyPuJptNSCDy+XSQIhGx
         +Lw6DOE/+SBsUxfk9m3H6UINsu8UmYGmaGCe5ZXLabviJVhfCGoqUFWhqEzDPIMhKvCO
         Lwb04hFz8XSZupjDZNHe9xcR2QAMNnaT9J/bBoF+gKW9AOFH8a1xs+B/cBERRHCpZhGZ
         zsH3z5F/NFLfuUddlCSh3+C6gc5A7MXxYLHj6xqNg8qMaExQiOz5HKUmZfGqnC82hvjQ
         lR1J+UWT6Sr/d2Ssc3zs2cDtiJ9NybqpMgLczoa1Tn/rdmgM0O6aRO9nBvBs+cJg32XK
         9Rkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1783433328; x=1784038128; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wU5hoHcS0fjFW/J132NtSAfCZEQjMpHiH4UbFN+xUxs=;
        b=SWFRlglKpYxb7/ktQfEAJpt7Mij71K4y1QNKz/VIooX3QHoQ2retWB4l92allO+vhR
         l80TStfDFSVuRDBp30RfX5OdFTfKrEGQPd+V/0+dVV/F5O0TY+HIElUPqnIo1f0cx057
         RR1aafgfAXpUkar2dNlAzPl/Fs1i3/tqRJt3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783433328; x=1784038128;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wU5hoHcS0fjFW/J132NtSAfCZEQjMpHiH4UbFN+xUxs=;
        b=Iel0uSS5xkPAgpMWCrekZoWfz4yuRdEh/5L3p/1N2IHwvGq8seL96dUDO3Ku5JAYxS
         TjgM2GOL02zGNNk1AVmzC98NYc+7lvj1arCRFTACZC75ClbzDmZjJiF6bhBCYtWOK5HL
         Q8ZGiSAm2Dmit13psVKCDRJOKeXQDuC++KHhA9u0wjb0nqotbXo3bgpFNtDYBGNpyOUh
         On1s1jI5SP8I57n+Bs/yVqGxKMJOzsMQegEqIDf6eUNdzhvxPv8w71iuQRR7do/wgeMC
         UkubQ43d/fpG2B37cbl7ZOYNhJbTjgWzwQA39o50jXSca+p5amSztmjjkKtvFDZXc8ok
         8VrA==
X-Forwarded-Encrypted: i=1; AHgh+RobIdrB+b4h+IJ1NSigpwFv+847GuQNy68MbMa8nF9EABKXOKlfxSEsivRTEDlwCA4m7BQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiN29AATtZ4ILeaNphIyztMrl4Y4Aj59JYA64AJZwVdSIgnVss
	J2nvAQBZ0N3BBpdObcg3mqIeYnqBzEh/fpD5MBknvtoX97ZBvksUnNqeg5OrbNoVypG4DV+u3HL
	p7W6m5pvdUrtaBcyR8+FN17jynZuQ32dEcpZstuSV9xDe5UqqBhKYxuXSeQ==
X-Gm-Gg: AfdE7cmcEHJ679fnjkGxfYX9HdkLREu9v9toIIOZLibhrEVyOvsbNXXkjWG0NDYuOWW
	rgp1K/h+dfYHjxYnHguZuGpgjffsyOMv33MMUMjGsLcDfWr/oXZD/luP14YDe+FJ07eERUKdOr/
	vQ2nIupO46N9EVrYv5V2zU4C/96catHOoRcZBvGEVad0dKtXNDPDD5+yKyeFSQHFFklXSzDXhOz
	3ru2ELypRddWmGrxsT30aHND6pHQ10vk9XiFFmWIAXQd/dAy4In3trfBxeyPtXp1ZTQXKiwhQ==
X-Received: by 2002:a05:690e:488b:20b0:667:8b91:2427 with SMTP id
 956f58d0204a3-6678b914957mr1379568d50.86.1783433328026; Tue, 07 Jul 2026
 07:08:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2170.git.1783418384.gitgitgadget@gmail.com>
 <b865c2bcff53a32637aac426dd2c6ef4a4c27077.1783418384.git.gitgitgadget@gmail.com>
 <ak0DUx5Y/5y1OINz@nand.local>
In-Reply-To: <ak0DUx5Y/5y1OINz@nand.local>
From: Kristofer Karlsson <krka@spotify.com>
Date: Tue, 7 Jul 2026 16:08:36 +0200
X-Gm-Features: AVVi8CdFtGA3No8cG3CUSfIPPBkJv51TJlLCDZIjZHTYwxXhjf8iEyFdMePNkbE
Message-ID: <CAL71e4PuD9D8LRbP3mfxxeMrM+1q--3sCp6oJs=hezdasZUPMw@mail.gmail.com>
Subject: Re: [PATCH 1/2] commit-graph: add trace2 instrumentation for
 generation DFS
To: Taylor Blau <me@ttaylorr.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Jul 2026 at 15:47, Taylor Blau <me@ttaylorr.com> wrote:
>
> > Add a test that demonstrates the problem: with a two-layer
> > split commit-graph, writing a new incremental layer for a
> > commit whose parent is in the base layer walks all the way
> > down to the root (7 steps for 5 base commits) instead of
> > reading the existing topo level and stopping immediately
> > (1 step).
>
> This paragraph only describes verbatim what is already included in the
> patch. I think we could easily do without it, but I do not feel so
> strongly about it.

I also don't feel strongly about it, I could remove it entirely.

> > +     intmax_t steps = 0;
>
> Any reason that this should be signed? Obviously in practice, I don't
> think we're going to wrap around with a greater-than-INT_MAX number of
> commits here, but perhaps we would at the very least prefer uintmax_t.
>
> I guess trace2 only has a data_intmax() function, so perhaps the point
> is moot. Regardless, it seems that we would want to have a convenience
> wrapper to be able to print out unsigned integer values which are
> otherwise un-representable as signed integers.

Yes, my only rationale here was to match the type that
trace2_data_intmax expects - and as you say, it's very
unlikely that we'll need to use all bits anyway, and since
this is only used for testing and debugging, and overflows
would be noticed that way and would not affect general
correctness.

> Instead of writing "# BUG ..." and then an incorrect assertion, I
> would suggest that you write the assertion you expect:
>
>     test_trace2_data commit-graph generation-dfs-steps 1 <trace.txt
>
> , but mark the test as "test_expect_failure".

I started with this actually and then changed my mind in order
to demonstrate exactly how the counter changed, not just that it
changed from failure to success. But I'd be happy to change this
too if needed - it would effectively reduce the second commit to
just the bugfix line and switching from test_expect_failure
to test_expect_success.

Thanks,
Kristofer
