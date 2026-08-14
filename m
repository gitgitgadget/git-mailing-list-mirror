Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0633E42AF8D
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 07:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786693852; cv=none; b=os9ZfGrgsFb86sYIa3s5YdiaDHJrBbEgbN8rhdlM5oeltpqUeRRmnMSkKrSAS7lFxbIzeY2gg2ECJ67pqxQuRrfcbqoHDRW9NxjQD0JSc2l3VsEqF5BmbdbwEQAnvYdDRHtPThMLT/dJn/JKtzUEwL5WI5s6+q63iNaXUFsG3HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786693852; c=relaxed/simple;
	bh=qXGTT8ZtuDAGoN2/eQEyiZhYoWzpgWzXx8FUmOWpJiY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YCYGfONrMCoMZ/0eDHzar7LN8z3mbnWDwkZX+r+YaUntMQWfeHsFGgUp9OqEh3HAFApEtaEOd04Ogna/8dci0HeAJbEvbjXM+eKD9Twe+iftQXD0lT7L3fLgjHHJSeMfSVGqgDJfr6WoWjVuox0pzgOZB+aCAW4yyn6DFvdDwdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=BfdQaWe5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XFLQfnDq; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="BfdQaWe5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XFLQfnDq"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.stl.internal (Postfix) with ESMTP id F21B51D00347;
	Fri, 14 Aug 2026 03:50:46 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Fri, 14 Aug 2026 03:50:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786693846;
	 x=1786780246; bh=qXGTT8ZtuDAGoN2/eQEyiZhYoWzpgWzXx8FUmOWpJiY=; b=
	BfdQaWe5WSMZ2yf8iwK2ksa98rgJwzapTtDL8yIgQlKXxxcNtPwce7UeXJD8fJhd
	96R6ulYjz35HG/mf+ZIaWwGW32likvI7caTYK3zpNwhNT7GIJfOlzHsqPeSP9EPT
	XbBcIaMc2MNcjWsHv7vkNWeQcoYBfIaBGcfxAnFHqrA47yNXSJVu+C4rr8PyxTbD
	seGTJHWOnEVznKLpYVTxV28TSmttkzOVyM2V24m7v1ozbSuBUNCPh5c62uPW/s02
	iYp4kiJ7dQwl9VfeNlb36N4n7OD5qj3gg5S8udAWfzBH63N1U2wuCK1kPaeVT1m2
	2rY8NfvLOu9u4SafD8+NNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786693846; x=
	1786780246; bh=qXGTT8ZtuDAGoN2/eQEyiZhYoWzpgWzXx8FUmOWpJiY=; b=X
	FLQfnDqmC7YpgOX+FDN/jAkipfMdZJfvGzSP2dFJkeU9KxuvLPw5v2+BktjwT6uM
	oEF2CPhxBK1v+SIjNDqb1KIXoV7Uhd8H9Nwj3nw/jIt0/09blrf06A3Y/unGkzMp
	/6z28IvztV/dv3hU1cP+nlaUNH0KFrP7rVZblFrUaNxSY6OW8LIbzHt1YOHBdvQv
	98VaMcX1ci0+4t1YpYpgIbOteq/RHt2II16WLLqlmPknJtwpBHG+Gh2jtOfLHUPf
	vF8l00Ieihy7JQs7vReYS9naxoC3fcw7a18s48Y9AFLgsumkrGJLbUx9TDphVhH6
	/il9+LcZTzHV6ekImfgVg==
X-ME-Sender: <xms:0sh-aoV4JsUsVSm-KhOz0IpB4Pfsg2usXATaz-PjvvPdk1IKpLiYLwg>
    <xme:0sh-anai082wgF_VRrFWs0aqfFjalOEyKhq22BdYP1jzophXDLVJWy4qlEqH-WsUs
    bElO9BShpHyl-xtddV2HB012M6AyVgjIzL_lVMvtLQ0jBqo_aoFDmU>
