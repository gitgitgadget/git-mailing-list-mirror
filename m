Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC723B810D
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 20:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791318829; cv=none; b=tBjVdYYmBNaqWD3Qaa99r2+F6N1oJRJQt3GzQJgOYh10RppkFSYPypsQZjHQeZZL1x4+tOgT+O+ydN+9MDgLxFFxm0lLvMN3haZyIjmF7xfxGN/3qFySjLrtf6TMDCbshNMJr8P972QeaDJlPiE6nrcsJraJnnaqfb3D6+6JE+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791318829; c=relaxed/simple;
	bh=aA9N3Q7m/ijm0Y9PwaU3uTxA+Kf8pD41lbSoMmJtq7Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SnfIN5XlzyyBOTbEtXo/5FLPpauD1D+iSJ1EboA9a5X/f9zSMbJeA4cf0Nq1RruO0ozbvEQK5AGjv0X4DISMyqZaLjfM4liLv1B5xv9PJ0inGIbiQRH4usglsC/hAqvcMRxeo1GqqdeklZXeLSAsmZJzdXRt2dEy8s/t/ruS/tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MssnaiRg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b/7UENaV; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MssnaiRg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b/7UENaV"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 31ABB7A0179
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 16:33:47 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 06 Oct 2026 16:33:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791318826; x=1791405226; bh=nugpkFOtt7
	SJ3We8bax46sYNuPIphezv1jmm+Nn11Z0=; b=MssnaiRg+IDROu6QtQ+2eecxad
	CVJbVL4szkvL2/na/1ACmGuxXytDQYXgXNuPIC97g3qtRRXVoCcISnn9kDwtLppD
	elB+RuLG7qnTMpduHOXPj4gOy61JBkXG3//4RgsWAgUBaeyl/ctgLxhuCKHHQH7H
	bglONd2UQP8Yq6lQMpc7eCEUzahAuVkodoZ91emD1vlMXXWp+GshcYvnJUAYW2g4
	8ed3fbMPMmQtCt7viRgZ1bCDwwIrNRDNKLDCjjHxFXaMlsl0aj9Gx/XY+brcHOsE
	sjwodxI/i/IwgJE+VHlKciToAUJGg/Bq/pWJZG6So2ryFyfkxDDSFYUmjXYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791318826; x=1791405226; bh=nugpkFOtt7SJ3We8bax46sYNuPIphezv1jm
	m+Nn11Z0=; b=b/7UENaV2tBCxZmKfOyVbUpykSZDwGO8LWcwnggWXXKvnZF2963
	YuNNujSFHz/Z3yE9gT7EHFkKiVQt1wm9TKWAncIK6p2XWlLl5gwzC6wvXgukhxUt
	NX27AFR2/+LP/QH2I3r+BCTXefqaJPWBpH617jZ9WGPLKnst9pcvAmdVQhX9Ql8m
	rveb5M27fsRvCXOvyxy+qM6FHPppGw1CgnZyh0uBpi/bIEzKAiwARaAM1Sno9q9u
	cPgwYtUQtCE7ptjpufXGFxHe27gNJRp0gL9vCJgy40s64L0PYjC63NKnfcuvQm6R
	sVgdLW3u9T+GC/MMNdvhBjdWlZWABqwaJ4A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791318826; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:jwV3/E8DE+q/HQPWpV2x/wttuEdEIVsNVawTBfZbwDC2Fu9
	6kX1BK5yRmP/3EWoOapHt75qRRco1MF1XDcv5sx180kFHdJHgXwpwjog3quRG+dj
	IiKK/vNHh10GSXsas2kcHkECXn7CkzrXg4ZzxZWiM1BEDTzCWD/lm2FQ/UuijiL/
	DD/l9qm/LwQJV7Kb2R9U2ONBWlRvxS7QYeh5h9hGgh6qactYj8oHygdhJd8pbuac
	ub8FvS1JpppJTwTaQg5mXa4+B+yviyFI0c4ZKXMwh+kOyl3CJP9tEQCTv/ZYLyyj
	P2XA06FYg8hU4hvB3mXXro7tkp0BSM4vP8cfMJg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:m98ocKa80u6TvxIxteEdINArKLNr/DbCloSYinFfUSE=:aA9N3Q7m/ijm0Y9PwaU3uTxA+Kf8pD41lbSoMmJtq7Q=;
X-ME-Sender: <xms:KlvFaoeLsdvoA3hZsG2PeZ2dfWVCxWy5CdOYKt6auay5bCby9s5OqA>
    <xme:KlvFahNzliNwGRydXGlu1_y1LZjeB9PBZ7CTNGyb4ggV2pu9y-cB4Gze3dq8npAib
    bij7Jqp0dHTh-JAT3Jg0oQ_LkjpBIBWl84bqpcqil-zW7s-xlOPng>
