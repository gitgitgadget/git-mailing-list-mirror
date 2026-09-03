Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE773B0AC6
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 07:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421224; cv=none; b=up7QiLH40aNPBDUSXpXEnSjY6x3gZnMY9mT/wr4Ie+JsAoJxcMJ/+mMLbZyTYdnYEEpc0buZEwImMRvvX4Rv8Wp/504U91h9KSs9kn7cjmD27uWK0eshJEmHWNpC2Ws2goftU/9fHO6Dafiwph0V1wwCDKciFqdnquDzsTvxyIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421224; c=relaxed/simple;
	bh=pW+YZKlD/Dr//KjZE6nznbg0YtzV9vFvb/LngxZgOh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NjJGuC0Z5oEifZeQZ7KKrMxEe3gh4OWex8at4BHuhvyV3IrAFWxrj+GTjgpVujUZCYRCetYau1luR78FrCF8VgVU+rth21rs7rKwDUDbYvs2OBB5vdnq6Eyx3xZ3DfwKzzoJy/oyh2jaILFuuMPNFOSoH1Pb5+LvEzujJy6Pzoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PN6Lgd9j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qmgcJj38; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PN6Lgd9j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qmgcJj38"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 99F931D0011E;
	Thu,  3 Sep 2026 03:40:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 03 Sep 2026 03:40:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788421221; x=1788507621; bh=Vh/WrFYTl/
	YJ+70bZ+MLj2nry7fiA/fYVyy2LCr8Smw=; b=PN6Lgd9jN/HZ5tYfM6GWzN7Mnt
	VsnPuW77bQi+K6QbgB1KDbio9mARMHDG0R5qNNgzzakdFuSNR7YtrFBTI4DmhYLI
	1qQpGXVbbFH2X2Fl+vn4dtrzxhVqiYIGYq0+zbhMhVEp8T+KNq5+8A+DWSRE+WL/
	tzLPPro2W98froCW7fScpVQOTQaK56JI/mUmrHpP4jKnkwJzYzjegh5y3FOs71Pa
	TXoqkoxMV1Vr9HhaITnqEx/VcyJ/Z35GDjYCkYeprnXnc5ex5Ms05TnN7Yw9KD6f
	lQFB9Yp3uHdevUHv5+D/LP1Jui0S+kR9vksxMpxQcFqas4VpYcZZZ+ucqraA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788421221; x=1788507621; bh=Vh/WrFYTl/YJ+70bZ+MLj2nry7fiA/fYVyy
	2LCr8Smw=; b=qmgcJj38agMwN2lhN2HMiDwaW6/61TmV9GSoah2wGiwwyR3yjPm
	zCoGYEr0B4lnR4rvVJkJ34E8uIj8scsABGyzgdRnmyTqfOE4kbeRYuPha9qkpoJy
	QwLFpRF8Imz6Ke4TNjS0EP9gDjgfpUcoeRPv/GxzZyYdvgCbOQ05eeSyJ3+Nkqsw
	Platm2qRhh38MPcZ0pRsKQRpkGfCzSJD49ipRIvzmEBIlqwOk3A4b2f8qX/4wa7o
	+1OQnAwk4+kPKLp2oTgkgeo79zDaENPaskJt5Fw1BTX2DUyad9TVgIl4TaOm44B1
	+PIcauql+MTTfRVl0Vg9ahxIElLJMKUA9RA==
X-ME-Sender: <xms:ZCSZaryGK2uDPYHWenOJnN3YQEwv6JDsOe-UKBSiA5lT9-Knv0FhfA>
    <xme:ZCSZakxwhn8Kqrxi03hVlIKjLTGZH7ZUWP10YiFBSU9mrY1CPgEGRDsucU8ltPSLJ
    LApBNNDAJOx6GdCDwqcEfjLGHWktot5kLqr37dO-ZIAhKnP6yJczQ>
X-ME-Received: <xmr:ZCSZalbVR7htPfeAqK3lYJWPflp_yABuu9oBNhMolfUXkF_1By3cVA>
X-ME-Proxy-Cause: dmFkZTE/j4rIBAobMBGqjzhLPJ6sj54XEGgoNndrIgsB8U0L9xCGmFJs6ZPCJ9ahrQpFIv
    3KPkNW1Zw/GRDWRls8H4IhzBDd+47wt3tnCA/mAGMEW+SIM/kYbFufJl5iFajmSeh+IGli
    XByHFwNZM4/iUyEMzLwsph+Y4ZCh2iH7ksCXezrvjYm2BOBbM8pip63ldRLaHOGLU57Kvz
    NXnHrSvoClyK85cBsg4kg5SLrmW03ZVVXd5QBtyFIKm+99cZtThxOBj0ckF0XmdnufiWNv
    wVySeOjOcVDHvH0LAMo3mOdZMqt1dImeA1hOoK2jxYpH8xiya3miqysFZizuCn+BFPu5Xw
    iwKCU/90ofK/YG2LdpRr5v5LbSv2ImUmw8WWo7G/Z68KLdnjA2tGaqv0VMdK13jy3BHDM2
    WK/SvCRrl0IOl2+yW2y/i5W8M3A2EkJwOAllBzxzBminX6DdsenuB7+L55cXHjRLQ1IhTw
    RJt8/kpz1+Gdc9QcvTAMiMt/d5FzQOxSg/aXsDGqS3LRdGQfG3eg5rnCL3D814Rukk61eI
    r2dyhhD/79UijroL2kV0GIlVkJzS9+eLxsq+5/yfUoA6/5Z7rD05GbLuO5+4Dd/3KHwNY1
    XsQ7sFN3BK00+qE3Fq7F55GtbgFiODnIA/vsU8Ok+1sz/2CIypYiTzrFztcA
