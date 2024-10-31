Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7771946CF
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 10:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730369301; cv=none; b=byCZeYNraJE8XXdy6pgUHYk2Nm9LndfV6cnJfJZhzlyn4+dU6Q3J0IqU1Xh5WfHt0YzLJfKkFeQXbvjYSYBw5/Oy/C1slHEDfqeAT0SB1MfXK+i2RIcKa5AQusDsD3NEv3UVaxDJPgw8xLlKlO1ao8LrUlV+N3DEJPsOAnmciwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730369301; c=relaxed/simple;
	bh=8PuGl+hrLHvffKENApHFppPX8tD8OVrNYhnx4ybTqYg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=XKtaMpWWZNB1tbDr09jOuQxSH5a568gEVgYbUk5TErS5tyuCVTtFKRrDDgzhk+0zHgvZm1w+85f6uBWFWfUjF4IVJHavRFMa3Zb5gmzaEWx94ysXqpjkuaAlwEif81Z3sfwjMaPJVUO4fb+eqYcmrEw1rh9Fh8v8jNB02wZmROQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=f0mBPXrB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JZuVsoxq; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="f0mBPXrB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JZuVsoxq"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 903CF254014F;
	Thu, 31 Oct 2024 06:08:16 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Thu, 31 Oct 2024 06:08:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1730369296;
	 x=1730455696; bh=JQognO7S3a6yh2dKndWEJKndKMwV8dFrfIlkE65P074=; b=
	f0mBPXrBrr1Bc5387M0cVoYl4KXgcjkvNN4srr/wP+RvrTqhdD+lF56Qh9i3whSc
	biTq759cRJFTtyk4ekKxMgNn9zJIp5gsUlGqyiAC1RwOEI9FrBg33+dUzWgyj+vi
	uAbjTKNlBg3T9QPTFH+aclelHClV6tCqn+Iq6T2wNXmOED0BH1imIuQsTIgLbsJ5
	cWbb7q5Htw2ygijuK8Fd7+kX8XYObfrHGkncUI46w3Ke1ou0Zs3Jr8ttfgWzkBxC
	p++xTZCUekAK4pE2qeEVVzpl9DJXcUhPt5TnOw9X5GewDNXGpnXW2cr+titGWC1+
	OMm7w7N42NExbA7cz0XdEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730369296; x=
	1730455696; bh=JQognO7S3a6yh2dKndWEJKndKMwV8dFrfIlkE65P074=; b=J
	ZuVsoxq5UNt7qaLcwsghdQm7zvOtqi9Kq8jwC6IN+rK8eyHuZQodchSfYBC7/RC/
	A06EdwH37BLjr+19RCQD+e52tQiJoyIBFsJpPxBJBw0Nuh6jMUG4TxxU57JVGwog
	zNm6tLy/sj5G7+3wBQox0xfhQkhv68FK1cIzGf4z6Ke0G+2L511E8msD2M4G6Jzv
	Mui1klFAtYaej3AigQOhiM1kxENXhuUQrmp8+zGzNjy6zhw1UKM6iI+Y+tlBp5vM
	60K4kPYFa+nqB+sDyLF5KKHV9oufrlI2R9M7UXWbzItW8ZVuByxAALwx894XvKmb
	vnIaCcu3dEQZXoYBs6A8w==
X-ME-Sender: <xms:D1cjZ7_pXE_nhMdH2SutkNYK31P7sIvheyh8F54aesT2C7ZnLJ4OS8s>
    <xme:D1cjZ3s8m6p3YiZUKr0UNsZgoHvILMCwoiwCYDNB07cu9MIdaRaGcK1HE8nE0_e_2
    a83kg8HiKueruZZxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekhedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnhephedugfevgfefgfffvdfhffdvveevgeehhedutedvgfeuffejveejudegve
    efvdefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdroh
    hrghdruhhkpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthht
    oheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepmhgvsehtth
    grhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:D1cjZ5CaM3-TEw4wR-AezWjNcpk1hCCylhY0Qhl4RpT7V6VT7K2_DQ>
    <xmx:D1cjZ3ebeSdxY-bQLwPejmYHsoKDKu6ljPwx-vaItYJNfGqkAVGf_g>
    <xmx:D1cjZwPga9DbBvOqtbfYAXCIGRxGxWtuC57LoLZzUK-hgs_Vr2s2Gw>
    <xmx:D1cjZ5mv20Yc8ub8xld0jjBpX3A1c44Qq8F5GTWh-F8sprZjFqUysQ>
    <xmx:EFcjZ9oE-G2jaa1IK5tB4kiTOXQKatKtrsHTc1dmC1fpA3LRPj7jgZav>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9AC68780068; Thu, 31 Oct 2024 06:08:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 31 Oct 2024 11:07:55 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "Taylor Blau" <me@ttaylorr.com>
Cc: git@vger.kernel.org, "Kristoffer Haugsbakk" <code@khaugsbakk.name>,
 "Derrick Stolee" <stolee@gmail.com>
Message-Id: <9c29cb98-541b-4a18-9936-81477c7c13ab@app.fastmail.com>
In-Reply-To: <c05e603f-1fd4-4ad2-ba03-21269f464ed2@gmail.com>
References: 
 <5267b9a9c8cc5cc66979117dc4c1e4d7329e2a03.1729704370.git.code@khaugsbakk.name>
 <ZxlEJ+44M8z03VOj@nand.local>
 <c05e603f-1fd4-4ad2-ba03-21269f464ed2@gmail.com>
Subject: Re: [PATCH] sequencer: comment checked-out branch properly
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024, at 10:58, Phillip Wood wrote:
> On 23/10/2024 19:44, Taylor Blau wrote:
>> On Wed, Oct 23, 2024 at 07:27:58PM +0200, kristofferhaugsbakk@fastmai=
l.com wrote:
>>> @@ -6382,8 +6382,9 @@ static int add_decorations_to_list(const struc=
t commit *commit,
>>>   		/* If the branch is checked out, then leave a comment instead. */
>>>   		if ((path =3D branch_checked_out(decoration->name))) {
>>>   			item->command =3D TODO_COMMENT;
>>> -			strbuf_addf(ctx->buf, "# Ref %s checked out at '%s'\n",
>>> -				    decoration->name, path);
>>> +			strbuf_commented_addf(ctx->buf, comment_line_str,
>>> +					      "Ref %s checked out at '%s'\n",
>>> +					      decoration->name, path);
>>
>> Makes sense, but the following command turns up a couple more results
>> even after applying:
>>
>>      $ git grep -p 'strbuf_addf([^,]*, "#'
>>      sequencer.c=3Dstatic void update_squash_message_for_fixup(struct=
 strbuf *msg)
>>      sequencer.c:    strbuf_addf(&buf1, "# %s\n", _(first_commit_msg_=
str));
>>      sequencer.c:    strbuf_addf(&buf2, "# %s\n", _(skip_first_commit=
_msg_str));
>
> Good find - it's surprising that those have survived so long without
> anyone complaining. There is also
>
> 	"# *** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***",
>
> in do_pick_commit()

I=E2=80=99m including an update to =E2=80=9Csay why=E2=80=9D in the next=
 version.

Those others look correct to me: https://lore.kernel.org/git/c05e603f-1f=
d4-4ad2-ba03-21269f464ed2@gmail.com/T/#mf299f1ac7bdb772b396068200d32b5fa=
c669fb55

Cheers :)

Kristoffer
