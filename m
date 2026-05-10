Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4853F13B58A
	for <git@vger.kernel.org>; Sun, 10 May 2026 23:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778455830; cv=none; b=sqr+Cc9Q2yh2AlrgN5BxP5hDaXGI8n7L3cw4PnKnBxoX67YapSBPhL/TouEslRYXmNOG59G9yvuALbmhF+VP2364OBIvRbozMb3mBHvcJtrXM2oIEbUwCnXCBaLcXBnOx09BYDDnPmnJPssAH0pJkW/AQCsl/Y3f3YEoxjW2jCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778455830; c=relaxed/simple;
	bh=ijuRldfPF7xqZBc6xh11m4RIQ37e759cTKLJrahbuDk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TZ414IJOl2RkElpGho38/IDMKUQDEaie7gehmgG3nV2bRoG39LCPNIeUznWzRtJrFyOanX/TG/sOC1KBwTF6YZvpbZcs0zhIc1dr/J8ztH9ognJuUQOzuCjcaAM3/FA3+Smdl+edO+7pelKMssKDMfQ60uVfU+pq5OLKY9xZA44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UKTFqZRK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W3MDSm5o; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UKTFqZRK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W3MDSm5o"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7DDA914000E8;
	Sun, 10 May 2026 19:30:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Sun, 10 May 2026 19:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1778455828;
	 x=1778542228; bh=+LYy8FfF29Sl6aAl1p19x6uUyS3LBZz9SadaeDC8W1U=; b=
	UKTFqZRKE86stfyq6vRATryhldg4IPE0sCEhXgbVBqSqK9vknouRLLF417sr5cWy
	ItJDFGLjulODcYB1V5lisfiACZPtwd7c5apWkmKTMHiBBBvl5Xmbtep4l0Azcp/Y
	//8KH2A3oRDomUwHE31ynP1VWZWD11nwJ9IC5GiL40r4toYOT4kt/S6f+Na5YiC7
	fouYf35utHrqw37GNR8Jkfok+U4MCkEv58opsHx68bBveB6bAEnD+QXO4C0jFgK9
	hJlss7UMrfLfoLYxcMrHPAOMV3fhzUQtggD0Idw1CgG8EEYftErTw8ucvQ+LplUG
	NN4svrcjKWPRJ9r8rfQyrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778455828; x=
	1778542228; bh=+LYy8FfF29Sl6aAl1p19x6uUyS3LBZz9SadaeDC8W1U=; b=W
	3MDSm5oMA0V3N2E9msFrncP7ioDD//7eg3nc9GV6cZ24Onk0DHNGwfyifvj6+VoY
	nNlj4fxwH/UqaALNFqUYbBJuMvpcWW83pfwHdVuTT9+pJ5zRJ70m6Yq39BC9g0Y5
	TTDW3FFSm8rTL5X1IPq6bqnzxQr7ib8smfUUDOWIfQLEUBxH+yYJCy2qJGNHv35h
	1rLvkvc5sYYN7gP4TGbAZyGP1yerhusw6UKqzmrUcGP2KrrRs8pL43GwkVnMOUv+
	AQ2V5xHVD14f3dIaliP1vwhpu2yYVzfVjoL23ES5f0mAgUt0jw75nXmrtwhx/5Yw
	mbIXGP2gIXkvGzSTUqV8Q==
X-ME-Sender: <xms:FBUBaoRzWiJ1YOOCHfLG9_sYWOWbNEo59AZE0esTbEvSCBQKQAiDSg>
    <xme:FBUBasqtKPUfRp_WLMcnIUBHslm8zhXNfek1CKY0j8ndtWsd9bVos1oIBeB9W1Y2h
    R1UJIihCX1ab9csTXYVE8WjnoTttlDGbnz-tFpwBA7YlVSJIp2blA>
X-ME-Received: <xmr:FBUBauINwPM-xcMogP2zfP2kcD7K5HM7ThQXC9wS2OwK_O4LDTi2Ym9y2sGNuc7t3LdWfhWqwGgshyYBQEMijwVE27QgLzha3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudejgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhope
    gthhhrihhsrdhtohhrvghksehgmhgrihhlrdgtohhmpdhrtghpthhtohephhhughhoseif
    hhihnhhothhhuhhgohdrnhhlpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:FBUBanofOKPO0mgeix1p29ok_IOpk1I-Qbe1GF-sZdOahBUs56qXaw>
    <xmx:FBUBauy_uvDoL9v-nDFLOzUentD2Z0AWvTUZVIJQsSBCsXoY9ur6Mw>
    <xmx:FBUBajMZfuGdIs48PQ2G_M0x8Yp7mcLA1rMuPm_p32HVCyb9yUWJtg>
    <xmx:FBUBar7UkRh2_CodshPVAx02b78GB1ndBJqXoBBRRf2fMy9XDidrtw>
    <xmx:FBUBatG2GERFtWIfr4GsIPfczxv3qcFz-dcIT2v017Ow8WYg5d916zza>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 May 2026 19:30:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Chris Torek <chris.torek@gmail.com>,  Hugo Osvaldo Barrera
 <hugo@whynothugo.nl>,  git@vger.kernel.org
Subject: Re: [PATCH] sideband: clear full line when printing remote messages
In-Reply-To: <9826dabf-c9a6-4397-8ae6-a24f9c507f1b@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Sun, 10 May 2026 14:42:04 +0200")
References: <2d3f5504-f5dd-4171-96e8-b5633b6a1f5e@app.fastmail.com>
	<CAPx1Gvf5Vts3oS2BdFQ4PpCR-UY=5cYW7fgOkRuQpi8ug2JXDg@mail.gmail.com>
	<9826dabf-c9a6-4397-8ae6-a24f9c507f1b@web.de>
Date: Mon, 11 May 2026 08:30:26 +0900
Message-ID: <xmqqzf26971p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> demultiplex_sideband() can write its remote output over active local
> progress lines.  That's why it has been using ANSI code Erase in Line on
> smart terminals to clear the remainder of lines it writes since
> ebe8fa738d (fix display overlap between remote and local progress,
> 2007-11-04).
>
> This erases the last character of remote lines that span the full width
> of the terminal, though, as the cursor is stuck at the rightmost column
> for them.  It's the same effect as in the following command, which
> clears the 1 and shows just the leading zeros:
>
>    $ EL="\033[K"
>    $ printf "%0${COLUMNS}d${EL}\n" 1
>
> If we move the ANSI code to the start we get to see the 1 as well:
>
>    $ printf "${EL}%0${COLUMNS}d\n" 1
>
> So do the same in demultiplex_sideband() and emit the ANSI code as a
> prefix instead of a suffix to show messages in full even if they happen
> to fill the whole width of a smart terminal.

Makes sense.  The final objective is to make sure that leftover
letters near the end of line printed by previous "print" would not
remain after the material we are printing, so it does not matter if
we print and then erase the remainder or we erase the whole line and
print.  And the latter is an obvious way to make it easier to reason
about in the presense of funkiness in the ways terminals behave
around the end of line.
