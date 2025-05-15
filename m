Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F50525A2B2
	for <git@vger.kernel.org>; Thu, 15 May 2025 18:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747335107; cv=none; b=d3ThZZXs0osv+dyAcQ+gRFp4uSDXomoYcdJ3INT6aoYMdgEYl6bxm/eWTI1HtJgDZrIAsp0/Q4/7UVWp9NA8aGmMwKOBq2R4TPsvcRy0vIIbi2wIh4zmVJoabt/hIwrLNgU0RGYBih8xtCkQAf+KFPHLX2jaS083OyvJqQ0vo1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747335107; c=relaxed/simple;
	bh=w6aqbIWDTjD8GDe59r20oyMh4GwAWHQS+j7u8d9oKB8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IL9FAxE/sFPQ2XLGZSNstYlvX9FzVDzqed7RTjrMgs6L/Dx0W7wblECpckELPCR6S5LIOeAWlCP0LPbAKVMkD2h03MyLrocF6x8C2eCPu7gvnbJGFQgmC4yB9VljIwDQmDn1+9fyVh5SLyYu3tXuSifbFyYwtBgJ2Tqc6g7up8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hlR8QVuF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b9X+bAHN; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hlR8QVuF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b9X+bAHN"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 827691380205;
	Thu, 15 May 2025 14:51:42 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 15 May 2025 14:51:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747335102; x=1747421502; bh=aaKMxwHNqv
	q5wZvXzaNEoT72HhubJ3kBiYHaRx1hFO8=; b=hlR8QVuFfNSDEJwkKkny5PsClO
	YfruqGFv+Ih6vsyE79e/j/wpenqT/pwf5w0N4dpiwzNDipwvq8d65ixsKIhQGriC
	3cTe4ds2WvpgvYfmtGezTpk19VkS7u1H3Uzj5kg7dWEGc9+gGvFFJP4+pne/S/6C
	ns193OG3xudS9RpRGJom1OQ3E7xDyzhdOffldDlZIMe58FN4o9NQWp0xrX869pmt
	WSIAkDTfQCd0SUtOPbk+Yv13nBWukkpAIZsG2hPxfW4anW7XNogKp0h0PVOgYgao
	76W4J4tlHf2d4c7YN6FSFKEizaIgtSXUCnjDzeVd0CsG3k4BUixNhmat4mxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747335102; x=1747421502; bh=aaKMxwHNqvq5wZvXzaNEoT72HhubJ3kBiYH
	aRx1hFO8=; b=b9X+bAHNfIeVLdjV1GX+HWdbLkIuQmrrVmyQ9ZDbJAxmuEtmkXP
	v+7fCePxe91pqLSwu8X+yZBNI1ylOXFf+bPfSv1XrdiEWzwieVUKToa8uqbQQ7YZ
	weW0cHTqms8yapJB6XU4mZHUccJVTRP/u5YH1ME7sDp9+puJ9hiEdeseQ+JR3VNS
	UhvvaoSz34mxu01MdTP/IeTn8LgZRzqYxHbvYw4VIV/7uISo1QEdVz1/27DBr8BB
	1ETuNGAnwgV+6Fd1iOd064B02p0E2+cfovc9mCO7zx4/qBLbfDSzdkmWktgjGLXy
	0FCPRAKhFdyqawAkbu3juj2GdocyC1yCvsg==
X-ME-Sender: <xms:vjcmaCMdvFzpGtJgPYt561AhP9E4UCiv2b3DTgwME--sDtoeV9HczA>
    <xme:vjcmaA_2f_wyYlbgaXmtzVneyAeON63PcPr_HOUbKmLW99WluhRJ-fuGQsccGMFed
    BjfyPb08FpJFzYprA>
X-ME-Received: <xmr:vjcmaJSWwUj1w1O4a_kpwBl0gwHEB6INwG-jZ9UqP63DEscdxCXBiEl0xN7EyfVjDkWc7qWsQx4ieln49rmJgbaPDeJ35rmTNAMNtn0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefuddtieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtgh
    grughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnse
    hgmhigrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:vjcmaCuBCVUoyClMFxC9pb-s52yt_VlhNGY23CrNpKCftsGrjQbsPw>
    <xmx:vjcmaKdlAFmFTCj8KxlTNJQV7xo40YiPLYqWl4su1wYWq8k4onA7TQ>
    <xmx:vjcmaG3uWUmDPTN69GnVJwXYyf4ZQU21jDpmAyK08xtAsdwSytCl4w>
    <xmx:vjcmaO8Dmsy3NZ3Z317S7Nz9nE4CeqJsPNjnSggcnK1Zs6IYSnPOmA>
    <xmx:vjcmaLqVmbX5IJtVMyrAn19mA_O4x1IA6mlzWzGH74DJP6AUkGf7HKxc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 May 2025 14:51:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 11/11] sequencer: stop pretending that an assignment is
 a condition
In-Reply-To: <7a54005bd26ac17cb6d99a2e18932f97575d4aca.1747314709.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Thu, 15 May 2025
	13:11:49 +0000")
References: <pull.1891.git.1747314709.gitgitgadget@gmail.com>
	<7a54005bd26ac17cb6d99a2e18932f97575d4aca.1747314709.git.gitgitgadget@gmail.com>
Date: Thu, 15 May 2025 11:51:40 -0700
Message-ID: <xmqqplg9zozn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In 3e81bccdf3 (sequencer: factor out todo command name parsing,
> 2019-06-27), a `return` statement was introduced that basically was a
> long sequence of conditions, combined with `&&`, except for the last
> condition which is not really a condition but an assignment.
>
> The point of this construct was to return 1 (i.e. `true`) from the
> function if all of those conditions held true, and also assign the `bol`
> pointer to the end of the parsed command.

True, as the value of 'p' cannot be NULL at that point where it is
stored to the pointer variable bol points at.  The second paragraph
above does convey what the long expression really wants to achieve.

> Some static analyzers are really unhappy about such constructs. And
> human readers are at least puzzled, if not confused, by seeing a single
> `=` inside a chain of conditions where they would have expected to see
> `==` instead and, based on experience, immediately suspect a typo.

Yes.  Good thing to get rid of.

>
> Let's help all of this by turning this into the more verbose, more
> readable form of an `if` construct that both assigns the pointer as well
> as returns 1 if all of the conditions hold true.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  sequencer.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index b5c4043757e9..e5e3bc6fa5ea 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2600,9 +2600,12 @@ static int is_command(enum todo_command command, const char **bol)
>  	const char nick = todo_command_info[command].c;
>  	const char *p = *bol;
>  
> -	return (skip_prefix(p, str, &p) || (nick && *p++ == nick)) &&
> -		(*p == ' ' || *p == '\t' || *p == '\n' || *p == '\r' || !*p) &&
> -		(*bol = p);
> +	if ((skip_prefix(p, str, &p) || (nick && *p++ == nick)) &&
> +	    (*p == ' ' || *p == '\t' || *p == '\n' || *p == '\r' || !*p)) {
> +		*bol = p;
> +		return 1;
> +	}
> +	return 0;
>  }

Perfect.  That's quite a natural way to express the intention.



>  
>  static int check_label_or_ref_arg(enum todo_command command, const char *arg)
