Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AF92F069E
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 19:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770926317; cv=none; b=uS2k/PJPSUmAbVKJzvPsx4S9vvURNuQBCwnMhO+6mASkKmQNHvSs8OG7lDm+/jBmrkRIGQJxJxkv9PhBoVRGtPySO1xyf+lQvp0cyMddiCkGbiMy4Ls8cRbCj632pe2fxAiYKH7rpAlLp41t9a87pGPDKwnMH3MutpZPReST5m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770926317; c=relaxed/simple;
	bh=2qygolCHX/kIRJLGD+M8wMx6zEzJ/7RfXkJQSxZJB/w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ELnp2cpLKcsvSpnn+lqkqjDTnK+BSxH0mdmevfWBaMlHwe+OLvbSLatnB9eslAJHRPWepbjLydbrRtzTlcmr+mv1uCRt00rjFVQN93mSG8VJfHTMoGVbo7NU2PApftkFoAPxv5WT8O/XWjKbaZ5GMzluc6JDoYrEsglu4jJwgwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LMZgiAIQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EBVNPT3U; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LMZgiAIQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EBVNPT3U"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C6B187A00B6;
	Thu, 12 Feb 2026 14:58:34 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 12 Feb 2026 14:58:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770926314; x=1771012714; bh=NT/+u3nFeP
	p3jKCg9j6IGDR8yVi02ypV8fmw8Ly0mRw=; b=LMZgiAIQL2k9Y6i2BQH+q0wV9y
	9fFNbH04GZInZZ67tFV4zSI4jH/022sjdueeN7EOx/DaYo/7OCbeGE1oB8RVT5ZA
	NE8smmismXBtyPUo60pFj8983Pf2OBwX/ucxl+bhvgn8rDKLMkuSVoq7EZ4ipHnq
	3qdq930O8Kpna+5MriA7pOwao0ACbrRsO8Xmc0frHxJ8DiJn8DZEUNDUegUyrzOr
	X56/ly2i5C5U4LbeL/HhYP7t/lBRD2KCe055+yljuFlvq/nCu5yiHqwMh9OalmIo
	gdtSL1b69u63up4tDUxsobp2py1uGCKHpw7j7cBy3y4YgTYq7LvBeB+AppxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770926314; x=1771012714; bh=NT/+u3nFePp3jKCg9j6IGDR8yVi02ypV8fm
	w8Ly0mRw=; b=EBVNPT3UXtya54+BnFhxeOkzsFH6IMk/1bVCxWrPPKQc+5F+Xnp
	DbB3bnSdo8nUqlvfaycGPt2MgbZ/U0RRsuL24v9prScyWt9sIJfAehQqZ6+yN+80
	5V5ua5U+eeH4XofOVkp3N2IFYl0w2zHfNW0+B63CpKRG0HPltC87XR3ZcvM/7ZdD
	0LypfhbhJz76w80DkpZPquJY50pvmb5INH+k67mjbgb0TzIymp/wFuKmQ+dGy7zW
	Dbj43yAybvSz4osKmPdDQYWmRfv/q4SB0D56fM6mzgtk0ueZzPs4R4WednCY3lkm
	syVBhcgwosl6ye3XN/78vdJH+d/OLACcZ9Q==
X-ME-Sender: <xms:6jCOaUQKESev-n4ELAtGbPObJrtYSvMyfAifouK3qN1WpniHeTsFHw>
    <xme:6jCOaYpdV3t58hD3iI7rRuqm163QYlKcRz-XBGSqdzuRh-dcHZQ3pIVXRLCvOBw7h
    u2Cz19C-MXruSse3qBk72aYDJ8HU2r6Wzvbzjy4nmRlZkh-B3Hvxg>
