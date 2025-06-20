Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAD52BF3EC
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 15:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750433389; cv=none; b=A6H4Q8HkBsOCT4e3LrSQJh2DK8DySVHTp4I8Fx24BqMR6pcaZSXe5beV0jBCmu+W/IU8MW6fQgsVT9zrdYexEsRiAD09lo6n3OR45RXcdiZG91UsmcMHgRyHtJOqM3PI0GYwg8Ihocpv9I5S30ep9ZJSHYh66jrs/LBnKss1Fmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750433389; c=relaxed/simple;
	bh=FzlCCQUDVg8O4XsSbfWp6C0EuZXHuARHa0DDVTqrbuk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=DSreDOV+RiapXaNJ7tyRHt+SPwoAPtKoEztqpjyuoXyVBlI2IszXZ4oWL42H+TQ+PkLeLC8Y1gWqHowdd0msrL8Ng+svyI1pHeGsRK5t8bErW9EwJbFd6NfaakEnJKK4SqQWcprkFZXAO5mYXHUenbeBLL6rs9QZI+eWh16kIOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=abGf8bZ1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T48t9P2a; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="abGf8bZ1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T48t9P2a"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 661F211401EB;
	Fri, 20 Jun 2025 11:29:46 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Fri, 20 Jun 2025 11:29:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1750433386;
	 x=1750519786; bh=MMch4pRBfkc7zyz1ENr6iMXun2yZuLXVhmMtVAcxGfM=; b=
	abGf8bZ15zTe6ctH6+UGgcDFS3jTaYbuA+0t5CrWg47dCkHTkUqZQOH/G8PU6icj
	yX4zGY60vlmUlkQ0YXvVnt+79CiLuVLIxMI5Y2d0h4Fl7cHqHfyKxHG7HNrIwwa5
	OmXkCGDne/QGHd3c2dw0RHTO49NFD1VKgMwiH+ccHTNxBvPLuJ07jqqG1xCoUIFW
	rBW64CqrCnfQoW+UWOE0tDakmZUGlA4AySUcyko0wGQY0bBLmbvNCb/Lt6i+kIgy
	6XJ8H866wwcADmFoacudzWukZk+Ivn1rejasbmoib/qBnjS4Cdzk1nUrfhwomX67
	N0zIWOOPTTzRZgweyMe9dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750433386; x=
	1750519786; bh=MMch4pRBfkc7zyz1ENr6iMXun2yZuLXVhmMtVAcxGfM=; b=T
	48t9P2axYJpFHQ+uWNaOZdcXeCNbyjOQl50BOV1shB0DJ9/TSY8pX5bpQN0KEob/
	UY50/URF44MDQ7DYTp5WPRAWJOBWDqeW0MAhq/BW2PVQzkCRri9bbjgHFwydFGBa
	keJ11YhWf9oVWRH8i16PZM41LOcBHCSfm1zgCIeB8kZ3ynxqqlbsL/rGVIKifkqU
	M9xSPc2xfm9V5Vue+9VaukPlO750CkqjJvQVLUt+WTVhpIFzNE1r3ZAioI4CO+3k
	+uMsF0yaQmcYhn4Q7OC0iTlaI+VR0FITpzGNCiNTUeVlpc9dM2uGuP7LI7E1/G2N
	8CpIPKsU15qeaQtG+Vf2w==
X-ME-Sender: <xms:an5VaJ8fl6zH2-Nz3CDK9gNRAIuMaHEihzsyixvEK1chujuv8H6NoE4>
    <xme:an5VaNtsS5MayZHlgA1kYyekbirJjuitFbNyIOSPCkbINGfZBAdNp95JKlOHbW9hU
    KzJmLpkV_VkOk8crg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdekjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhsthho
    fhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkh
    hksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeegjefh
    heeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:an5VaHBzLrYHZrm995bYIQf69QXd_rwpQrrOWsOAw_hm9EZfPGV5rg>
    <xmx:an5VaNcyoR1kgvwQy2CKhg8TKC-LY1vIkLD2n6RB5TFNKmohkQMNoQ>
    <xmx:an5VaOOTx_24_qzQGQkSHgr-bIOlbA4r1L_g1nxVhdGbzPgtCPkZzA>
    <xmx:an5VaPmFAg24VhaKwPdpRRDT61m-pMlnQIPx67PuNHIzsOesSpfRwA>
    <xmx:an5VaE1A9kAJma3obPu8juOBfBf-69VRfztJBLR_dyegyj-5sfgKvOwP>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2843E1EA0068; Fri, 20 Jun 2025 11:29:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T45b3e437b124cd3b
Date: Fri, 20 Jun 2025 17:29:24 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: git@vger.kernel.org
Cc: "Patrick Steinhardt" <ps@pks.im>
Message-Id: <74ee41f3-a9dd-4a9a-9350-33ffef7dea23@app.fastmail.com>
In-Reply-To: <4e3c2840-37f3-43f8-9d8a-b4a106d8d18a@app.fastmail.com>
References: <174f3704-6319-48f9-955e-b36a25836e3d@app.fastmail.com>
 <Zwzvgby2_oCjQpii@pks.im>
 <7347e29a-f33e-472b-b993-06c4767a9456@app.fastmail.com>
 <4e3c2840-37f3-43f8-9d8a-b4a106d8d18a@app.fastmail.com>
Subject: =?UTF-8?Q?Re:_What=E2=80=99s_the_intended/reasonable_usage_patterns_for_?=
 =?UTF-8?Q?symrefs=3F?=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024, at 11:45, Kristoffer Haugsbakk wrote:
> On Wed, Oct 16, 2024, at 19:23, Kristoffer Haugsbakk wrote:
>> On Mon, Oct 14, 2024, at 12:16, Patrick Steinhardt wrote:
>> > [=E2=80=A6]
>>
>> Thanks.  This makes sense. :)
>>
>> =E2=9D=A6
>>
>> I discovered/re-discovered a pitfall with the following approach:
>>
>>> Create a `refs/heads/<symref>` which points to a remote-tracking
>>> branch
>>
>> Again, so tempting to do for me because you get a shorthand via
>> `refs/heads`.  And this is indeed fine for read-only operations
>> (effectively).
>>
>> But don=E2=80=99t be careless and do something like commit while chec=
ked out
>> here.  Because you are checked out on an ostensibly =E2=80=9Cproper b=
ranch=E2=80=9D (not
>> detached HEAD) and the remote-tracking branch will move forward with a
>> commit.
>>
>> So I=E2=80=99ve gone back to using one-level (root-level) symrefs with
>> all-capital names.  Because git-symbolic-ref(1) allows that and I
>> haven=E2=80=99t gotten any weird warnings from it.  (I would presumab=
ly get
>> warnings if I then defined a ref named e.g. `refs/heads/M` if `M` was=
 my
>> top-level symref.)
>
> Another newbie mistake.
>
> I used e.g. `H` (root level).  But then I was in a worktree and
> discovered that these root-level refs are per worktree.
>
> But this works across worktress:
>
> ```
> git symbolic-ref refs/H HEAD
> ```
>
> (Or `refs/h`)

I=E2=80=99ve been using some shorthands for over half a year now:

```
git symbolic-ref refs/C refs/heads/<longer branch name>
git symbolic-ref refs/O refs/remotes/origin/<longer branch name>
```

E.g. I find the latter convenient for referring to some long-living
branch that is also long-named.  I use the remote-tracking branch
directly to use as the upstream-tracking ref and to rebase on top of.

I haven=E2=80=99t had any problems yet.

--=20
Kristoffer Haugsbakk
