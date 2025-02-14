Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9167623A9
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 18:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739558120; cv=none; b=OhE/W1eOtw+SmNZBwissMO1kLVckByd95oV4ZymhntZsjvFN+vEg9b9WI0WgRHta3tDMj2pa2PrIQowfJ85tzXxvlt9ovm/XhK4xtLpYvU7DTIlML2RihsDGjWHh5Ev4mscd7siGo4/qWd23gK049Bfm0zx/SAWrK0M/gfzK+qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739558120; c=relaxed/simple;
	bh=crS2vnl4kxuQops6eHyAcRQ0/MZgTSt0OnSAV9zZ7iM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Lt/+TNPink5IkSw/x+pR+cK2mndqSzz6+nHdZDBtAbxu6fehsBfdPwkX1dnrlvTmkE0CvTVixej0tS4HYDMJi08hJ7IKHZDp7aXqgV2qlj/1GN4fRYVEpAQr9aeH+GnFEPWWU9i5CVxeH0tT/f7Aqp2cCoa7sWg7Xgvp56tT6xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cbbs3vm1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sS5qaQuO; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cbbs3vm1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sS5qaQuO"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8C92311400DD;
	Fri, 14 Feb 2025 13:35:16 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Fri, 14 Feb 2025 13:35:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739558116; x=1739644516; bh=NwG4zVLk7J
	nepZwv12/NSQIBLlX7lej75DDK9ymuuBg=; b=cbbs3vm1tRLS8WyFbZn8OKL/JC
	hLpe/5Wjm22dtWLYLMHeBdqHp33HH5mtCjYJtje6Y20+/HjM7Xq+996cKg4a6be0
	6/dm7btL9A8AWrxIc9qb6YXzB96pEcjr2LsWXFkgPaEHvk3vD9ue88lv0kNZCsOv
	bfWo0OKkRBb/OA5nsPAiSZh7A1g/8HUcINBLiq8eMa1ai69ABAUvT0eWL+0dLIAc
	6vxqn9ZlL29frYn5Pi5CLp9U0dd4iY4kDMVcYIhj5ZwvLr95AHrM4uQTTOqE4LfD
	aQ16xPnkduYh6ECIGlZG3dHz7k/FHDdyxx6ascVJNsFfP7C1skYtgQwC3K3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739558116; x=1739644516; bh=NwG4zVLk7JnepZwv12/NSQIBLlX7lej75DD
	K9ymuuBg=; b=sS5qaQuOP8fhCanC0A4QWnnt9F3Wm2nTvPTeSRYBddnbKVJu/GN
	c7i1Gqmek9UXyQbrrku5kyRa7mA1raj2BUAj5LYr65Ww227RSOnIk99Z+SZNLllw
	Y2WinupK6CD8VmY9ZCrPM2M94xjyvkxe8mSH0ElShUWkFmIgop4C0RFt360/iOoA
	6OtkeHB3vn/6+OJ/4xAtTn6HTwvEvFBiPOpwZj+fobvw9IFNHi6zRFvCbGS4ZjHu
	OfLLIWdQBVlET7k7KyeralM0XZAdBTOhL+PSDo7iW0Ejs1GS7g23jHwETLvOO4AC
	Uv70jIRf4HZzFVB6e8EB1HenShQDojxUchw==
X-ME-Sender: <xms:44yvZ4O2f2hHA4WlgCn2Ke1HrIILy5imkoOV8ieY8xclbR7eO8Ifpg>
    <xme:44yvZ--DFF-T9EAJaxwCM2H5mQgJfV_IVZ4FdjSTPZ9FalaGmbXHYilqr_WVqvitN
    yVLnnvc5B_CMzhwiw>
