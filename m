Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A00321D5B0
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 16:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772210984; cv=none; b=uAX333AiEaoTYyrsFSXy4gd2S+8+qaiqgZtN7X2TT9lINg6tGjnIZlOuPGVV6NHucPXYWcfoPpRQ5cV/SEeSTOOt8DGfTpaMKY9amPht8cCXGxgynw3ozL39dqzZAo0suMgD+3+gt/g6LqHYFq2N4Ya96CuvvWJUgZjE4+0fNPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772210984; c=relaxed/simple;
	bh=PMigL+RYhDLoTC2+6cAQzIetqCOHQDYS3Z5Xx9sTvIg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sArgZlIKvqHSdXaDtt13dKIVJFFY8PV+TzGtVwpOwMO5z4o3HlISR92c29RZ9eFVAfiF3pQPM3ZmE2Sr3yvcV3Rse7U0NGIftg01dIXDQDwenu82+IpcBK6kbixhabiWMGei/N/7A3hauMKUsllaQnfOkd7Rqic4VTD7CmMvnlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jxXy/AcK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z084da6q; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jxXy/AcK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z084da6q"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 66ABE14000F2;
	Fri, 27 Feb 2026 11:49:42 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 27 Feb 2026 11:49:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772210982; x=1772297382; bh=zBDU8Um+OO
	ZPaf1JFGSSpXubIsylf9rGcUp1OVfZpNw=; b=jxXy/AcKd7d01oTcd9SeHlgvqX
	dptRUg/8IqTRCcvZ2A4yKt6AwDLYsrgHj7U4srHz0hdoKPiJmY1fpui0jIWMdoav
	z1VRcIRvt92X7/T61ssAUjJvyMXmkmksMsN14amCQTO85Xwi7/2i2v5bScX/E/OE
	bCaLeqzZQBe3u3t1sGZbNRhHcT6t+17KikcYBN7E9MoJpvTEbiYrrvWt1oBJhCGA
	3il46/9pHQBPF1K3/4zUTStrcp21dYEtSh2qLWVwdw+Iy+SUvx0QKDd7dHmegYrw
	ti7nfl0OUw8WltEGaoaB6mHcMyOJAMPsm9q+YF8ps7NgMrPzdXhNSSi9xo5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772210982; x=1772297382; bh=zBDU8Um+OOZPaf1JFGSSpXubIsylf9rGcUp
	1OVfZpNw=; b=Z084da6qOMvUse+ixwf9dwzl5M0s27vkxppav/W4Wm8Zahltk15
	1Ot3ppmZ3kMSDJ/KMVKUBOARQTbcRjkT6lAKRE0M6RDNBcXljCtHunWr4wUS8nif
	kZmx9be1BQ/+0SyhcSxj2JJWHtVS4iV0fmMUUDGtve0Zq5ytEGtLvb1tKQuYiHyT
	+nLjhfDlg2wWEarl/dRQ9NGoDhAUVAkeZflqs/cFf6eEErvyxzyJrOW4lCeKq4AN
	a4qLNqNcTWww/G76mn0XEE7vJX1brN9A9v2uOLJh9QoLHCpx6uRvyEz4gKiZ2Z4C
	8x1bgCVeQyNHWbUw60k5ntqV/BMIQN9iJcQ==
X-ME-Sender: <xms:JcuhabFoANs56i-5Ow1MbFLCUDcCnYpY8xD31-UXF8Xu8-NZfc8C8A>
    <xme:JcuhacDa2JW8gGYMiRVzVQOzr6NXrmBWqGLyZwYMFl8on9KBDHfA6qcRy4U043s9S
    08cGcNxZMwlucnEOS736ZIT8AWcnxS1t7t1iU8CwR5yA4mh6keciA>
