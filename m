Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F94A202638
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 18:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731522421; cv=none; b=DlxhMS6GTpmerIaypCOE3R/sDn3uHPz6F5vioP9uBMsB6FANPFef3rix4DoEBoQJqISW5z3mxNWYuCvtxicGblPLpvQV6kRLkUpfUQ+f4E5D7u4M1YnEWi1N0Z8UvkgSDqQEJw8SYeExaDsrLfkJZP0mf5AiUlIk3xNzju97wB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731522421; c=relaxed/simple;
	bh=Rl7saCFnprpOCuDA1eTEPo87V5nGh06oPshS1+QKmPA=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=kWXsd3ZKew9o0f17iOi3AnX/3Jvz3Okf1v4DlmaQWkvHcPLB5Fgc03ICuOaXxjMK4WIXVcCYmhZFuVmMzecXtxwduT0U2YJwPa0adS+WiZ1vs9CpXfoRNsBgjeC2L1pAV01v6vAGNb1EHEmvqrjot/XEFx3iEYNWc7xg5YhMwxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FjVFpwWF; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FjVFpwWF"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea8a5e83a3so140931747b3.2
        for <git@vger.kernel.org>; Wed, 13 Nov 2024 10:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731522418; x=1732127218; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iHpWEoq5zALilQWLMiREcpJNMouIE5VJJNj+oPsXNAI=;
        b=FjVFpwWFv7LfKpyoU5elWFk14F2TFU4vIgloxPddRWrFjLgteefAI8MbpQw1DcwE4w
         cYvQwkhecRDj0hqeY7NxypLLydiOsysckrq+GvyWHwJo0A9cKglukEeyFNfHZKa6w3Je
         Hu5fud4XJQ5GEyeh5dcXnl0QaZAy0QIdTpIEGO+10mnjq2VKgCrdvhMvE6hg3SKp1CfO
         7lF/mX1sVR6SMv/zTzVLDRbpiWjULSzmrKX8ej1uIrNde/bg6EIriS3L44qzVQ5zk2ZW
         NYRVCZ6sejRzrf6T1MihH15VzpuqQC6BLxkMOKDAVkzz604SzHmudvdM61uyJv23EEOB
         c68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731522418; x=1732127218;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iHpWEoq5zALilQWLMiREcpJNMouIE5VJJNj+oPsXNAI=;
        b=VZ0guVZLM94DDGmfMDrOUHZDpbWF38Fg1/nEQg9mc8YMdAPHQUBDstJR5WohM/1FU9
         EGGlvUXrxK0makwnouwv0zQqLG+8FNFp+ZqPy2TBogC3ABboan24A5LhWCL535Hwl2KZ
         qI+hcUWpgWCM3Fpf55iu9/Y3Y49syQCdTuoC3Jv9x3cO49mFiEyAew9WLbDSnzyXrYvn
         kK6CFuyp0lEcp5KFUAcrq747+aWsyAmJkl6FYVRBcOlYQPeF+daMn5GW2qf8Qpzj6lhY
         xCbC/Kwu7M4l19XQWAS3y9W0YrX2xvf/gw4vEE1gPdLVk3Y7knxaCuMf89/vs4U5Z3aW
         KWZw==
X-Forwarded-Encrypted: i=1; AJvYcCW3aykTf/dZd/MzBKITpsBNk0m8xZ9t4dpxfg3XmmMuAwnhy9FhH+hY2CSyjWPpQUEXNC4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx94CWJNP6NwxkrwzaH+Rw0/dnFUVXpx1Sw+HrUq7UrglwlPJyZ
	mRl7mW9PYV2+VvbFC4oTtLRdvH0LlqcKVb98X3GBb36DCuZYr8EkKJqi45wRTbir6nQV3uj3xQF
	NoFJSzJQrhV1SJdekDgxBBGduXm6SRg==
