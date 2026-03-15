Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F515B5AB
	for <git@vger.kernel.org>; Sun, 15 Mar 2026 02:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773540523; cv=none; b=ZnExk5O4iq+ACvw2U5Vsiaft8oF3g6h/13iYGls+AI0Qke4j8PDaVQc7ONIJAjM6NxOlBE7Y4H54K/is6dzLd09SsDR4VVqJWSvBca6bPooCrL8MUQNtFixwVaWztCgM03j5zEiHNHtvU1aZKIdj6skMyfJOtmu7Y3e8go7znX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773540523; c=relaxed/simple;
	bh=zRjrxsw+fPeQpTgykR6a0pUdobbIaVc1ofGB4CHI30M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hfr2XFq9A2o6VtDJNCqVLvgWzMPFxrt/+QHK32EN+uBurpVAyEepWfqRj4yMoEiY8cEaWFxtRQX87wNfL/c9E0AEIjjh1VQagBqmG4wayAY4Z57BBqTE/nqgodBB1h66K8W4HeWVgblT60KQ4GYaBnd+xiIDY1jO1olib8rLGho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QkHJsIgx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PFggwSdP; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QkHJsIgx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PFggwSdP"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 5C00AEC0546;
	Sat, 14 Mar 2026 22:08:40 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sat, 14 Mar 2026 22:08:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773540520;
	 x=1773626920; bh=tvrJHgwXXkAGWTERfXMUNEpdXn0TkBc/zAv3u5MQzVk=; b=
	QkHJsIgxS49nUAmAHHcXZuFGHMQYe4ewPN5hGmy2MzuubRqswFMcjsmNI2xg3MHe
	FX4VcJ1kyYcimtrZoU2FimHCMjX2B9/1Gq8iaJFoAWmZiNRN+0Z5Fuz92onCSG1D
	b16KiF1ApkMs+wCmFjrXAOuLP8GEnA0Es9WY46wR2XNqi1OgHkCSAF2eZIdejXps
	TSbOX8nMQaAZU3j3MRXRKALenziZcoIsWfshXbG6yt8UCbgkXds3Lh3ahCl8UGYQ
	BplMH/7q3yYxdPijniHwL0sLCDq1TYH4oVfbGPKbEVxC03XxC8sXR1JGLuZ+vvVk
	DC5eTAMMsg1Gl3VvklhWUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773540520; x=
	1773626920; bh=tvrJHgwXXkAGWTERfXMUNEpdXn0TkBc/zAv3u5MQzVk=; b=P
	FggwSdPcHriQCtR/f0XlguHp+wzbpzXNL7IS+kPnekawEpimlklK27Z2suvxOG0z
	ODwp8FpuyTUxqa4OaNWOnwYtv7IzuvvzNKCtqNQpXdEtPqRE/QWZuou0SxerGhca
	5fgCZ1DQnMZ0VD7EgWX28HhKPx16MPzobNYU7FbPGYp8MgtUuL7uYz6oIhiVfHas
	xdfKKuZeM52cWMUF9a7k8tRJTsDBalRC3i2KPbGZISiJs6A5EN4+N2Qi+eiiUupm
	BbsJw97qoIQEEK9/sjfopXOOPhdzGdi32EFWbBvZeDYCsQ2nOL3IaHKPuyBqyRrl
	qENePCd6isFJfGm5Nb1Vg==
X-ME-Sender: <xms:qBS2aRhNw-WR93e1bB0f9VzR3Lx8XBHhgxEIaioufL-0gB2P2A2C-w>
    <xme:qBS2aRj2ndAEc7_orfcPST_ik8S_IhW1ecq7uACZ8NcdeSmT2vV-mwHCexYc3mXIh
    QPzMxtiCA6RUmMDP0Y1Rlu1pGMAKeC8sYP3FYPaNxgbXMtlu-obgw>
X-ME-Received: <xmr:qBS2aXiCHPIyB6yGnSxydKQh7T7HAAQaEboHT4ezw8YJRxzNuMr-dau7-fk275p3XJyE3fVHgldhzm3mhyfCWhFGFxGBhN1cvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleegvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hhrghrrghlughnohhrughgrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:qBS2aRIaET8WPW5i04bWSual8DntuDN_RdIDhbBMg_-7fCXab_JZdA>
    <xmx:qBS2aWGfSOBbNUSqzhc2do4FxoRSjEVgRhNEmsoc1FlF_ZTNTPfB0g>
    <xmx:qBS2aVRKwh_B2EdXn-ptImUxax3m2cuxETxYme5HiIx8OahNve7xSQ>
    <xmx:qBS2aSdfYmkLpnofTrhNwxXpbBZDXmhom0oVMQp78nlc6lefwEtqpQ>
    <xmx:qBS2aQjmq_s5t3M1fbNADejPo0P6OsvYB18lcez6B4O-i0B1GPYfurw7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Mar 2026 22:08:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH] remote: use plural-only message for diverged branch status
In-Reply-To: <ca6e021e-0301-496d-8bd1-b646487ccbf6@gmail.com> (Phillip Wood's
	message of "Sat, 14 Mar 2026 20:08:15 +0000")
References: <pull.2239.git.git.1773479526823.gitgitgadget@gmail.com>
	<xmqqqzpmwdyi.fsf@gitster.g> <xmqqtsuiuugy.fsf@gitster.g>
	<ca6e021e-0301-496d-8bd1-b646487ccbf6@gmail.com>
Date: Sat, 14 Mar 2026 19:08:38 -0700
Message-ID: <xmqqjyvdvo7t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Phillip Wood <phillip.wood123@gmail.com> writes:

> There can be more than one form of the plural string though. The gettext 
> manual has the following example of the Polish translation of "file" for 
> different numbers of files [1]
>
> 	1 plik
> 	2,3,4 pliki
> 	5-21 plików
> 	22-24 pliki
> 	25-31 plików
>
> ngettext() handles that correctly, translating a single string without 
> an associated count will not.

That is a very interesting example, and a valid reason to have me
retract the #leftoverbits that led to the patch being discussed.

But wouldn't that lead to an awkward conclusion, i.e., hits from
"git grep '[^Q]_("[^"]*%[id]' \*.c" are potential bugs that need to
be updated to use ngettext().

Of course, we need to exclude messages like "the error code %d was
returned" and "you have a bug on line %d", but there seem to be real
errors in randomly selected hits from the "git grep" output, e.g.,

add-patch.c:						 _("Split into %d hunks."),
archive-zip.c:		return error(_("path too long (%d chars, SHA1: %s): %s"),
builtin/checkout.c:	    die(_("'%s' matched multiple (%d) remote tracking branches"),
builtin/credential-store.c:		die_errno(_("unable to get credential storage lock in %d ms"), timeout_ms);
builtin/describe.c:				_("found %i tags; gave up search at %s\n"),
builtin/fsck.c:		fprintf_ln(stderr, _("Checking connectivity (%d objects)"), max);

You can notice that I started from 'a' and stopped very early in 'b'
;-).

Thanks.
