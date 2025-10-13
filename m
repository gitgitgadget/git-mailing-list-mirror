Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B2318C31
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 13:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760363324; cv=none; b=ASq3fanSfOutQXcG6vzNHwWwvBmegDqee7d0j8giO/CAYZBqxqr9jLpHJ5D2MGyOyCInAGVIEk0QGzy6Ky2JFOVsiqASjnhJX2fGYvvZK8KWJ17Kq+PcRXFRnDoKyjAQdA9bBNKfeFLMuvS8wxbpkwpaK7YwM+81o604xWSca4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760363324; c=relaxed/simple;
	bh=GeYGZqvKxOSJyI1cIwK86ZuggO97rOBl5OC/9KQ9pqc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hQ8+uxD603k/5oZxKVfIOhiUWtKvx2PZnLsSIaXm2HYIIUCiDjb6Omchk3N3WVsg3JpeSYi/0Z3+qa8wKK189Y+9ZtBvQkODhSFCbMSPNn8QNDKIuUFlRT8WsT0zy/55MnRgmFgbhykA+gD0aiNVqpHhJVc5vj2G7rL3eoT09+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=MFy8RvLS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jgsnh8PX; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="MFy8RvLS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jgsnh8PX"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 28C5A7A012C;
	Mon, 13 Oct 2025 09:48:41 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Mon, 13 Oct 2025 09:48:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760363321;
	 x=1760449721; bh=KnKvJq9CO9NS3I6auFz737kgxiQHYX8yzg7shEHGw7M=; b=
	MFy8RvLSxhNXjRuKCzM4z5amrhH2cA4fN24B89le+zq6quQoMdq+XVI+4K2dW+En
	POv90hex+WoA1a9tp8iQKSUjGAlqgmxIVbVhzX7BtQD6EHp2UAcjp3kK77ncM2/l
	CHAcgKavsvdT+pEnk8UJVAbUfSUjurdOYru+8Sw6CULlwpegUYdtqsfgLkTClQm3
	DyHrbIB3gspdh977LNmRuwf44mc7ejYqbFcbPGyiZJNfzewYeep/NeHzzALwAijR
	iFHeRBFuPYDJtElxzivzJxBVekQ+BJL+DmApdDgKnQd01l4EGL4pXa+xMKOwy8q2
	G+4csWwNypGiMsKn+p5U3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760363321; x=
	1760449721; bh=KnKvJq9CO9NS3I6auFz737kgxiQHYX8yzg7shEHGw7M=; b=J
	gsnh8PXOGijMOIRkZzed3rXwglcEOX1ZYkbNfn9NR/HnAMKGZLz9/1uIDHO57Qwp
	VTV3MRviNB+9bwWupJfqUJqFGcgGuuh3H0ho+eo0+uANg5fv6TsKXITTm8e6evJ2
	1nVxgehdDHprjP+mrnSYA33WTRhrNLpw7GkWqU8oLzd/sxkcLlwndcvlJdPLrr8F
	fiqmFDSZx4WEXNnYtUH9qzPfNsFFTX0vcr2N8KgtZLfL4uiyXrL+e1ykdBRXh4KD
	PFo17FUmt5sZNdQ1ehTcDZDHd5yvQmbZwpC+jGEBYHdP0kIXVP6MXLUWXKukz7UJ
	F1l4tBU562/f6QFVY4s/Q==
X-ME-Sender: <xms:OAPtaHIud0xdzvSECD3EYN1W5bsdfoRQaQh1VMBOlyVfjYXdwqOxtAo>
    <xme:OAPtaF8GICutIsxiq2aHdKIU9-TLTVWfevzmRm5rMU5U80y8aLirr1ySLccbDlmk4
    F5TDbBUS8WdJz9bEFOXDBNplL65f86SYcbB9xLVl6qIjystntOvQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudejkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegrughmihhnsehgrhiivghgohhriihkohhp
    vghrfigrshdrshhithgvpdhrtghpthhtohepghhriigvghhorhiirdhkohhpvghrfigrsh
    esshhtgihnvgigthdrphhlpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:OAPtaLl0P_fDz18laAEUYKiHB3KIy_utVg9NONAaSwIAvY7tnFtxgQ>
    <xmx:OAPtaGlsOTrqPoT-4gobVM32H9se0Z8Ag6oBGlRNaGW3E2qRa5cqkQ>
    <xmx:OAPtaEv6BsvJgQfwBuMhLlPfmGC2xthIXZjHPMFzgMkW0OblxA2x6A>
    <xmx:OAPtaBl1jYiZnJ7VTOyKbPQwm_ijZ55BaFRjp3kxCt_OvVhJ6X2CUQ>
    <xmx:OAPtaDHiHHfs_CcKrPzwzJWCQfE_N01BJsQHxOiTT2tbUQxeLHw3Qucv>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 615D11EA0066; Mon, 13 Oct 2025 09:48:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AnqBueeHxi9N
Date: Mon, 13 Oct 2025 15:47:26 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Grzegorz Koperwas" <grzegorz.koperwas@stxnext.pl>, git@vger.kernel.org
Cc: admin@grzegorzkoperwas.site
Message-Id: <8a69ab15-9a4b-4fe9-91ae-86e73bc733e8@app.fastmail.com>
In-Reply-To: 
 <CABuAATb5bKG+CwPME4jPwJfizw0FE1w3kJre4b2a21UGv_8f+g@mail.gmail.com>
References: 
 <CABuAATb5bKG+CwPME4jPwJfizw0FE1w3kJre4b2a21UGv_8f+g@mail.gmail.com>
Subject: Re: git whatchanged
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025, at 14:44, Grzegorz Koperwas wrote:
> I recently got this output from git:
>
>> 'git whatchanged' is nominated for removal.
>> If you still use this command, please add an extra
>> option, '--i-still-use-this', on the command line
>> and let us know you still use it by sending an e-mail
>> to <git@vger.kernel.org>.  Thanks.
>> fatal: refusing to run without --i-still-use-this
>
> I am letting you know, that I still use this command :)

This command is being removed because it was supplanted by git-log(1) a
long while ago. Both commands use the same machinery, just with
different defaults.

You can replace it with `git log` in this way:

=E2=80=A2 Given: `git whatchanged <opts>`
=E2=80=A2 Replace with: `git log <opts> --no-merges --raw`

Additionally for the sake of readability, you might have more
use for `--stat` or `--name-only` rather than `--raw` if you are only
reading the output (not feeding the output to another program).
