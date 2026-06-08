Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED97F2DEA75
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 13:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780923997; cv=none; b=CAmuRoDf/6hwoxGh9jxYFZyUb7dCTTcyWfXlETMmkPrRvJ0VxCxoPTzDF0aiZJkPnQgNznp/6zPCm9tbBu7D9nBIP/IOpGgPR4498LeFeUVdkS/mbwS0Ix0qu41tMljivYpGUyaZYhCANbtraPuOIXprTtn1x5ItxB7cKtweSyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780923997; c=relaxed/simple;
	bh=UnOxSlIZhA4QfURVMfkK9K2pt515VaRJXeKxK0bnXP0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QJ2m/Vf6iZOQfLFt9NyVR4ooFHaxw5F42tmEs9ecRSdQHTVe5nv9FQVvAlCxh7ulSA4v8c8cJi/jSGEyxLs2s2GUUXjrSMgg/lsMlCN0FLRCJjYQv/A/RPAghp1N97e27HFz9L4dZ6k3rFhk1PpMhRM/ML1fTP6kz6QPX+EDLw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=d48/ffuX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZapQTtg9; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="d48/ffuX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZapQTtg9"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 31BCAEC0081;
	Mon,  8 Jun 2026 09:06:35 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 08 Jun 2026 09:06:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780923995; x=1781010395; bh=nM6X5JHDd8
	i7uhYzEW+9HvGSxlR3pWz1kEjFJ6A04Kg=; b=d48/ffuXGrUwUzv+hwRS20COru
	5CE1TkTplZb/nzdLx3c0vuiHFjV4/d17oorucW02yrpExDNCRjf7SwlgarPljXJx
	8mWO/lmZIh/GFzn2Ngqhymr+gSPLj9Q0q0y8NpRugEJNN6V57CwKhn4ZS4JvNmlF
	2+fhiIX8+eGYP4Gh0wjQ5bL3fgW94nfQtsHSq82WQore9VpPljTJ0AMJi/S+3S9v
	p7HasKLpd6OlqUrwhcScCcCXvgAtN62UnCtk9tCYajBiYXJaXhaSsr6SDnYeyrHa
	0eZI09Uqh8rKMNjGlRHN1Oc8cn1YPvczlyNxl2MB8MSy3Ya4rGf+r1VNW+sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780923995; x=1781010395; bh=nM6X5JHDd8i7uhYzEW+9HvGSxlR3pWz1kEj
	FJ6A04Kg=; b=ZapQTtg970UuUcFJyo0E3hzpWmThubWL9+CcFn0MnHD/HlNNG71
	wyD0hfuzk13Lj6IcfXwPZD0X+9pvBq9wJeOaC+p9yTz78qR4jAi6zKYcG81Fc0Tb
	AFHkWZ7YDPxn7i0kxAw95p1x2HlOKVcqBBTcxRBZu88dgE1SDeBF1bYIVuVKD/ka
	GwWL5QXj5cwO3cJhmWIjVbAuxJDr+Eog9XdaGTS8AUQDDhB7kXoglb2Ij7/kUbqF
	HUP0LJ8IEH6BpP+85PkMGXpCwu3obuuukUxhRuvyVYOiSbA7EnBGba6SV8Wl75XY
	rI5bVWclLWHPOWlla5+04GQsvlW3Mbc9Qbw==
X-ME-Sender: <xms:Wr4mavx-zUt9czJXf2HD7RPo2yWP3PZSt1mqgRI1jNeIALdN-llItg>
    <xme:Wr4mauJfEpqBRh_uyTG3cgQV_JGSKOz6oQO6_iqAJhQebGQY4MnbX3fmpzGdLsVc7
    zVwQFndMm0rVz5sjhVA-_Z6LuZwIDk6xT_sEOjmMHzou-PfA4NX>