X-ME-Proxy: <xmx:ZCSZalVzhUO3KwPnjRQVzmU1qg1-IXJCxuxNMrOn0iNwfIayieJ1RQ>
    <xmx:ZCSZajjBBQTAbIx_t9AscucWhyOR0jDzFrXpVduyONRvrOAGLYGRbg>
    <xmx:ZCSZajvWHIk1ckekwfRrLmaPf1slsdzLElYOGWQ5FqMqd1-B7XyYuA>
    <xmx:ZCSZas6T5zpkWwmT3gI9Vr5gV6TWpflUlQj0PKARjiSSy6nW6B8AgQ>
    <xmx:ZSSZatZ3X4kyxjCit6n2iRvYI7XJXLAaNhUCq3r_qOAIBLJcmPTB1lBY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Sep 2026 03:40:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b0f6f630 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 3 Sep 2026 07:40:21 +0000 (UTC)
Date: Thu, 3 Sep 2026 09:40:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Bachem <mail@thomasbachem.com>
Subject: Re: [PATCH] rerere: keep a background gc from killing a rebase
Message-ID: <apkkVAYOqjfAsp9-@pks.im>
References: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>

On Wed, Sep 02, 2026 at 08:31:37AM +0000, Thomas Bachem via GitGitGadget wrote:
> From: Thomas Bachem <mail@thomasbachem.com>
> 
> Since 2.54 unscheduled maintenance uses the "geometric" strategy, so
> the "git maintenance run --auto --detach" behind every "git commit"
> runs "git rerere gc" in the background whenever rr-cache has an entry.
> That includes the "git commit" the sequencer runs for a resolved pick
> on "git rebase --continue".

I think this hints that we should tweak the default value of
"maintenance.rerere-gc.auto". The way it's currently written we indeed
are quite aggressive with spawning `git rerere gc`, and I agree that we
should tweak it. And in the best case we'd not only respect whether we
have a specific number of entries, but we should also respect whether
those would be garbage collected in the first place.

I'll send a patch series later today to do this.

[snip]
> The gc needs the lock: it removes every rr-cache directory it finds
> empty, and a rerere that has just created its directory but not yet
> written the preimage looks exactly like that. So keep the lock and fix
> both orders. When the gc finds the lock busy, let it warn and do
> nothing this time, the way "maintenance run" treats its own lock, so a
> manual "git rerere gc" sees the warning and the maintenance task and
> "git gc" see a clean exit. When the gc holds the lock, let every other
> caller wait it out instead of dying at once, for rerere.lockTimeout
> milliseconds with the semantics of core.packedRefsTimeout: 1000 by
> default, 0 for the old behaviour, -1 for an unbounded wait. Walking a
> 20000-entry rr-cache takes about 0.4 s here.

Having a locking timeout is sensible anyway, I think. It does not only
solve races with a concurrent maintenance run, but also with concurrent
writers.

> diff --git a/rerere.c b/rerere.c
> index 8232542585..22d114262b 100644
> --- a/rerere.c
> +++ b/rerere.c
> @@ -32,6 +32,7 @@ static int rerere_enabled = -1;
>  
>  /* automatically update cleanly resolved paths to the index */
>  static int rerere_autoupdate;
> +static int rerere_lock_timeout_ms = 1000;
>  
>  #define RR_HAS_POSTIMAGE 1
>  #define RR_HAS_PREIMAGE 2
> @@ -876,6 +877,8 @@ static void git_rerere_config(void)
>  {
>  	repo_config_get_bool(the_repository, "rerere.enabled", &rerere_enabled);
>  	repo_config_get_bool(the_repository, "rerere.autoupdate", &rerere_autoupdate);
> +	repo_config_get_int(the_repository, "rerere.locktimeout",
> +			    &rerere_lock_timeout_ms);
>  	repo_config(the_repository, git_default_config, NULL);
>  }
>  
> @@ -908,12 +911,26 @@ int setup_rerere(struct repository *r, struct string_list *merge_rr, int flags)
>  
>  	if (flags & (RERERE_AUTOUPDATE|RERERE_NOAUTOUPDATE))
>  		rerere_autoupdate = !!(flags & RERERE_AUTOUPDATE);
> -	if (flags & RERERE_READONLY)
> +	if (flags & RERERE_READONLY) {
>  		fd = 0;
> -	else
> +	} else if (flags & RERERE_SKIP_LOCKED) {
>  		fd = hold_lock_file_for_update(&write_lock,
> -					       git_path_merge_rr(r),
> -					       LOCK_DIE_ON_ERROR);
> +					       git_path_merge_rr(r), 0);
> +		if (fd < 0) {
> +			warning_errno(_("unable to lock '%s', skipping"),
> +				      git_path_merge_rr(r));
> +			return -1;
> +		}

We should instead pass `LOCK_REPORT_ON_ERROR`, as the lockfile machinery
knows better why exactly locking has failed.

> +	} else {
> +		/*
> +		 * A background "rerere gc" holds the lock for as long as it
> +		 * takes to walk rr-cache, so wait it out rather than die.
> +		 */
> +		fd = hold_lock_file_for_update_timeout(&write_lock,
> +						       git_path_merge_rr(r),
> +						       LOCK_DIE_ON_ERROR,
> +						       rerere_lock_timeout_ms);
> +	}

I think we can easily combine those two branches and simply set the
timeout value to 0 in case we see the flag.

Patrick
