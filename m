Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8254136C
	for <git@vger.kernel.org>; Sat, 18 May 2024 00:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715991015; cv=none; b=ure/NJNSL6Z0tOiak5dgiqP+n273SnTvtI4tVq4GrL12ZDOrfapf/EgTYqll0wIb4M/Lser9Qfr7Gdbj/8S0gCzwf0lCbdna1dqNS124NXBmi8nkUC9Cnp23U1bTWo7c4q2MGGKg/LirvbUHfO9OgtaW+WKgP6QNOAhoTvzC2oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715991015; c=relaxed/simple;
	bh=2lPB9/hAUESi8SIq76fCKyz5orfwPxG4YmNK2xDsoFs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s5Bj8YVIeZWEovyGYR12jiIn1kPpGQq4Bnyh6HLm5mF8lfjtZkUm9kjoFS7IRc0BKW2YBqF4NWOUyybK0Q9QUt8qjBet+rLg3i7SZuThazSjnk/wHx831VqyvGd0GVmJ38P3uVvjVYFNtKtGJyFXJJpIBVzvZySKwTFhkm3qDac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hQAsWxDY; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hQAsWxDY"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 453C92BAA4;
	Fri, 17 May 2024 20:10:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=2lPB9/hAUESi8SIq76fCKyz5orfwPxG4YmNK2x
	DsoFs=; b=hQAsWxDYpJ6fhw32Lblh0IdD+k3elB8BFz33GYu+n7s0wVNcjt6L8L
	NShRRiTLF23SX0hoeLaIf5C9eVlxOIWse0vYKgKO9XrWh9Xy+fOgAdFFXErd9iik
	Ys+dbBu80t29yyuvivzlieAsRq6QHXL0zIbesxvn2DLkEmpw4k5UQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 39DC22BAA3;
	Fri, 17 May 2024 20:10:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 503902BAA2;
	Fri, 17 May 2024 20:10:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 4/8] tests: verify that `clone -c
 core.hooksPath=/dev/null` works again
In-Reply-To: <7d5ef6db2a9c3c7a1b0ba78873d4202403768769.1715987756.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Fri, 17 May 2024
	23:15:52 +0000")
References: <pull.1732.git.1715987756.gitgitgadget@gmail.com>
	<7d5ef6db2a9c3c7a1b0ba78873d4202403768769.1715987756.git.gitgitgadget@gmail.com>
Date: Fri, 17 May 2024 17:10:09 -0700
Message-ID: <xmqq4jawdlpa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FE32A4CA-14AA-11EF-BAA7-25B3960A682E-77302942!pb-smtp2.pobox.com

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> What the added protection did not anticipate is that such a
> repository-local `core.hooksPath` can not only be used to point to
> maliciously-placed scripts in the current worktree, but also to
> _prevent_ hooks from being called altogether.
> ...
> diff --git a/t/t1350-config-hooks-path.sh b/t/t1350-config-hooks-path.sh
> index f6dc83e2aab..1eae346a6e3 100755
> --- a/t/t1350-config-hooks-path.sh
> +++ b/t/t1350-config-hooks-path.sh
> @@ -41,4 +41,8 @@ test_expect_success 'git rev-parse --git-path hooks' '
>  	test .git/custom-hooks/abc = "$(cat actual)"
>  '
>  
> +test_expect_success 'core.hooksPath=/dev/null' '
> +	git clone -c core.hooksPath=/dev/null . no-templates
> +'

Is it sufficient that the command exits with 0?  I am wondering if
we want to verify that the resulting repository looks like it
should, e.g., with

    v=$(git -C no-templates config --local --get core.hookspath) &&
    test "$v" = /dev/null

or something silly like that.


