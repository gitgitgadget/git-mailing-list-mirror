Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9D350EBFE
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 13:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790688725; cv=none; b=dOUqvcJP++wUGfQvYtdXnXmMaJUMXcO7oxOxgZhHhZ8LKlHABSKzwSuwGsblrOhcW+B5qtQGu56hLdBG9vpNIdKMWCSu/Tusyf8T6MPqXQ6SkuycFPslMmB28eREjpOHt2LaUJt+U/7AQpvk3dvBbKxbPyYOBj/+LCoK2b93gbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790688725; c=relaxed/simple;
	bh=tk6LagBzV09rSyBL/e+61VUri+UwwFwF8WpIA/YD8cA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=KLr46CZf/YZBdnGIsZc4LrUyAmP/Ls+tHgu3V8k0kPMLbhvsWtHWaEftCNelf4v5upmPTIhFvsNLi8Sr0MtjWL9rtT57H2fqbJ2+/vCZBmR3+5y6uD4R4dSNMyp3c8Qym2A1W5UMDwXI+XdqZtzlDGaG8ZS2ciQ9mNmh+GVd2dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=dbHYzl5B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q2cE3v4P; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="dbHYzl5B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q2cE3v4P"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D30BE1400512;
	Tue, 29 Sep 2026 09:32:01 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Tue, 29 Sep 2026 09:32:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790688721;
	 x=1790775121; bh=9poK8pdvBviwThY514f+ELwtBu6tZdNfJIr9Ovqt9OU=; b=
	dbHYzl5BgTP4oxXeSrmtHta0/aKNU/xqltBlcrit9DxEtYfAbz7wH2LDJuxo9gYX
	O6y8t3ozPCOr/yDMhB0yOm7ICura72g79IeNVHRFzOZk2BURyndWxj2EL7vnyzLn
	qmeGSvsW3ELkA4rQxUNK2GBoGzMoNqFrUZ0aI8Yhw+4cwj5rJrB2LO9HnRgBDIhd
	vkExBF3s3Sdcx/y35LEkuQOJalgUVVnxbB4JUp7xuvzGQC6tbcYLRvou3lh8IHoQ
	5sNRmUVIo2V0JSGvDWrROJVAKLYx63ybpMBk08Ey1hH1hcoR2E2/S0DS5/qv19m5
	gbRPBR+zXTAwWaHcgUO76Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790688721; x=
	1790775121; bh=9poK8pdvBviwThY514f+ELwtBu6tZdNfJIr9Ovqt9OU=; b=Q
	2cE3v4P0tT0/ZkeO32gQ7sIAOA0K1ZuScHZ4Ecc+JJO2TaRU0+El8qOsF0x+ehi3
	LniEX3dcnh+wU80YptyxKani4A9pDqp14a70G49D5kPNX25X7tXcE2CnK1z5WQdZ
	lTaYhKSsnqCrER7Ca8IcEsDVxLqERHr9Itft0yinZnP6/nGj6G3Ghb6+vK4UO19v
	GyNGUFuSJjawhv19SSSbKnR+JNOqxenbTy8HaybQn4CstSx37mSNHXTKYoYFQhGu
	QyHh0J8ZvBZF9rGYKqzr2ylc+0lHTKzUXW5rPKUOxrCzbd+bNrR8tW1y6+q5ZMUR
	lMjCblwFt2h1P6EzbygGg==
X-ME-Sender: <xms:zr27au4wO3Be5YsC1PuEBs4X-W6jaemmzbxUGS5mo6GFlLAL-meCJ40>
    <xme:zr27ait9IFI3f-OEJlRc_gYOCN0lykxwXwYkkIQAddCPJFMSIbiNge8Ncz-21bnMx
    bbm1xUZSgRTY8lLwvvdHqBWmiazEPICI7gHWIcDDClKQWesfj0SBw>
