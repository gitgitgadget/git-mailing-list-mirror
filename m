Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2FF41B8F7
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 07:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789112074; cv=none; b=DgdGe0hUDJfLYKyX1W19rJGnHz4v+8FCT+8zhn9G/YuTY1YsFWzY5DXOPrlbAC1ju3sNYX6m0pCRVztxgiG/NwlkncgBUuUlbTBzMGN2NLhQVYvmPMcgqxFxcKYXMQz5HO0PQmJ+Yfxh7eGf2FVeXmnXUt57nzseV5Z/Xnd318I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789112074; c=relaxed/simple;
	bh=4MjNvcDbRpWOKuOj5K5xAsNnnFS+NsWhXrz2MgE5rYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOAdf84jkVKZfsucqgtevCbMWUKro0G3Yz5HVZGHq4gEoYL/ND2ZxWoAGjWR5SxrMmosV2p2FXvi+yOtboxcBmxwpq0N7yNJf0nVetkxxf2dVtnHQDJTV+l1Q3b9kEh3TPvDFy9puZmG+d9CYOlo/bQeFhhINBh7roZg1YjfjAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lENRtxxW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H2s05CLN; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lENRtxxW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H2s05CLN"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 919867A00D9;
	Fri, 11 Sep 2026 03:34:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 11 Sep 2026 03:34:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1789112068; x=1789198468; bh=KB6j/bhWfv
	Qv22yKI3CG1VVNPk1kJP+TToOUPpiwUgw=; b=lENRtxxW1OzwksRVURIOZDLgU3
	YAq7ZhQwMIPJ8ZlL5wU6gmme69VBRweOJjebuih5VgrN4sDrsaipvF58M5sCAAP6
	9kvr08wmU527INr2RaPAhaEgo/Mtb+PDkXzpjlvuZeuMDXCKzkuOWK7z1KMiAkph
	7udkHlpJ9o3skG76EpaGeDO90OCUJMrK8x+iRf/VNfEQVJE4321vl3fbnqlX/gl8
	AoutUN7BDn3ZXvUfPUqSG/9Uea7iplLfb7/KsKgWLwFKt39VW27+JoIGY/UPSRPq
	+V/6Uj3NWzFELATxb1prl5rE/mGn2B+Hk4NONJpDgkc0MeBnQU7g9xM0iQEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789112068; x=1789198468; bh=KB6j/bhWfvQv22yKI3CG1VVNPk1kJP+TToO
	UPpiwUgw=; b=H2s05CLNiIeqEsSYEjsNKbRY7H6SB1niEhFsr7etXgTJUZdhLoS
	O1zmh5N6PB1kE4MARPcp68Tf5jedk74ghns8N1JpviNDLYtAxTzvsBhmLUgMn1zu
	4yDpqIdhqh3H3ZlbpoUcyCMlMQizEhgR8yDpWv7b3nLc+St6e3mAqqG/9EoNO/RR
	DKCtEmF6M86C7757Ikq6L3GZ/uc8zzK+FQGS93Ewu2ZHDNrKs0kyrU6InAUjyUZF
	4o05pwqQBDHLPcks1v20peolCXeGxClTer6UNJm49cpb/KrKFIhyFQif4R+NgWc4
	lGTogBocwnL5QN6d3PrFDHER7kkCDpd/yVQ==
X-ME-Sender: <xms:A6-jaipoorE8ey0BcJXMOud4hegDLdn26iLQ5gDGLSwJCR1ODMZ_og>
    <xme:A6-jaqozXXPpltgO-Mi2LnFrgaf7erk8jL4TnuqoLkcwmngA2zkvqrX7l8EziWv1i
    6l0X4YNaVcGJJAW_Qg2aAfg0tnS4uHmFMjMIdFeBfdmITyIH9HBUh9z>
