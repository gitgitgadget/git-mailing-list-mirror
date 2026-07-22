Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D758F470EAD
	for <git@vger.kernel.org>; Wed, 22 Jul 2026 19:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784746990; cv=none; b=TG0RcIAhxXvCIrJc/uuQRfTeMPelqfF10BUqwvHEaet49y/Bf+MbdAfsd4k6Drm5sxr4KXy0gPHLQjBIUs4axYIxo2fJgqVq/Gxl5LEs5aZ+IzgCH9TwTDLnUxslHWmq7r5sU3ehj30FugUvevQ5MKHHCYGkPTx2itYZIlwywBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784746990; c=relaxed/simple;
	bh=o+Px/3cYGp2PTzkKPKhqI9BFpEgNAcel8WOgpL89GXQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PlGA/tI2t7pYo9Ks4iEy00vn68Emw0HP81hVF/zxvrJPJt3efpHjZbMEmGzxl49JwtB2igH0P053yvsPWIhPmyMugNlDkdyUxnSDy0fx+3mnie+9DfGJUPT2GbZHMbGxjpj+Yxj9WOdLPgo0UAoboM8Yop2G7843euostwZhd5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=odmHhQaa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=agP5zO/c; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="odmHhQaa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="agP5zO/c"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 0BAB1EC01A2;
	Wed, 22 Jul 2026 15:03:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 22 Jul 2026 15:03:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784746983; x=1784833383; bh=8ABcZTV5jm
	Ue6GiJVkeu0ySt5VGFnLDl7N2pyQ7Ouy0=; b=odmHhQaahza8Adtc6hTEhwaaop
	H4cPM1TbHJIJufTkhfM5E/ZxKQgLggvbOav2orATxxmZUshu8leKdH7RnewXfINW
	ZvlG1XOeer3ju4+Xn6CEpKwetCLPv/v4fFcoqtDAUxvEuS951ubmIM6Z5LvGZ+OZ
	n3HYOPwnr1bhZK6OTrsHNCjshA/7i4hIIDIaTHq3AqiXbIqKMXNHg1uJtHSNSb63
	8KlYsFoSTnBJdWYMCIr5ZJxGv+rzSNWRSnY4ZjJv8jY8Rfh7Pi4v8Wvb5BzYlgW3
	x6bFV3NeeEDKU0y0crCVZHZjy/MIw0dv+nXJ01xn+Vd5l0yjM/UkOcxb1v2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784746983; x=1784833383; bh=8ABcZTV5jmUe6GiJVkeu0ySt5VGFnLDl7N2
	pyQ7Ouy0=; b=agP5zO/cNlC+kDkttmruHtZlbIuhQLLIHiXkI46BrGh0JiIuTZ9
	GGUq8w7PlD7U7PV2PLWdmPWoQtFGPXSVhlHalqitD4ltOvcKi1dvAKPijWPtFb5a
	FRJBoeNBoPwwyiD758dog78xJ5k1Eb0Bi4mdmVXKf4wqZML6jI2NxsvymzR3LyJD
	bfdv/8gsQknWt1g70apk7I4OdhNsfVCi31U68znRYuzXmMX7WL1fEt9VUerkz/Vp
	6u6rnWom9jExmmWlzaFBFjMX+SfT3OPZW//1eWQv2rDJpkZJ7vgH3+alhKCTo7gk
	IA16yPOZvq3U6h9K962vhanDibHbnAFS+FA==
X-ME-Sender: <xms:5hNharylTMgPrEqgBo8HpMZCKD4WM0g3poOmbXUNh7jVUaOI4roH5Q>
    <xme:5hNhaqJfBhJuvtAmNNw0alOX4Jc4eUO7Cf9ZNitFoeXIOxpk6kTAykdnLQu5OiCjb
    jbkQZTr9z_8qSmQAM78x0uW27vyzwi1wzac2F958dKJfepMeU5DGsg>
X-ME-Received: <xmr:5hNhatrWDK_Ux02EZkdjdg24Ulph0SDBsJx8mySIA_Oh9rkJ4IThwwmZDlFIDPBjvL_aT2giuiKYHQ5TD4avuPsQqkYL2Q1_tA>
X-ME-Proxy-Cause: dmFkZTEZrbDzui7DrYnm3rAuTv653z/Vmzz7REuC0AWxF9663EJC0Qa4gqSMKAUz7yXAYb
    nNB+6KcuAhbAcam2RSf/FdahGdLz9zaFp/J3wVD+dfwUKH7+iaPVZrANlfQOTT/pZwnT2+
    /39COVzVWeHPKUEOxyfTrOn96cyfz485k6v3CrD8wrMBa/1oajrYyGXOZ8hogJ5QC+p/0c
    JW+R0kzaOlW4thPzVNLpiSIQystKcIeHemBQ0xJkPbde4X5i3ePe+cfZWaSoF0uBVpBsqm
    Rn+JisNvk5PW9sIe3pKRMI7nOF7+TU9c1ctyxSebP+M/opIhKA30hagoIHglA6Jc7kJ9hg
    kmwgY2tDAiP16vWmiYQijWESYsW+Wvt8Bf+tB9M3L0DK7jdeepVqd/o3cbhZ1hij4XWQph
    kSdr8DTQ/JAIlp+UOW0fOy+WX/HfecCELrsXE0mHyHZ6+LRvFYQU8cD+zBmF56VTZ4tQM6
    no8CFjA+IRISW+UxK1CtDdv3ai5wbn+DMhKlPViYYRkTvmQtjwjslpQ0zti0rkp8ds7d9/
    WjmyJ/8PdFDaRWMfaZmbHTIRi9doLb9lpESGDNo9fyjG26WjX8ywbc5vW+RczFpKDi/ihF
    uny33/9fYF2plRyCErkbCZRHJ2RaDFHRceUxBWcZ8VwdAjgexDJQNJhC0nqA
