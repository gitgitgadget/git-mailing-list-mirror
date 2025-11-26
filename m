Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DCE26E6E1
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 17:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764178534; cv=none; b=tf74Gosmx5iRGGRqz4wILUBZhzIgaT7E9mzcejgkpntCyDxlDiLRCjRC+bxkGaEIEqcHIOM8O2YBTKMcfm9WwocqzZnvxVovpAT+jJ7ucAn8KVqjyZqjpLt5+Ghh0g73gR/GNxDZlWCSiE4HWwjBvtTjW1n+ZS9YG2xXg78i9bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764178534; c=relaxed/simple;
	bh=QxVmtNHIQaE4YrUor5q4b+uN++NFh0eGPQZqQQXeeqY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uC6fxefDWF1trof2QGSJsgZh/LbiFjD3KscjVQVvhsFCIQSlVHzTpQ/OwDjPr/eDtR4I0QHFkegdMaJDR+XnFMtOBPXpY8L4gkyH5QuBLhAh6tn/felQfqD/aCxfMyD50BIYiduYhv+jkHIWfwDwmPcVAhIz+v1/fFeDerpSDcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cWaRe3cg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GuINtaP1; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cWaRe3cg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GuINtaP1"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 93105EC0473;
	Wed, 26 Nov 2025 12:35:31 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 26 Nov 2025 12:35:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1764178531; x=1764264931; bh=linGGUB6xi
	gMs4SoI7wEdaSamCT5XRvXDgEdKZcCbVU=; b=cWaRe3cgqU0rvxCuNXAq7mL1Jk
	+/3Oi38ZiBNHecE9YId4PH/htDqc85EcUc44lZC8TEz0+SyY9LrMgOW1i1mCpQs8
	Ef7JNkm2XHCc8f6z8BLlmYail5ZarrY/QMCaPQhcVg1r97N8gyvSUoR6o234fjnX
	lE6HOdQ3M6ZiigchcDgitR76cc+Ui4a4/QACwkdBoFksgvJ3ci3Zz1cK/E7cLM8X
	pA7A+Zwb+S0V4BpqtvtycyvFlrWwhKCCE1Xc/Bbyn/zgTAR8p7IxaTW7R9PKWNgz
	E1fI14mK4ekdyWaU2Uy5uRvqYk8iLINoLsFQmk5z1pL+uydrXtN9hxbnA0XQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1764178531; x=1764264931; bh=linGGUB6xigMs4SoI7wEdaSamCT5XRvXDgE
	dKZcCbVU=; b=GuINtaP1LAUGAYxZvQU5PlBlpJO8wlR6jRaeG1L9sM0dC0z5PQP
	7cF1P/uSixB3VZDAdb961Yh8CZtTViFXD582XGKPPPD+QtaKfjPZxkWrDqiZV8m+
	mkk9t5JqzhK9wME3DZtEXAhkcIbi7TeKfKoHPrOSD3SMevzeJ9SX2IBLjoz5amZI
	E7Z/SBXO8M/kc7uGPb5iGbOWNYtECUsA1Z3jFcBiTi4gDfXgNzZRjC6M8j1Ft4Pg
	Zsfj1c3KgyHoHcHOgLx9aoD4/2TPv1/AmcVZBxXqy11+GkKPDk08QslHBEGxeK2+
	ywwmsmH7bqLo/zxm8EPomzv5ciwuX3ys7qw==
X-ME-Sender: <xms:YzonaTJGN20pPH2gT7mNeA0MxN_XxSyB4sCUlwF5jHAWqbBeJ-PrlQ>
    <xme:YzonaenGg-3PGh-XZGytwhkc5vO1RZg553NmB9oKGBlK6JshnA33V8QO_oNVgyrv2
    2q6v4TKmIERD8ew2NSjIQc5xJon6QQsO_krIeY098ZQu9tvHVYoZQ>
X-ME-Received: <xmr:YzonaZEPGyecsf_8zr1e3zsHkhoGtsJK76S5jH-Zvcnp_AbJ-FDh-ABxLyK0GtTezLBaVTkTcLmb1bleJh6h8oxi105vjcPvBgib>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeegleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeekkeehuedtvdelieehtdelteehle
    efueetveehvdffleefvefgkeehueeileeiheenucffohhmrghinhepghhithhhuhgsrdgt
    ohhmpdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjiehtsehkuggsghdroh
    hrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:YzonaWFq-PYRyM1YvILRuiLbgnxPK77OmPMRtUhQxlk3dbou4RhG8g>
    <xmx:YzonaePsJfELgPqeQWnCTl2xAb7MI-QUkTOSTcjXMg54zwf6WEKfMQ>
    <xmx:YzonadFPzwX2a6lb0hY05w7SqgeedWR9uBHQPG3Pi-auQqFe-HUfgg>
    <xmx:YzonadPLefvHC50dTQyj4msPQpwfZ0y6SSMSaF1yrdwDL-HPnS4jHw>
    <xmx:YzonadwrNTKPNJz8WdvEPL_j51kYZuk0vh2XPsCz9hjRM_Hi5_vu6wK->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Nov 2025 12:35:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: [GIT PULL] gitk: restore window position, external diff of
 renamed files
In-Reply-To: <a3e24a03-55c8-4c1e-8c19-e800f5a128b4@kdbg.org> (Johannes Sixt's
	message of "Wed, 26 Nov 2025 16:38:35 +0100")
References: <a3e24a03-55c8-4c1e-8c19-e800f5a128b4@kdbg.org>
Date: Wed, 26 Nov 2025 09:35:29 -0800
Message-ID: <xmqqcy54ofxa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> The following changes since commit c435c515dad872532705d45d9ff81d3f4af22d6d:
>
>   Merge branch 'ml/themes' (2025-10-05 13:09:49 +0200)
>
> are available in the Git repository at:
>
>   https://github.com/j6t/gitk.git master
>
> for you to fetch changes up to 776223c4d8482a29585266e189ea8f1933ac9652:
>
>   Merge branch 'tb/external-diff-renamed' (2025-11-26 16:04:14 +0100)
>
>
> The commit that reinstates that the main window position is saved across
> sessions is controversial and needs testing. In b9bee11526ec (gitk: Only
> restore window size from ~/.gitk, not position, 2008-03-10) [1] it was
> argued that restoring the main window position is inconvenient. With the
> reversal of that patch I have now implemented my preference (to restore
> the position) with the purpose to solicit feedback whether it is still
> inconvenient. We can revert the patch again or find a better solution if
> needed.
>
> [1] https://lore.kernel.org/git/20080223113759.12854.qmail@6a8737aa4695b2.315fe32.mid.smarden.org/
>
> ----------------------------------------------------------------
> Johannes Sixt (6):
>       Revert "gitk: Only restore window size from ~/.gitk, not position"
>       gitk: persist position and size of the Tags and Heads window
>       gitk: fix a 'continue' statement outside a loop to 'return'
>       gitk: show unescaped file names on 'rename' and 'copy' lines
>       Merge branch 'js/persist-ref-window-geometry'
>       Merge branch 'tb/external-diff-renamed'
>
> Tobias Boesch (1):
>       gitk: add external diff file rename detection
>
>  gitk | 87 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 69 insertions(+), 18 deletions(-)

Thanks, pulled.
