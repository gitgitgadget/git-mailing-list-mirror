Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CC813A3ED
	for <git@vger.kernel.org>; Sun, 30 Nov 2025 18:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764527583; cv=none; b=SHnqJ6fubF6ea5IUHOAeYwsrYA/bSsbO+ipGri9wpM1DcDNQHrQcPYsekdgARAFd4bw8gDfy4E+RP0FNhyx/uyuqelSH5U2PjvNMQEN1GnSLlFUa/VAGyaKlRZnqtfxkcgpQ5KJEM5FzcSfXfkhRwDZb0pefE9hF9+/yLNF4o60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764527583; c=relaxed/simple;
	bh=LVwbedgSv7gyyp5FYuQyFbuzbquJR4Kl/LiRnr6jOJc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OKgw+8/x/jaMk+btLGaTz4kxhlBOyfhHbN2eH0YUgMlFdD1ew3eYRbg0gATbowuxcgF9nfct6LRtWoNhBINHjIHggbFBr2YbZV28q61wz3ulMbSqbuJp5TD9XmaON5njvTYfk7+3Ze1MsyrMi9waSl3kWvU+2SO4hA2oZuZAGjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=D7c/FvQE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RGfBSBAp; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="D7c/FvQE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RGfBSBAp"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0C9A37A013B;
	Sun, 30 Nov 2025 13:32:59 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sun, 30 Nov 2025 13:32:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1764527578; x=1764613978; bh=U0FqbdeiuT
	5fKIjuK+zHtPRWpmK9CZ2vJVbofBzYvYA=; b=D7c/FvQE9t1dECikAvEzw1gO7K
	VvCzYsOxP+WGImP/Xupfmz7O0SINDSX2kTpUu66xEVrea9qtspjvGtbp7WCPEHYZ
	Z7yfWODcbgqRpfeMU/z6XoC9JfJDnge2Lb9tFDVWxL6N4D6xD/2hnyItZJnfBYaF
	JkrOv7TeBw4vyAnxiQcWpnQ2uPTWLyUZ3w9LWPsFFfRL9CPIt9ks3AeoS4UV/KMZ
	RKTRsCeiiARApEwK8y43YwAsS6hsbZQAV+fJgVU8Yd8ExNp7Ao18Ts15T0CeP9Fj
	h7SV89sWrTx20muiFP0zysHukqj/E5WDPYa6+nUTCcGcrGsIOWGL6bakOTZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764527578; x=1764613978; bh=U0FqbdeiuT5fKIjuK+zHtPRWpmK9CZ2vJVb
	ofBzYvYA=; b=RGfBSBAp3aDpUxzWVpimcMg8Euh9nT0yVr0hokIwsYCTSyzISKv
	twuAPNNcR63Mi/sWWsODxaQ02BII7MOd3SRrZIKl+OcdJ+5viDuvKncJJKpRczjV
	GgLCP7nap3qR1R0DT9w0+mfF8HJSEk5wXmUqgA8SrIIv820t05KxB8so3rcN2z6C
	69psTjLKq8ZFkshZLhIqfGaLYVn2SHgMym0+U90L2I/M2Z1yvit8G9VBvNVt7Plk
	IhpqXGTtwymPX0t1R0zmIb/S9ftFjrAgNnWZ04o9NHET0iGfao+uQc59oEJ3attE
	zdjjdcSfb1ebSgDy6GmohNwrECKVvi+byAA==
X-ME-Sender: <xms:2o0sad2OkbgdmYuOVtQ7hc6i8CO5b08TckK-0We8rrCXrOEdH7lDOg>
    <xme:2o0saa9IPdFM02dCyXHpMdaa-hXRNgMN73wpyCMTIaZZDaERyu3jSiwDLTptSoSrQ
    GXxUzSZ4wk5V0_9kTRqBze6xhof87-Hv_2LK88OP20_-16zcirvUA>
