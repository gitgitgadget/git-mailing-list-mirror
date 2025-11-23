Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6C2747F
	for <git@vger.kernel.org>; Sun, 23 Nov 2025 02:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763865464; cv=none; b=nwNSRRZWI7Evm2BNOP8cR4czZdEabzqjguIDAX9H8fGnM0u2kdfulwiijbz/JfsajjSiF3pETQ6+DSdOPE9Q+9ZHIMXE2gqMIK/K6/a6+tcBkXR5u3y13TyvGvZ8LzOA2+LjBr8MXofe4eDX2Bll0Ibfa+LYKkM9M0L6Xzg4eYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763865464; c=relaxed/simple;
	bh=zUVvCNUQoe3NAjyPm4awyFBy1/HVL0WJ1P0pId0wRnE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gz5UoWDmzxjEnim5CtARx5R1klD9b0Ah8J7i6hqplh6u+3um+qwbnc5cs5+GC+DInow/mU3+gVii+vkxUcyRun3nO20UDCpzjno6sEqkzL9CvNQcYvRn+qVeQW2yEd6TduPBubOSGC88LI2e2W7Cd/feAc8a7bXadKx1xETbvL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=G9cqFAl7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ULbnPjUa; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="G9cqFAl7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ULbnPjUa"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 96FF21400076;
	Sat, 22 Nov 2025 21:37:41 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sat, 22 Nov 2025 21:37:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763865461; x=1763951861; bh=jP/u7t/5Cn
	sesZ65KPUzq/HiNP9F/xsZJkGs5fJLOVk=; b=G9cqFAl737SVPptFhurZK+DOwz
	LbU3c91gzzit4ZY9z1MAgtlW6D0LhYKrmIjOTMiwWkPXUAYpgXnvsWH9leZtUoMD
	NH9HAmnY9xrLI/hH0m6b4XxFDF63uaDemNaIVwAVI9LFPwN9DayGGAbHJYIiXNAc
	nPxUJsFMHIqwP1ZbXIu0tFWMYNCWB7BHne0sVbnr7oG6XAvHLJOy20Dk+TMJYA21
	y4iX39t888Q4HXPs6c60bdN8NHFrgUnPqMHJmeF6NfKizcEXWk9I5kxnA35lHv5s
	CSS/rgxFs9H0db+wUHmsD/OytwVsyjV71JxBgnwFsDmrWjAOQLl/FLQFT8oA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763865461; x=1763951861; bh=jP/u7t/5CnsesZ65KPUzq/HiNP9F/xsZJkG
	s5fJLOVk=; b=ULbnPjUaLbQc7DeV778ooEEy+jwzdZpD30rPoyCHSnxo2GwiArx
	e8yK9X7oNgjLIktYJyu9sjbdh4WOgfyvz0eXuLWf7qoxIg76qWqHZ2bx4iBslJpn
	+xNYXA2t1Wob8bXv9s0KpE2qBpNzlJZH0uUvBmvwBWBcU5537SdrS7U+2Up7rRBq
	naL+u/cGLZG5eHsAFtSP3iwlVR+vKUV5JvbCd2QQ3b2p9Hkq/ISjabi3Em2ScIw3
	EFozXz7o5Gi1Onej1Eyzxy/Pxx2jxK7PQShU1FYhlDYvPTTyHxhWAOVnN8hvYs4a
	5qUIeZWbvruXzuyqsKgPBq/7wtMzBlr1zAg==
X-ME-Sender: <xms:dXMiaQJ0PdCcc9VSg_Pb3Are6Jv5x-f-2C-mGvaw48Sy5BWRlAQYZQ>
    <xme:dXMiaSY1Co2af_ANzq6Of8OL1P3llD9Sp8uqaPSR0bJzKU1asrWLcPdU1LW19Ci_H
    ND2hSTuAAp8S8-LobbGxVdL27JoyMULZOsHlA6pUKSeQLqfcfA5EQ>
X-ME-Received: <xmr:dXMiaS-hZBewX4Djl_2xsrZ88PFQyi-W63NL1pe6zGyOAUk2Dr36JKMlb01WSclRYoQsY5FxlH9G32jqKINDggdgHbc4ldYk--W1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeegheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprh
    gtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehp
    shesphhkshdrihhmpdhrtghpthhtohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:dXMiaTZJrEYzU0frzog3ssMQXZ-e1bXsmrgAdpExn9hAToFBkx_m3w>
    <xmx:dXMiaWOEnnrA-1HkFDiqz1aT6SXCpR6y8LGqyHc9vjqQzjp4BirQuQ>
    <xmx:dXMiafCvANgQRuij8wEmyloyQumyDXAf87YUYQiZnJPvv6kXmAU4SA>
    <xmx:dXMiadLkdlsFyp12qkFMRfXIPiWirE8-4HmogPwXDEUGmdBqkSxpIg>
    <xmx:dXMiaTOwHDSK29gV9ivGz6yTtoekpMBZkvB89Wzvb5oKEiV4x0VINsl5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 22 Nov 2025 21:37:40 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Patrick Steinhardt <ps@pks.im>,  Julia Evans
 <julia@jvns.ca>
Subject: Re: [PATCH v7] doc: add an explanation of Git's data model
In-Reply-To: <pull.1981.v7.git.1762977200244.gitgitgadget@gmail.com> (Julia
	Evans via GitGitGadget's message of "Wed, 12 Nov 2025 19:53:20 +0000")
References: <pull.1981.v6.git.1762545177204.gitgitgadget@gmail.com>
	<pull.1981.v7.git.1762977200244.gitgitgadget@gmail.com>
Date: Sat, 22 Nov 2025 18:37:39 -0800
Message-ID: <xmqqv7j11nkc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

>     changes in v7:
>     
>      * Replace "file mode" with "file type", to make it more obvious that
>        Git does not support general Unix file modes. Remove a broken XML
>        link as a side effect.
>      * Use "top-level directory" instead of "base directory"
>      * Like last time, I still don't have any better ideas for "A branch
>        refers to a commit ID"

We haven't seen much comment on this iteration, and hopefully that
is not showing the lack of interest ;-)  Shall we mark the topic for
'next' now?

Thanks.
