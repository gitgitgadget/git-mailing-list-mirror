Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF9E2E7653
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 18:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765304992; cv=none; b=kKPkwBxalMddfeolCuLxZYdJyZyL3diLJLJn1O4uEi51MFlRoCeGs2570m46w6YBMbTxTYq2BSENPpic22wMDWUS6PQOvL+vSZflk7x05Gj2Kh9aA9jfw8MtHHBiCsQkl/MysfgTLksfEWeNKrAkRQzrjQBlU4W64Di1gES+Erk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765304992; c=relaxed/simple;
	bh=2CMwQBCnhHm26aX2JJHxun+2K7MJIm4sDEKhNwE+F+c=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=HSCUD8yaCplw8PGImn2JMdtIw4fdEnLMjrZcdjfH14Xk3vj+y9zpCKkEMnU2tk15Z62PJdlVGAFnjfiw6h63Jz8DfASI753f9OkhIT6W3z4W96L4TAAlrlJ6GfzIbY+bVK5QMBhE/LtJbnG/sHAjS4/+gSfx6mN2AssWwXbqkcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=PNSXNqGk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pUfJpswm; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="PNSXNqGk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pUfJpswm"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 2CC2DEC04D6;
	Tue,  9 Dec 2025 13:29:48 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Tue, 09 Dec 2025 13:29:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765304988;
	 x=1765391388; bh=O6uAKjlJdPwVqovdH61WolhFBaSKZpUpvyCKeFoZWAY=; b=
	PNSXNqGkpDhl82LY0HhppS+hEmZpxyQP/pM7GlTwWaKJAfEKmt9pVIMa4dbhaX1Y
	ISilcg1uIcIl4/NzTDPq91iBDK1XDXW39eZ0qxX7wV4QrELztqFFqMYIeQ4hpx06
	xYzrMe2sxOHFtEnoqt28n4SWW3jFS+lGesxT2DKlD6tTfJBssXlmkh5z26oDtrUP
	+Y+3EHuNk7wDPqSrlha/yN6OD0JCexNfBYWbs1Z+l19gafIfoklXte9HGzqeQlIj
	Dbb0Mj0ZWdiK/WEl8WAcKbYUjNZlzPAKhuTFVxHa2nYdBVibH3C9VovGsHcMnT3+
	fu0RQ8rDzK6LsZTA2PsaUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765304988; x=
	1765391388; bh=O6uAKjlJdPwVqovdH61WolhFBaSKZpUpvyCKeFoZWAY=; b=p
	UfJpswmeFVR+K40osT0CIvEWfmldwyR2KN4ysXNTiqxsDgO9oS/WboQ+23mEzztF
	ecVi9CDOeULOHgwB7IHyGWYzxtvLocebhE8C9tPXyrkiEX3IG1DdrFa7qUIGx7hG
	WOzOhDOWJ0W/9TKY6wC8oZIG8OpL2BjsZ3b95aIdFu1JIGT5mCPWrCTXDErwgYs1
	S/ko2gOgYXBDFZ2KghRSGrNS1lGk+aTNZez2b71vGymiUvwyroyWPOemGauxu0kK
	f4hB2Kf0JkwH5u930qRj81/TGgl61TM9GIIzzTV2YKUfTHakDKO1IFLNdL2YAfsu
	WE3jlzkshUphrNrYj/1ug==
X-ME-Sender: <xms:m2o4aR5hhGJItCfsx0Qay5g1C-pZLnhtQJL3KhUy_dLNT66UlousO1g>
    <xme:m2o4aZsh1UhWoXFRTrRFVjOsCYK5hhPv5zMWhmds7dTwOGIBNcTppn-JSwEXAAW3M
    tgEF5G_3Ll2Ff_pVL-XueFzey2t-WGq6sD57sJr7czWvQPzrQ2d0Sw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeelheelgeekgefg
    veegveetgeelieekfeehkeekvefgvdffteeufedutedvgfdvfeenucffohhmrghinhepkh
    gvrhhnvghlrdhorhhgpdihtghomhgsihhnrghtohhrrdgtohhmnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruh
    hgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedutddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpd
    hrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    khgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehmrghrthhinh
    hvohhniiesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdr
    tghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepshhorhhgrghnohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    phhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:m2o4aXcKSjEnIzXABXUwQTMHWfarD_3qC3AuP_XBTUj4eYfgLLbteg>
    <xmx:m2o4aak2v7XuvtsgOgmE3Fsw87Q3Bf8b_z86vUkbCWI_gtfvixyofg>
    <xmx:m2o4aX2TVPg9Nt4_RP5UJJqubCHEVxgUztqwQMqJ64x6naS9VIsvCQ>
    <xmx:m2o4aTeDgamhFyF7717IO61dD0T7LMZPh6ncPgkUe7RxkFwli7ZuIg>
    <xmx:nGo4acqY4d_mDish8hwx4QDIwqLeFjq-u-fEOQZlmLVSw_eLBl3MqbCO>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CD5AA1EA0066; Tue,  9 Dec 2025 13:29:47 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ate3QFRcz-LV