X-ME-Received: <xmr:JcuhaW_-oBMC-W7WmcRgU4LM4kHVs4iJ6434GzhzcEXgf_bejfEifZpsgzDBfIEfXX7h-rjwN2ib0M_O1n_MaZ6LU2niVDlmug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeelhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjie
    htsehkuggsghdrohhrghdprhgtphhtthhopeifrghnghiiihgthhhonhhgseguvggvphhi
    nhdrohhrghdprhgtphhtthhopehgihhtsegslhhumhhirgdrnhgvthdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhgihhtghgr
    ughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:JcuhaQB_ZbQh_ACtbIJ2hrfA0aeTklChVVCdpQwEoDOesXm5BDLw9A>
    <xmx:JsuhaTTixnkqPeIGff879XjI6TcVV08t-VXIy1md5xpJ6BciH_L3PQ>
    <xmx:JsuhafsmCbiXx4mfFBJWY2HtunnOdfWfu8XrEkoJm_itrNtzXPi7kA>
    <xmx:JsuhaX2RVzzPlAeP2SaN02eevfoRRd3f37ZStjop984gJTQJy4oCaw>
    <xmx:JsuhaRqIjm84cdkRNF2Vxa0bQtTtVFFpoAOaRtAWWGD5wjsd-186mZrc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Feb 2026 11:49:41 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Wang Zichong <wangzichong@deepin.org>,  Gary Wang <git@blumia.net>,
  git@vger.kernel.org,  Gary Wang via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH] gitk: support config the color of linkfgcolor via Gitk
 Preferences
In-Reply-To: <ffd58cd5-811b-4ebf-8572-cca681ec9bf7@kdbg.org> (Johannes Sixt's
	message of "Fri, 27 Feb 2026 08:37:20 +0100")
References: <pull.2217.git.git.1772109195114.gitgitgadget@gmail.com>
	<ffd58cd5-811b-4ebf-8572-cca681ec9bf7@kdbg.org>
Date: Fri, 27 Feb 2026 08:49:40 -0800
Message-ID: <xmqq8qcet9ln.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> Am 26.02.26 um 13:33 schrieb Gary Wang via GitGitGadget:
>> From: Wang Zichong <wangzichong@deepin.org>
>> 
>> As a dark-theme user, I use the Preferences dialog to set colors
>> for gitk, the only color I cannot change via that dialog is the
>> link foreground color, which will lead me to use the default link
>> color on a dark background that make it not really readable.
>> 
>> This patch makes the link foreground color also configurable in the
>> Gitk Preferences dialog's Color tab, so user won't need to dig into
>> the code/manual to know if the link color is configurable and can
>> simply set the color there.
>
> Makes sense.
>
> Our usual style is to not say "This patch does X to...", but to write in
> imperative mood "Do X to...".

A bit of tangent, but I wonder if it would help new comers if we add
what I sometimes send (e.g., a recent one found in

    https://lore.kernel.org/git/xmqq343ehu4o.fsf@gitster.g/

) somewhere more prominent, like MyFirstContribution?

>> CC: Mark Levedahl <mlevedahl@gmail.com>, Paul Mackerras <paulus@samba.org>

It is unusual to see multiple people listed on a single Cc: trailer.

>> Signed-off-by: Wang Zichong <wangzichong@deepin.org>
>> ---
>>     gitk: support config the color of linkfgcolor via Gitk Preferences
>
> In the subject line, perhaps:
>
>    gitk: support link color in the Preferences dialog
>
>> +    label $page.linkfg -padx 40 -relief sunk -background $linkfgcolor
>> +    ttk::button $page.linkfgbut -text [mc "Link color"] \
>> +        -command [list choosecolor linkfgcolor {} $page [mc "link color"]]
>
> This text "link color" is used in the title of the color selection
> dialog. It then reads awkwardly "Gitk: choose color for link color".
> Let's just use the text "links" for this purpose, and then also just
> "Links" as the label on the button.
>
>> @@ -11891,6 +11896,7 @@ proc prefspage_set_colorswatches {page} {
>>      $page.hunksep configure -background [lindex $diffcolors 2]
>>      $page.markbgsep configure -background $markbgcolor
>>      $page.selbgsep configure -background $selectbgcolor
>> +    $page.linkfg configure -background $linkfgcolor
>
> The variable's value is already serialized in the configuration and
> needs no additional treatment. Good.
>
> -- Hannes
