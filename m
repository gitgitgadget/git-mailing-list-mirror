Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E930D1BD00C
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 18:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790967128; cv=none; b=svi6L9dC1RbnNdQhuAiZAoEPtdxKKjF4BSOGaNp6E7/66pEe5DvSBlgGib76Hatz0KKKXqpSOoahNEJmdo16Iyx6KZZHsLBawOAmf1/A1FDublPBoBbPODecjUh+EDRvWZo1uPLvlt8WRATxYSsC6GyS/TsN4Ak0/f43d5+zZ6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790967128; c=relaxed/simple;
	bh=xteJCiuuX1SnAZUl7YhU6oQLndChEZcVlbcCssyZjHY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BpaYKaTPzFdUVOdHqk6aWigjHGDlJont4NCcm/zCqiZ2DLOruoPqeTjA2G8pNVGaUg8l1YlwvkD/I6wmQYvM4uNarkTX7OATGSj9N1srsIHyvQVid4fMGgg0Z8rhnykKT1RYUYMSRBfGdFrR3zraQUlSRO+WNoeIGvsxiWtmagI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=o+kmj/GW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ftmB8dJH; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="o+kmj/GW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ftmB8dJH"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.phl.internal (Postfix) with ESMTP id C83EBEC0125
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 14:52:02 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Fri, 02 Oct 2026 14:52:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790967121;
	 x=1791053521; bh=Zi2mxEpWZkc57ogVe/yHuaehfVyScxZ8lCzyN+8O/Sg=; b=
	o+kmj/GWgedb+8+74sDljkTUDP2mbNB0/rWOlUYpC9JmFjyPPo2iSYswaMc7w4DE
	QXLoXd+TqTaK6c2vrrMLJCE/zjEQx+Yg3v0VaiuNj0zVJAiU2AW/sRdDJCo8A+5n
	IZYPyk/OE9zSjsuFQsghz3VXKaeJ9PdD58V5G4310WDt2M3Wg0A6Q4y1opipKJTY
	ihhWF5B8opgfRsCywtQXN8NjyaZ+BKB1UdMJz6OWeJzj4rh9hb671EZgZfHY8OME
	hn4lvWKf5PsCj/EM83wgERTmC/VIPUL1aumzpkQPrG/6jI91owu6xQjIU9OxOm1w
	dpGegrgXt/EouUA8GdtxCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790967121; x=
	1791053521; bh=Zi2mxEpWZkc57ogVe/yHuaehfVyScxZ8lCzyN+8O/Sg=; b=f
	tmB8dJHHWfI2U0R4aQxP7su7Zs5SY3/Wj/wjBOWlLJdHh4CttzcGObKvrs/LjkLC
	nCaIMzC16QbCXGXwXVg5IfSKKOufdxFSNn7DQ81OOq4PAgTB0wgVtJV6ORQ2EC5D
	flUcexqVDZANxlQH2SR2TXZafBgyXiuKCs+N4PWxvPqq9xGFYt2pqYPYBjOlNT9Y
	phMqgnaBhewiYZmsLEGzSumxE3kYaQPXCwYlxMKDYImffg1CX5OKTc4yrs9WKbQK
	Mz5GIzXAO4oPbhly3axcOYpogTP3P7NQLKqO4OOXvOSac0xSyYuwQw3FfNdY8nAq
	QSHYRgwdZsFOnq0VMpJXg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790967121; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:jr4fmuopaPqPm6KB7d02OuLMi57g/ej1rf9GShMK9pP/2db
	Vok6T4zzSJITL6O7kgoMCAJuekS+YGt/2X1R6nslds0IZTUHqh2GljJ9roLLzA5n
	kne4NonprjgFNguClGV8zNWZNkA/kRC/HOhImrQ1Gz0pcV7J11LCy0Q7NcX9MIzV
	j10r6T68U7IlL9tPWYzVrXCzs/47xOOy4hdUF6L4dIUulIccjMZqqeTYa8G+sP1K
	TMTAF6OMsbRSGPAHz1r4LWXqeEScI42UxXls8vv27pQIWwCxDp47et6XKy77mL+m
	CoVPW7KrXAjP8aH61f8DrSU9loIeq7NCA0HypBg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:hQ1BCj/S1MJh00eiOoVs3/lxD5i4cBWweAJ/W+SwNyk=:xteJCiuuX1SnAZUl7YhU6oQLndChEZcVlbcCssyZjHY=;
X-ME-Sender: <xms:Tv2_ak0czzrW4ShO2rJQYLp2bfLborhvEWgPcIj6PxjXu78PVwVO0Xg>
    <xme:Tv2_ap4OJ9YjVqRMDj87VkBxfgd9M4GJYl752O-DzqBcFEw3YN-ugsME5dl23l0eZ
    AN6AdUKVR6v1bzP4zAUP53hnbyr8IgTccLLCkuwB4ynzlySBC3SOA>
