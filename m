Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79722003D5
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 15:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731079049; cv=none; b=nJ2IAaHA2WzP5rc1NwD/nxcypOIqDhb2jImTP/66IPZtfadtW7YkkN3zHIiRV1r+dcpyVXfhfHdw+Wn594gt+sEi/lADw+6AYHVgWQ6MM2+zHte6/6Vohj5ET6EhCy9XxhbrBwKk3KpfS7h/Gq/CeZfJ6MwaMbAwvgJfCewWBfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731079049; c=relaxed/simple;
	bh=vacnqkbTat5BQcIe0T/r/clRlj3WydqiRcu7WVjG+2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tvRCAOQi7BmW2r/2LojHXtdlnXPX7xWVrD/0dvC1+V3avjmEgj7n7oOVOEbb6QREHxKVbnL32zHhChENFwbwKakeMPLTIMPZLAxWeRYL2Hm2BDk1Y246NBvM/Wohal9jT35AfxykaYmTbAR5CsBlxajf7XMXYRubgt2NECsqYQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/iWgg4x; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/iWgg4x"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6ea1407e978so21409877b3.1
        for <git@vger.kernel.org>; Fri, 08 Nov 2024 07:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731079047; x=1731683847; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EzgmnxDrw5vgJ+foGwIXnUXL30SoUhbQZe3ddKmckHo=;
        b=f/iWgg4xSdT9DF+ZhT/n6fDVYqmtT0hSPO/LWihHTZ3mNviYMfkfpVKlrbXlggrH/h
         0KaMywh/DjufFpuPQYB+6u3N3YGp6IsWF9hC+buFvzRbPeFTlAavRrO+xSJdxgP0xsJf
         VfMXnZDaB8wjsTFWsYrFTc6FranptlmJ2GxV8+Mzm7+OFjDVc7+4sNEj5NNuaTgnmkQP
         2K7mCkzJY8a5AjAe91FrINy4plNDWiGc3NbiZXKHRyIQqzTUEGSAi6WOvCzymdl8gw3f
         fu4jUxerAehR1M6gV5UjY6YM7qZq2JWoc0Q3uAu0RuRaR9ale+FgCddDM8rnCy7NdyeK
         Fo1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731079047; x=1731683847;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EzgmnxDrw5vgJ+foGwIXnUXL30SoUhbQZe3ddKmckHo=;
        b=gwB12CAmIsC65WKG3cx243mhRYEVGF3gOVyzjWWulqazNwMFmQliICWV2fQG84wQtC
         miV+YmfmA6ZDFHVkuh/Q+T4jrCZJbacp4mhxTGF7llhZUb/AiZguQtS7iqTPWR/xYKE0
         CfejcHWWhEBYmpURUVecqHMuDd4P5z5y1Z48yQZ4Pqerw+728GfCsFHH5My+hrBHnzfi
         2ZU4r4N+va+b4Q5ArNF8eSFWEtozisssfmM7vKyfT7yOtREkNT+Ez5tqNa+7Hn2lDr7l
         FMXb2fvMgT9hRZW2qsPJ8cya+VTrBBP5Sd9dM1+3/3afhaoWoHijL3hMfgKQTqO9J4sn
         r6kQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0IFQqyoKRy7m+jK04CLeCK6W9ysAb1GByYDXt3iDmlGrFxTwSsbadOTx6c/lFQyvOmRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjwYEGy3fMTpnb9PJFEdfF6Lz3Z83IVrVGTgCb7VOEtat96s2H
	dq8cH0rLOOwv78GfTFUXkw+1Gz4YIawq3LN/Si3nj+B2dAZUuy/H
X-Google-Smtp-Source: AGHT+IEimG9/s/Xe+UU6bjiRzd8eZAsW95XVEKFL0MWOzazR7Z5VVBqUbArbNwFuKNVMRF1ibKMplg==
X-Received: by 2002:a05:690c:c96:b0:6e2:50a:f436 with SMTP id 00721157ae682-6eaddfc5255mr37331797b3.36.1731079046686;
        Fri, 08 Nov 2024 07:17:26 -0800 (PST)
Received: from ?IPV6:2600:1700:60ba:9810:cdf0:7186:dd7d:aa91? ([2600:1700:60ba:9810:cdf0:7186:dd7d:aa91])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eace8d77e6sm7418567b3.17.2024.11.08.07.17.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 07:17:25 -0800 (PST)
Message-ID: <f02ee8ac-01e4-42e3-b99a-d9616b9ff1bb@gmail.com>
Date: Fri, 8 Nov 2024 10:17:24 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] PATH WALK I: The path-walk API
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, johannes.schindelin@gmx.de, ps@pks.im,
 johncai86@gmail.com, newren@gmail.com, christian.couder@gmail.com,
 kristofferhaugsbakk@fastmail.com, jonathantanmy@google.com
References: <pull.1818.git.1730356023.gitgitgadget@gmail.com>
 <ZyUqr/wb5K4Og9j9@nand.local>
 <2d2940ef-0b26-4060-90b6-9b6969f23754@gmail.com>
 <20241104172533.GA2985568@coredump.intra.peff.net>
 <xmqq1pzqwnck.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqq1pzqwnck.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/24 7:11 PM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> On Mon, Nov 04, 2024 at 10:48:49AM -0500, Derrick Stolee wrote:
>>> I disagree that all environments will prefer the --full-name-hash. I'm
>>> currently repeating the performance tests right now, and I've added one.
>>> The issues are:
>>>
>>>   1. The --full-name-hash approach sometimes leads to a larger pack when
>>>      using "git push" on the client, especially when the name-hash is
>>>      already effective for compressing across paths.
>>
>> That's interesting. I wonder which cases get worse, and if a larger
>> window size might help. I.e., presumably we are pushing the candidates
>> further away in the sorted delta list.

I think the cases that make things get worse with --full-name-hash are:

   1. The presence of renames, partitioning objects that used to fit into
      the same bucket (in the case of directory renames).

   2. Some standard kinds of files may appear several times across the
      tree but do not change very often and are similar across path.

   3. Common patterns across similar file types, such as similar includes
      in .c and .h files or other kinds of boilerplate in different
      languages.

A larger window size will always expand the range of possible deltas, at
a cost to the time taken to compute the deltas. My first experiment in
these repositories was to increase the window size to 250 (from the default
10). This caused a very slow repack, but the repositories shrunk.

For example, the big Javascript monorepo that repacked to ~100 GB with
default settings would repack to ~30 GB with --window=250. This was an
indicator that delta compression would work if we can find the right pairs
to use for deltas.

The point of the two strategies (--full-name-hash and --path-walk) is
about putting objects close to each other in better ways than the name
hash sort.

>>>   2. A depth 1 shallow clone cannot use previous versions of a path, so
>>>      those situations will want to use the normal name hash. This can be
>>>      accomplished simply by disabling the --full-name-hash option when
>>>      the --shallow option is present; a more detailed version could be
>>>      used to check for a large depth before disabling it. This case also
>>>      disables bitmaps, so that isn't something to worry about.
>>
>> I'm not sure why a larger hash would be worse in a shallow clone. As you
>> note, with only one version of each path the name-similarity heuristic
>> is not likely to buy you much. But I'd have thought that would be true
>> for the existing name hash as well as a longer one. Maybe this is the
>> "over-emphasizing" case.

I'm confused by your wording of "larger hash" because the hash size
is the exact same: 32 bits. It's just that the --full-name-hash option
has fewer collisions by abandoning the hope of locality.

In a depth 1 shallow clone, there are no repeated paths, so any hash
collisions are true collisions instead of good candidates for deltas.
The full name hash is essentially random, so the delta compression
algorithm basically says:

   1. Sort by type.
   2. Within each type, sort the objects randomly.

With that sort, the delta compression scan is less effective than the
standard name hash.

> I too am curious to hear Derrick explain the above points and what
> was learned from the performance tests.  The original hash was
> designed to place files that are renamed across directories closer
> to each other in the list sorted by the name hash, so a/Makefile and
> b/Makefile would likely be treated as delta-base candidates while
> foo/bar.c and bar/foo.c are treated as unrelated things.  A push
> of a handful of commits that rename paths would likely place the
> rename source of older commits and rename destination of newer
> commits into the same delta chain, even with a smaller delta window.

> In such a history, uniformly-distributed-without-regard-to-renames
> hash is likely to make them into two distinct delta chains, leading
> to less optimal delta-base selection.

Yes. This is the downside of the --full-name-hash compared to the
standard name hash. When repacking an entire repository, the effect
of these renames is typically not important in the long run as it's
basically a single break in the delta chain. The downside comes in
when doing a small fetch or push where the rename has more impact.

The --path-walk approach does not suffer from this problem because
it has a second pass that sorts by the name hash and looks for
better deltas than the ones that already exist. Thus, it gets the
best of both worlds.

The performance impact of the two passes of the --path-walk
approach is interesting, as you'd typically expect this to always
be slower. However:

  1. The delta compression within each batch only compares the
     objects within that batch. We do not compare these objects to
     unrelated objects, which can be expensive and wasteful. This
     also means that small batches may even be smaller than the
     delta window, reducing the number of comparisons.

  2. In the second pass, the delta calculation can short-circuit if
     the computed delta would be larger than the current-best delta.
     Thus, the good deltas from the first pass make the second pass
     faster.

> A whole-repository packing, or a large push or fetch, of the same
> history with renamed files are affected a lot less by such negative
> effects of full-name hash.  When generating a pack with more commits
> than the "--window", use of the original hash would mean blobs from
> paths that share similar names (e.g., "Makefile"s everywhere in the
> directory hierarchy) are placed close to each other, but full-name
> hash will likely group the blobs from exactly the same path and
> nothing else together, and the resulting delta-chain for identical
> (and not similar) paths would be sufficiently long.  A long delta
> chain has to be broken into multiple chains _anyway_ due to finite
> "--depth" setting, so placing blobs from each path into its own
> (initial) delta chain, completely ignoring renamed paths, would
> likely to give us long enough (initial) delta chain to be split at
> the depth limit.
> 
> It would lead to a good delta-base selection with smaller window
> size quite efficiently with full-name hash.>
> I think a full-name hash forces a single-commit pack of a wide tree
> to give up on deltified blobs, but with the original hash, at least
> similar and common files (e.g. Makefile and COPYING) would sit close
> together in the delta queue and can be deltified with each other,
> which may be where the inefficiency comes from when full-name hash
> is used.

Yes, this is a good summary of why this works for the data
efficiency in long histories. Your earlier observations are why
the full-name hash has demonstrated issues with smaller time scales.

These numbers are carefully detailed in the performance tests in
the refreshed series [1]. The series also has a way to disable the
full-name hash when serving a shallow clone for this reason.

[1] https://lore.kernel.org/git/pull.1823.git.1730775907.gitgitgadget@gmail.com/

Thanks,
-Stolee
