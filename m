Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019CC28003A
	for <git@vger.kernel.org>; Sat, 21 Feb 2026 05:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771653341; cv=none; b=uwDh1Y+FYotNdj2V/aezihv+/hz2cXSCukmUWF/SqYMuRpLpBW8uGladqhwW1lIosMoSO+BiphcszOYkHrizq19Fb1PDOaXxzhLp6g0dVWPxYkEOZ3wjgU32TvQ8NOz76uO5D3GINPlNh8T8grgbTVpceLeMitaV62RZERGbEK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771653341; c=relaxed/simple;
	bh=sMLroaA62ebImhrlGDfI/4RZszIPWaMbytmVZt6gOlk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nT6iLf/n/CPi5H3AfHsEIfHshCk3hGy7hcSYsVQf+t2GNnGeG4oljMRoA7iGfnF0rezZJdZqJYevLACb5wn69wfCjmIcsC494KNROhgoLTf2jxTPd0eA1MPZtrpfcT4ub7pRfD7dRVsNMVHaCasTCcUq78bs9iam2K+NvM3QXAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EGM2kwDS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B34LZc0m; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EGM2kwDS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B34LZc0m"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 338E81D00199;
	Sat, 21 Feb 2026 00:55:39 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sat, 21 Feb 2026 00:55:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771653339; x=1771739739; bh=3uddUCZ8wM
	B1NA8sQ47rWIsSTuwrW9Uv1YuiZWawutE=; b=EGM2kwDSilyGsXVwUHPq/2l8+8
	/TaZFdQF7fua3aiT7aqhe12EYKSAf6DtYIzB7jvkg1x0xY6BClJ/cFTA6hKCH8H0
	dl5fpV9PVAIJBh97fqQ4pefTaO4IOE+s3GzxqPW2f5rJtVKr5vtFNnLUrImJVv/4
	WSkqcHvplJ+9frM6UzXJcsO3ZSNMhobRmIKGzPeO1YEsoq1P8/hsp6msM9xdVr6R
	RIP+nYEpvSG5ThZy3+y8YPVKnb7V+XtAvLTtAb60FWXT0/2l6OlFTCMJmfs5CqY6
	Cu875I5zNeswHpi/kXTongM/VapDs5KUg0nStYbadAyKYgJTDHjRoSiubD7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771653339; x=1771739739; bh=3uddUCZ8wMB1NA8sQ47rWIsSTuwrW9Uv1Yu
	iZWawutE=; b=B34LZc0mNPgmOPQeWm8I7DvRVzkCTSZ41xXy5l9yznZJiF2H8WL
	Wpy4AjSOJIDKPlE/i1UFbUSuIvDIZvAXEUXIVz54qeOFjQjWDEEuRpuM0F7/oZip
	mQfhiqJ1oGNkyh+xkt9JeuPnoYOmYNK6dMwi4L1FLIxv5opr60IaG3z1r0CTsH+r
	/S6UbRNDsPyWw3/z91j8XDG94WGDEBdJCC9HM1TdbOUqEPL3XRBp/1+1ssJlGoUj
	gWzPe/2+nAZvuQ6tpHtn9bC4WcZfK9P1VuDe/iaGiW0UFTe6Cy0ndnJTtyHoNgQV
	K+Zqzy2zzN3GeEK6TR0R0yBUgwkx8o4BjNQ==
X-ME-Sender: <xms:2kiZaZ8htvV3tpPla_Wuc4z-pVxde94DutUZbF9BHxwGu9Mgll1T3g>
    <xme:2kiZaVIiJ9OyJmzHQOyGu78dke3TmVzZ2eaLyb-g6mVwpA370hcgf40neQlbmuEuI
    EJNZDiUoUQG_2zpP8Chhc5bMHAF0ySn9om03Rbw0O06UiA7h2vfqA>
X-ME-Received: <xmr:2kiZaUZRlQTAGlz3UhIOfVZ0iH7ADc9XJuqVylqZIfUJeE2XR-i5_CLybnmxsQMJj_vW4qekiQtK_wIaXBfUG3kNS7bIpauh0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfedtheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrhhoihhk
    seguvghlrgihvggurdhsphgrtggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:2kiZaXIC66MOplIrJoHO1G8a4njk1OmKc0nOvGkSIAIsk2LzhPL4Dw>
    <xmx:2kiZaSDyu3ZnKVUvKpS26x_7jryX5o4DNhIbMiFHDbvR_ynhNqM6aA>
    <xmx:2kiZacpYoGnKwlNjfxWxrS-V8Chivxc_K1SqnfXij4Hrl9TbzCzsEA>
    <xmx:2kiZadhTFn11QOcKi4DFxdGzjSxmJlwRripm4hQiEzh9BYHF2Z8r7A>
    <xmx:20iZaX04j6ppCRklbfGnvCFxTmSNMlw2jwZbP6yGMGrRWz2x7FgC8MTO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Feb 2026 00:55:38 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH] format-patch: better commit list for cover letter
In-Reply-To: <aZk9QlH2PDugXKrh@exploit> (Mirko Faina's message of "Sat, 21 Feb
	2026 06:18:46 +0100")
References: <20260220230633.132213-1-mroik@delayed.space>
	<xmqqldgmu25h.fsf@gitster.g> <aZk9QlH2PDugXKrh@exploit>
Date: Fri, 20 Feb 2026 21:55:37 -0800
Message-ID: <xmqqh5ratzc6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

> On Fri, Feb 20, 2026 at 08:54:50PM -0800, Junio C Hamano wrote:
>>  (1) Drop the abbreviated object name, as they are useless garbage.
>>      The result of applying these patches will not have these commit
>>      object names anyway, so even when people find these messages on
>>      a mail archive in 6 months, they will not find the result of
>>      applying the patches from the official project history with
>>      these object names.
>
> Should there be a reference to the author ident instead of the object
> name then? A quick glance on who worked on what before diving into the
> patches themselves might be useful.
>
>>  (2) Do we need to make this optional, in order to allow those users
>>      who do prefer the current "shortlog" style that groups patches
>>      from the same person together to keep the original style?  I am
>>      undecided myself.
>
> Maybe the "--cover-letter" option can take an argument like
> "--cover-letter=<shortlog | commitlist>". Although I doubt there's
> anyone that actually likes the shortlog version, it gives very little
> information. I'm inclined to think that most leave it there because they
> think it must be somewhat since it is the default, tho this is just my
> assumption.

Just off the top of my head...

Perhaps with

    [format]
	commitListFormat ;# true

we use

	[1/1] format-patch: better commit list for cover letter

and with

    [format]
	commitListFormat="%s (%an)"

we use

	[1/1] format-patch: better commit list for cover letter	(Mirko Faina)

instead.  IOW, the value of the configuration variable is used as
the format argument "log --format=...", and appended to the fixed
[n/m] that gives the numbers.

Without format.commitListFormat defined, or when it is defined to
false, we'd use the traditional "shortlog" format.

Hmm?
