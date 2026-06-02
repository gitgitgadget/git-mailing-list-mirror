Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CDB3EDAA0
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 14:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780409895; cv=none; b=PBHqK3/aqemvo5L5BDB0w+TWBPsHjyBlgNxDOtaHBULl+iOH+XtB8ef3Z6o31w5m73qK7c0ws3lCJQ7y17C4qC7dxJnS11995CHGmfh2+FCPOy+znm5tptx0MaEfQkt2ODBwrlEHzBVNSf7KODoAMV/fWSvwfp+8Pqr3aACoDoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780409895; c=relaxed/simple;
	bh=RJ8YFWuj8yAoAykJ/yzFxWl47SH9nr0RQbbVvH68g+4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R0gkl4QtwygV8WoX5kLqEignW9uAigWi1rG9YXUi/vCLRR/Dj5mdzVhwXyh3RJoZ3I0krBVbS28doP/27QPLJQb5xXn0w8BnByTXt2qUj0F8p1KoRy34U0w0l3mgS213WxeEwHZN2zMLGMB1Mx8drQ2CpZjv96NDsVKH1cy3v/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=L16p8Cv0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aJeav6J2; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="L16p8Cv0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aJeav6J2"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 70B111D00135;
	Tue,  2 Jun 2026 10:18:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 02 Jun 2026 10:18:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780409892; x=1780496292; bh=AqOSVSDzss
	PL2lZybuv5Ye86v1Qt+YWn0pU4yeptTRw=; b=L16p8Cv08xV8PCp4J6V7OKJEJZ
	j7/RJ4oSITs9LcysYnGJn1xdC8tssab4JMxO0QUDK24wdC+o8WcMv2bWM2GyE1/I
	4fjjfZmZSvCa5cIFs/JEmMynGIQau8G3nAneVo7wTaYSdAvpVYDeYsbI6nxdpL2L
	K03osMU74OtkrH7+JThBdRI6t4hhAzTo4RlwRUuLk+5tJCJeimfSJJqCIlm6QiT7
	esrGbuUo8UVbiAh/I8YNnKLnn1KNSjSGyPERLAxRtrS4UrqblxRaidjZG7jItW+z
	s7rVOx+503kQr0GF8PACPVAN2FxU5fup76Iv61HsVO1/5oHzIJHH+qAe4U7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780409892; x=1780496292; bh=AqOSVSDzssPL2lZybuv5Ye86v1Qt+YWn0pU
	4yeptTRw=; b=aJeav6J2005iGGowmDUlKKVRoAwQJFxzmX3NlBKvqTiEoeypugP
	5uP4y4p5vJiqpNk4o7vuaCqXtr203WWtjojsqPemAFLKi1w7XTb6m3NZc33bPHxn
	gouh1SJgUiNYRIFfhTkWZ5p+2cGJ36UKdu4cR9DO3Qf1/YT5SPjcUZmDp45Dr7Np
	Bty3O8Yt8+sXRj4JdaEncZQBd2WsBzvtv/hq2/fjUqiUMEM8yprlyhzFc1Q3xyNU
	P3MmDl974nxhM+g82VJ5UTUhXtWQGdq1Ib5xyjtBxvNz6MF79ww+KzOmlYnBH9Oc
	NFlF4QBEoDMOSw17QzdWGO5UM35MUo9dBBQ==
X-ME-Sender: <xms:JOYeasqSgs6E5SQ8IJSPckFsKV5OhlY6zpl4oaa4R62LPbi5Sqc4tw>
    <xme:JOYeapji3ta98osXGB9knQ_Th0YrVNDZVl1feNyhLyz1QFXkaqb4D2eds5pJTecqr
    Cu7WnI0_NKSyl9cIKfw7aV71f0elePajckDafD3dx1OTdAZZ_L80w0>
X-ME-Received: <xmr:JOYeapidrRMK2cAzrvFMvV-K0QBghBzMbyaVzkTuG2-Yz8duxpc4RR-QF1FbSoLAQiimpm8cT5l3M-TNL0S4BkBJNN8dpG4cAoNM>
X-ME-Proxy-Cause: dmFkZTEfS7GSL2H1XVck+yszvT1yfTG39W+CW1Lxi+jH/IYhz+qGsoD8pH4Q1kwMNgICSW
    fBZk+qjPJc9OnDXKMbf8FrP14HmjV8ttbUpr71w6mU+9TiyIO0l8w4xqC0rCZNcSJ9TkrG
    fJxyXEJckcvKG6UruZvStOamF52l5itee0s5cywA9oQp3G41nWBes/8jIi2zQwZAZOMDG2
    HIUgq/7As/w7fJfXEqWXxhn6/GdhpHjbsXmelikOA52X03ftPPu/xy/0djlHscHPT/6G4z
    Q82uSh6wBuj4ccCc5h4wxjrXnoUNeMuAkySkmr1UYMsv+ILoTGxlmkZCUsCKsQTRRegltA
    8wlH3sHq58uvWDDqhtmTFEzvUxrIn3ax3ZcU/lahgR54seTBLZAzDdiQeOVqK3MVpOTpQy
    5GSkdbl3m0CaaxdP+dosjDD6Vr/251I/oyQ7UY7YM29Q9dc5gwT6y9Bc7+H/cRFJ/Q9CMR
    cdhCRlAKP9KUVt7F0sjLMQ2TRKmE9fQ6nNkcQykoG27OJ8G52Y9VTrGuRAcF8bCpVuwKiM
    B4SVxw64PHCZ+NMyrR6MYzJiOWbC8mS+zYQh43EUlZqlGZ0HVbcEyirGITf7o4ahpeJvay
    EF+FbCN2sSXsMPv3UAdKWVN7H3TzobexXV/LsjxTfKYutpbSf45lVVGEt7dQ
