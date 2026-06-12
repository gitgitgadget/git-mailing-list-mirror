Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06637384CC1
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 15:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781278914; cv=none; b=mDYWpZFi+8Neod79hzGofrYZXc/zYsm/WButPbT5g3YtB6pS5rorrTk/+ztH1il1aF8d1IJ3W//FQP4Np5pOHpBCouoKEcuZ+tOy5GkAwrPw/EsNlPuyB7subSWD1eybrLyycDxj4cetSBw5XwWOHy/DuXmAYmLbwAOHGAnnzV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781278914; c=relaxed/simple;
	bh=VFTbij1hYX9S/p1i/5Ah7k/PKy5eXCvRiNww3kl+dSI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tpi3IRoTglpHbAqENIvLo8KakoYf6NkO8rxBfywRCn1lVfqv+I4D188iLdCO0YypFPfXgU8t+kg75tjKcZGgb9JFbOG8xxZXmrGX6ETNFLeLtBObuNMRQcm2QJF3EdtyPOnUylUVnbbIoNj9Y6+frktDvvgNe7W49T9x17mvSCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oXz7qcO7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AZuIe/W4; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oXz7qcO7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AZuIe/W4"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 2019D1D0007A;
	Fri, 12 Jun 2026 11:41:50 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 12 Jun 2026 11:41:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781278910; x=1781365310; bh=9+KL4DYFeH
	dYW932lamMEEDzPuEkUv5Z3oVDBiLG5c8=; b=oXz7qcO7PAuYrcohQbYlfyQunD
	0W6KaXKJ0R+nhSBe85xj60M4/lHEJArzn/OQgPLOXkmB18wO9QBBuVtcLuXTlav3
	lV/GkyBFMDTwLtyiXv4Uf/LZRM5UJncVFO6vkZrI4hHcupZqcX6lRm0osHQOH7Rx
	tjIIjwtw9pM4jbEpB7r+ji78W42bbNh6LbcwLOVIqFf+IOW6Ou80qvPAdjrWAd7P
	88gECiAZ9yU2GcTsa7oLYJKXViK7CdH91GI14ybJa7fhZlLucd1QWeEZPDfrF7Uz
	cg4wSYHsCzsGZffdT1FgbR+yf+lAllkltZ953cLBYs8GARetrc2fsvqFLJsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781278910; x=1781365310; bh=9+KL4DYFeHdYW932lamMEEDzPuEkUv5Z3oV
	DBiLG5c8=; b=AZuIe/W4eCRuib8JwegvIoDn0bYimyzXgP3Awn+7t+y4QuG3GT1
	Po1bCkJHzoR11imdbyVvAAT+/u+72LslXOKU3/JwHISkmTysV3QRuctjNn/LCDOs
	xVJSSpBEJtE6MOd6Gfv954ry+tMBlGaCjoQjxPFine8Y81yQcXNgXLjCSoYXhb6A
	JG8IjkaHWD9uI7gpavJ+get12NWVSwmVePaUBZg2oZ3gpYtrZ+yHOl8LOsVxXXMg
	73KTG0ItQMdffeO6wJOxZA6zupeA1CjAgkXWTyJggvQvXkN47nk8QdEmVty69Tro
	+JhIgubKTia1WX+mgOptcSvFGWNtONAfTWQ==
X-ME-Sender: <xms:vigsatVtP-WPU5ZBou62TS9UFWK1VvA5jno54fiuldgnWxS_hCeIuw>
    <xme:vigsalAZ3UCsAF7ZKOqxX8LyOSy1NdQGcaBBxOB_895nOT-skXUXFTIJ9gbxjqhJ_
    f2vEw5QSHUNiBBilBU_2X0Tj6tbcbVr7wsO1un6DjKM6hvsmb125Q>
