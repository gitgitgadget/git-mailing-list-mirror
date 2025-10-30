Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470AA27A907
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 17:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761843896; cv=none; b=AWA8+syGVgy8KoK7/STE6IIVVpA4E10LC+ZmSDqmUyAXTpcZNJiA9hDwT7z6J65HtzXa12iBvHo0XPzmfFPtBxE4quoBYTGsk9i2bQJs2avFZGqBEDU+w7zZaH4CCBo7vKHPBsRXgb7vrpgrK07ayZeEPOTkZsbFbfhvsbEUm2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761843896; c=relaxed/simple;
	bh=Bj74tjQTGs4rZBXwyMdZIif71ndFt3BzU6LGjmsvu7c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Mv6TWU8r0KpboVCrlj0UXa2pZ9WJt8TYUwUky2170H3qz1mwS72UTF6Gc/V5R5bFAG5QF5ThL2kvTvzxi4iAjXOzhTHAv8cf3bPVD2+vF03E0XO+6uo5mHHRxEZs2gHC8THcBxLTioh0gAGnpjJSn1/LCKArAXr3sdSXmF67Vq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=P44RzBgR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hl/1mkHX; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="P44RzBgR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hl/1mkHX"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 3F459EC021E;
	Thu, 30 Oct 2025 13:04:53 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 30 Oct 2025 13:04:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761843893; x=1761930293; bh=Bj74tjQTGs
	4rZBXwyMdZIif71ndFt3BzU6LGjmsvu7c=; b=P44RzBgRBEGY/QUiU6t/CZiboe
	WKeEsKeXjBfhHM/PryFypH+puEx7TvPTKUeQYCXpDiY0qfOKmhc8afjMeS6SdvHv
	fQ/L1n2YVwWR2+sf0ToImCWE8YOxy99Btg1HlgE6kKdwleKx2J0r4/nQSAki/yOQ
	/yqjCR7GW2YMP0qw7VMThH8m36T5mVKW0hHVngM9EDwzPu/K3hv53XE3NUxr30/A
	0qYqRMujg/vGEMKEML7FhmRtxh27uBgSg5topiK/X1zT7NKFA2F6OGZmZdwh7LKO
	tOen/SmgeUfLlrRLge6YOk53a6/lW5/aMg0/2268BI5kkL23CtXGaM/AQKrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761843893; x=1761930293; bh=Bj74tjQTGs4rZBXwyMdZIif71ndFt3BzU6L
	Gjmsvu7c=; b=Hl/1mkHXdsZQVS1Z+F/li1WVA5vDRefkrK7eecyx2VfHcIYw1L9
	TNoOaJA6Bi5b5235EVw/BGpou75UNG0c1ry0eY16yZGTVYsX3RV+QfOucmFtu4d/
	5WlDuCWC8vM8vBl1Rz4O2t2i+ohhjKckkRYSE+sj1g8PvLSN8i3wfSR7i39S/rP9
	caUdOiiywopg6u68hFtV9pz0llCq2gQFzZPIXZ+yYmRqgVPtah7jpBeaIaajNa9H
	c2tbyJUq9Ml4p2Ns8UyHM4lZb/YQzWeq7plyeQatxL5FbX/8jp7Mr78+c5sM4PIh
	0VmmXQwHXlBlkx/+QoQw/OcmNEDvNUqIJNw==
X-ME-Sender: <xms:tJoDabbmkXFhmV1S4kCt763z_sCr-O1mEK_XWQf1r5yviMMsfs3LRA>
    <xme:tJoDaRaAXVf2K_Rl4bWDjlUSRhRdqMjxdIfXEpbc786-vCZ2ZrNlkx_nT_NID1xsw
    yuYKet3iIXKOg2SBK1OyTwLxjO27nhbt7Onv_OCR9XfM9UqGNy8EZ4>
X-ME-Received: <xmr:tJoDaS9bFcptQLLr3glWjceJ7t1IkTr_U0zfHwlJO9krOJ5ZXLfIX_7o7JqrvWDxnWmMKpihQst1o9jsl3VCmSujmV8DagZA9KPj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieejudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesgh
    hmgidruggvpdhrtghpthhtohepuggvvhhsthgvmhgrihhlsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:tZoDaQgbeOWx9DqTdat2fktSV3M0PaskGu-IUo8Gp9u7x0nqO8jUbw>
    <xmx:tZoDaSfoDSVNDPvuxUYz7GwmSzL6qokzEpR53wifGIQgdu9OLaR8IA>
    <xmx:tZoDaXowCWpPFQZh2uLyj1W4Ofs7dz8aq55-Bd9NVNTOdX7k84yF0w>
    <xmx:tZoDaXBT2mv3HSxet3tUs-If2UnBa2S6nbe814MabrE06gSaKdO5lw>
    <xmx:tZoDaYUkfyM6WivJ2MuD9bRDyB_poLi0Mdjvb5z4HnvhERG1tKLVD1Xi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 13:04:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Devste Devste <devstemail@gmail.com>,  git@vger.kernel.org
Subject: Re: git clean deletes negated pathspec if directory causing data loss
In-Reply-To: <a77f4e6f-86a3-ea15-feb5-4d08636ffd94@gmx.de> (Johannes
	Schindelin's message of "Thu, 30 Oct 2025 09:49:41 +0100 (CET)")
References: <CANM0SV0R7OYJKeBAs5-WY2Wqp7VxhKv5=LQ4cuDd6MaQwNqGNw@mail.gmail.com>
	<CANM0SV3iRF=jVAFj=+rrgOC_nXEJ=_v1bUG88n3T9+PQD=a2-A@mail.gmail.com>
	<CANM0SV3qgqjWeAu+NvfPxeDLgo6-eRWKmi9xkpUtN6w7LJh7oQ@mail.gmail.com>
	<a77f4e6f-86a3-ea15-feb5-4d08636ffd94@gmx.de>
Date: Thu, 30 Oct 2025 10:04:51 -0700
Message-ID: <xmqqms585nik.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> In case the Git maintainer (whose call it is, ultimately, on which side to
> land regarding above-mentioned options) sides with your interpretation,
> here is a patch to add a regression test demonstrating your use case:

Thanks for an opinion.

As "git clean -X" is not really "my thing", not in the sense that I
did not write it (I didn't, except for code clean-ups) but in the
sense that I see no good use case for the option and I rarely use it
myself, as long as its behaviour can be "explained", like you just
did, I do not have preference myself, and no strong motivation to
advocate changing it, risking potential disruption on existing
users.
