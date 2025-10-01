Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE4C1946AA
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 20:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759351740; cv=none; b=V8iheY8AjPuNqSTfc7ozzafnW6TK6OX1OZc/3cCYYE2LFDbJIk3RESy+BLQIVruvKZV6b6Dk7GB2kgRyvVLGRus481ZSG13vIXfxL63Iu1DxpDhDIqww3WEDl6kOgWjGN4PSOdtplWFcHcVXkBBa4OE4WRKbiZgEbVsdGxbrN9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759351740; c=relaxed/simple;
	bh=GAqZOUBzvUkqTiF4YWZfoEqDAZptgGhxdLDlIAaXNkE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K/NXlBESDLYG4ZSg/F2cwTuFRhEO1uw1/A7kx5Xj+9/bRCRjRTt1KlTx8pFadpn+O1l/N6h/REWhD3Ty/kfMnoIRpZamijgGFsZAwk9U0ugveDEQ1HyvtGJwViZ3sWPHxV/DUNnQQKnrrWC6vHBywyVnP0YDng5CIZNcoOTH9rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bomPn7Pn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b/bFZnrL; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bomPn7Pn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b/bFZnrL"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 20E777A0487;
	Wed,  1 Oct 2025 16:48:57 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 01 Oct 2025 16:48:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759351736; x=1759438136; bh=34iqDwmKaf
	1Ub9+OXMSTGCRY397+2gnHCzCY+UyfN8w=; b=bomPn7Pn45mZq0dT/QAzzi2GGr
	UVpM3J8nB+v15Zix9xuJB7NtuhKwixTKIFL0sRzv/4z3qPwsMrk5Szop/SwjnWXW
	AXrFvW6kk2XwxxNcN8pV5DnEnGny5Z+9upxf6GJVJrJXDNFlKbVDVH9KRLCBDO7q
	FlJlWOEF3q8ng4q+2gHPspbH6aFd7SyJnzqg4O/mqS1w2vgkPgN3gq61wDX3inL0
	qtU/NwqtqifYb1BHXplZ+lgkiIvAL0by5FDVT9D/v92TGgfx1JK5sIk+drSCVocM
	m3MVZ5xV5Yz5UIkLWlLSWCO2mbLX9+/Ex/lLB2CuirX0wZsIVVYXvPsr0Rdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759351736; x=1759438136; bh=34iqDwmKaf1Ub9+OXMSTGCRY397+2gnHCzC
	Y+UyfN8w=; b=b/bFZnrL9ti8ZQiEHxeualAEuLAQfGzMqsFnKjf03R/I9W8jvcX
	RqpLvw/AUlIFJgmwnMJ6ebNwxp7Wef1+lgijcujP4u/11ViblxjhDbEoBtXSiCYv
	GaFV6gh3ZNH1E4W8Eq+p6yHLp7vogTidIDM4oG3AW5G42wrvGIDQuWJt341azKWe
	lA1KclWhgFN+Z+3zK1Kgx7bPpoVx1MJXPFGS1XWdh0obzNmVR7HzZB7Z2oXujni0
	JI0/IfL62OSDYgJ3DSSC03RLdYGc2nhwWYdyV6DY9G1P7ba5zsh06tTbeWUwcTB/
	fdm1NIXcTva5TdjJQFNeJ67HagJbJZ0h0wA==
X-ME-Sender: <xms:t5PdaHij17SqhDboB73pTx7exkWYAaLQ6CjOoGXhxKg2wApYwGHzXg>
    <xme:t5PdaGRuHH7nfO7MepSPqnct_uvV0ZXpLVBvHE33hohcGhWBkOpVNsOotX74tEqER
    o6GLf_OwpU_CygatWdCj1--c-U3L-NFS8JuCkwqJA3aH8BwpJd22qk>
X-ME-Received: <xmr:t5PdaJW0vKT0O94gLLmG8szQL3sojSMf4UBryTYE5awK6BBrlBpCwrnZGVxx2Kr5xnC45rjxv_sFMJrHau5KrRYL_5jdb1_O8wny>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekgedugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsohhrghgrnhhovhesghhmrghilhdrtghomhdprhgtph
    htthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehmshhu
    tghhrghnvghksehsuhhsvgdruggvpdhrtghpthhtohepjhgrshhonhduudgthhhotggrse
    hprhhothhonhdrmhgvpdhrtghpthhtohepjhgtuhgsihgtsehjtghusghitgdrphhlpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:t5PdaKQvouxDD4yAPJp4lvpq6awbmwHMal1cqqeY_s_9A3OkekE-9A>
    <xmx:t5PdaDl1wOI3b_0bYHTc17FGpw-rCBLbw0q43pTQLSwq0S2Nu4YC-w>
    <xmx:t5PdaA5_HEYArEoPAUCnZefIt54Jfy_7Fjkp131tlCfdOdrzP4_YcA>
    <xmx:t5PdaJgICy2P36xQ20Hg8QxUZbx-ncE7V03PGuERTrbWZ4xz4YzN-g>
    <xmx:uJPdaHPAUgh-ajiF3Fos_pSHddyGDwkr-xk8pfwcZldCK6j5Pl8WEF91>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Oct 2025 16:48:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Sergey Organov <sorganov@gmail.com>
Cc: Ben Knoble <ben.knoble@gmail.com>,  Michal =?utf-8?Q?Such=C3=A1nek?=
 <msuchanek@suse.de>,
  Jason Cho <jason11choca@proton.me>,  "Jakub T. Jankiewicz"
 <jcubic@jcubic.pl>,  git@vger.kernel.org
Subject: Re: What is the reason behind not hiding git worktrees from git?
In-Reply-To: <875xcyfk3k.fsf@osv.gnss.ru> (Sergey Organov's message of "Wed,
	01 Oct 2025 23:22:23 +0300")
References: <aNuy1aab954D3rJ1@kitsune.suse.cz>
	<E311F5BA-F88C-4C3D-88B5-F8508B106D41@gmail.com>
	<xmqq3482312r.fsf@gitster.g> <875xcyfk3k.fsf@osv.gnss.ru>
Date: Wed, 01 Oct 2025 13:48:54 -0700
Message-ID: <xmqqa52a1h6x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sergey Organov <sorganov@gmail.com> writes:

> Also, I'm almost sure that the first thing almost every worktree novice
> does (I did), quite naturally, is:
>
> $ git wotktree add <branch>
>
> that happily succeeds /anywhere/ inside primary worktree without any
> warning for me. It probably should either have created $top/../<branch>
> instead, or refuse to proceed without confirmation in the first place.

Yeah, I almost never type 'git worktree add <directory>' without
"../" at the beginning of the directory, and every time I do so, I
do wonder if this is a UI pitfall that we should warn the users
about.  Perhaps we should start from documentation updates and
possibly a new warning or two?

Thanks.


