Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1001F4192
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 15:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758900567; cv=none; b=Viqdh8cX1049MMh8cm23586yGQ3jyNW7n83a6Ha1RxcidtZmJMiC9/5OTgJUvL3Ma2MkPVtfyZMy5CTaZlgEu6VoN8CFqva/GmDtwvL7nfMhAe/kB1zJx47IMrgHhjpMJUkQ6d0L+mlXrtk8QG8l/0SQHnJGiZS7NWatOW/HKbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758900567; c=relaxed/simple;
	bh=It8Myx60AN+Xz17Lp24ie1itqKxWFLK4Qz+NaBs+ORg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TSBoYtZMftoxGvIbk5FCUMk6Q5zgf2Aht8feCjtxKPffKELrnMl1yivo+5QiC6C/faT1EwUB2TGe6R6dCTRVN9KYV31UXvdlw11lPMAvW/2sx6gt0b+dLImbZdXPubmlQKflc2hdutq8l5TR+5FVZQT7D7hwdvOzS9mmvZjTsOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KzLB9Njs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uXjH1BRd; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KzLB9Njs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uXjH1BRd"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D8AF07A016D;
	Fri, 26 Sep 2025 11:29:23 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 26 Sep 2025 11:29:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758900563; x=1758986963; bh=vUINAaJZGi
	V2DzUmzZNB/Aj7zj2kmabPCRIsH2Qq4eU=; b=KzLB9NjsK3IN3rmTPLkOkzsJBQ
	TUcH0ekTjcLrWUt5S4vLfFRcmZfLEgYgOCk7UqdABq05m84++Y43ceQvAyepDVAN
	X79hJn3O7eP+k3Lr3nRImi5rh1uL4NUdRjQs+PykUzTWEIyPDKSWS6QFn6526+GZ
	ZadVP1gAvWE03ghkohJvQzBqc3XcSvkX6I+8kQq+SNLrxR+3ruvXwr4D8eE4WBSA
	+cfi95xugO4buKZU5G5nRU9CSAAEMHTP9tG8sXg3Cu4b7dW3IFgwPfnV+LSLH9ml
	3QG5yvgtk1TGLl4FlPgsEyiF5QX2nBZBcqr9Of4pd+Ul1CPRup/4NDguHqCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1758900563; x=1758986963; bh=vUINAaJZGiV2DzUmzZNB/Aj7zj2kmabPCRI
	sH2Qq4eU=; b=uXjH1BRdd7OJK3HHZnHpKxarPLjEcO/ZdLp+q26nS8mjQumdCwR
	2wb7hO8AMVhMmaU31Q+Gm3A8TDYCGMGY5VV/wFjJLGMC22WK+BeSnAHgn6oWLhuu
	qPQDNcSViOKdEHfSF418E9ICMxL+ehcKcpP90zswjT28ThWMUfWO3lbmZ/q+hpfQ
	d/ry4itDnphlLhc2vX7QcEBnuVn53kHlgt26w84j4qAISW5GSGMaH7Nw/FX2KpOt
	d11/r1StJieiBqB4f9qaO3gGmrXQG+RlDLWpBldEB47nWM7+Jsxh96cqxjnYVh1a
	+hNSDedKJXlBCAmGMSd20Mhs9DGTQQvNwSQ==
X-ME-Sender: <xms:U7HWaEecULkXHW74PUjSIgi3efsEl70PX92J9RNJfL_WEUqst_SWzw>
    <xme:U7HWaJ6Vn-5yYCZfB2Zap20JVfuzVhPGXPUD_5ji35SB9auIBtfzUU0TpyaBV6yiY
    qXkypF6I4cSMSc3N21a80t4d2iHPPdzybHsNtvABaYY0AzAbPA>
