Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3EB3D6B
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 01:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723080170; cv=none; b=PHDqWf74wfQPhQ+d415A520+olIKtN+2NjL0NWzd1GPUJBk3vzW4l9es5+QUC84wTCrtJkXy0zmmXEvl6pBwXNZDEConNLTIUVO6a+KLxc4mUOdMvQKbyG80MPvmi5NcumDCLE77GfWshAnUN7K3e459+y7gQgFECofK1WM1p5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723080170; c=relaxed/simple;
	bh=OI6B0Kw7Rh+5bMR0XnVcZSxwhuiWPZE0GRbaHnhZsGA=;
	h=MIME-Version:Date:From:To:Message-Id:Subject:Content-Type; b=PzECM21vlGQEg8DUZfU5fKiz/oeHRKlLywVWFlTtIor2KNtVNv2yABq6+jll2o0GNikJ/WluYS8FT/dPV+EWV97KLbY56+g/BDm/tgia/81GtdYfbDXAg/rLSAX3LMnP66VOWNO8k4Uti3h5Z5ftnZV+HhwI0smZoYEjPnDYreQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=cVZv5dYA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BTbszM6g; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="cVZv5dYA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BTbszM6g"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 40CFA1151C08
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 21:22:47 -0400 (EDT)
Received: from wimap26 ([10.202.2.86])
  by compute4.internal (MEProxy); Wed, 07 Aug 2024 21:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1723080167; x=1723166567; bh=SBVqCpRmeb
	aYYGTHjlZsJ28OlR3IEvv4oUshDKLrGl8=; b=cVZv5dYAc8d45hF/xJSneO5yhi
	Uwl7+NtSDwIfCObpR+5OHUHY0ZlcH4ZfbPy8Mb7IZTm8VJvpXy+uoweFTu0spT5k
	Q/BaKbTRtwUJaMLiH2HPXRlyfMAfUm5DjP6pIwv2XruE/bgJXYq1lj2d2dOoihkc
	ybOSAk0qHhJxYNaf3PTO+GpydslSAPNqkn4vUnhiTY44eFRNAuZEDTp12Wnqdeil
	MLWwg1zXDdeUMJtWYnqxg7ZR9J8NWLCEvdyilm+pwjv2MxWQECS4tgL+jzJ2rArp
	O3Hw9Cjr/ywz71WoaNo9dZqPovQbowBjIDWugYVR20bCr7DaYA5mL8KLrYUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723080167; x=1723166567; bh=SBVqCpRmebaYYGTHjlZsJ28OlR3I
	Evv4oUshDKLrGl8=; b=BTbszM6gPU8Vp3qQEg3A03qsEbHvE43amKffm7ngpO+9
	0wnLefQGehKgmdFjCBvPozrial4DCcd+ebwyoBN0+iDXoefy3iYiLzY+iPrkzqk4
	PGxvCSMHjoSphUbUx7FW2XW5TMQZelqnIh50lcSSZD1RuhCSVFbJTAuRs8M5uSFo
	118EwXIi3N4H/oX9q1qHSBidcBJzmbVcfxlUCC70QKilO5TzuFjQkbAHTA9z2c/E
	fzxPsIWaiyC+lg41fCSvq13X1slZUorxTXAhFRR+26Ie1ttjETwGqChQ9Xm4tH2L
	PsSc3J20dSCmKn9ye0dlS1I5WaYBIFb8OFEXi98/zQ==
X-ME-Sender: <xms:5x20Zl-6BIF3UTsbC1S-zfurxxf-_nyvx5LSmUJwxbspmgyEnddgFg>
    <xme:5x20ZpvQ_qcbmGBNszdkuxxr2FiZwShmUUvKvInp9DEXt55LsGPjOquiAH0y6Q6jg
    hlK28t2oyU7cKDrR2M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledugdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepofggfffhvffkufgtgfesthejredtre
    dttdenucfhrhhomhepphhunhhkrdhlihhonhdtledtieesfhgrshhtmhgrihhlrdgtohhm
    necuggftrfgrthhtvghrnhepuefhhefggfffiefhuddttdfgtefhkeeljedtkeeggeekie
    egvefghfehhfdtueefnecuffhomhgrihhnpehgihhtqdhstghmrdgtohhmnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhunhhkrdhlihhonh
    dtledtieesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:5x20ZjBsLieh1QwNVTqb9kgoN2vqKFnvQgYgQToGrP-L7cbXI2TwXQ>
    <xmx:5x20ZpecGgUP6M5LEOa2mcC7simipob-vcOsrGGoiXpgZidVRFDuAQ>
    <xmx:5x20ZqMafJ50IqpcH7-gfEk8EGUeB1-apfwX-HYdSHU7z_t9X10xJw>
    <xmx:5x20Zrll8GP6TOU8jlmkmy1ypduCmkE32fk6idHAXOah3z4qx2FUcA>
    <xmx:5x20ZkXfan1MdOUCWqHLbT9DxgbkM_E_Di9FCuspqH6j8hAzNkkYNRpG>
Feedback-ID: i35d941ae:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 1392519C0079; Wed,  7 Aug 2024 21:22:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 07 Aug 2024 18:22:26 -0700
From: punk.lion0906@fastmail.com
To: git@vger.kernel.org
Message-Id: <ab0fcc2e-936f-4d76-8059-fb2bc8a4f661@app.fastmail.com>
Subject: Documentation bug (?) when describing `zdiff3` merge format
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The docs at https://git-scm.com/docs/git-merge#_how_conflicts_are_presented describe the following snippets in `diff3` and `zdiff3` style as equivalent. They do not seem equivalent to me, so either this is a mistake or the `zdiff3` style is counterintuitive needs a better explanation.

diff3 style:

```
Here are lines that are either unchanged from the common
ancestor, or cleanly resolved because only one side changed,
<<<<<<< yours:sample.txt
or cleanly resolved because both sides changed the same way.
Conflict resolution is hard;
let's go shopping.
||||||| base:sample.txt
or cleanly resolved because both sides changed identically.
Conflict resolution is hard.
=======
or cleanly resolved because both sides changed the same way.
Git makes conflict resolution easy.
>>>>>>> theirs:sample.txt
And here is another line that is cleanly resolved or unmodified.
```

zdiff3 style:

```
Here are lines that are either unchanged from the common
ancestor, or cleanly resolved because only one side changed,
or cleanly resolved because both sides changed the same way.
<<<<<<< yours:sample.txt
Conflict resolution is hard;
let's go shopping.
||||||| base:sample.txt
or cleanly resolved because both sides changed identically.
Conflict resolution is hard.
=======
Git makes conflict resolution easy.
>>>>>>> theirs:sample.txt
And here is another line that is cleanly resolved or unmodified.
```

The problem is that, I believe, the "or cleanly resolved because both sides changed identically." sentence should not be part of the **base** in the latter example, since that whole line was moved outside the conflict.

I'd appreciate knowing which it is.

        Thanks,
             Ilya
