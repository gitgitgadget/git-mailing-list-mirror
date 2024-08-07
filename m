Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49211C7B73
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 07:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723014694; cv=none; b=pp+pSagOIcqxAiNkOOJLkc28d+VUUqPyw0syvVbNCF87eKJiKGsLt7n0FGwIOlbE8o2WwAr8Bn8hQmEE4P6dEfdzm4Lqj/E0OQSfucvtp2fyiiXtVtjTWp8y3cNU3KcVxMwnAefs/HZxGaTuvIYhQs4cutz/EIbKtJPBK3x98ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723014694; c=relaxed/simple;
	bh=lNdb8mQmy0KIyNBPAJuugt6UjCInqBndtk9OTYa+c3g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=KYxMmzdBZAlkkgOoIhPJZA9xy7epQN/vdL0qzS79Px8hPjLgfNTf90Nm8MLZ1Zs58Iozoba89BLrDHGW+6kKyD31RwjjjeItB7HmLQo9A3uZiXtrp9qi1KwCqn8E4dU00Ud16PKUfv8Y7KiN+kKqMwQ2ODeGDRlpmuIuLaV7XIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=Ny/FsDbG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=USFCofp1; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="Ny/FsDbG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="USFCofp1"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 5AB361388073;
	Wed,  7 Aug 2024 03:11:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 07 Aug 2024 03:11:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1723014691;
	 x=1723101091; bh=SrE1DPc/PSDPiAmhdmWTEpOMPIWJpmtS9BDmBh8fiXY=; b=
	Ny/FsDbGvFGqi8Dqk98Fu1XRW9+m+tuqHMghc9kMRd27AYRmYl0XlEmfZrqv6S+c
	aUYcDwXaxyYLLsK2O1ZsyE9+YtPSiU73hLlqP2cD7S1Mnb9QfCFPamcx7zxXFw0j
	iPZpjl9aQeDSAUkZ0eEEOPdF85ZOc5IQ0bdxVeSZTaoBltDWcpb9hmBAcxG1fQp2
	yC8H8Gmgz/jhTLjQXHT3Jwnos+/HQ0JbYHaIGWyPqUOvj892hZIkZNN2xvfTcX2T
	gzrO18pnmK9qjq9XXxhtkJ8MP0EKDIHutnR9o8Za3CI3XILzCw7Ld3T3blx8mZcl
	JFN736K19XrGDIxB0MqmmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723014691; x=
	1723101091; bh=SrE1DPc/PSDPiAmhdmWTEpOMPIWJpmtS9BDmBh8fiXY=; b=U
	SFCofp1Q0Xyr34wuwv7r+pc9OiM5qwsGJpojOSIz6CkoT5gQRjEv0WqNFa+C/a7+
	VhS4crOeiDwOgahCJyZN4sUTp8l9zazZ3DllAPtOySJ3Asg8sx6fBeeLX5szPzJ2
	kgThd+ambJGksdPki5aWHoWBB9ONYaqXCnPzW5/wOA8YmoYlkVIeb9Q+OpwWbWgE
	hzQPrHjoxeQt4A0b9B66hgtucw3vB+4I1WIbvuFJRuHJXqjrgRADdXIyqIu4ncYc
	HjOnf45riCmTTaJiwHtkCy1cTvzge554az46mciRdDkve93t3wuJeYoP2ZYtgY8E
	V57mmaFpGTfWcpnI/ao1g==
X-ME-Sender: <xms:Ix6zZh8B8alRpEfiP2ifDJ29iClYKxRE7hTEaaTMoCsSRkYu1uGToA>
    <xme:Ix6zZltwKRVwexOBRMqab5XQGgy2NEVFe9NFsQuQJpkFzhHJnECcnXIQnLpbIVlFP
    J4Fu5KreiS_msx-_w>
X-ME-Received: <xmr:Ix6zZvDw2rLBIDTAxuGnv95ZAo8HSEbu0mYEZAtVAocKT1oCCz8-Al6362ML>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeelgdduvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepggfgtgffkffuhffvofhfjgesthhqredtredtjeenucfhrhhomhepfdflrghm
    vghsucfnihhufdcuoehjrghmvghssehjrghmvghslhhiuhdrihhoqeenucggtffrrghtth
    gvrhhnpefhteeuheduleettdejkeduleeuiefhveehuefgheehvdeikeettddvveegieel
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjrg
    hmvghssehjrghmvghslhhiuhdrihhopdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:Ix6zZlei010TOQX3M0Wwu-PdkAnQCHzxGrqwYdx1GOTQc78SEXS-cA>
    <xmx:Ix6zZmMNbm2ThUjVaSgikaSQgtbLLyebF7x8q02Ux_wSwV-PakpTag>
    <xmx:Ix6zZnlBDSqbkRAlzntHztmPhwFRVQOkIh2mUwUquTvxN9hHvAWWPg>
    <xmx:Ix6zZgsooYwCo2pbS4uRv5qPpNDaLY-OOxke2MGMCdzvYuZtAYTX9g>
    <xmx:Ix6zZvZDmp4_CpCGk1T8FShSrrSzY5NjaNmLceYRI8VCKJ_hvjK9WA2r>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Aug 2024 03:11:30 -0400 (EDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 07 Aug 2024 17:11:28 +1000
Message-Id: <D39HQCFQ2DCW.1KFGPLVU1EVQD@jamesliu.io>
Subject: Re: [PATCH 08/22] config: fix leaking comment character config
From: "James Liu" <james@jamesliu.io>
To: "Patrick Steinhardt" <ps@pks.im>, <git@vger.kernel.org>
X-Mailer: aerc 0.18.0
References: <cover.1722933642.git.ps@pks.im>
 <a34c90a5527cb45ec89a0ad44dbca1d61705a0ea.1722933642.git.ps@pks.im>
In-Reply-To: <a34c90a5527cb45ec89a0ad44dbca1d61705a0ea.1722933642.git.ps@pks.im>

On Tue Aug 6, 2024 at 7:00 PM AEST, Patrick Steinhardt wrote:
> Refactor the code so that we initialize the value with another array.
> This allows us to free the value in case the string is not pointing to
> that constant array anymore.
>
> diff --git a/environment.c b/environment.c
> index 5cea2c9f54..8297c6e37b 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -113,7 +113,8 @@ int protect_ntfs =3D PROTECT_NTFS_DEFAULT;
>   * The character that begins a commented line in user-editable file
>   * that is subject to stripspace.
>   */
> -const char *comment_line_str =3D "#";
> +const char comment_line_str_default[] =3D "#";
> +const char *comment_line_str =3D comment_line_str_default;
>  int auto_comment_line_char;
> =20
>  /* Parallel index stat data preload? */

Is my understanding correct that `comment_line_str` is now just a
pointer to the `comment_line_str_default` array, and thus can be freed
once we're done with it?

