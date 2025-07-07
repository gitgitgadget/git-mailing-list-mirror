Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60442749C
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 16:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751904954; cv=none; b=KjXu2lZNJwK8LQ8VfhS7es91LjHU78szs5f/gOwIhZv75HvHDt5ZL3EzBt+249Dv++FO57gZEq3d6CslHjEoPD1+24OS2655Tal2mSnJVwUkEAhUOneNtAbaxRQr43WjJ2ZtTbYs2UC0Y6ZYNcO4N67d6BwauhCDPrdkXGb23sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751904954; c=relaxed/simple;
	bh=XCGLCIVadfGj3kK35GLVXsTCnx65tOY4BMlP48x+OvU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GqnBrfWteuVM7zumYJhwcOXyOU5okZU2GP2m90RtR3AMnlP8n7Z+MZpEX+gxCPJM4knhWZbTqKrZN0nSGapOQi5p4mco5jaMi87liW3q7/qQaTM9VQ79GLY7oxbJMKgGIDrPUoR8JA3AJpaVRidRJfZPER/eKprnTM0tzZOfGd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Clkyf/tx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a1A727s7; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Clkyf/tx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a1A727s7"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 5C2E91D0008E;
	Mon,  7 Jul 2025 12:15:51 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 07 Jul 2025 12:15:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1751904951;
	 x=1751991351; bh=yU8zFfkZxYyD1iwsR9gZm3TH/WVdsmovUeKNNsBWLkU=; b=
	Clkyf/txTX04XXgoyZI60Q8dbn96hg+BzNYRi/JrHDYidJWdc7p5oPZQX+HGQ7Vf
	LhoV6C+vkMyYVPUOglF0SC+xdcG07zgIzGFMs1O7FFnp721FnjMJwOau/pp/yznG
	WpXR6kzGDzpHQJcdJMXB+FmUTWgiLhcK1w0lX0/pDgJ+dLJTJ8PfQ9OtRR5vr1xh
	c6zGiO3W+b3QHE9R94zi1c63enKon6ScIFBiLX189apbzFWNn0LLXUngQq78WP1L
	SjhY93L9uORALgXduPgcRZ9Rc90A7tomQ0nQmKLRpeeD/Znr8Z51pFphxOtV5nox
	q4xdAMngXgN0LSQEKMmy/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751904951; x=
	1751991351; bh=yU8zFfkZxYyD1iwsR9gZm3TH/WVdsmovUeKNNsBWLkU=; b=a
	1A727s7zyc7VkYrtEmjZZgU6yzL2zbnicUpYBmq7CK3YufqQILf8rEbqV29qBdNi
	ela3ULfFev8RjL9OIwdgsJK5M3rFZN74hxn9SrH/sAlHVFqlfM/k8kzBiq3jfpo1
	dgRyBGN+qHZqs1RHW88ARIruuCgFKaJLcRasP+SKysiGEH6Yd4Rcvtqc65EBbzBi
	4ATGxjOutaAXk7NdwH3xUx38zSvbYqNmdIbnsnK3yBM0QFMKNu97DTRlzgBK+Faq
	Zf63vS8x+PbbPBeolDneJyCmpVVZzPuP3ohqB2FtqskNUGwXwEaGRJHIAVRHpNPT
	kZpTS1jm/54b0GgrISC0w==
X-ME-Sender: <xms:tvJraDdjOOcnGoKDT1pPzOKXOX3306NBANZxf-0MRDAU1Kxp18sPqA>
    <xme:tvJraDy2w7JjKJdO9G8Q7_W2_XDODVSId8V3IM5nmVaRouiWpWdPM7p2Szh4Ocnak
    X1z1991tlqzGzKKyg>