X-ME-Proxy-Cause: dmFkZTGkO72623jTEB2JnzXI5pI/be37Q1Xh+gCL7n0nFl+8Yf3BdRy8AkQahGYwf7m7fB
    F+963poQWqB1P7kaWvjtfdjRL4woRcYkZO13qt6XIu5K3olllpwweo7SrfnaKlFiO2Gpv9
    K+gHdevrogM6U7G6LVwsn7COFwbYAIitBMpzkSGRgusNnY4AlYUs8t/ax2/BzeuyiXW9WW
    7RMxo/PSIDe3tjnz2u0ZkSGp7aVb4wUNhenva9rojqof3iwntIIFVA/+vpcM8uht4W/dxg
    BHXnb/wIyhnl73PhKUg/IsIcML2ybaVjc76LSyfNIhdFZU+yFsf18zHfkKP4bV7M1ORmIV
    IhrTUhsjaNSi+kt5Y6ggOyBAgCFe88W/cIw2XIWEKvz+wFHXTlxo0HwkM+2hRAor4f8ifs
    bT7p5237vAATGclML29XLJoLuMNhgkPgfn3B9lqlkolzuV4JPzWLGJdKSBBhEwzAkRh8Fw
    xO+PMucSReS8YiVy9oo8XLoTLU57L0/doyer+cvXODQw2bQ7nzjUi7BDkCrRMC6jw7a2yv
    UbEo5VxJETbAELVzJlhKZqRQHjrm8bjws/0kO55Jt88CrIw9Cj0Ut/iJh04akSCQzvhZAU
    gAZScUZ2TfnniDFh09CA2YygpNt8hJevYFKQppTivHHYFklWMc4EBJ7sYD0w
X-ME-Proxy: <xmx:0L27argSbIUkOJHKEBYll-JK7VD2-fhX8KOqgWtbi9CbfuYIFdRq4g>
    <xmx:0L27al1WlZKZqw9fNs9KYK9hX7feTF6DHj6Iudp-ZP23aEdCisMKPw>
    <xmx:0L27aliJKoaVKCsS6R1igq3gMwCRvdRr18PiNv9m_aONzn_OMuwzlA>
    <xmx:0L27alfYN5Ou4cN21iCV-WDTQX6vV_JGWij3-ruN5t16ES2n4Ip4QA>
    <xmx:0b27auhe0ep0xnB1z5rLYwu0pClGXFngAK4HvlKAEkKk1lU-Neyh77_5>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 9451022C008F; Tue, 29 Sep 2026 09:31:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ACf_4gHdHLcR
Date: Tue, 29 Sep 2026 15:31:38 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: "Harald Nordgren" <haraldnordgren@gmail.com>, git@vger.kernel.org,
 GITGITGITGITGADGET <gitgitgadget@gmail.com>
Message-Id: <4c4fba69-e474-4ee3-8e34-73e76d42d3d5@app.fastmail.com>
In-Reply-To: 
 <CALnO6CBq5Udc1rbk6efRj1q5pJNUDt-uvmSGDDen=CMH0dFOHQ@mail.gmail.com>
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
 <9a6bfc3c-8759-4fbe-9e90-5dec9d00e278@app.fastmail.com>
 <CAHwyqnVf_D3qV1OVYiCnLz2tVteRXdWYTGBaNTJpkVtDwCC1vg@mail.gmail.com>
 <d4fd92ea-b1c5-4528-9e9e-0b1ab600891e@app.fastmail.com>
 <CALnO6CBq5Udc1rbk6efRj1q5pJNUDt-uvmSGDDen=CMH0dFOHQ@mail.gmail.com>
Subject: Re: [PATCH] branch: let --delete-merged find squash merged branches
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026, at 13:18, D. Ben Knoble wrote:
> On Tue, Sep 29, 2026 at 4:17=E2=80=AFAM Kristoffer Haugsbakk
> <kristofferhaugsbakk@fastmail.com> wrote:
>>
>> On Tue, Sep 29, 2026, at 09:52, Harald Nordgren wrote:
>> > [snip]
>> >
>> > Maybe I should include both examples in my text.
>>
>> My *guess* is that `git merge --squash` inspired the forge squashes.
>> But the forges popularized it.
>>
>> The apparent `git merge --squash` approach of using `git log` for
>> concatenating the commit messages isn=E2=80=99t that nice in my opini=
on. So I
>> wonder how much it is used.
>
> The same behavior is present in GitHub's default squash merge message,
> and almost no one I work with bothers to edit it.

The asterisk bullet points on GitHub are better than `git merge
--squash`:

    Squashed commit of the following:

    [just `git log` of the commits in the range]

> It's really sad to lose the opportunity to have good commit messages
> when using squash-and-merge on a forge---not because we *cannot*, but
> because the defaults do not *encourage* it (and we all know how
> defaults affect user behavior!).

In my opinion squash merges cannot be implemented in a good way, in a
way that leads to good commits. Fundamentally not. It=E2=80=99s the butt=
on to
both squash =E2=80=9Coops=E2=80=9D and the incremental, valuable commits=
, resulting in a
blob where even a manually written commit message cannot document all
the changes properly. And the reasons why are laid out in your article,
I think...

>
> Anyway, see https://benknoble.github.io/blog/2024/08/02/github-squash/
> for a distillation of my thoughts from working around folks that
> squash carelessly.
>
> So, anecdotally: it is used widely due to defaults. Blech.

Which is excellent. Thanks for writing it.
