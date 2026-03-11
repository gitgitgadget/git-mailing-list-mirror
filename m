Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BCD3CF03D
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 16:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773247131; cv=none; b=UoFXsd164/w8dMBRxsFj/gr5IACX1hESSSX0nx8HkFA6RE+PbuB3eIRcsr3X6jTYnz65jk6DHc7T1gT4twFXi6B0ZGfw0MVY1UVJr9k6HxuhCYscP95PSAWnGbGtNHmThomtMZi8q25cRcbJVljqhya4D/lRoY/TF7+7f/2U3sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773247131; c=relaxed/simple;
	bh=jOsodiZlDVAxAU+h4gKyBY2T2CbZA3MA32FYY4tEH8k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gYXFm1p3B4encqgHPe+VT2eFWKe7T3PtW+giYUmu8OtdboO1IFMMVBqNCPh0hC5oSPLwJ5GnI6eMts5Z3Ul9mFdQ9X1QS6Gpd1pkZyEcip89He2Y2PnlxH3/jEC440BYV6KYUOh5BeaR0nsrZpTrvVWr3vXfFTjTZUIq5Lkq3a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=k0RV2IeZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uGzGbHTw; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="k0RV2IeZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uGzGbHTw"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id A9B3EEC0AF5;
	Wed, 11 Mar 2026 12:38:49 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 11 Mar 2026 12:38:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773247129; x=1773333529; bh=gBO6v23yOL
	ijAzpJFrQl3SI/jfeR+N2l7SgAekS0vbE=; b=k0RV2IeZ4FmxlNfL+2/irrm7Y5
	++peboR+mDQpYPcOEQ1v9TQMpKuGeuM6xGWUH8MD2Tqj2neHMb3A7yyhC8hJjGD/
	UqCK9pyb0iG6Sp4hWgO3UawveCIOTpkYzJBoFNcyaI4aVH6en/C4zbaJ+zkOXb2J
	CFBCFctjOmO9xHrkfPm7+Cbz7G3mECa4MhibIjXYoEaJ7l6wBa9hV/VWWMebUedc
	pBOn3Jxj4dcsE43APC+h2aKCqazJy+pbHdbwFZrwtKYvmDSs0awgUgzNAiRaVlKc
	Lp4GUEHH91hWWrA+aAYfEdW4V9P+invlrP88MEjp9QXu0FX0cKNneQhFoC3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773247129; x=1773333529; bh=gBO6v23yOLijAzpJFrQl3SI/jfeR+N2l7Sg
	AekS0vbE=; b=uGzGbHTw42LXCaV5HFy1sGA+8+gDCUlTX7mZKbyjOaGL8KmICIM
	EIpd2y1HGV14WMyXOp1v+GkRyBTfDx9hnadtTFXP2jB+GJItk+WJGXyf5luyyqGp
	4qDHEucQsgEvTwmESnKqmQVo+juA1hliwBMwEQnqpwbrLI5xscCqfIgIAjHvqm3c
	Ra7awb6LEkPP2N7+ObCFhqinfPv3l19fLoc9RMPdwKM0KKgK68gBGcDOatJYaUoE
	QApoA+VslZcWRMmSwYjxSdkRbWZ9UBlZ/CugAwKWYCw1LpXAw9J0f1Pp3j073Cf7
	wLJ89+FNIiyEN9neAdcDTwrgTAb1/wnBFOA==
X-ME-Sender: <xms:mZqxaUbNG-4hek4R5M4YO-GQUfeEbZyBBbMbaiGGv1TIHTaaLn0oCg>
    <xme:mZqxaRpPmUv9A9sngJc_wbhTh8iLiz8seS24hh2CtCDjeLaIDzkIt80X41XWHEImo
    juTQpDx4vlcCBUAdARsyfqKA7m1Za541bceFc3w5y5TRDNFhIXB>
