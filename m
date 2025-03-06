Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F22C25A638
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 17:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741283602; cv=none; b=i8h+FZUQ24mkHMGlNe5y+mYOdedEZKGxz8zTsiNUv6lCtoySIUszF65TOVFrlgfoW13SgG7MQyWr9f7K8cYX1wpG8dl0mDavrbG1iD7fAZTlGNSv6wXT2BXQku6/DjNmEOe4kUGiGC5LYdKGPJY4nfavYdx86NDC5fJp4aVg+ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741283602; c=relaxed/simple;
	bh=OtROM/b1p/8nhYnCTgfy4kCridIeHyVG8ckO8Joo6Ic=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZIb+YjW7cjQOiTCvJxgZOe3EXpLO/19CHEyJay4sVj68pp404aCzBjtGNwwiTYGAlw3t16OtjToODGgOHzdbOFYSZbFLof5Tue7JntJD/mXsexK+9KauPu+gRNLDfOie8niiodNq6y3fsKr27KBiDwvyOGpasUYegzeVRdMquA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=y3x+gd2O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TRD+QmCU; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="y3x+gd2O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TRD+QmCU"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4EE8D114011F;
	Thu,  6 Mar 2025 12:53:19 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 06 Mar 2025 12:53:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741283599; x=1741369999; bh=8HhAAS36r9
	tBt23i4FBlqFt1S/mhqw940YzHiwFZ6/I=; b=y3x+gd2O1XoT1EG6LDyslKwQej
	44zbPHPxlI7CIW72iPTvb41cQHE3l0p6a8aeEYDq0OPNPU4V5mHIzw0pMAvYlE+7
	GJ8/v9KxaT94FIu05W4Bq+CENuT5yyCk9dRHXrEuSf+48KArYvG2v/ziLqhpS4Tb
	KeEnZqKsTnLVoHvoRWGVsxEh8hi7CH8Ej7+ow3HJUH74u6J8u8LcDRONWOaNIVsN
	VKaJOXWbLjGnjCF78sYszGxIRiLPWTg11ncW/fOG8MrwRiftj0y9WygF7JVc6M1v
	F7fc0AIwy7IeoP1OOJVoijHwo7G5fyox03p+YduVY4HBTMStvfmB5sr5/wvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741283599; x=1741369999; bh=8HhAAS36r9tBt23i4FBlqFt1S/mhqw940Yz
	HiwFZ6/I=; b=TRD+QmCUDijoic/EdoxomSD+miGaBqcQSxuRqqE91DiS08LN4Ba
	k+tfR/5/79VK3UqmxOlUxQGOL4kw0oCCF5h1veRKCTB0cPwWUzAooAzwoAuJoj3h
	0H4R9fL6E0OI/dBYfbQ5zSS++gnbOeblthnPyCLEJLBgcLk0/Iv9WCwaCyf6f1Ci
	c64fhQsmTKCvJvdF/xmRknV0+jgnLAi884YXBtRs4crbDYtJBiAq5qQL8uGH+0+8
	DFTRK9aWR1B5aMI43OQwVICI0q7rS/5Xi1AwfrgV82UFKj6eiDkl0htEq04WBvhK
	eacVQtrS8s8yCQ2KxvhHKaqkHT63KQjYzpg==
X-ME-Sender: <xms:DuHJZ5JzpNXg-4ikutNm5IgLln_oD1TjUa3i9ghtKBU4uhrc1yYIUg>
    <xme:DuHJZ1J9aCWpL-aV4oQ2OYFG5csoM1m4aJvcqoS_0HmMMBXZrHmEKI09dNUdvcsLZ
    h5nf5JyCtQgfCDySA>
X-ME-Received: <xmr:DuHJZxtgDWk8DJPRYXFy1gjj0oZ4NCOksZjZ0SvBsOUR8XRQx-ghLPw8QIggKsIC2sbmbM9-aOFAPg8oAKz12HZDBshPnwk9rjs->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdekgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefg
    feeivddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuhhsmhgrnhgrkh
    hinhihvghmihdvtddvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehjohhhnhgtrghikeeisehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdp
    rhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:DuHJZ6aZ0QZpMDjdS_QfH38LRMfW7vQy5bupy4IzbzVf4GfceU8yXQ>
    <xmx:DuHJZwZUlQzy2y1qV9cS6KELXz4KLPAjQvuzd1LDOhM0zkhF3WKUIg>
    <xmx:DuHJZ-DGgK85gwa9Kz4jaYGfjjuZTexgpBCCj_hv3Anzpy3dpNgInA>
    <xmx:DuHJZ-Z-n3VHKrm7hP-jX7XtYs-mrk5Phngqwz-AzTk1yhDIOkLB3A>
    <xmx:D-HJZ-lvuFpxYBn9gkZIUAasw560sh8B9QfIMRInuyYVRoL-3JfpkhR4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 12:53:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  johncai86@gmail.com,
  me@ttaylorr.com,  ps@pks.im,  shejialuo@gmail.com,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 1/8] config: teach repo_config to allow `repo` to be
 NULL
In-Reply-To: <20250306143629.1267358-2-usmanakinyemi202@gmail.com> (Usman
	Akinyemi's message of "Thu, 6 Mar 2025 20:05:45 +0530")
References: <20250219203349.787173-1-usmanakinyemi202@gmail.com>
	<20250306143629.1267358-1-usmanakinyemi202@gmail.com>
	<20250306143629.1267358-2-usmanakinyemi202@gmail.com>
Date: Thu, 06 Mar 2025 09:53:16 -0800
Message-ID: <xmqqcyeuhwqb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

>  void repo_config(struct repository *repo, config_fn_t fn, void *data)
>  {
> +	if (!repo) {
> +		read_very_early_config(fn, data);
> +		return;
> +	}
>  	git_config_check_init(repo);
>  	configset_iter(repo->config, fn, data);
>  }
> diff --git a/config.h b/config.h
> index 5c730c4f89..1e5b22dfc4 100644
> --- a/config.h
> +++ b/config.h
> @@ -219,6 +219,9 @@ void read_very_early_config(config_fn_t cb, void *data);
>   * repo-specific one; by overwriting, the higher-priority repo-specific
>   * value is left at the end).
>   *
> + * In cases where the repository variable is NULL, repo_config() will
> + * call read_early_config().
> + *

early or very early?

I am wondering if we should describe the effect we want out of the
design more prominently than the way we try to obtain the effect
here.  In other words, instead of (rather, in addition to) saying
that we call helper X, wouldn't it be more helpful to future
developers why we call X, to convey the intent, so that they know
how to adjust when for example what X does change or X even
disappears?  E.g., 

	When repo==NULL, skip reading the per-repository
	configuration file but still use the system- and globa-
	configuration, by calling X.  Note that this ignores
	one-time configuration override "git -c var=val" given from
	the command line.  The only use case the feature to allow
	passing repo==NULL was designed for is to support handling
	"git foo -h" (which lets git.c:run_builtin() to pass NULL
	and have the cmd_foo() call repo_config() before calling
	parse_options() to notice "-h", give help and exit) for a
	command that ordinarily require a repository, so this
	limitation may be OK (but if needed you are welcome to fix
	it).

That way, folks who are planning to update read_veriy_early_config()
so that it pays attention to the "git -c var=val" in the future will
be rest assured that they won't be breaking this caller with their
planned change.

Of course I didn't spend enough brainpower to make the above comment
more concise and to the point, which the final version should be,
but hopefully you got the idea.

Thanks.

