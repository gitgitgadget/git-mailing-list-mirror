Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7301E2F25F5
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 06:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770012746; cv=none; b=m1c5vC6p7pTeiRP1qYPS5f0dI8QTsn5K98aR6KgjFWAfylWhH/vIYlf65Wo5C76MJY4seFuOF/eVIPqQvhOpStPF5kJTx2qcvS5XSZB/4JsoUJzhkCxq21o26T767Jqw9v1qIj7tbedlHD0lxxHroeD2lL1F9bpIYY27LMMJe4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770012746; c=relaxed/simple;
	bh=gDx4tlvudkOcIIPBfRYu8mlqFRe3E2ktiH5HRfGVVMQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kyi1N2Uv+jz7EJzrAOY59NOncB7Nt66kDU+jjx1UCIVvAAMfancIl/Bpuq0whdLu9EQZq4LCdONK/uvonZM7V40HaUgdxxaDA8bRNSIG4GwYz+b8IXGCHrSTeJmUJh7rrCFYBmSJSdFdk4ug5AoOFFH33kQFwjqEeEh+jM6X3UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=yevNzcZJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rtWz67f9; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="yevNzcZJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rtWz67f9"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 993DAEC00A1;
	Mon,  2 Feb 2026 01:12:23 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 02 Feb 2026 01:12:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770012743;
	 x=1770099143; bh=G57mQObef08xr0y3s5oRNb0r8rMhjH7HENtMtHQYlio=; b=
	yevNzcZJ2P0B3plEF4TwOMYiMqsFDaz5meEjMUXrsnL5yTtHRzqtXhEtpYRfuYHR
	KS9z+ssWAzTXvE3X8fALooC6Rh9zftkSLWNQm6/9klxnNtOLTUM2mqKCno203h6X
	bR6l3XCWJ3A8Lqr7JvAkwqwk2zMyCkajnRNz2bQOQtlw2KDCxJSyRAyZULTqgKq/
	GoEf46gQaMguZpweTxfheykz78R1D//h15mN5qwg6JACftzlaVKgLG8JEKhIRfac
	kZDrcRzCI8LHoDFwumOAYDXVCihlxGlMr+T+TnIPv5keKu+ze2zsrvRy9nImb1eh
	EqsOcLvs7hm0uS9oWmON7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770012743; x=
	1770099143; bh=G57mQObef08xr0y3s5oRNb0r8rMhjH7HENtMtHQYlio=; b=r
	tWz67f9sbSWR83/oChUOUYv/rrKw3cQxph6yEiJtyMqDQfZ2FfOnj8QH9VHAWjNK
	jqA1ogt3yQFqga4U87OIlO3WtMV9tSBC+bikVEEAX1uNH0CloGc88/WsW8trvn6l
	aK2UDi0/TvPv35067KNjZCnWGufMuc0a7rnJhhOgFvJotSTUQogC3mY7Gr3h+Dzl
	ft+8K/BohCs0yVyN+qjkq0AKyE8xb16GfMx9p0+n6dlgP7WO4Fi68wHOY85ps4rx
	Q7EJmM36pdYf2K2fOg7niMlcbzlIofbgxwnd96lAptfcVWUF0GpXO64XpWjCLPqn
	gNyd0ynNP1lc620dzOlFw==
X-ME-Sender: <xms:R0CAaQ7zMQWPfiNLei3nJ7k5DjAKbF7JpiXxTc3vKSwplDW0LGdgMA>
    <xme:R0CAaZUIXf1cmn-fp_3lMGJ4U-zS6_Nhc8U-N193VMoIuCoaAYLK3Hx9o4vF6312E
    RN7etRBqg_VVHcbdAnq_GEZVUWfIbf4NEhSCX9tDSbsBaoi46plnXs>
X-ME-Received: <xmr:R0CAac2NLMods-6JZj0kDWHmSbfZpvB0lU0Iu01IlvGJI2mY0TJXqm0U2cmb20qb0oYZlFvK-5ewzIX7FZ34051qaPomcxUjxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeeikeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegtrghrvghnrghssehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:R0CAae0RJYTA9fuH0Tln_q8mWatkaTKJfZEaLrcFx5JYfEso72F30w>
    <xmx:R0CAaX8LwQhGB1-oxJxDHIA4tCiUGn3IpwZFGcphopWbHYh1s9Mqcw>
    <xmx:R0CAaT2AK_CNubW8Cuxc334jADfQt-vOK50Ulv0y_VHax0XI97h_pg>
    <xmx:R0CAac9xy-M15_I3WuABoO-VEs3kGSlnUVcOSpL6MwgkyCpRNIbBow>
    <xmx:R0CAaRVfPtPFzI-d4tqci52gHfDgIZAoYZs5asCxvnONvprjqvn17itB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 01:12:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] RelNotes: fully spell negation
In-Reply-To: <20260131230848.4790-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
	=?utf-8?Q?Bel=C3=B3n=22's?= message of "Sat, 31 Jan 2026 15:08:48 -0800")
References: <xmqqpl6vezt3.fsf@gitster.g>
	<20260131230848.4790-1-carenas@gmail.com>
Date: Sun, 01 Feb 2026 22:12:21 -0800
Message-ID: <xmqqo6m73c8q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Carlo Marcelo Arenas Belón <carenas@gmail.com> writes:

> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  Documentation/RelNotes/2.53.0.adoc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/RelNotes/2.53.0.adoc b/Documentation/RelNotes/2.53.0.adoc
> index d3f6d18199..2668c2e996 100644
> --- a/Documentation/RelNotes/2.53.0.adoc
> +++ b/Documentation/RelNotes/2.53.0.adoc
> @@ -138,7 +138,7 @@ Fixes since v2.52
>     (merge 42ed046866 jk/attr-macroexpand-wo-recursion later to maint).
>  
>   * Adding a repository that uses a different hash function is a no-no,
> -   but "git submodule add" did nt prevent it, which has been corrected.
> +   but "git submodule add" did not prevent it, which has been corrected.
>     (merge 6fe288bfbc bc/submodule-force-same-hash later to maint).
>  
>   * An earlier check added to osx keychain credential helper to avoid

Thanks.  Applied.
