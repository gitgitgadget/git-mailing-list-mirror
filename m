Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224A5321F32
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 16:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758644817; cv=none; b=RlNVNGo3D841feR198oUfVYao6xjeh3puB4fN4SXdvD8z05TXfcQaI5zqspmSzHQtbTmky5k9MP4ZCB5YJ7sQH2HH8iszrfj8NzWvGeADWtxDDGenTiaAOoueRSKvHpq7Djyijw1YcFaQwdSJulVLBN5mDC+zMWHnrhGFB5Vd3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758644817; c=relaxed/simple;
	bh=Yo2UI0ytVL0b/i1ThpILe4Yw/3O/3Fy6XQR0gmZ2/kg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=KgjOkXqDiDR05PjEI3u+c2L5jHZPGMxbCegbVQ+1XoHTiYpiAFVMkIwk/c2hcy7JpkFokpMxkTa+2qDTqaiGkRF0sv1zkd2iZeT/PV/tEf1GluIpuwt0jK9ChGsi3cPIEQgJdUO8qSTWcQXFBI2bkBVkh8MuFhblpR4UrjlmC6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ENDl1Yns; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wxuqyb4s; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ENDl1Yns";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wxuqyb4s"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 2241CEC0096;
	Tue, 23 Sep 2025 12:26:54 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 23 Sep 2025 12:26:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758644814;
	 x=1758731214; bh=/jCyMMC8kvwU0SJWyBuYP5Xp2QuqW9OdMHz1jVk3oLY=; b=
	ENDl1YnsStSAZH+WwozD8ZHUnItJCxWe/rVJKNQ7VmPOhY+ElN1pHf7XP3gxNksa
	h28VaQJzK2yZs8tru3nAW7azj4OOAyzWYaiAMJm35WCD8FGyqZR6EDbsedjyiVhS
	iOZfAJeu5LGLiZEhP/jW4Q/bzWnm+wPk2A4WQeNYY4s+d3iXgzpG3SZhMN7l7qU+
	GI3J5EdKdQeqiT1DDfNh0EZjSTczWFr4crJYoLry7AgnKvNsmQ66aXQQxaXXEh+N
	B/ZTGXIetSfRFTNEmsAVV1+oHvi+xMW4Xr/LgBi4j+54A0zfP+nRXqDvy2d7OW8i
	5L05EyiPKuuNBeYgHznVdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758644814; x=
	1758731214; bh=/jCyMMC8kvwU0SJWyBuYP5Xp2QuqW9OdMHz1jVk3oLY=; b=W
	xuqyb4sP+HR3RdCPbsol5TM0ctQbZu26gwFORsiP+IyJGXu1KyqTToKdYv+IcH0U
	c4rHZIqWBaOwaliwz3lVLGasnDY+MwZ8xuRlmim2qqlsaF115uOtA4gu2E5hvWIk
	9b/t0mfbwgunt8e+OfZwgetwQ1HwAaiSB/UrNrSOe5qdbhAIike5RZzW5zwQxM6b
	dXM/6MeGS5gfHKKT6xs8XItYcKQMIqmhjO9ABhA95M9HgH+kAYkw9eLhWjZsHI+V
	QUwfbfFu4IUVUC+iuejosP9BF+/cWmHsjaOdjqaFd6kS8L2pp0jzXQm+2tasELzg
	L1I6IuNFBJg44NUJjbBfA==
X-ME-Sender: <xms:TcrSaOrrza5qeuAWcJarKNZlzrDxjMRYVMxJiFeJv3DinQCfnYXcz8U>
    <xme:TcrSaHeC6LIvs3VhldqefwWZWHb777gCFjxtxuHx19OaARwSyCQBq0d1j562HVgkF
    c4QX0CyXbZkfQv5zZEWFydsVYYd0qtCFf5OR0Q61GPOiPsba7rw1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiuddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertd
    ertdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecugg
    ftrfgrthhtvghrnheptdeigfegjeegjefhheeuvdegjeekleeguddukeeljeektdevjefg
    iefgfeekudfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
    pdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:TcrSaJUhc5-K_RFMJAcC6NY7c_T2ZAozW2LR2Skq9-KRhSd_E-V7kA>
    <xmx:TcrSaHhzZ6e4VPqxuoxP7-j8a0ibOxEA2EIyS12zwjTkTeFWOjUaig>
    <xmx:TcrSaM93MKV4nNw5QZFieA9tE-95Z6d4dXHR_JaBHob2EqHYDfcT1A>
    <xmx:TcrSaJDosnPx7_2nlN0iXvYUW5-s24mpnIhcsPo7k1VP21gx52-YLw>
    <xmx:TsrSaKOaSihZyBVA2AgEslc523lkPLDc9tTZIs7R321-_nkPugJIpEWh>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D75411EA0068; Tue, 23 Sep 2025 12:26:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ap9Hw1rPQ1Nk
Date: Tue, 23 Sep 2025 18:26:33 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org
Message-Id: <269dd1ed-e8b0-448a-a85f-fdcafafbd0a0@app.fastmail.com>
In-Reply-To: <xmqqecryrvt6.fsf@gitster.g>
References: <cover.1758574974.git.code@khaugsbakk.name>
 <7f2487af433.1758574974.git.code@khaugsbakk.name>
 <xmqqecryrvt6.fsf@gitster.g>
Subject: Re: [PATCH 2/2] format-patch: handle range-diff on notes correctly for single
 patches
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025, at 00:01, Junio C Hamano wrote:
> kristofferhaugsbakk@fastmail.com writes:
>
>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>
>> No `--[no-]notes` options are sent to the range-diff subprocess in
>> `range-diff.c` when making a single patch.  This means that you can g=
et
>> different Git notes below the commit message and in the range-diff
>> part.  (See the previous commit for elaboration.)
>
> Would this also mean "range-diff --no-notes" would not have any
> effect in squelching the note output in such a mode?

Do you mean `git format-patch ... --range-diff --no-notes`?  Yes,
`--no-notes` has no effect.  range-diff just does the default thing
which is `--show-notes-by-default` (act like git-log(1), which shows the
default notes namespace unless any `--[no-]notes` options are given (and
there are no such options in this case)).

> If so, perhaps we should say not just "can get different Git notes"
> but "can get notes even when you asked not to"?

I think =E2=80=9Ccan get different Git notes=E2=80=9D covers all possibi=
lities, both too
many and too few.

But like the previous commit this one could maybe use a rewrite.

    No `--[no-]--notes` options are sent to the range-diff subprocess in
    `range-diff.c` when making a single patch.  This means that range-di=
ff
    will handle Git notes like git-log(1).

    This is a problem when you ask to use certain notes, or none at all,
    since that set of notes will appear beneath the commit message but t=
he
    range-diff will have whatever notes that git-log(1) would have given
    you.

That=E2=80=99s at least less dense.

>> @@ -718,7 +718,8 @@ static void show_diff_of_diff(struct rev_info *op=
t)
>> [snip]
