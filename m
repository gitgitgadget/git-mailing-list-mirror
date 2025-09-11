Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA19327A21
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 16:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757609349; cv=none; b=jWASfX7dYtrWF0aS543PpwSrhWAiHrjsaULeE0pD86sd4VP2pMBMAfgOR8QewAv+bgmyWvJ7zjT5o1t4fs34vgJQObCRthJMm6gVpaGzAnMiAUlIZVM12u/WPEw/4UYj8DXYDgyniXN+/RE+oM0T5OtK9pjN/tdqOlrrge4SzLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757609349; c=relaxed/simple;
	bh=eazKnyeif9MphPNPO2bS/iQ+A+312qC6VZJWXwJU7sM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=MaIJdRpkmckcfXp3Ilv3zfu6mxVk1NeYBYLsLuziFY7qQsV5WQWy/e7+a0/Rd2gmWEJtqvbH4YtguxDnK4O3+8AM8vebER7s1NjgxT/Hm69UE1gWlnhy9QkPcQCVRSdRHPEnp9l7+1F8t7yyyYDeQ0PWEbNUehOuZlzBm9xyE74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=gA9v5QzU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h5iCkFTG; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="gA9v5QzU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h5iCkFTG"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3AC8D7A0392;
	Thu, 11 Sep 2025 12:49:06 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 11 Sep 2025 12:49:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757609346;
	 x=1757695746; bh=qpqKnfNqOtWl93b8d8ZleegxYFwvYUmWkRg2BgFn5WI=; b=
	gA9v5QzUcNOJhpvRLeBuFeP+CN49POOVepH9va7FQKjgKRMUXGXTvDSBMFfTlCY+
	cTCuxYxbODieEOLhQr2a2/fGJ0GEvj8VZiywNkGBBXD3TxEWzNT0A7ypr+Odwn0x
	b8oZhkPRQlTR7OLZfLNg2hX/vJ+r9wa1992f/wStIY5lezd3+u0AN3XtxP4UMQcW
	vgGNGh7TM9qiBjTyZPOxPkGr9su1O17pODCZ3PI7H+YGgbcyLiVEZpR3Hz9dKIGe
	gU3LhPOcI168lJV39jYyIsW9W4Gsh4AfYBUetHy3PaXJhlebDCVs/0mk4KIchqGQ
	3vNYzz/n4jJUj5NhbdLvxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757609346; x=
	1757695746; bh=qpqKnfNqOtWl93b8d8ZleegxYFwvYUmWkRg2BgFn5WI=; b=h
	5iCkFTGKA7fdAK0kRsAG5iZ83n52NMcTiik+t3N36NFqd+V9S1Ytm00OTp1Ab0Kw
	R8uEYW6LgsEywiQr9X+UnrKkEdUfV9AIDyPK0u6c+Afr88QrDabSC9jD2CeUcbIx
	n6WZCQrt1OpNpZkKDkR1hT6ZvpVzHliZfrDa9lRj84tN+7aYMPlwne0A1YTblBmf
	fyphaxGkgo3NtlkgwSIFEWHobItWv0CByjytxgibFh/94SeznfNymS2b7P3Q2X1Z
	JkCGq697cTo2a64u8L9hkNOQmHxdVrou9Yd3p07xi/qoV5A3VT3YJLdBI1UT8dlp
	/uKoMKCCAkErYaN1KSIGQ==
X-ME-Sender: <xms:gf3CaKgjoIGXkUXuWLDEKio__knbNoRC3GpNLCNE2ECqdFveZnmlfEo>
    <xme:gf3CaLA6DujRvQbnZV1SidOAfAccAQMNuxIUE3I-c24b7k8N7v1_Yy5TGWkh4LSkB
    6zhLUHaAR5aSa2_Dw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvieeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeej
    hfehuedvgeejkeelgeduudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepgedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:gf3CaIoZ_W8iAcvKWlZAZ09ylxTkSp9nhDwopWn7zBKZoUfHg5weSQ>
    <xmx:gf3CaIERL_iGg1kCUUzE-vt9qk5gyR1nq1lodtXo-UwugyVcsBeK1A>
    <xmx:gf3CaMynRkWgBRwxJCB2rAuIU0D7wJ3SrgI91frIgm5Me6QNjNuYWg>
    <xmx:gf3CaFrN0RmTqfVR9R90wKVXPpckuejqG9hUlC50wZRLIcTnkEiuXg>
    <xmx:gv3CaPEBkhRA9JuPn0LkNRozu1aNYXolizHMfbjvbL65W7qJ0CXqy14r>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 98E891EA0068; Thu, 11 Sep 2025 12:49:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AhZp2Hba2xuB
Date: Thu, 11 Sep 2025 18:48:45 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>
Message-Id: <365d19ca-0a61-44f1-ab31-7e87f47d55e6@app.fastmail.com>
In-Reply-To: <20250911-pks-config-color-v1-4-3a7c79df65b1@pks.im>
References: <20250911-pks-config-color-v1-0-3a7c79df65b1@pks.im>
 <20250911-pks-config-color-v1-4-3a7c79df65b1@pks.im>
Subject: Re: [PATCH 4/5] builtin/config: special-case retrieving colors without a key
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025, at 15:24, Patrick Steinhardt wrote:
> Our documentation for git-config(1) has a section where it explains how
> to parse and use colors as Git would configure them. In order to get t=
he

Okay.  This is simple to find with a `color` search.

> ANSI color escape sequence to reset the colors to normal we recommend
> the following command:
>
>     $ git config get --type=3Dcolor --default=3D"reset" ""
>
> What this command is supposed to do is to not parse any configuration
> key at all.

Or

    This command is not supposed to parse any configuration keys.

> Instead, it is expected to parse the "reset" default value
> and turn it into a proper ANSI color escape sequence.
>
> It was reported though [1] that this command doesn't work:
>
>     $ git config get --type=3Dcolor --default=3D"reset" ""
>     error: key does not contain a section:
>
> This error was introduced with 4e51389000 (builtin/config: introduce

IMO s/with/in/ ?

> "get" subcommand, 2024-05-06), where we introduced the new "get"

nit: s/introduced the new/introduced the/

> subcommand to retrieve configuration values. The preimage of that comm=
it
> used `git config --get-color "" "reset"` instead, which still works
> nowadays.

nit: s/still works nowadays/still works/

>
> This use case is really quite specific to parsing colors, as it wouldn=
't

s/use case/use-case/

> make sense to give git-config(1) a default value and an empty config k=
ey
> only to return that default value unmodified. But with `--type=3Dcolor=
` we
> don't return the value directly, but we instead parse the value into an
> ANSI escape sequence.

Two =E2=80=9Cbut=E2=80=9D?  Maybe

    But with `--type=3Dcolor` we don't return the value directly; we
    instead parse the value into an ANSI escape sequence.

>
> As such, we can easily special-case this one use case: if the provided

s/use case/use-case/

Like special-case.

>
> As such, we can easily special-case this one use case: if the provided
> config key is empty, the user is asking for a color code and the user
> has provided a value, then we call `get_color()` directly. Do so to
> make the documented command work as expected.

In my opinion this is more difficult to read without an Oxford comma.
A bullet list could break up the serial comma and the comma used to
separate the =E2=80=9Cthen=E2=80=9D subclause.

    use-case:

    - if the provided config key is empty;

    - the user is asking for a color code; and

    - the user has provided a value,

    then we ...

In any case: I think a colon generally means that semicolon will be used
instead of serial comma.

>
> [1]: <aI+oQvQgnNtC6DVw@szeder.dev>
>
> Reported-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
>[snip too technical diff]
