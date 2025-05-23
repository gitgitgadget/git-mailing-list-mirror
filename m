Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC7C101FF
	for <git@vger.kernel.org>; Fri, 23 May 2025 22:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748038750; cv=none; b=A5TPPJdjp1LKlYSHUygW+BEstg/DJHjL+BSBRnHiE9wIw6kn0lAhCfWOoG2piELSLs/woe7jXZv65Cw4mamqojIbPh9A7YT2aoRHhZJm8qFgr7RKSPwlePondi+HS7jmraPR6p6m5X1ISdsY1J1AA85CI/TvdxvmptH1FgiEScQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748038750; c=relaxed/simple;
	bh=xXlYEZMs5MHaZMRtSz+DdrzzE0oLf5U5ru34hDqWxx4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jTacrumsVSf7fWs76RRaHPQ6ia/CQzsVLkQxUiGjfatmpzspyClIHx22Nob8/m5ERUQamo+fyfCLJYXAiBi69zx/f7wPwyXd++hbU754xLNfOYQBmQ8BiKoT4esHjTHAS+7WRMrvZ7HzkdMUf2l1gK+v3Q8hA2W/4X2TYYqahQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eJvU7hF+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ITcGaIpP; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eJvU7hF+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ITcGaIpP"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A750811400D6;
	Fri, 23 May 2025 18:19:07 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 23 May 2025 18:19:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1748038747; x=1748125147; bh=U8pALAACfB
	NI9kGmwSWOxKEA0rJ2FGayEvSQn15vlLw=; b=eJvU7hF+k3Sgxp8fSB6xzlG4dX
	wm/xZbFtNB6/Aq1u/nVklF8Pj+tSe45/6iOQqWijPtRuVItS+n2vD/GrLBJ4Vj+l
	jHdfw88yvRb3vCwidORez+Vdrd3BPHRU7wyuCqEwSFig0b/DPxrNiUxOS5Ytshpe
	fYQ0jQh16u1lhAAdL8gk69+Y4w0p9oiKhxx0q8O4QTLJs9H2jrAHg3kchKzGFU79
	11OZ4xIE7o13KJ7cAwj23Lopgw4LlZiRP3ERDfSeZ61c5eShpMC8xJX8prDi2/5p
	As1YCXaQ9JKts/G8UdTutHtoaUl+EjWh3gedxoNxEKwBpnct/apPPsIOAOtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1748038747; x=1748125147; bh=U8pALAACfBNI9kGmwSWOxKEA0rJ2FGayEvS
	Qn15vlLw=; b=ITcGaIpPDhhkrB26dyQw3fB3vx87nNVEc4r6ZNA1vK7tY9kzfBL
	iVo0YEd0w2QPRdto2A1oPTgo2xV8ikUDoUecZfGhj52JHHkhRczZEBPs5G2PCdlo
	SIQF6bXhAT8D7DDhWAtY1+lunCQ1cGYYtCHNuw/q9kuerw8KT4eJesagJ2asN7Mb
	H7TO7dzBJyQ1+DDbMugoh/FUgWhnp/qi7hhVs2dnJAbNPKNxO6ZvFtA40bo1F5kx
	TUPzJRS5to67Hg6+KDU/Jzak/rnQRuON00AaGN7GAYCDV8nAGL7Pi+FKLBwe9yDi
	SqlFUnkCCCQW9KzjXm4IsP4MDsIQVd5IM2A==
X-ME-Sender: <xms:WvQwaJmOfdMihIdGXq_-tYD4XkUyZCzWeqyNpyc65tqBhfWcnXs_YA>
    <xme:WvQwaE1JlUUfPA20vHeE3akDf8cWCdnGIqE0oaSZwj9MFhYl_yGkBOAYkevKZ3ccz
    LKj9qT5-ONZLspRSA>
X-ME-Received: <xmr:WvQwaPq7xxBzDuZsrY3pMYhTCGG5ubpi56s3HrVHdD7MRah5FvZWn3qI1jPOvOdEGUYYfFYrZxVcWoP2SYPhQF0Fbae766ytO-LGjTk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddutddtfeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteej
    heeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehgrghrghgrughithihrgdtkeeslhhivhgvrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhnshhhihhnvgessh
    hunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthih
    thhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepjhhulhhirghnsehsfigrghgvmh
    grkhgvrhhsrdhorhhgpdhrtghpthhtohepiihihigrohesughishhrohhothdrohhrghdp
    rhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:WvQwaJkRSfPaL53CUB7UmQ4fZzYQpNL1ozBybD6Z4i_G0CPdB2CCUg>
    <xmx:WvQwaH24O194QvsHL3I-jNut6pd8oa2JCt5VHN8j6NGIdvLfy1kOSQ>
    <xmx:WvQwaIt3UC7pxPSc5e5IH9GXY4HugwY-3sGVW6Vo4defOmA8FavYpQ>
    <xmx:WvQwaLVZazRftFMjmqRQ9G9XJH8EcswLq-u17GLs7R3psGBMY-4qvg>
    <xmx:W_QwaMPvJXJo1EcgmR0X7zeAV86BQsaQlR-FXHK_757FvwzTuNAu6eIQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 May 2025 18:19:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,  Eric Sunshine
 <sunshine@sunshineco.com>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Julian Swagemakers
 <julian@swagemakers.org>,  Zi Yao <ziyao@disroot.org>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH] send-email: fix bug breaking shallow threading if the
 first patch is edited
In-Reply-To: <73234CC5-8712-4B7B-94BE-F643345677BD@live.com> (Aditya Garg's
	message of "Fri, 23 May 2025 15:36:19 +0000")
References: <73234CC5-8712-4B7B-94BE-F643345677BD@live.com>
Date: Fri, 23 May 2025 15:19:04 -0700
Message-ID: <xmqqwma7ug13.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> So, whenever the first patch is sent, $num_sent will become 1.

The reverse is not always true, though.

> 	# set up for the next message
> +	$num_sent++;
> 	if ($thread) {
> 		if ($message_was_sent &&
> 		  ($chain_reply_to || !defined $in_reply_to || length($in_reply_to) == 0 ||
> -		  $message_num == 1)) {
> +		  $num_sent == 1)) {

This sais "enter this block if we have sent a message and one of
(num_set is 1, or we are told to chain-reply-to, or we do not have
in-reply-to) holds true".

But is $num_set == 1 really limited to "the first message"?  Given
that ...

> 			$in_reply_to = $message_id;
> 			if (length $references > 0) {
> 				$references .= "\n $message_id";
> @@ -2060,7 +2061,6 @@ sub process_file {
> 		$references = '';
> 	}
> 	$message_id = undef;
> -	$num_sent++;
> 	if (defined $batch_size && $num_sent == $batch_size) {
> 		$num_sent = 0;

... the counter is reset when we send out the batch_size message
(and we sleep in this block, which is outside the post-context of
this hunk).  So when you send the first message of the next batch,
you'd do the same, no?  By that time, we have in_reply_to set, but
that does not prevent from $num_sent, which was reset to 0 at the
batch boundary and then incremented to 1, to reenter the block in
the first hunk, no?

> 		$smtp->quit if defined $smtp;
