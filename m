Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD3033086
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 20:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751921980; cv=none; b=I2GiAuOwCzNiVCCg0uZ9zQ+5NOPvcQ2xs9quRXolfVtWou4/oBMrfEETCsHnIq48m99euSwwmIRokMtULSxfNstsW/XqftmZNVglUh4bl9h6Wvd1kIVLbZ2oPD0kOPmFyLsdsl9dAn5EI2u0OlBego8Wg2o1UhI6qF/nRcmIf3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751921980; c=relaxed/simple;
	bh=MGjIR3DhX4mWBoJAidRE1/gjnRmOMP8E9mIWR25uE44=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lNwhu+/0nnJa/MLquxL/Pg4q2drW6RON9tMsj0KxIkavOhy3d6PexwiiAV6Q23HwuYi9WwlhKunDb8MXRmSjhYNC12Q2/2tggJHwa9DsExVuFKMwZGfEBSDSLigbv46CQKwgrYTxAumPlTt41QuOyPp+oVY5z6YQ04Gc42CqOsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DzxoihGl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nJXejVGm; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DzxoihGl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nJXejVGm"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 33058EC0493;
	Mon,  7 Jul 2025 16:59:37 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Mon, 07 Jul 2025 16:59:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1751921977;
	 x=1752008377; bh=5T9a0xsjKRKN3LyyF3gfzYmFLOf+ugLVoUDTmhQgd64=; b=
	DzxoihGl1rdxZWE7EVcqvrGvqyroPvPp3DlkRIhPIdhiqJQUYXYHWW6LXqKot3ZN
	ZUfVt+Sql3qEKsyumCLF+P63AbWl3oog5KeqUDQDFfu3jkxsc7EbHJZoDWLM+Ls7
	ByfSxmyAP+BVDvcqsiFUjvd00zQypoobg0UJRQYjzP7nQP3jzRG1TW+91JpnLYrA
	0VQPsLo+7j+B7qdPQ9kQ90p/CwcFfV0iNDoFvm7KJ1KiBxCNy+9yeX+TSYYbKAe2
	DWfHRWzQK8ojmEjy/gKU8krLnT6LmxvNoewCPhE/Gb3jBUHkUAJ9PFsJMKNau71Q
	HaTOh7bPKHgjfbNu2VJEPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751921977; x=
	1752008377; bh=5T9a0xsjKRKN3LyyF3gfzYmFLOf+ugLVoUDTmhQgd64=; b=n
	JXejVGmXCYYeDbSyXjdlb+fF1CsDSDIR/5rAOsXW81qWuWYfF6Qrc6OzKUlMlkgk
	CW3vZjxRnsy6EtV0OCrWrhNo/CMswtcCq6pdI4MQ1iMhuhSZyDRYlgevdveMLmlc
	jyoXUxUIBKucGoMJFmwXSm5opPYpgOjfiqT69Xbq4k1kX2QnaAcsUAhbdAPU3sep
	WCw6/9vp/Vutxki2rP1Sqx8WjT75kzAYpdO9196AHW8OQ+mgX1RBQR77XK59YbWw
	QDRlY8Q7CsOOUDjBSRZlhVhOd8Pl7omjgs/+DAQ/RIGHBS0AJjhLYlfWcW1W6z3c
	sYvuWHKqQJfJlSbBgOEbA==
X-ME-Sender: <xms:OTVsaF_KnQ1AolYTuK5qJ63XGokB8mbXTc95Yf6PXmN0ZoZdg25AJw>
    <xme:OTVsaFMXpyQOZEwo91HOkfWS75W2RWGDvEHphaTYCmPerxuqQ5pr9_pbdbs2FDd4V
    0PqQT7wqIMX8JWODg>
X-ME-Received: <xmr:OTVsaJeqProqnRRNbWI-TcbWMr-EYp4PEeE0lAX4PZslBlKxC63hNsWDJgJbn5m3z3nBNm6O8wlV4OJCkJhUFMrvh9qoTkn_2yNmKHk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefvdekvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprh
    gtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:OTVsaEUJPAQdK0qiDMqeCL4GIIdZHwrbqE8oaO9cLUd9QEz13F236A>
    <xmx:OTVsaBhKfCNP0go8GVq2qL9n9wYAtsvgJDleFm4wHSzVO-nENVxo8Q>
    <xmx:OTVsaD9k1jpkpkXx6IPBzB6GJ2A9TXP4n_-K2v0h3-lyVlk5SK-rtQ>
    <xmx:OTVsaDaK3q7A8nLhLO4VapAOffP80lx1HZ8nGqgFm3pLsF6xHfvOxA>
    <xmx:OTVsaMrE1UBhuuOGl5fFGC9X6butJx3ArUsytuglAHcc1NRUSelElED6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Jul 2025 16:59:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH v3 0/9] doc: convert git log man page to new synopsis
 format
In-Reply-To: <pull.1933.v3.git.1751914412.gitgitgadget@gmail.com>
 (=?utf-8?Q?=22Jean-No=C3=ABl?=
	Avila via GitGitGadget"'s message of "Mon, 07 Jul 2025 18:53:23
	+0000")
References: <pull.1933.v2.git.1751203241.gitgitgadget@gmail.com>
	<pull.1933.v3.git.1751914412.gitgitgadget@gmail.com>
Date: Mon, 07 Jul 2025 13:59:35 -0700
Message-ID: <xmqqzfdf3efc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Jean-Noël Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This series converts the man page of git log to the synopsis format style.
> Git log is the second largest manpage after git config, which makes the
> changes quite large.
>
> A special note about the log format description which required escaping the
> synopsis processing of parentheses.
>
> Changes since V1:
>
>  * rework the grammar style when refering to plural placeholders . The text
>    is more descriptive and does not rely on puns. Puns may be difficult to
>    understand and to translate.
>  * change commit message to reflect the conversion of inline description of
>    several option to a list.

Changes since v2 is a minor but necessary mark-up fix, as we do not
want to leave `enclosing` mark-up elements unclosed.

Will queue.  Shall we mark the topic for 'next' now?

Thanks.
