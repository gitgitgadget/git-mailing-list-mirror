Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A08A770FE
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 22:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758580785; cv=none; b=l+k971jAvgj0Gj3oJ3nhO82jx+Wy46677ORO8VbTS6OfN9LjvvVTQgsNs1/KxP5srsQXoaxWZEnw5NnTEl0dxvk5uAeDfAEsSQYB/70EL9NxeJ4+ANlLTahGxILxNl00ANKx6NYToe393Uit4U5B3k+shjFlnyMfUSUL7FPMFw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758580785; c=relaxed/simple;
	bh=QGbP7snExJfYW3ncfZjuonUZCZu+trnlZ8UY18eko0E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=knT/XVyGryn9MNh+7zjBkdBKE7QhiZs38e+QKiGMXql62uzXhu3sYOmGocRRRBfeToDjQ52sae8uerX0Kxj9XAuTFQGjpXIc2FUexV+/6SlOLo4W9V1djpDBAhMYs3hqxZd0mHTDAriw6iJtGDNkTf5E96HV10mQQZnG7Q8C9eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jfi+U048; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HUc6+6PN; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jfi+U048";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HUc6+6PN"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 1ACC01D001E3;
	Mon, 22 Sep 2025 18:39:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 22 Sep 2025 18:39:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758580781; x=1758667181; bh=XBW0myGUld
	umq+OFWr+WMGkSjwbqwikxcbxrK2mHroM=; b=jfi+U048B8iWyQj6kmSMU6CdV7
	0wcOhqqfdAv1QK9cy9TyQPymk73KCYG7CrxES7UiTnGydDkr09NZdoseiXFLPd8m
	45ZJeiV4hHxh8dsXfvnqZU264VessvYnV+K31jN1Y5Dj7wh3Nm+r9iKfkGqqHAD4
	6ty/nrnPyqg95FJIrHhv4VeuWrAs8a5GUsjCCQFuXWh7zjms1YZ5CVtMoFZxL1pp
	GVNS/SGIgVjEl+VZeILJKqa+IO0li6mIlZ1AqHq6/qje2ariaUWVmRleWGezh0+E
	XF9F6JgSx18E71I0KJHi2q8ODdpLVOthoqUHfgmrY6nT45gB3jeDR0wWuwVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758580781; x=1758667181; bh=XBW0myGUldumq+OFWr+WMGkSjwbqwikxcbx
	rK2mHroM=; b=HUc6+6PNMR0U1TnmThzZt1bV2qJCgtz+aMQsEyC9z6W2xwUiQqD
	6+E7jWQ9cTDdGBDYfmmOgGfhkICyql4ULfM8p8ZpCJGNQTk75ynTrPBl5x0FpFam
	d+MwUd9se7YOtXhD81eIvp/pOjLNdNbF/PwFidrh+c8T5t+I909YmZITxDRyxW1Z
	CiMxSSjU/6G/e+lBvVZCNlkqV/BDlorWMqckIDFexFv+9PgB45mMzbROeRf82qeG
	3PcflkpqxZyp3MaUs1LYH+0XAlfMg7X+3MnbAXA0UFFkilb5twKLbiVuJlhnLKGF
	5KtYueLKRqAe4ANiu7+lDrpS2TN5ZvzYr3Q==
X-ME-Sender: <xms:LdDRaAA55sl72lBHlaalpGfpfxCXQxCtpQydEIxSyFL6YiZWEAtnSg>
    <xme:LdDRaBlApegnsXNxW-_F5dKH-n3RDed189W7P7S1cU5bwBwrim4daPM1S6HUGG04F
    _pTqESfhe427xdfi6NQz3BKnYewuYmSmDa4tpq2IUarZa7QhpOYNg>
X-ME-Received: <xmr:LdDRaJx-i94ICxgER_R_G8wb6vme-TLKl9Ma_hlIwbgSrePkhvvQ7LWMkVW0_wXvh418c2AlM4jh1emhQ8NiBTKLipqyFWOkqSz8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehledtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    nhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihooh
    guuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhm
    rghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoh
    epvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:LdDRaDQu3okyBM4J0PzfQN-FEtNuHlFy-VDUt54qsyB5raFNPFGtIQ>
    <xmx:LdDRaJ_ySilvjgskVFllE4WLNyZ7ZUizaJEOFx-xZFYd_E7AyK3Hrg>
    <xmx:LdDRaJslMFi3r8HxXkk_b-MjY17HXuSGkYbTgeYfndKmOA2Ek9pt4A>
    <xmx:LdDRaJOV8GUeuyt04ai0MpCsNJ9GBOnajH_FZoASmrKAzDZxFNE4EQ>
    <xmx:LdDRaFR1dk0_Ywa64ziRLJG01TNXB_r0DWdxshv0jYV_crQ_waw-3jzi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 18:39:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Ben Knoble <ben.knoble@gmail.com>,  Jeff
 King <peff@peff.net>,  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH v4 00/12] Cleanup xdfile_t and xrecord_t in xdiff.
In-Reply-To: <pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com> (Ezekiel
	Newren via GitGitGadget's message of "Mon, 22 Sep 2025 19:51:29
	+0000")
References: <pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com>
	<pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
Date: Mon, 22 Sep 2025 15:39:40 -0700
Message-ID: <xmqq1pnyru1f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Changes since v3.
>
>  * Address review feedback.
>  * Split the deletion of xdl_get_rec() into 2 commits.


>  * Move NO, YES, MAYBE into xprepare.c, and use bool literals.

The elements of this array is of type "char"; it makes me feel a bit
awkward that the code

 * assigns bool "true" or "false" to "char"

 * expects that reading it in another compilation unit yields 0 or 1

Instead of abusing boolean true/false, I'd rather see the code that
assigns 0 or 1 to use 0 or 1 as literals.  As the array got a much
better name .changed[], anybody would understand that

    env->xdf.changed[line] = 0;
    env->xdf.changed[line] = 1;

mean what they mean.

>  * refactor 'char rchg' to 'bool changed'

Hmph, I am not sure if it is a good idea to pretend that this
changed[] array that is more than bool to be a mere bool.  An object
declared as type _Bool is guaranteed to be only large enough to
store the values 0 and 1.  Granted that you cannot allocate less
than a single bite or make an array of bits in modern architectures,
an array of _Bool would likely be byte addressed and if you assign 2
and read it back, you may get 2 back in practice, but I'd rather not
to see such a strange code to live in this codebase.

How about

 - rename rchg[] to changed[], which is a very good move;

 - optionally make it unsigned char, not char;

 - the user of changed[] that uses only 0 or 1 and is not even aware
   of that MAYBE thing use 0 or 1;

 - the user of changed[] that has to be aware of that MAYBE state
   use its own NO/YES/MAYBE for readability.

Hmm?
