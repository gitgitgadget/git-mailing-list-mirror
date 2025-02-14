Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C531DC198
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 22:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739571070; cv=none; b=pSVzIeO15bmoz6201+ZuKxIC7PpuHyHcgYELUg7Ng7soG1Y/8hK/z40qJiXMxuKKKuDnDc6ld0VCxGl4FWWGgfiJFfZFlscq7zbeoRQ1SP/v50dROd1q+cgP7BX2VFLoIPUJptkdo9YruIXGhcXugC5/yJYDdYWLRhRGDMP5DVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739571070; c=relaxed/simple;
	bh=lmc1qpNj4gg2nG0spci5vzVdTMnh8O2tiHEE33nl7Nw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YA69/fB8Oepw3gknwD5o9zSv6zvt8idzu8/K9arKmI2pPJupb52gBoDIgT9OUOyaXFtV4+RPIHECTwP/sgNVJT/v3CJu4OXxTmhY3TC2X79wuhddFvjwo/LbLnIAY3104IAbz+NlbG1gy/KugjMy7gZ4vOnro4EhHNhSJqqZ2mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IpDMkUXX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DNIWdjNi; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IpDMkUXX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DNIWdjNi"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9CE0F11401B2;
	Fri, 14 Feb 2025 17:11:05 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 14 Feb 2025 17:11:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739571065; x=1739657465; bh=Vb4VhpMCcH
	ND/vGnufBHdvkrjrZjFaCybdLmZ8wS2Jo=; b=IpDMkUXX1uum21wOO5v/gvyM2u
	YJ2q9CXtlcsnSaHMhrcIQkHtPcT741PMnMk2kwDUqNr8z/oAX2XQmxbST1mOp8QZ
	OMNZcB7ojWBRWVSsSgGsiVbae8wuD8gMIj5CDttWZpmgwdzKpFL+FyMzX/557ioS
	QLNLGF2/QgdhD1G13SqHxCfIn3LhtWv7zfn5O8EF5aHSW7caJj1w8IiaoQ5CWTgd
	Y6A9Setx9lAMW4JyxHNtHJeJHEYX2R3AmdkQ0jvuxGcpdf1tvjWLg8yBfJJZBLTf
	nfdhvGGTf62wtQ74d/OJ+T75povsl61/leMe2hWjeHjWxvTccADX6GDptW8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739571065; x=1739657465; bh=Vb4VhpMCcHND/vGnufBHdvkrjrZjFaCybdL
	mZ8wS2Jo=; b=DNIWdjNiK3/M1JUmBF1KzAwffRwa/Znewj5FNKYsMES/UO6O4DO
	1wgJuEmEIx58zHR0kKpH1gDIvf8XkGE2MinmgzV+K2hDnNAzFx5SgLCj2z0w83eg
	VgUG/1Rxu0XaT95Fe23DoxbHUtkhkxOR1s/nAdLT2tLkMQo87Z/RKulzB6dSWMB+
	Yv9BpliMLtbfA6Q3jSFb4FB4NKoyYUMD4lasFK2Ejl4obr8Oa0u01NAqZrmpgbI1
	XVssqdVhejbw04ctrJR/8vlZY5+gQW4WfLzkolbDUDt6Ql5omJSxCV7D9y9KPgWG
	7TVHJIdIncEbyJnrtPKwOe926yH0/8LtHpg==
X-ME-Sender: <xms:eb-vZyi_J2RWXTFpF5jWMgVH_2egTdMLHOJuYkvEGmwLQ0bDwJmveQ>
    <xme:eb-vZzBwgIsl9Zg5t4c6Hsjgz0A6I_u23Sj5BP4xOW_Tl6zk0cY_rjj74akSB_wGb
    oLdieMP5ibtut0ljw>
X-ME-Received: <xmr:eb-vZ6E8G85tu396j8KKCedYHQptBmZHNcFaJeJvq3vvieKGyT1EV_Q_wG1Rx_OZWOMTzMSRlUFDZGE-JxZyKL9ESZkPKHY7KidWhDk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehtdekudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrg
    gughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepsggvnhgtvgesfhgvrhguihhnrghnugihrdgtohhmpd
    hrtghpthhtoheplhgvvhhrrghiphhhihhlihhpphgvsghlrghinhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:eb-vZ7TiYAEOZsZuKp1trwBywTUkUqgV0HFr9EFNka0Qed_2qfdGaQ>
    <xmx:eb-vZ_wCIvSkjcn6lOp_Cm33HpkqMhxqx4cTixdbbar9plplZaGW8w>
    <xmx:eb-vZ55JYErqXFpFOkvIsnzihUPGsQW8day8fo9ZXeUEGa6fNXWShA>
    <xmx:eb-vZ8zdaIGyWkJc1fIqrqcqiwK783W-Wk-UjuzfMNrCSjBADgTpGA>
    <xmx:eb-vZ6oVtezWoj_pLKj2YgBKHl3hCzkgl4ZlZRbgitHZ_3sKrwtaPfsm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Feb 2025 17:11:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Bence Ferdinandy <bence@ferdinandy.com>,  Philippe
 Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 1/2] config/remote.txt: reunite 'severOption'
 description paragraphs
In-Reply-To: <cc2e59ca0475ea2d4f2df7784d5a4c81a70c264c.1739554578.git.gitgitgadget@gmail.com>
	(Philippe Blain via GitGitGadget's message of "Fri, 14 Feb 2025
	17:36:17 +0000")
References: <pull.1894.git.git.1739554578.gitgitgadget@gmail.com>
	<cc2e59ca0475ea2d4f2df7784d5a4c81a70c264c.1739554578.git.gitgitgadget@gmail.com>
Date: Fri, 14 Feb 2025 14:11:03 -0800
Message-ID: <xmqqy0y8jhxk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> When 'remote.<name>.followRemoteHEAD' was added in b7f7d16562 (fetch:
> add configuration for set_head behaviour, 2024-11-29), its description
> was added to remote.txt in between the two paragraphs describing
> 'remote.<name>.serverOption'. Reunite these two paragraphs.

Ouch.  Thanks for spotting and fixing.

>
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
>  Documentation/config/remote.txt | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/config/remote.txt b/Documentation/config/remote.txt
> index 4118c219c13..1b9814e8aa4 100644
> --- a/Documentation/config/remote.txt
> +++ b/Documentation/config/remote.txt
> @@ -101,6 +101,11 @@ remote.<name>.serverOption::
>  	The default set of server options used when fetching from this remote.
>  	These server options can be overridden by the `--server-option=` command
>  	line arguments.
> ++
> +This is a multi-valued variable, and an empty value can be used in a higher
> +priority configuration file (e.g. `.git/config` in a repository) to clear
> +the values inherited from a lower priority configuration files (e.g.
> +`$HOME/.gitconfig`).
>  
>  remote.<name>.followRemoteHEAD::
>  	How linkgit:git-fetch[1] should handle updates to `remotes/<name>/HEAD`.
> @@ -114,8 +119,3 @@ remote.<name>.followRemoteHEAD::
>  	Setting to "always" will silently update it to the value on the remote.
>  	Finally, setting it to "never" will never change or create the local
>  	reference.
> -+
> -This is a multi-valued variable, and an empty value can be used in a higher
> -priority configuration file (e.g. `.git/config` in a repository) to clear
> -the values inherited from a lower priority configuration files (e.g.
> -`$HOME/.gitconfig`).