X-Google-Smtp-Source: AGHT+IGtlcIkCw/vbFdqI8it259XlBHgJf7SU8mxQkPjl93C3QcCY8v+5tioK6fcfPSeA92xeG5vWWTtINI3ECvm3jIH
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:9c2a:2b62:2715:580])
 (user=jonathantanmy job=sendgmr) by 2002:a05:690c:3186:b0:6e3:b93:3ae2 with
 SMTP id 00721157ae682-6eca4600e5bmr348917b3.1.1731522418194; Wed, 13 Nov 2024
 10:26:58 -0800 (PST)
Date: Wed, 13 Nov 2024 10:26:56 -0800
In-Reply-To: <20241113073500.GA587228@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241113182656.2135341-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 3/4] t5300: move --window clamp test next to unclamped
From: Jonathan Tan <jonathantanmy@google.com>
To: Jeff King <peff@peff.net>
Cc: Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org, steadmon@google.com, 
	hanyang.tony@bytedance.com, me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"

Jeff King <peff@peff.net> writes:
> On Fri, Nov 01, 2024 at 01:11:47PM -0700, Jonathan Tan wrote:
> 
> > A subsequent commit will change the behavior of "git index-pack
> > --promisor", which is exercised in "build pack index for an existing
> > pack", causing the unclamped and clamped versions of the --window
> > test to exhibit different behavior. Move the clamp test closer to the
> > unclamped test that it references.
> 
> Hmm. The change in patch 4 broke another similar --window test I had in
> a topic in flight. I can probably move it to match what you've done
> here, but I feel like this may be papering over a bigger issue.
> 
> The reason these window tests are broken is that the earlier "build pack
> index for an existing pack" is now finding and storing deltas in a new
> pack when it does this:
> 
>   git index-pack --promisor=message test-3.pack &&
> 
> But that command is indexing a pack that is not even in the repository's
> object store at all! Yet it triggers a call to pack-objects that repacks
> within that object store.

As far as I know, index-pack, when run as part of fetch, indexes a pack
that's not in the repository's object store; it indexes a packfile in a
temp directory. (So I don't think this is a strange thing to do.)

> Here's an even more extreme version. You do not need to have a
> repository at all to run index-pack. So doing:
> 
>   mkdir /tmp/foo
>   cd /tmp/foo
>   cp /some/repo/.git/objects/pack/*.pack .
>   for i in *.pack; do
>     git index-pack -v --promisor=foo $i
>   done
> 
> used to work, but with your patches will segfault (because the repo
> pointer is NULL). Granted it's odd to pass --promisor when you are not
> in a repo, but certainly we should never segfault.

Ah, good catch.

> So I think at the very least that index-pack should not try to modify
> the repository's object database unless we are indexing a pack that is
> within it, which would fix both of those issues.
> 
> I'd guess in the real world, we'd only pass that option when indexing
> packs that we just fetched. But as a bystander to this feature, it feels
> quite odd to me that index-pack, which I generally consider a "read
> only" operation except for the index it was asked to write, would be
> creating a new pack like this. I didn't follow the topic closely enough
> to comment more intelligently, but would it be possible for the caller
> of index-pack to trigger the repack as an independent step?
> 
> -Peff

I thought of that, but as far as I know, during a fetch, index-pack is
the only time in which the objects in the fetched pack are uncompressed
in memory. There have been concerns about the performance of various
ways of solving the promisor-object-and-GC bug, so I took an approach
that minimizes the performance hit as much as possible, by avoiding yet
another uncompression (we need to uncompress the objects to find their
outgoing links, so that we know what to repack).

We definitely should prevent the segfault, but I think that's better
done by making --promisor only work if we run index-pack from within
a repo. I don't think we can restrict the repacking to run only if
we're indexing a pack within the repo, because in our fetch case, we're
indexing a new pack - not one within the repo.

Maybe we could conceptualize "index-pack --promisor" as the pack giving
"testimony" about objects that its objects link to, so we can update our
own records.
