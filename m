Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1582BEC43
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 14:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229304; cv=none; b=Ru0C6YOwi9lf957tRbW8MZ1e1zopgCrmJrhQkKss3VFrejpRr+4JeRUGHLwoyQLHWa4Ynz7coNZ5HvhyNmqVvcGk3+ZsXWDCrj79p8yYRVoZrXN7WrRbP+XDYFMNByhKU3EP+qammttTBD6CE5C3ncKO1o+NKQUrwQ02h4WW17k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229304; c=relaxed/simple;
	bh=9UK7K8V0Z484KFfHNCbeAwGUJYMRqDQHPV8VlUvG6JE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LkV3zIpSsu9pM9kIud02iHh5BrB5d7HfRwZ+jXO69x9/iliIjQZKzMl5H2kMBxVGkh4i6Ftl4GAxvIAojZiqfBn+c8AkYAa5ERG4UaSwqyVMztazCnE/TBN9Ul8wUCQ2an3nfO26dgKTO+EM0Hua+VpGEJqaokiHRb497X4JTG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XNL4e58S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pbWYoS2s; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XNL4e58S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pbWYoS2s"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ED24F140005A;
	Mon, 12 Jan 2026 09:48:21 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 12 Jan 2026 09:48:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768229301; x=1768315701; bh=pKmJKCgcEg
	NO6T3hu9NZoxuL0YDbssLNz5uYHORWvlE=; b=XNL4e58SrTPujUC1sfs3sGpAhJ
	GNFINOoRzR3Ug8+eXWmSZTZBB+StJrwyowwss5KBWWr1tktrbsQ7vNzTgCUS+rBy
	WeQX2ohEyn557zveV5lfRXJUqHaFwA8CgPlZO9EqmWLndTNSnetqEXw42gFSugD3
	Dz2eN6Md9PyDC5s8W1ObQGlWEQYncuo4WG+cqXNNTeGcmeWHlpI5otvjr5tKYtHt
	toy6Xj8pj+LDF5nHR6IFFj+o/L2Slt4tPlJFKy6gF6I4lf4Ck3qJfNiBRZsTy9QD
	GxAtBWByl0yqtJsgJVNyP/ua0bnaZnHpi2YXQk7gimmABZC7urpYAfPXSKOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768229301; x=1768315701; bh=pKmJKCgcEgNO6T3hu9NZoxuL0YDbssLNz5u
	YHORWvlE=; b=pbWYoS2sMAvwAaOaQxozUrP+p3Q1FMr5V8D6yQWoMX/YaAzSIVl
	bajAy2a5tck6rrsbJo2fW6gQCgm5Pu8DoQY351Afq+gFZXpcnqGLx6BfuE0Nbaal
	861Cs+K+4mXwuZb08r0a8NMgQstKJ8Fs/FJR4kmYK9BpjeSiGz76lgS6xMnEOO2T
	V7fU+77LEiKykB6/7lSTrjQncLolbCxVIEzMskZLg4Z7fvACryMskLx25JfbC3RZ
	eST86OqhTtQgTQBVU+xx60P+p1wOvufHvEJfGw9YLotEmObLcWQUwG12ovhkymmJ
	GiAxPyfSa02SsJp0pImJy6QVxQVr1EYTl/Q==
X-ME-Sender: <xms:tQllaaTmmszw8UQMXHyKfV8O83PETbCCHQ44Yudjb2kT1820FlsZDg>
    <xme:tQllaWpyiDsee45RUQa6sdNxs7lZkdVRfay5eTjIPl0FBmPzYwWOhcUic8mMK8-a_
    SmpF2tSkfx-4Fji0Sh5PsBmvHHm2QLYgRuf8-89F-t-ud-8SGGPSEw>
X-ME-Received: <xmr:tQllaQKGrvg6P7tO9qpt4GGUFtzwVQgHzu1woOFLryAInsispi7MXVoEfeMqNjPURoo9xEm2ZgM84wNAtrSEAEvIGZpWGMhYZ5MCCa8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvvghs
    hhhighhurhhgrghonhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhn
    vggtohdrtghomhdprhgtphhtthhopehpuhhshhhkrghrkhhumhgrrhhsihhnghhhudelje
    dtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:tQllaRoFLnpDy3gsfSWKV_y4POcTWgQldmXeWT1rUoFzQthpIqKtLA>
    <xmx:tQllaQxFO9NYv9pJfhocO-baSLseekvtBvRoa0VoPitgvYOiQLwXpA>
    <xmx:tQlladOHUUNb-1tmg-KtvZWGOrgiX11xDQyC3mGoW8UqEHYZpHnDCw>
    <xmx:tQllad6ue3BkMnm4uSQftGb2IwS7SuhoWvfPdFPMvaKk_Z7B9EIuOQ>
    <xmx:tQllaXFy9ISCGzoUK6Zz6FuO4opO_k_NDBmSGhUlEzN8c31wjGhpw9ar>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 09:48:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Deveshi Dwivedi <deveshigurgaon@gmail.com>
Cc: git@vger.kernel.org,  sunshine@sunshineco.com,
  pushkarkumarsingh1970@gmail.com
Subject: Re: [PATCH v2 1/2] t5403:introduce check_post_checkout helper function
In-Reply-To: <20260112065301.1290-2-deveshigurgaon@gmail.com> (Deveshi
	Dwivedi's message of "Mon, 12 Jan 2026 06:53:00 +0000")
References: <20260111072950.9463-1-deveshigurgaon@gmail.com>
	<20260112065301.1290-1-deveshigurgaon@gmail.com>
	<20260112065301.1290-2-deveshigurgaon@gmail.com>
Date: Mon, 12 Jan 2026 06:48:20 -0800
Message-ID: <xmqq4ioqopjf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Deveshi Dwivedi <deveshigurgaon@gmail.com> writes:

> The test file repeatedly uses the same four-line pattern to validate
> post-checkout hook arguments: read the args file, then test each of
> the three values individually.
>
> Introduce a check_post_checkout helper function that encapsulates this
> pattern. This patch does not change test behavior; it prepares the
> code for improvement in the next step.
>
> Signed-off-by: Deveshi Dwivedi <deveshigurgaon@gmail.com>
> ---
>  t/t5403-post-checkout-hook.sh | 49 ++++++++++++++++++++---------------
>  1 file changed, 28 insertions(+), 21 deletions(-)

OK.

> diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
> index 1462e3365b..7bdea25107 100755
> --- a/t/t5403-post-checkout-hook.sh
> +++ b/t/t5403-post-checkout-hook.sh
> ...
> @@ -109,7 +115,8 @@ test_expect_success 'post-checkout hook is triggered by clone' '
>  	echo "$@" >"$GIT_DIR/post-checkout.args"
>  	EOF
>  	git clone --template=templates . clone3 &&
> -	test_path_is_file clone3/.git/post-checkout.args
> +	check_post_checkout clone3/.git/post-checkout.args \
> +		"$(test_oid zero)" "$(git -C clone3 rev-parse HEAD)" 1
>  '

All other hunks are as described but this one is slightly different,
which may want a mention in the proposed log message.  We used to
only care about the fact that post-checkout hook was executed, but
now we check that we invoke the hook with expected parameters.

Other than that, this looks good; so does the next step.

Thanks.
