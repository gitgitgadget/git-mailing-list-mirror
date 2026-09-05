Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6333630B0
	for <git@vger.kernel.org>; Sat,  5 Sep 2026 06:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788589931; cv=none; b=JJfnyKTyy7yPf6uYLvqTi20WpeGfPQyg7+LETH9KcLDPInxHDWHIMiskqL17Fphfj1SCikoBZ3EPBFCyrH1EI5+U8MEmzZ/qhUh88DS6fBQM3jAM78d+3U0gpJ8caqrp6nN5xqLK0oIJXV1IRsMcrJ49PFbceBQLQm8sTXxc7ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788589931; c=relaxed/simple;
	bh=zzPaINrokipOvgrWFhg6jReytZHm7ztw8cTjKNY3+Gc=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=cMTm+UyaZji1QmrNw54vtWCmLnVa5Gr4D7sfnkyBTtF0Cfsbid6SmdrKeJTP8jEmldlaZdjT6cY3omG/QGEkPxPr47gOxiZN3O78XaFMoxUeDw51tdk7wvG5B0uRafgF+dVRI9hWfCbiOeUNx7w0scFVSAhgufQ/S8mSOnDBEIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=pnZVGfEA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TOERAZr1; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="pnZVGfEA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TOERAZr1"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 88013140012B;
	Sat,  5 Sep 2026 02:32:08 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Sat, 05 Sep 2026 02:32:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788589928;
	 x=1788676328; bh=vh4pRbPTkYQDBwRSsU75awjfKVzFY9/AbUXcsZcSM4Y=; b=
	pnZVGfEAKLtck4y8tOBJ+VRf5Lh7cSJFzB/qcBX0cAPhCtBIXdqCGNtBmicy3vES
	VdHQBv5Wi5X3vE/J7C9dt8TcO/bl2vl2fHG1XaMs4I/Hh7PhlsI2b2DZ9XsIq7YD
	UsZJZaBNHogj/v9BIVYMriW8u81WaNDnB4f0v3qzTcnPHbp0LjgH4cq6zn8b6tiA
	/P01INCL2+gkZWTbijF1n8ip2HPgcBlgK74LDAOAp34fATN+Oscap0vlfoGTHgYO
	7xVl0iWhRdGeIs/slsAkanAND+BmWJZRbKZ2RxS0oJk/8lyPCFEnNEiDms8VWQin
	PrBUo3pTZYQcTc6HFOxAqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1788589928; x=1788676328; bh=v
	h4pRbPTkYQDBwRSsU75awjfKVzFY9/AbUXcsZcSM4Y=; b=TOERAZr193ZRAzkR3
	4rd+JUyhwgb1Aa3Y6uEFD4A1MzKjcqmIldwcVQcM6rLWz++ieegolnJlJP5WfjuN
	2zb5HtKWWq+ObWDGadRkMmD6OblID4ht+ElSvpYwbbiQKYeIk1AEyLIhFhlhVwL4
	6BkYAdCpvitiY8napTmCsQwenmzsIqUaIH7HL1HlTpJfpk64BMSI7BTgUqVFFz+j
	Tx1DHPj8d+Imrf9QtEXl8LNJKUsiZeljaDR5fF9JPmtWxqSCFu15UsrSq9Sh+A0I
	R6ZFXItqz3NV1AVnv+dQme2T2y45SWgHc2jQHLuoblNjzBZqFjsNm46+FZJ/oODW
	MmT3g==
X-ME-Sender: <xms:ZrebairVnL543I2HkP2ROznt2ATe-90krJOa_CqmVUgRAHQzdfyH3Yc>
    <xme:ZrebardSkdpjQmo1VTbAjQA4_7f6hebx6duoyoAVAtNTR7SsJmugyTE2xFzzr6oqw
    AlIdgOGtX_2rorIUoCXnzCywh_erxHO75tSi94aTsc1YTtjx9hJaBo>
X-ME-Proxy-Cause: dmFkZTGp4w1KJHj8wuG5As7zjMO1DEMz5lrIuCTluP8Fuq59hxcjQcwk876jtpVjr479b4
    YgSSoqCDTB8J6rJyMKSL9ZiJWQ6uYoffFEMs73bDz4+C1qFKB+Ff/0sE4FlP89Sk676VcF
    I4x0J/zyAxgN6LV1Cj1CvsS1RSKuYkKT0r3HIH10EIcGz065+tbEdQfAuLE10BEQk6kvrY
    Yh2epqMiwy124BHLrzGjkm2kDRVFQnbYNfYqE64/Ie5407BYnHEHWNFhNvu3Na46yyazyw
    tkWA+GZNtNNWJpLNtHNr3/7Kfkr3wcss/3gK3ibIzEU0p47Fzmb06XAvGHN1pbbmPE5gDu
    VArppp8Efu0FWR2DFBz3rVBwGHDKSwgwEUD61DafuR/Hr5979Z9ZuDhdnLpuZsbIq7Xy3l
    7V1+CYEpPDz88gTR5qlWxW0tRPbUMJbF1z9AIdMqCMfxmi3uVx3x9axCVZg3FG5aY0iHt/
    ghfrn8hadp6KuTwkCE5k2oRZO5bs9LARaHvuVeHVjMLquCGEkt/SMf6y2r8urEqwLWNBdM
    JReVXklGE9UdrmEPtjG6X0j/1PCzCN44n9TjIYhfTWRsX3JwfUVVC5I3H1jE8hZxdqM2l2
    cfyFYVqXq8jQNlf/K2C+fpTv3T6DYX8pE/4aAUO483CM5ql+yfPIxTvGp41w
X-ME-Proxy: <xmx:Z7ebarjT5GeXpHjNIYF8qta-8hO6sx5a5Rf2MrY7eTZT2X6YjbfR5w>
    <xmx:Z7ebag_zC3rthWAA90979u47XD-S8T13HaasRsPJbWaQPjImVq8t-Q>
    <xmx:Z7ebatDi4WR64y2wWW8ECngt2sYTHRO-phpPc6L92AlmgN9pL1RysA>
    <xmx:Z7ebalIlSTkN-FHHTcSpgg1g8y9uBJAgnlN1vq15EtH0OaArcsD3pA>
    <xmx:aLebaqgMNeo-io-5xbQX4Mz_R9j7CM_Jh0txm17b7ySFN1WMkYQCnePX>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id C460C22C007D; Sat,  5 Sep 2026 02:32:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 05 Sep 2026 08:31:47 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Message-Id: <d19e3ab8-f003-4c05-a09b-de865fbe8962@app.fastmail.com>
In-Reply-To: <xmqq7bl03723.fsf@gitster.g>
References: <xmqq7bl03723.fsf@gitster.g>
Subject: kh/format-patch-range-diff-notes
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 5, 2026, at 01:55, Junio C Hamano wrote:
> * kh/format-patch-range-diff-notes (2026-08-24) 3 commits
>  . format-patch: learn --[no-]range-diff-notes
>  . revision.h: rename struct member to reflect notes role
>  . format-patch: simplify get_notes_arg parameters
>
>  The 'format-patch' command has been updated with options to
>  configure notes specifically for range-diff output, allowing them to
>  differ from the notes displayed on the patches themselves.
>
>  Retracted.
>  cf. <9335a35f-e9c0-4e62-812c-e5855c201003@app.fastmail.com>
>  source: <CV_format-patch_learn_--range-diff-notes.c57@msgid.xyz>

I will make a draft update of the doc that wasn=E2=80=99t clear. Then we=
=E2=80=99ll see
if an unretraction and new version makes sense.
