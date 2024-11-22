Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F6D2594
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 01:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732237992; cv=none; b=LsxN3tEanSCQwWRlLDfDFevF9jdqbUD+QvzoG94/vOtH6ClMMKTHtLHamy4PLpJVuwWS1wvNICXSRnKIYDdz4PnLBu7YFRYYBHj7cDWHjU12isheLi0fsoXEJU3gkq6A2jLSYCuzWa2w6ueQyDwI51HqWLydb00wkKtvnXIzpzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732237992; c=relaxed/simple;
	bh=lnQflNf7ShUMWmBRD1lkvsqxjX3j9YzmXnlcrF03nB4=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=YMHW7dFLOHO+XiNchsRgFCVZfn6w1Zpk1PfIt9dWu0Q6kzL8zlYL3vAOblXck5ODElp/owTfMW9cQb2ASBSpuUhZsfvetO7oAhuSRbxhniccI7D4uV4mYEmX5XzNAb+2zy1ZkghlEB+ZpIqIOOqNgIM6esJNt7Ky86w8wOfE4ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g/AD7gu4; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g/AD7gu4"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ee7856bcf2so27410877b3.1
        for <git@vger.kernel.org>; Thu, 21 Nov 2024 17:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732237990; x=1732842790; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Txb7kG+qDMYgrXkK0OTvzNPZcWP2240Y+kFOzK9vovo=;
        b=g/AD7gu4jA3lC7uKsTR80LHw9h9X2WjDNe57s8NCHDyljVa58jsp5aIyuE4hxO6owQ
         KS8B8nVs+SfQ4SU1oli0J988Pmtx4zuN5yWv5zS5heiMY1Lg8LyTx9nAveSyn47dwKnd
         X1mTrNL5tvfEvW52vfWp3TEj//y//mBjQB9WPBnD6mV4pPFbA7frLiDG0TJ99+uv9uqV
         6K/qhQ/yGfBeSGwFBVHjKMVhWz02dCSSICiUxx53plIbviUERBz2qSH1yI0NPAZjGU13
         JcbMZFT0tj9NKWYKpkXtsgDPkWglae1WAdSNNFS5Gdp6WdSxsjLffEGXN12P3a9og9qD
         iNwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732237990; x=1732842790;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Txb7kG+qDMYgrXkK0OTvzNPZcWP2240Y+kFOzK9vovo=;
        b=LqolRYgqtmWDb5b1+PG7w3+f4fMwx1HHUp26eMkgU9SZhDjC+VPnN/5e76xgnyCVcZ
         ZGKnvBAuuz0QqHtsZ96JJMbkYTX/8DvgTZsCW71u+x28xO/vgF4drFAgCQYWfUKFwqcE
         io6Xx9gCNyY1rIkb1zA8P1Ybh6fUYhw2C/zr8ky9t1mRU7WnuisSWsntT9i9d5WbFQaw
         8AYF+lKzqjQLbNhEMhEdCz7EweZrAs/53heriL20P/STD8vPCmXYVPiO5L4RZuJOpA3L
         Q8vnspjyWbvEd336V9rC/6Po7k4WhHdsZNs4G/JNazIl12eX3+DI6uI0BJ/liLYmjFiK
         /Dag==
X-Forwarded-Encrypted: i=1; AJvYcCWdAfYLBR5Sy6BFbvTjCmdhdF1tGrqTh6KbNZuXGRSGWAUdtpymxcFE5dfAE8geaSCd9Vw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg7F803ICt2Y2glyKvwAPoryIzlgpslNfOP6hoSx2DJjmKqCfT
	Fi7XE8BIfojVbpTCY+Ppfp3zJwDL7+L2SoKyM/5L5H9Rz0tfcU1VKQCbs+YiosbOXaxwS7/jtj2
	lBG8j8Qso7U8NKt9SXPePFYRiWTLCEw==
X-Google-Smtp-Source: AGHT+IH/ImrEeIQ37dd7mPkMAjHcb9wqRYVcTky5bfThFlK/y4EfMdThzK7ht0eOfr0uN9ITD84fPD5sP2NamMVD3pwh
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:d214:e3cc:8644:78ef])
 (user=jonathantanmy job=sendgmr) by 2002:a05:690c:320a:b0:6e7:e493:2db6 with
 SMTP id 00721157ae682-6eee0a49615mr5187b3.3.1732237990245; Thu, 21 Nov 2024
 17:13:10 -0800 (PST)
Date: Thu, 21 Nov 2024 17:13:08 -0800
In-Reply-To: <259734e0bcea952c2c09b0fb3a017e139922b975.1730775908.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241122011308.2743517-1-jonathantanmy@google.com>
Subject: Re: [PATCH 3/7] pack-objects: add GIT_TEST_FULL_NAME_HASH
From: Jonathan Tan <jonathantanmy@google.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org, gitster@pobox.com, 
	johannes.schindelin@gmx.de, peff@peff.net, ps@pks.im, me@ttaylorr.com, 
	johncai86@gmail.com, newren@gmail.com, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> Second, there are two tests in t5616-partial-clone.sh that I believe are
> actually broken scenarios. 

I took a look...this is a tricky one.

> While the client is set up to clone the
> 'promisor-server' repo via a treeless partial clone filter (tree:0),
> that filter does not translate to the 'server' repo. Thus, fetching from
> these repos causes the server to think that the client has all reachable
> trees and blobs from the commits advertised as 'haves'. This leads the
> server to providing a thin pack assuming those objects as delta bases.

It is expected that the server sometimes sends deltas based on objects
that the client doesn't have. In fact, this test tests the ability of
Git to lazy-fetch delta bases.

> Changing the name-hash algorithm presents new delta bases and thus
> breaks the expectations of these tests.

To be precise, the change resulted in no deltas being sent (before this
change, one delta was sent). Here's what is meant to happen. The server has:

 commitB - treeB - file1 ("make the tree big\nanother line\n"), file2...file100
  |
 commitA - treeA - file1...file100 ("make the tree big\n")

The client only has commitA. (The client does not have treeA or any
blob, since it was cloned with --filter=tree:0.)

When GIT_TEST_FULL_NAME_HASH=0 (matching the current behavior), the
server sends a non-delta commitB, a delta treeB (with base treeA), and
a non-delta blob "make the tree big\nanother line\n". This triggers a
lazy fetch of treeA, and thus treeB is inflated successfully. During
the subsequent connectivity check (with --exclude-promisor-objects,
see connected.c), it is noticed that the "make the tree big\n" blob is
missing, but since it is a promisor object (referenced by treeA, which
was fetched from the promisor remote), the connectivity check since
passes.

When GIT_TEST_FULL_NAME_HASH=1, the server sends a non-delta commitB,
a non-delta treeB, and a non-delta blob "make the tree big\nanother
line\n". No lazy fetch is triggered. During the subsequent connectivity
check, the "make the tree big\n" blob (referenced by treeB) is missing.
There is nothing that can vouch for it (the client does not have treeA,
remember) so the client does not consider it a promisor object, and thus
the connectivity check fails.

Investigating this was made a bit harder due to a missing "git -C
promisor-remote config --local uploadpack.allowfilter 1" in the test.
The above behavior is after this is included in the test.

I think the solution is to have an algorithm that preserves the property
that treeB is sent as a delta object - if not, we need to find another
way to test the lazy-fetch of delta bases. My proposal in [1] does do
that.

[1] https://lore.kernel.org/git/20241121235014.2554033-1-jonathantanmy@google.com/

