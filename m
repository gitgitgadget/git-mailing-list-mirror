Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5A0390205
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 20:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781557053; cv=none; b=qKzVrQ8jweCtSKfp/+loITGKQx4DGCRLWDKxkCqd489S45aKVNsFhBdT5ZwGG1I/3OmYqHtyIDRd/mU31P+7ZwTJz5gslGtlY8MxZpeJS4MkW6pCo33J9jSy+pX+Uoj72PnrrTwvb4Z6bpRLVyc3mEA+g8WtMpVzo/m1lN76vmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781557053; c=relaxed/simple;
	bh=qNn8r8ah+30gMHOX9ka9JXMhbA4JjMWLnzzclF86qkA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n3O0/OgyAduolml/Q9gX+CTubJYM/3cdlHvsObCJPrjN8Sw02BDpWa8WibjhaF/mfcvssC0VO+ycVqegB92c8oquAKJXj+7HX/R0vbe0OhvqCE6MLcyvyxTS3rUU2VfphCTDlypYXLJAev8esov6w5Gfbjd91GeHUN4hl0eXcH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dajjuleF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bjj9tLgp; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dajjuleF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bjj9tLgp"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9A2377A00D1;
	Mon, 15 Jun 2026 16:57:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Mon, 15 Jun 2026 16:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781557050; x=1781643450; bh=WfZb0laZ+h
	FwC0KMvnBFcbaxvVZmkEongEnyI78P+Ik=; b=dajjuleFzO2Ka62cCpPMy9E8ZL
	Cg+wrXh2uzA+qDkBx679Mx7Cuq3vqXVYBpoAMyMlmbVouj2oeisFSK1v0klY0PtN
	aCaqsSV2Bgm2uw0pXhqnyKX2sGzUT1ftCn0yG3YHvlqinQJAmw4QlbBiq7OWXwKx
	k/pAk3yp0grPvoFIA57tR159ZguXqiVyTBXCWDVN1sQDrUjBkxv1HvG/jT6cttss
	AEQqCuLe8TlPgS1Kje8BMZPChtpYD3aQXLFHmTjIhJKjAWO1254g41LMooizOeAy
	XUr/qQhEtbiJzXk2mK76LR0eZMS3jIgJ1ou4uTsVsYVxkGiY6otpESblrh8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781557050; x=1781643450; bh=WfZb0laZ+hFwC0KMvnBFcbaxvVZmkEongEn
	yI78P+Ik=; b=bjj9tLgp54LVmXYDpZRRgX6l/JVS5K599S3jCkWx1esYKUeI+qA
	0r0CcORILWj7NrRczdymAFRED00ivvNB0NEskVJGcS1NXOrAARCI6f/UfgutCIFV
	UeohxEzu6sfLoQETmm8CjwmTSgBj4bCCJju/gAoCYzDfodXDlOk7RTXjTbWpYYQa
	yaTU5v6uc3qBYlVITmXHekSl/G4mgOW3zERQA/ZcaNAgyUoGlyxyE+U83FFDz8ji
	JGw8CKHIz/NljNMNWeGFjak7Po0F9mZ0og5ggfrc4ny/lwZFICOIPrKABLIjf24w
	Wzh7R3q8ySwbrM1+yj3PQfayLAsDb2gd4TA==
X-ME-Sender: <xms:OmcwatyXaPrPhwcaSvcrzasKSVsv8gplLzfhACse3zxjkja6rnv3-Q>
    <xme:OmcwavhUllzCyg2YgFSoK-WYIeqmUlW73zrXE9nCcaSzh0tJlnNOi_Qe6x07bl2lw
    FFxcHdopByGz2RRgLJVMDyDcnJL3BX5l7JMchvhPeZYM-KDnuO6-g>