X-ME-Proxy: <xmx:JOYeavjTQ_rPxqJw6Co8YC5cyZb6Nn70x36u1QYQoyuo6L5S-yHOCQ>
    <xmx:JOYeapLNBy05qn6iFm40p6zC8fT7L8SCBAx1q30tjnR8P0hAtKOkEA>
    <xmx:JOYeauEMmFGnkbJeSJnRvrxTU9MGayp0lCcyXMzrEPRnv0ufts7qUQ>
    <xmx:JOYeatTp9Kx0RFW24CEtX6WlO_a7zGbrebSAfvE1zz4lRGPsBptpCA>
    <xmx:JOYeaizc_YGKyOoi5n6dCVwJ2m6Om-Vm7XyzZ391pQMXYryPgaKO8zex>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 10:18:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v5 2/2] config: improve diagnostic for "set" with
 missing value
In-Reply-To: <e5a2070ee1598bc345556b4afd01ae6d40fab633.1780407557.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Tue, 02 Jun 2026
	13:39:17 +0000")
References: <pull.2302.v4.git.git.1779823288005.gitgitgadget@gmail.com>
	<pull.2302.v5.git.git.1780407557.gitgitgadget@gmail.com>
	<e5a2070ee1598bc345556b4afd01ae6d40fab633.1780407557.git.gitgitgadget@gmail.com>
Date: Tue, 02 Jun 2026 23:18:10 +0900
Message-ID: <xmqqfr35uiu5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> index 11fc976f3a..ed122d1100 100755
> --- a/t/t1300-config.sh
> +++ b/t/t1300-config.sh
> @@ -469,6 +469,61 @@ test_expect_success 'invalid key' '
>  	test_must_fail git config inval.2key blabla
>  '
>  
> +test_expect_success 'set with 1 arg of "key=value": valid key suggests split form' '
> +	test_must_fail git config set pull.rebase=false 2>err &&
> +	test_grep "missing value to set to the variable .pull\\.rebase=false." err &&
> +	test_grep "did you mean .git config set pull\\.rebase false." err
> +'

This is a syntax error of the command line, but the lhs of '=' makes
us suspect that the user may have meant to assign to that variable.
Makes perfect sense.

> +test_expect_success 'set with 1 arg of "key=value": implicit form suggests split form' '
> +	test_must_fail git config pull.rebase=false 2>err &&
> +	test_grep "missing value to set to the variable .pull\\.rebase=false." err &&
> +	test_grep "did you mean .git config set pull\\.rebase false." err
> +'

Ditto, the syntax may be an implicit "get" with bogus variable name,
or an implicit "set" with variable name and its value concatenated
into one argument with '='.  The message seems to be assuming the
latter, which is OK to me.

> +test_expect_success 'set with 1 arg of "key=value": invalid key does not suggest split form' '
> +	test_must_fail git config set foo=bar 2>err &&
> +	test_grep "missing value to set to a variable with an invalid name .foo=bar." err &&
> +	test_grep ! "did you mean" err
> +'

OK.

> +test_expect_success 'set with 1 arg: variable name starting with digit is invalid' '
> +	test_must_fail git config set foo.1bar=baz 2>err &&
> +	test_grep "missing value to set to a variable with an invalid name .foo\\.1bar=baz." err &&
> +	test_grep ! "did you mean" err
> +'

OK.  The above two should always give us the same error (except for
the actual bogus names given by the user to the command).

> +test_expect_success 'set with 1 arg: digit-led section name is valid' '
> +	test_must_fail git config set 1foo.bar=baz 2>err &&
> +	test_grep "missing value to set to the variable .1foo\\.bar=baz." err &&
> +	test_grep "did you mean .git config set 1foo\\.bar baz." err
> +'

OK.

> +test_expect_success 'set with 1 arg: subsection plus invalid variable name' '
> +	test_must_fail git config set foo.some.b_r=baz 2>err &&
> +	test_grep "missing value to set to a variable with an invalid name .foo\\.some\\.b_r=baz." err &&
> +	test_grep ! "did you mean" err
> +'

This is the third one that should be identical to earlier two that
gave a bogus variable name.

> +test_expect_success 'set with 1 arg of valid key reports missing value' '
> +	test_must_fail git config set pull.rebase 2>err &&
> +	test_grep "missing value to set to the variable .pull\\.rebase." err &&
> +	test_grep ! "did you mean" err
> +'

Did we see this already?  No, this is different from the earlier one
that had "=false".  This is a bog standard "you said set but did not
say what value to set to".  Good.

> +test_expect_success 'set with 2 args including "=" in invalid key does not suggest' '
> +	test_must_fail git config set pull.rebase=false true 2>err &&
> +	test_grep ! "did you mean" err
> +'

OK.  Do we want to see that the bogus variable name reported?

> +test_expect_success '"=" inside subsection is valid' '
> +	test_when_finished "rm -f subsection.cfg" &&
> +	git config set -f subsection.cfg foo.bar=baz.boo qux &&
> +	echo qux >expect &&
> +	git config get -f subsection.cfg foo.bar=baz.boo >actual &&
> +	test_cmp expect actual
> +'

Excellent.
