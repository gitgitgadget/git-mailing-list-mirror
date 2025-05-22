Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A415C2D8DA3
	for <git@vger.kernel.org>; Thu, 22 May 2025 23:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747956460; cv=none; b=RCM2xVABzeOaYec+zLATdkqwg8lW1RLmKU7ou0sqLec9G3Wix7wKfxieN600yqkB/9vDsbFVxFAeYthtjnhFuwiJeHLCuapsIhLy3/G7x21eYfWioiKfdb89QnuIFvgEeOhwqM3KQCJeMfi9p+nX3atkfUqMRyz2r7bxUr+m/Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747956460; c=relaxed/simple;
	bh=l3P3mSOPBlkdIqceRZGeeGsH4g1JBLwZaNJlDGyFl7k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NRaOMaPAs5b8QxLT+v0ugpwuRmvTJievamnsQfE6vlZ54E4w8g6mtQ0xgxRarJGbpkg24holwbvrbOhtbv5VRmrgIwnVUWFeOR0rHVyXPURwTaR4XiOJPVTHH9n6wiX7ehHo3AHDS7Fz/Ku1tserjedml7XCy+T22AIjv1amzWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=drhCeZ/6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f477844+; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="drhCeZ/6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f477844+"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 807C01140116;
	Thu, 22 May 2025 19:27:37 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 22 May 2025 19:27:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747956457; x=1748042857; bh=xqylww+oNO
	Iea24Rh0iXTI17iKnEzFCyR2M8deA4Hn4=; b=drhCeZ/6aTFAMlVdbpy710ixVi
	WH1iCSkvWYgMuKS/Jk2SvuMqT174C/rwTUgZgbJcsTnljrDEt4SErKUX+J0NrV4g
	IF8Vz6ACi/5lG5OGSgsAilksyPxkfAz6ok2vzZxQpvgPBKoWA15Vj8XPJZpjQr6b
	zLgEHFNvy3dkaKbxPbDcVUfa8XUasOWUvaA4/G0YIiHUcEWbmSMw6HxYC3QHtnSA
	KCjS3uRddR2JrHCGgXQ53xxKczRdblGyNBaHY0NImgDOqKwD5OOIBJ72JhLXV3s5
	FAJGAK1sxtPcbBapO9YSjDAs9bY4r2AYOzTSXZTMbgJbbwksaIH7n5nlvXsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747956457; x=1748042857; bh=xqylww+oNOIea24Rh0iXTI17iKnEzFCyR2M
	8deA4Hn4=; b=f477844+pK6nMCPUxCyPXtJ0ZGICWoknE4W/AIwqXxOlIF/Ebhu
	jMM/8SaL6u2ywZx1w01SxKQoIjZiTT8MnzLCV534NV1z4yn4m6WcV8OVxbXS/rRU
	VtuV6OPaPAw0y3z6EdLbl88+Vecg2/p7IBHzUIK5ki0iU1ebGMb8c/SPfbp/eVQE
	ecPw+5XuGbSByaMcro3i/hnvAbIImKFrG/g4GHtrBVabFVV3S2st6W9pvX/lB4Td
	Yx3DqpXQjPyuS1Q5n8FuBWOHiumPm8HO8RciMjqlgOPkIyojlZb5HqAX6yFG0t5D
	CNxOuWJNTItpbhAJK0EZUyyk1s3yYDIephQ==
X-ME-Sender: <xms:6LIvaOrh-mzlAt12hExSu1B0anSNuNv7ydHRsvZakegCNKWEBa4iHQ>
    <xme:6LIvaMqIeEXSOTon0WI93xqgKJMM_L8HZguXrU8CbZBqsnSPBNucH6pjvjUJPZedO
    HqNRdpsvMRuMc4QZw>