X-ME-Received: <xmr:U7HWaPUCyjSrJT4nuAESmncJZRyiOo7Rb7BQvD8mHf1PtpNY9zXshhsTsODclbM68BQkvt9xlaSNNjooqoD1dxszVyNSyHdCl53G>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeileejfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeetgefhffduueejfefhhfdttedtfeffheeilefhudegvdffhfelfeffleeggeel
    ffenucffohhmrghinhepuggvfhgruhhlthdrrghsnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhulh
    hirgesjhhvnhhsrdgtrgdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhr
    ihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:U7HWaA7QdAwpmHpPDZbJrI9_82BPeMBpHsKHI8QiwmIXeO_-KI3Wwg>
    <xmx:U7HWaCr5BphoFy2fK9LtGN9CH_N0SK06o8lODfnzrx8Dlm5HnksZFA>
    <xmx:U7HWaLnxu6x6x1qrNl_UVBwnGqdgcd6_-UNQDldqK3J304ZrzIHWJQ>
    <xmx:U7HWaGOYxrk1h-U8YEIJMxdWmgIlpiE9AW7-SsPIb7gf-Q4Fs7UxoQ>
    <xmx:U7HWaND1aTas-rnM2G_wF5RSNpx6aIUxniqd4QfFeRYgR9PvSZIPHmgI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Sep 2025 11:29:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Julia Evans" <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  "Kristoffer Haugsbakk"
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v3 4/4] doc: git-push: clarify "what to push"
In-Reply-To: <xmqq348admuo.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	25 Sep 2025 18:27:43 -0700")
References: <pull.1964.v2.git.1757703309.gitgitgadget@gmail.com>
	<pull.1964.v3.git.1758649472.gitgitgadget@gmail.com>
	<be6453d010bdc9d2b49988d6841dd7e7f9bdf1f8.1758649472.git.gitgitgadget@gmail.com>
	<xmqqqzvvk4bj.fsf@gitster.g>
	<2365a7b9-3d22-4406-876d-65822822655f@app.fastmail.com>
	<xmqqzfaidyil.fsf@gitster.g>
	<1422594f-b0a8-4a7a-bf78-940693757224@app.fastmail.com>
	<xmqq348admuo.fsf@gitster.g>
Date: Fri, 26 Sep 2025 08:29:21 -0700
Message-ID: <xmqqwm5lcjvy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

>> But I'm not sure it's true in this case: we just said above that
>> "The default is `push.default=simple`, which will push to a branch with
>> the same name as the current branch."
>
> So I think this simplified statement is what causes confusion.  It
> says push.default=simple will push to such and such place, but that
> is not true....

After sleeping on this, I do think that at the crux of confusing
wording in the current draft is the lack of stress on "simple" being
a narrower special case of more general "upstream" for various
push.default modes.  In either of these modes, unless told otherwise
with the configuration file or the command line arguments, "git
push" pushes to update the upstream of the current branch.  There
is, as you said, an additional safety measure in the "simple" mode,
that rejects a configuration to have a branch whose name is
different in the remote repository as the upstream branch.

In other words, the push.default=simple mode does not tell Git to
push to a branch with the same name.  Rather, as a variant of the
push.default=upstream mode, it tells Git to follow the same "push to
the upstream branch" rule, which requires you to configure your
upstream.  But the mode gives additional limit on the name of the
branch that can be set to upstream.

We should make our text clear enough that anybody who read about the
push.default=simple configuration easily understand the above.  We
would need to find a good division between what to put in the main
text and what to leave out to the "see ... for more detauls" part to
guide those who read about "git push" command to the same
realization without bombarding them with descriptions of full range
of possible values of push.default.

Peeking our earlier exchange to help me formulate my thinking a
bit...

> +To decide which branches, tags, or other refs to push, Git uses
> +(in order of precedence):
> +
> +1. The `<refspec>` argument(s) (for example `main` in `git push origin main`)
> +   or the `--all`, `--mirror`, or `--tags` options
> +2. The `remote.*.push` configuration for the repository being pushed to
> +3. The `push.default` configuration. The default is `push.default=simple`,
> +   which will push to a branch with the same name as the current branch.
> +   See the CONFIGURATION section below for more on `push.default`.
> +
> +As a safety measure, `git push` may fail if you haven't set an upstream
> +for the current branch, depending on what `push.default` is set to.
> +See the UPSTREAM BRANCHES section below for more on how to set and
> +use upstreams.

... here is my attempt.

    3. The `push.default` configuration. The default is `simple`,
       which is a variant of `upstream`.  In either mode, "git push"
       updates the configured upstream branch (see the UPSTREAM
       BRANCHES section for more on how to set and use upstreams).
       The 'simple' mode has an additional limitation that the name
       of your configured upstream must be the same as your branch.

(iow, I rolled the "As a safety measure" paragraph into 3. itself).