X-ME-Received: <xmr:OmcwapnZPMym0qEmUHUvCUOmn6RCCjT21nH339A29Goyotr_fq1xhWk9BcMXQxuX_ByhnK_Buh9E03std8sJAZ71txjrhZK4zaSq>
X-ME-Proxy-Cause: dmFkZTGi/8E0e9Ld69RiIrWyy4MTWAKGN9gQA4eDTcbJf+CacUk/uGOpOUuiHks9i5mUx8
    8dw735aNfFdDVhOIPmbKC2RfXEDix6F7sAc9C8Syzai/vOW6IxRNCyAheQATI5RPl0vOdx
    yx2IERrSuCN+k6Dwp/G/yqcdmp/20s/2eQnq0fZv8mFKjQR1wpDUjmtkVXDXtQ0MvWtT3d
    TAOCL0YSSgXRpw0h04rikTa1x/RV6CVjITqGx1Q55YSXqh0Qs8wtzGz2t7o9/v9kxRFjBH
    7tv9/0WC9dg929ugDE7Q9ziaDDAdUSB/9cLUbl7PJYYayomED9uTkIovoYUv2GARUnZWWa
    uXmEYSYiD9/VipmVwnLTCgwMeYB3YgWncuA4ISN+p6+QXPx+nuyzxvUXNBDkOVf9DF/uCc
    Ke7d9IJvFuwcy4c7+bV4zHcE7WhXSq5tC9CuxrY81FEJCgmaQ0UZdV68K9jBS8tJNqos3P
    H4rlni1NnBCJsEDwZF7UFHjXHVsoWmCjLjJXsd2XBZDoWAJ+l4PsJcVqLFTPN03sE/A3Le
    9jbX9xv4lwyuEIFHc9/asm+xkm8A3ed6tJl+fbfCiz5apj+cJdh+y1XLeh1QsgLQGYuIhE
    3/zodBW1S1AA2kT2S75/+REM0Jg6ZRgnIr51NnPNsmaIi7RzJp1Q4KpOpaAA
X-ME-Proxy: <xmx:OmcwaliKI3fGYeFwE5fZNsO66ENxi-_Qy910fwtVUyRWnCn5x5LguQ>
    <xmx:Omcwat3LQcnhx79EvQIue-llfCnyQviMj2NWA-YbleU8BTvYu5aswg>
    <xmx:OmcwauK6NbaCoSBT9slT94xDNqam06EQpF89pXP9ASXAEEr3UNa2pQ>
    <xmx:Omcwatz5-ZIqBWzJJHakohmIKA0qPkHHrLJUcsTI-FR7LU7hV9_wjA>
    <xmx:OmcwashtoXSNKMbm7oRlRQeHO3c0J2GG8NDWogy8qHG8-xbx5nqG9STR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 16:57:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,
    Michael Montalbo <mmontalbo@gmail.com>,
    Derrick Stolee <stolee@gmail.com>,
    Jeff King <peff@peff.net>,
    Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 2/4] pack-objects: support reachability bitmaps with
 `--path-walk`
In-Reply-To: <ffad584a43ebf3cb2138e8dce7daef84ab72712f.1780438896.git.me@ttaylorr.com>
	(Taylor Blau's message of "Tue, 2 Jun 2026 18:21:47 -0400")
References: <cover.1779923907.git.me@ttaylorr.com>
	<cover.1780438896.git.me@ttaylorr.com>
	<ffad584a43ebf3cb2138e8dce7daef84ab72712f.1780438896.git.me@ttaylorr.com>
Date: Mon, 15 Jun 2026 13:57:28 -0700
Message-ID: <xmqqjyrzbjyf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
> index f693cb56691..69c5da1580a 100755
> --- a/t/t5310-pack-bitmaps.sh
> +++ b/t/t5310-pack-bitmaps.sh
> ...
> +		for reuse in true false
> +		do
> +			: >trace.txt &&
> +
> +			GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
> +			git -c pack.allowPackReuse=$reuse pack-objects \
> +				--stdout --revs --path-walk --use-bitmap-index \
> +				<in >out.pack &&
> +			grep "\"category\":\"bitmap\",\"key\":\"bitmap/hits\"" trace.txt &&

This gets flagged by updated test linter X-<.  Use test_grep to
pacify it.

