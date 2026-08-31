Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAC83C1F
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 06:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788157209; cv=none; b=MqJrQRMrsorjpw2eX6VvN9Ola0ODe7ZaH7ox0RyFQSyJ/Bf6COoHI8yAflN/FBFcq1S1MXddzmW7Z9DInaOaviiGZRkUTZmNGEeBixCMr0a6OtzAdSH8nZDhjbDlJEYSHR/8+QET1GtlPal3bf/hDS9Jzhlve+zjzezBE4SGjz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788157209; c=relaxed/simple;
	bh=EXQYbISiEgtisZXp1JwuKlKYZDj/cY4N2OBIRmBAZ9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUren1SU6FbTdnPRlULzUnmbbhDHhXadyUDhN4Ic3+vywenWI8aAOEzgI/LNfP90Q3TgQKFCC0ytC/HXx2HHCWZJbpvEv/DF8XaQktWc2j7+fvHPdDtnBezLo56bBJqYdATyw1uJN3kZhLmoXRGZEqIKuKzxYcyqWL39RaIxobQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Nt3saEs7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D7STTF1h; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Nt3saEs7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D7STTF1h"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0FD047A0156;
	Mon, 31 Aug 2026 02:20:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 31 Aug 2026 02:20:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788157206; x=1788243606; bh=42rf/Gg7Hu
	h8MOnTn706zwTPsl1w3QuT9KasfWhUziM=; b=Nt3saEs7Au3IU+LwRpziIFz3VF
	Z6eGelRpITpyYZBm1e9VfQUEkyzzzph0rDhju/NOQqvYcODlqcTq1F9swhfAEA6C
	GwkBWpF/2bIf6C0hyVfy5DXVcdmQJd88Grb5Ihb5hgWDjktjT45wkS5WLhSeCykq
	jgb/yU1db3rWObs+NKgZ5IhlrsU146cMbj5e6bXVBTTGPoThzhMwSbKN1D5YEyPI
	oouAeCpc0CfZGdrbEBemd35yD/HVzvNuApP0lBeaXoR/Eo1y/V5+PwNVWMsMwZGe
	uGzlTG8M+z9VGrZ34OqzXRyi2NlWXGzkRKKySEX5EmMxRAMVtxAuMSG9ieig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788157206; x=1788243606; bh=42rf/Gg7Huh8MOnTn706zwTPsl1w3QuT9Ka
	sfWhUziM=; b=D7STTF1hFyESIwqumm5Tsj0Nm3ahN4WZoNbnF6A9ZpTQPxD1fuF
	HDYQpQikgZ514PQVb06oQBG4gfIs+D+ZqNnuGOPxu9WslRNDbvUFfnwy8QmAF0fx
	IoIcc69nswkFRxo03kkhwH6Tl4UGa55f8UalVQMIhrLz1KsMUJWbGhYcFmNg/iwk
	X96GK0DiqQ1PIPkLjTCZuTYMNU7bneBt3Q+RQb8vrg95AJu+GyheesZGetotNGq/
	tUep+9qQseH81qhX8NWhB5GcVkghzjz3XWdoWlUdRwjqsidHUBH8Xi5aRkTkwLNN
	1ZRr83qdjQqlCI+m/yT4B9qFtfw+WKQZZkg==
X-ME-Sender: <xms:Fh2Vajgaym8Uj0Ys7yN_bykffzZTDtCC_xdc5Vcx7ET3_Cky3weeYA>
    <xme:Fh2VanA6akuCaDOT2WXQXI0ijkjvTgi7FFBEZaKVHzcqVbpgUXoSGv0821jHeqOUg
    XHyEmFU4xBKsZdR5SHZQ6MmuphgtuZ3d0npmaQ1nEJiGCNS6eVcL8E>
