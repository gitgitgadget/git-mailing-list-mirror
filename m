Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE92025D527
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 18:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775069789; cv=none; b=ujVpnXS/lEUMP+WUJZLZZPFiVEJpe1bvESdXzxPHfxG1uaD5Cli8S1BmprKFMWPF1OurrN6kNrkK2W0hkzB1Rj5NHIW2DCTa0CfHqTkAp76yZZB4+wGOfEyDaEw9OwM1G2+Yht3GjPXucw0a+cUf+51jbh4BCVI8yT+czJqvZi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775069789; c=relaxed/simple;
	bh=RZTfxE+1j2HoAt/pgsSnfRlpZbvmnRoA/lLT51w/fB4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mMc8VMBJnW09SysokecutAwcHT00u/q7AtBaIEp6eKyfxSABxZNxBffBI6iSKTnRtybRN27U6n+WAFjD3/zoK/Sjjp33UZkrirauKhu2mJpHSP2ktIIIn7msaxHKKYMJhmbKdaeAHFSLdGOqBjz1i/7/RSzKwOvnvGXr9qOAXzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CdcmcM6I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NOXmkrRp; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CdcmcM6I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NOXmkrRp"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id E41E91D001E2;
	Wed,  1 Apr 2026 14:56:26 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 01 Apr 2026 14:56:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775069786; x=1775156186; bh=qgXD/7ecY0
	6T1C7G1oWwFUM6D+U1rSfG2FQsW1S+oMw=; b=CdcmcM6IaS2RlCHPQ8yKkdPglz
	IXWc7MXA4ttnoIyOfQq9MBr4QGH4QyOPbzOO2QD6I1tBCs/mfAnAKsXHp2wHVxNv
	vjAaJBfHjli2f4Mc5/zMwVXrVcgXihtx6Mr8rQ82Mfb+P5IWe21jAvoUTdqqAlx9
	t871wPm1EF4tWU8Mmc/+l0VCgSK5IYvlUkwK/O5FHWzifVLQK/LZQU71JKeJh8o/
	LT7gMOBF+YDnl3H9tCS6px9ec78DYH/4kr/uytVNYiWVX1MDbfaGGKZQZKdM3keY
	rpO+cGBDKc9USPZkJrLXTwTSv3qsLoIspEvsuvIZ7qYaDfv4T55gyplzQVKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775069786; x=1775156186; bh=qgXD/7ecY06T1C7G1oWwFUM6D+U1rSfG2FQ
	sW1S+oMw=; b=NOXmkrRp6EKBmnOCNEoAagUdTJpaUZq0ouDlaK1qcHBiNPScZqf
	ZMZTPTKWVBGcK+xQtLTuILx13cPIQT8fJsGJ2tj2/3tu4716H6U3+CHdNwj9JdKN
	NGDusBFh1lPX3aBprlKgXWAGm9tc6sSsUtuVpHQaZaTnseD72mGV+A2TjhFXsMWM
	tqIfkaRP7q/rLdhXWZfmhKYm491wWcEXWpvAvDokif60AThxm0/e37SltZuRgzRa
	OjY+meC4dxvxLotvyjW1hUnsdXeHESWgqmtii/dh4TjKEXbBTXrLlAMsJvtDuU2g
	Zx1bVQVZHoMi63fJX6RGB3pe/BuIcKpuORw==
X-ME-Sender: <xms:WmrNaUHwAA-r6ub0bKtIDO1gjNW8wV9XnkNaUriBULshlRZNKTrRMA>
    <xme:WmrNafm1-hOwwegobcYi8mbrrFM4tsCi3tjMHDSJBFS1mZ1EAQh6nQSZtZ4CjaAcc
    xpGCto3lZTj7GQZoza4pdP1kPAFXueLe6WWAvZ3cKWRtELPxQn10Q>
