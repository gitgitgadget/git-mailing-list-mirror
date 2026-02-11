Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076163126B2
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 12:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770812006; cv=none; b=NJbuUoQqX30k/02NMR1CoulnwrL98oQhLTblOAZovBI20tNMhMrIrGm5y7e4ywDjk5JMJIVsQFQWKlMB6QZsmFdFeUWs5bRNcRmB4sfF1M014eAu6I+t4pyE6ME1KHP20vGSn6XI02OLycP+WvSP5gFE7zbBcXk6hZ2AjN2utX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770812006; c=relaxed/simple;
	bh=5vrzWK/XSDYyPSoPlclE/QCNcDYherXIpjRVp8q7lrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fiYDOfdJp2ge79nynOALxKhA+PLL86kkB4IH0QFxUFa40FSOSxAf4CkbZnYHWByE2y1iywuO3Xe9YWOQZX7PwaAowarhxJaq6pfjEjOzExLX9MFHYuEW5wtx90SLPsPi+MlNloYsL6rqjhjE3j7iAI37nu7zravmC0NOo/Jz/PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=prPOXcWy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k0YwqpT4; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="prPOXcWy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k0YwqpT4"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 317651D0009A;
	Wed, 11 Feb 2026 07:13:24 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 11 Feb 2026 07:13:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770812004; x=1770898404; bh=LquM4UyIuV
	xU51Q3kKlyPMO8ZENKcoXxYh6p3AVsnB4=; b=prPOXcWyJfvmMR/9g58NWj0s8l
	DEpKW9tpa805u+UglN/6MlnRsy/mR+tJIS68DqW+5KIAXHS9bBqLPSuF/FcYZsaK
	vhSvMxvyeaSwiozTDOZMzOEgbF+JK7RsGTkJMe9bOOmGHiacCY5Y2fINoTtALH3h
	K/Vp/UTjRtQDG1stN+YC1vBwZekk5xZhmvsGTg+zlI8E5jUsZ+4qW2VrAG/WWxNF
	FOX1NXVuBQOoOm2eOpgvcDwno8udfxwoZmJfJeNXceorEUnCCEGtVKAVHqE7Zcfj
	lOYe2qhtd67t+qw5JikY5ld8THMhXUpjlLHbJ/EAXL0WEACQo/dEGsi/vFxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770812004; x=1770898404; bh=LquM4UyIuVxU51Q3kKlyPMO8ZENKcoXxYh6
	p3AVsnB4=; b=k0YwqpT4AegW2HWKscFyMfMJp8Q5QiPFmZJ4nwsrA4RAGxHmNB/
	tJ2Wfp4pBjhDHJ10+xxqBSFBzAlrzrCc83epK3czGuynqcOipFBvdR0cSHQ7e3UM
	6JRI1GRGxS83B43uq1kV3WTcNLB4plG0jDW31+oHOdI46UjHHbyWYMcDioo4a+ZT
	PLRLYWRkqdG/+adH8AvNlEmbLWUeU5Apj1mS8nP8kMS2mVq5Pidm7kytpjkxAAyw
	zq0Bwl+5+V1pKmIPeSl0U12iU0ohD9GYCSAGRuZl0TGk7DC35+sfgbARv7Ise9Zt
	ENu+VvLb5j6T3ZSLTcATRSEMgVAD8uuXS3A==
X-ME-Sender: <xms:Y3KMaQ6B7oLoNfLjOqXK710dVLzXX3fo_S52Im5bRtAb1w5pn_-8sg>
    <xme:Y3KMaQ-C0LJi6eeCqy8aF94_hK-Ey6z6K_PglqEYEkmierISNaQ4zzGj6peXdqDEd
    pTSfWjzTr8gIljphbwOkCuCc-gNXiy1zQTqGq961flIjFe__bd4MvY>
X-ME-Received: <xmr:Y3KMaVqYAfPfBhnPJQiyhSvduFnT1ewzY7sPPO4UCs4cqDg8RYdOJyMu2b3Ho__oRxopOdo9S4WOVtT1jjNHFDT9SifsyDzAi13gTDBiBHa9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddvhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhih
    hllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehsthholhgv
    vgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrh
    hhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggr
    lhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:Y3KMaRrYb9oYuXnV8FxLnTKTSUNrOHgbe5M0Joc6IuOpfQebEp4Kjw>
    <xmx:Y3KMaY3t_Gk9ftwKYNQyE7Nau9tJfwaIbptY5AU3QaNVDQzlaV_GkA>
    <xmx:Y3KMafHQ0YJo8_-8webmYz80-CUSLQibvW53_nmU2vB1fdcfSu66Ng>
    <xmx:Y3KMaTHN_VO0KFiJqQcd3WIQ65GoH6xvqRMLNCUBQoKnazFyYHhlTA>
    <xmx:ZHKMaWTwIL5AlkFo-VIu8R5SjIxN5BRAGDQp-sI5ehnu5TMErOrbcKWU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 07:13:22 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e2ab858d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Feb 2026 12:13:22 +0000 (UTC)
Date: Wed, 11 Feb 2026 13:13:18 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 2/5] parse: add git_parse_maybe_pathname()
Message-ID: <aYxyXlH5Z0toWgPj@pks.im>
References: <pull.2044.git.1770698579.gitgitgadget@gmail.com>
 <8d3a6a8265714c5e4bae0f2e5a587ea46a6adddc.1770698579.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d3a6a8265714c5e4bae0f2e5a587ea46a6adddc.1770698579.git.gitgitgadget@gmail.com>

On Tue, Feb 10, 2026 at 04:42:56AM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <stolee@gmail.com>
> 
> This extraction of logic from config.c's git_config_pathname() allows
> for parsing a fully-qualified path from a relative path along with
> validation of the existence of the path without failing with a die().

That sentence is quite something. I had to read it thrice to understand
what it wants to say :)

> diff --git a/parse.c b/parse.c
> index 48313571aa..3f37f0b93a 100644
> --- a/parse.c
> +++ b/parse.c
> @@ -209,3 +210,26 @@ unsigned long git_env_ulong(const char *k, unsigned long val)
>  		die(_("failed to parse %s"), k);
>  	return val;
>  }
> +
> +int git_parse_maybe_pathname(const char *value, char **dest)
> +{
> +	bool is_optional;
> +	char *path;
> +
> +	if (!value)
> +		return -1;
> +
> +	is_optional = skip_prefix(value, ":(optional)", &value);
> +	path = interpolate_path(value, 0);
> +	if (!path)
> +		return -1;
> +
> +	if (is_optional && is_missing_file(path)) {
> +		free(path);
> +		*dest = NULL;
> +		return 0;
> +	}
> +
> +	*dest = path;
> +	return 0;
> +}

Okay. So the difference is that this function here doesn't cause us to
die in case the path is not marked as optional and missing. Makes sense.

> diff --git a/parse.h b/parse.h
> index ea32de9a91..4f97c3727a 100644
> --- a/parse.h
> +++ b/parse.h
> @@ -19,4 +19,6 @@ int git_parse_maybe_bool_text(const char *value);
>  int git_env_bool(const char *, int);
>  unsigned long git_env_ulong(const char *, unsigned long);
>  
> +int git_parse_maybe_pathname(const char *value, char **dest);

I think this function could use some explanation what it actually does,
as the behaviour is non-trivial:

  - I think the ":(optional)" part needs to be documented properly to
    say that we return successfully with a NULL string in case the
    target path doesn't exist.

  - We should document that it expands "~" and "%(prefix)" (even though
    the latter feels somewhat coincidental to me).

  - The path is not resolved to an absolute path.

Thanks!

Patrick
