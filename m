Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD611EEA47
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 18:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745431469; cv=none; b=WHxPiM0ZPuqSBw72lC0843+gYirjoGB+yL+oX+tkHpXYeYfbJ54OB0ufLyYBMQIzKj6Aw0I0boJIhp0B8M5PMwMDGkT5KJgj0YmpaGfXWqkTEYn/jRQJ6/CHYg2vugIGFuktJBfjVRU3asafipoXJ3+FhI2GOXaweaEVoH2x/Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745431469; c=relaxed/simple;
	bh=udBoX0rf2RXJ8/BKj27KM6Hwcd/mt1/EGhB6DGW3Ovc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TWz8/gmdKFf94JDqm6xnwTJP4M60yOxOdyu5l5ElTHkskimzgn6y/HYCOAeNdKHOI0khZLkLZMkLW1EuDHz6Ovn52XoyVzLoiQ5RbiDiyq1B7kSvlei8OO4wXWswyc7AnrvvQyvi5BovSsksDoU7/Vm8belQioTtmbG9kacZVmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NqHFdjgd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mdltgKCD; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NqHFdjgd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mdltgKCD"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id E4CED138021E;
	Wed, 23 Apr 2025 14:04:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Wed, 23 Apr 2025 14:04:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1745431465; x=1745517865; bh=eijU9Hm9v7
	XQw1co4TFisUKBMe4TwsyC3wOtMzxDLaA=; b=NqHFdjgdNPpdcE4sr0igIDkvjq
	CaakBvTCtHBjvpvxyYkYyFP2YaC3EVk3a66hu+QoCIpWLEMk++m9iOGPoJwCMvuq
	yN6BPpjipTwDWZYRvTRZYpK3zDOinTwA3gmPdY8oANoEIY/W5mMMii+hkQprADfx
	Do9l0tTtU5XAhn00AowWUUZh0INa+QttuY6aKpitV/dWxepajmgiHCLGodupp5r+
	u0qxbOJt3niMJZ4SHT2rh91GdMv297SKXQfGofHqXlAtr4foWIEnvV3Wg86EYazx
	rOUCBwABNnXkRJAM6X/kvPXbMpLkOGpnXd94XYmbxvG2e69boNN0bdbn9Liw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745431465; x=1745517865; bh=eijU9Hm9v7XQw1co4TFisUKBMe4TwsyC3wO
	tMzxDLaA=; b=mdltgKCD1EJlB01iKCfQ5i6Rp8dz8tkLg78s4mj1oohLgqKr7Nz
	zUQWqGu/zzSNxjJiRdSdVppYrs9SAk/413ZZEXvN/ol6tvN2spUaWvfGbmkNo02w
	d4f1hbzZAfO+LehwAqZTpfkSqq7tZLUbCtgFFiKDQijJzwCf/OMrBFtUIWYhTwMJ
	Jw6Dchdh7Wss9EviMoWAUU1N6Yw4Pw1uqUCnuoq6i29jm/+Rc/op7WCkI7qcgk/d
	g30VKEcMqc4OiNalWPTpJq8WfamanUaTjW3vJyRwoNXQHcw7mXsgcUzqDOA31N/8
	Qm5WllyIcyAEn4q2TLoxGMjPLH+3QNszU6A==
X-ME-Sender: <xms:qSsJaHhOkA4kLxfMoKz_4r2k8MajtJ3sWK25thieKjuhM1-i7nM34Q>
    <xme:qSsJaEBVh4ixJHi9earQMyNc-FQrrNkUuUIsUG6LpNEeO1AMjbC9-giIaASNSRfmc
    9NxdkYt6DS6ZXZ2_Q>
X-ME-Received: <xmr:qSsJaHEkl8aJ3ZkZmaJnztoiWaSPW-DKQY8_Ic1ylnZOp_aaobI4S53zVCZ1HRKmNAuHhhKwjLFL4wSakbdo6zS1ti4C3Z3cSDZk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeejvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghgrrhhgrgguih
    hthigrtdeksehlihhvvgdrtghomhdprhgtphhtthhopehjuhhlihgrnhesshifrghgvghm
    rghkvghrshdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepmhhirhhthhdrhhhitghkfhhorhgusehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpd
    hrtghpthhtohepfihirghgnhdvfeefsehouhhtlhhoohhkrdgtohhmpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:qSsJaER2JzRKh9MaOlwKfqcbdk5axlE_gipWQImgJeTkgOYVBpB03A>
    <xmx:qSsJaEw3AuRpZxSkqg6P_hQOcZ_uUoU9_H90LSGCvIXX0We3aZcB5A>
    <xmx:qSsJaK5vlnXrsvU1Ai4RHBOrVXKKKAKyCXd0y6d7Gzf95zwnF9RXQw>
    <xmx:qSsJaJxyaYSQWExzzuMD1vuDzjrTdqmT3mze_KviLHpThZAkRjXRKA>
    <xmx:qSsJaN9NbqD8pbL6piurLQszL4Sx1LYdS-_CmL2uyWM7Owk6CNN_ToyF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Apr 2025 14:04:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: Julian Swagemakers <julian@swagemakers.org>,  git@vger.kernel.org,  M
 Hickford <mirth.hickford@gmail.com>,  sandals@crustytoothpaste.net,
  Shengyu Qu <wiagn233@outlook.com>
Subject: Re: [PATCH v4 1/3] send-email: implement SMTP bearer authentication
In-Reply-To: <PN3PR01MB9597776CB37BE7B05A7ADD80B8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Wed, 23 Apr 2025 12:19:45 +0000")
References: <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597776CB37BE7B05A7ADD80B8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Wed, 23 Apr 2025 11:04:23 -0700
Message-ID: <xmqqjz7azrdk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> From: Julian Swagemakers <julian@swagemakers.org>
>
> Manually send SMTP AUTH command for auth type OAUTHBEARER and XOAUTH2.
> This is necessary since they are currently not supported by the Perls
> Authen::SASL module.
>
> The bearer token needs to be passed in as the password. This can be done
> with git-credential-oauth[0] after minor modifications[1]. Which will
> allow using git send-email with Gmail and oauth2 authentication:

I am not familiar with this area, especially with Authen::SASL, so
I'd appreciate a second eye from other reviewers.

Having said that, the documentation is very clearly written, so is
the above log message.

Please fold overly long lines the patch adds.  We officially aim for
80-column soft limit, and we allow going over it when folding lines
to stay under it makes the result less readable. But lines added to
the credential callback to call smtp_bearer_auth() are a way too
wide, for example [*].

Footnote [*] The text themselves are not overly wide, but the long
lines there are primarily due to them deeply indented.  I have to
wonder if it is a sign that the part of the code needs to be a bit
better refactored, e.g., by defining the callback sub defined
elsewhere and passed to Git::credential() call as a variable that
holds a reference to it, instead of defining an anonymous sub in
place there, for example.