X-ME-Received: <xmr:KlvFauge4E8OY_hhSe-H5vVizFNSwWh-8NH-S49Hc3XPtpbGnpKvt6RSl8LYiGMy-PKSUL8_8JHUJ1smlePtECOjs4vBQdg37y_h>
X-ME-Proxy-Cause: dmFkZTGa3IFQ3HgO1bvaQRiWWz6Rs94BNZu6rGsISjqNvph9GTkrsgRhJ/zZ600BRw9eJN
    cYHXCE0ADcsxasXBz/Fuko/XAA4NX+agolxgY7sj3WgJ04j4uSmdpAONtlFAHVF2KRh2LH
    RAgMZYphDvVUwy3BDzTVmDDmoe9/2yU0YHHeUHtfC4rcBhKCy8eumHuXzzs/tt8RoyjE0e
    j2txv2Cp3Klslbar7Yp4SB9Ti9oEHrrVQo4R+7ijyYfcLkUXsMTgvOfKqop0bqPen/yuKU
    QgQSLjB+Xu0vCoMXmZZRfcmrj70GWV1qMCQxatWErjV9jeQAMa0pcyebFrTBWWoJ1kBElM
    dCgTobgBQyEfdwOE+wF47oDh/vXH+w/XPeVLH5+3AcHvrB23lUDcr7a7pRHSXaBGYnaT2Q
    t4IyniYMR5t5+dH+8Ij7+cWlKiNcYa1rv/2z7NoEi9x65cCaz3eKDDLZgOvRpyJuFyXRT9
    Odo1/RCuY1cUs8pvJDw9n+w2p8JTIaJYJaqy6cz9zsJC5KF21rBXARD6loKc5DYgAaSdVN
    vGVg8J/8TABrQJnpl7W048gjnORbiOQ+2sYMO46xmRx39w8jLhD1eKv4xaQgbnyM78wDUS
    GoU1fuk40Ukw1dDIUFsaolTra4kNBjq8rDzagJBUtLquPDQtGdeBI0GjKGCQ
X-ME-Proxy: <xmx:KlvFas2mMeWQQSFb-UDt2nAUFufDqNG319aKdkxKZutyiscSsH4deA>
    <xmx:KlvFaghpPWqPh2kQI0R_t7CQywiSeJv5ylektHK7uYswPIF6y-5jsQ>
    <xmx:KlvFakc2eXphJMM-gQ0YBLtvUut-6nF74VkxzB4EHGkPG8P9gzS0uw>
    <xmx:KlvFarn5vi_mPY1CMoVEV7c71e2mj_JRgZIWo3O4a7ZFWx-Z2Su1Dw>
    <xmx:KlvFalIn_wybB_Ums4aeUEgfXXCz3rLSBT2WyqZi275nCjUGHywUCI1I>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Oct 2026 16:33:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Patrick Steinhardt" <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [RFC PATCH 2/4] doc: gitbreaking-changes: replace msg-ids with
 URLs
In-Reply-To: <c85f5906-630b-4335-a7ae-09af665bb335@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Tue, 06 Oct 2026 18:38:30 +0200")
References: <CV_gitbrchanges7_please.d1c@m5gid.xyz>
	<URLs_not_just_msg_ids.d1e@m5gid.xyz> <ar0OltAkeTiCx81c@pks.im>
	<xmqqeceaa5h9.fsf@gitster.g>
	<533e2f52-2c9c-459a-9fa1-dff3ef4bb2f9@app.fastmail.com>
	<xmqq8q4ew604.fsf@gitster.g>
	<c85f5906-630b-4335-a7ae-09af665bb335@app.fastmail.com>
Date: Tue, 06 Oct 2026 13:33:44 -0700
Message-ID: <xmqqjynud0wn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> What if we used footnotes for all of the original msg-ids?
>
>     <URL>[1]
>
>     [...]
>
>     [1]: <msg-id>
>
> Or maybe just for the ones that need URL encoding? I personally think it
> would be better to use them for all if we go for this approach.

If this is an attempt to cater to those who prefer raw message IDs
over URLs that encode them, I doubt it is an improvement.

A footnote placed far down the document that merely repeats what is
already in the URL is uglier than simply using the URL without such
a footnote layout.  The cost of avoiding this ugliness is rather
small for such users.  They have to extract the encoded message ID
from the URL, perhaps decoding it manually, before using it.  That
is not too much work.

So, unless we can use a clickable link whose text can be copied
to get the raw message ID (which even novice users would clearly
recognize as a link rather than an e-mail address), which we
already agreed is impossible, let's just provide the URL.  Users
can copy and paste it into their browsers, and many terminal
emulators will let them click it directly, as you mentioned
earlier.

Thanks.