X-ME-Received: <xmr:tvJraJGNftOatojWvysp7vJ3uWDRU8SSkH7bXLWBOsZzt8hxqJRtoHC7UDma7eE0IAbCI1um3El-re4CL9IcS9WEQLnWyctHnNNtbps>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefvddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshiivgguvghrrdguvghvsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:t_JraHzC_6wtXLWjf4UfaNIaQQx0Kl70cxoEeujF8-QXukSgt8dS_g>
    <xmx:t_JraKuEh5JYfCRyzu0Ib-MbGf_RyEuUbfD5WwR84O_Av4K4Cx2RWg>
    <xmx:t_JraE0ydES2cPx47l-hhgH_r1Oxucg06XDHd-qdjI5kuaJ6plTv3g>
    <xmx:t_JraF9_08qnhiZ6LOLVXz0VnMksmqwr9B1xam9YaDqbbK_HTAVing>
    <xmx:t_JraJv6PpYH9gaxZ-3F7KgKlDD8EeG_9Qs7SymlLEpZfb-ySw7jFnCl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Jul 2025 12:15:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>
Subject: Re: [PATCH 2/2] t5333: fix missing terminator for sed(1) 's' command
In-Reply-To: <20250707-b4-pks-t-perlless-fixes-v1-2-92b2de1c3dd0@pks.im>
	(Patrick Steinhardt's message of "Mon, 07 Jul 2025 13:08:34 +0200")
References: <20250707-b4-pks-t-perlless-fixes-v1-0-92b2de1c3dd0@pks.im>
	<20250707-b4-pks-t-perlless-fixes-v1-2-92b2de1c3dd0@pks.im>
Date: Mon, 07 Jul 2025 09:15:49 -0700
Message-ID: <xmqqplec3rka.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Patrick Steinhardt <ps@pks.im> writes:

> In 6aec8d38fdd (t: refactor tests depending on Perl to print data,
> 2025-04-03) we have changed some of the tests in t4150 to use sed(1)
> instead of Perl. One of the conversions is broken though:
>
>     sed: -e expression #1, char 41: unterminated `s' command
>
> Curiously enough, the test itself still passes. This is caused by a
> sequence of failures:
>
>   1. The output of sed(1) is piped into git-update-ref(1), and because
>      sed(1) is the upstream command we don't notice that it fails.
>
>   2. git-update-ref(1) does not receive any input and thus won't create
>      any references.
>
>   3. We then repack the repository with the configured pseudo merges
>      pattern, but as we didn't create any references the pattern doesn't
>      match anything.
>
>   4. We use `test_pseudo_merges()` to compute the list of pseudo-merges
>      and write it into a file. This file is empty as there are none.
>
>   5. The loop over the pseudo-merges becomes a no-op.
>
>   6. The final test succeeds as well because the number of lines in an
>      empty file is obviously the same as the number of unique lines,
>      namely zero.
>
> Fix the issue by adding the terminating '|' to the sed(1) command.

OK.

> Furthermore, make the test a tiny bit more robust by not using it as
> part of a pipe.

While I do not think it would give us big enough improvement to
revert this part of the change, I would have liked not to see this
"furthermore" change.  We are not in the business of catching
segfault in 'sed' that is supplied by the platform, so there is no
point in breaking the pipeline here.

Will queue.  Thanks.

> Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/t5333-pseudo-merge-bitmaps.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t5333-pseudo-merge-bitmaps.sh b/t/t5333-pseudo-merge-bitmaps.sh
> index ba5ae6a00c9..1f7a5d82ee4 100755
> --- a/t/t5333-pseudo-merge-bitmaps.sh
> +++ b/t/t5333-pseudo-merge-bitmaps.sh
> @@ -234,8 +234,8 @@ test_expect_success 'pseudo-merge pattern with capture groups' '
>  			test_commit_bulk 16 &&
>  
>  			git rev-list HEAD~16.. >in &&
> -			sed "s|\(.*\)|create refs/remotes/$r/tags/\1 \1" in |
> -			git update-ref --stdin || return 1
> +			sed "s|\(.*\)|create refs/remotes/$r/tags/\1 \1|" in >refs &&
> +			git update-ref --stdin <refs || return 1
>  		done &&
>  
>  		git \
