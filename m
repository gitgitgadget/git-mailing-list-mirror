Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8300C43D51E
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 08:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788768855; cv=none; b=qURtc1dFqWTUWaj+WrgYfflyJLCpiey8BNqyev8WSKXYBhLK8gvhsCCcVe84mAoMWPfV6B0UeMyRaWG6hW29pA+dABsGYPIXUumnTF8ytfsPz+NZBCkXm8pyej9577PXapC/c0w717DWO/H9mWV8o2nqBPXyoIChwNXoAWuJ+V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788768855; c=relaxed/simple;
	bh=xMAA5fJNGhnkFAklVjRL1XKpfOXuYXf73dfIVVF8H/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxFs+WpH2yTxraprs9jZdOlcS4LRzpn/Y+EWNw6h5ouEzFUMZf+1O/kgYMA8gt3ghi0Z6FWaPXefyPxnmXehPxsb+V+B9QGGC1fn81tMwGv/cSXq+WjJrApY3RmQDozqpw/8fmQMoO5aTEPmslDQFam6+ZLDk6CqC2V9HSzQO5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HT6xxJJh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DS9NCz90; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HT6xxJJh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DS9NCz90"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5A5F114001DE;
	Mon,  7 Sep 2026 04:14:13 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 07 Sep 2026 04:14:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788768853; x=1788855253; bh=2BANqiyIKb
	Y1rbQ9ZphqNR05/6Ts6Mg3c2J3hJ8FK14=; b=HT6xxJJh8154MaJAXa11BA8yb4
	rZimysMuKDNHTVHgfRLw2JvV61zyhTUEHWihcaKqeKb1H/yuLWDhgemGZgggvz4n
	ZMUfcFOjUJ/jXUG5eRmg/FBJfmWDcl9VaECSLsSCAuXKH0TkZul3I8FGntFfDSK/
	/YNNg2D1bt3k5L1fSWSZ379BVO7zC3VsPbAhdY+DeVvyn8es7+FokYUQ3b/LCAT3
	O1mPhRxUSPuU6eLNwOwi5a+/5NTqlnqF1fXWYSj495JXPJ6AOyqrYRzPcAooZQT4
	m5aR+zbtznMkDHX7WYeJzEBv2vRJSVjNjO5QOvdqEHUs6Ra0VRBsdAK/8UdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788768853; x=1788855253; bh=2BANqiyIKbY1rbQ9ZphqNR05/6Ts6Mg3c2J
	3hJ8FK14=; b=DS9NCz90qMW6L5OjPXWABzy/Jp4Kh96bZIBOL+HLhPx/LX7VGFe
	KRF+FzLm9M6h9GC1ukCHoIzJkuRX1h5NwvhsRLEXMsZQYThXjC7lWlNUzmUK0/oB
	8rZ0s2Uw23wn+RRtk7qIcPlxo45ysELuRV6yAo3+ixforALBaz8XMjpsvh8uHAjh
	ryZnOIwiNFGSD34OJeqQFP/R43+XG15vuCfvDPWHS4xuC1tR+ppwkHBOZ9cwzb72
	a7MDavhRIW3AFQbi/9PtToGmV+T1A0eX6p1peMzk5ckfxsHKqiW2ktQSpwrL+dWl
	fWXIdnna8nsOxaM4zQLMiC4AVWm1U4B7ynQ==
X-ME-Sender: <xms:VHKeaqsvBAKG6Sp3YWOSzPhiSjPvFE3s2L3l4T0Ah2_-fYCPSjO9Yw>
    <xme:VHKeaoxdLb5xp3gSVtlF7SVFd_MFmje-_BbXpswqzbJG0L9yNyq43zCX4_rdMATGU
    k8UKO1m-fYcuCDgWh70SeCph6Q-A3VJ5lEvBpj7F6EF9L_-c-iT>