X-ME-Received: <xmr:A6-jat1JEBA62vzZ-WqCsN9HiNhkpb_IGLEHJAzLY9DlmgKa1GhnWQxSRUMj-q2Waz-3_w>
X-ME-Proxy-Cause: dmFkZTE4V8SodkG/fUbJMIGgsv5LKmNcFE9Osgf07ttGEJRf55wMH5HdqAYF/EpYEyKjqs
    3sYzQoG/cEFbSp1zJtsroWxhYfy5UwIpnmvpSfD30IYJreLpWJIUd8FjnV74Z4J980903L
    B1/OVvGbKQThZ7yK70EEsxBj8b8VEC83qEHFMykmYNE+12a1I5iLhLVzH+JHuQQvCYMG+1
    /4mT907v3VcjjexYMkTlNsqMad8GBJboSZN0ZwUmCe0ZxDq/VEjZ8/XUN5zeBECX5+B/LV
    yDHaRUwnTH7mdn6xOaS25Lmza6NjxWiszQImWDrwZ+7LJ5K8M91CnvJUKtVXQ5f6yXg/Tf
    NP3Um7+NxqiBkwgCB6skgCJqF+NGy9d52Zonvt7qZmR2E8rKpcV/P3fyUqTi8PJMh9Q0CQ
    U2MoVxVtySClfRVpxKFQMM4qOWObD8P3CAIZkNrn8ffAT3sjqCAPc6gOarlmFi+OMmHHGJ
    22vSUNYnJ6KOkqmDEHY7q3h0pmFpMPrOJI0dvurycKESnflEPjVVcUnf1Q5wIwYxw78fu+
    ggEIuboVue2cp6haVWaHuG/oa15DfHLyf0rHZOTS7+q/YfaTmoTeURgnHuER3Z9scAczMp
    8SI1T4uq1bDGlGR+cMFR8QgdbzCukP3xytHe5djaBEdv6TYhrd3wCXPMpIyQ
X-ME-Proxy: <xmx:A6-jagH_vxerAoRn_-jCgYtwrWOrX_vB9iR6iFUSTrIL2aQzWa3NPQ>
    <xmx:A6-jagHKiREjZipJhT6h5nwUaRAP4fs4OIcLh83w9OqU8yuwjx6RNw>
    <xmx:A6-jar7Ix4yrFySG7e9vXmlHvTyl-UlRDnFYycRR8VF85BQEfhSmKA>
    <xmx:A6-jatwBscmU6VpXTLGq-zHbZ4ylB3RBdPCW08CdqsfWVleOunKiyA>
    <xmx:BK-jau5pdIrYYO7QIktRH5IJPYT-mAOquNnSRjQHOOIp1tMa5GorPcyx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 03:34:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 44d8f8ee (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Sep 2026 07:34:24 +0000 (UTC)
Date: Fri, 11 Sep 2026 09:34:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Thomas Bachem <mail@thomasbachem.com>
Subject: Re: [PATCH v4 1/3] config: add git_config_append_parameter()
Message-ID: <aqOu-dvjAkkqx2Sr@pks.im>
References: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
 <pull.2217.v4.git.1788942331.gitgitgadget@gmail.com>
 <0472fadbc564fb724e2cb14f306c1c29ed42ef40.1788942331.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0472fadbc564fb724e2cb14f306c1c29ed42ef40.1788942331.git.gitgitgadget@gmail.com>

On Wed, Sep 09, 2026 at 08:25:29AM +0000, Thomas Bachem via GitGitGadget wrote:
> From: Thomas Bachem <mail@thomasbachem.com>
> 
> "git -c" passes its settings to the commands it spawns through
> GIT_CONFIG_PARAMETERS, a list of quoted 'key'='value' pairs. The only
> place that formats such an entry is git_config_push_split_parameter(),
> which writes straight into our own environment.
> 
> Split the formatting out into git_config_append_parameter(), which
> appends one entry to a strbuf, so that a caller can build the value
> for a child's environment. The sequencer will use it in a later
> commit.

Thanks, this commit message is much better now.

> diff --git a/config.h b/config.h
> index b66dd08007..838d1509a9 100644
> --- a/config.h
> +++ b/config.h
> @@ -186,6 +187,18 @@ int git_config_from_blob_oid(config_fn_t fn, const char *name,
>  			     enum config_scope scope);
>  void git_config_push_parameter(const char *text);
>  void git_config_push_env(const char *spec);
> +
> +/*
> + * Append a "-c key=value" setting to a GIT_CONFIG_PARAMETERS value in
> + * `env`. The variable carries such settings from a git process to the
> + * git commands it spawns, as a space separated list of 'key'='value'
> + * pairs with both sides single quoted, which git_config_from_parameters()
> + * reads back. A NULL `value` appends 'key'= with nothing after the equals
> + * sign, which stands for a boolean true, like "-c key" on the command
> + * line.
> + */

Nit: this is not necessarily specific to "-c key=value", and your later
patches in fact add sites where that is not the source. Proposal:

  Append a config option to the buffer that can be exported via the
  GIT_CONFIG_PARAMETERS environment variable, which allows us to
  propagate configuration across Git processes. The format of the
  variable is a space-separated list of quoted "'<key>'='<value>'"
  pairs.

Patrick
