Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B42E2AE69
	for <git@vger.kernel.org>; Wed, 11 Sep 2024 18:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726078552; cv=none; b=hkoY3r9bCCepYCNFtHc0woaOdAZ3i/e92nG0KMvpEm6dtLjPa34HpYny8GSeXr3HuWToqhKkuir8baQP1l8bXS8wJDn7Kwaj5f55n4EF2m2Ku00jwMqLsdWyQ8byVtZCec0zg0ax/M9iEa8YFvl+mGIvy/J0hd/4qOtPvgW1EH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726078552; c=relaxed/simple;
	bh=8f2TXloK4XDk4boF3LcFzKxYqN41VA7rfvsorselarE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FvVoxEwU1aU6xVGNH7oVTvdOVtOxm7nC1D86YrpUW4bP+vjKqPrwAPmmzJbGBLgUIM3TQ0ZbBTndBWTWX/v1sp4jpdxrLdM8zX57lvuU98r/fAj5QhI1GH4bqQaBhby/Np5TySP1oFXf9H2c/IzxYwI/bGyfQRNd1B+u4emkAJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Evr+4/gw; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Evr+4/gw"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 32A061C07D;
	Wed, 11 Sep 2024 14:15:49 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=8f2TXloK4XDk4boF3LcFzKxYqN41VA7rfvsors
	elarE=; b=Evr+4/gwzV7taVSCPOM13w2c4J7WG828Hdyg2ww0jnJs3Jyl5U6Cw8
	1rZIcn6EIayPRZotxw+k0vXKSfvZNhdYTapxaqjfjrPJINMR99lXfQkatHTVA+mc
	0N8Bsg7TB8AYxSDOZ01gUo+sNIkA1hlabZOARS7SuCJk0SJ3NvgL0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2B3DD1C07C;
	Wed, 11 Sep 2024 14:15:49 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8B3601C07A;
	Wed, 11 Sep 2024 14:15:48 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  John Cai
 <johncai86@gmail.com>
Subject: Re: [PATCH v2 2/3] builtin: remove USE_THE_REPOSITORY_VARIABLE from
 builtin.h
In-Reply-To: <434c8babbb140b7e66321deec0cd8e8a0d706475.1726001963.git.gitgitgadget@gmail.com>
	(John Cai via GitGitGadget's message of "Tue, 10 Sep 2024 20:59:19
	+0000")
References: <pull.1778.git.git.1725555467.gitgitgadget@gmail.com>
	<pull.1778.v2.git.git.1726001960.gitgitgadget@gmail.com>
	<434c8babbb140b7e66321deec0cd8e8a0d706475.1726001963.git.gitgitgadget@gmail.com>
Date: Wed, 11 Sep 2024 11:15:47 -0700
Message-ID: <xmqqikv26oq4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DEEF7B90-7069-11EF-8509-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> Instead of including USE_THE_REPOSITORY_VARIABLE by default on every
> builtin, remove it from builtin.h and add it to all the builtins that
> reference the_repository.
>
> Also, remove the include statement for repository.h since it gets
> brought in through builtin.h.

Can we have _all_ builtin/*.c files that include "builtin.h" to gain
"#define USE_THE_REPOSITORY_VARIABLE" in this step to make it more
mechanical?  That way we do not have to go through this large patch
manually to review it.

Then another patch can immediately remove the "#define" (and doing
nothing else) from some of the files in builtin/*.c with its commit
message saying "These do not need implicit or explicit accesses to
the_repository as-is", which would make it trivially reviewable,
because such a claim in its commit message can trivially be verified
by simply compiling these files.

After that, manual work to remove implicit or explicit accesses to
the_repository, which would remove the "#define" that becomes
unnecessary, one-patch-per-file can build on top.  Each of them
would be reviewable again.

> The next step will be to migrate each builtin
> from having to use the_repository.

I am not sure what this "to migrate" refers to.  Is it referring
exactly the same thing as what I called "manual work" above?

Thanks.