X-ME-Received: <xmr:VHKeatBr4sZ66m4prIB9S8OmQSXt0E-0510T2QS-pKjHy2ttOGH3tQ>
X-ME-Proxy-Cause: dmFkZTEuDxWEFVPXKjjQlqUlDJ1t8NxWe/2y5zednXE80fnZrtD7msFqXRQTqY3RPW4P/X
    1DrH1hOT6DIqQ0n7novq3egSahQmIOphe/4ZyASFm2WxnOErn0usK9IBgPjEqxgmys7n4U
    J/1WAOVcvBQ70jEhctdPJO7vPz7AhAMvSYojUrJRN/OI8zqk8354KGIvuOWqc3F4EfeoGJ
    WQerx3YObOIx0HYPkMc7h56eZ8btKXkVG7uUz5ymPfeTOMPJ31ZAS0H7gxrAo0N6wEoQ6o
    5/mV8BXvmLkWhadca+2DTtntQtURa1sntdIo/dTdDsb1PFx/FCE6HOC2WNYIRUKIUMKNof
    KHCrBGuEfVDCL/Ezcp/OLb3WGwkUXF4PzgPkC1Fu0fHEwNnlzXzyIkPJtTpL0mvFPFuirc
    57ALi4HmrURj83kg+Z8a9t1vyfWE1waxnAzAOIA9PXqr54lSqfT5FWMb/EscUv14xkioyT
    mmfLw7jUfOrpC+Fk/0FUSpUkb8NGzJvAY6Yn4aHv14iXjpif3ApePYvCvUKszAD0izwh2j
    uhiF3u4C6z67pr0CZHdGWPa5h0NvzqEOYL2QwPg2Ui9OUW+iWkXXeLleSqkJ2I1jt1fSdt
    NWbSV2D+rvyj0rkHiy2++RVFdeq4kFFpygNb+Oega/6I+TSf2qKjcI33PPbg
X-ME-Proxy: <xmx:VHKeamfmNG4_CJT0S9A1PlONlhniJJgOH0Iou6SDcYhnerRjXWJSqg>
    <xmx:VHKeankagzqoKsFWIrf37sxIZ3WY9fkbH5X-EYpTZC1xtNXgYeYnWw>
    <xmx:VHKeatH_9AdPCT-9d7ks6z8QaJ_ig5b2xo61xutHuhJcGnBiSrgzeQ>
    <xmx:VHKeav6NFn-bANxCUMaHLaOu61npuNU5ft6tTV5zSawnd0cBRoKQag>
    <xmx:VXKeapQEjGXmTsOM8dGngtAxwBjPi8SOaSfUI8YJ_Zf6LOkKDAUaKXvR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 04:14:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 016d526b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Sep 2026 08:14:10 +0000 (UTC)
Date: Mon, 7 Sep 2026 10:14:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Thomas Bachem <mail@thomasbachem.com>
Subject: Re: [PATCH v2 1/3] config: add git_config_append_parameter()
Message-ID: <ap5yT0sOtLQQa4AY@pks.im>
References: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
 <pull.2217.v2.git.1788537086.gitgitgadget@gmail.com>
 <ef8087e80db18c511e31dd9c7dd6ea3d57dd543c.1788537086.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef8087e80db18c511e31dd9c7dd6ea3d57dd543c.1788537086.git.gitgitgadget@gmail.com>

On Fri, Sep 04, 2026 at 03:51:24PM +0000, Thomas Bachem via GitGitGadget wrote:
> From: Thomas Bachem <mail@thomasbachem.com>
> 
> Split the part of git_config_push_split_parameter() that formats one
> GIT_CONFIG_PARAMETERS entry into a helper that appends it to a strbuf,
> so that a caller can build a value for a child's environment without
> knowing the quoting. The sequencer is about to do that.

Readers who don't have any context around GIT_CONFIG_PARAMETERS and what
it does will have a bit of a hard time making much sense of this, I
think. It usually helps to give a sentence or two explaining what the
infra even does, and what this quoting looks like.

> Assisted-by: Claude Fable 5.1
> Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
> ---
>  config.c | 20 +++++++++++++-------
>  config.h | 10 ++++++++++
>  2 files changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/config.c b/config.c
> index d9019e7e6c..e0bb29b53d 100644
> --- a/config.c
> +++ b/config.c
> @@ -450,18 +450,24 @@ static int git_config_include(const char *var, const char *value,
>  	return ret;
>  }
>  
> +void git_config_append_parameter(struct strbuf *env, const char *key,

Nit: callling this `env` assumes a bit too much about what this buffer
is going to be used for. I'd have called it just `buf`.

> diff --git a/config.h b/config.h
> index b66dd08007..fcf48f6245 100644
> --- a/config.h
> +++ b/config.h
> @@ -22,6 +22,7 @@
>   */
>  
>  struct object_id;
> +struct strbuf;
>  
>  /* git_config_parse_key() returns these negated: */
>  #define CONFIG_INVALID_KEY 1
> @@ -186,6 +187,15 @@ int git_config_from_blob_oid(config_fn_t fn, const char *name,
>  			     enum config_scope scope);
>  void git_config_push_parameter(const char *text);
>  void git_config_push_env(const char *spec);
> +
> +/*
> + * Append `key=value` to the GIT_CONFIG_PARAMETERS value in `env`, quoted
> + * the way git_config_from_parameters() reads it, so that a child can be
> + * given configuration on top of what this process was given. A NULL
> + * `value` appends a boolean entry.
> + */
> +void git_config_append_parameter(struct strbuf *env, const char *key,
> +				 const char *value);

Pointing to that other function makes sense, but neither of the
functions documents the actual format that's used.

Patrick
