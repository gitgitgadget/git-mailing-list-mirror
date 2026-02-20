Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1A7344054
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 12:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771591593; cv=none; b=OhsVeRapQjJDPJHSeM/roxctuFNsFmy8EV1nmPRDOshaiTn4ZVmTnoXdOhet7JkDhCFLh/y+XcGfRjl6Fc/EHofsb1O5G09rMS4YlIz/xuFjxmoHOuc1gsn6dlEzFUbTaxrN986tX4fTd4GA5acx6J3YdzkbFWf3A4OAEARANw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771591593; c=relaxed/simple;
	bh=dWsuZKUJalm04FGCoYikeXmqlaBDeW+mAlP1ezH0bsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUp29gNljuNBhpY8RYbIVum/HegBfBcCqdKmbIpwLJ5kwd0BqhSv2bw0DNa2MFUY8xzozMfz5KNRF9yPSfpjaf1yqz7c514jtorupJ4YIQsz8rkqL8qf/5+sXTDl0by7fPnfV6LIMZts/lkkxm1QRfnttt5ZWULbpZhmwl8xlmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Tv7sVS3l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IAcIOlPN; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Tv7sVS3l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IAcIOlPN"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 413171D001E8;
	Fri, 20 Feb 2026 07:46:31 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 20 Feb 2026 07:46:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771591591; x=1771677991; bh=TBd1x9AOMJ
	wO25IyO2iFU3GTUX8gJhaaatExczGmTUQ=; b=Tv7sVS3l5Dk2Bzh3egp2raRm0+
	0crMP2HZviS/9JeHNSD6FY6S0Vs44mqJVXCfuBoyzzi3519BB+arDkSg2Mi8+epS
	XUQOR+gNDU0NclYjgd0hfpS9vYOm9VNOnVTTgNlUMlgOXdvyV7EtraQwAQXnrx2Q
	T4pRXcTMskYyhhOlBIIbSZgDkBIvcwvvkxsg2X1L9hHK/CLXKmdFIYwiaVP4diNi
	OkovG1uYU5dyHnHWypNiD7nEdKZE3DQN4c4lJp4QxEEXrD6o0+zdYO/rwetq6rK4
	Ov+0qYBBdoUEOSLKXuVkKgzFPTy+lHuyU5nVktzSRa87CzlXqkZuCkd3flnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771591591; x=1771677991; bh=TBd1x9AOMJwO25IyO2iFU3GTUX8gJhaaatE
	xczGmTUQ=; b=IAcIOlPNgQ55/hWzcMW8ePcuJ5dJtZRjbrlVTQfD/rWwcyFh5zV
	w+hz/NZw9eMEjMBIeU+XHNuIfg+qG7dF6Kj64lsYQ1bfMHbwWMi1HqNifR/iFgpi
	nwI4aT1sMOEAdIRiSodP6+Ll4PGfDkKFHdrEkWDrB7SgBq6IwKbYcVhwYMZEb3dK
	AG0RyJ/cj3x4kvlL3gmEWz1WdAgpeBj3Kzo5WjpWGiqxX21ZYxBYO8uD0hd7RBKo
	d702LYPZkwnmbdBRMw571yzwRukGhm8GTJM991zaHKcc6yNpZvMvf/Nq6NEfkUt1
	5Hqr1WAfrZf8AYo5+ohnJFfRkaQW5yNYCsw==
X-ME-Sender: <xms:p1eYaZn0ZJXZ2FQ_dmHyfnXebNY5Ris2ClH1xhMOOuVyX6BAGKu2DA>
    <xme:p1eYaXGfl3kSWeEtUL4k8XcIfViwMxhw2xPkwG0dPXdLYraVbqoMhpDT0-cAtWeUf
    0cxg7FawtbIUSTY_0-Z6nXVeLvChUt26ifwqZtI6Ra03ie1Htvjbg>
X-ME-Received: <xmr:p1eYaR5FPuSEh8GshLnNGHJnsMKw0gO-mKxA2J1sr62T5UT4NPZLWOODjdrp0Z5j1iitgv6-2owsqUEaPsRKWq9ZCF05c95kafaQQsOYKJXx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdekgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegrughrihgrnhdrrhgrthhiuh
    estgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopehsthgvrggumhhonhesghhoohhg
    lhgvrdgtohhmpdhrtghpthhtohepvghmihhlhihshhgrfhhfvghrsehgohhoghhlvgdrtg
    homhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:p1eYafnP82rDt_G8krV4RotwCx4NR3ABTXLdwt0mcgZFLnOh0enI4A>
    <xmx:p1eYaWoX6oVjlebugeOWFt6IfzYtea92oUt6hjvFWClPX0vW9jFJgw>
    <xmx:p1eYaeuTuinRb5-ad_L6-WLhYmHTQ2wQEYMS1q--jDLwQTPZMB4cTA>
    <xmx:p1eYabF41P-HgupDd53GfGyjlfQSYViIbT5DCfcilz-Bkd7wTbJxOw>
    <xmx:p1eYaT5OiZrh4-StWGOppur46pBjAdvRTpGqkRNrk12cwnTM6BC3kcQr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 07:46:29 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d2f89072 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Feb 2026 12:46:28 +0000 (UTC)
Date: Fri, 20 Feb 2026 13:46:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2 5/8] hook: allow disabling config hooks
Message-ID: <aZhXom2cD8juWYs4@pks.im>
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
 <20260218222352.55393-1-adrian.ratiu@collabora.com>
 <20260218222352.55393-6-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218222352.55393-6-adrian.ratiu@collabora.com>

On Thu, Feb 19, 2026 at 12:23:49AM +0200, Adrian Ratiu wrote:
> diff --git a/Documentation/config/hook.adoc b/Documentation/config/hook.adoc
> index 9faafe3016..0cda4745a6 100644
> --- a/Documentation/config/hook.adoc
> +++ b/Documentation/config/hook.adoc
> @@ -13,3 +13,10 @@ hook.<name>.event::
>  	specified event, the associated `hook.<name>.command` is executed.
>  	This is a multi-valued key. To run `hook.<name>` on multiple
>  	events, specify the key more than once. See linkgit:git-hook[1].
> +
> +hook.<name>.enabled::
> +	Whether the hook `hook.<name>` is enabled. Defaults to `true`.
> +	Set to `false` to disable the hook without removing its
> +	configuration. This is particularly useful when a hook is defined
> +	in a system or global config file and needs to be disabled for a
> +	specific repository. See linkgit:git-hook[1].

Nice.

> diff --git a/hook.c b/hook.c
> index 8a9b405f76..35c24bf33d 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -164,6 +164,21 @@ static int hook_config_lookup_all(const char *key, const char *value,
>  		char *old = strmap_put(&data->commands, hook_name,
>  				       xstrdup(value));
>  		free(old);
> +	} else if (!strcmp(subkey, "enabled")) {
> +		switch (git_parse_maybe_bool(value)) {
> +		case 0: /* disabled */
> +			if (!unsorted_string_list_lookup(&data->disabled_hooks,
> +							 hook_name))
> +				string_list_append(&data->disabled_hooks,
> +						   hook_name);
> +			break;
> +		case 1: /* enabled: undo a prior disabled entry */
> +			unsorted_string_list_remove(&data->disabled_hooks,
> +						    hook_name);
> +			break;
> +		default:
> +			break; /* ignore unrecognised values */
> +		}
>  	}

Somewhat similar to my preceding questions: why don't we store the
enabled state in the `struct hook` structure itself? Like that we can
for example even list disabled hooks in `git hooks list --disabled`, if
we ever wanted to do something like that.

Patrick