X-ME-Received: <xmr:Wr4mahpyYh8gW1oW3RktmJ8PfLLOnGeIVWmnEaVEDCpFF6SQOnK6tJ2QbawkHG5yEqv_N3acuUyT44kYFT5liBAlexT_PWAQ2JWz>
X-ME-Proxy-Cause: dmFkZTFCODTT3QvAG5GuC/dfxXHZKy52zeeGF9+aEP/6yAKx/8/ne599WclB90p5MvQAfo
    u7oxW0ZoXEXHvjf6KWLid+PU5F8KLCM5F1pvE4TBWXnbKeePXv/WT4D5kusIQn2twtzaGN
    laegUIH1gzJKVl123qOBfT1ryY1iGvjsFFCjiP52yQsduUzU8HtxrFqVPSdXWdS7Bo3d3v
    I8s5Sbk5trxWNtDaTuvzHD/B49mWRXVmpuPrOXQPO7nUFvMNnyiR25AE20Kr6+YhLRXM0I
    m3MxkuzhJY1wUyozXzKydfyG5EimN8S1j+vWcqJcts6tyPbHDEL605jsEbFfAlN873iDf1
    zI5gUFs9weaM4t8IGb1imHmiFNGYTNGE4zawAhMmM6AukaoLwZ4uLl3+QfT8TpFbGxywdA
    59Z4xcjvZE9jL3XOIZlvsDCxYjX+LJxEGq65B4/EK+DT0AVUMPIEqRTTFpp9DVYMslzj5c
    Y7suJSCGq9jnmU9I9LG7DbfaBhnPOdCdZa+iGw7TaxktZP/jJ40oZ1J2q40hnXWuipn0TO
    bfXva0Md4gHPFgXcgJEMq/bFrng9yDVt0wNa9I2zhX9KrFvm+PLknUd5IikWwdRfUzF8bR
    4qmCay7qv1JScMvQONkWKpEvVel5JnCK1f97D0qVJ27vua8SiV7HO7NK2gWQ
X-ME-Proxy: <xmx:Wr4malIbBxEvJaFR569iGUFdALrwJ7txTABpyJ6JKNpEnwnf7tt7Ag>
    <xmx:Wr4mauQKQCODcMhWlPmsvj9a1Pr1PbbtSeTMgsrj4gPH2lMwukzsPA>
    <xmx:Wr4masvUOVKHbOyEJdh2mGjpQ5qVJcRG5O2QMJzYRNjRbs_AwXqU1g>
    <xmx:Wr4manZEK4MDOVr7701jKQ0qSCKcSPcQIbxozWHaiuDsKMdySA8yZg>
    <xmx:W74mailJyhMJN1VIKDIrTkTWz6Qb1w7AvynbtO7zveGBMzzbBnXlCtqp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 09:06:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH] ls-files: filter pathspec before lstat
In-Reply-To: <20260607-ls-files-pathspec-lstat-v1-1-8cf40b730146@gmail.com>
	(Tamir Duberstein's message of "Sun, 07 Jun 2026 11:40:56 -0400")
References: <20260607-ls-files-pathspec-lstat-v1-1-8cf40b730146@gmail.com>
Date: Mon, 08 Jun 2026 06:06:33 -0700
Message-ID: <xmqqa4t5yyee.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Jun 7, 2026 at 11:40, Tamir Duberstein wrote:
> show_files() checks whether each index entry is deleted or modified
> before show_ce() applies the pathspec. prune_index() avoids most of this
> work for pathspecs with a common directory prefix, but a top-level name
> or leading wildcard leaves every entry to be checked.
> 
> Match the pathspec before lstat() for the deleted and modified modes.
> Keep the later match in show_ce() so --error-unmatch is satisfied only
> by entries that are actually shown.

Adding an extra early `match_pathspec()` check before making slow
system calls like `lstat()` makes sense, especially when most of the
index entries need to be skipped.  But if most of them would match,
then we would end up doing the same match_pathspec() calls twice for
each path, and run lstat() anyway, so you may also be able to
construct a perf test that demonstrates a case where this approach
is not a clear win (or even degradation), perhaps?

> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index e1a22b41b9..702c607183 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -450,6 +450,13 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
>  			continue;
>  		if (ce_skip_worktree(ce))
>  			continue;
> +		/* Only entries shown by show_ce() satisfy --error-unmatch. */
> +		if (pathspec.nr &&
> +		    !match_pathspec(repo->index, &pathspec, fullname.buf,
> +				    fullname.len, max_prefix_len, NULL,
> +				    S_ISDIR(ce->ce_mode) ||
> +				    S_ISGITLINK(ce->ce_mode)))
> +			continue;
>  		stat_err = lstat(fullname.buf, &st);
>  		if (stat_err && (errno != ENOENT && errno != ENOTDIR))
>  			error_errno("cannot lstat '%s'", fullname.buf);

Hmph.  In the current code, because there is no such pre-filtering,
show_ce() would unconditionally recurse into active submodules when
told to with the "--recurse-submodules" flag, even if your pathspec
coes not match the submodule.  With this change, such a submodule
whose path does not match the pathspec would not even be seen by
show_ce().  Would it cause a change in behaviour?
