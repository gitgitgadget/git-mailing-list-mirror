Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6FB3A838A
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 08:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790669364; cv=none; b=j/qSUUYUPN29zBc6fEBnHJrSJApr00Knk5rd5J+cudFsZUVuGXpO4zebtJU2zdwxOm1GvqKMFIRIDJnxBQMkC9fRmMkOg7Ge6xtO4H/YqbFL82f6xJP8hOS1XxNOxCpYFhABwUSNLS7Dt+o425kiTpN7fk64RhRnw1HFOvKaYwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790669364; c=relaxed/simple;
	bh=mrvgTox/KwVz/IpXr234ZFCaCWXyUWwGQQBC77cUqTQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=FEhoak7VnLFR/t5oqW2zd93AJszt3fOak+r0AxR7nGr7sU6PngQS8pFeGpFnCfJbaXV4itsCYENmOll1yuRwue9Y2NvH8G7utezG3fBykWWLU1I3iAH6alsQqYi45TUYjI0XcqZr0sTobNQ72V/8t1OUMBIKUT+b6T1C2YxVVgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=D4THeXMg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z5eZ/kZp; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="D4THeXMg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z5eZ/kZp"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.stl.internal (Postfix) with ESMTP id 082811D000E0;
	Tue, 29 Sep 2026 04:09:17 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Tue, 29 Sep 2026 04:09:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790669357;
	 x=1790755757; bh=hylMiWlC9AcoDa20GvZOEe+v6hSHFR2dfjvQcBQTcag=; b=
	D4THeXMgzenI5GJKV/pR6jJZypiEZAm8dGCqlGU7BJp2kjfaA6A/Hdmgy68TmH+b
	MLFwE86Vf5JDGtFOCNLdJLZKcQ1wEjwO5A5Ql3XOYT2OfKmQA76B69WkJJ4vSdUq
	vbLR6tr0SI+nqZzVhRRkUVqwyaU4Bbpos3if/5VykPgtuvcHHFyQNYJNPsHPLTFD
	9bYvVGEoDLjQ0cOlBBYGnhPjdqNMmO9kSu2lzhLSQkbxQRLAwChJ8WkDbHqZUGf2
	EjAiJFIl71T17j1CcA1t//uq/SQJQzqyICjiibE9bk3lM14B86hyHhCaYR/T/MaV
	zONe9mLKeCSpKwWaXqQqew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790669357; x=
	1790755757; bh=hylMiWlC9AcoDa20GvZOEe+v6hSHFR2dfjvQcBQTcag=; b=Z
	5eZ/kZptGp8NGuwEb4kQpRQiXoCwgB22FQjPWZGvKeOGHS3DUoHJHq47mjamGn3E
	ui/4nkokSUVqbGt4SoHBPZXhay84jGY1+p4yHY/7P7/pjFoWegEW5lW9cpNVEXkc
	T3ClVikr6kunlplG0PPrsrNUtyVqgbbYWjNl27wbY9kWVOUXmTNAOe816ZGDDP6b
	vqZ+SXGkk4jXj9oVKZD9SLZ4/4MuAMV5v0MaT0fLsBgN5lErA2lpT6ca3DP6DuLx
	Nudw4NXFFkYj7fyXnTGU1pi6fKrBzVg223jTBKLXGvvxNccceUckdWZYeMD+v1T0
	BAMVsCawY2+gt1eVIZ6Vg==
X-ME-Sender: <xms:K3K7as6J-9HAcqhvR-nlRWZBGoBkmDGeBTSbUj7hHKA63wNO6pzi4-4>
    <xme:K3K7aouUX-8fj1pitfxF2iMoy4n8kCPA7Bb5U3z86HeAYytkEilh89n6h9SihpzTa
    bBCyXawamgRY07m6caYYiBvLNxp9OiFW93AITN5CuWVRbIVpXdlICw>
