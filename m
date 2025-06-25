Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133651F3B8A
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 20:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750882785; cv=none; b=dBg/f87pirHjje/9rNLm4vZwhVE3ZznuaUYu7zrJxq+NCc2AG+bA7Lab4VDu79vl+gk4y2dPnT8Wjg8HIEjRzlZlMpSd/96l78OUFqOJNnUz/1nJLViXbeSLbK/P7mp+GqNCU4TWasBL11P0jZ/p+foTkkj1wiZlmeebLF970ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750882785; c=relaxed/simple;
	bh=vLQspK/zsAg/NBI6eyI3BP20aUNhIXZ+B+kwRgnD9FY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=dLB2Qu3jWVRqziBKCNZxwlIlzPY+cKGvgKIR93XM/yJYjUufywlzsr91limDYeFo2EqcTKkcj3cAfBRF7BfAdZshBbnVi64tmy7Q3PODiqthb0sJ2sIHecMLeCBXdFGhmRssad7BTrQWaHJ0uZPvlrCILhy1Tm29dbFvACYacNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ERCKD3I/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y2n96ji7; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ERCKD3I/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y2n96ji7"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id EF9441D00036;
	Wed, 25 Jun 2025 16:19:41 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Wed, 25 Jun 2025 16:19:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1750882781;
	 x=1750969181; bh=fsvXs1Vcu6Nw0cEwrwqK9dRdxeYChfisuD/6FMtQ5Vk=; b=
	ERCKD3I/14gjMtRQWFaGa+kUbCoU52JwQtMDk9GTL+Ocp11GSC8rd+0agkoiOJrv
	YeeXePlyVl3S/Gbgx1Bzj4oI0ZM5BwYbvorJbtkhtR9yW9xfpI3RwtABS4erqJOk
	dGR3eNUTXc1g/LEdJuYtpSqvC/NlzUjS8p6KOzChhWtyCd9LFZXNEgk2oVhLOxlw
	pg+tHDYlRf7Hw409NqfsKaQrU8UPdAmvohCSWmhfyU/EKitT5FU0xTMAkqbvQqK+
	w5MmK1Wd2Ms7z1KavLqZzodLlxh6DmiQ66ko9YW8xtjKIAuBp/S3nB0NEXiVHfPR
	+JVROB/oWqw6HX7zylVJyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1750882781; x=
	1750969181; bh=fsvXs1Vcu6Nw0cEwrwqK9dRdxeYChfisuD/6FMtQ5Vk=; b=Y
	2n96ji7PYlxSq7vymCWVytODdy0ObzuxAWn46bv2NFDqUFFjrqRhVmIQ19hsNvjy
	y/qm+jy8T14/bxWj0cfzd4TJQg6cFa6JWdDpvI4eFpVacvzLA9vHG5E/CHA5bAFz
	ds+FDIUW9DnJ+oVqoypgFM9n7kMoARMCp1ABChkabA+2cGqGWIl4oR8zGXy25MiX
	PbuxKuD5BxwTWsFHRgFH8sjmr5/B6yWcnBofwYjTdTWKkxAJyAGMfdPsJPQsTYo+
	WwgUI7ahHfzEUzvKGfcQqPdWdIv57IFmiP/tuZR2eT/RKBk76frbobPjJEIyp5CB
	CsTT4uvnAszSnZ81vWZEQ==
X-ME-Sender: <xms:3VlcaBRWrjQ4Ga47YxdEjifBK0lYUB16mdiLBJG1tsC9Kt35k_q4Jh0>
    <xme:3VlcaKy69gkNMm77J6_T8ZnpHPaN85F1uawr8qlNDazg3eNThgeOWPSCEYL54-0tq
    IzexxIykvWb-TRLng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvfeejudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeej
    hfehuedvgeejkeelgeduudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepgedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghl
    mhdrohhrghdruhhkpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehophhohhhorhgvlhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:3VlcaG1btB8ZuXVd4npE_Hm99tt9XXS1aaMhYAL_qxszmoAnrvUBQQ>
    <xmx:3VlcaJBHTp004dyxL3WDu8-CIhpecoM9Cru5Lvx0tFoAnp9urW1mww>
    <xmx:3VlcaKico2PdLTJVUYuROidypZ2uRTzQ0V8k8L9vl4HqbrYuSSV4PQ>
    <xmx:3VlcaNo_Lwfa0uBcQ8TMY-hwEkdD088PCrm_q2rg_Wu4hMNFUShSWA>
    <xmx:3VlcaC7R7Ahzst3e8zu_nG1op_URAhVG5CCSGW67aHrcbk_0GzPlDyAm>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1975C1EA0066; Wed, 25 Jun 2025 16:19:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T38185b1eafdd6744
Date: Wed, 25 Jun 2025 22:19:20 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 =?UTF-8?Q?Ond=C5=99ej_Poho=C5=99elsk=C3=BD?= <opohorel@redhat.com>,
 git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>
Message-Id: <71204f81-3281-4089-9e9e-1a81a73c8d41@app.fastmail.com>
In-Reply-To: <84eccfa1-88fe-43b8-a839-61ea4fa4e4e9@gmail.com>
References: 
 <CA+B51BHEB24JNzOroTxFodxiuPJ1=Vj7KRFevrm2YatnTVuoYA@mail.gmail.com>
 <8515698b-4ab7-4901-bacb-1c47180c2530@app.fastmail.com>
 <84eccfa1-88fe-43b8-a839-61ea4fa4e4e9@gmail.com>
Subject: Re: bash: unescaped `>` character when switching branches
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025, at 15:57, Phillip Wood wrote:
> On 25/06/2025 09:53, Kristoffer Haugsbakk wrote:
>> On Tue, Jun 24, 2025, at 14:59, Ondrej Pohorelsky wrote:
>>> Hi,
>>>
>>> Our customer has found a possible issue when switching branches.
>>> Output redirection character `>` is not escaped properly when
>>> switching/checking out to different branch.
>>>
>>> Steps to reproduce:
>>> 1. Create a new branch and switch back to master
>>> ```
>>> $ git switch -C 'issue#1234>/tmp/dangerfile'
>>> Switched to a new branch 'issue#1234>/tmp/dangerfile'
>>> $ git switch master
>>> ```
>>=20
>> It=E2=80=99s too bad that git-check-ref-format(1) does not disallow `=
>`.
>
> It also allows `<`, `$`, `&`, `;`, `(`, `)`, `#`, `"`, `'`, '`' and `|=
`.=20
> Our ref format is not designed for them to be used unquoted in the=20
> shell. I think the problem here is with our completion script not=20
> quoting the refname, not the format.

On Wed, Jun 25, 2025, at 18:38, Junio C Hamano wrote:
> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>
>> On Tue, Jun 24, 2025, at 14:59, Ondrej Pohorelsky wrote:
>>> Hi,
>>>
>>> Our customer has found a possible issue when switching branches.
>>> Output redirection character `>` is not escaped properly when
>>> switching/checking out to different branch.
>>>
>>> Steps to reproduce:
>>> 1. Create a new branch and switch back to master
>>> ```
>>> $ git switch -C 'issue#1234>/tmp/dangerfile'
>>> Switched to a new branch 'issue#1234>/tmp/dangerfile'
>>> $ git switch master
>>> ```
>>
>> It=E2=80=99s too bad that git-check-ref-format(1) does not disallow `=
>`.
>
> Is it?  It looks like an outright bug in the completion code,
> nothing more, to me.

That was an aside.