X-ME-Received: <xmr:6LIvaDMS0BwYtArcKnma2i_wfE80F4mxJgBFmw3RHtATvvaE0X8Xf60lyWIkOacBMgx0PuHr4U1RYGXRXrtcfykLFvKFHtQnYmEfb6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdejvdejucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceogh
    hithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeeh
    ueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosgho
    gidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepghgrrhhgrgguihhthigrtdeksehlihhvvgdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuh
    hnshhhihhnvggtohdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthiht
    ohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehjuhhlihgrnhesshifrghgvghmrg
    hkvghrshdrohhrghdprhgtphhtthhopeiiihihrghoseguihhsrhhoohhtrdhorhhgpdhr
    tghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:6bIvaN792HpWXbrtY9lSwyRFfMTxUN3M_vYtpor1-2lDBQVi2MFU3A>
    <xmx:6bIvaN5PZQsJhd3dAqQZ8PeYnmgpAoqOeFtaGDcNM9mplseyGfeqrg>
    <xmx:6bIvaNgRc4VIEeHl5Y7IOd9F1rhxFn7W8ymmJkL9lwuu2xhRAemyEA>
    <xmx:6bIvaH46xGnIugWE9IyvjUYfMoPlQKgk6BMbNzmN0L5je_lp3IH_HQ>
    <xmx:6bIvaFz9eSZ-hybja8941x-nLrU03VxjBflTej8jdrk9Xho2ei9To3f0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 May 2025 19:27:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  "brian m
 . carlson" <sandals@crustytoothpaste.net>,  Julian Swagemakers
 <julian@swagemakers.org>,  Zi Yao <ziyao@disroot.org>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v2 1/3] imap-send: fix bug causing cfg->folder being set
 to NULL
In-Reply-To: <PN3PR01MB9597488E63B9C1565EFD9631B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Thu, 22 May 2025 19:49:52 +0000")
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597EC279126820B74D2D6A5B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597488E63B9C1565EFD9631B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Thu, 22 May 2025 16:27:35 -0700
Message-ID: <xmqq7c281b14.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> Upon setting up imap-send config file, I encountered the very first bug.
> An error showing "no imap store specified" was being displayed on the
> terminal. Upon investigating further, in static int git_imap_config,
> cfg->folder was being incorrectly set to NULL in case imap.user, imap.pass,
> imap.tunnel and imap.authmethod were defined. Because of this, git imap-send
> was basically not usable at all. The bug seems to be there for quite a while,
> and has not yet been detected, likely due to better options like git send-email
> being available.
>
> Fixes: 6d1f198f34 (imap-send: fix leaking memory in `imap_server_conf`, 2024-06-07)

This project frowns upon this trailer.  One reason is that it may
later turn out that this does not fix ;-) And no, this is to suggest
using "attempts-to-fix" or anything of that sort.  Most other
trailers are declaration of facts.  "Fixes:" is not.

Also, in the long run, first-person experience of an author is not
all that interesting to "git log" readers.  "I did this, I saw that"
is something we try not to use too often.

Rather, flow it in the problem description, perhaps like

    6d1f198f (imap-send: fix leaking memory in `imap_server_conf`,
    2024-06-07) broken imap-send with mistaken copy-and-paste and
    cleared cfg->folder when it should have cleared other members in
    the structure the code is about to overwrite.  git-imap-send
    since Git 2.46.0 is unusable due to this bug.

or something to start the description.


> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> ---
>  imap-send.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/imap-send.c b/imap-send.c
> index 27dc033c7f..37f94a37e8 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -1316,16 +1316,16 @@ static int git_imap_config(const char *var, const char *val,
>  		FREE_AND_NULL(cfg->folder);
>  		return git_config_string(&cfg->folder, var, val);
>  	} else if (!strcmp("imap.user", var)) {
> -		FREE_AND_NULL(cfg->folder);
> +		FREE_AND_NULL(cfg->user);
>  		return git_config_string(&cfg->user, var, val);
>  	} else if (!strcmp("imap.pass", var)) {
> -		FREE_AND_NULL(cfg->folder);
> +		FREE_AND_NULL(cfg->pass);
>  		return git_config_string(&cfg->pass, var, val);
>  	} else if (!strcmp("imap.tunnel", var)) {
> -		FREE_AND_NULL(cfg->folder);
> +		FREE_AND_NULL(cfg->tunnel);
>  		return git_config_string(&cfg->tunnel, var, val);
>  	} else if (!strcmp("imap.authmethod", var)) {
> -		FREE_AND_NULL(cfg->folder);
> +		FREE_AND_NULL(cfg->auth_method);
>  		return git_config_string(&cfg->auth_method, var, val);
>  	} else if (!strcmp("imap.port", var)) {
>  		cfg->port = git_config_int(var, val, ctx->kvi);
