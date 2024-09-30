Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD6B194082
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 21:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727730387; cv=none; b=h1znDbGYKsMAAEQWOuNJYWEPcxdHJHR6T0vYiO88u2mSpGOrxjq6wu70yYsq7X5U9MHV6Gw2zai8/S2Lqz9LAtQqH4Hzm6cXwOAZxPnrwyiPppduXtaGXYO4/1RNI+wlOssYjYhetYLOFdZ6QtZt4EEVIe35Jj0OFeXS+y/cpuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727730387; c=relaxed/simple;
	bh=KFM3kQt05tB2DccazmueSgYhYOpuRl5Yf1qMRNiNZvg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=h1Bn8Hkc3xpT3yr3H0KEp496+YTuQ15slTkH8cW14wZ5T7P7PkDOM3aWsx0q20H7UaZNr9T+qYrLTvAWY2p9zNZJjmGjQQj5OLNbaANwEaC1Ep9jdc5KHddZ1XhcEySy4DhZe1Jh9fOOvE8dsc+XZ2oET4/LgSgt1238i5lGfAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=OdWDOAMJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S3gGVzrJ; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="OdWDOAMJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S3gGVzrJ"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id D359E13808EE;
	Mon, 30 Sep 2024 17:06:24 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Mon, 30 Sep 2024 17:06:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1727730384;
	 x=1727816784; bh=YYp9q51tKZjGydvHV8B2lK5J3Hva040X/5stRzxWd4s=; b=
	OdWDOAMJfoQ9kTP2ITv+8HOqws2z1hWg5CAnksdre7sRrfBHQ5pW+LCldj2AhAA1
	W50bOlvXNXDW0QcXnVbRr4y9DKoknrJVrCLaqW2nZaLdDOLVvg4rDafCup82Hg83
	EHEZ0yH8G8dKugN6lcW8iUW6/XBslcxli/hh7fQ2b1EYFVVIy4QGMHV3OzITe/7o
	pE/ncGLRhKqDkFD0eLoJ2D2iMaEWlQH51osfF4O2vyiF3K8moQ244QehhcCnhyQA
	uFvtBgWQSWowhqq6Fumc8242ET9CeWtwUBvMmqOX+XoMyilMsxXAqHDt4rY2tGCZ
	KrLhjuYrKeeJf+Q/L1nZ/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727730384; x=
	1727816784; bh=YYp9q51tKZjGydvHV8B2lK5J3Hva040X/5stRzxWd4s=; b=S
	3gGVzrJlx9ImIyfUQNIdUmuIIYOaWuAxe6Rl7rqObhXCK4I4qLnMM5QV4fbqt7SL
	gy55EJb0Lb0AJCT6Mg3JOaQsF0vEFgJ+seArQSP77o2Fd6llkDe5A9G9GaNYSC7g
	WK09cmpk9gOd59Tv+oJk6Gjim2HqVgzRtbgkDulFIKJIQmvmzFKAUnrzkH5u9zPl
	CYIy+clko4XOTLPWcuh9ngW+91Wmct7ePyjACXLBUx+h/jdbxj1ihDrjayVzGfxO
	j49QgDkahk095bAtC5KCYc8bEOz+NGUP8yk3YhA0p8NvKF7sDvwmffX9jb9M1cGk
	ouyNmRY318FHoBWzvvs9w==
X-ME-Sender: <xms:0BL7Zmg4e13Kn326Q53hEE3qu1y9YomrzLehHNsAG9Hl6foS0S09lzI>
    <xme:0BL7ZnCQ-vl618ikPIaQt24tVbaj2EF6DaYRSEwqa0zdBZgFUn9ck-jegHOjGmHKg
    nPoNhoIovOnGLFSKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhedgudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffr
    rghtthgvrhhnpeehudfgvefgfefgffdvhfffvdevveegheehudetvdfgueffjeevjeduge
    evfedvfeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgsh
    gsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehnrghsrghmuhhffhhinhesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepkhhonhhsthgrnhhtihhnsehlihhnuhigfhhouhhnuggrthhiohhn
    rdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtth
    hopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:0BL7ZuF3FMxjfkQl4DtdSxcoWpUF7vsj4nTsWjybKh2r0L2wmYobeQ>
    <xmx:0BL7ZvScui4TYup05yIpKfISE5D7FoXG6wBvCr7e8IKgrggFX5inVg>
    <xmx:0BL7ZjzQqxNTJ0ndahzzdhZAKtl1FiY41neYhWWXhnIFxTb7zr-9sw>
    <xmx:0BL7Zt4tdD1AFte5tvhfg2KkOZdupPpbscMot3zBeM_JqnORD9tYqA>
    <xmx:0BL7ZlsxjPrQRJ8KD7XgN3iARwAYTeRwKd0ftE7Dtq94_xMjqT2Wm5M4>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8A3F3780068; Mon, 30 Sep 2024 17:06:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 30 Sep 2024 23:06:03 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Taylor Blau" <me@ttaylorr.com>, git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>,
 "Emily Shaffer" <nasamuffin@google.com>,
 "Konstantin Ryabitsev" <konstantin@linuxfoundation.org>
