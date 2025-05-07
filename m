Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F91A29CEB
	for <git@vger.kernel.org>; Wed,  7 May 2025 01:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746582021; cv=none; b=f41UjGHFHIRPo2PPY7Gui3soapXMJeXjfjOTtwf+of5jDQJPZ8Z5gRaf7nXchsprkkvHMLmM7bW1oT1cE+0bx3zsj3J3Gph5f9m+2/EE7fZDOvZLY30+9jFdvr5rtr9z0NQ3mGLGUcmDYsUTVk0VpqHDbmrF5kvBceAtK+NdGjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746582021; c=relaxed/simple;
	bh=RdXD/FWQlKFohQKj9sw5fq3W4pNRKpwUQfF44KNy0EQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WDuGGOx/+6tLdndpPZLdwI6m7jU5A7mMRWknozouGAKpc/fLcnR01W4F44nbmie/01/TDzeTtVitbT4DdRbfrcz2WodK+QVdMRdSdB2D6FoiJb4fqj92pmPQpsw2KFDq2g+MaHvhA7kxQKStiJnyITJ1V8CL+1tpSE+UJZR+Ba4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IAWRiNST; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAWRiNST"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e7311e66a8eso5817709276.2
        for <git@vger.kernel.org>; Tue, 06 May 2025 18:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746582018; x=1747186818; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dfNWxaqSv9yNZbxadQjSLPkm8cZHJfq2GzgaKsZ7bgg=;
        b=IAWRiNSTV2al385g2YhgB0nD5ukBR5j2B+y1fHpq39D8vf7K1vtXDsa6WWFh4OViJI
         ONSADJcKDbpudKsp6omj7CYj1M9huEwUCnej2ePv3glfO0MLABA3FYAXkbK40HthzSmu
         kw2hTBCrA5jP9J/cbkoHui8oizUi8O/tnzykedWZH824jArBn45i1bTVHyboyazgvmjN
         70uZyVPOmIiWv8JJex0dPcogeENJlcZVr5dnmoyKHRUK0by3llYz574pf7kp3NmbMpcl
         dqGZWNM1rsT7LlIHup3uO70o5CokCiyH5D7kxx3wR89g/OQlnfpMD7qVtRlsOwOf8rP9
         VeNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746582018; x=1747186818;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dfNWxaqSv9yNZbxadQjSLPkm8cZHJfq2GzgaKsZ7bgg=;
        b=M7Px/TjtD3NnBmJhif1J1AEcErajtMKaCUgV2E//ruAhOJga+pMqIQXSRgm9tIVln7
         9DD8Or9XjwqbQLNxhhRNiNAfEu66znp3NNbRsSahF1cLoez8hzyP+Pb3MbIyN2AqJMXs
         OVszk9lFEO8bwOz29orgaR91S02yDmMMdBK4w7IEDp1ESqxUGCeUa+d4w19btBBlI6yI
         CaAFcuzSsqi0iNl2cWUOzQlMoTDhLF8mlfxKJXFEwzi1uCFqfsyiYXJXf9693UhnhPFi
         tmcwpR3t1jJN7IQ+3WeYfxVXPjYkUdmjuMpsbr1wALdrXLNyKWBLNTdaIp7hJO1Z22Zb
         E3aQ==
X-Forwarded-Encrypted: i=1; AJvYcCXK5IVyFw5zt/p1nJZyTY7g1AKcUTgUSec6APBGYR6S2UvFabYmgIt3PP/vWn8FF4vajbM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2UY7MypOBo77CheSmvjReO6ypN9E0xMVnVCF46N5vn4/ATZ75
	qCWjuZfbvavn4PYl7H8Qy4Dd1ItRGDX9kS9exGA9zV4av7d8VlbZQcg0zw==
X-Gm-Gg: ASbGnctDDnh3yhLmSRO0GzAAsSTPZI6uWFkf8jfmd3iBfaWGHtkSAGsImXmuBnatYXF
	6CeXd7TFUKZGSgc6VpyaDYGn5DUQbKsaNcUEpVtDpUdOCISi+E1zECwn5kjVHf/cgJbAyaBhc0v
	nwDVMFgaylV1KxKNUwoPsqRjue4A7R2SgV/86P3oRhH4XOaCBQAJa6Ay87qtNpdpwx5/92/2BUW
	xC5U3hQJPAuJUyWClPVbdgH1e0WEUzxgoGKhYQ+BUd77P47SJ6nd6IJBJCiYii0/dOttWfmSJi7
	yh37XLZhpIjnmRb6ATW208JXFzi8UZVDa1d1Y4/QJuldgRCpimLrWKdJc5ff2U1nT1PZayWGuoq
	/YMU8MmyzGOTsT66NROxZI+Sw4riJ
