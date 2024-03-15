Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3597456745
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 21:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710538939; cv=none; b=Hpsnnjl1wpaDT0tjUWAuqq7G/C3f8nsCqw5hQUHz4g5T5HeeBT/lCGNAc/ouqW3CDgkq8h7gxcVC2cRQrNALJWEMUivnvXqjXU/5pU0w8vVeGBSjG2wflPAnQdSM8phTizZXHx3m04O5fa2tKvHvKmXn36BIE7awmvyRoGo/QOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710538939; c=relaxed/simple;
	bh=i2IOrrJLTWf/6ULVm8rbx+lITn/lPhAmF/woEpDaalg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Z02LLTYVA3eYlzisC6wiLWZ7Cw7mfOfyVVwQfUZljOoSeiPeY1uKgSWy5UB6lfgtb2STylrIdW6An9ZcrLJYebRuwI9DqmP40B4+EdnUYvWYmtllfwN3SdjfyR2KELThxD5/jUGE7PX6cyICHXmpeQtZ9USxAuWzKCuXkR7S3Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=bh8NNn/E; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="bh8NNn/E"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710538932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rEgjt4kX4pypEFYpW+p1/YEENpuN0yLAFzddjSvzeLc=;
	b=bh8NNn/EkefohVM9E9OqEK1l6uUubm0LNj8eay0rumcNzHf/4jjshRQxKKezslVBe5kUEY
	YQK78Qyfu7Wp40M59COAd6IEjYAfpEYqGezIhGjIZKTgw0/XOrqOeDVUXGPzRa1WJvqLp3
	Dj186yC+AE56Y0fdOQIiaiyEgbe89yU7gy5Hz4w+fYwDN/W2QQS6pfy6k4Gxi1KhpNGmlk
	aCxW2eUUjBxqffbCVt3q5LN5PaiVOK+dpLVDGUFRzTklAlQYIpvTOzlOTe/D+YMplYTRq/
	m8Eyj9l5kUnFLD+WTl34j6ApeUTLVTCO6IRVNc8LA8v/XPpIbdbx/0fLbGYKpw==
Date: Fri, 15 Mar 2024 22:42:11 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, gitster@pobox.com, rsbecker@nexbridge.com,
 github@seichter.de
Subject: Re: [PATCH 3/4] t1300: add more tests for whitespace and inline
 comments
In-Reply-To: <CAPig+cRG8eFxepkaiN54H+fa7D=rFGsmEHdvTP+HSSaLO_6T_A@mail.gmail.com>
References: <cover.1710508691.git.dsimic@manjaro.org>
 <590731e15a01558d1bbcdfc01df4f78573138742.1710508691.git.dsimic@manjaro.org>
 <CAPig+cRMPNExbG34xJ0w5npUc3DDwxQUGS_AQfam_mi4s53=sA@mail.gmail.com>
 <CAPig+cRG8eFxepkaiN54H+fa7D=rFGsmEHdvTP+HSSaLO_6T_A@mail.gmail.com>
Message-ID: <ac99ea0a24c257eab8f29466589b6eef@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-15 21:29, Eric Sunshine wrote:
> On Fri, Mar 15, 2024 at 3:39 PM Eric Sunshine <sunshine@sunshineco.com> 
> wrote:
>> These days we try to place all test-related code inside a
>> test_expect_success() context rather than having it standalone. In
>> this case, since the file being created is (presumably) shared by
>> multiple tests in this script, you may want to add a new test which
>> performs this setup step.
>> 
>> Taking all the above into account, perhaps:
>> 
>>     test_expect_success 'setup whitespace' '
>>         q_to_tab >.git/config <<-\EOF
>>         [section]
>>         solid = rock
>>         sparse = bigQblue
>>         ...
>>         EOF
>> 
>> Same comments apply to rest of patch.
> 
> To be clear, this case is special because the file being created is
> shared by multiple tests, so it deserves being placed in its own
> test_expect_success() invocation.
> 
> For the remaining cases where you're doing some set-up outside of
> test_expect_success(), just move the set-up code into the
> corresponding test_expect_success() invocation. For instance, rather
> than:
> 
>     echo 'big               blue' > expect
> 
>     test_expect_success 'internal whitespace' '
>         git config --get section.sparse > output &&
>         test_cmp expect output
>     '
> 
> do this:
> 
>     test_expect_success 'internal whitespace' '
>         echo 'bigQblue' | q_to_tab >expect
>         git config --get section.sparse >actual &&
>         test_cmp expect actual
>     '
> 
> (I changed "output" to "actual" above since the names "expect" and
> "actual" are common in the tests.)

This looks nice, thanks again.  It keeps the expected results and
the test execution in a single "block", making it a bit easier to
keep track of different tests and their expected results.
