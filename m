Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161BF1B87F1
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 17:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736790134; cv=none; b=daL7NsMwy9wON3wL6/2tGFQIyFhD3xPUeBrUeOsvhV3LxMOmPevOIkcAHfryiHBRZxlCdObF5XP8RC6CLuzhOfI31u0EVfVsNy6CsmaCdfKQ3WosNazDV0f1PDR2rpsxz+HD4TuWy7ors2UGdquwfg/UH3RTPT7aQTUtoSWu3fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736790134; c=relaxed/simple;
	bh=tdTAjRSDQapdElzqlTrjACITVs0uCD8YXHlqP3K5yWo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p51kijnH56Waulz90rRIDOh/R0O3ASIw/f53gyDvyvg2yn8PpgxeGf9xPesuaJvQg1DJfDDM+Gky9RkgfzSZE703qRBrNxL3fw0Me627jyh4M5GaF4jE6o9AsGEqXIi+NY4XJhHGF0gsn6BpmelsfxBBDGnD1RbKgPYvfhuB76I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EeLw/TXi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Oh9Z8dLg; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EeLw/TXi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Oh9Z8dLg"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1E3EA254019E;
	Mon, 13 Jan 2025 12:42:12 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 13 Jan 2025 12:42:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736790131; x=1736876531; bh=p1g9bB/wKS
	89JRY48cVwi6pFfvMfa8l4dwmo1wwk/wc=; b=EeLw/TXiNOcJK7y69pgbZnHQyt
	mT0w9vyyqNxhH7tT0WeSBi0w6Do0E3CdaebESoC7qo5DxjRrbX4jOjxrZSFlFc72
	Uqer88TmnTZJDFfqrGuoZqI7FUNcko2mxc5Tnpd9keWIrIi/monhswxAH3wzdQ6G
	Kmou7Onq2eAsxLX9dGZIuS/jqnxSle1PV4FiIvR+lpAJMm3XprekcxacLQGEeIlJ
	uvrhE/hNmp82G5CcYJnBqn5ImH5NSxzv8mLaayrxXWmurDt2eOsQpASyFRC678L/
	xrPr5jNrRsG1wQZkCQvF8qrytsTwBXIeEIG0kJOrH1qoJawoWyhH2gUQuJcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736790131; x=1736876531; bh=p1g9bB/wKS89JRY48cVwi6pFfvMfa8l4dwm
	o1wwk/wc=; b=Oh9Z8dLgO5cvN1lqrYOBbEndZY2IWE0WETIKEs08h7yK3141Aia
	b4MzTN26urHEy8qnojnetpzyIQ6yPUne4TIB6NP+Pjph6YBUnFyLfBkv5BDzpsm6
	Thr2YR9de1AhkrtHPTjj5uahdH60/K2fWQtjSnk6jMPKg5/daOfvQ8KQ07mJ0xhb
	LR5YiWkrHogfpv0bYyHJVmL0P6FuPNs6m0e+3KIhjrRAGFgKpia74zN0pkdaOA99
	Nelb3GbRgwqE0ZVzz/ul2spMBvzhDoczVdDYmodYH5m4Lp/rPN0cPpB/rn2zP4qk
	dBFAibDqpNuEIiyRuAYOsi4sMszPcVkeSHQ==
X-ME-Sender: <xms:c1CFZ9ae-fGPEvSJoq8IaLuKj43M1EcD_Boztu4TcHDL3HBRS_zG4g>
    <xme:c1CFZ0YBO5XDLnzPTio_wjfO537stoPaSO7gpDKBIMGjz_kP2L99fGAw2OdTcB8u3
    4xFbzDzfPAkILmc_w>
X-ME-Received: <xmr:c1CFZ__GLGUyc5B5-dlZbEgMc5Ff7zaSUBFgtmfBlc_GIRMwPHA-2cQWCWSSO_D57yeUbJNGbhKgdIAnaQkEJL9ABqLkPqZ3wu7b>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehgedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegvvhgrnhdrmhgrrhhtihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghstghhfi
    grrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:c1CFZ7pA0ShL_lLtioPI05KBpbVUCFUQm1GfJue5OIrR6E8xIkzxuQ>
    <xmx:c1CFZ4pv-5SIFDAqEsDctqBeV5HCfRLYnkGpbJi1SFzyr0miFB_SwA>
    <xmx:c1CFZxQWY1UoC43eb2H8yu6wStgTTFS_hmmQ74cDXVzW2dyZwFVxsg>
    <xmx:c1CFZwrwE4bm1jiCNbPVfzb_2xhvZgKl_457JPqD7wxJ765PEzYFsg>
    <xmx:c1CFZ9D066b4uyYaK6L7xPE8c5tJPfqGs4t3UqOHjUak-7PH_dfP8Wv1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jan 2025 12:42:11 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Evan Martin <evan.martin@gmail.com>,  Eli Schwartz
 <eschwartz@gentoo.org>
Subject: Re: [PATCH 2/9] GIT-VERSION-GEN: move default version into a
 separate file
In-Reply-To: <20250113-b4-pks-meson-additions-v1-2-97f6a93f691d@pks.im>
	(Patrick Steinhardt's message of "Mon, 13 Jan 2025 09:33:35 +0100")
References: <20250113-b4-pks-meson-additions-v1-0-97f6a93f691d@pks.im>
	<20250113-b4-pks-meson-additions-v1-2-97f6a93f691d@pks.im>
Date: Mon, 13 Jan 2025 09:42:09 -0800
Message-ID: <xmqqa5bua9vy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>   - We can pull the default version out of GIT-VERSION-GEN and move it
>     into its own file. This likely requires some adjustments for scripts
>     that bump the version, but allows Meson to read the version from
>     that file trivially.
>
> The last option is a proper solution and quite trivial to implement, and
> adapting scripts should be a one-time event. Refactor GIT-VERSION-GEN
> accordingly.

It is not clear what "proper" is.  It smells like we are bending an
established work flow element to placate a tool that is not willing
to cooperate, which is very much unwelcome.

Compared to that, grepping for "^DEF_VER=" in the file may be less
yucky.
