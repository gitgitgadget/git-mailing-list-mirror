Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9177A1BF804
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 15:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730735334; cv=none; b=h2a0oTqB9oKkWxrLbPE7hKOV2rW/Cs+DzCeFe08Sz1PCFQqyvwye3imNjVre3YeehWDhoaqVLOziZmCw1BDPCC7T/k9obE3eTq+2t1HTI4+afNAdX3kBu5ekPgmNSxAiDoT+KkxQH8kQHPbaaxNZSRBBkMocOAMvsepk7LVr5Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730735334; c=relaxed/simple;
	bh=sZgFv4nfB560wtKaSPvaGU4X5AB0x79Ot7cTc36h/ZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WS0llWtSx3Kn2ieh8rh3hqElD9HUIV6akaObeBlpP1XsmOqzT7vEN6h5J0radzW/h8uVXFCQNZHUGsN81uyVFpmNu0SofbI3lJWgPiKNOgv5+1YMczCo5erX4d2GyvMJGFFXa59LSRMkpZtWPSTDMHsJAGNbHU385NNIxXsSzpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DUg0HWEN; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUg0HWEN"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6e2e41bd08bso45312317b3.2
        for <git@vger.kernel.org>; Mon, 04 Nov 2024 07:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730735331; x=1731340131; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TfEfuvdqrgOTVH4sZuJ8NndlSGWmuTaHvYzB2D6rHwI=;
        b=DUg0HWENI0K/7Qx5mirCtXEzHx6UaKnZDWzjEg9jZlbpGmeuCpw6ddq87rtchc/bQ6
         YfQbEyIKf1LX/WCIecQLMumzHzEUX2j2aJByAWO2yqFD4PwtfiLwHop26MFy28W/ERh3
         vIj5eXceMpNzkEdifxjA9Ljib03/ijkjNAfHWd9x3bdhZpi6xspu63YYK8QP5hCOueOh
         GLV/j/OWM0klnwCce/LJo9P+8Ajn/5uc/9WXgw3ILImfjNrTNEhLOVuPMFOy4EqaXCMI
         FJW6a7ZKeBa84UJxalfYWNheaAd0OG9ICX6znmg6OE05tdnQSDpT8O56/B/KudayJgPI
         UMvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730735331; x=1731340131;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TfEfuvdqrgOTVH4sZuJ8NndlSGWmuTaHvYzB2D6rHwI=;
        b=ANPxmzebpYLRqak6LrbnNf6lwf/u7vUxSohiG+PrNdOi1hl8yDQPPy/Aax78NgKU38
         1GJscdg2D2gERX0Z1E5T5MQRXRr+QjD2txN0d8S+5JU7MornRjpFZ6Fw2ZCMdBp0axYo
         e+z5dTwi7QnNUleE1Xt6KrZVPd1fatTwYcEm3lJI5y3zeQajjCKrSuGKoULrSi4UGFEp
         y0dXUA1lxdC+qSZkXq++wB4B7So7f0lZg+hqIBVsOccbmgEMk4W+FjahcnNGVApWq2j9
         kgAfhaSHBdbxXpAWZb3LVF5zfZ/Xuyax9xIlnWgyTlzxqx9kISO1rmIIMtg7ZbldkM0b
         LHxw==
X-Gm-Message-State: AOJu0YwK6gq7gbhBLGFZoSnRKA0+VZEYuwm03RUxTZCvR1177yHOp8h0
	GpodqweVTOKlv85DH1XmN8mZqn4zqx/f+IMTWLJ0f7OfbLfKwwlx
X-Google-Smtp-Source: AGHT+IGLosSOZc5CMwGmlwdyb5zBtaYJ55vMLutbyRxE2v7ucYJYl6L/Z0oX1gRzp3YWJtY2+bIPwQ==
X-Received: by 2002:a05:690c:4513:b0:6db:deb7:d693 with SMTP id 00721157ae682-6ea64b27585mr118488327b3.22.1730735331376;
        Mon, 04 Nov 2024 07:48:51 -0800 (PST)
