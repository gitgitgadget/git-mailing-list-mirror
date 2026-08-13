Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D9238BF8D
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 17:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786642545; cv=none; b=NNORogXiMrKQ9fXkb4HedmeuM7JmypVZ5YDWDYUC0VcY85deLPC6y002TCV611K5MVl7uvYWEGFobcZtrGPIgb3culPBNq/uPZniiW33BbE75fGK0dH0ZJinfscuQ5Kh7W4jVpQe8AG46Fwcn2hlRXHJj7mWTh4GjXylFcgJDkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786642545; c=relaxed/simple;
	bh=93Mq68UMF4OS3lTTXidpYVI4L4nZVLpSOHlrQEVTeBE=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=QgHIUN3sCMC2kQ38J28cGuKpirv5Aqyo0wLlZJiPG+zABPIYuNl+qNh6YyxUHS0aVNRVGQRk4W0269DpaTKC0Tk+7PsKDUPUaZswlkOinQcnWwk9ZAM7QePQLmNcwkK5/6CkCJWd1/ByRJEudOJ7bzD/ezgXOlO7Pxs/HzhCPmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ehlU8Olj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KxtiFLDE; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ehlU8Olj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KxtiFLDE"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 843E1140009B;
	Thu, 13 Aug 2026 13:35:42 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Thu, 13 Aug 2026 13:35:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786642541;
	 x=1786728941; bh=ZxkmhB2r/Q4voNtJu7AKu0bIoMmMwXXB0ClCwyjIWsU=; b=
	ehlU8Oljc+SN+Z7E48/w7Z2Rkzq0gbWTxTdG45QA46BdCgSd4d/qtv3S7SYlHouQ
	naL4AT+dn/bq2ev8EkRBBmMbXLKom/oH/pVkbQCEcZkKCOzvEsg3aimF5U2j58KZ
	CzkM5jS3DElEZNazL2p4wNFZ3jJaNsymzrCWsQJshbFqf+HI5mN/qRWRBxKpDhxF
	j+XQQw5h1r+NIicN+p2j8avuZKId8xHtKurxqB/dOfVCyRKm4Knw6wXy21AYmgHT
	zi53Zdw9GO/sLxUFIyO9AUJiOY3YftbM9C5OcruNesiFF4iJF8qPzFD6/rSRt57c
	6iPaAfEdNFSERa3wZqLJtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786642541; x=1786728941; bh=Z
	xkmhB2r/Q4voNtJu7AKu0bIoMmMwXXB0ClCwyjIWsU=; b=KxtiFLDEccSS72nEb
	wLdbF/Un0h03AMsEnICl4Wc/KyHJlkAK4FgnAPiD6cKImpm1jnKXdmgWRk0QBX0a
	2K74rnkPOPzi2bxvqkRMYlajO9h2rdLYmtMIoXCJ5LXBFMkFo8dJtdAOqL0Qp01i
	qInuwfXM1esUyO6XbGfHyPGZ+PminTj87PCmIiVm3COHLj645rjZJxdx6lxnXKNG
	ETCCzTuo/reX4zfzmUoL7jVnu+mivH4QMpkBDMdWlbMAUDK0ycSX9al+AS4WPwOz
	3AJhWIEbc/lBDHvUn9g83vEBi7AYHcds+FlELVlKlamlTM0KNOZ2kCS8KPHboee5
	A6kIg==
X-ME-Sender: <xms:awB-aiTncd9a9JtgABrnvkH66e8K7UwdbEJpsgtHuU_uajxzqcuVC7k>
    <xme:awB-aimW6KHcfCEKNSCy8x_H0L94d9sjwyWR8JO7D1pUb56QvA0LUzaXCNLC28rTM
    -_TvCcp8ghlWwEOFQFOXjoocxU5WdWFsu6zPy1WDAjEIoEs93lex0Y>
X-ME-Proxy-Cause: dmFkZTGRqRPUaiGo1TwOSjb35155twQhzQOaY4kXP3ayOHCxHcjD/Uq2R6ZsA6v2HI6XdG
    pKOhROnuytS57HUfsOHnjxrC1d2z1y1jzAckNXwpC4JkAjCkvdlUybO1VJ2l1YKV9IOlCo
    sSOjpPfQq2ohzgAjJSkBzIAk6f7vvp3tXwVtIWti3Ep+LCPDjZzzxJtLhhkC7CBfxsGnBq
    7Hh41nyr6oA0uTJAWvMUjH4nsIXFAhg3h1coKTFCuL5cyzi3AqE42O5MbpF2aPRxRie8RH
    fnYWO3PqWrCzksKJIN50spTYqWui8VjhO59kXxsdbZGAomeaGeg8nuIv90t65JQmZD9SRP
    X1fpX0OMjK+R4W3N3T61JGiSD5h5aNqdIQK0k4neVghau5cgrYyiekNyF5fpxu0sDPbJL4
    sEP6+9Qm7DsuZ+CXnlacvaasgcvVcP2AsZd186D54+9kr262kYmDZPow9sDbBvWcyU3HL0
    Zi/3hnMakLWPHCW7Jh/vh3ivlGe4QoEDapPHGCeskIdOqFSuK5ajenXy0EywYYz9c/Nbdr
    +KvEw59FdAQ0fImRYrTgOSvk5FuxIPvGQmC8xoVSqAbhMejOKE5JL25Zse5HSqZ7giI39Q
    dKr18Q8BZ27PoH20lm8ay+R3iasVrvDZlrT7LLCbTerwtekQ508TzXp46M+w
X-ME-Proxy: <xmx:bAB-ak9fVNfLWWYMFgPWTOy-9o71zv4GxezaJe0JjAAtMVC2F3njkQ>
    <xmx:bAB-aqrXOwNLY2K22EghY9JvxnUWC5j7p0XwZbkczqmGsawaQqLr0g>
    <xmx:bAB-ahkNvEr8hjeLSZWl5KxcB4n5KqrgsbjkZYeYejJigeP7Vp1uBg>
    <xmx:bAB-ahL1eSSoc80S38reZIcqNVMpCH9yZ4oQGRnyF-wpp3xklM2KHg>
    <xmx:bQB-arXwAA5FNRGJSiKu8BlUWzLoHfcjY6dVrKana3OBYspBJeVidPDM>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 2CE5722C0072; Thu, 13 Aug 2026 13:35:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 13 Aug 2026 19:35:18 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Message-Id: <6e990986-2d7e-492f-aa40-d26cca4f58f4@app.fastmail.com>
In-Reply-To: <xmqqcxvmvda1.fsf@gitster.g>
References: <xmqqcxvmvda1.fsf@gitster.g>
Subject: kh/trailers-no-urls
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026, at 06:45, Junio C Hamano wrote:
> * kh/trailers-no-urls (2026-08-02) 2 commits
>  - trailers: stop recognizing URLs as trailers
>  - Merge branch 'kh/doc-trailers' into kh/trailers-no-urls
>  (this branch uses kh/doc-trailers.)
>
>  The trailers code has been taught to avoid mistaking a line that has
>  '<token>://' at the beginning as a trailer line.
>
>  On hold, waiting for the base topic.
>  cf. <20260803152025.GA189075@coredump.intra.peff.net>
>  cf. <xmqqmrv42lrg.fsf@gitster.g>
>  cf. <xmqqtspbz00x.fsf@gitster.g>
>  source: <URLs_not_trailers.b13@msgid.xyz>

The status of the topic kh/doc-trailers is =E2=80=9CWill merge to 'next'=
=E2=80=9D. I
will wait until that topic is in `master` and send out a new version of
this topic then. Thanks.
