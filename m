Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9BF31A068
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 22:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758579564; cv=none; b=P/5Auz1OKcb3JKw87VB9NOIhcVtA4JZ/WzCJHS4jKB9W8AwtEHbXNEgMLmtkXxImDSKAbpwileEJ9qWxdvMPJjRLSKKxBGuyW/KbnyYOYeWmBXovljm9Hkamml0s/AccBF9nEDJTnkl/do2aGfOC/rJH39WL5nwAJlimvxOo458=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758579564; c=relaxed/simple;
	bh=owxBXe30Ju8jZPs+g7+uNUx0Zfws6+DwlpIQhGsS1dQ=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Bt+tTStRIPgMLMmaXWJOTekE0dm81Iv3wlRBqDB6WK7D78bEJ7r/FOM56/QCKH/RTn1sEoR9fED7xQFjaWJDjCpphKeU33RnhwMaYjkEjvv51C3YvllpHLsui/eU2UhY4jnxi5nxzrOK4egRNSJwVV5w0BOIuhOCfNSGbXtyBe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ZCi59yQf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GH59ShYF; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ZCi59yQf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GH59ShYF"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 2BBDB1D00243;
	Mon, 22 Sep 2025 18:19:20 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Mon, 22 Sep 2025 18:19:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758579560;
	 x=1758665960; bh=DTEysQLvUM0/7G/a4UsoPwqqOoO33hXHNiBfpKu60TQ=; b=
	ZCi59yQfX1OOlMW8U13o1uXeb8bcU2cVdMMqVyRN8F6XNCpO58ayrHrkeKpJpa6y
	I7b4fOnDyBDjkrvogocD0xzsRpwpnChoHGsYhSWxklWMWaZc4RZm8JDfngp5Kab3
	vinj/BsGjBkKjLxUwT0bQgm7Z/7mDtC4v/erBsD+7SV+F+ooEa2nXghctKZrKfY6
	d4UtAE4jFLK9wp7jiM1jfMMGGv75rRtRvSOiLQ1frCmEe+X1+A00+JD1zTdGiNGA
	rMbbmFNKxqVa4XfwO549WgqGfIRyF1ae9NSqt++gdLnk96EexMpV01GSscnl1zFW
	G0orGdzxUht7Pck1SLpmtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758579560; x=1758665960; bh=D
	TEysQLvUM0/7G/a4UsoPwqqOoO33hXHNiBfpKu60TQ=; b=GH59ShYFV1i16DFnX
	zktvJn3utrcbnlGZEKfqLSP0EYnLhVV+cqcXHryQUUEERMJwbMabqNlugCDh/YLy
	9A/89/uOS4NFhyg3HRIPdwoUhXtWswJXQrWGxd32NGGAQYFSFA1vfUxh2gBEVC5H
	ebO9OxOptTCecsxfUHeUh8+GzQZnCwoDZk6BYj+6c6hlvtEsE3AvJ3an2mpiE9bq
	VzNQkvXPa70YPiNR95H6hbLhdWE8jtc/62qaMnGdV3hzshbhlYA+BOMLCdyGQDBf
	SHCdsROlt8DWKLQC9YVIVNVqRxeRDgRuQG6M8d+vlgSZQr06XEkjlWWflKNSoa4o
	48NVg==
X-ME-Sender: <xms:Z8vRaJYzRgwMWYwAu_I7KyRtUWUOBsPDgEu26dzicNiPZNLWvMWXXFk>
    <xme:Z8vRaLOOE8qkPy3yKe7eIpnRDWtxQ65e-Kjg9G0G9pAYJb0Gq4fffMblQg_jJZfeT
    on7FNNYKhWaLF9mnkdbbiOWyDxYED5PMBVfqe8OiktPPiaA6H09Kw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehledtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhsthho
    fhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkh
    hksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdfgffettedulefh
    feekheetgfegfeejveeikeeffeeikeekhfevieeltdekgfeunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehstdgrnhgushdtseguihhgihhtrghlqdhmvghr
    tggvnhgrrhhivghsrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:Z8vRaEGsfEVlQw4eMEvKmIO_UJuArq7rRChUyyjo8Wq5y117vh6lqw>
    <xmx:Z8vRaLQGnuqdQZx08reogmQ0PMxeCODMGZY-CaQYLRfgxsLzBtbNqg>
    <xmx:Z8vRaFsQBQ9Ih0IqoroQ1xRH6GSsf6UWa_ZPRIXnAGdw_fq_Kms8sA>
    <xmx:Z8vRaCykVY3OCnz1scEE6YFUJdxIoK6t56oFbPvHYR2V5eCFyH31pg>
    <xmx:Z8vRaL-M2JrrlCmvvy5K9O-wnuVHEGayC8M8smLcqPpKQegKx2vl5aYC>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B82AA1EA0068; Mon, 22 Sep 2025 18:19:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AC4a0_pyrYUo
Date: Tue, 23 Sep 2025 00:18:59 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "S0AndS0 of Digital Mercenaries LLC" <S0AndS0@digital-mercenaries.com>,
 git@vger.kernel.org
Message-Id: <fd993486-069b-445a-ae91-a0f149fd3ea8@app.fastmail.com>
In-Reply-To: <8f201082-07b5-44a1-88cf-d6db551a598c@digital-mercenaries.com>
References: <8f201082-07b5-44a1-88cf-d6db551a598c@digital-mercenaries.com>
Subject: Re: I still use this/these
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025, at 00:11, S0AndS0 of Digital Mercenaries LLC wrote:
> Recently, as of `git version 2.51.0`, running the following commands be
> popping
> warnings;
>
>  =C2=A0 =C2=A0 git whatchanged <path>
>
>  =C2=A0 =C2=A0 git log --since=3D"$(date --date=3D'-2 weeks' +%F)"
>
> ...=C2=A0 Warnings stating those using certain features slated for rem=
oval should
> email y'all about `--i-still-use-this`. If there are alternatives I can
> alias,
> that will remain functional, please do let those like me know. Maybe v=
ia the
> same sorta warning system.

You can use

    git log --raw --no-merges

If you want the same behavior.

You can also replace `--raw` with `--stat` or `--name-only` if you want
the list of files without the filemode, hashes, and change type (like
M).