Received: from ?IPV6:2600:1700:60ba:9810:2db7:73fd:372e:bf53? ([2600:1700:60ba:9810:2db7:73fd:372e:bf53])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ea8c8b0673sm7409057b3.26.2024.11.04.07.48.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 07:48:50 -0800 (PST)
Message-ID: <2d2940ef-0b26-4060-90b6-9b6969f23754@gmail.com>
Date: Mon, 4 Nov 2024 10:48:49 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] PATH WALK I: The path-walk API
To: Taylor Blau <me@ttaylorr.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
 peff@peff.net, ps@pks.im, johncai86@gmail.com, newren@gmail.com,
 christian.couder@gmail.com, kristofferhaugsbakk@fastmail.com,
 jonathantanmy@google.com
References: <pull.1818.git.1730356023.gitgitgadget@gmail.com>
 <ZyUqr/wb5K4Og9j9@nand.local>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <ZyUqr/wb5K4Og9j9@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/1/24 3:23 PM, Taylor Blau wrote:
> Hi Stolee,
> 
> On Thu, Oct 31, 2024 at 06:26:57AM +0000, Derrick Stolee via GitGitGadget wrote:
>>
>> Introduction and relation to prior series
>> =========================================
>>
>> This is a new series that rerolls the initial "path-walk API" patches of my
>> RFC [1] "Path-walk API and applications". This new API (in path-walk.c and
>> path-walk.h) presents a new way to walk objects such that trees and blobs
>> are walked in batches according to their path.
>>
>> This also replaces the previous version of ds/path-walk that was being
>> reviewed in [2]. The consensus was that the series was too long/dense and
>> could use some reduction in size. This series takes the first few patches,
>> but also makes some updates (which will be described later).
>>
>> [1]
>> https://lore.kernel.org/git/pull.1786.git.1725935335.gitgitgadget@gmail.com/
>> [RFC] Path-walk API and applications
>>
>> [2]
>> https://lore.kernel.org/git/pull.1813.v2.git.1729431810.gitgitgadget@gmail.com/
>> [PATCH v2 00/17] pack-objects: add --path-walk option for better deltas
> 
> I apologize for not having a better place to start discussing a topic
> which pertains to more than just this immediate patch series, but I
> figure here is as good a place as any to do so.
> 
>  From our earlier discussion, it seems to stand that the path-walk API
> is fundamentally incompatible with reachability bitmaps and
> delta-islands, making the series a non-starter in environments that
> rely significantly one or both of those features. My understanding as a
> result is that the path-walk API and feature are more targeted towards
> improving client-side repacks and push performance, where neither of the
> aforementioned two features are used quite as commonly.

This is correct. I would go even farther to say that this approach was
designed first and foremost for Git clients and specifically their
performance while computing a thin packfile during "git push". The same
logic to help the push case happens to also help the "git repack" case
significantly.

> I was discussing this a bit off-list with Peff (who I hope will join the
> thread and share his own thoughts), but I wonder if it was a mistake to
> discard your '--full-name-hash' idea (or something similar, which I'll
> discuss in a bit below) from earlier.

I'd be happy to resurrect that series, adding in the learnings from
working on the path-walk feature. It helps that the current series adds
the path-walk API and has no conflicting changes in the pack-objects or
repack builtins. (I can handle those conflicts as things merge down.)

> (Repeating a few things that I am sure are obvious to you out loud so
> that I can get a grasp on them for my own understanding):
> 
> It seems that the problems you've identified which result in poor repack
> performance occur when you have files at the same path, but they get
> poorly sorted in the delta selection window due to other paths having
> the same final 16 characters, so Git doesn't see that much better delta
> opportunities exist.
> 
> Your series takes into account the full name when hashing, which seems
> to produce a clear win in many cases. I'm sure that there are some cases
> where it presents a modest regression in pack sizes, but I think that's
> fine and probably par for the course when making any changes like this,
> as there is probably no easy silver bullet here that uniformly improves
> all cases.
> 
> I suspect that you could go even further and intern the full path at
> which each object occurs, and sort lexically by that. Just stringing
> together all of the paths in linux.git only takes 3.099 MiB on my clone.
> (Of course, that's unbounded in the number of objects and length of
> their pathnames, but you could at least bound the latter by taking only
> the last, say, 128 characters, which would be more than good enough for
> the kernel, whose longest path is only 102 characters).

When the optimization idea is to focus on the full path and not care
about the "locality" of the path name by its later bits, storing the
full name in a list and storing an index into that list would have a
very similar effect.