X-Google-Smtp-Source: AGHT+IEMvLbSxVkSLbP9SA71XU44KQ7oNbFVZbP43uErnWTh5SK43HA5dPIYVGC92kxqfOOwMY6I7A==
X-Received: by 2002:a05:6902:1ac5:b0:e72:c8f9:2b34 with SMTP id 3f1490d57ef6-e788154d50emr1796938276.42.1746582018249;
        Tue, 06 May 2025 18:40:18 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:cc2e:477b:d336:3346? ([2600:1700:60ba:9810:cc2e:477b:d336:3346])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e755e716696sm2729816276.31.2025.05.06.18.40.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 18:40:17 -0700 (PDT)
Message-ID: <5bea19fe-6616-4f01-a78d-9b7da94db899@gmail.com>
Date: Tue, 6 May 2025 21:40:16 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/17] object-store: carve out the object database
 subsystem
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/6/25 7:09 AM, Patrick Steinhardt wrote:

> this patch series refactors the object store subsystem to become more
> self-contained by getting rid of `the_repository`. Instead of passing in
> the repository explicitly, we start to pass in the object store itself,
> which is in contrast to many other refactorings we did, but in line with
> what we did for the ref store, as well.
> 
> This series also starts to properly scope functions to the carved out
> object database subsystem, which requires a bit of shuffling. This
> allows us to have a short-and-sweet `odb_` prefix for functions and
> prepares us for a future with pluggable object backends.
> 
> The series is structured as follows:
> 
>    - Patches 1 to 3 rename `struct object_store` and `struct
>      object_directory` as well as the code files.

Patches 1 and 2 involve renaming some core structures, and I had
some questions around these names (since we hope to be stuck with
the new names for a long time). I was thinking out loud on a per-
patch basis, but now want to collect my thoughts around these:

  * raw_object_store currently describes the abstraction that contains
    all objects that can be accessed within the repository. This may
    include multiple alternates. Patch 1 renames this to
    'object_database'.

  * object_directory currently describes a single directory that
    has the same structure as $GIT_DIR/objects/ but may be an alternate
    or a submodule object directory. Patch 2 renames this to
    'odb_backend'.

My concerns around this are basically around not liking "backend" for
this purpose. When I think of a backend, I'm thinking about the
implementation details (like the refs backend being files or reftable)
and not multiple distinct locations that have their own objects.

In this sense, I'm partial to being brief for the most-common structure
that will be passed around and then more descriptive about the smaller
pieces:

  * 'struct raw_object_store' could be renamed to 'struct odb' to match
    its use in all of the new odb_*() methods. This represents the
    "object database abstraction" and consumers don't care if this is
    one or many object directories in a trench coat.

  * 'struct object_directory' could be renamed to 'struct odb_shard' or
    'struct odb_slice' or similar. I may even recommend 'odb_partition'
    though that does imply some disjointness that is not guaranteed (an
    object can exist in multiple parts).

  * In the event that we create multiple implementations for storing
    objects, then a 'struct odb_shard' could point to a backend to help
    find the appropriate methods for interacting with its storage.

  * "alternate refs" are locked in as names based on the following
    config key names:

    - core.alternateRefsCommand
    - core.alternateRefsPrefix

    These user-facing names should not change. This may be valuable to
    make sure that the 'odb_shard's still have a state of "I'm an
    alternate" or "I'm the base read/write shard for this repo".

>    - Patches 4 to 12 refactor "odb.c" to get rid of `the_repository`.

These are carefully done. Thanks. I only have a few nitpicks here
and there.

>    - Patches 13 to 17 adjust the name of remaining functions so that they
>      can be clearly attributed to the ODB. I'm happy to kick these
>      patches out of this series and resend them at a later point in case
>      they create too much turmoil.

I like that these are present, especially because you included
compatibility macros for in-flight topics.

I do mention that the rename of the object-store.[c|h] files may be
unnecessary, or perhaps could be delayed until this series is merged
and the collateral is calmed.

---

This was clearly a lot of work to put together. Thanks for working
hard to thoughtfully rename things while refactoring to reduce our
dependence on global state.

Thanks,
-Stolee

