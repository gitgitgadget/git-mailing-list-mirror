Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D627C284888
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 14:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758119578; cv=none; b=Spg850gSP/k/O3pUXOuZJpsrZcVIL8zlumnELRniIzXP6osTJ2FEDqCcaVkTYUysv+BFjKe+5XST9vdK6U3b9JaX6CcMSlzxW0GPAVv349RRBChMMQVv6Qctd32g71BWEEFyoUN6Kz7dNaaKloRw2zFF/NRETLwg16dEoXuA5PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758119578; c=relaxed/simple;
	bh=ruXaHskWwQ0nPMcP+/IBSPFDDEt/ZsiOoW5e07xHCEY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q7Ij9ATIqF62w9tl4hakjHSRxGipIh2yY9oiLv95uDqfNgd9l6CqybOVKNKZaoWo4NBlHCkzgVLP9RSp8/RnBHZyG8t8w7J/6t1b/vdz+F+kLvoqQYonFfXzR8TsnXUyDw47jN5HBobAW91lI50EFsWEYqeTLJIjmChe80t+YxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=0saAiA/E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zlh2y1EV; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="0saAiA/E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zlh2y1EV"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id F05EFEC01D4;
	Wed, 17 Sep 2025 10:32:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 17 Sep 2025 10:32:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758119574; x=1758205974; bh=pkYWilPLLL
	bKCTiT5PASjXa1+2rdKNE906OuAAvnf1c=; b=0saAiA/E5mKENPwDDm7/BbkqFD
	9grWVw3LV4B2xKYh/+U364vaJaSMuyVNkaubUyfkRqB8827+fvS/m7KsEY6ItMee
	1UEWwy/8Y06b5SF8HuNljhgof0UR3tAEOsHV/rr2l80PzQbEWZFBKIUy6EZl6oAh
	YPtsF4XufgYO0Idu480WlQ23ayFnC2p4yVz4wkhavEZe79nrGg3oPN5D0RDJQLJi
	KJHfC0+/GlApRAcxbPZIibipdJr0HCg4bPhHcrgnff8hy+DOnxz/SlyMwbkT1d2L
	1yoYF3ovo7x706QeobV5WOc/36N1z1R6wy5b2XK1VLd4TKykT3re25BtoBFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758119574; x=1758205974; bh=pkYWilPLLLbKCTiT5PASjXa1+2rdKNE906O
	uAAvnf1c=; b=Zlh2y1EV1nCWtT+nT+jHFXs4t+qUyArbeqFi6hAuMqnGATYyVRV
	iY5gzVxbW728dy0srUVyXIEZqGarQ37rLMfWxTlNckjTGWrcBYy9kg1l4fFjus8q
	5r6u2axy5lLgdI5NIAjow/ONmc173e93qU2MF5zkgAmHEHDVNwz99IETEftpGQBw
	H9BuPQ6LMp9nMXbebyS74tkuwPUN2RsYAqk6GWUF83FrnBkslpEUus6YW97oTU/W
	H4ur/ukad0gkT578RmTxnKq3xSwu0BsX2nmAElGqBp2iNXrrueTOmP9E1TCdWIGt
	2kJglYZbQS5K96OJxZmbMfWXbflqpBsSXeg==
X-ME-Sender: <xms:lsbKaFPbgp9xVVAwzp7Oz7w2GKG962ktu5_SCouNLqo2lSYNmL2bdg>
    <xme:lsbKaDeHWkl0_mcdNNw3r5eluisumlTk3dqwYlWeGftGuJMDEKxPhTAVQnXyHUTLk
    IJ82fPNNpCwtemSfQ>
X-ME-Received: <xmr:lsbKaKsmXG_9AvFRkGoAc11W1w9IPwD-eVHC1fb-xDVjK0CNQhlvfcQt7NWwrwwnJYR2Bd_fzSxOL7maeC0b6iidVX1_q9lyXMus3F0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegfeejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtoh
    hmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegviigvkh
    hivghlnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:lsbKaMnVs1lT-sRXDcCLpD4ZwO2fdinQjS-6fOH5Gz6EkM0NHXJJZg>
    <xmx:lsbKaEz27Cod7tDzRVPUkXwJwvw2vgyczhIkYTPfIR5H5eqcsXRhFQ>
    <xmx:lsbKaGNudnhWSKuHshxb6nrxuopbHx0yTY431WnebKxxqwNXq8VizA>
    <xmx:lsbKaIozT0a6D9OmUVSM1hOyvOAn2jnAYHj4C_qa_zXmaehWu-_v5A>
    <xmx:lsbKaA7nxMf-rb8sH4K6ETRum3_43EjIWNeamUQ22R7Ji8d-JpBqp2I9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 10:32:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH v2 01/18] cleanup: rename variables that collide with
 Rust primitive type names
In-Reply-To: <CAPig+cQqKCbGpfp=ppmjKEOe+sDRu6BocDfenzqvQJHSMiKDHQ@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 17 Sep 2025 03:42:56 -0400")
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
	<pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
	<5f77f1bd5d986dc1f8d123919af24dd219e323e8.1758071798.git.gitgitgadget@gmail.com>
	<CAPig+cQqKCbGpfp=ppmjKEOe+sDRu6BocDfenzqvQJHSMiKDHQ@mail.gmail.com>
Date: Wed, 17 Sep 2025 07:32:53 -0700
Message-ID: <xmqqa52tgne2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Sunshine <sunshine@sunshineco.com> writes:

> Same comment applies to the other renamed variables...
>
>> -               OPT_UNSIGNED(0, "u16", &u16, "get a 16 bit unsigned integer"),
>> +               OPT_UNSIGNED(0, "u16", &u16_, "get a 16 bit unsigned integer"),
>
> ... though with some of them, such as this one, it is admittedly more
> difficult to come up with a better name since the original name is
> already meaningful.

On top of that, just like a name that begins with an underscore is
reserved by C standard, a name taht ends with an underscore is used
for specific purposes by convention in this project.

Typically 'foo_' appears as a parameter to a function, whose type is
specified with our interhal API, and when that type is cumbersome to
work with, we have a local equivalent 'foo' of a more appropriate
type whose value is populated from 'foo_' before being used, and use
of 'foo' thanks to its better type is more ergonomic.

    static int compare_pt(const void *a_, const void *b_)
    {
            struct possible_tag *a = (struct possible_tag *)a_;
            struct possible_tag *b = (struct possible_tag *)b_;
            if (a->depth != b->depth)
                    return a->depth - b->depth;
            if (a->found_order != b->found_order)
                    return a->found_order - b->found_order;
            return 0;
    }

    static int path_is_beyond_symlink(struct apply_state *state, const char *name_)
    {
            int ret;
            struct strbuf name = STRBUF_INIT;

            assert(*name_ != '\0');
            strbuf_addstr(&name, name_);
            ret = path_is_beyond_symlink_1(state, &name);
            strbuf_release(&name);

            return ret;
    }

are examples.

There are existing crappy code that uses foo_ without corresponding foo;
we should clean them up, not emulating or spreading the pattern.

By the way, in this partcular case, why not use "uint16_t u16"?

Isn't the true cause of the trouble the (I might say "misguided")
desire to use "u16" as a type in C code?  As long as we all agree
that the data that can be passed across the ffi barrier should be of
the types of known size, and let C side use uint(8|16|32|64)_t and
Rust side use u(8|16|32|64) consistently, we do not need to have
this "cleanup", do we?

Thanks.