X-ME-Received: <xmr:vigsamyvHy1qRO55JQfgkYqhzF06ASV_z1YQ2WuE9Lkz-qIXbaiO4KJeHxDxnwBtjsR41I1hBdw16bBcFsSREs9GuSy-zAOJFma0>
X-ME-Proxy-Cause: dmFkZTGGWhs3tHs4Wb+eCjjcrwKmmD7t9dlNG17Ehq6REBK+fo6kf248KEAKWLKUC8s/qp
    95bXe7k/uk+tnNtLn123KaYT19ndENVF+OfgWtVaWAVnOiQoOHAdsU6pasUkbLKsV3+M+u
    IRhGnXzN/oeHY9Hi6r+ZLelrKHPPtSiX4sVnRdAVYVMI7w5pvENmfkMVrplHmFesWeJLuf
    UF/d6vFg6ixE6TNUcouTkj+Ivesah74emqJaO6Y1KuhKIUeSubMPJErTYwtPActGbZ+tj9
    PJMwBThe9L8BNNk4CCnCs9GDikpydp3bqyc7qaL/eChxxGc8kleMkSyuaOHg1TP+Gw6zgf
    YomuWFcn5PEr5fFkDKMxJw4OT9bHFp1m5Q+DfkBdkbJ2KraeotBRA4CqrHfRWLnR1TQZzS
    qWD5ABZe5Qu9qE/5Bm5YX5lqhp5iBVAvX3E2Z7BB2GNCbXdrPB8ALP3d0Rk0TN91aHyqgI
    F8hPJbh0uiGUZcKHTUlmjaerNwVXfHdYiYDDAylqEAhPCtqFRZRPSk1GDdS0xb26YQhSxy
    FU93Rs1RR1lSbV2yn5DjPf9LnL/riCnCoSAIJXfAXjuCXGXRPeYs9nMlp6Z4jqPAakqtPR
    Eo6AHoA290cbE5g6K9uzpFCg4Xl/TIiY8FVvW7mSiI2wupAfzHEZCqaamL8g
X-ME-Proxy: <xmx:vigsaqA8c_azlp9K-g73dxWxsygxff0rbYBfVlovCyTgyC1JluIjOQ>
    <xmx:vigsarYLaoVMp6Y94AlBUFLt4Uzpov8IPRAWHaBGdbOLz35Jnacdhw>
    <xmx:vigsaqgBBr_D1DslyEiq2ryQPJLSieKtfEBpsC2GYSuCKgLgNDdqcA>
    <xmx:vigsal6uvl-A-XNT-RjbXd9HbgxmJZuo6mvw_3xUSwrY3o7v_JDpmg>
    <xmx:vigsalJvrygN8zyhvpZ8LDkmq7qYPu4ek1wUnpv50kAQx0XHyHAHaobi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 11:41:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3] update-ref: add --rename option
In-Reply-To: <aiugat0gvprSX5yr@pks.im> (Patrick Steinhardt's message of "Fri,
	12 Jun 2026 08:00:10 +0200")
References: <xmqqv7brz9ba.fsf@gitster.g> <xmqq7bo4n4ge.fsf@gitster.g>
	<aiugat0gvprSX5yr@pks.im>
Date: Fri, 12 Jun 2026 08:41:48 -0700
Message-ID: <xmqqqzmbhikj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> A slight tangent: this is part of why I really don't like commands that
> determine their mode via flags: you now have to worry about every
> combination of flags and whether they even make sense. With subcommands
> we at least only have to worry about the set of flags that directly
> apply to that given subcommand.
>
> Makes me wonder whether I should have a look at extending git-refs(1)
> further:
>
>     git refs delete <ref> [<oldvalue>]
>     git refs update <ref> <newvalue> [<oldvalue>]
>     git refs rename <ref> <oldname> <newname>
>
> I always wanted to do this eventually so that we have one top-level
> command that knows how to do "everything refs".

That may indeed be a better direction to go, but isn't update-ref
the "everything refs" command already?

