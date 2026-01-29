Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CD334C81F
	for <git@vger.kernel.org>; Thu, 29 Jan 2026 17:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769707743; cv=none; b=pM+Fpq26IIxj24yIpyqEM2pN+iZqNC3fDMQTrS89xYmn4SLa3OrPXkBfYKFxJANWJQuBGYI9kP9x+Sa0EZaWC5u6cPfnwSLhXS4lxscEF7OORzL9hauLz/xwi8xJyJygu5EBRrwApgPt2QElCfUhpFls0Jy2tzRWUB+zu5DY5XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769707743; c=relaxed/simple;
	bh=4SDXZggCKsJ+bYSokxa6ZdDg+L/TbXl7TGcUPd6mhTM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gWUNq9Swnp0GI9U3afyGoQXsow9sYGz0vAKIdglVJjwY2AXk/2cOx0xNdrae4Ir792ObN298UBB5JE4nPDEihpHhbsyvJRSKv7VyznN1gp12LFmiY552lrzrmkMJ65eIS4bIZ8xOhyIw9KsACcSWEhof9VkJy4uhDorJTE83Wjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ae33WeY4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hJcBj6Kr; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ae33WeY4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hJcBj6Kr"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A8500140005A;
	Thu, 29 Jan 2026 12:29:00 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 29 Jan 2026 12:29:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1769707740; x=1769794140; bh=wrKkvxHqyQ
	Qg/Gq76+n+aDwUjSauZYcuMv3nUbubSgI=; b=Ae33WeY4sDzNrXmUeDNavt7Ar+
	nkUeT4GO3X/AGiR0MkiUFlBYAPhHj/iFptjMwGhuQgUuYAwj/rbF60xm7ZcDJ5+e
	uY7PpThRK3tBRjC4jcjSrEr812PeuyAIGnwzYlLs7v/gNyoQ06HjWOfhVRQxlpgc
	MA1SKLTNzVNo6zrotBNErBpP2KJdSao4HZySsMGW/aA9HTbhuPKeCjfk56uHTPAn
	M1/4blliDu/pCrHOVCASSvTsZcYCv0VH2HsfY72nCcSun9/wyov5N9mPL1x4psAD
	vEKxbV5M3AXGpDrvGetp8xK2N+me6kpgQOyMc2XPsjRKAT60ZXqTXa8dwSgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1769707740; x=1769794140; bh=wrKkvxHqyQQg/Gq76+n+aDwUjSauZYcuMv3
	nUbubSgI=; b=hJcBj6KrXBCJniXPTy8UKsT0TGzXnLPs0xTStDdcVAb+x/kLXsX
	GJ07eZ0ufmhEiPJmmdin5sgmnxbOvvYAKx1Ohb9fqCJFtWmZBn+G6j1iHT/xf7sW
	tWiEPoVnFau9INIlzloHOdxGAPJRMQSGBVwJkZb9dqOs252dAZbbfHEKY3oDXC+O
	s8Qg9GRLQymAeftm8pMzrnI5bC/vLO5E29avUAfA4DALbT9D1q0BP7dkZAPXdtV4
	Z9xg57vVh/uBPx9FmVSytFXJUx45Mn9nFAhVF9uhf8RAXtZUInNC0/VZvjQCFbY1
	3bLHJkICQEo+uxdFkTuEyjUsS6bJ+qqVU1g==
X-ME-Sender: <xms:3Jh7aULGG1QzrAQG0up_5usVtiVBaTIVaedu6feLxJ3OU-s-CdGGFQ>
    <xme:3Jh7abCc99_hqLOqVwzmEcLfXZQmteXiKaex3qs8RgDic9HNml9nt8FePN46IyPWW
    gYVQx1KbfT6JbkgdbuX6IPmgakPUMPs8FGNr6fP1cgNmvJQWXLxsg>
