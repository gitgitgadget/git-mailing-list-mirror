Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E632F50AC
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 15:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752679745; cv=none; b=NQtE0NrX7QNMo++/qlghOa9yFBBVVw2lvqrCtGGIRhW6ZD8HOo5fQZvFbg32erHeOZzbJpYnFPgaVcPxtwV47JCbVkdrgzHjdyOQhdeIuBWkvsAfJ1zGlWPbNpKt0QdUG1czSzxxx7SVN5X6AVDj3DGTjUE5rQF6aTeSItPr2m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752679745; c=relaxed/simple;
	bh=7QfGQewnv/iu78XbOXQr7BatsPUcbKz/IW52H3erTHo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jMIyGhns7lDlTCOiAI8UrMH2fVd59zJ273anmN/vSWJf8NoDwa3DgoGO/UTcomZy+KXP4j7FJYEcaxfh1+g2ogrrrXmABtMLDS6M1CvIn459aUQ6C0LN9yDeUsYpO5sVPTXBCtrDb1JVsoM4J0fB/XD2pSbrKzr8GrIMKNfW8uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AjhNw/v2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PW7BqYh4; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AjhNw/v2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PW7BqYh4"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 4534F1D000ED;
	Wed, 16 Jul 2025 11:29:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 16 Jul 2025 11:29:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752679742; x=1752766142; bh=qboY3K+1bx
	fNYB3/ff664hYFoT+sAk3frxwK28ggLPE=; b=AjhNw/v2VjsuxAhpB4zpM6y9n6
	Ra0Sp6WDt0VlTDSHaVauT2hMpBVgedU8ZQnrA8wQCg1NlUKYHgT+CqCH+u1EBgXJ
	aJIbId96owq7rNQE6owSBH7nuZ2I9kPpsPLvDe1WfBe3gLe2tvBDpFowmHN14nTw
	HDraq7yQjDXyznpWPJf3eUvlIeYtVxVhW38EoBZQB32vDLY+crBuWR1DV0QYbyBD
	uQl4q6Wg69xsIuRG576LjD2myrT1L4/+yJhaPeM58TVZlgDeZ7eE2rxGNEFX1Nhn
	Dqbo60alzpReTWBcpcRZSyEiuhONSIVP1ikSaPIvEO5s9cTQ3fUbNKxt8kUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752679742; x=1752766142; bh=qboY3K+1bxfNYB3/ff664hYFoT+sAk3frxw
	K28ggLPE=; b=PW7BqYh4kQEPSlzC/iGeoQ8VePooEi7Zqm8To19WdpKNfE+i1xK
	cJdE0iLru2m7AgsbcNP6IvXEUhXk60uSXpv8N7mBervobaUlV2xaM7YLLHTtToE2
	oW+2xs9AAlDGbSk3EJvI1hqCT10PABHRkZ68si4uUj+n23TK3WnpTVTbq1u2SU4N
	JeW+6/JrW1xvepSnekxtfTEE5DniQIgPHBsSwqQEmnpmzg7Jg1ploRAONiQXWCR0
	vd6W7TGtoMuogyyXHKGDnwCJaVOUTTUeoBaaR31HZ/rFf9RwtlmTaeyjVm9Nv+u7
	azMVapsy7E0+MX+ULk1n6CuQPeunOZ3oTfQ==
X-ME-Sender: <xms:PcV3aJxjziggfupl6IVnKTnWc6T3knTJFRJQtMKhzqBI6AwSBJlcSw>
    <xme:PcV3aG1tctQzEmG3PshHBddfQe5zOHD2P8f15b9SS457rjfEOFxnDzGFA86jXx6jd
    nSqE1XnbDnD-3mUsQ>
X-ME-Received: <xmr:PcV3aJzzMzgRs1ytFO78T_ZPHJmP-ht-Q-_84Sl9Iyn-uVxg45Fw379Z9Y5xIFnfl-BDtCJNtTgsPic819zdXFr68PR24Ir0tgILwSI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehkedtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtoheprgihuhdrtghhrghnuggvkhgrrhesghhmrghilhdrtghomhdp
    rhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhh
    higrmhhthhgrkhhkrghrtddtudesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:PsV3aNG1gb5laKN9-SJtl_cZuN-Z5vbh2MLX6xlbg6RuOS4fTh_jPA>
    <xmx:PsV3aMaPjdM_UZGjOnDU3-pk0Try5CfmlP8TlsRRGlGhRcoKyWsyMA>
    <xmx:PsV3aPB21PTGACYHnSTKIhzaZCtxQHw1mgx7yf_TZNErmhnvy3wDzg>
    <xmx:PsV3aEk_-3Rxs5_0Bi_t-pcKzelpp2_-Cia_fM_hDS8JEcw4QT43lA>
    <xmx:PsV3aFji_CbknYY1Wn9b7h6L0Sg7njY-sigS88fHYg5Uz4D9TsXFicET>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Jul 2025 11:29:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Ayush Chandekar <ayu.chandekar@gmail.com>,  christian.couder@gmail.com,
  git@vger.kernel.org,  shyamthakkar001@gmail.com,
  kristofferhaugsbakk@fastmail.com
Subject: Re: [GSOC PATCH 2/2] config: set comment_line_str to "#" when
 core.commentChar=auto
In-Reply-To: <b16c6f79-c021-4068-9c95-09625ca058c7@gmail.com> (Phillip Wood's
	message of "Wed, 16 Jul 2025 16:24:29 +0100")
References: <cover.1752602474.git.ayu.chandekar@gmail.com>
	<2a3c2d323bdb520a37a099b361be9ec5f2d5d46f.1752602474.git.ayu.chandekar@gmail.com>
	<xmqq1pqhgnby.fsf@gitster.g>
	<CAE7as+aN+j4CteHUrr+R+CbZ=qi=mehYW2xQEG4ZcQYvXqJsaQ@mail.gmail.com>
	<xmqqcya1f2vr.fsf@gitster.g>
	<CAE7as+YxajFO0FfMe2wYpT9okYQoevZAghDD29d7E0P82-A_Hw@mail.gmail.com>
	<xmqq1pqgduvo.fsf@gitster.g>
	<b16c6f79-c021-4068-9c95-09625ca058c7@gmail.com>
Date: Wed, 16 Jul 2025 08:29:00 -0700
Message-ID: <xmqqseiwcfyb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 16/07/2025 16:21, Junio C Hamano wrote:
>> Ayush Chandekar <ayu.chandekar@gmail.com> writes:
>> 
>>> Yeah, Phillip should actually get the primary credit for this patch
>>> and Suggested-by does not do enough justice.
>>> I will send a new version right away.
>> Thanks.  Don't forget to ask him to sign-off.
>
> Here it is
>
> Signed-off-by: <Phillip Wood phillip.wood@dunelm.org.uk>

Thanks.
