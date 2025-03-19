Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E7E1A841C
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 16:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742400055; cv=none; b=ECsxpM4UnBvsZgE/B910DkglVICB7SdRuLleM5lycfeTpqOyuWIj1WpubxCWLF0kTISSBa0TCLxTQ7EseEj2RHV/B5g14HIkRiQD0XuVw9r8tZJAWW/VkCs+WZaEYDqVhbCfIa6ZJb06vcNzUeDSQDWt4ecOBTr8TlXbb33nxmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742400055; c=relaxed/simple;
	bh=fkf36JbI2gMikwgSdbb/C6C0oeOHREEE9UOJGuGoK/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8fl63SCKEe33Bnf5yh0HqNWFxwqKHL2NSG/matcpezWIpikDFfFgGz4dgRlfXe9LgIZgvISsU4QmYMaC7qV9EIWC/wI69xt8cO9MwzQhvpbd4/NuKNrJ/WRXuOOSwse2+aG2439lez5Xgi5wzogPK/kePwshuN9fWaBsENu4fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=C6Rh9nVA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gH0TIY4C; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="C6Rh9nVA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gH0TIY4C"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D4AF72540239;
	Wed, 19 Mar 2025 12:00:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 19 Mar 2025 12:00:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1742400051; x=1742486451; bh=aqRxaqleVk
	ZcFFaUqmT+uIUb4hJdE1TLb5uXwyQ8n8w=; b=C6Rh9nVAuUIgm5ERNkP50xZcxK
	T1BMcF13iniL1ErNYMyJIrP+Exs9CcExh4OKj0PLawdot5nRxAoI/lFCia6dFYqT
	IxOSMmuJLl1bBnbxbn3Eme8cu3YZYTUvfXVxLqnXz0sXwpb0sPSEZlZ4BenuCvJ5
	imqbYNjtcREnUFkTDvIbFbXDjtZyu49yAYcudRNYGzp7q8SBrJzbGla7sPXsBELM
	gzmw+3uW3SX5y7Y+D4amDkUOw9+WthOPVinPuD1eaewvqFn41kNZjbPCuHG4QjYI
	EAA5GNhy6iifZmFCDvH7/fUpOIy4qxFyZCsfbHTKcuzzbNOeBpAEKN3RIlGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742400051; x=1742486451; bh=aqRxaqleVkZcFFaUqmT+uIUb4hJdE1TLb5u
	XwyQ8n8w=; b=gH0TIY4CvsgX7T6RNkwoL135eBU1zsPf3FFwlg/5+eXceVL8Y07
	Qvgmwljg0NEUH2XjrS7RYQBL5qP6AlpFYOEh1mzDX2FlVe9DozIQRBbxiKH2ue0E
	NTgXsyTMEZ5Ca72aqXacijkgv5tkM+PDq5kfHcjD7SJyW6hmfpqRMEZegknrjIWG
	v8o9xv5pgDDgqjTKLWiMQ34XQA0fwN6J0Fvc6Rnvja/2D20FPomZsVcnqzogZI9x
	jSTpQgv0p3YksrIhav+/WRpTqNybuplzqB8mTVo5WvWD2D2SspluKK+RFyUKg7Z0
	N8Dn75ZRVq2yON6u+eNnHJXnXRm9YWP7H9g==
X-ME-Sender: <xms:M-raZ8l3fHlDFJfpPzarooxrbWkNApnLVdkXwMXsp5LPFFtWhqlvJA>
    <xme:M-raZ72y35B948xhEZk0oDJR8WGCUKqFUT5A-mcJ_Ik2lgFAkxpkzx4Y-gv-CGBv7
    m91rROPQezeOMkKvQ>
X-ME-Received: <xmr:M-raZ6pAcU0qCucSat3hqolMy4RuOj_YtipTjYnFslBTv7OCA7CtSCOAxnKnpLxlMBgKnMjOkIkWRFqsymRumjmn22Jk1VUbrlu7rMN9t_57VrY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeehjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtph
    htthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:M-raZ4mw7AZu-dfxWZ4vsI4XIGToNH9rzqZMIOIJ2oXAGEf02sxofw>
    <xmx:M-raZ60E8mHkboX36aP-w0uJGHi26UzqJJM76UUIwWcHaaURu1fhNQ>
    <xmx:M-raZ_sHovprKJUYEBvGx3NqPylIgSjMn3nRmUb3cs08ZICNCkD8TQ>
    <xmx:M-raZ2V5KsItXZfOeH0Ku-iKj3gxUumig3AO3NU-J8rjpBrHJd4eXw>
    <xmx:M-raZ9TvaQT-l2RMjxgWeM_3fzTtH-77or4UlbpLTMHTN1tMOhsRQUGi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Mar 2025 12:00:50 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 88c8f854 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Mar 2025 16:00:48 +0000 (UTC)
Date: Wed, 19 Mar 2025 17:00:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/3] http.c: introduce `set_long_from_env()` for
 convenience
Message-ID: <Z9rqK8QSs2dA7t6S@pks.im>
References: <cover.1742336481.git.me@ttaylorr.com>
 <ba22a121fa699e490de00eba988552b6c10fe2fd.1742336481.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba22a121fa699e490de00eba988552b6c10fe2fd.1742336481.git.me@ttaylorr.com>

On Tue, Mar 18, 2025 at 06:21:34PM -0400, Taylor Blau wrote:
> In 7059cd99fc (http_init(): Fix config file parsing, 2009-03-09), http.c
> gained a new "set_from_env()" function as a convenience function around
> conditionally assigning an environment variable to some variable if and
> only if the environment variable was set to begin with.
> 
> But prior to 7059cd99fc, there were two spots which need to first
> strtol() whatever is set in the environment before assigning it to a
> long pointer. Both instances stored the result of getenv() in a
> temporary variable, and conditionally strtol() it depending on whether
> or not getenv() returned NULL.
> 
> Replace those two instances with a new cousin of 'set_from_env()' called
> 'set_long_from_env()', which does what its name suggests. This allows us
> to remove the temporary variables and clean up some minor code
> duplication. More importantly, however, it prepares us for a future
> commit which will introduce more instances of assigning an environment
> variable to a long.

Okay, makes sense.

> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  http.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/http.c b/http.c
> index 0c9a872809..be564fd520 100644
> --- a/http.c
> +++ b/http.c
> @@ -1256,10 +1256,15 @@ static void set_from_env(char **var, const char *envname)
>  	}
>  }
>  
> +static void set_long_from_env(long *var, const char *envname)
> +{
> +	const char *val = getenv(envname);
> +	if (val)
> +		*var = strtol(val, NULL, 10);
> +}

Hm. We don't perform any error checking at all for whether or not the
value of the environment variable is a valid integer. This isn't a new
issue introduced by your patch, but now that we have a central place
where it's being parsed I wonder whether we should be checking for
errors?

Patrick