X-ME-Received: <xmr:WmrNaQYNDVzK7v7E9hAW9VgNjZDReDxCGDV6AfZ6AYyVRZokxHV8SV9l9gRxFDxYR2ROfL8HwNW5vl6lUGEC7yNectEToflySg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtoheprhdrshhiugguhhgrrhhthhdrshhhrhhimhgrlhhisehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopegrsgguohgsnhhgrggusehgmhgrihhlrdgtohhmpdhrtghpthhtohepph
    hssehpkhhsrdhimhdprhgtphhtthhopegsvghntggvsehfvghrughinhgrnhguhidrtgho
    mhdprhgtphhtthhopehjohhhnhdrrgdrphgrshhsrghrohesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:WmrNacFdea8I_btx9Z5el6pnM7EGhAbXELpke0M2X0LpsHJjlVmUfw>
    <xmx:WmrNaZIlidT-7OSTd0gD4b52yvVOY5FP6lpnyw306vWDUuyXd7Q_SQ>
    <xmx:WmrNafOKC0dDWNzW0De9Ade94mFqbntLCE1hh2voH7CfUVONtH-ZxQ>
    <xmx:WmrNaRnXnuSZeStAw7bZ9f8TxfLfRz0zjnHGRDX1OVLLCqXDFCWmag>
    <xmx:WmrNadyvensVNpjLn7rtK5oUpIog5AYLp9XKhnaaAT5eJvPwZB7kQn3o>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Apr 2026 14:56:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Cc: git@vger.kernel.org,  abdobngad@gmail.com,  ps@pks.im,
  bence@ferdinandy.com,  john.a.passaro@gmail.com
Subject: Re: [PATCH] t7004: replace wc -l with modern test helpers
In-Reply-To: <20260401062029.54757-1-r.siddharth.shrimali@gmail.com>
	(Siddharth Shrimali's message of "Wed, 1 Apr 2026 11:50:29 +0530")
References: <20260401062029.54757-1-r.siddharth.shrimali@gmail.com>
Date: Wed, 01 Apr 2026 11:56:24 -0700
Message-ID: <xmqqldf6v7af.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Siddharth Shrimali <r.siddharth.shrimali@gmail.com> writes:

> Pipelines of the form "test $(git tag | wc -l) -eq 0" suppress git's
> exit code. This means a crash or unexpected failure from git tag would
> go undetected. Additionally, the use of $(...) creates a subshell for
> each check, which adds unnecessary overhead.
>
> Replace these patterns with test_must_be_empty and test_line_count.
> These helpers check the output of git directly from a file, ensuring
> git's exit code is captured properly via the preceding "&&" chain.
> They also provide better diagnostics on failure by printing the
> contents of the file when a check does not pass.
>
> Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
> ---
>  t/t7004-tag.sh | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)

They all look the result of good and mechanical transformation.
Will queue.

Some tests, however, may want to be cleaned up on top in a follow-up
patch.

For example, taking a look at this one:

>  test_expect_success 'trying to create a tag with a non-valid name should fail' '
> -	test $(git tag -l | wc -l) -eq 1 &&
> +	git tag -l >actual &&
> +	test_line_count = 1 actual &&
>  	test_must_fail git tag "" &&
>  	test_must_fail git tag .othertag &&
>  	test_must_fail git tag "other tag" &&
>  	test_must_fail git tag "othertag^" &&
>  	test_must_fail git tag "other~tag" &&
> -	test $(git tag -l | wc -l) -eq 1
> +	git tag -l >actual &&
> +	test_line_count = 1 actual
>  '

it is dubious to insist that we have a single tag at the beginning
of the test, as more tests can be added before this step, or some
tests may be retired before this step, changing the expected state
before we start this step.  As the test title says, all the tag
creation tests that we mark with test_must_fail are very relevant
to this one, but the last one that counts the existing tag again is
pointless, as it adds an unnecessary dependency on the state left by
previous tests (i.e., if we start with a single tag in the repository,
and we expect all the tag creation in this test fail, then we should
end up with a single tag in the repository---but this means that every
time a future change makes previous tests leave no tag or two or
more tags before this test runs, this test needs to be updated to
expect different number of tags).

I didn't bother looking at all the other tests outside what was
visible in the patch, so please do not just react on this comment
and update only this test.  If we were to make such a clean up that
is more than mechanical rewrite, it should be done with a better
understanding of the whole picture of the test script, not just what
I happened to have noticed within the context of this patch that
changed something unrelated (i.e., use of "| wc -l").

Thanks.
