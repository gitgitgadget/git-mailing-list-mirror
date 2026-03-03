Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61C6370D73
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 16:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772556355; cv=none; b=iHBgA6iLMVGkin7zZcT0ivfBvqI8M1ZvFTlO431pvtMSA785mbiZQ9OqogTQQEdl2ePM0ToDzEysQRMcXnXjF8YDQBa8hDDYXLcz4S/dNtNKkddSPUXF1CTR57GaudMWXjziPTtJvuOn5gMbTu4hfSiOeFtEAXNbgG8kPUr/qP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772556355; c=relaxed/simple;
	bh=qe7X8/YZshPDCnkY7EX5bpiinyN43KFLYEZOx0rgllw=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=sVg//0afzKi/KmUvk5fGDU+X/8N8SJ6EtPEHlG2KD4/VFTrvjq7NhzoLGXBKhHd8KNmqMT9LUZyKlAeZBZLEEwtT5so8oLNAIBI2n/7AbQqrs87Uh0E1qrms+vI7vigikCLKJJKCnL5ILzBqtWKPavC55kwFFTnAHkkH6LZQopw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=E6R3Kn+5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s4WK4Me2; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="E6R3Kn+5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s4WK4Me2"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 2D5621D001E2;
	Tue,  3 Mar 2026 11:45:53 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Tue, 03 Mar 2026 11:45:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772556353;
	 x=1772642753; bh=qe7X8/YZshPDCnkY7EX5bpiinyN43KFLYEZOx0rgllw=; b=
	E6R3Kn+5fsWU+wN9DjJoXh6tWmYdem2k6UGfnqC8+LEhNizPIXt+aNncrS9PUczK
	lI6VzsBcUkq7++alh2UXIa9+jjybIk6cDtGqAA0g0/giIaGHPpiwL7bbA26rFMU+
	HuMevodJgq5L6jgQmQ0fibymAaE74ApbwfMjpfHSrT1Bcr+o33Ab7iTll3cYfUV6
	DYFkUsoe+q4v7+thGZBZEwyiVJOPdVV3Dtb9K6jlQ70Vo1XMrY1ILcCPGn+1jyaK
	8zsNrlYeEl1GldZWry1vYF+nfwJ/5uht4/up7FoW6/rDpXFzwzG9wd6MYKy3Cb49
	SP08msksDxd7ugFknqfE5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1772556353; x=1772642753; bh=q
	e7X8/YZshPDCnkY7EX5bpiinyN43KFLYEZOx0rgllw=; b=s4WK4Me2skVFTt72W
	ZcbrIl7XW/q5fd8kyrfEisiq2Izfwt7ZjJovfZpUeP0FROMqCRmMee8awvd7zyXm
	zvNwVbOXXzgp/FjHkFYwQcUcbJL2F/K7XJEi+73DyXeimF/637T0d8PYP1VSqN1T
	lmehQU7ATYgzHTh+SC99wijxI6V8dCHRgFm7muw2jzenCO1sPk05rHrw9vyfRxfT
	2DVEXuKu3Nr+axEfOnXyrYEQDf7k6T/JYgcgCzMYoVbngjZHSnyszc4hUllTMCoH
	i5fqfVJykW1PRtsqT1A0C82mjMpy0l3I2dkLCfWrc//1rhU2lr9HTiPqBRYkyeUz
	5c9Lw==
X-ME-Sender: <xms:QBCnaebiPZv_-UzDEyKATZQXljZAGzI42CbU8Sf428_tHeGYlbiSedc>
    <xme:QBCnacMTyy73vyJUhcL8gsW6ejJiJJDdRsDnulyycgBZboDK-gKnAlKgxcHT46ArM
    GJxvDZUVgzNVWJgIseL9YMOHTxNjnbncYXLQe9VdjbfuyXBv9--hA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedutdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeejvdfhjedvgfev
    hfdvjeefleelteffgfeuhfeihfeuuedvfeevteekteeugfehtdenucffohhmrghinhepgh
    hithdqshgtmhdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheprghnthhoihhnvgdrtghouhhsshhonhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:QBCnaZHP_vFQJ2YdWMChToqXbCUWiGuruixPH7FGYJQ84QgawZC_DQ>
    <xmx:QBCnacTvgDeEYqI6PSsCl35aJMrUfcO8oHd6Ol7US47pvmaU35pXoQ>
    <xmx:QBCnaSusxmPYilGn4FiORvc8R4_JmOAfvQ7dkryfJIGWPieW1mFA4A>
    <xmx:QBCnabzbgZnenYOEvnFYmq6cnM8sxkgSDaz2sCzxFkjAde6KyYKStQ>
    <xmx:QRCnaS_g8Cb993t0_9JMc6v_OPcBtp8EobKO5w_lLZvb5TXmmHE17mTh>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DC01C1EA006B; Tue,  3 Mar 2026 11:45:52 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A5SwzrcE9SNF
Date: Tue, 03 Mar 2026 17:45:32 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Antoine Cousson" <antoine.cousson@protonmail.com>, git@vger.kernel.org
Message-Id: <9595d154-8586-4afd-ac1a-f5c133e10f9b@app.fastmail.com>
In-Reply-To: 
 <bhYbjxeZY0QZt48g6XVTVfyPo6vbv9yeYLsw9PgFdVKgye6Ue0cAPy_RkNTwAOYEANhHyD6QbaxZrWaPS4__jlTcAVKOaEjrDgAxQYKdYvE=@protonmail.com>
References: 
 <bhYbjxeZY0QZt48g6XVTVfyPo6vbv9yeYLsw9PgFdVKgye6Ue0cAPy_RkNTwAOYEANhHyD6QbaxZrWaPS4__jlTcAVKOaEjrDgAxQYKdYvE=@protonmail.com>
Subject: Re: git whatchanged --i-still-use-it
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Good evening

On Tue, Mar 3, 2026, at 17:01, Antoine Cousson wrote:
> I would like to say that I still use `git whatchanged` I like the way
> we see the modified files instead of just `git log`

This command is being removed because it was supplanted by git-log(1) a
long while ago. Both commands use the same machinery, just with
different defaults.

> And actually I never saw the message before today when I showed the
> command to a friend of mine, will it be removed soon ?

It is planned for removal in Git 3.0. There is no plan for when Git 3.0
will be released.

See: https://git-scm.com/docs/BreakingChanges

> Is there any alternatives that are straight to the point without any
> args or something?

You can replace it with `git log` in this way:

=E2=80=A2 Given: `git whatchanged <opts>`
=E2=80=A2 Replace with: `git log <opts> --no-merges --raw`

Additionally for the sake of readability, you might have more
use for `--stat` or `--name-only` rather than `--raw` if you are only
reading the output (not feeding the output to another program).

You can also use `--patch` to see the full diffs.

>
> In any cases, thanks for your amazing work,
>[snip]
