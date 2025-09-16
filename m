Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CBB22E3F0
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 20:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758053098; cv=none; b=KKGT/OtNcG+FO1Rh2C+/NhALjfINrXbc5iVdWakRPAqc5VTX+T+0iujmz94CQ4rcyv3EowBFG/IOZvVkiMtol4o5npAUpUqUimFYGgxuKvSUZSigcqIWatp0zr5KnWY5xVrJNjlBa2M+YKjCL4XJCbwB1gD8PY5Mf8tfh0Bs0s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758053098; c=relaxed/simple;
	bh=heeCBCs8E3p3odb/Er05n6oIF0WgNN1HRHdRC12Yovs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=fLkXtZHHqyiXvT8lXadlz5YPeHFC0PSSRvLYZZsULA58IpNFVB3OoXYg560G3vf/zRbhL6xglXXqzB6cincipz2iQDeMq92LKEMx7NUuOglLGcPctLxocJWXKrXLG+L1u6Uzw8+k9TvTrPpxmjdLU8aOm6arHJMWFpN6xl+wznU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=O/Jf7foa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nfx9FoE3; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="O/Jf7foa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nfx9FoE3"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 17E5CEC0235;
	Tue, 16 Sep 2025 16:04:55 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 16 Sep 2025 16:04:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758053095;
	 x=1758139495; bh=eXah5CAZPaFKbEOVUlbDtHKjxBWTxwUgsahZZ6MMnIA=; b=
	O/Jf7foa1YbdPFGnBYdSOAbZVtrD47Q02TWaxUYa3c3ya+vFt6u7zxw9OliPe+iU
	WVGl/aTpcLNRv0x/cNhGllaWK9CopvM9A/fzr2Z5A9RHjhPUkgditu9CeheQJLap
	wzYQweRNa/g6rNNo2I7jFZm3eOH37lQmDcqlpVVuJmgeTIddZ6OwMqHwogVEHpRr
	uMHV02c98xEXlWCNG6teQhy20XP6vFTq9moM563IGZviDUPmkaCFVdpmfodaB6ZJ
	A2bz6/VssOWI02Z2YUHAbg4kUzSa72ypccpEs2pdPAV4efeVMMRE9E7GOqYEGVGU
	s6Tfd4s9/TfXF4lYtAi9CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758053095; x=
	1758139495; bh=eXah5CAZPaFKbEOVUlbDtHKjxBWTxwUgsahZZ6MMnIA=; b=N
	fx9FoE3MJuxPSIdsV/92coeMyo5s37+pU4pFmxtNCnL7ldY6VjqKSTKrysRN2Yga
	99OYwOcx/QX2P5ufD2UrN596Pvex92MxdHwTwrfM2L5xvTZJTUVxtg0kQNE0Q/os
	hXNRy71VC0OwLheZQFUC557AjzAdZ3ODIc9KYUHo0p6xX6/f5kAip250BrBo3MuK
	O4IeNdOtZdn6cho9KyTTsYhmvAZygaV3OBB5NIef45ECvL95Ndp6r3xQs78p6wC7
	Og9oNnKhT65xePOQeav5ftASge+hbA0F4Ny9Zgp4H69DknL7vSDijgz/8mEnrtpN
	lsHcVu3VwkklU5u5yuSIQ==
X-ME-Sender: <xms:5sLJaMocIn28N4BedHTtyfBUkbdkQJ-fxvNk_5nQl2U_U7Y0FPkmnJU>
    <xme:5sLJaCrakesPKgZ8ozHtqyhiww2XpjTmy8r0SjXclmKQ2E-ZvLMaHKCd0H3Bqt4sF
    RL-N_Y1JektidZtUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegudegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeehudfgvefgfefg
    ffdvhfffvdevveegheehudetvdfgueffjeevjedugeevfedvfeenucffohhmrghinhepkh
    gvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehguhhsth
    grvhhordhvvghlrghstghohhesghhmrghilhdrtghomhdprhgtphhtthhopehguhhsthgr
    vhhordhvvghlrghstghoqdhhvghrnhgrnhguvgiisehnvghtrghpphdrtghomhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:5sLJaLpfD3LygHrmx2QRyKOVj7lV5dICOTt7cPYXv_aaZB20W1suOQ>
    <xmx:5sLJaCybGiG0-IyqeWbf9n2sVQRMR1iapKd9ttp4Y7maLdnyJX-exg>
    <xmx:5sLJaHPzSThWNVlmEkuhFqvLh9vu2oWF9UjV3tkqI_1T8ZPUiA0aiA>
    <xmx:5sLJaP5Bc-ZzuJjtHWOuBEENVOyqz0nYDt7ydmsWRTW0VBOAN07nUQ>
    <xmx:58LJaCD5pzObYg2f85J5_jJhrrU_K9m07fONRXVXFX43XadrxPcPLFTX>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BB2801EA0068; Tue, 16 Sep 2025 16:04:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A4llZu9Ahe03
Date: Tue, 16 Sep 2025 22:04:34 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Josh Soref" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
 =?UTF-8?Q?Gustavo_Velasco-Hern=C3=A1ndez?= <gustavo.velascoh@gmail.com>,
 "Velasco-Hernandez, Gustavo" <Gustavo.Velasco-Hernandez@netapp.com>
Message-Id: <97770221-63b8-4375-9787-991717594938@app.fastmail.com>
In-Reply-To: <xmqqzfaumi2b.fsf@gitster.g>
References: <pull.2028.git.git.1754922884439.gitgitgadget@gmail.com>
 <pull.2028.v2.git.git.1758038628948.gitgitgadget@gmail.com>
 <xmqqzfaumi2b.fsf@gitster.g>
Subject: Re: [PATCH v2] docs: update description for '--mirror' option for 'git push'
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025, at 19:19, Junio C Hamano wrote:
>> The current description considers only created, updated or deleted re=
fs
>> locally. However it does not address the case where new refs were cre=
ated
>> on the remote end, in which case, are also deleted. The description h=
as
>> been reworded to describe what is removed, updated or added. (Based on
>> Junio feedback)
>
> Drop "(Based on Junio feedback)" that is not even grammatical ;-)
> If you want to credit others, it is common to say
>
>     Helped-by: ...
>
> just before your own sign-off.  See an example like
>
> https://lore.kernel.org/git/2f78ab2e28c64f05d807cb9460fa62eb1011a57f.1=
757879060.git.code@khaugsbakk.name/
>
> (by the way, oh, gee, that's an unwieldy long message ID).

It is.  Considering I only send out (git send-)emails at most
every 15 seconds. ;=E2=80=93(