X-ME-Received: <xmr:mZqxaRPmk1CJMsXNDqnKL-KnwUNFrZCuvSQuped2ITjohoe8lbn_9ksWeyYWO5ZmENfiMwjfX2_EugbnDj7K8Gq93t1BPFslUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeeggedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfe
    esghhmrghilhdrtghomhdprhgtphhtthhopegrrhhshhhsrhhivhgrshhtrghvrgdttdes
    ghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepkh
    grrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:mZqxaUp24VHBWGo74GtTLgybjnQFh90skb01-33f5qYxCsVgiG-roQ>
    <xmx:mZqxaeetMu2ZEoPuir0tjGcDPmxXRQumSb0WjJi2SlV09nfvtcO7rw>
    <xmx:mZqxaST1EnxYYnCV3t26suC2HQpjI_L0OOFZ3KViZNXyiqPziMnAoA>
    <xmx:mZqxafYTW4XoR5Gh_92MgurJyMlD68_4AVVZNc3DxCE-p_oeDYwXNQ>
    <xmx:mZqxaWf-EV7iBlSuD0-Dn4EffUfqlo-9qFthxCR0tAeyyrArdloutTyf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 12:38:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Arsh Srivastava via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Arsh
 Srivastava <arshsrivastava00@gmail.com>,  Patrick Steinhardt <ps@pks.im>,
  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 0/5] Advice on checkout dirty files
In-Reply-To: <pull.2233.v4.git.git.1773219028.gitgitgadget@gmail.com> (Arsh
	Srivastava via GitGitGadget's message of "Wed, 11 Mar 2026 08:50:23
	+0000")
References: <pull.2233.v3.git.git.1773149337.gitgitgadget@gmail.com>
	<pull.2233.v4.git.git.1773219028.gitgitgadget@gmail.com>
Date: Wed, 11 Mar 2026 09:38:47 -0700
Message-ID: <xmqqikb2qq20.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Arsh Srivastava via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This is my submission for microproject [GSOC]
>
> This patch adds a new advice type ADVICE_STASH_BEFORE_CHECKOUT to help users
> when they attempt to switch branches with local modifications that would be
> overwritten by the operation.
>
> The new advice follows the same patterns established by existing advice
> functions such as advise_on_updating_sparse_paths(). When triggered, it
> lists the affected files and suggests using git stash push/pop to save and
> restore local changes.
>
> The advice can be silenced with:
>
> git config set advice.stashBeforeCheckout false
>
> Changes:
>
>> advice.h: add ADVICE_STASH_BEFORE_CHECKOUT enum value advice.c: add
>> "stashBeforeCheckout" to advice_setting[] and implement
>> advise_on_checkout_dirty_files() function
>> Documentation/config/advice.adoc: document the new advice key
>
> Signed-off-by: Arsh Srivastava arshsrivastava00@gmail.com

Even though no developer is perfect, when you are presenting your
updated work, armed with wisdom borrowed from your reviewers'
comments on your earlier attempts, you are expected to take the
opportunity to pretend to have written a series of patches that are
perfect logical progression towards the final shape of the code
without detours, change of plans, and fixing earlier mistakes made
in the series.

Please do not throw a drunken-man's-walk series at us.  For example,
I see that [PATCH 3/5] literally removes what was added by earlier
patches.  This is not a place for you to show how you made wrong
turns before arriving at the final shape of the code.

The final series accepted by the project will have to stay in our
history for later developers to see in "git log" output to learn
from, and a series being clean logical progression is a must for
that to happen.

Also, what is "updation"?  Is it a standard English word, or some
dialect of an LLM origin?

> Arsh Srivastava (5):
>   advice: add stashBeforeCheckout advice for dirty branch switches
>   advice: add stashBeforeCheckout advice for dirty branch switches
>     [GSOC]
>   unpack-trees: suggesting 'git checkout -m <branch>' with its
>     repercussions
>   Updating tests and unpack-tress.c [GSOC]
>   File updation [GSOC]
>
>  t/t6439-merge-co-error-msgs.sh | 6 ++++++
>  t/t7406-submodule-update.sh    | 3 +++
>  unpack-trees.c                 | 9 +++++++--
>  3 files changed, 16 insertions(+), 2 deletions(-)
>
>
> base-commit: d181b9354cf85b44455ce3ca9e6af0b9559e0ae2
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2233%2FArsh123344423%2Fadvice_on_checkout_dirty_files-v4
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2233/Arsh123344423/advice_on_checkout_dirty_files-v4
> Pull-Request: https://github.com/git/git/pull/2233
>
> Range-diff vs v3:
>
>  1:  eb5639dbc3 = 1:  eb5639dbc3 advice: add stashBeforeCheckout advice for dirty branch switches
>  2:  e88c851701 = 2:  e88c851701 advice: add stashBeforeCheckout advice for dirty branch switches [GSOC]
>  -:  ---------- > 3:  4237b9667d unpack-trees: suggesting 'git checkout -m <branch>' with its repercussions
>  -:  ---------- > 4:  b25ea22410 Updating tests and unpack-tress.c [GSOC]
>  -:  ---------- > 5:  2ef7d5a3d6 File updation [GSOC]
