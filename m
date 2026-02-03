Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827FB288510
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 23:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770160512; cv=none; b=mAFO43GV9YVIuVPvBF1KBetjDYItRYfW52ohlc+zRlMIeIi25VcZ8zzlfJpSHIonhGbfibYMorJlZwc00p4jR+9w7NN6PpWX2MsbV3LUzwL7V9zvUEGWMY7UOUSSQnrnT2OSb/RSam2zvR0rrXx9cf9bjbxzwJmlk+3B03w2dmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770160512; c=relaxed/simple;
	bh=YnBWdy7DsnXx16/lPhW/m84SnFRU1VdqpNfWEbUpzZI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=mF8f8GoOziBxhZJ6FvN1AcCAeFHXiOWlsaLAsu2whibewElv8qN0QEqFp8+9ihOQyhy03Jyt5dmYO/pC3P0lQgDBKK6xLwZpP5eo1VceB7VA9smjkqhbv0eL5UHfikG3i1dtKQztiliSXXo25nFD/5tRcN3tLuQNoaxxNvFyYVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=HTQopGRG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LqfBVcmg; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="HTQopGRG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LqfBVcmg"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C5D7014000BD;
	Tue,  3 Feb 2026 18:15:09 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Tue, 03 Feb 2026 18:15:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770160509;
	 x=1770246909; bh=fPkzaj4GqukscFDmkpV2WEnqFMbeCDJOFF1zRlcBFBI=; b=
	HTQopGRGFCakbL/6e21NoL871MNe3uIxij7CrOv4TPKb5dsZqevY9sVc9kBqG/76
	EBeVYeY7UZ05Cr9/+L0CywB6y0BGK2DtOMAWG4ZCsZX5U4MRFaG/hcXmhpHc7Pam
	J3EYG/oYTCHqHV2gO2aescT3XqrI8mkqJKfjEb5dmo30JnIXQKdsCRJGB0KrzyqK
	tejzthl6EPP/XW0fulM5Vem+dzPmkiDk4qR0SHqcFkOZBAagHyOVZN36NG5wDsD8
	+vNKPmUoH8eHaX4soQ8PJoIBRy8eBLoml+fuFEOXn2ZF9JSFuncTAnzAT7H0q5U7
	Qe4TBvFPRT7apbd9qrRdiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770160509; x=
	1770246909; bh=fPkzaj4GqukscFDmkpV2WEnqFMbeCDJOFF1zRlcBFBI=; b=L
	qfBVcmgmZNylZnFGCOxEYYfjxrzZS6jcEPxtMq4tPgERVGLUm9t0AxsQ8ClJTeRw
	5aos/QLXO5QrlqKesTOBIC6QtK6Qxl1j9M9CaUQIgStuGoRRRhwYehJS7ZG//sPL
	ftpyN+8N1ieSC4eTmHElM+ZVWEX5jAH9h3bbPORaQOhuMKUb1X0jfxYLdbzhq5G+
	THU2VK2RW4+x0I+Iet5mAbP9Hxv0gkrIqZgKwav337HUrYCg1lqSEAOrFgmiyP7i
	8w25GSX2QWfqAbWitCg47TxJj1K8w5N0MI4Jg0BIDtk7ySyvWDKvzhYolMc5LX7f
	AIRdDoJzyq+byu13H4wZQ==
X-ME-Sender: <xms:fIGCaQ9sneAaS39RwOHamJmRBvnYcpbdpORkZfsxNtwYdUbhRrsWebw>
    <xme:fIGCaThQf435ltJ59ckbmWsRpe6zl5TBp-7OxG2EQeLgeH4V8jNfZ1WGpPlNgpHfw
    wJcmqQWBmI0wI6ajvJgqwZk4c2xEpwhb0iHOBNH_ScsYbkPnuKM3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedufeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepvdehtdetvdei
    gffhtdfgueegheeglefggefggfetledtudevieeggfegjeehgfdunecuffhomhgrihhnpe
    hkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:fIGCaa5kM7w5PKKTWFhS5Zd5bWP0uGpJ12fxJKYP1U6kwSaAtxF1RQ>
    <xmx:fIGCabq1iOsjDetRKSAjL_s_wXNJlXnkxs8_aM-9htAp2rRHTXkyVQ>
    <xmx:fIGCacj3U1pZtfRyt5zZhyY2XpGOSElbFJzdgA_xS2IJgr2Y15oiPQ>
    <xmx:fIGCaVKxT83ZHlzwznsrJf19vqNyUH_lSRxRjtub2FpwrPijzphumQ>
    <xmx:fYGCaSq671rLiVt4zXfgW-PPUR1PTU_zQtinYFTP-Hn8Vf8mN6VeNeQ1>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 973F21EA006B; Tue,  3 Feb 2026 18:15:08 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AmklL-wrE5xZ
Date: Wed, 04 Feb 2026 00:14:07 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Justin Tobler" <jltobler@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <e48578d5-ec48-4369-901a-597de3be9455@app.fastmail.com>
In-Reply-To: <xmqqpl6lqw86.fsf@gitster.g>
References: <20260203221758.1164434-1-jltobler@gmail.com>
 <20260203221758.1164434-5-jltobler@gmail.com> <xmqqpl6lqw86.fsf@gitster.g>
Subject: Re: [PATCH 4/5] builtin/repo: find commit with most parents
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026, at 23:48, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
>
>> Complex merge events may produce an octopus merge where the resulting
>> merge commit has more than two parents. While iterating through objec=
ts
>> in the repository for git-repo-structure, identify the commit with the
>> most parents and display it in the output.
>
> Does the size of octopus have anything more than a curiosity value?

I=E2=80=99m guessing this stat is inspired by git-sizer.[1][2] This is a=
ll that
the project says about =E2=80=9Coctopus=E2=80=9D:

    * Are there other bizarre and questionable things in your repository?

        * Annotated tags pointing at one another in long chains?
        * Octopus merges with dozens of parents?
        * Commits with gigantic log messages?

It marks the max of 10 in this repo as a =E2=80=9Cone star=E2=80=9D (*) =
concern
(lowest). The 66 parent commit in the Linux Kernel gets six stars.

By the way: why did this project stop doing 3+ parent merges?

=F0=9F=94=97 1: https://lore.kernel.org/git/20251021182601.2687284-5-jlt=
obler@gmail.com/
=F0=9F=94=97 2: https://github.com/github/git-sizer

>
> The opposite, the commit with most direct children, might be even
> more interesting, but that may be just me.
