Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2941218654
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 16:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711296636; cv=none; b=l/nmD3PNB7ULnKXWcOT4WodC5QebKGR6yi7S4XGcjB+Sij9bG+Crofrg39xVyfOIFpZDoLTQOq3FEZFIHytj/1Tmr0DXdRWGV5QazZ3JamD+ybV1m4EduSAYMfdCbto+ZWv9q1F/3NbWprQ0IpFgZwOibzFTRfUJbJ3iHOE745U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711296636; c=relaxed/simple;
	bh=zIOmSzpAVVZVkb/bAh6fTCK+vfXjyL9OGLrlWdH/k8s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bTR6b0cfHOZjp2wyCd2glaKM82wduwT8vPyXdQNMaW34FPXVMD6CJ+jZwx0UQVokXFG8HeBSfCgWBebtgrwiktu3lsdmszo8Unszx6/4el1oisb4AK7x6xfqyw5lFfwo/mu7hftB6bhg7HeLNpv+/PtnG/LFSLAmOJm5Bo9eJvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Qg8Y7Qf8; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Qg8Y7Qf8"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 066311DEE40;
	Sun, 24 Mar 2024 12:10:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=zIOmSzpAVVZVkb/bAh6fTCK+vfXjyL9OGLrlWd
	H/k8s=; b=Qg8Y7Qf8ikQY8E0XhJ6g7WIPwcvaiv4Xm43qekfQwaZNggvsmx3/0u
	8y+I60XNO9xQUpWvQ16j6lwLqpykFUld1r6cp0A2vSXDQHERJE7BxKGGKbkoRIN1
	OLzhZGTBF31VmmCJtpVKyakxU1o5uO03ciPFGXsq6/sk+Sbicez/A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E49281DEE3E;
	Sun, 24 Mar 2024 12:10:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3B4941DEE3D;
	Sun, 24 Mar 2024 12:10:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH] t/README: mention test files are make targets
In-Reply-To: <pull.1701.git.1711293246094.gitgitgadget@gmail.com> (Philippe
	Blain via GitGitGadget's message of "Sun, 24 Mar 2024 15:14:05 +0000")
References: <pull.1701.git.1711293246094.gitgitgadget@gmail.com>
Date: Sun, 24 Mar 2024 09:10:32 -0700
Message-ID: <xmqq4jcvtxtz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0AD07DEC-E9F9-11EE-9C54-25B3960A682E-77302942!pb-smtp2.pobox.com

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> Since 23fc63bf8f (make tests ignorable with "make -i", 2005-11-08), each
> test file defines a target in the test Makefile, such that one can
> invoke:
>
> 	make *checkout*
>
> to run all tests with 'checkout' in their filename. This is useful to
> run a subset of tests when you have a good idea of what part of the code
> is touched by the changes your are testing.

While I agree with the patch that this is a useful "feature" of
t/Makefile, I've always felt it was ugly to use a file itself that
we do not consider a build product, rather a source, as the target
to trigger some action.  Are we comfortable casting this behaviour
in stone by documenting it here?  Just checking by asking others, as
you are obviously comfortable enough to write this patch ;-)

Thanks.

> Document that in t/README to help new (or more seasoned) contributors
> that might not be aware.
>
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
>     t/README: mention test files are make targets
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1701%2Fphil-blain%2Ftests-makefile-targets-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1701/phil-blain/tests-makefile-targets-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1701
>
>  t/README | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/t/README b/t/README
> index 621d3b8c095..71211109338 100644
> --- a/t/README
> +++ b/t/README
> @@ -32,6 +32,13 @@ the tests.
>      ok 2 - plain with GIT_WORK_TREE
>      ok 3 - plain bare
>  
> +t/Makefile defines a target for each test file, such that you can also use
> +shell pattern matching to run a subset of the tests:
> +
> +    make *checkout*
> +
> +will run all tests with 'checkout' in their filename.
> +
>  Since the tests all output TAP (see https://testanything.org) they can
>  be run with any TAP harness. Here's an example of parallel testing
>  powered by a recent version of prove(1):
>
> base-commit: 3e0d3cd5c7def4808247caf168e17f2bbf47892b