X-ME-Proxy-Cause: dmFkZTGoZGfsgHrrHK173AyOY9slBhL2YhdxiyRw1Tgi2OwHtbXoo8o/nNhK1Cpsf/QiZS
    iMft+HW+3nKlv/ADewYtSkOblPydSMtNPMnyKkkdz0c+OkftQfRrQAp2bFPQj2xXCYeDSh
    yGPHJhNrNwlxugno4aqRcHqoKW9oVdDdnZTWfsToj3+O9Dx8mxEr91emrYjM1ivqRmAjwh
    9YuhW5eTaJ1lIt9VOLbL+uJmJ/CU0UCELfxcpLiwmRrlBlBzWhWnhZXObqkr1Wi4vVF1d/
    TqEpm449M26RPPVwz88wMfntmII1WUHt+XcPB+jKwDOTHmOGj3hQo1116r7VRYMrs1C/ew
    krhe1gC1zpkvijTPRC2V4fUrPMtvfWwoNSkHl85uL91YUzaNtNv+i9UYBeeyhYuXaZ16+7
    MhhzNgVhnGmF4n1n1voMTlRVIBvlOT/rxDSpoNoQgIcUHi97ejy5UkjlM62cA2Bhm/dIom
    eO736wN9Jq/OX/1EyAPVXp/FkgExT0H4f+NThqdQRJ1jyc2kxSBqiHoCJbBu6oZCOkUDzm
    /M6mZ06yD9lt1dgEtNirrWDLKwMpDkHW0dC3xwipLn09nZr+zIgNDp48vdwDLZq7WTy8w0
    q8N82XPlbHQ1YPqGIeB36X8BonPcKuZLInkMZLUuq/6Gwlt1Z9/Wmw8C8VDQ
X-ME-Proxy: <xmx:UP2_anxy-mPjFrW1WsdlNjKXEPYJ7Zdvm7NcEqlOkCOuyEb67vlJhQ>
    <xmx:UP2_anCqmI-ihValGkjZpwfvv38k9oiJSnGCY_K2UlnihPIUz_qaZw>
    <xmx:UP2_akatwvZKYm96SB3sML4miEuCgV4h6ouCyW3VjimnlU0WWx8fGQ>
    <xmx:UP2_avgrqnMAW9erbI5D4F7qMNVDrehNoG0X101-UYV5WZYnLx7Lng>
    <xmx:Uf2_attK2s_aEFNjGLqqzWZnTyknO5VSLPs49aZtuf1MVDnni30HCX4p>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 948A422C009A; Fri,  2 Oct 2026 14:51:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AAUWAJQF6URs
Date: Fri, 02 Oct 2026 20:51:38 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <d2360e73-6602-4418-af2e-265054ba8e2b@app.fastmail.com>
In-Reply-To: <xmqqtsn4xd17.fsf@gitster.g>
References: <CV_format-patch_learn_--range-diff-notes.c57@msgid.xyz>
 <V3_CV_format-patch_learn_--range-diff-notes.d39@m5gid.xyz>
 <V3_simplify_params.d3a@m5gid.xyz> <xmqqtsn4xd17.fsf@gitster.g>
Subject: Re: [PATCH v3 1/2] format-patch: simplify get_notes_arg parameters
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 2, 2026, at 18:50, Junio C Hamano wrote:
> kristofferhaugsbakk@fastmail.com writes:
>
>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>
>> 85bd88a7 (revision: add rdiff_log_arg to rev_info, 2025-09-25) added
>> `rdiff_log_arg` to `struct rev_info`. I changed `get_notes_arg` by
>> simply replacing the first argument with an access on this struct
>> member. But the second argument was already `struct rev_info`. So I
>> should have just simplified to *only* passing that parameter. Let=E2=80=
=99s do
>> that now.
>
> The readers do not necessarily want to read the "author's journey"
> narrative in log messages.  Let's be more detached and objective,
> like
>
>   85bd88a7e8 (revision: add rdiff_log_arg to rev_info, 2025-09-25)
>   updated get_notes_args() to push into rev->rdiff_log_arg instead
>   of an explicit strvec, but left the rev argument as the second
>   parameter and strvec *arg as the first. Simplify the signature of
>   get_notes_args() to take only struct rev_info *rev, dropping the
>   redundant strvec *arg parameter.

I don=E2=80=99t get what objective improvement there is by replacing =E2=
=80=9CI did=E2=80=9D
with =E2=80=9Cit happened=E2=80=9D. This is not a gratuitous incidental =
biography but
just says what your alternative says, only with a personal pronoun, less
technical diction, and one word longer.

But I think we can shorten it with a little show-don=E2=80=99t-tell:

    85bd88a7 (revision: add rdiff_log_arg to rev_info, 2025-09-25) added
    `rdiff_log_arg` to `struct rev_info`. `get_notes_arg` was changed to
    take a second parameter, namely that member:

        get_notes_args(&(rev.rdiff_log_arg), &rev);

    But this is obviously unnecessary; we can just use `&rev`.

    Now is also a good time to format this `for_each...` line since it=E2=
=80=99s
    gotten quite long.

That=E2=80=99s 16 words less than my first version.

>
> perhaps?
>
>> Now is also a good time to format this `for_each...` line since it=E2=
=80=99s
>> gotten quite long.
>>
>> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
>> ---
>>
>> Notes (testing):
>>     just compile tested
>
> The code change looks good.  As long as this stays as a static helper
> function, this is not a loss of flexibility but a simplification of
> the calling convention.
>

Thanks for reviewing.