Message-Id: <ff2909b2-3526-4628-bb11-b3a09066a7a6@app.fastmail.com>
In-Reply-To: 
 <a4b1da93e16d88323181f8f8444f01d96e09ef45.1727729100.git.me@ttaylorr.com>
References: <xmqqv7yd548i.fsf@gitster.g>
 <a4b1da93e16d88323181f8f8444f01d96e09ef45.1727729100.git.me@ttaylorr.com>
Subject: Re: [PATCH] Documentation: mention the amlog in howto/maintain-git.txt
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024, at 22:45, Taylor Blau wrote:
> Part of the maintainer's job is to keep up-to-date and publish the
> 'amlog' which stores a mapping between a patch's 'Message-Id' e-mail
> header and the commit generated by applying said patch.
>
> But our Documentation/howto/maintain-git.txt does not mention the amlo=
g,
> or the scripts which exist to help the maintainer keep the amlog
> up-to-date.
>
> (This bit me during the first integration round I did as interim
> maintainer[1] involved a lot of manual clean-up. More recently it has
> come up as part of a research effort to better understand a patch's
> lifecycle on the list[2].)
>
> Address this gap by briefly documenting the existence and purpose of t=
he
> 'post-applypatch' hook in maintaining the amlog entries.
>
> [1]: https://lore.kernel.org/git/Y19dnb2M+yObnftj@nand.local/
> [2]:
> https://lore.kernel.org/git/CAJoAoZ=3D4ARuH3aHGe5yC_Xcnou_c396q_ZienYP=
Y7YnEzZcyEg@mail.gmail.com/
>
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  Documentation/howto/maintain-git.txt | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/Documentation/howto/maintain-git.txt
> b/Documentation/howto/maintain-git.txt
> index da31332f11..fd1560327c 100644
> --- a/Documentation/howto/maintain-git.txt
> +++ b/Documentation/howto/maintain-git.txt
> @@ -165,6 +165,22 @@ by doing the following:
>     In practice, almost no patch directly goes to 'master' or
>     'maint'.
>
> +   The maintainer is expected to update refs/notes/amlog with a
> +   mapping between the applied commit and the 'Message-Id'
> +   corresponding to the e-mail which carried the patch.
> +
> +   This mapping is created with the aid of the "post-applypatch" hook
> +   found in the 'todo' branch. That hook should be installed before
> +   applying patches. It is also helpful to carry forward any relevant
> +   amlog entries when rebasing, so the following config may be useful:
> +
> +      [notes]
> +	rewriteref =3D refs/notes/amlog

Nit: `[notes]` is indented with spaces while the next line is indented
with a tab.  I guess it=E2=80=99s supposed to just be spaces in this con=
text?

> +
> +   Finally, take care that the amlog entries are pushed out during
> +   integration cycles since external tools and contributors (in
> +   addition to internal scripts) may rely on them.
> +
>   - Review the last issue of "What's cooking" message, review the
>     topics ready for merging (topic->master and topic->maint).  Use
>     "Meta/cook -w" script (where Meta/ contains a checkout of the
>
> base-commit: 3857aae53f3633b7de63ad640737c657387ae0c6
> --
> 2.46.2.633.gf09c3c1769.dirty

It might be worth explicitly mentioning the git-cherry-pick(1) footgun
that Junio talked about in his email: you have to restrict yourself to
git-rebase(1) and `git commit --amend`.  Since git-cherry-pick(1)
doesn=E2=80=99t care about (respect?) this configuration.

Right now it=E2=80=99s implied of course (=E2=80=9Cwhen rebasing=E2=80=9D=
).

--=20
Kristoffer Haugsbakk

