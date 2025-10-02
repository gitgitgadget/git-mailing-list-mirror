Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C7B1DB54C
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 17:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759427504; cv=none; b=n1BvBglDqMWKLArwWKGMylQJWPShGQkD514O3uCDiq8nJg5aMWw18bkuX5/70GhB5UkqXf6pgVTaInBj3tpsMsl4Uwd1x+1+rhGW+/23twFsD4g8v8/dDI0kz9HcQCJM6ieObUJEvA9EVSP0i5S/avs5xoVpTNIdfIN5TI4Kg08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759427504; c=relaxed/simple;
	bh=DBZ7TvUKXJ8T/OaPVXOPs+mgomRVAFpGadgAsmTP3NA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=p087Of2lDgS5c3sje2GC7oOzQPrUlmI6apYO3AfZQYaySf6qzvj4P0tR0ZwRz6/WCc8Zf+KIRo5BPBqUOrupPNNOMZFT5iqTuXPvhYKd3PI0dd2VbuRFDH2PUrTVsZrku7mVuj3fqaNyPLWkz6VAt10k9rdooHoR2RZz+EaI4JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=sv76RkUy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mNo4Ah7D; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="sv76RkUy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mNo4Ah7D"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C342F7A003E;
	Thu,  2 Oct 2025 13:51:41 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 02 Oct 2025 13:51:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759427501;
	 x=1759513901; bh=eAWEH2y2WgWorqVw0B1JzQeNuhbMVXhfIOFpZHY3MZo=; b=
	sv76RkUy/FuqZ/nRNOPCxYNDCHu+9EGAy5U6i1+skHuU1ZB2ZV9hjS+3SEV6GKvc
	90VdqlW4Hb4jhdIKZgQM67K/aObq5+QcANtqHzsDiHW/S45kKPWGZPYoE0+83zFv
	/3HIo7Xo0s3AxPbDqyMbdZI753IUMA0EHVAy3D9eps+fUlr5V6CWtoiaD7Lii52O
	k9Z4J8bTKuTwK6DpRESg1rOsTE2+uJ10XIp1X9hJxAhgDJ/5bO6+F6G08juetrS+
	1HeH4Q2IsWCs5BxTkg71NDK4URF+L3Gyth+bwtoTNLfToSJVE7aG47pzh/iEOlmP
	Kto+dm6MfDTDISRKOTB0jA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759427501; x=
	1759513901; bh=eAWEH2y2WgWorqVw0B1JzQeNuhbMVXhfIOFpZHY3MZo=; b=m
	No4Ah7DXA7qVwPrjkrFmEuiSmVFe/YVcFl75/VD12iusqLW1c1QED3+wSQzO+T5Q
	zZY/tbBdz/OK8ukwqVA9jxqA4xYOp+tR60MDoNQR8e5t0OryjrIEvfQ4Q91LtE39
	1Md+53gri99ACD0ayxhC+diUwKRGI2DSzpTVOqJ8rAHZizp0lJ2kVlWRNxYOkh1g
	zgc8ZBez7tkUhvJHcpE9Jusj42YeiXZSnGRs/6bUrdBP1UAbSDwCKctECEnrzxDq
	w7qndjwhzZiIrHtEDkwOgqRLyAuSFdSkYuS494/ClNdbkbjldpxu+y9xsgOTa1VW
	i0DL82FS4ZsTIBMCvVO2A==
X-ME-Sender: <xms:rbveaBerPM6QCIKOYjoU-EE54EuhXEsFKSpK7jTNFymM6n_O7bDoKG4>
    <xme:rbveaKBWTtg6Dbq-KGBQDc1SbprcIiZOt6N1rRAqJmx3zuZyrOMoTzNfiPZAmUyVd
    tSdhdJ72IyVEc-Zl2pHGsKt30t4ro2dexBBc-omYdmFhogsdtMXeg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekieeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeej
    hfehuedvgeejkeelgeduudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepkedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepshhorhhgrghnohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epjhgtuhgsihgtsehjtghusghitgdrphhlpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomhdprhgtphhtthhopehjrghsohhnuddutghhohgtrgesphhrohhtohhnrd
    hmvgdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhr
    tghpthhtohepmhhsuhgthhgrnhgvkhesshhushgvrdguvgdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:rbveaOx2vMJ05BFsYS4IkoOIBxnrqI7X67tOp9rpMjD1C7yForbsUg>
    <xmx:rbveaETIj_v7GdG0Am46r8NzDInVP3EugX9DS0D3SEofnEHJ5Z84Ew>
    <xmx:rbveaG_rEwlgQnCEOuZ3iRYZZzVk107iEfPh8bF9IPQy3gWy4cu2_Q>
    <xmx:rbveaCv2DPCXBhVS46vtxwk-mn0J2kIXu0A0nAgWhdEs8SY9bu3jPg>
    <xmx:rbveaAzk7EllMW4bNUGNYoeT5YRELFp1n8q5XX-1YYM4XBoBiBeMiY9G>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2BBC01EA0068; Thu,  2 Oct 2025 13:51:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A98-iMmoqE87
Date: Thu, 02 Oct 2025 19:51:20 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Michal Suchanek" <msuchanek@suse.de>, git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>,
 "Eric Sunshine" <sunshine@sunshineco.com>,
 "Sergey Organov" <sorganov@gmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>, "Jason Cho" <jason11choca@proton.me>,
 "Jakub T. Jankiewicz" <jcubic@jcubic.pl>
Message-Id: <dd4027d1-4148-4171-bf17-b5c33881a446@app.fastmail.com>
In-Reply-To: 
 <1d5b41562937d83be261d054989b04db6cb94a86.1759420102.git.msuchanek@suse.de>
References: <xmqqseg1xwc1.fsf@gitster.g>
 <1d5b41562937d83be261d054989b04db6cb94a86.1759420102.git.msuchanek@suse.de>
Subject: Re: [PATCH 2/2] doc: git-worktree: Add side by side branch checkout example
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025, at 17:51, Michal Suchanek wrote:
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>

I think this could do with more setup and motivation.

I=E2=80=99ve seen a lot of questions on worktrees where they introduce t=
he
problem with =E2=80=9CI use a bare repository with worktrees=E2=80=9D.  =
And I was
puzzled that they kept using bare repositories all the time.  I=E2=80=99=
ve
forgotten some of those details but I do seem to remember that they were
motivated to go all-in on making a ton of worktrees, and using the the
=E2=80=9Cproject root=E2=80=9D to do it.

Is that what the bare-setup is getting at? ;)

> ---
>  Documentation/git-worktree.adoc | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/Documentation/git-worktree.adoc b/Documentation/git-workt=
ree.adoc
> index ec31863aec..122b191ff9 100644
> --- a/Documentation/git-worktree.adoc
> +++ b/Documentation/git-worktree.adoc
> @@ -525,6 +525,16 @@ $ popd
>  $ git worktree remove ../temp
>  ------------
>
> +Side by side branch checkouts for a repository using multiple worktre=
es
> +
> +------------
> +mkdir some-repository
> +cd some-repository
> +git clone --bare gitforge@someforge.example.com:some-org/some-reposit=
ory .git
> +git --git-dir=3D.git worktree add some-branch
> +git --git-dir=3D.git worktree add another-branch
> +------------

This works for me.  But why not this?

    git clone --bare <repo> some-repository
    cd some-repository
    git worktree add some-branch
    git worktree add another-branch

> +
>  BUGS
>  ----
>  Multiple checkout in general is still experimental, and the support
> --
> 2.51.0
