Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F16EEB3
	for <git@vger.kernel.org>; Thu,  1 Jan 2026 22:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767308099; cv=none; b=GLy8wbsvOCz8YnmudzMyVJ4Gn8qqpSfchuqukfgiUIgW6OCS695WjEBxp/QpkYR0YGdnrUVkhBt4luOAF15ERzMT8SILUzCZ3aW0C8bfgLaFShQOydBGsMn1rOyvRNiRsQ1h+mT1hzj3tOXOOuyJIBKADUOnhSLF5fFvsZ2FNYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767308099; c=relaxed/simple;
	bh=xdVs75knIcK3e6T98hyTFo+AS2jmwjpEmr7E4lP/Awg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e1YUBJZ2T2bMMxJPB9COeQ0ohx5bCPeVpHNSrldL7hoMNjrhXfnyGj7ZiaJ78jNtefRrMpOSmYtzb/QvLcN0cIYuq6Hx0kYQFWzydSoU6QJe9HI3GtRjh5i8XyAwhBft+vT+AD/KHpwXlQZPfYQaVSPk8spRzQhI92o1eOEdWnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OFA6TcMM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hHeAgJ4V; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OFA6TcMM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hHeAgJ4V"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 711FE14000E9;
	Thu,  1 Jan 2026 17:54:56 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 01 Jan 2026 17:54:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1767308096; x=1767394496; bh=Sx5g3b+PMX
	+0NqcHw4HCMD+7NI+x264qQyyTqPBRRo4=; b=OFA6TcMMkWg3KwYpJhxga3obMq
	3pUyqNgcHsIUPmFhYOCQytZCHQ4BW2orUiBAsB4AZnWo4jsi74VB1qYENaTQTEmv
	Yi6tMfWWeL88qplsW8cG8sKDLKqWX1m8e8am2/FJE/9OcLaMt2aRE/CVOlZERCUJ
	l0cpCuLrMPQpsFeNGsv9TtCy60zuyuSnoYwWAy4J+GWx0t/J/XiMkPIomGJmy9mS
	CyIl86XZc0TkD7jrj+tXuDC1JSddIa1vnoIRhcGYVrqOgK+GQUexyVXdOnXTZ8FQ
	LJjCwa5YAd3koObjjkTGxS0+d2SkuXVtRty+WYXhGUA2aZe2UPIi/fAoTYWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767308096; x=1767394496; bh=Sx5g3b+PMX+0NqcHw4HCMD+7NI+x264qQyy
	TqPBRRo4=; b=hHeAgJ4VrdIB/YF+3CcIyqxMz3Ts4XV5lA6mfSX9s5m2lsAXfs5
	zaHfTLbp0Tx0P0fDTHzpklUGB3Nup9AtX1s92aNFQy11biM5F+pZt7hvau6JRu/y
	h/RcO10/ym2QEkpjZj5hMFCbHfvlMYXQk6vuzGvMXaTRN8qi6zNuIErzzDbMBR2F
	YMIQ/NGn4E6/6uFEVcJX7vdK9UbpKC/8jxAjRm/jP1+nV3cnFHVdFfGK2iOzaNG8
	Qzczi632PY7xiovdwoej9SqeA7VVTODwZglFdsmseJk4HQ8cAkB4TtPvMgc95Iaq
	91lzhlQ+okg+5RU9aWP22FMkqk5/EjBZwLw==
X-ME-Sender: <xms:QPtWaTBro8HSyfX-Bp_ruHCGosEbEB7LCnmXslGZ6o-g47U6iKEq8Q>
    <xme:QPtWaQaqTtDcYFKlMwDEuAU4ifytdWGm8REVwVKmHkhgF43caJdZs8n5Pqr1xLRz_
    2cq2-bxc8wabccQmlfRTGcqmqPyN8OmU1JPEZTSHcFXNXWVEg2JMA>
X-ME-Received: <xmr:QPtWaW5b2vLtI09SlKMaR0nhhp0eNtIRYCQdP00cWgLSTnc9FtcZtgJUcZHjzuhDkqtEqHC53hgM4znC8SmB74zrkl9PdZu6rA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekjedtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegrsghrrghhrghmrgguvghkuhhnlhgvhedtsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguud
    dvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:QPtWaRbsJsgFeVp9MTBPa2qBd-kI74Q8Tm6iIT3miCMpTQsyDBcE9w>
    <xmx:QPtWaVgGDB4TRcOMynQPt16vJ9x6UGR9PEmrNGKLPcrJ1jc81_AyjA>
    <xmx:QPtWaS8d7sU2F2xZ9m1aUphSRuCh81XOxKiqbANyBbr6NmoAFozPgQ>
    <xmx:QPtWaQrvJzT3TqYAmpqSpufRkRipIQZrgaH7IkubW4vlumPqjUdrBA>
    <xmx:QPtWacoFx7qhvGrJy8h7Dn-sT688ghdR_77sQChp7PM7p5OJdANNnqKA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Jan 2026 17:54:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [GSoC PATCH v2] add -p: show user's hunk decision when
 selecting hunks
In-Reply-To: <aVbgkySezz8YV6sN@Adekunles-MacBook-Air.local> (Abraham Samuel
	Adekunle's message of "Thu, 1 Jan 2026 22:04:08 +0100")
References: <aVbgkySezz8YV6sN@Adekunles-MacBook-Air.local>
Date: Fri, 02 Jan 2026 07:54:54 +0900
Message-ID: <xmqqpl7tc5a9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Abraham Samuel Adekunle <abrahamadekunle50@gmail.com> writes:

> When a user is interactively deciding which hunks to use or skip for
> staging, unstaging, stashing etc, there is no way to know the
> decision previously chosen for a hunk when navigating through the
> previous and next hunks using K/J respectively.
>
> Improve the UI to explicitly show if a user has previously decided to
> use a hunk (by pressing 'y') or skip the hunk (by pressing 'n').
> This will improve clarity when and aid the navigation process for the
> user.
>
> Reported-by: Reported-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
> ---
> Changes in v2:
> --------------
> - Modified subject to indicate GSoC participation and user's hunk decision.
> - Modified the code to detect the user's decision for each front-end set
>   that uses the interactive patch machinery
> - Changes the decision phrase to 'previous decision: _decision_' from
>   'Selected/Deselected'
> - Placed the decision phrase before the [choices] instead of after the [choices].
>  add-patch.c | 84 ++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 47 insertions(+), 37 deletions(-)

Doesn't this break t3701?
