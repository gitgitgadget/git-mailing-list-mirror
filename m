Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41BB2777FB
	for <git@vger.kernel.org>; Wed, 14 May 2025 13:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747229342; cv=none; b=oSgsyCrBmpWT3IrSb3wKW5BTv/QIYDf086nV4XbNFCKVWmdSrLidB4ruW33/b3jlzFHyRrtLGkEgFddYcay0wnanYcc+ClZp0Xi/ia1RpXnzm7tBNZpWWhBC4QF39/UX/TrtpmZepL5WbLIVWBlKm+HcjS/Lye1dm/OttbqatmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747229342; c=relaxed/simple;
	bh=tIyXlydBTBbpPwDybIvVGmxPCcQJVjHY+GajMXFwBvI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JvXEaJbCZwVWmn/7IbgoKz7HAnvYTB6iG9OH6W7nCBj6DzZoSL578hM0tbVmGpIyYmQBbsCWopV53q65WVoJd8CPTJ6yUvZUWfqkRCPg3Jxgvkdi2/fk5Bg7matL+ECiLNb6LzgbM7NbhfBjVhpColUqbgspRvwK1NW7mgD0vvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HAODpLIw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JJZ9wwqo; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HAODpLIw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JJZ9wwqo"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id C4E0B13801E7;
	Wed, 14 May 2025 09:28:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 14 May 2025 09:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1747229338;
	 x=1747315738; bh=p2s0lTCrRnVswn2etbGQWOeDAZ327/2sKAR4GIKqprY=; b=
	HAODpLIwICHKCcPJn7tJ09CrI6n6RKF3m5zKKuoKbXBLdxD4viJS7fiH/8gQe8YE
	NgFIQu7eSCPRVsZqK1NsE7nOnRfLoFCbYt4fa3kBQFalkCJbTKnC52iJveYynBNt
	npxupsdV36D/lsq8qtatkesrxiqAVAdhEqLk2XAmHcaG9u+PXZLOc1K9O0O7JPEZ
	kYqFyxCzPeB1HHSoY8Z4dgk5dupTfHZkqgt8uc6XDDjC8o1oZeE2gBjjj8P1oHvz
	6ZJQTZ1OTWdCGCm3K43AIqtQYNmHoWz7i6xEec7h5a8sOVjzIohTBByJ5xgaIZ5E
	6cwQrHcjjgbA82Ecuk2z2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747229338; x=
	1747315738; bh=p2s0lTCrRnVswn2etbGQWOeDAZ327/2sKAR4GIKqprY=; b=J
	JZ9wwqoJz75b7H+rnn1GnkLE2OityPEkNPtw7sgHiZwj4QiG3c2NGk755dv6E8HT
	mJD9wcZ5AL2mwWw3qaf4uq+uuhL8VrmcKBRI09mOFpuBActVP0Zxok6RHJY4sVDB
	G/1mG7U3l5ggn0GAqMo9RWQSz9zBF2XWnHmElHw4TEEwmhHLJmzVXpkK2J76jgWF
	u9s8aobCDe87X655p59g+KISZex3DMCOLepC9q+FMtZxFWY9Ks09fm2Uppjp5znP
	tO5E+GGvv9OaMaCuLly54XXCtPkORuOj5J4BiXEGgprOfqwM2+lupnDCkrbCuOqg
	nJHNhfwh+e1V1oJj2jRdg==
X-ME-Sender: <xms:mpokaDJ74FrLxsvA-NTAVvy8UBbBnB3no20LXoTWVG3teQn_VrteiQ>
    <xme:mpokaHJ8UZboSupnC9FHj5S64VDwOuSqHBZj7Ek1Q01Q0iIPXOeb1tqCTazLKkWA_
    9ViyEIcugBdhpjHfg>
