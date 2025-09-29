Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6B72236F3
	for <git@vger.kernel.org>; Mon, 29 Sep 2025 18:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759169616; cv=none; b=CeTmzIgj1nymsSJVkBfSwONivBXv6IxnHuywr3wP+DAO6IKwBR680yGILogv9q+2aKTsMJEV0Y5sbgO0GM/hHu51gSx/UQrqWCi2zsZ80BJnM/CegurdvyU8ESlvY6S908rFUucip0jHIWt9Ib/IS5r+HRQg0L40aYJlivj9Ev8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759169616; c=relaxed/simple;
	bh=o8mxx5vBc9NuQH4F5nIqRKOHDuY9ymERoXKtvHlRo5o=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=WH8qFDbFpQgFcQ5RpUKyluLpFmepbMtrlmsVfzGFztJJAuJtZoGxuLdHGRMS3zRHpyYOxI9f9/C3paO7tq1V1qrCDsspFg3WboWkeIsSSV/vVBEVtBbyIc55/N4yA5FXg7i6bHX0SoOIYmsVYSPHg5Ue7O3JwOaVPk+5QCqmHcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=sObEdMZY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EuhImE/P; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="sObEdMZY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EuhImE/P"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id AEBADEC009E;
	Mon, 29 Sep 2025 14:13:33 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Mon, 29 Sep 2025 14:13:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759169613;
	 x=1759256013; bh=qbz7g948bWhqdW99bOv5m/qR/lMkevdLpUIKMDzpYPY=; b=
	sObEdMZYXwjnvRcvL4xk0uKoEDWrLHLYhuoMpmJ7LirdSjtFcpJF77udSnqPvOEJ
	F3G04KkCVxkPl//UZph4G/52TDz5Mk/FXwN+hIWMB6Gl9HfLaTufq3kcoUgY2Cf4
	V5yoxzYfz1ruyn3vcoLUM8Xl04rlGntUoop0KIToAl+5AFC9EAdb+y185x1/5TMi
	iNIppBha6pwFtOkp1Ju4DtHKgG5+iv0ZA9xuOOpuDwhDhK0dyi8Kg050CDIndVo1
	LXvSGEJhU7oqjFaIhqHkn2kT4ZCT/V5YR+y421F+jJFeGO+pifdxfxp10TaZBLYp
	LYjqO+RTFrFxg0KTaJ5d6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759169613; x=
	1759256013; bh=qbz7g948bWhqdW99bOv5m/qR/lMkevdLpUIKMDzpYPY=; b=E
	uhImE/PcxQ6Db7ROc+U9oWOjlJCpRUA60IyBOWpavsaYYo1Klrd6EXDSbQnz/Nyy
	mV8glaime3FxO1q6o46j91la86ciGUpu9m/NnOTespMZDiTmAbBUm+b9aUc9SH7M
	wwMA3WJSQSeIwA83o64A8R54VxuM7xpHoqu1MdVCKp6/d5ptl3W5TytSBf5FV/Hv
	Q57bfgt13kvSeK3hmsGy42syEz9v92vuHfod46xF9clSM6BmlZ+2rnYIOZEUuBcc
	2+bIA2BiYxjV/eY03HdNpA5PUC6TAdqyLZWvGAAQ0h6Jq1OK6L235qT1IV0nCs07
	Ub4vbdU/j/KhDGnxfmvzA==
X-ME-Sender: <xms:TczaaN_mth2mpQ76B6yFiRJP5uwdw2jtDCcizWs2NPcNvn1OAYz7VJ8>
    <xme:TczaaMh6bw1RB1NEUHnZV_7F4-iYFzPZW2MxMr-6Jm7sVYMZvGAMljGVz06OODzPq
    ejErWk6QyI7o-dnUEYjUtvY6Ctd_L8oQ1459eLrhzNqLPtPewuxkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejkeejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeej
    hfehuedvgeejkeelgeduudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:TczaaP48e-yUYUipUuqXwqDXBdGlLuWoc46DpQyXsBJLvP3yfgLSFw>
    <xmx:TczaaMqvN9ANb10pNBq1SPT-55sc_nyosWvHsf432U5uVm3rAOuZ3w>
    <xmx:TczaaJjQPlRa232vWIMIiUydze-FdGlESa9_4b8lLAmgKDyCbmeRZg>
    <xmx:TczaaOLh2HQeowV3tsQDhPPQ85bQ60tyLRh9MBXmUpvynpCeq8vGsg>
    <xmx:TczaaDQNtUhdVv3zBsgtqIRpWJFXoAgAG78yNYYEeDujCHXFaR6130Fv>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 586991EA0068; Mon, 29 Sep 2025 14:13:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AlH9lrHFu41k
Date: Mon, 29 Sep 2025 20:13:12 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Cc: "Julia Evans" <julia@jvns.ca>
Message-Id: <5fc9a038-584d-4bba-8960-fae843421245@app.fastmail.com>
In-Reply-To: <xmqqbjmydw5i.fsf@gitster.g>
References: <xmqqbjmydw5i.fsf@gitster.g>
Subject: Re: What's cooking in git.git (Sep 2025, #10; Thu, 25)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025, at 00:06, Junio C Hamano wrote:
> * je/doc-checkout (2025-09-10) 7 commits
>   (merged to 'next' on 2025-09-23 at b776ac7a24)
>  + doc: git-checkout: clarify restoring files section
>  + doc: git-checkout: split up restoring files section
>  + doc: git-checkout: deduplicate --detach explanation
>  + doc: git-checkout: clarify `-b` and `-B`
>  + doc: git-checkout: clarify `git checkout <branch>`
>  + doc: git-checkout: clarify ARGUMENT DISAMBIGUATION
>  + doc: git-checkout: clarify intro sentence
>
>  Doc updates.
>
>  Will merge to 'master'.
>  cf. <236a79f4-e9a2-4335-bbff-79ae0cc67e9b@app.fastmail.com>
>  source: <pull.1962.v4.git.1757531669.gitgitgadget@gmail.com>

There=E2=80=99s two small syntax problems.  You might want a small commi=
t on top
of the series.

See <df251b0c-c593-41ed-903e-8fb1c323b874@app.fastmail.com>

--=20
Kristoffer Haugsbakk

