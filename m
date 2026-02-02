Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43EF26FA6F
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 08:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770021391; cv=none; b=dFvlGRn4uGnwdy2jhzyiy9ze5CGaEojjANpP7R9qdh0HHEAqJpnLo75QnYXpoFSYmAJrGcDKZewvKueHkAdgZO0dEu5dHLaTwG0Q0d8kP5Qlyr1nBDoNU521SM3drjoWnoh+iY8b8WPr+afkoIs8wQF9qPOJ8iCo6Suqs9C6VJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770021391; c=relaxed/simple;
	bh=WuypQMNRKv5uDaVM/w1iPRRGHI1hQvesS7L69fE9sqo=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ATbcDJjDAkQC6lEUFtTnfPvFHUcRD3t6RK5JdG43DSDmIdVljSmSX0JUfnuLEliVBBpcHxPhWMrwMNqQyz9CYQvVeGzfHYg47KItxyyHDT1lCwiuP3dhEBO1mKlN8JvSi/77KFarqDjjnE4JQ2gVoD65DWAS4ppr+JSs+07LMJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Cq2l88OY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wCkgOO59; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Cq2l88OY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wCkgOO59"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id D680BEC02A4;
	Mon,  2 Feb 2026 03:36:28 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Mon, 02 Feb 2026 03:36:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770021388;
	 x=1770107788; bh=WuypQMNRKv5uDaVM/w1iPRRGHI1hQvesS7L69fE9sqo=; b=
	Cq2l88OYWdYEmDNsPzwFDlKcDy7931dgh1gEfV/MfQxPRnvGm/XfQxYQYq4i8GSq
	pvyNZeuyBHgbMhuWP4Ei+SDW2tpeatx1od6EykzD+MEqRmm7ilZZdr8akxeMV9fV
	N8n508fSKAkdm/SeAFq/mwmXjEUtCAeQX3qaWoUB0LavMFen/WifCKENrDg8aHsv
	0FuDNjBQgSnYsf2nEFklz7iy9Lh9Vo3bi968lEHioxlde7HpMVyVDH0O/DNRAGlW
	eza5IXBH4UXLizhmpdKQ0zIadNzSDry9C1s79A6nnVrM5tOPubkbKJAIFnlJJ95V
	AkQbxbFXnunZqz4JQnHv+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770021388; x=1770107788; bh=W
	uypQMNRKv5uDaVM/w1iPRRGHI1hQvesS7L69fE9sqo=; b=wCkgOO59hHuxzr4Oy
	xRYvE0kNBLZuPyXQZ1Wifmv+VpViXtSgvw3EWghSH3km9Qb11qU9Kk7I1WxIeDSe
	fTm/NUKHfp99Fh6aHoRvC67ZJhqaRvavqZglYqRXz0GtfBmjAiElHaEZGpNKpCbO
	fYd8l7i22iRZ3q0PIhCCDT+TLiI8Gz+hhzSY0ftHqUSemJB1S7I+9mKwgQoN3d+O
	6DNclUJuu/MtrG5/VWkyIhQtVAU6luU8HeUTFBKVRhEXOY86wRjErv7fdVIBz15O
	MdTBRTnbhi2fl4t/sIwRyWOodb0JN5H7flJohH41jiHivqt+vLY15wQ5+ymOy4yR
	bIzDg==
X-ME-Sender: <xms:DGKAacWsIFSy1IZrb1eAapoFiw5m4C5seO2xp-heBkUjz_SyPA0Jte4>
    <xme:DGKAabZhTSQzw8Qg7Xx1lYaz_TT_D-RfXWfZw4x75XEh4SO8DXVgcaixn3Er-fdSy
    sBnlUc0JWVi_mzK-SPM4ryEys13J-Yz_xQK84a8SD76xd9i_HL0Og>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeejudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtgfffteetudel
    hfefkeehtefggeefjeevieekfeefieekkefhveeiledtkefgueenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhr
    tghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:DGKAaTTdsoEG1B-nSRcUkQckc2Bclr8blPFYk_B1qdKU5ZwFE7LPzQ>
    <xmx:DGKAachqn9j4-sT1glcnM_4GrmuM6y8cVm6Ahr8p7F5_8tmA6NThfw>
    <xmx:DGKAab6ikcBFYfDAugrlIY1QmPDJLP4sA3F158j6XUpM0lGBmB7krg>
    <xmx:DGKAaRCA8qsIgDfQqrpZ8wo-wzL0gRfvX3vcNrqwfLAsjhHx8NHCvw>
    <xmx:DGKAadN-EV9mg21OJ_TjVRH01xOjz7PZg41Nr0__rLDKaILevpq5mGiz>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A1C591EA006B; Mon,  2 Feb 2026 03:36:28 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A-_DlS5lSLTB
Date: Mon, 02 Feb 2026 09:36:08 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>,
 =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Message-Id: <bc69a105-5621-4ecb-b89e-82bbe1c4bc51@app.fastmail.com>
In-Reply-To: <13939780.uLZWGnKmhe@piment-oiseau>
References: <pull.2036.git.1769202903.gitgitgadget@gmail.com>
 <3a5b642d05b9fcafb684631a0026959bfc362d2b.1769202903.git.gitgitgadget@gmail.com>
 <6f7d027e-088a-4d66-92af-b8d1c32d730c@app.fastmail.com>
 <13939780.uLZWGnKmhe@piment-oiseau>
Subject: Re: [PATCH 2/4] doc: finalize git-clone documentation conversion to synopsis
 style
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 1, 2026, at 14:14, Jean-No=C3=ABl AVILA wrote:
>>[snip]
>>
>> Doesn=E2=80=99t need to be done now in this series, but the =E2=80=9C=
stuck form=E2=80=9D of
>> `--origin=3D<name>` is recommended by gitcli(7) for long optoins. Thi=
s doc
>> uses a mix of unstuck form (no `=3D`) and stuck form.
>>
>
> Is this something that is automatically available, i.e can we already =
convert
> and advise so to writers in all pages?
> For me, these synopsis series are a chance to push forward a larger ra=
nge of
> reworks on formal formats such as this one.
>
>[snip]

I am not aware of any static analysis tool or helper.

I think I learned about in this combination with that gitcli(7) as well
as Junio writing about the preferred way to write options.

Thanks

Kristoffer
