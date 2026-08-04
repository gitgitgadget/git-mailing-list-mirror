Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5923D88EC
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 12:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785848348; cv=none; b=CslWG+6snp1l+NWCHUVT1rcNOMSCPzHNPhwgrHlqbg64WbH6kh+GJBOOGQwFaN+IzJysYI+cXny2eOXwFQMZugBPcbb5nKChRtuuy4KKomTS9jyRu9vkd5EtYh2Q31C7LCo7COAMCVj7R5VO0UwQgy8bJ5r5bZbN39T3XMXESZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785848348; c=relaxed/simple;
	bh=xA7tl3c/pvrX/CeB+u1qQ+WURWy2NTY5Q0xULg/Nh+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lD/ekKzNWOZr62iCnyn4ki+A3FEPPam2/NgSb/Nrb1LAzET5EiVNrB4neIsvVXsRGO/4vAaW18Jb1XjF2Fd+MDfSa8bXZ2s48YOa1m5WWI3XoLnVOuuaz7a6ZL2Qs0li9NBwVzEVbisyBAMrRDCaRhhFOrS6MMweH9HX1IM0qYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RpGBX6rT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CQuM5kGy; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RpGBX6rT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CQuM5kGy"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2934E1400150;
	Tue,  4 Aug 2026 08:59:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 04 Aug 2026 08:59:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1785848344; x=1785934744; bh=McoTa4xtIp
	w1EWfc1/wkVa2dq/eQX03YEkSllYgk8jg=; b=RpGBX6rTK7KrW2YcyOIMIZxiZ7
	DqDjeQmEdXJqcyc+4wm3jweONE3hPKlIU83eFhe3toCcqtgpI8HEvefodfj15BFQ
	RUfP8R9ML5ghObAaezF+N4PB4HHTO6SObbbmrgykeMbRJqAoIUJuakpkWNRTs1d4
	UWm0PskrKTAYvOAWTUuuI6PA2f3gwJtOrqqsTAHNh4x2JShuGEJ/ZY94bAYJ/8dW
	BnBWY4/knSOcQKEE3vJ7K643PlFWaShOmYHynWfeYizPnFK2tFrsll+NbYcIkiYp
	4nRBfGCtumk6YGxPvQq+HnkndZ2bZ+S6PRtLgy2amspAX+ESBp6SCin6TTsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785848344; x=1785934744; bh=McoTa4xtIpw1EWfc1/wkVa2dq/eQX03YEkS
	llYgk8jg=; b=CQuM5kGy06PJm54Gqrff4rsUazEADQwMJVjSepVAGKysvaz08ZE
	SRz6umOkY4EJdtAQvzgyur7XAIHPyWQXzExMb46uhZuTWOPzb6YWPuRgJM9wepDI
	PUEx/9IPWiuOl4vobF9iQxQx4UVfhRwzsnXCy2IIFB6NGN+XnPPuf8xyYaQB2NGj
	nK+QjwNzi8sbAxZQp3YWcWrH1lvEtMIJDVGRDuR0S364yUz7qo1AX7d/ne4UGxk3
	ekuMDt0dJzUniTIfM7mVGhTizHVl/+q1Z4UZjC4fawbw9w1z59LTrPuGporPS6nE
	SV9X2Ehvt/6zXJkwwjw+BU3gIB7KxcDSbaw==
X-ME-Sender: <xms:F-Jxah4i9mhTZH4naXIAv28kyekmVSFI5jnmrMtVpdR-4eaKLDmIbw>
    <xme:F-Jxal47Sq6dr02n6ayR-s0dO5PNzNWgTrV9AcAxAwrmPni2sSCOid3TSz3Z6U3IY
    EDIa1bau4R1Kmhh61rCi75m2ea0chIAu6qnAa-wfnxtnL8M1p_reQQ>