X-ME-Proxy-Cause: dmFkZTFUmAEeiLVyaSyVI8YHSCuiP1vcdY6EoD12S6fifAl+I6mkqx9QeZ9q+E4x9i34mM
    CpGjqPC3SttRGcrxZe1XeXF/nkBEI/jb/HtKvjYuvSGR4kVEXL34pz6stK9avPrIfjd/qZ
    htUmJzW5aF3at02wmkwy3KQMwD+trTzm+iOHQ/FCdaFRaMrpNes9Isylbe7ec6HYQqOvDD
    rG9IbbBEtmhcItgBijX3meOlf/YtDYwoRaFvGNyL81oTEiHofZVJ3mcRwsVNP4SmcAIreh
    fUneMXAXfICL2Rejq9leY9SxzzTNVnRnvS9KpLyTGeqdcAmFdQxKYr8QgP+M37+ODrZ3ds
    k76acduZ9czKsLCbkoEQAQQeFOhcJeeThoULJsSHC5KI2oo/XO+3ovQRnybEn4RmpQWnBu
    tbFIeq57ZhN+x+ChT4n4HYEAVYp3G/UmFJ9t0X+78nRuFxyqYiCPchFUtiDplRvCyjUf8g
    3UeCYgsUTCVBfnSmACJek0USprsd7k+mpKog7Fj3AEpy7PEUsD7i7oT71emKSn60nhSPNR
    GrKpbpejwJIUO5miaDv8iPj5/gLt4YSpEt+UkGjO7k00mGQV45JceJAFtYSt2ssYo+Pv/+
    XJDlv5cTvCjpmjXmB6qyiHX7fzRJl4LOWFXUl6x5V6G3zlMrpL5Euqc6ypEA
X-ME-Proxy: <xmx:LHK7ajVsOv7OtKm5fvrsuQFQltNOUbAHz70Q_Z53crbZWXd_MMJf2w>
    <xmx:LHK7ajU0vluRJC2Gd1hj-Q0MFmyHFNRaaAP0s4sgRahW7ueulDqUfg>
    <xmx:LHK7aidUIXRoS4uUCUkMjFx7Oe0PIUY9CX7JpxMsHtaCJHlVHzTIDA>
    <xmx:LHK7asVfUdTY2kAO6xePm7DSsqAoZK5PdLA8qifdm0BVeB95x0BxQw>
    <xmx:LXK7an0bT4ScupBhiK9pOGJWZHSyIB0Vvtt6pzgp2kDRq0b2aeLReIgK>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 2466522C008F; Tue, 29 Sep 2026 04:09:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ACf_4gHdHLcR
Date: Tue, 29 Sep 2026 10:08:54 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Harald Nordgren" <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org, GGG <gitgitgadget@gmail.com>
Message-Id: <d4fd92ea-b1c5-4528-9e9e-0b1ab600891e@app.fastmail.com>
In-Reply-To: 
 <CAHwyqnVf_D3qV1OVYiCnLz2tVteRXdWYTGBaNTJpkVtDwCC1vg@mail.gmail.com>
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
 <9a6bfc3c-8759-4fbe-9e90-5dec9d00e278@app.fastmail.com>
 <CAHwyqnVf_D3qV1OVYiCnLz2tVteRXdWYTGBaNTJpkVtDwCC1vg@mail.gmail.com>
Subject: Re: [PATCH] branch: let --delete-merged find squash merged branches
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026, at 09:52, Harald Nordgren wrote:
> On Tue, Sep 29, 2026 at 9:47=E2=80=AFAM Kristoffer Haugsbakk
> <kristofferhaugsbakk@fastmail.com> wrote:
>>
>> On Tue, Sep 29, 2026, at 09:30, Harald Nordgren via GitGitGadget wrot=
e:
>> > From: Harald Nordgren <haraldnordgren@gmail.com>
>> >
>> > Branches merged on GitHub with "Squash and merge" or "Rebase and
>> > merge" are never deleted by "git branch --delete-merged". The upstr=
eam
>> > holds a rewritten copy of their work, so their tips are not reachab=
le
>> > from it and they look unmerged forever.
>>
>> An example closer to git(1)=E2=80=99s home:
>>
>>     git merge --squash
>>     git commit
>
> True. But likely it opens up the question of _why_ would anyone on
> upstream be doing such destructive actions? Well, then the answer is
> of course that millions of users (including) me do that via GitHub all
> the time.
>
> Maybe I should include both examples in my text.

My *guess* is that `git merge --squash` inspired the forge squashes.
But the forges popularized it.

The apparent `git merge --squash` approach of using `git log` for
concatenating the commit messages isn=E2=80=99t that nice in my opinion.=
 So I
wonder how much it is used.
