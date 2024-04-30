Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33309A48
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 00:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714438611; cv=none; b=DzT078d7Q5C1BN6s3meMMCPUdHqamA1/RWztncgiYACtt7lBtCFMP50CMa/x2X4VFsv0kkIEYl7QX+SDD/xlMr7iRQEKL6BqcS4UBKTBasVBXPwKroJwMF0KyC5aTbJOTTQYyQTI6c0rXI4S484hVx3yuF2y+3XpA+zos6Ck5xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714438611; c=relaxed/simple;
	bh=a9kWy4AMYkGyxbyrJYNZzMStbQtjFDMwHjJMsXLpz9o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=sT+YTop4CivBrhe0s0KTRp3bjzz3gMYPu2UA3Q4U3yT4p/wI6BkACULgxcldOHuWAXgmPXrvv1aG3cWDlmxFma8UNXopRmNRFJ8R7PR/QrvjbqKBrCyMBlQqwQhuq0/t+jpqGXqhikk3M84p/36lnkdmAt5ZWYD7E+aoxWDvsIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=gBRPf2r1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TDQGdw/P; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="gBRPf2r1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TDQGdw/P"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 2B4AE13803C0;
	Mon, 29 Apr 2024 20:56:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 29 Apr 2024 20:56:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1714438608;
	 x=1714525008; bh=KmNTwykkn6IZutr+CmOtNCN38fq0V+MEeCyB82bXgIY=; b=
	gBRPf2r1sXH8zMjEc54wLQ8vMv0IynQUI9Ajq47i6VZPrcrJJ+61ZmU+vhTWezIv
	abnABlmzW1dmCWFU8LVK6UoQJSKRgGcnp2bI0s2k7CPRTEHZSa36Hs/3jD+bYMQ7
	FF9zVy9nzyEEG+3j61JjPuvnD1tnJGjRKg9Xk3oQg9hFvbb8/we0daw4PtsK30ND
	sibiE4idAT5jdoMKXN34QLXCKlBpzgAjZinpyyVjiddwiiiy7kZTJyMIl4LlFam6
	NgwPYqAkL+mCyluOhULv2KHy2D4nwutVs8w1AoFzGR8cw4/KKcdTG9LyzZpGj/VT
	42i78scAsUMDTSy0p6zYXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714438608; x=
	1714525008; bh=KmNTwykkn6IZutr+CmOtNCN38fq0V+MEeCyB82bXgIY=; b=T
	DQGdw/PCixksCCc2KZKzu8uQCg+oc2QOWTyoVmD8F11lIoPEHMbiY3UIpjCUtzar
	7HzMkFz8IKUKbBKuHgq5Ke0b1s84T6msNBTHGrv78VWGL6r/6w9a5Rs3DdOaeJZ9
	iSsQGLjdcdkNm5wj9PGVx+fMU9bKhkOIaQEHTel8jp6KvQbrz7EaEItQw4SX1sHv
	Rlyb9zq4BUsRa1Te9+Zy7k5f7y5ycpthOz23SwBYba94qEZPYYP7k1Uknjx4ev1c
	0cXkMTCHqSatg3csWH1M87FOK2d+RehTiOYPAhooSMlvNSuyEOdPOJ1r2T4FVmUE
	98spj4n9PQMiduDZAqKwQ==
X-ME-Sender: <xms:z0EwZqYoJFszghcnjl28IhUoeW2mBB0aABmZmSWxea3pz6jN2TNtGA>
    <xme:z0EwZtaO6P-3IgQPj7o_4gTtSKWl6D8KAKjvezq0dfoc10bYivvP4SXNU6zzMHqqx
    3wCOSsqc6y4BTKAew>
X-ME-Received: <xmr:z0EwZk9tAR_bK3T34FcnwwQijYJBd2IyLnyPrGVxQe5eOyWTyXbNdxDEqE7eto5dPHWIhHHDr87YHxNjIV4eYYlo9HnynJ8NSI3BsJoq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduvddggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepggfgtgffkfevuffhvffofhgjsehtqhertdertdejnecuhfhrohhmpedflfgr
    mhgvshcunfhiuhdfuceojhgrmhgvshesjhgrmhgvshhlihhurdhioheqnecuggftrfgrth
    htvghrnhepffeukedtiefgjefhhefhgeelieeguddvveeujeejhfegtddviefhjeetudek
    jeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjh
    grmhgvshesjhgrmhgvshhlihhurdhioh
X-ME-Proxy: <xmx:z0EwZsrwhwcus_gLV-KnAEVqtezfEkrpI7S6ukNAAhNcZKs6s1ngpQ>
    <xmx:z0EwZlrGsrnF3aQtNcKnk9nE2dJdkI_WyE-kPcozlsrVhUi54QBMxw>
    <xmx:z0EwZqTsMReM0m3UFaimv1MOTILucKcV_ohlbcrKL613hS4BROV1sQ>
    <xmx:z0EwZlqrqoyWWKWxrmOu8VK2G9duX9Gu7HZReOGJZgQ6KGIm31ScBA>
    <xmx:0EEwZsXCxfQs-ISgTAihc_qNqg9vqS0f_3-jQ9igy8SemoTq2s9g1fTA>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 20:56:46 -0400 (EDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Apr 2024 10:56:42 +1000
Message-Id: <D0X1RH1PK67K.34KDYBQM6XDDU@jamesliu.io>
Cc: "Dragan Simic" <dsimic@manjaro.org>, <git@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] advice: add --no-advice global option
From: "James Liu" <james@jamesliu.io>
To: "Jeff King" <peff@peff.net>
X-Mailer: aerc 0.17.0
References: <20240424035857.84583-1-james@jamesliu.io>
 <20240429010925.93205-1-james@jamesliu.io>
 <20240429010925.93205-2-james@jamesliu.io>
 <37512328b1f3db4e8075bdb4beeb8929@manjaro.org>
 <D0WCCOLSMM9K.24BIGLR6EEJI8@jamesliu.io>
 <20240429064025.GA2905826@coredump.intra.peff.net>
In-Reply-To: <20240429064025.GA2905826@coredump.intra.peff.net>

On Mon Apr 29, 2024 at 4:40 PM AEST, Jeff King wrote:
> You need an environment variable if you want the command-line option to
> work consistently across commands that spawn external processes. E.g.:
>
>   git --no-advice fetch --all
>
> is going to spawn fetch sub-processes under the hood. You'd want them to
> respect --no-advice, too, so we either have to propagate the
> command-line option or use the environment. And when you consider an
> external script like git-foo that runs a bunch of underlying Git
> commands, then propagating becomes too cumbersome and error-prone.

Thanks for the explanation Jeff! Makes sense why the pattern is so
prevalent.

> You should use git_env_bool() to avoid the confusing behavior that
> GIT_NO_ADVICE=3Dfalse still turns off advice. ;)
>
> You can also drop the "NO", which helps avoid awkward double negation.
> For example, if you do:
>
>   if (git_env_bool("GIT_ADVICE", 1))
> 	return 0;
>
> then leaving that variable unset will act as if it is set to "1", but
> you can still do GIT_ADVICE=3D0 to suppress it.

Awesome. I'll apply this suggestion in the next version of this patch.

Cheers,
James
