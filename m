Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE951D798E
	for <git@vger.kernel.org>; Sat, 20 Dec 2025 06:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766210848; cv=none; b=trGXJ7PDrdRQko1fUEoKZLJcwSJdUZReiPSaabXMYwqHN4QcjR/hxT1b9ww61N9zfxTEuubTwyk4lupr6ZNUMvHfwd5AS3Ns4QduCYc6cyEag8sgj658F2960v4Pipmx/SBUuo0vpCKt9T8au76DuXCWmGxWbPWOssopFOdhDn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766210848; c=relaxed/simple;
	bh=tLcXcwYpFvtmcYMEc16ziok2v3pNJGvbY1XarWT9vIs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ebdzgLIueMkR3cjMzLRT5punbA6p7ueNq5MxaHTgCgb2cUJdsmNSyAGJieUd1+WVhW8p4A2a+Yoy9W1kDEWWLTCiE0V0VMWB2cxhJItPk36vXxLZbdViWA4yxbYz3eY7olFTO2IqLMW9OfHb/dOigueKfAmhMp/JbdQrhVrASok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MpBqMN/C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xc7g/Fg7; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MpBqMN/C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xc7g/Fg7"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id D6EAEEC0075;
	Sat, 20 Dec 2025 01:07:25 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Sat, 20 Dec 2025 01:07:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1766210845; x=1766297245; bh=k3d6NneTHx
	bMWqI+TX28mNRS7G81oVIfWhpTU36imTI=; b=MpBqMN/CLr7iDQRImoFA7Nhj47
	djbkh80VTTVcXOUkLTzoDq23WBmVbp2mr4DJfFwgk/N3vG7gKqlW4DvYwH/Hji2x
	bjuVuOIk3rKPBdsi22LbxifJZSRFzw9UyS8dNWveUOZU78L4+w8qawGF/knqO5Gn
	501vg4DPnYX2tE5GQUoK3f6iKP5soNW40hNokP9WlF2HWwxRoq1v6DOVMp+ngtwg
	NwPkZoI1JdRJ4TrV80oHh3BJ2RJqWPx3ZVZSG6jWRDFcr8mHVxh1itZsQTedvV8u
	FS2q2ZK5RiUBa/8vQPfK986DuFVhfZiKs5SGKPwrAyw2cPytDZuKs/Y6pXKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766210845; x=1766297245; bh=k3d6NneTHxbMWqI+TX28mNRS7G81oVIfWhp
	TU36imTI=; b=xc7g/Fg7iXu7Mqz1ZaNLuEjsAcw7covpshxqceqxBPwBM33Flaj
	Ti0Hl6wAK3SZftO4ZYhGkFzqWuaR2jk4536ZwbuKTsf8uKYUXEcRnOb13Av7QBws
	YR9m9rsd3PvDWTvMwSvp4ZJHsEuCjTADaEv5e5Krw3Cm/Gy+L8USRKc+yfgxw5Tb
	PWZx7tzmX1Osx1SFkpD27Cxc/R/T/I5vEu6naLvKv8Rsc0OPT9SSLlfvf2NNxt99
	QcGRTEMK0CS85NdrbgFxnf4grzRBBFVHf5O4nfQdtmlz4YBQKYxlPUAO92KWQms0
	etw0s1m23rcAsYiwaNW/eElk3Jiiv1j517w==
X-ME-Sender: <xms:HT1Gafe2Wt7eFdN2QJVVp-U8Zu1SpkolHS5ewygLMdibxRKBqdY4RA>
    <xme:HT1GacG34iXeXeGXp_IPXL6_MN2N9kYaa2n63pWxIJbOEa33uF3Ns2wUkVRKD7GLF
    jtrpo8v5-ztrKp1zil5lkgwLxdy8iXdALKq8GFP0U4Rk-ascOEiAw>
X-ME-Received: <xmr:HT1GaQ02njn6rRiTOay4lxou0FEgPGt8aSVmWrEZ_sluCfda36HBVFPDm3jqCJ4S0dwL69ynNTjRvWTa3sq77kADir9RLApIAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehtdegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    shhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehsrghmrd
    gsohhsthhotghksehshhhophhifhihrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:HT1GacnbiUxTDrafv4VOufs3QhkQxeoDKfuSdT1tOaiJGqtFN_EBUQ>
    <xmx:HT1GaY_nipKNCcms0MIbStXedLuBFlH6Jy8Ho1aHIiCRVAqu3pATGw>
    <xmx:HT1GaZpr_65EEqlqz1rPyQeOtKHMg2Ok2x_zYhZ1XVJVY8FXhrV7nw>
    <xmx:HT1GaZl0nhFhhG7Uuew866ZluQyVxE5s8jio1Gpxj6yDFFVfhikf6w>
    <xmx:HT1GaZM70Li5PTzccp7SJb3l69jkf7gaGfrO4ORO3Gc2KC5fm_9VD_CJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 20 Dec 2025 01:07:25 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Sam Bostock via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Sam
 Bostock <sam.bostock@shopify.com>
Subject: Re: [PATCH v2 1/2] worktree: clarify --expire applies to missing
 worktrees
In-Reply-To: <ddd4191ecb391e10bf4b123f699384a3d609b4a8.1766168169.git.gitgitgadget@gmail.com>
	(Sam Bostock via GitGitGadget's message of "Fri, 19 Dec 2025 18:16:08
	+0000")
References: <pull.2135.git.git.1766156407442.gitgitgadget@gmail.com>
	<pull.2135.v2.git.git.1766168169.gitgitgadget@gmail.com>
	<ddd4191ecb391e10bf4b123f699384a3d609b4a8.1766168169.git.gitgitgadget@gmail.com>
Date: Sat, 20 Dec 2025 15:07:24 +0900
Message-ID: <xmqqqzspu1nn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Sam Bostock via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Sam Bostock <sam.bostock@shopify.com>
>
> The `--expire` option for `git worktree list` and `git worktree prune`
> only affects worktrees whose working directory path no longer exists.
> The help text did not make this clear, and the documentation
> inconsistently used "unused" for prune but "missing" for list.

Well analyzed and described.

> This updates the help text and documentation to consistently describe
> these as "missing worktrees".

We phrase it more like "Update the help text and documentation to
...", as if you are asking somebody sitting on the keyboard to make
that change.

> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index fbdaf2eb2e..82fcbfeccf 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -252,7 +252,7 @@ static int prune(int ac, const char **av, const char *prefix,
>  		OPT__DRY_RUN(&show_only, N_("do not remove, show only")),
>  		OPT__VERBOSE(&verbose, N_("report pruned working trees")),
>  		OPT_EXPIRY_DATE(0, "expire", &expire,
> -				N_("expire working trees older than <time>")),
> +				N_("expire missing working trees older than <time>")),

"expire" -> "prune" or "remove".  As the user already said "prune"
when they run "git worktree prune -h", using a different and more
common verb "remove" to explain the action might be more helpful
than saying "prune".

Thanks.
