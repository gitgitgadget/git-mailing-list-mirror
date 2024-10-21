Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDED2433D8
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 21:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729544608; cv=none; b=e8eZlOnOKzR9sMawPYdY2iWb7Wtft6ptNaJqkyfdXXlVPNkgiZqGbIWsuxV/fJDc7bRaKcciK3ATS5X/LSICgBjkIzkgE0/HhWXOSL18wq0y2Guos18TIZLv/r+yjrocoij/PJVLeBX02xTnogzXrTYrC3nte6iN1RlqAXGsWNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729544608; c=relaxed/simple;
	bh=YeDkCV1SVnvozQ4YxIW3gmK1DdvV61sww+NO5EaDpXs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=EJhFAjbbte9jB0u4J3q/N9+XHJ0B0dbEbG5rBUr6qnnyLLnCm3qiIcX+/wbifdoouDGcD8WvFpgVTUDPS7AQLchIGNjaRUtK+CoBbUCyH2lzo8H9o7oXw/XfgpgYVUuVMisVBe5I/IctrIjYzmfkHaSjh3+ny99kFrghWSEz1PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=lHJptDbN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XRCVALk7; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="lHJptDbN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XRCVALk7"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D40B7114009E;
	Mon, 21 Oct 2024 17:03:25 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Mon, 21 Oct 2024 17:03:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729544605;
	 x=1729631005; bh=mKHSdy8I0yav0CTXXt/7UMC3R5cE3tWH4msVHBF0UV8=; b=
	lHJptDbNBBZhGyiowaQbVhspAfIdjwoIOeSnU4pXz2KWXARL2eNLwNmJwTpNfzRY
	5SWMlmsPIZoE6WGtU4EpN0QasGdL9HU6Iku1Jod7Mu6w7Nf3jE+TIKCeZp6CUO0m
	+EPaPbGgkG5H/lQqz2rrzpX5KtdPrpON5iEo18h37LPEZclDDdzA8/o8uxTPVQtr
	G0qGDzyCc+cdZWGp2uW+dEuSjlEIQxkQgwWp5NqfAZ034cYHT4AGlgp4Q/EONAzP
	e8SbH4MUaDBXPqfff9LTEll7lMvesDtQZohkwiasihq7CrfdHpnNzWr5ygIyeshF
	Pnja2HgLDMdGu9yoWSiymQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729544605; x=
	1729631005; bh=mKHSdy8I0yav0CTXXt/7UMC3R5cE3tWH4msVHBF0UV8=; b=X
	RCVALk7Y9em8RbaW/wp+XUL4CG30jKNbMc2qud3MRHNA2bObzJbtHx3YSpz9S12m
	YnOtIIWZ1AboXWDDGiJgbpeCQn+zX0YtJp/UcvvLr+UA4ckGGHpuga+KKo1Pa/bn
	LxwJhc6KhUTZ7HvJCGoV58Qz79yDdIIBYNWp8kM4mL3TXdpXGlTTFg3gDUaYdqUa
	e6b5DYp2/BfmHpkl0AHhiyvI1zlJqpWR1FEc1q1NUfskN8DEwG3SnEmLrPy6uYcv
	eG7sjx4o18rHqJgtw26XtzMDlN80c3XPx9zAHCZn0x1Cn8N1q3TZ2tGn+pFI2rtN
	jBHYJYUPLw1+0OWE8IUrQ==
X-ME-Sender: <xms:ncEWZxIChCmbHQ1IASqhJj-171FMZKIi0jXL8jzWn7rRUx0b1isnLXc>
    <xme:ncEWZ9IpnxMyezpWrcMLgqUMdr5yLk9Tqz98hlQgY8MEsa9FgCYnEhuUzUbg1yNOp
    q3suNXpE9FTSWDgeg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgudehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffr
    rghtthgvrhhnpedtiefggeejgeejhfehuedvgeejkeelgeduudekleejkedtveejgfeigf
    efkedugfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnh
    gspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhs
    thhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtoh
    epphhssehpkhhsrdhimhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ncEWZ5vST_ucDXtN9K8XO3AnMwZvH6BkFdEi2R1U_l8LptI_YTNi3g>
    <xmx:ncEWZyZa-412Nae-v4aqI5DLo-_Ct1nzNGTDu3H5a6SL7ZiOLeEqEw>
    <xmx:ncEWZ4ZKT5LiNE8AourdN4pGYl1eEFfznlSStQtN0zDzSQK7WClYDw>
    <xmx:ncEWZ2C7JfFu0yuF2QFWQlnLilYZdXfXTTUx_kdwNjoloAhRVx_Tew>
    <xmx:ncEWZwEtxh_NKaMvyogbr0U2JFpXOWxubLzppHFMJvTc2YlUlj4MDJgo>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8E567780068; Mon, 21 Oct 2024 17:03:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 21 Oct 2024 23:02:48 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Taylor Blau" <me@ttaylorr.com>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org
Message-Id: <36959987-5695-48fc-9b4e-2fecfe9f5b88@app.fastmail.com>
In-Reply-To: <ZxalTgct8WhEmO0w@nand.local>
References: 
 <ab7d4c8d89c075de05bf04f1f9dc195145455964.1729439476.git.code@khaugsbakk.name>
 <ZxZETN7WjbNiSRyF@pks.im>
 <d66936b8-d12b-4035-b563-328ae9fc4824@app.fastmail.com>
 <ZxalTgct8WhEmO0w@nand.local>
Subject: Re: [PATCH] t1400: fix --no-create-reflog test and description
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024, at 21:02, Taylor Blau wrote:
>> [=E2=80=A6]
>> > Overall I'm rather leaning into the direction of making this work
>> > properly. But that would of course be a backwards-incompatible chan=
ge.
>>
>> Good point.  It does feel inconsistent.  I agree that the conventional
>> pattern (to my knowledge) is to have options override config when the
>> options are given.

Agreed, to be clear. ;)

> I agree with you both that it feels inconsistent, but I feel somewhat
> uncomfortable changing the behavior here in a backwards incompatible
> way.
>
> Even if the original documentation leaves the door open to changing the
> behavior, I think that probably a non-zero number of users has either
> (a) never read that documentation, or (b) come to rely on it, or (c)
> both ;-).
>
> I think if anything we might consider updating the documentation to mo=
re
> clearly capture the status-quo, but I'd be very hesitant to see a patch
> changing the behavior here.

My background (how I ended up in this test) was that I learnt yesterday
that `--create-reflog` and this config variable controls whether reflog
files are created.  I thought that they toggled when entries were made.

I have some work in progress patches for clarifying this mechanism in
git-config(1) and other places.

Now git-tag(1) and git-branch(1) seem decently clear on this point[1]
but update-ref is lagging behind IMO.  I will be looking at that one as
well.

=E2=80=A0 1: There is also the `--create-reflog` case vs. when the confi=
g is
   `false` but I can=E2=80=99t check that right now
