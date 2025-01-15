Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175601553BB
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 17:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736962869; cv=none; b=T5gRybTYWkyWeOL1PWLthPVA8vV49e29QYkOEpHOnFCSD3IdCB3ddpcO4ksDfLlnKFEMSZyU+8f10EOkIaTQ36L5n4CB8PBWBZYwUGOrhUjZ6bRI88SjZ1toFbtDjPtMma3/jD5iKl8ATR6/sL6iEUPtS1G6nZvXIc9MislCkA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736962869; c=relaxed/simple;
	bh=ei+kl7ZIQWCUr3n6J73jw4zAytM/9hSLbeUh3PC6mrg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=DGrumOtVCnwHmrm/mg3wt5eq7h/ds2CP/uL2TouYEqwnIB4Wl+7b+dKJ7bS6bcfhbHmuTiON9IWcvkQsfXnjTKVMsuVEMoULZr/0Jo+9wM0B/eavhN/shhnMHVLKTAfuZl/FbAcfGnzAZrNwymdUzxGJKPzVyKZnRpQ2+dRKHsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=NVymc/7U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VFwhVOKO; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="NVymc/7U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VFwhVOKO"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 2C5B51140190;
	Wed, 15 Jan 2025 12:41:06 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Wed, 15 Jan 2025 12:41:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736962866;
	 x=1737049266; bh=7zZFcbVVKlgYyZLhb774Q0CxS3Web0LIlve1Xdf8kjQ=; b=
	NVymc/7Uz+kVjbuhTIdVy65cqC2pdMlg3/LWcC/iR92C9OX8zJHVMOLB9vqgCxUb
	5r8OsdliLKSXiKQGDK+Bo8njo3zfZGtLJf/WGDghLS+cj6R3elehOjhGevmgRWN/
	Tf9lwIt3X3zWjggTqbt+PnFyhPTXRud4xx6hpniZ1+7sagg3kgANVftXx2oLVxKE
	irKo8kHxQHCg5jIBbAF+GYHxm6ukg9gwgV4kAb7P8to6k20084g9V2N29LvdnO1w
	l+gTSzVx8OUjqPudnLFMyCr6FpXQw+K4T6k9/xp2lzkAlaJUeNX/zTfQmKFCzkM/
	bFzmhi0ie9lPd1NefS5ClA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736962866; x=
	1737049266; bh=7zZFcbVVKlgYyZLhb774Q0CxS3Web0LIlve1Xdf8kjQ=; b=V
	FwhVOKOtzf+oru2AHBArMSAXjeW4PJY1fSvz+Q+k/Ebc3E/Vow4Vt4hsRYM12lTM
	yye17HztiI41VG9uN7GlYYsIoLQU/1ROtY5Q9GhgJPj404mqhQ3rh2dBims4/ZjJ
	jwWwz2xXV3V51lGd1S9GRZr5HEiDgDOoFQ39IhkG2KTg5yLbRYIK86tP146Dsq8Q
	8R50Dl/RoO+RJTBItQPNBvHnFn0v7vn65MP8Ca/XZpVJuKgzU/0mmRTuHeRkHAI7
	Bb/D7qLAXbXhEgfMfMCeDjLaoGpiOtK/6F8e/74+VdL2mJgIedBVX7IOg7uRHNkF
	1xKBkRrN59E919xud3jtw==
X-ME-Sender: <xms:MfOHZzxY9VT0eyX1-LcWXwJyfbxSXzG-LV4deILFUmMfS_JDC9XM_g4>
    <xme:MfOHZ7SVAkEFsvxR3ePfE9UZG3DvELTTri00HgdNW3tg73j38Wd-SzLwUyoecKV5s
    SYVIQji62Zz5HExxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehledgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnheptedvhfelhefgtdeugfefkefgudefgeetfeejheehkeduleelieduheefge
    ehhfevnecuffhomhgrihhnpehgihhtsghuthhlvghrrdgtohhmpdhkvghrnhgvlhdrohhr
    ghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrh
    hishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhohiflhgvth
    httdelsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:MfOHZ9XN6RFFFCAdSi_w17uS_7o6mof9iXl4aL-IHbcHsEVP9ztteA>
    <xmx:MfOHZ9htuWpnpogOt0DM6XVqxCDqsni7xZaJMKyxmU8oRwsQwjbIJg>
    <xmx:MfOHZ1CZB9k3sdi1kA_bcUg0_KAQg6cVu8ShFes-0d1YyfftelGhLQ>
    <xmx:MfOHZ2LDoHKawZ-eNWRBiDx8ztf_r1KkkCTEpCwITvQwjfCMvNZZFQ>
    <xmx:MvOHZ4OAjkcVMhehK16ZAORWNqif-1b-HDQY9eyJOGRF4Yx46kqAylYS>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C387E780068; Wed, 15 Jan 2025 12:41:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 15 Jan 2025 18:40:45 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Chris Howlett" <chowlett09@gmail.com>
Cc: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Message-Id: <4a396e63-5e82-4ce4-83c2-13d508cb1f7f@app.fastmail.com>
In-Reply-To: 
 <CAJVagJ=3uxcCpEivkpW5_HTxdL9Sa9Ymqm1iJQHUJ+=9XneLSg@mail.gmail.com>
References: <pull.1852.git.1736933815236.gitgitgadget@gmail.com>
 <1c220376-4b4b-425f-9797-abd1728aacc2@app.fastmail.com>
 <CAJVagJ=3uxcCpEivkpW5_HTxdL9Sa9Ymqm1iJQHUJ+=9XneLSg@mail.gmail.com>
Subject: Re: [PATCH] help: add prompt-yes setting for autocorrect
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025, at 11:21, Chris Howlett wrote:
> On Wed, 15 Jan 2025 at 09:51, Kristoffer Haugsbakk
> > [snip]
>
> That's unsurprising, as I was inspired to add this option after
> reading that committer's blog post on help.autocorrect -
> https://blog.gitbutler.com/why-is-git-autocorrect-too-fast-for-formula=
-one-drivers/
>
> I'm happy to wait for their patch to be merged, then rebase and rework
> against it, if that seems the most sensible option? Presumably I'll
> have to monitor the mailing list to learn when that happens? This is
> my first patch to git, so I'm not sure of process.

You can keep an eye on the =E2=80=9CWhat's cooking=E2=80=9D emails.[1]  =
The latest
one mentions this other topic as branch `sc/help-autocorrect-one`
(that=E2=80=99s Scott Chacon=E2=80=99s initals followed by the topic nam=
e).

If you want to wait for that one to get merged:

=E2=80=A2 Wait until you see such an email with this =E2=80=9Cstatus=E2=80=
=9D under it:

       Will merge to 'master'.

  Which means that it will be merged to `master` soon.

(Or maybe run

    git branch --remote --contains=3Dorigin/sc/help-autocorrect-one \
    | grep master

from time to time (I don=E2=80=99t know, I=E2=80=99ve never had to do th=
at).)

Or else you could build on top of it.  That=E2=80=99s more advanced thou=
gh.
Not something I=E2=80=99ve done myself.[2]

=E2=80=A0 1: Latest: https://lore.kernel.org/git/xmqqzfjt2qye.fsf@gitste=
r.g/
=E2=80=A0 2: See `Documentation/SubmittingPatches under =E2=80=9Cselect =
few topic
    branches that are=E2=80=9D for how to depend on in-flight topics
