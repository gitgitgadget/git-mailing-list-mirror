Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAA236B933
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 05:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787290111; cv=none; b=e2ZrKeoQ5u/SNhAiP1auhdu6taibPXSlRyMFuOrUnjCjN5c2DMoS0mi8mLdcQsosNiAq3hSR3/YwBIaOwJyrzQLEjccZOeXt9Gav0lfIy17+xEKMs000HmwrigBTemda9IyE2aQr8shrTV8uTmSNLK36o15D5Q5SLLPAAXtu06A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787290111; c=relaxed/simple;
	bh=sC+4tfjpail3o4EOjpsM4sGMosFQQcGD+pvXt3o8oBI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=MWUOZ5+4l45XhuW9z84d1OXXZljojvCQDt+nxhHeAjTviLzPEFXlV+01CIDPwDw7mAgvmV0R+GfsZ6AP2PHHxEsjt41Nf3w+3Q5NfSEsNP04EJxEW5OonDO+oqc8k4SjN0v7KVJUYx9O8KAjLtrL81KlENJTbRcthapJfv92tsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Bnabz9hT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HJ9akGId; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Bnabz9hT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HJ9akGId"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.stl.internal (Postfix) with ESMTP id E061A1D000B1;
	Fri, 21 Aug 2026 01:28:28 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Fri, 21 Aug 2026 01:28:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787290108;
	 x=1787376508; bh=NYZqguhW8OGqlZWKE3JEJ5wlPft7Pd43kLAx9JbOhVw=; b=
	Bnabz9hTI+FEJKYWbWKiqp0j0IpxYAPaiaVtwpn5wi/mB6q3ZpcVHD3coB4fo3xO
	Kg8I02413Oi0bjLlwK5PQYDoMaNZgRMMUmGmG/s9eYij4SwkxJXx9/gi+XV6Awzg
	rRbMg/XJq2ftS0yFbAgrxvT1KV9bxNRV643TYmbJ7hYJCa3yR4QOOkqOef+6SULt
	ig+E3Q1rasj4372ss22B06s+AU3ouo72SiehVtnguxtOzxj6n/Ka34XvErpUFvnd
	M+uDyTwk8xrtfVMiiocIeytb9u7cxNrN1JCEFFUuhcodnRePLPrDNs5aRUShcu0b
	XPBEfmJhIg0ndIxPuO5dzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787290108; x=
	1787376508; bh=NYZqguhW8OGqlZWKE3JEJ5wlPft7Pd43kLAx9JbOhVw=; b=H
	J9akGIdXAJixQFrMlgHoqiifnOhw/XtuY70yatEBr8HJ1RXFhQaFU5mExhc/1oXD
	LuzDZtFe96V2cifrjpo4rneSIfXCbuivkLNc+a1akZpiEF/YHWhNp3TNzmosEaHc
	bCZN+7fD1vvn8rqJi42qjp1pnFcoORiZykJovE7n3hX6XwWz9BCln9B7R/ykt5Tn
	H8/dW/493r/YAwPvGeEo9CgqJff/SfCc+4xJ5T7YtBshJ5QBCHJHb0e1dRqFiHTU
	hHaaEJGZLGuEiw2D2ivgQHGjtbLOiEpwE2LRf4uaJhhMqz61jHzPuJR3aiVYBNIY
	pMyMckYxSrRE3NQ0CZUiA==
X-ME-Sender: <xms:-OGHamXneOOfGDsUj-h95u07m-tupfGZeaoXTmiE6dRYcbwk1Ju5bkY>
    <xme:-OGHatYXCj1vTJXSvmxogE4L9h3A21G2pTyYdT1MUZDxaXv9qISxfgllNyWN4oakI
    nQGPAQ_79mY8UL4eSR6UMTLqh0tuCWcm8X_Yj8WiIe1eSm-rX8jXA>
X-ME-Proxy-Cause: dmFkZTEvwTPZ5jRXD0voA2Z+0zWuBTXIEHSuQaPqHCiyGWxODbxgOiFPEkpbd80yb2ku0H
    3SX8EHPZnC4vRA34rI1moHysyKwiuEmq0SFjdVyThz7Buc+zCx1RdjhgVSRNapVFPUg3gl
    kHBLU0MUfK/J85fAqv2EGyMc8IH3Ln8xYvCD2MOJvMpvA2HILiFRNE2i2ZY5Njq8ScfLBd
    fEycHdhos7bbJ2w/jfGMPKwC0jliCT2fyA5cYWjLnvAi6D19dFDUMKGbqWeyWZhwiY1V8M
    iDietXwQJ8beKIkf8dYCvg765Ez0gl8degkmH1nCMPrS8Ovgs46h0gN8Hqkn72efLk19EL
    EykzBXwNHOGlZZTzYpiItyPv5SqtpEDK7LAur4TcD4YBe0oJLCW/k6FS0TXw8P3ze9Z85Y
    ALWroffr0L+PniySr5zbuCjcVedaB+mYyUJOQjatD6yMvVyaE3+i9iROFZLunCB9c54+mI
    hLjqVpdV9ayMOmXT31ZUB3Rivz6Pzu60py2B04SDuCCr/kOvMTB2KsS87qQfw1Fcb6tsWX
    RKVgOrllqrdGB8gq1cegWBGzn4Hbimg1QDnCzQnmNTDPXIXdQkvbAZL/w9Bnr9Ex3dJEg4
    lu+jOWOSK13T9gi0WbII9DgtEBCigpxECBKPMuH1sGq6rQpVnohgkLAFLQgQ
X-ME-Proxy: <xmx:-eGHatTqhqs62gjbKJbMhuRRfTCKCVJN8wZDCDmvvIXW6ILw9Dafag>
    <xmx:-eGHauj3pnsjaQ-dfRn3aOsKsIWFJPYMLW3WxA6VWUw1OHN7-6ngDA>
    <xmx:-eGHal55E83abNW45SO0mLnk-1hF2PSKE-9Ync6qliNqyZGVoUvRPQ>
    <xmx:-eGHajCijkGf-3NouPjDFZljUlUj_I1ftwvafdxH-mA6sXxlH7-iBg>
    <xmx:_OGHailvqoKhEE14hd3_Nz2YiUM0o2fZqOPeRuAAEl4nYshTDF7AmKKd>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 4997022C007A; Fri, 21 Aug 2026 01:28:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ad5igGGZDhxo
Date: Fri, 21 Aug 2026 07:28:02 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Jeff King" <peff@peff.net>, git@vger.kernel.org
Message-Id: <6dfeeec6-c435-4408-8160-d7707806feac@app.fastmail.com>
In-Reply-To: <V3_URLs_not_trailers.bfc@msgid.xyz>
References: <URLs_not_trailers.b13@msgid.xyz>
 <V3_URLs_not_trailers.bfc@msgid.xyz>
Subject: Re: [PATCH v3] trailers: stop recognizing URLs as trailers
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026, at 07:26, kristofferhaugsbakk@fastmail.com wrote:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>[snip]
>     =C2=A7 Changes in v2
>   =20
>     =E2=80=A2 Add Ack https://lore.kernel.org/git/20260821004248.GA296=
777@coredump.intra.peff.net/
>

Sorry: changes in *v3*.
