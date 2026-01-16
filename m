Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF04327281E
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 15:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768578424; cv=none; b=unThU5XAPezJm5zwuWS1qzphSwOjvlB5aUKm4g065vkYUW5TUCG6NDLq2oSM6wXvFAKQi6xfAf9iXcUtxFWcni9dontdnhnUx4pfS5/43QwrLq0rA5yM/IsJOATJ7lhM8sMVTbA4o4fzZa9DWulehinLzeVRIbiyESGy9kZ/oVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768578424; c=relaxed/simple;
	bh=e47qpuTNadnueU1/p7rynehIeYsFvy4IWdF7iMiLKQ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VrrBUurNQfNYEArI3uCnwOcsBChxjqWyqDYQZyDecEfBz6NU/oWay0ihm/3U9DBc2GJBe0KdzRx7sYzNWDUF8i7eQtt6dm/UHtLWNUC9VA5RE+TTkgeKGF/Ww9F6p+sWe+gMlkmUBlDhjwbDzjsmVayeumAjb6V/Ts1GDw9HMOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SH1uzveJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J0n/hBWS; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SH1uzveJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J0n/hBWS"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id DAC671D00184;
	Fri, 16 Jan 2026 10:47:01 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 16 Jan 2026 10:47:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768578421; x=1768664821; bh=vBo0tSnpZg
	jLrZBBdU7WwzbNkLBGWw+7cBiqmq1JN2c=; b=SH1uzveJwpS5CvJy6sr4HwIU69
	FVH54nUZUk2zsXp80KxR+BTMXZejIPn06zhUq10NC8VKZ74TA5uW8Ohjc278iISG
	MM/llTkW6GAEfxPVr1hhlr87jw8reKXdbDGYlQr86o4Y0dSowVpzRpVFrKrm+Sof
	6nsFF08E7nrMMw9bgjgOrwZust9wC+cZStX1iM0KhVAxysxqS9sewRpOVQMosJEO
	YKzc7viBI57Te2CHQXDVubWA3frErG0XiluY37zyF1uFT+mxsD49UIgv6blzn8bJ
	o5sG7H4/SWdgrNd3vH4kFRra7vTzH2jXC/t3BKa8FcZ0N0aLdcBZoJPbO1KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768578421; x=1768664821; bh=vBo0tSnpZgjLrZBBdU7WwzbNkLBGWw+7cBi
	qmq1JN2c=; b=J0n/hBWSOk22ujyHtSRnrJX4eDqKwEU0Q7ScSUMU6JqLzQUDFS0
	XyzKxA0HKZ+SkHNZI8kyR6ekQgLsn5KllsofwHwCt3PQPryrrY7+0RyxdGnRMB78
	ob0hpDkzoblffnTnErpt4b7NgaON1KfRnZuTOErlc/XzdhhKDgadu9o2h1My7ylS
	VHn8CHOhBRov1RUkDa+HuACyXuNyZz9SDO8/AsEKKffEb6dtWqMt09Aob5cl60Ai
	S7wCqQRUfMskGvSo9Gwaqzw2JDLbYCIyxSHuZVmlC/QZQCRVCW0Ug/1KvshVq68P
	mTfvPcBn3Oeso7QI+2NBbPmWOOAhAR+GJ5w==
X-ME-Sender: <xms:dV1qab3IWxm8SYuYYrryFIOYxQJZw4elnP8WQEPPw2fUqkIXlkMavA>
    <xme:dV1qaQ8t11Fqyr2VFqjaI6RCDmtIRIw55-E3r3BYVbl1GNrbIv0L5Cly4S_HuH5Mm
    -W2iRHXVR-fyqz0G_uHT-KjXs_WzP6beOxtN2nKaVSLnPcHevQuaw>
X-ME-Received: <xmr:dV1qaUM8AFodBCcUdltQXKdeJ7XGTXRwEp5P-BVfk7E3z6k6Pigfp206E3Mo__pMbh_lmXYqFD0zWu3JM7clgAg6sqC3pCqNsDC2QZ4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdelfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepfihorhhlughhvghllhhordhnvghtsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopeiihhhihihouhdrjhigsegrlhhisggrsggrqdhinhgtrdgtohhmpdhrtghpthhtoh
    epphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:dV1qaccEo7XBSfoKGGS2T9umi4Zm6oDBPRSVKSiApqWjZ-NVCgsDtg>
    <xmx:dV1qabWPPfvcuw_6MLHntiOtcEYEmiiUVe6P2vXgd_yF0oB8UHfjIw>
    <xmx:dV1qacgnK70UqZ1G-FrhXDg2NcZhW0xa_eIgE1kCAZNHsjZkv7HTTw>
    <xmx:dV1qaS_otsMephcQicadlMUKCSFtzWlv3JdNSRVS5ACxsVL8UD5OEg>
    <xmx:dV1qac5Yh_bUVwqUM4aez8zdiJJf0z76RqbqfgznN-B9J8fL40-7X2ZH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Jan 2026 10:47:00 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jiang Xin <worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,  Jiang Xin <zhiyou.jx@alibaba-inc.com>,
    Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] help: report on whether or not gettext is enabled
In-Reply-To: <f3500e698fd40297d2e2634785529b76d49ca470.1768530514.git.zhiyou.jx@alibaba-inc.com>
	(Jiang Xin's message of "Fri, 16 Jan 2026 10:29:40 +0800")
References: <f3500e698fd40297d2e2634785529b76d49ca470.1768530514.git.zhiyou.jx@alibaba-inc.com>
Date: Fri, 16 Jan 2026 07:46:59 -0800
Message-ID: <xmqqo6mta7bg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jiang Xin <worldhello.net@gmail.com> writes:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> When users report that Git has no localized output, we need to check not
> only their locale settings, but also whether Git was built with GETTEXT
> support in the first place.
>
> Expose this information via the existing build info output by adding a
> "gettext: enabled|disabled" line to `git version --build-options` (and
> therefore also to `git bugreport`). The status is derived from whether
> `NO_GETTEXT` is defined at build time.
>
> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> ---
>  help.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/help.c b/help.c
> index 20e114432d..96d70d8e6c 100644
> --- a/help.c
> +++ b/help.c
> @@ -799,6 +799,11 @@ void get_version_info(struct strbuf *buf, int show_build_options)
>  
>  		if (fsmonitor_ipc__is_supported())
>  			strbuf_addstr(buf, "feature: fsmonitor--daemon\n");
> +#if defined NO_GETTEXT
> +		strbuf_addstr(buf, "gettext: disabled\n");
> +#else
> +		strbuf_addstr(buf, "gettext: enabled\n");
> +#endif

Presumably, we do not care too much about the version of this thing
unlike ...

>  #if defined LIBCURL_VERSION
>  		strbuf_addf(buf, "libcurl: %s\n", LIBCURL_VERSION);
>  #endif

... we do for the curl library, so only reporting "enabled" does
feel perfectly OK to me.

I would prefer not to see the "disabled" entry myself, by the way.
Combined with the vintage of Git binary that had these help text,
the fact that an "enabled" line is missing is enough clue to
diagnose.  I know you mimicked the Rust entry before this point
(just above the precontext of the hunk), but I think we should fix
it to drop the "disabled" entry from there.

Cc'ed the author of cb2badb4 (help: report on whether or not Rust is
enabled, 2025-10-02).