X-ME-Received: <xmr:44yvZ_Q--cPqJ_fIexh4RnePwB52uyBfAANzIDQeEGorNYk4BMZCN-t6zAaTpfneu4fG7FdSWhdOj6KE5X_p9Pmh-svYDHYR33vri6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehtdefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpefhledvheeuieegudefgefhkeefleevjeef
    leduudekgeevffefgfekffefvefgtdenucffohhmrghinheprhgvfhgpphhrvghfihigvg
    hsrdhnrhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghp
    thhtohepihhtohguohhrohhvsegtrgdrihgsmhdrtghomhdprhgtphhtthhopegsvghntg
    gvsehfvghrughinhgrnhguhidrtghomhdprhgtphhtthhopehjohhnrghthhgrnhhtrghn
    mhihsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:5IyvZwtygkU1Gifwa1v6WmIAYi4AeCnjrw_FhC4rtaslBwZkNT9CIQ>
    <xmx:5IyvZwc1aLOpv7vvikGZGgfsJaDBPHWl0G_Wx9hBstABM42tcU-BkA>
    <xmx:5IyvZ016XXgn6r4ebjqs8ZsyBwnlndRd0qOxxHoox9UETG3Y52WtqQ>
    <xmx:5IyvZ0_SRzPmQvyWBcoxEA-4_HbY0FAb6E68BRwHxKwVsL_oBnn0LA>
    <xmx:5IyvZ4TCowaZPkJUknpSfnDWwJv96X-a2e2etjYut1r3LxPZhfmMaWPs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Feb 2025 13:35:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Igor Todorovski <itodorov@ca.ibm.com>,  Bence Ferdinandy
 <bence@ferdinandy.com>,  Jonathan Tan <jonathantanmy@google.com>,
  "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Tags are no longer fetched when fetching specific commit
In-Reply-To: <Z650WoqFwCSo6svH@nand.local> (Taylor Blau's message of "Thu, 13
	Feb 2025 17:38:18 -0500")
References: <71075837-D0AA-4F01-9F5D-CA10BFE93B63@ca.ibm.com>
	<Z650WoqFwCSo6svH@nand.local>
Date: Fri, 14 Feb 2025 10:35:14 -0800
Message-ID: <xmqqv7tcl6hp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> So I think the right fix would really be something like:
>
> --- 8< ---
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index fe2b26c74a..0e63621e6c 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1770,9 +1770,8 @@ static int do_fetch(struct transport *transport,
>
>  	if (tags == TAGS_SET || tags == TAGS_DEFAULT) {
>  		must_list_refs = 1;
> -		if (transport_ls_refs_options.ref_prefixes.nr)
> -			strvec_push(&transport_ls_refs_options.ref_prefixes,
> -				    "refs/tags/");

I guess the original "if we are giving prefixes already, then make
sure we learn about tags" is because the semantics of the ref-prefix
is peculiar, in that without _any_, there is no limitation and the
remote end would advertise all its refs, but if there is even one,
the remote end would advertise only the ones that match any prefix?

> +		strvec_push(&transport_ls_refs_options.ref_prefixes,
> +			    "refs/tags/");

So this change would make sure that, even if somebody else already
added a prefix earlier, we would always ask about tags if we come
into this block.  It also means when nobody has added a prefix
before we reach here, we still add prefix to ask about tags.  The
implication of which may be rather grave.  If a later code relied
on us _not_ asking for tags here (because nobody is limiting the
ls-refs request with prefix), after this change, that code will
now see that there is some prefix requested already, and if we
wanted to retain what that code does, we would need to adjust that
code (and then the need for similar modification cascades X-<).

>  	}
>
>  	if (uses_remote_tracking(transport, rs)) {
> --- >8 ---
>
> But I'm unfamiliar enough with this area that I'd appreciate comments
> from the authors of these various commits, all of whom have been CC'd.
> Does this seem right to you, or am I totally down the wrong path?

I have no idea without doing a deep dive myself, for which I have
failed to find time for so far.

I have to wonder if the first thing we should do is to update the
logic to decide what ref prefixes to use, so that it does not do
such an incremental strvec_push().  There are multiple questions in
the form "Do we need to know about X?" the code path need to ask
before deciding what prefixes to use, and before Bence's "We need to
know about HEAD, because we want to know about its symref value",
refs/tags hierarchy was one (and only?) thing we needed to ask
about.  The bug under discussion smells like the result of how
brittle the code's assumption about what prefixes other parts would
want to ask.  This code did not assume there is anybody else, and
that is why it broke when we started asking about HEAD.  Now we have
two possible X's in that question (refs/tags and HEAD).  We may want
to make sure the code is robust enough when we add the third one.

Thanks.

