Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FC92C18A
	for <git@vger.kernel.org>; Fri, 30 May 2025 13:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748612124; cv=none; b=YvBkY7b7GfjRE7Q2YmLrL5dssFsA7wGMVabDOfX0TB+y4un4bKVuo8+YTQ31qwA6ogba0h04U5BzBcZpHpWJ7IBoiKmSl0aD7GGu9PAtXytDkpJdcXO40FR7ZK38TdRav1XC9HZal36zYrUKGDN7Xz21+CZoEtx0ghi0EWDLhc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748612124; c=relaxed/simple;
	bh=2hpUzyH2ZCtMmklXjtUuWAPvH1tF+d6QZetPf92XHFk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uJ4sYPYw0DVdy8OO/i/YSiKVVL9bsHjjbjia8JHtkRIQpFaf9YXFOKD9pGv2XWGky2yabsX0dQWwwDJOaS40L2gLZiVpbDzKiyTydq+yENs75lJ4zLLnvttsFdWuJ2H6duKqvMDR6VfYdp7KA+6JljDAxzi++QUEGRWhqbupfUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=yyn+WBlO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GZz6ecnA; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="yyn+WBlO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GZz6ecnA"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 903301140136;
	Fri, 30 May 2025 09:35:21 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Fri, 30 May 2025 09:35:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748612121; x=1748698521; bh=d+RI2S5eCu
	7I9I0tpvKI1Lj90Ytfmc5cm7gvbHqj48U=; b=yyn+WBlOH50iW9mabEkTE9kNZS
	kri5WZnrujofAclT/ia0OJza4AUMOqljwgKs5T10SD3aTydtPPM/YKeEMwOQzrx1
	jwCMrzRtrq99J6AK1FIIT3j32sEbOqrEEknKCu6lGEVAipHkI4HjYe3yYQRyHQBj
	D6olK0unlvYA+uMhZwF5/t29Uml9jvGFSd3HZUg3Ix5E9P4X2BwkyAbRCbbAhSVj
	+z19ng9Y23+V5C1Nb6EZNa037yz+3T3p+aFnsDQPyf+Za8Mh1odBh57DJOAYEA0n
	M0Ruv3FTlMViX3JvZxqM9LRKvUWQZ83IauCAxZyQZDiWT81USZSC7Q8O0AMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748612121; x=1748698521; bh=d+RI2S5eCu7I9I0tpvKI1Lj90Ytfmc5cm7g
	vbHqj48U=; b=GZz6ecnA0zeu0aZf9hz8WtTAxUQh3It5ytTLsYC7OWIiqPde8LR
	8K6K8xmzJXYJuzu3PSO3HjHmzY/e3demfF3vFClm7LVz35xb9iBtiMb2roCmX9a1
	wffouG2xU3sC4m6wNDHZRcy80cE27WUeZoN3ZNcSBKeBf7lxbr9Z0lQHcEEXheqM
	bHe2WPCAbbVNnoaYqah447UDvSZvGlx7BYqj7il3A6z5jeRBXEXzOH9LxcJf1H9q
	7cNjtcRNUE2kANWABIpbZjtzB2F7/qv6iFGK0gXJ/EYcXuvY9JGpZrFqG63mLrHv
	oiINRxKImmzRNwv9ZTnvUFpUqdh9vVzX5+w==
X-ME-Sender: <xms:GbQ5aBU9mzdeeJnoZf9zqcFO-fnL64S2jeR-fevWacYQF7ASf42JIQ>
    <xme:GbQ5aBn8S_OSeLCtOVSpkKVOzNOBaq0ctgxDiNe2hexjwbpXyADr1ZAxH-eAriGDh
    -xTxNGk9yeWFYFtkA>
X-ME-Received: <xmr:GbQ5aNYkRejmcxWTA9Oq0GsMGtz85dXV7sDwdMTuSOLZwICr17gmSF6d98TzjdHOq18FhHXg4RRIubndj_ncYGHf28_cvBRJ7MkMSVU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvleduheculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteej
    heeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfi
    hoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopeehtddvtddvgeeffedttdeh
    ieesshhmrghilhdrnhhjuhdrvgguuhdrtghnpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:GbQ5aEVftNLZ7ugz0elcZZPgjHMJnvKzSRg5HMAH2NWXfT-AIDc2mg>
    <xmx:GbQ5aLlSRKrK1HQkvmXfU0h3_x8-LgEvTKM0bmkpeKid3PnKuchVCg>
    <xmx:GbQ5aBcL3BJOU0BSB4EJqWwx04vgjwVToqQr-ouCFk7ohNh0FNkUKw>
    <xmx:GbQ5aFH0eFdgfwjZbMqTzUvC-VLihVdPZgImj7ulvWkGp3hM697_SQ>
    <xmx:GbQ5aLLqtL_1j1UqItjehXW6ghey6j0H7aB6iJCTtyg509mKxZxdzHzU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 09:35:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Lidong
 Yan <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH v3 1/2] sequencer: replace error() with BUG() in
 update_squash_messages()
In-Reply-To: <b812f973d18fbef104f2d30f4719fcc58c8578c0.1748569955.git.gitgitgadget@gmail.com>
	(Lidong Yan via GitGitGadget's message of "Fri, 30 May 2025 01:52:34
	+0000")
References: <pull.1964.v2.git.git.1748168353204.gitgitgadget@gmail.com>
	<pull.1964.v3.git.git.1748569955.gitgitgadget@gmail.com>
	<b812f973d18fbef104f2d30f4719fcc58c8578c0.1748569955.git.gitgitgadget@gmail.com>
Date: Fri, 30 May 2025 06:35:19 -0700
Message-ID: <xmqq7c1ygr1k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -2067,6 +2067,9 @@ static int update_squash_messages(struct repository *r,
>  	const char *message, *body;
>  	const char *encoding = get_commit_output_encoding();
>  
> +	if (!is_fixup(command))
> +		BUG("unknown command: %d", command);

This is not necessarily unknown.  It may be a known one like
TODO_PICK but the reason why we are rejecting it is because it is
not either FIXUP or SQUASH, so we should say so.  BUG() is a message
to our developers, so a clear message that tells them that they are
not supposed to pass anything but FIXUP/SQUASH is far better than
saying "unknown".

>  	if (ctx->current_fixup_count > 0) {
>  		struct strbuf header = STRBUF_INIT;
>  		char *eol;
> @@ -2134,8 +2137,7 @@ static int update_squash_messages(struct repository *r,
>  		strbuf_addstr(&buf, "\n\n");
>  		strbuf_add_commented_lines(&buf, body, strlen(body),
>  					   comment_line_str);
> -	} else
> -		return error(_("unknown command: %d"), command);
> +	}
>  	repo_unuse_commit_buffer(r, commit, message);
>  
>  	if (!res)