Date: Tue, 09 Dec 2025 19:29:27 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, "Elijah Newren" <newren@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
 "Phillip Wood" <phillip.wood123@gmail.com>, git@vger.kernel.org,
 "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Sergey Organov" <sorganov@gmail.com>,
 =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>,
 "Martin von Zweigbergk" <martinvonz@gmail.com>,
 "Karthik Nayak" <karthik.188@gmail.com>
Message-Id: <b3ddfaa4-526b-41e3-b12a-0fec846ac7bc@app.fastmail.com>
In-Reply-To: <aS80z0DxAEBLba-M@pks.im>
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
 <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
 <CABPp-BGLrVv=maEqhs=j9MmST-F=K=XN6gGqmd9Hox5QRDMiHg@mail.gmail.com>
 <xmqqbjkw78jj.fsf@gitster.g>
 <CABPp-BG+2+vanKAS-cwAD2XZxwx=PPcu5OG58ys+8O7rfZEhug@mail.gmail.com>
 <xmqq7bvk77lr.fsf@gitster.g>
 <CABPp-BEyMFiRdHoseTaYG9rUFO6Ta=dBG88CGRb3CfNf8aSAkg@mail.gmail.com>
 <3fb47b15-ed43-4137-95f8-cee97ab5e44c@gmail.com> <xmqq7bvj5q8m.fsf@gitster.g>
 <CABPp-BEVX85xZ7_1fSfW4-xJod13p2-HvQ-e5ga+m9-Sq7mbdw@mail.gmail.com>
 <aS80z0DxAEBLba-M@pks.im>
Subject: Re: [PATCH v6 00/11] Introduce git-history(1) command for easy history editing
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025, at 19:49, Patrick Steinhardt wrote:
>>[snip]
>
> I'm not sure whether that is something we want. I myself have the same
> commit on multiple branches quite regularly, as I tend to queue up
> multiple dependent patch series. But I wouldn't ever want a history ed=
it
> to affect all of these branches myself, I really only want it to modify
> the branch I'm currently on.

Let=E2=80=99s say with the current subcommands I want to

=E2=80=A2 Split a commit because it contains unrelated formatting fixups
=E2=80=A2 I want to fix typos in a commit message and also add a paragra=
ph

Then let=E2=80=99s say that there are three branches that contain these =
commits.
I can=E2=80=99t think of a case where I intend to only make these change=
s for
one of the branches.

A default of update-all-branches-in-range seems like the best default.

I also agree with everything Elijah wrote here:

https://lore.kernel.org/git/CABPp-BFtx7-vLFbVqbHar=3DUZb1CGX5=3DufMA4hrJ=
RkSYuB14_Tw@mail.gmail.com/

I haven=E2=80=99t used Jujutsu yet. But apparently it is much less
branch-focused. But for us who use branches and sometimes need
=E2=80=9Cdependent branches=E2=80=9D or =E2=80=9Cstacked branches=E2=80=9D=
 the default equivalent of
`--update-refs` seems like a win to me.

Okay, maybe let=E2=80=99s say that I am really making intentionally-dive=
rgent
histories and one commit needs to be reworded for that divergent
context. That could happen. But I can=E2=80=99t imageine where I would d=
o that.

>[snip]
> Consequently I'm leaning more into the direction of doing nothing. It's
> not really clear to me that this is a bug, and we still can introduce a
> flag in the future that opts into the behaviour of rewriting relevant
> branches. That behaviour certainly can be useful, but I'd claim that
> it would be rather surprising to the user if that was the default.

Maybe it=E2=80=99s surprising with the current defaults of other command=
s. But
for a new-and-better (for some circumstances or all) commands defaulting
to updating all branches sounds great.

I have read or heard about the =E2=80=9Cmega merge=E2=80=9D strategy in =
Jujutsu.[1]
Being able to (this is how I imagine it could work) make a temporary
integration branch where N branches can be edited by making edits to
them and having all the branches be updated sounds amazing.[2][3] I have
found myself doing temporary integration branches where I make fixes on
top and manually cherry-picking them to the correct target afterwards.

=F0=9F=94=97 1: https://news.ycombinator.com/item?id=3D44650248
=E2=80=A0 2: Maybe the commits are =E2=80=9Cedited=E2=80=9D and then the=
 integration merges are
     re-done which sounds simple in the case of splitting commits and
     rewording commit messages. Well, =E2=80=9Csimple=E2=80=9D, that=E2=80=
=99s easy for me to
     say from the peanut gallery. :) (I am aware that git-history(1)
     does not support merges in this current iteration)
=E2=80=A0 3: I am thinking of the =E2=80=9Ccommon case=E2=80=9D of `-upd=
ate-refs` but what
     Elijah pointed out about =E2=80=9Cother interesting topologies=E2=80=
=9D sounds even
     better. :) In the link from above:

     https://lore.kernel.org/git/CABPp-BFtx7-vLFbVqbHar=3DUZb1CGX5=3DufM=
A4hrJRkSYuB14_Tw@mail.gmail.com/