X-ME-Received: <xmr:3Jh7adBphoi1BJB7GBK0Wp2J7kuxPneahZSOM6NICphPWW_vmUnVdqbOmftc7Gm0zHEqLQi_ZYHdaGPwLNEmJPP-iNi6wniJtlbnzig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeijeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:3Jh7adAXrVWL4GqOaSykij3gxe09l6e-MOM048y4usmhmdMuUxPV8w>
    <xmx:3Jh7aYrA7YZ4yL_sZLcuf9T6u3V4W83OeEzAGHTSpub4Fr4Q7yWsdA>
    <xmx:3Jh7aXlQaz0FhWITZKn-7BtRKSGo0MQcjC2V7qfgYvyr9FzoxPDazg>
    <xmx:3Jh7aYxBwwTh9XL3iq3xiLXlBDsyXoADMPSIY9SdOhHFyk1PwR3hIg>
    <xmx:3Jh7aQReWWkwXHZhjCvaTwcAUW7kq2Cgtq0l1IZQHgcGxiJz00BFpx3y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Jan 2026 12:29:00 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Taylor Blau
 <me@ttaylorr.com>
Subject: Re: [PATCH 3/3] bisect: fix misuse of `refs_for_each_ref_in()`
In-Reply-To: <20260129081420.GA589284@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 29 Jan 2026 03:14:20 -0500")
References: <20260128-b4-pks-fix-for-each-ref-in-misuse-v1-0-deccae3ea725@pks.im>
	<20260128-b4-pks-fix-for-each-ref-in-misuse-v1-3-deccae3ea725@pks.im>
	<20260129081420.GA589284@coredump.intra.peff.net>
Date: Thu, 29 Jan 2026 09:28:58 -0800
Message-ID: <xmqq343ocopx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Wed, Jan 28, 2026 at 09:49:22AM +0100, Patrick Steinhardt wrote:
>
>> Furthermore, taking a closer look, we strip the prefix only to re-add it
>> in `mark_for_removal()`. This is somewhat roundabout, as we can instead
>> call `refs_for_each_fullref_in()` to not do any stripping at all. Do so
>> to simplify the code a bit.
>
> Yeah, I think the result is much better.
>
> We might also want this simplification on top:

Very good.  Thanks, both, for improvements.

> -- >8 --
> Subject: [PATCH] bisect: simplify string_list memory handling
>
> We declare the refs_for_removal string_list as NODUP, forcing us to
> manually allocate strings we insert. And then when it comes time to
> clean up, we set strdup_strings so that string_list_clear() will free
> them for us.
>
> This is a confusing pattern, and can be done much more simply by just
> declaring the list with the DUP initializer in the first place.
>
> It was written this way originally because one of the callsites
> generated the item using xstrfmt(). But that spot switched to a plain
> xstrdup() in cf01f617b9 (bisect: fix misuse of `refs_for_each_ref_in()`,
> 2026-01-28). That means we can now just let the string_list code handle
> allocation itself.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Even before cf01f617b9 we could have done:
>
>   string_list_append_nodup(&refs, xstrfmt(...));
>
> to get a similar simplification, but after that commit it is even
> easier.
>
>  bisect.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/bisect.c b/bisect.c
> index 2cd97bc9fe..6b9e9d81c3 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -1183,8 +1183,7 @@ int estimate_bisect_steps(int all)
>  static int mark_for_removal(const struct reference *ref, void *cb_data)
>  {
>  	struct string_list *refs = cb_data;
> -	char *bisect_ref = xstrdup(ref->name);
> -	string_list_append(refs, bisect_ref);
> +	string_list_append(refs, ref->name);
>  	return 0;
>  }
>  
> @@ -1193,16 +1192,15 @@ int bisect_clean_state(void)
>  	int result = 0;
>  
>  	/* There may be some refs packed during bisection */
> -	struct string_list refs_for_removal = STRING_LIST_INIT_NODUP;
> +	struct string_list refs_for_removal = STRING_LIST_INIT_DUP;
>  	refs_for_each_fullref_in(get_main_ref_store(the_repository),
>  				 "refs/bisect/", NULL, mark_for_removal,
>  				 &refs_for_removal);
> -	string_list_append(&refs_for_removal, xstrdup("BISECT_HEAD"));
> -	string_list_append(&refs_for_removal, xstrdup("BISECT_EXPECTED_REV"));
> +	string_list_append(&refs_for_removal, "BISECT_HEAD");
> +	string_list_append(&refs_for_removal, "BISECT_EXPECTED_REV");
>  	result = refs_delete_refs(get_main_ref_store(the_repository),
>  				  "bisect: remove", &refs_for_removal,
>  				  REF_NO_DEREF);
> -	refs_for_removal.strdup_strings = 1;
>  	string_list_clear(&refs_for_removal, 0);
>  	unlink_or_warn(git_path_bisect_ancestors_ok());
>  	unlink_or_warn(git_path_bisect_log());