X-ME-Proxy: <xmx:5hNhahKBGLRB6lzkRyaRfvnFMlydqU7L5oQBaNDluMkSVCsamouW8Q>
    <xmx:5hNhaqTdEoBvkRSUGE718AhESF5fJBOPKuEi1siTrulC94Q-wDPTKg>
    <xmx:5hNhaosQVgpBfmbsLYYxMX-sMm5PxZpKYEQxnJo_YyG-x_sCHw-vnw>
    <xmx:5hNhajY139nir176OqPBb4tagDBErFroB4ZAwHjPq5VABBN9o8Eh1w>
    <xmx:5xNhasYtKkJoBrnF8UOf0Z0Z5aRIBqcpxeMkBzJXO6jZcJOGazP9YifW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jul 2026 15:03:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Harald
 Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v4 2/2] remote: find tracking branches for URL push
 destinations
In-Reply-To: <08c432a2d4f52c202a2bebaa72330a17e94aedd1.1784743738.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Wed, 22 Jul 2026
	18:08:58 +0000")
References: <pull.2358.v3.git.git.1784664859.gitgitgadget@gmail.com>
	<pull.2358.v4.git.git.1784743738.gitgitgadget@gmail.com>
	<08c432a2d4f52c202a2bebaa72330a17e94aedd1.1784743738.git.gitgitgadget@gmail.com>
Date: Wed, 22 Jul 2026 12:03:00 -0700
Message-ID: <xmqqpl0eoniz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +static bool remote_has_push_url(struct remote *remote, const char *url)
> +{
> +	const struct strvec *push_urls = push_url_of_remote(remote);
> +
> +	for (size_t i = 0; i < push_urls->nr; i++) {
> +		if (!strcmp(push_urls->v[i], url))
> +			return true;
> +	}
> +	return false;
> +}

A new helper is very much welcome.

>  void ref_push_report_free(struct ref_push_report *report)
>  {
>  	while (report) {
> @@ -1887,13 +1898,45 @@ const char *branch_get_upstream(struct branch *branch, struct strbuf *err)
>  	return branch->merge[0]->dst;
>  }
>  
> -static char *tracking_for_push_dest(struct repository *repo UNUSED,
> +struct remote *repo_remote_for_push_tracking(struct repository *repo,
> +					     struct remote *remote)
> +{
> +	const struct strvec *push_urls;
> +	struct remote *first_match = NULL;
> +	struct remote_state *remote_state = repo->remote_state;
> +	const char *check_url;
> +
> +	if (remote->origin != REMOTE_UNCONFIGURED)
> +		return remote;
> +
> +	push_urls = push_url_of_remote(remote);
> +	if (push_urls->nr != 1)
> +		return remote;
> +	check_url = push_urls->v[0];
> +
> +	for (int i = 0; i < remote_state->remotes_nr; i++) {
> +		struct remote *candidate = remote_state->remotes[i];
> +
> +		if (!candidate || candidate == remote ||
> +		    !remote_is_configured(candidate, 0) ||
> +		    !remote_has_push_url(candidate, check_url))

This part used to use remote_has_url(candidate, remote->url.v[0]),
which only looked at the .url and ignored .pushurl.  Now it uses
remote_has_push_url() so we grab the effective push URL for the
remote we are dealing with and match it against the effective push
URL of the candidates.  Looks correct.

> diff --git a/transport.c b/transport.c
> index fc144f0aed..30a4ab2cd5 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -1553,8 +1553,11 @@ int transport_push(struct repository *r,
>  	if (!(flags & (TRANSPORT_PUSH_DRY_RUN |
>  		       TRANSPORT_RECURSE_SUBMODULES_ONLY))) {
>  		struct ref *ref;
> +		struct remote *tracking_remote = repo_remote_for_push_tracking(
> +			r, transport->remote);

Personally, I would have line-wrapped the above more like this:

		struct remote *tracking_remote =
			repo_remote_for_push_tracking(r, transport->remote);

This is just for a future reference; it is certainly not critical
enough to warrant a new iteration just for this.

Thanks.