X-ME-Received: <xmr:F-JxatfIg5Prsp1hOmjmw2DwGCV1KFw-fU5c6Y2fo-RnLwBchEmdtdORt3yPoKEUQkogMLnrUUntrck1PPtOFxONzDveASJ0K7QNAI9R>
X-ME-Proxy-Cause: dmFkZTEs/yOtuoRIMMZK+p8fqZCneEmB/xr3kqNBAs3xmlzeiupIc4jcaGMAo1mSj4Wf87
    2wyLBXU2KsmJZIXTaZT8/wS5/b5SasBPg7D41kZplUxlBb2B7iwl/rbw+QjxLKlHScCiJN
    xp3E8seU5JmckcfDLmWlNk7jgJ/R5y8ayCJ61V0lvPCWYggN6kKZ/+IvMkSX9rOHg5WbhW
    LPvgF07u9zopaZFiGOu2oDQkYFlUiDqZIxwW9vlRCOfT5rx26gNBSLQ6zJ5sulmkXPlm4A
    wAmEwygYE2Nmzte+xxAXYKZClEyeb6Z5VQd9d0ItVpEFtiDtVoTIqNf3MFBxaBeR87dNgk
    P469MtZr/eA68aYIpELs0V4rgaYscXzrsN+/mshjYVQiGi4sWJrbzLip7Lr4mwRzw4XlOZ
    WqH/4i6IJHW9olKq2nWNGRGsWnFx7fq5/WksLfLOKmwAOTQ80IL64qHcjW4mRliVAVTMjq
    jwny7uRfyR4DIAZ4LzW+YMm9HdvEEjPwh/b31HrILZGK9+0+2FWgwe4mEDC6Gf+/Oi3wbp
    BgfhW6ZEUNpf2v1vXQ6DPkAvUyxTFT11cX24kSMEp5UaGevZdvGqRKmB8/1jq9QSJ/9Ig5
    y2Inb5uJybfe8j2bnEfyEcJiRL8EZr8ltypuMBWHEzaCCly5lhBQa9w01ZLQ
X-ME-Proxy: <xmx:F-JxapC74abdYlJDQcia6aAtp95zbJOdUUWwjlExLCFiqcHq4cuySA>
    <xmx:F-Jxag9yoVLCTH8tYPW72lVv-1Uaerb5OkSi-eGICi_nPfgMQaWUzQ>
    <xmx:F-JxakJYobGqCTKDxhu_RHHs7LA7s4BfgPxuT6IaPYFWpShYPjnQUQ>
    <xmx:F-JxapjzwLfUJxwFf88oHKWIrKuSZZKXAXH1af0P4Apa6PS2YV2eOg>
    <xmx:GOJxam0aejRt_wQvlLAsvlpC7AtEnImRXE3WLMgHajk7w3qlHpqgZ2Vf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Aug 2026 08:59:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id eb59dbd1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Aug 2026 12:58:58 +0000 (UTC)
Date: Tue, 4 Aug 2026 14:58:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: David Lin <davidzylin@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, David Lin <davidlin@stripe.com>
Subject: Re: [PATCH] builtin/maintenance: accept "none" as a maintenance
 strategy
Message-ID: <anHiDzJbXUAgPRbO@pks.im>
References: <20260729194006.75317-1-davidlin@stripe.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729194006.75317-1-davidlin@stripe.com>

On Wed, Jul 29, 2026 at 03:40:06PM -0400, David Lin wrote:
> Commit d465be2327 (builtin/maintenance: don't silently ignore invalid
> strategy, 2025-10-24) changed scheduled maintenance to error on an
> unknown maintenance strategy instead of silently defaulting to the
> `none` strategy.
> 
> However, `parse_maintenance_strategy()` does not recognize `none`, so
> Git rejects a valid and documented strategy that can be used to override
> an existing strategy and disable maintenance tasks.

Oh, indeed.

> Accept `none` as a valid maintenance strategy and add tests to ensure
> it's accepted.

Makes sense. You can of course achieve the same thing by disabling
maintenance altogether, but it's a documented thing and users thus
rightfully expect the "none" strategy to exist.

> diff --git a/builtin/gc.c b/builtin/gc.c
> index 46999a99ab..3d1e39d46a 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -1922,6 +1922,8 @@ static const struct maintenance_strategy geometric_strategy = {
>  
>  static struct maintenance_strategy parse_maintenance_strategy(const char *name)
>  {
> +	if (!strcasecmp(name, "none"))
> +		return none_strategy;
>  	if (!strcasecmp(name, "incremental"))
>  		return incremental_strategy;
>  	if (!strcasecmp(name, "gc"))

Yup, looks obviously correct.

> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index a8d691719d..130c971b15 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -1022,6 +1022,9 @@ test_expect_success 'maintenance.strategy is respected' '
>  		test_must_fail git -c maintenance.strategy=unknown maintenance run 2>err &&
>  		test_grep "unknown maintenance strategy: .unknown." err &&
>  
> +		test_strategy none </dev/null &&
> +		test_strategy none --schedule=weekly </dev/null &&
> +
>  		test_strategy incremental <<-\EOF &&
>  		git pack-refs --all --prune
>  		git reflog expire --all

And test looks obviously correct to me, too.

So other than Junio's remark about the SOB this patch looks good to me.
Thanks!

Patrick
