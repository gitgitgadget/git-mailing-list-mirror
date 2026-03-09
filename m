Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B6C2C237C
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 23:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773098416; cv=none; b=H1YudsfxHNbYX04pCO3zy+bNRDk6YoH4J4FJPxTWwV9IkUPtHkBdUqfELJwIcrI+LG+nJQ3o0D0A6/WhgEcwLjgEUASo9WVuyh3db7adu1RsVGYNdr3PbtW34AYTFrSCbjm2SwoxO7C1wbjiTwcka5Hj+blRmEK6ygrG+OAEoZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773098416; c=relaxed/simple;
	bh=XgdPBLSiX6cANpFlUHoNp9CS+Hf5a+FqMz77b7fJYYY=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=APVw/J5QmHZkUSus56HxG/VITngxU0yftzieuTNY0kin8YqeIzvSwad5Oavp/zOICQNi/gNQ2KLssVuHLome/MUHaCtuXl+HGBXZMe52yWTNP2sjO8XmbUpAEsWSeA/V3OC1RKkIkujbZIAG1v8JoOaJxfBIu+TB7uYbhs8ZhEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=eDGMc4I4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fwaWUrjX; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="eDGMc4I4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fwaWUrjX"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 4535FEC059C;
	Mon,  9 Mar 2026 19:20:13 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Mon, 09 Mar 2026 19:20:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773098413;
	 x=1773184813; bh=IYp4n7rpSJMke7nieAS72TXRB4pYa8R5b0EKUPozas0=; b=
	eDGMc4I4GLpecaGZNXb06/q1CxP3opfUBwbsvrbBwRnPqKYyaD5ozr222mX43HpG
	f8+Ako3XLZ89ILMuXLLggHIi47oF4Ll85CyYVs130X5Up+XvOtq4uGG+nnzaP+/p
	jSHwdndij5iS5J4jiweNY1zau8V02gwIBFiEqHJ5ZImb4SjhSXkLviZ89hP2/8WT
	gcYX0SvOXIhFCQJDPFHgrjvhX5yFZieXS5e2NHUjbR+SWdhkYnLq212Zo1nq5vyk
	EjfpJdWiZSRzte6/T15Qq0NV18cefHJfd2r9qsVywyZ0W8Iner0IL6gYrzMqMS9A
	8K0o0XJeb+yZnHrwI1VRCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773098413; x=1773184813; bh=I
	Yp4n7rpSJMke7nieAS72TXRB4pYa8R5b0EKUPozas0=; b=fwaWUrjXtSj7v3Ij2
	+AgVubW4q4kWWsPKgP+IYoa1Vui7MEqnHAJwQLZTgQR0QLxs0uUlCwZsPeIgjEg+
	CUlT+vit2ErLOXwjENnDt9w9Wkxn7mNe9/pG6UWgFNKhYx9Z+yw9LHyLIydGObbJ
	uI/nmTwIW5wA3wtEq6LMbfCbfgmaSIMLAvvao3MJQHdTIjVc1lGzlqz+s28HX7gD
	3jVnYbLeAkCzr27t0X4LvBxpbS3uBMvKE4zoGGP19b+oYQuOQkEnOEwkIOsE+TKK
	mPEw5Z4S84AhqtehBTbts7bb/LJPyV97bSfq6f7LJgtK4dkKgjwMb9gZ7+By9YHZ
	Yabwg==