X-ME-Received: <xmr:6jCOaaJih4y-z1E9wAkCScRmYc-jlLs5p-bZ5W-DZi-fujOY-3lHLamuQaq4ax2METk2Z_nBVU2MuPHHJuy8ReQn_kg5-NATsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdeivdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrmhhishhh
    hhhhrggrrggrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:6jCOaTq1O2c8pHaMGqupPWO3FMjxqkqDfHE0JhrkAJLnlIR5blcM1Q>
    <xmx:6jCOaawCzCux0Bvts7Ob6WI3JCFh9qtKIlZSek9UQMgIIprhFm4iJg>
    <xmx:6jCOafME0JL0UMfD4INqRa_84fdA_nKBtIREAmtX3cTJ3B9vIPCTLA>
    <xmx:6jCOaX61QQdCUjpecsBZ6LZ2ZyJwNs59UXkFFJ9yvZGbguQXBE45UA>
    <xmx:6jCOaQK5V789dBC_fj2ijftiMaBWwVwx-eMULYtE23Z_E3leOigdVUNh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Feb 2026 14:58:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Amisha Chhajed <amishhhaaaa@gmail.com>
Cc: git@vger.kernel.org, stolee@gmail.com, peff@peff.net
Subject: Re: [PATCH 2/2] help: ensure &keys_uniq follows sort -u
In-Reply-To: <20260212041017.91370-3-amishhhaaaa@gmail.com> (Amisha Chhajed's
	message of "Thu, 12 Feb 2026 09:40:17 +0530")
References: <20260212041017.91370-1-amishhhaaaa@gmail.com>
	<20260212041017.91370-3-amishhhaaaa@gmail.com>
Date: Thu, 12 Feb 2026 11:58:33 -0800
Message-ID: <xmqqh5rlohsm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Amisha Chhajed <amishhhaaaa@gmail.com> writes:

> From: Amisha Chhajed <136238836+amishhaa@users.noreply.github.com>
>
> uniqueness operation of &keys_uniq depends on the sort operation executed
> for &keys this might introduce regressions in future when the logic of
> forming &keys_uniq from &keys is changed.
>
> add string_list_sort_u operation for &keys_uniq after the processing of
> &keys so it follows the expected sort -u behaviour.

I am not sure the above reasoning is sound.  With the original code,
we

 - prepare empty keys_uniq
 - collect keys
 - sort keys
 - iterate over keys
   - add either the whole "section[.subsection].key" or "section" to keys_uniq

before we call remove_duplicates.  keys_uniq would have duplicates,
but because keys is sorted upfront, wouldn't the contents of
keys_uniq be collected in sorted order anyway?

This is not a performance critical part of the system, so it is OK
as a future-proof measure to sort keys_uniq immediately before we
start doing something that we _care_ about its sortedness (e.g.,
presenting the final output to the user), even if keys_uniq is known
to be already sorted with the current code.  Using sort_u here would
allow us not to worry about how keys_uniq is constructed in that
ugly loop.

Yes, this function, especially the loop before the part you are
touching, _is_ ugly.  What drug the authors of it were under when it
was written, I have to wonder X-<.  For example, wouldn't readers
wonder why CONFIG_HUMAN output mode does puts() right in the middle
of the loop over keys string list, while the other two does not
puts() and have a separate loop over keys_uniq instead?

I suspect that making a switch(type) that calls one of three helper
functions for the three different output types after keys has been
populated in the earlier part of this function, but immediately
before it is sorted with string_list_sort(&keys), would be a
low-hanging fruit clean-up that makes the result far easier to
follow than the current code.  The helper function to handle
CONFIG_HUMAN mode may need to sort keys, but other two helper
functions do not have to and iterate over unsorted keys to construct
their output list, on which they can do sort_u before they output.

Thanks.

> Signed-off-by: Amisha Chhajed <136238836+amishhaa@users.noreply.github.com>
> ---
>  builtin/help.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/help.c b/builtin/help.c
> index c09cbc8912..0c9c007214 100644
> --- a/builtin/help.c
> +++ b/builtin/help.c
> @@ -196,7 +196,7 @@ static void list_config_help(enum show_config_type type)
>  
>  	}
>  	string_list_clear(&keys, 0);
> -	string_list_remove_duplicates(&keys_uniq, 0);
> +	string_list_sort_u(&keys_uniq, 0);
>  	for_each_string_list_item(item, &keys_uniq)
>  		puts(item->string);
>  	string_list_clear(&keys_uniq, 0);