X-ME-Received: <xmr:mpokaLvA-MKTZEEwjG_jRiC722ANTnwGTK1iKyb6iWH62Vn-ABWIsIYMdDriDqTfegF3cbQ8ie7dc0U_4AebBhbCI3AW92K6r5M_EhQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdejudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefg
    keefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjrgihrghthh
    gvvghrthhhkhhulhhkrghrnhhivddttdehsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    shhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehsmhgrtg
    guohhnrghlugeskhgrihhmrghgihhnghdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:mpokaMZ9WZzEm92hOHMuDG6sU4h7qM8Uc63voWitJSNpq7ttoddpeQ>
    <xmx:mpokaKY15tuEzqNGucsj612ZKyMu5iAQYAKQ6-1gD_Z_9rl_FAOtiw>
    <xmx:mpokaACYJl_q7qaZzj-wlDdr0SIpQc0ICqn-EP99vHuR8kdGSLgRew>
    <xmx:mpokaIZJnMJVNxhQSaTkniyWIu3Npja-fxhwaEA89Igc92YsKwGfnQ>
    <xmx:mpokaLJbJzeGeK1TEM9zCARFpgunn02EgboaWHnN3Jzj3o76xJ1zhRz_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 May 2025 09:28:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,  smacdonald@kaimaging.com,
  git@vger.kernel.org
Subject: Re: [PATCH] stash: fix incorrect branch name in stash message
In-Reply-To: <CA+rGoLfpV7XLB01-5evp=qNX3g9-=za9zH33ceBRnzYe3Og=uA@mail.gmail.com>
	(JAYATHEERTH K.'s message of "Tue, 13 May 2025 06:51:22 +0530")
References: <TO1PPF29324B4CE2F822159A3F1C6A5F3B4CD97A@TO1PPF29324B4CE.CANPRD01.PROD.OUTLOOK.COM>
	<20250512164001.62065-1-jayatheerthkulkarni2005@gmail.com>
	<xmqqtt5psor5.fsf@gitster.g>
	<CAPig+cSbwGdhq66tSk_A5oNGXqpbqFA=ZO5GS1E-ENb+_rY70A@mail.gmail.com>
	<CA+rGoLfpV7XLB01-5evp=qNX3g9-=za9zH33ceBRnzYe3Og=uA@mail.gmail.com>
Date: Wed, 14 May 2025 06:28:56 -0700
Message-ID: <xmqq7c2jcodj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com> writes:

> On Tue, May 13, 2025 at 12:24 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
>>
>> On Mon, May 12, 2025 at 1:50 PM Junio C Hamano <gitster@pobox.com> wrote:
>> > K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:
>> > > @@ -1404,11 +1405,20 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
>> > > +     if (flags & REF_ISSYMREF) {
>> > > +             const char *tmp = NULL;
>> > > +             if (skip_prefix(branch_ref, "refs/heads/", &tmp))
>> > > +                     branch_name_buf = xstrdup(tmp);
>> > > +     }
>> > > +             if (branch_name_buf)
>> > > +                     branch_name = branch_name_buf;
>> > > +             else
>> > > +                     branch_name = "(no branch)";
>> > > +
>> > > +             head_short_sha1 = repo_find_unique_abbrev(the_repository,
>> > > +                                                     &head_commit->object.oid,
>> > > +                                                     DEFAULT_ABBREV);
>> > >       strbuf_addf(&msg, "%s: %s ", branch_name, head_short_sha1);
>> > >       pp_commit_easy(CMIT_FMT_ONELINE, head_commit, &msg);
>> >
>> > Funny indentation, and branch_name_buf needs to be free'ed after use
>> > but other than that, nice digging!
>>
>> This change should also be accompanied by a new test to verify the
>> fixed behavior, right?
>
> I will be writing a patch series after checking CI and include tests,
> the only reason I sent this patch was
> if the bug reporter needed an immediate fix.
> Will send a new patch with test case and improved indentation

Don't forget to plug the leak, too ;-)

> Thanks for pointing it out