I'd be interested to explore the idea of storing the full path name.
Based on my exploration with the 'test-tool name-hash' test helper in
that series, I'm not sure that we will make significant gains by doing
so. Worth trying.

> Some of the repositories that you've tested on I don't have easy access
> to, so I wonder if either doing (a) that, or (b) using some fancier
> context-sensitive hash (like SimHash or MinHash) would be beneficial.

I don't know too much about SimHash or MinHash, but based on what I
could gather from some initial reading I'm not sure that they would be
effective without increasing the hash length. We'd also get a different
kind of locality, such as the appearance of a common word would be more
likely to affect the locality than the end of the path.

The size of the hash could probably be mitigated by storing it in the
list of all full paths and accessing them from the index stored on each
to-pack object.

> I realize that this is taking us back to an idea you've already
> presented to the list, but I think (to me, at least) the benefit and
> simplicity of that approach has only become clear to me in hindsight
> when seeing some alternatives. I would like to apologize for the time
> you spent reworking this series back and forth to have the response be
> "maybe we should have just done the first thing you suggested". Like I
> said, I think to me it was really only clear in hindsight.

I always assumed that we'd come back to it eventually. There is also the
extra bit about making the change to the name-hash compatible with the
way name-hashes are stored in the reachability bitmaps. That will need
some work before it is ready for prime time.

> In any event, the major benefit to doing --full-name-hash would be that
> *all* environments could benefit from the size reduction, not just those
> that don't rely on certain other features.

I disagree that all environments will prefer the --full-name-hash. I'm
currently repeating the performance tests right now, and I've added one.
The issues are:

  1. The --full-name-hash approach sometimes leads to a larger pack when
     using "git push" on the client, especially when the name-hash is
     already effective for compressing across paths.

  2. A depth 1 shallow clone cannot use previous versions of a path, so
     those situations will want to use the normal name hash. This can be
     accomplished simply by disabling the --full-name-hash option when
     the --shallow option is present; a more detailed version could be
     used to check for a large depth before disabling it. This case also
     disables bitmaps, so that isn't something to worry about.

> Perhaps just --full-name-hash isn't quite as good by itself as the
> --path-walk implementation that this series starts us off implementing.
> So in that sense, maybe we want both, which I understand was the
> original approach. I see a couple of options here:
> 
>    - We take both, because doing --path-walk on top represents a
>      significant enough improvement that we are collectively OK with
>      taking on more code to improve a more narrow (but common) use-case.

Doing both doesn't help at all, since the --path-walk approach already
batches by the full path name. The --path-walk approach has a significant
benefit by doing a second pass by the standard name-hash to pick up on the
cross-path deltas. This is why the --path-walk approach with the standard
name hash as consistently provided the most-compact pack-files in all
tests.

   Aside: there were some initial tests that showed the --path-walk option
   led to slightly larger packfiles, but I've since discovered that those
   cases were due to an incorrect walking of indexed paths. This is fixed
   by the code in patch 5 of the current series and my WIP patches in [3]
   have the performance numbers with this change.

[3] https://github.com/gitgitgadget/git/pull/1819
PATH WALK II: Add --path-walk option to 'git pack-objects'

>    - Or we decide that either the benefit isn't significant enough to
>      warrant an additional and relatively complex implementation, or in
>      other words that --full-name-hash by itself is good enough.

I hope that I've sufficiently communicated that --full-name-hash is not
good enough by itself.

The point I was trying to make by submitting it first was that I believed
it was likely the easiest way for Git servers to gain 90% of the benefits
that the --path-walk approach provides while making it relatively easy to
integrate with other server-side features such as bitmaps and delta islands.

(Maybe the --path-walk approach could also be extended to be compatible
with those features, but it would be a significant investment that rebuilds
those features within the context of the new object walk instead of relying
on the existing implementations. That could easily be a blocker.)

> Again, I apologize for not having a clearer picture of this all to start
> with, and I want to tell you specifically and sincerely that I
> appreciate your patience as I wrap my head around all of this. I think
> the benefit of --full-name-hash is much clearer and appealing to me now
> having had both more time and seeing the series approached in a couple
> of different ways. Let me know what you think.
Thanks for taking the time to engage with the patches. I'm currently
rerunning my performance tests on a rebased copy of the --full-name-hash
patches and will submit a new version when it's ready.

Thanks,
-Stolee