X-ME-Received: <xmr:Fh2VaoGP5fk7eIfYDR70ME1O3fzkAekmvU3rjLUD4aZqaqpcHpA6ZK0Ir1Q8T-hH80_URA>
X-ME-Proxy-Cause: dmFkZTGbpAtIrR78AhuGEKMGdpL20ctYiAE6XpkO3lSePhmI7x78bC8FgQ+WsQrhH/Rg7s
    8fsrh/QnMEw39xn1j3SXBu+0sk070QYZWyOva5mtuR7QH4vyu1wLa7RuyLLAUaHZ3Sa+hb
    BxjHvadHpksPDPVfqaZDYTb4z8mbZlFofotMOpk1sJhPILeqHc591aAT9jyhgFciOVskth
    FKXzzv6JhoVDd0bWcn4xOyBRMnsJ7nA3+bJObFz6T0X7J9GeOhao34dJbh0o/d5SCqFW4g
    MsRawk1F67wWvhr1sOEZPVpIC/7rfBTLdL8GpOtUYkhi7Jkuyd610RHRjmMT3t+oFYv2Ei
    bElMGnJS8UemlTLhvYgJW0WJ1K/C9dlP7mdcGX1Son/XXxy6NeJtgo+luFq3jsVw3rZ0Gn
    Hh85wxQp2ZBcjDQLHCN+vtXFzOhuasTHFGagT5MmZEQSFTnf8LO9Q6JTxq01ln6/JkLssf
    Tfbsma59jkNpAXSQ8rhd6vNG2qSohURBB6Y3Z/Tzphnbtsx8A6xWKldG7GGsEnoJmsHP1H
    V1UAWabzKUwYsidh3jxcgOg9XLoXqC5dTgwX25TwfggDWCvctHikMo6O92zG9sUsT+562N
    kAtcdvGmNad4a8MbWErXkSJl6Epu3+yjyVo23tN+L8C0MsLg37D5XwT4Nusw
X-ME-Proxy: <xmx:Fh2VavINuKcvuZ6w9wyDwWIo7sxAWYNe3sUI6BgE4XVk-LcZJS4bog>
    <xmx:Fh2VasmRPirRa7mPBwp6kFCfM1Bl8U6sysUQw20UPtabEHmLkvv1Hw>
    <xmx:Fh2VanT2gDUi8CfUGxh_SwZPLsGkwp_I053nNMUzO1513MqmPUbp-Q>
    <xmx:Fh2VauI6MPh8xwUZMsLPBMIW_9i6nzKvnY5DPWKvHzSMjuevnNby4Q>
    <xmx:Fh2VagbazvpG-cXSQw5jDbCAVKYSSEC6rWjY7ouYqRBOrISsBNxNFHkQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 02:20:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ae83c3c0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Aug 2026 06:20:11 +0000 (UTC)
Date: Mon, 31 Aug 2026 08:19:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Nikolaus Schuetz via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	Nikolaus Schuetz <nikolauspschuetz@gmail.com>
Subject: Re: [PATCH v3] t1401: check symbolic-ref failure and --quiet silence
 on a non-symbolic ref
Message-ID: <apUdDyG98D5upbhj@pks.im>
References: <pull.2204.git.1786655554197.gitgitgadget@gmail.com>
 <pull.2204.v3.git.1787763107646.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2204.v3.git.1787763107646.gitgitgadget@gmail.com>

On Wed, Aug 26, 2026 at 04:51:47PM +0000, Nikolaus Schuetz via GitGitGadget wrote:
> From: Nikolaus Schuetz <nikolauspschuetz@gmail.com>
> 
> git-symbolic-ref(1) documents that reading a name that is not a
> symbolic ref fails, and that --quiet does so silently.  Tests such as
> t2020 and t5621 already rely on "symbolic-ref -q HEAD" failing on a
> detached HEAD, but none checks that the plain form reports the error
> or that --quiet stays silent.
> 
> Assert that a non-symbolic ref fails with the "is not a symbolic ref"
> message, and that --quiet fails with no output.  Use test_must_fail
> rather than pinning the exact exit codes, which are documented but not
> worth freezing in the test.

Documented sure, but the behaviour does not match the documentation:

  git symbolic-ref will exit with status 0 if the contents of the
  symbolic ref were printed correctly, with status 1 if the requested
  name is not a symbolic ref, or 128 if another error occurs.

So in theory we should always exit with 1 in case the refname is not a
symbolic reference, no matter whether the user passes "--quiet" or not.

Anyway, we're not asserting the current broken behaviour in the new
tests anymore, so I think that this version is good enough. Thanks!

Patrick
