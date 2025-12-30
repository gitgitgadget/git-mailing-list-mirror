Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEF8222587
	for <git@vger.kernel.org>; Tue, 30 Dec 2025 05:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767072217; cv=none; b=SJryTMJd9MXdIuxIHeWVhMYVxJvlZsPnyM8hbLuIuT83gF2Q4Me2+xgr+PiTXKhwvs73o0mjaU9VnK/JndsKepmHcSLFfarOnj9WF+aI//a6xm9imbBHM4Ra9eUYckOjPnztejlD3jIY1V/mth5HHGk8NERA6wSfpq2jYZLKQt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767072217; c=relaxed/simple;
	bh=wkORI/eDZOZqsRSIDv2kAfg5akU6nPQIbUG6R3aOxSE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nLrOD+7H8ci5cmZw8/xszCnAXWcGphglLP1j2IDNHUm18BnsP9lve4JVK3O4JKx4SHFRCROIQPHCU6nZ2R9S/VPeqLpOrL7+Gb8+JFHVZlqRzpURo/fyICCojtIAUeKncfIwDRuDnb3WFHXRplDZLNbs1H/+mHn8/8dBvcaC2uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gfWNXJli; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KAJbvTaa; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gfWNXJli";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KAJbvTaa"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 0F0B71D00116;
	Tue, 30 Dec 2025 00:23:34 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 30 Dec 2025 00:23:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1767072213; x=1767158613; bh=ywkDkxAF1t
	J0TSJrzeUtVUGPYaXyRhfam0bXqDgwaLM=; b=gfWNXJlil+RJUrEHxTiwusJiyA
	hohA7cluT5jKn3iEGXXYZuqlziK5iA6+S6xAxoFISamYE+inwC8wEOLJGHObX0jd
	VDuyKG4xo8zyFAAGk0UkSWMb+851xCjVLYbYCX2Eg9ScfICN5sfBFRLT/MCA9muN
	MZogvi79esYSe3G+TLVuS+yEOiJWN0xNIhm69h4dTNC8I4LtssytfcKyIKxjew/f
	qwUaIoXKV+tWNghAwR86ehoAfw47hhMROsSQLrqXoiKs3QZfmMWTtkKf5JWqTpEc
	WyI4kUIssr/DGxTfunC8SVfbz67EzsT/5QUTSXnkya4x8L74ZLlEXrGlT/lQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767072213; x=1767158613; bh=ywkDkxAF1tJ0TSJrzeUtVUGPYaXyRhfam0b
	XqDgwaLM=; b=KAJbvTaas1+8MuoEILet4P8tPw04hmd83djghqxXdhdiPZPOW6d
	f8Ge6Kdfeaxx99ZDbi6Yv4Xnha+vqLU0eqPOg+zv8iJm3g/jWzfuJYL0D4vIceqa
	BC8/92+w1ZkqSGZchHQHJWcK5cKzyEr8wcwPkdSYqWSNhwPPTuO3i1dxaz+zdsqK
	1RoVEqL7YIycxYf4hj/2BKOG5OIKCAMc8/TOusQRJD6RYlR5IyrJ4pQZu373o5g/
	2g1zlAHmHPMCdHt+AmGOZphMpbKe1pwmLwaKcyj0QcBVrEgi1dM1V6KqdI0hchRn
	dJj6makQ6dwX1zV5YYyoD+IzRnZ0PWMqqoQ==
X-ME-Sender: <xms:1WFTafXifJStXgdxR2q3cpK6tk6rBLYB8Zmxy2pdQBEThF93rzTCUA>
    <xme:1WFTaeemHTgjD560UamC8zT9L-Kr0tLm4fkO5Fxzjk_d36Kn8qguzfh3NC5mScHQ8
    264aZfQ9h0vqhKlJvTjtvYcZdvSQiR642-X3R1NtXgEDRg69CI98A>
X-ME-Received: <xmr:1WFTaTstmloXip3dPZtQvLJDVVNwZSH50E7w_lbQ1M-ECvo1ZumeDXXkdnf7J8M0b-f1DLWWRFDsb_irNm1TlmMniGP1ONJWxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejledujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegsvghnrdhknhhosghlvgdoghhithhhuhgssehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehjuhhlihgrsehjvhhnshdrtggrpdhrtghpthhtohepjhhnrdgrvhhilhgrse
    hfrhgvvgdrfhhrpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:1WFTaV9uTXr_0bnu2Ble1aP4jr5A_pc7DmuaeurvDwlistS5vy4SnA>
    <xmx:1WFTaW0Vy_rcEOuQTBMcCVWnxH8XG0HJn6SpE8ZV8UMW8JivM8sIPw>
    <xmx:1WFTaSBnMIipzVDbxdrCo0ySdpY9HpJ0QNdktnlzx28gG16zeOF64g>
    <xmx:1WFTaafw-6B7s6OHvlfnvTjKAtFtdOfqnR-o_c-q0T1v8T8WoIEgYw>
    <xmx:1WFTaeacEEaW1HjeDz8riKVyDEX5GBEhAp22dcokdUpHaG7UUKi4kozn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Dec 2025 00:23:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org,  Julia Evans <julia@jvns.ca>,  =?utf-8?Q?Jean-No?=
 =?utf-8?Q?=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH v2 4/4] doc: git-reset: clarify `git reset <pathspec>`
In-Reply-To: <d6582dc53ca852ef01421d2dd2c446dadb731dad.1766103827.git.ben.knoble+github@gmail.com>
	(D. Ben Knoble's message of "Thu, 18 Dec 2025 19:23:56 -0500")
References: <pull.1991.git.1760731558.gitgitgadget@gmail.com>
	<cover.1766103827.git.ben.knoble+github@gmail.com>
	<d6582dc53ca852ef01421d2dd2c446dadb731dad.1766103827.git.ben.knoble+github@gmail.com>
Date: Tue, 30 Dec 2025 14:23:31 +0900
Message-ID: <xmqqwm24fsq4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble+github@gmail.com> writes:

>  `git reset (--patch | -p) [<tree-ish>] [--] [<pathspec>...]`::
> -	Interactively select hunks in the difference between the index
> -	and _<tree-ish>_ (defaults to `HEAD`).  The chosen hunks are applied
> -	in reverse to the index.
> +	Interactively select changes from the difference between the index
> +	and the specified commit or tree (which defaults to `HEAD`).
> +	The chosen changes are added to the index.

The previous iteration said "changes are unstaged", implying that
the changes are removed from the index.  But now it says the changes
are added to the index.  Which one?

I think neither is correct.  I wasn't involved in the design of the
behaviour of "reset -p", but IIUC,

    git reset -p
    git reset -p HEAD

show "git diff --cached HEAD" (i.e., what damage you will cause if
you commit what is in the index), so chosen hunks will be reverted
out of the index if you say "y" to "reset -p" prompt.

On the other hand, 

    git reset -p COMMIT

for COMMIT that is not HEAD gives "git diff -R --cached COMMIT"
(i.e., the changes to take you closer to the named commit), so
chosen hunks will participate in the next commit if you commit after
completing this "reset -p" session.

    The contents in the index are modified using the chosen hunks.

is the best description I can come up with.

The actual prompt asks "unstage this hunk?" when operating against
HEAD, while the prompt changes to "apply this hunk to index?" when
opeating against a commit that is not HEAD, so it might be simpler
not to say anything about the direction of the application (i.e.,
how the chosen hunks are used to modify the index) in this
paragraph, like the above example, may be a viable option.