X-ME-Received: <xmr:2o0saWO_y4ygMeF-RDnkUCn8kBQYAHnu8nCRoIHNRJ2eDxb7fIRUnVfpk8iGwz5uC1fblYXoZse3Rwl70ix1QEdQu4bVYWmtdNBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheehheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprggsrhgrhhgrmhgruggvkhhunhhlvgehtdesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehphhhilhhlihhprdifohhoug
    duvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:2o0saWeZmM91PBizgTqSGG8sfjoHHNxzw_omjenXljRaFFnUG5X_4Q>
    <xmx:2o0sadWX1W9mgXYO0Jeh9HmuwN_0fo9V4B16CqEA85635IKghZBQ5g>
    <xmx:2o0saWhdszaFJ1-XrM5hUuRnPBDF6TuTg-ZSvS8jvCrxqIKTgXfs7w>
    <xmx:2o0saU99YxK4nJZdJnIMtbX4qaVTa4SmFw7Kk_5kxB_rYdu1J5Tn7A>
    <xmx:2o0saYsVK2J8DLQ3RiVxZjIHncaCkHqw6p1--il6K_JqjIZMpnwtZGlh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 30 Nov 2025 13:32:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH] add -p: show hunk selection state when selecting hunks
In-Reply-To: <aSxQhqwzT34hIjV8@Adekunles-MacBook-Air.local> (Abraham Samuel
	Adekunle's message of "Sun, 30 Nov 2025 16:06:15 +0100")
References: <aSxQhqwzT34hIjV8@Adekunles-MacBook-Air.local>
Date: Sun, 30 Nov 2025 10:32:56 -0800
Message-ID: <xmqqqztfbcbr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Abraham Samuel Adekunle <abrahamadekunle50@gmail.com> writes:

> diff --git a/add-patch.c b/add-patch.c
> index 173a53241e..e70e390506 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -45,7 +45,7 @@ static struct patch_mode patch_mode_add = {
>  		N_("Stage mode change [y,n,q,a,d%s,?]? "),
>  		N_("Stage deletion [y,n,q,a,d%s,?]? "),
>  		N_("Stage addition [y,n,q,a,d%s,?]? "),
> -		N_("Stage this hunk [y,n,q,a,d%s,?]? ")
> +		N_("Stage this hunk [y,n,q,a,d%s,?] %s? ")
>  	},

Three comments:

 * These sets of prompts exist for each front-end that uses the
   interactive patch machinery, and we are looking at the set used
   by "git add -p".  But the "I came back here with K, or I do not
   remember which between k and K I came back here with, and I
   cannot easily tell if the hunk I am looking at is already
   selected" issue is shared with other users like "git reset -p".

 * "chmod +x Makefile && echo >>Makefile && git add -p" would ask if
   you want to stage the mode change of the path and content change
   for the path separately.  You may skip, and later come back with
   K to this question.  The same "hmph, have I selected to use
   this?" issue exists, no?

 * The existing "[choices]? " was designed to be at the very end of
   the question, so that the answer given by the user will come
   immediately after the offered choices.  Adding an overly long
   "selected" or "deselected" to make it "[choices] selected?" does
   not give us a pleasant end-user experience.

Also, after you decided on one hunk when you have two hunks, typing
'j' or 'k' would tell you "No other undecided hunk".  The phrase
used here, "undecided", refers to the choice between USE or SKIP.
To convey the intent clearly, "Select"/"Deselect" feels a rather
indirect way (i.e. "selected for use" vs "selected to skip") to say
what is happening.

Ideally, if we can convey

    Stage this mode change (you previously decided to use it) [y,n,q,a,d%s,?]?
    Stage this mode change (you previously decided to skip it) [y,n,q,a,d%s,?]?
    Stage this deletion (you previously decided to use it) [y,n,q,a,d%sm,?]?
    ...

without wasting too many extra display width, that would be great,
but this patch is not quite there, I am afraid to say.

> @@ -1564,7 +1564,19 @@ static int patch_update_file(struct add_p_state *s,
>  			      (uintmax_t)(file_diff->hunk_nr
>  						? file_diff->hunk_nr
>  						: 1));
> -		printf(_(s->mode->prompt_mode[prompt_mode_type]),
> +		if (prompt_mode_type == PROMPT_HUNK) {
> +			const char *state = "";
> +			if (file_diff->hunk_nr) {
> +				if (hunk->use == USE_HUNK)
> +					state = _("[selected]");
> +				else if (hunk->use == SKIP_HUNK)
> +					state = _("[deselected]");
> +			}
> +			printf(_(s->mode->prompt_mode[prompt_mode_type]),
> +				s->buf.buf, state);
> +		}
> +		else
> +			printf(_(s->mode->prompt_mode[prompt_mode_type]),
>  		       s->buf.buf);
>  		if (*s->s.reset_color_interactive)
>  			fputs(s->s.reset_color_interactive, stdout);
