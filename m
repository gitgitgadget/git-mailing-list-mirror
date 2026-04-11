Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E152DF132
	for <git@vger.kernel.org>; Sat, 11 Apr 2026 20:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775939690; cv=none; b=ozwXTNu0WC6iT3UbLpIh6nicV7d9Lnk1j/eUAb/1mRLxs/seb5kgUmjNk3DiKUZxnNxDvXOzZGbDmpU18fxIgGoVD/P6R7Ys0vi8cDL9J4JToFNDer/jgKJXOyjNq5LbrAFp7MITMTf8NiYZHue6fvH0auACZApSJOQ7eefcwG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775939690; c=relaxed/simple;
	bh=DrfsXqixUwC8arIJYa8Xz7ajGjStrfe4+66wUDU3Nfc=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=PppSbjI3nTf0TADtHaWCWOChXYgocrUbaygkMrLvaZ9/+J4XTrLuQucU+lXHv2KuscfN3D2byvJQb9WahRLSvdUhKnd9QYO+Aa991StHHOW4ypnBBY+TKV0gYw+6x6Y/7SbbpfzINeQ8JnsvGsV5ycr7m0zIyMzeczB2F+mOkyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=OZ623CPd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cTJcG+r3; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="OZ623CPd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cTJcG+r3"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 866291400082;
	Sat, 11 Apr 2026 16:34:48 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Sat, 11 Apr 2026 16:34:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775939688;
	 x=1776026088; bh=ZesyROLc2jA4DDrUtljDLWvp8e2E+I9arpytlYG0HpE=; b=
	OZ623CPdC/3wV77C8C7h67F9CXW9PvQITqgW+j14t4ldPtVVWk8LWKUonBkM4bEv
	M6UAn2IUdqMszCCS8Mk4O9Yhw2fhwWZ1uBrvv/kQNbQnSQPHfU4MLvsIUGaXjjNg
	U1VODostGD2dH5C/kKRwN09BMJov0ZXM/+0EDvosEFAuF6OP2452LKDeFRjHszhX
	3temzAw6o63fK4/FzEgmwWpiilJwF6695fHhLlk/ooYUbjkkwS8wOzHzykODDRgO
	dGn46NzyT1jCky8E4vNs0ieeY6E327IMWy/4vTeDUHLo7Zq78knXuPlybgbzLTts
	73DWA0tXbm77eVpZyumFPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1775939688; x=1776026088; bh=Z
	esyROLc2jA4DDrUtljDLWvp8e2E+I9arpytlYG0HpE=; b=cTJcG+r3Er4IGBmzc
	YjIp5vSl2RIgFLVbxkMSTdSHjoHzJDTb3wwy7TnHcN/I9uAUWLfNH5YzxwSaS4Qv
	MtpjNuJ4zdNWqvnMWoyfUJrWM7hn5LVsJSE1FSNlP/Rxv8AgzFoXmugMZ4NPEONm
	lSYbHVYglilm77j37xEN9hxQA8FfUtSZ6KD0Cj42bYQVfEn/bjln4biYVvQTy2g+
	4FBPkTgrV6bHBsBqkyvNdoIvw3Vw/PMJIToFEaeNJy25dLxMG82dwfVXSYGwshNi
	QePtGHk2FEYUBUJr7isNEzQ/RvX63ZmRFg/htBHkIjyJ5Eb+vtN36BDmXIvwcPQE
	57uFw==
X-ME-Sender: <xms:aLDaaYZsLqPixNzWnOOlTnnh5ZJPbzRI3H0AnJiEbf6zMvYdhmOrWYg>
    <xme:aLDaaeNsW0vsiM91_Pqo8D0ymP3d-CsaYqkQ2i-BEcCvvTKmAn0JQ_w44x0P73I-r
    PLytMth-xKu2lIDv8fl4jDNSn-JaTeRcv-Mu8H_PjqrxC2TWUR-Zp8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeffeefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvffkjghfufgtgfesthhqredtre
    dtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhr
    ihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtf
    frrghtthgvrhhnpedtgfffteetudelhfefkeehtefggeefjeevieekfeefieekkefhveei
    ledtkefgueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdp
    nhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfh
    hfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:aLDaaTEBpTOlTxTmlGLg50LJReTE-xRJRiWr_z73vVMwk3dj7pfx1Q>
    <xmx:aLDaaeTQWftCDHHqwM5c52OvhfY3ywhzNKl2XIJM_UY0UOkHdBoMKA>
    <xmx:aLDaactG4erhuveoW3kZMsZcc50wXcRTN_TYvGPM-jM9KBcyxDZPxg>
    <xmx:aLDaadxxQVLBdAITUumjtLxcVHdSXeEJk-xN1tIaXKO3gte12MYlYw>
    <xmx:aLDaaSqBeLcYJRTzyqo8nx4vhgyNnubn_aZlnTmCpo95y_kn30iWCHNx>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4E7A51EA006B; Sat, 11 Apr 2026 16:34:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A__05JlRJZT-
Date: Sat, 11 Apr 2026 22:34:27 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Jeff King" <peff@peff.net>, git@vger.kernel.org
Message-Id: <fb4dff1b-d304-4f29-a96c-373b1a73989b@app.fastmail.com>
In-Reply-To: <20260411190625.GA754966@coredump.intra.peff.net>
References: <20260411190625.GA754966@coredump.intra.peff.net>
Subject: Re: [PATCH] gitglossary: fix indentation of sub-lists
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 11, 2026, at 21:06, Jeff King wrote:
> The glossary entry is a list of terms and their definitions, so
> multi-paragraph definitions need "+" continuation lines to indicate
> that they are part of a single entry.
>
> When an entry contains a sub-list (say, a bulleted list), the final "+"
> may become ambiguous: is it connecting the next paragraph to the final
> entry of the sub-list, or to the original list of definition paragraph=
s?
>
> Asciidoc generally connects it to the former, even when we mean the
> latter, and you end up with the next paragraph indented incorrectly,
> like this:
>
>   glob
>     ...defines glob...
>
>     Two consecutive asterisks ("**") in patterns matched
>     against full pathname may have special meaning:
>
>     - ...some special meaning of **...
>
>     - ...another special meaning of **...
>
>     - Other consecutive asterisks are considered invalid.
>
>       Glob magic is incompatible with literal magic.
>
> That final "Glob magic is incompatible" paragraph is in the wrong spot.
> It should be at the same level as "Two consecutive asterisks", as it is
> not part of the final "Other consecutive asterisks" bullet point.

`Documentation/doc-diff` confirms that this is the effect of this change.

>
> The same problem appears in several other spots in the glossary.

And that it is the effect for all the other spots at as well: pull a
paragraph out of a bullet list back to the previous block (or level).

> We can fix this by using "--" markers, which put the sub-list into its
> own block. This should catch all of the unordered lists in the glossar=
y,
> which I found by grepping for " -" list markers.

Yes, for what it=E2=80=99s worth I think open blocks (`--`) are a great =
cure for
this when you are lucky enough to not already be in an open block.

AsciiDoc is certainly a format.

>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Just happened to notice this while looking at the "ref" entry.
>
>  Documentation/glossary-content.adoc | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>[snip]