X-ME-Proxy-Cause: dmFkZTGxbMXTEJz3HGhp6ratK3mQzAD4rDTmOxq7EZAb2ZPZcMirKf3FtynF7tdNcoKtLs
    wXe3RU2yQTgb9ApxkVWCdZgXzeG2rsay/xyzH5SwBxVpfOeb5ctB1/BCAwHYmhhDFRKSHQ
    sregLc3ht9nvU5t50szw3hE51Mw7BHiWbKYvsPqbMaRtiSsOZHnwMNWqKgxD9eGrh6mt84
    rmSnizn4CuJ4bfjF3/KqPkqnrtxtcmmvPvpT6NMzaelSjEzNvcppSwoyk3f34c7rZNz2FK
    MvHIp2W9ipVOQDsvIe8ctRRGEZ7SOQiG3OwrjmzpkSP9EYirX04VWGlFNVRr08gEJky1sD
    8nI+nxYUj5wdvd3cflHbD5EduPI+Djx8/2D/ut2OSAak17+8w+afr6RqRK+XMnGZ3oP+H3
    GmkQWf9jfnH4sR7VpTrHpfcHn6wsXsgB4hUiPqQ1Z6PCSyvrIsMWGj3ySip1j3aVYqG+T/
    +OjIe8nok1U4dSSPXPaVXymkpJaz8r30VkxkhAEB9ak/BgdTGnHAa0E9b1zaIsvE/VQHtG
    we1PMgxE8zGEpKA91iskqq+4Yq2Ntjhu1E8nH1Yzv8QwkYMj7BV111F7KxNHo/08KjxdMT
    9kVO4M2EobG5ylPePZ+82veabIyxOLrXKK8etisZfdTJbdy2KsCJFU8r4I/A
X-ME-Proxy: <xmx:1Mh-amC_ymgpx7r1yqLfsoDpEguEBwqDyajLXbXoiAMwS-rI13aalg>
    <xmx:1Mh-ap0rsVYti0yh5A-YcTwq4x_EjXvaqEdq7ufObXV5mhkgAGfIeg>
    <xmx:1Mh-ag1v0Nf0TCNJYPTvPv1F8xQHe7bNSAgNQI28KrRgnYMF_1sS0w>
    <xmx:1Mh-amAVsVylwPK3I-9XxU0BXv5bkqddH3jnG8zkd-IKIL4zI0xJsg>
    <xmx:1sh-ar2RJlOMWzkzHuacXPQAXhVN29aMVYum-2owC5dIyakYlEBtnlln>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 7026222C0075; Fri, 14 Aug 2026 03:50:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AzIdpI2gmJpk
Date: Fri, 14 Aug 2026 09:50:22 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Vincent Mailhol" <mailhol@kernel.org>, git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>,
 "Philippe Blain" <levraiphilippeblain@gmail.com>,
 "Patrick Steinhardt" <ps@pks.im>, "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <7dd74cba-2149-4d31-9d45-2c355137bf0d@app.fastmail.com>
In-Reply-To: <3d0e8944-c17b-4665-88e0-2f955d52e8e9@kernel.org>
References: <20260804-history_autocompletion-v1-1-6f7459ffb677@kernel.org>
 <20260813-history_autocompletion-v3-0-69eed1cea93a@kernel.org>
 <bd3707a8-70ad-4308-bc93-5aad84e028d6@app.fastmail.com>
 <3d0e8944-c17b-4665-88e0-2f955d52e8e9@kernel.org>
Subject: Re: [PATCH v3 0/4] completion: add support for 'git history'
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026, at 08:25, Vincent Mailhol wrote:
>[snip]
> As you guessed, b4 removed the line starting with #3. I didn't see this
> coming. From now on, I will stop using # in the description.

You have a new enough Git (2.54.0) that you can use `core.commentString`
if you like. And with that you can set it to a string that you would
never type yourself.

That=E2=80=99s more of an assurance than `core.commentChar` which was li=
mited to
one ASCII character.

>
> Should I send a v4 with the fixed cover letter, or is it OK as-is?

No, no new version necessary. It wasn=E2=80=99t my intention to make a r=
eroll
out of a molehill.