X-ME-Sender: <xms:rVWvaVHX0KEGLcIX_wbWhSL5P436F0ewix5KCF-WJ8SB_rfiewKqaAY>
    <xme:rVWvaVJHmR87LJi3T7qrmmaMTJUbxJfug-JCOS9qg0j4ECjRcpGmVd-ukt9A1U94s
    g6ypMnOWLA76SoJv11NjQo_cdSOVwOnRGcPR9lmrurs5OUttmP6pQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeelgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvkfgjfhfutgfgsehtqhertd
    ertdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecugg
    ftrfgrthhtvghrnhepffeifeetgfehkeegieetudejgfevhedvveeileefieeitdettdfg
    udfhjeeigffgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:rVWvaby0s6Ma0BeXZITNLfFO38-EgWe_wdCdGE5MLLcK4quhlXCnoA>
    <xmx:rVWvaRMlD_VhfsgTKxGcPv1HxJyPP0Z61HljYhG5RNnTzmflwcOBlw>
    <xmx:rVWvac5YDISZH8wHb82i5X8ryo1lBKe-UAsSZ6Zw0Ofrlf8Wi5BOGg>
    <xmx:rVWvaSPPinDw8iVMTRTbDBWGZ2tMU9gbhTIN2f---8JpyrALwHdQqg>
    <xmx:rVWvaQ6Krr6NJvpcn6jNtzRDwCdRvyOC-1EorP8Gdhfx4QQd7MgfeRP3>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 06E871EA006C; Mon,  9 Mar 2026 19:20:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AbZw3T7tOYb3
Date: Tue, 10 Mar 2026 00:19:52 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Message-Id: <32e7a75c-f8c3-4a2b-8865-ab48330fd4cc@app.fastmail.com>
In-Reply-To: <xmqq34283b12.fsf@gitster.g>
References: <xmqq34283b12.fsf@gitster.g>
Subject: Re: [PATCH] SubmittingPatches: spell out "replace fully to pretend to be
 perfect"
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026, at 23:15, Junio C Hamano wrote:
> It unfortunately is a recurring theme that new developers tend to
> pile more "fixup" patches on top of the already reviewed patches,
> making the topic longer and keeping the history of all wrong turns,
> which interests nobody in the larger picture.  Even picking a narrow
> search in the list archive for "pretend to be a perfect " substring,
> we find these:
>
>     https://lore.kernel.org/git/xmqqk29bsz2o.fsf@gitster.mtv.corp.goog=
le.com/
>     https://lore.kernel.org/git/xmqqd0ds5ysq.fsf@gitster-ct.c.googlers=
.com/
>     https://lore.kernel.org/git/xmqqr173faez.fsf@gitster.g/
>
> The SubmittingPatches guide does talk about going incremental once a
> topic hits the 'next' branch, but it does not say much about how a
> new iteration of the topic should be prepared before that happens,
> and it does not mention that the developers are encouraged to seize
> the opportunity to pretend to be perfect with a full replacement set
> of patches.
>
> Add a new paragraph to stress on this in the section that describes

s/stress on this/stress this point/ ?

> the life-cycle of a patch series.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  cf. https://lore.kernel.org/git/xmqqo6kw3bjp.fsf@gitster.g/
>
>  Documentation/SubmittingPatches | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git c/Documentation/SubmittingPatches w/Documentation/Submittin=
gPatches
> index e270ccbe85..f6ec8a3dde 100644
> --- c/Documentation/SubmittingPatches
> +++ w/Documentation/SubmittingPatches
> @@ -43,6 +43,18 @@ help you find out who they are.
>    respond to them with "Reply-All" on the mailing list, while taking
>    them into account while preparing an updated set of patches.
>
> +. These early update iterations are expected to be full replacements,
> +  not incremental updates on top of what you posted already.  If you
> +  are correcting mistakes you made in the previous iteration that a
> +  reviewer noticed and pointed out in their review, you _fix_ that
> +  mistake by rewriting your history (e.g., by using "git rebase -i")
> +  to pretend that you never made the mistake in the first place.  IOW,

Spell out =E2=80=9CIn other words=E2=80=9D.

> +  this is a chance to pretend to be a perfect developer, and you are
> +  expected to take advantage of that.  In the larger picture, nobody
> +  is interested in your earlier mistakes.  Just present a logical
> +  progression made by a perfect developer who makes no mistakes while
> +  working on the topic.
> +

Looks good.

>  . Polish, refine, and re-send your patches to the list and to the peo=
ple
>    who spent their time to improve your patch.  Go back to step (2).
