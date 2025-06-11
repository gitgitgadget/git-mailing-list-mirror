Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4971C84DD
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 16:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749657642; cv=none; b=dZhHoYQSYFqdoHkVuShuPx3Z53w7QFTi1CuO63+JmHpC/jDmpf0SdTz7iC4+znLVgY7fsbwJa57b8Xlw7P4YEZmeG+UiwUhBeZbDOUDptEhw5Sug4xyntk01VYJJfxQh8V6yJbS4EjbaiuvfPRuHTw811jOtVEckCgPHZsL7Wwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749657642; c=relaxed/simple;
	bh=KSX9MZt9lUVp4lCLGcJpkHHomLCagsm5PYbotwB4Woc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NcJeM/IuXoTTxBoFaKbwnFYKc+3l13VmdLpQAai+uv9SIPU5z0Q2h8tlTQ5r5lYEBNT07/OSK3KtcjOL/M/+qQLP+08wxP86AMVrBWaI7fni1ZxuDPcJct2ykrh1sKSYF2pvbr5h2MoIW/kXdh2uYfwQ1lTGIwBEBGNOkvekxLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=K5lWCcVV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rJ1qECWg; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="K5lWCcVV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rJ1qECWg"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id D17C413804A0;
	Wed, 11 Jun 2025 12:00:39 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Wed, 11 Jun 2025 12:00:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749657639; x=1749744039; bh=PSz3kCFWWj
	LePitGbraKdLd6yLzTeZ8bK5MEBlR1BtI=; b=K5lWCcVV2WEql77boG8HWnowGK
	ntBh7pqyJ03Ra1hv1cpqd9kLTmt7CBd+btdIOTT4++4Q+/atR3+qfNiDvoj6Y6D3
	hBvM4mljZF5gZUuqZTMEdgk1dRzm58XLLeVbY4I31GfDX4xuchAb/QSucZX5/YgF
	vQT99Dyo5FaEscULAPcIEnKIyP+lI5XL+xz01WuBViIQz/Iz1Jitzq9tq60VYPFC
	msOGMQMe+5k9Rn529hFhichFLSAYKqMITpuAhlBXqS/bRVbWqNFYAvVlHo+TGmVu
	ZKQNXudt5vxB6j7xzRz6p84OGkMnpn9A+iWH84RHvuAawcX2NzdxnbdI7dZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749657639; x=1749744039; bh=PSz3kCFWWjLePitGbraKdLd6yLzTeZ8bK5M
	EBlR1BtI=; b=rJ1qECWgPCSN0zEr2mKM3KXTbHjnnwPKQVQ7AHE25wngDJXLZxG
	IrwNS6cXy3tJCZJu7jTozVCToyh2tuGAY3qMdN3e8s8MWlfRoAhIf307Ga1/bGzx
	WlmoMI54ePrkomRQCIBCw648aYNRLaOJYaq5Lk4AmuIJOs9CiVtDNNLTYLZb0/uK
	OFYOqDHspOyc0InldqBgwj+Bztrh7f2HZL9piUi44qXQg5VAVHNlomMAhA99Z/OM
	M50MqgVesk0qX0TFfACfRSIzdAESaolhIvFc4rDkxzx2ya/IJJzKgMIbotzsL/n9
	5WQ+zVi06LaWOxvLWb/0CJZ0ayYyzeda3vQ==
X-ME-Sender: <xms:J6hJaAO7pqcda_PFTrNlUxjy8Lnpa-YMmAj8zkoHDdrSr5EYyWlsYQ>
    <xme:J6hJaG9uvHYjA6zWY4oo7nSQCXIgNRTF1yK230tvlYbwjPXO4YUWmEF7vYWwq_ZQl
    5CJAiRuAQAg7cKGXg>
X-ME-Received: <xmr:J6hJaHQXJ-F7GrnRYmrTglnmO_3rVlnI4MTsq_uvitGS8UczRWBcS6WIJGqAdYC_LzWYpUyZ5nHwXMr3jImS3G329MDJEFxiLDEn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduvdeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjrgihrghthhgvvg
    hrthhhkhhulhhkrghrnhhivddttdehsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlrdhsrdhrseifvggsrd
    guvgdprhgtphhtthhopehsmhgrtgguohhnrghlugeskhgrihhmrghgihhnghdrtghomhdp
    rhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:J6hJaIugingeGJw_Lxg33vvH18asLXWxQ4Mx2xfq_IncTSgQTu9EMg>
    <xmx:J6hJaIcBq6XcU-NA1o3t5J1ZeIyodDRfNPcGUjgp--U3ToXy2h1rAg>
    <xmx:J6hJaM2MiShpJvgz_V96-aTgwdsF1FlJt4Gxp5zlYx6x8mb1L11cVw>
    <xmx:J6hJaM-yqtyWwee6VeJgx8hHiKugia2Z52bB0-ThwuGLSp5Z-kiaIw>
    <xmx:J6hJaE1_XA9PhQEJ-RZcGw3Ugjs97f2PEx3WS92RBWbl6tvgRFwMiayg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Jun 2025 12:00:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org,  l.s.r@web.de,  smacdonald@kaimaging.com,
  sunshine@sunshineco.com
Subject: Re: [PATCH v3] stash: fix incorrect branch name in stash message
In-Reply-To: <20250611014204.24994-1-jayatheerthkulkarni2005@gmail.com>
	(K. Jayatheerth's message of "Wed, 11 Jun 2025 07:12:03 +0530")
References: <xmqqo6uyw6h4.fsf@gitster.g>
	<20250611014204.24994-1-jayatheerthkulkarni2005@gmail.com>
Date: Wed, 11 Jun 2025 09:00:37 -0700
Message-ID: <xmqqqzzqi7yy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

> When creating a stash, Git uses the current branch name
> of the superproject to construct the stash commit message.
> However, in repositories with submodules,
> the message may mistakenly display the submodule branch name instead.
>
> This is because `refs_resolve_ref_unsafe()` returns a pointer to a static buffer.
> Subsequent calls to the same function overwrite the buffer,
> corrupting the originally fetched `branch_name` used for the stash message.
>
> Use `xstrdup()` to duplicate the branch name immediately after resolving it,
> so that later buffer overwrites do not affect the stash message.
>
> Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
> ---
> 1. Used the hook to remove trailing whitespaces

Huh?  The pre-commit hook trick I showed was to detect and prevent
you from creating such a commit; it does not remove them for you.
Your trailing whitespaces still remain in the patch just fine ;-)

> @@ -1401,11 +1402,15 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
>  		ret = 1;
>  		goto done;
>  	}
> -
> +	
>  	branch_ref = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),

which causes

    .git/rebase-apply/patch:29: trailing whitespace.

    .git/rebase-apply/patch:39: trailing whitespace.

    warning: 2 lines applied after fixing whitespace errors.
    Applying: stash: fix incorrect branch name in stash message

Other than that, looing good.

Thanks, will queue.
