Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269A23016EC
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 15:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758121335; cv=none; b=abcC8Ddx5azsk6r2WFvYZg+WUp5A67EHxOlJJK5NfMw2EC7yiVR1at2zuU6ZcMCs4FvxQN0SBXpXsKR6DRe95fFs/AvNX4iillmIbh4AxRrbCiGx/Eio4kBP488+PsYoGiKOAmbNGaukaLS4aF03068dUkXmjRrdwUb4ME94dUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758121335; c=relaxed/simple;
	bh=CbnOqaAIUkDU+9T26knkhKC/zh153ZE3Le9OcnuzJFo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n50otsLZuvvQbXWRKxBLwGOIidUjGPmmN90gRVWmk/CXiNx4w/3ZauLLgXIZh5ePIxm8zcu31tDRrIe/y2598O59B5htnMyMuCAO+mHguSSurAcnZHhY7S+ZsepzocosIpx+NmTcKDNFy1SPIVbWrihTMaMFupY5Kn400viublU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lUUsb4GU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cg3tmrqw; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lUUsb4GU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cg3tmrqw"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 2978DEC018B;
	Wed, 17 Sep 2025 11:02:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Wed, 17 Sep 2025 11:02:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1758121332;
	 x=1758207732; bh=37o/ES73igd0gklBaC7M+q72spntm0VTQcP33sWKeSU=; b=
	lUUsb4GU/SQaGSDJO/EhKBGxQvnBXGInHi7mJfBErEXaRLG2w3qO1Y1veB2haLsS
	DkijhDXyj1/FVlX6bkcfHlvM9SIe4v4h8l+gJb9vB+ehhmRg5jlaI1MQiWE3VSZx
	NYeEF9p2DGRCfkYejSsR6cXh9QjiuaO/q/HIJ0OrPbfJDrc2dUea5zfpk1Dnus2G
	6OVQUeEl7ccAKkQ4X6f5i9cxwAnQHinFIxStpRPnUzqu2Uqw32wc84ICpf+C5EGW
	CtIzgTFp1g7/hFKFut/FSfdFd65iZF3hNYQGDVmMeeznoybMfiyzji4Tj7I/1svY
	oN/vCVr1fuPz4wZqBu+tvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758121332; x=
	1758207732; bh=37o/ES73igd0gklBaC7M+q72spntm0VTQcP33sWKeSU=; b=c
	g3tmrqwTep0J76/kHi/pEXh+MQSgP1vdNbLlflyV4t1pmu3ZOQ4xfxmyRst8pdl5
	qXvEauv2oMglECBh9bKcCIc5+UuFB3IZNA6C8KCkEL2/MILzQkg53eU57p2MZt0+
	7usNo7NToZRBKneojuUXJVbjtpg824OSXXHXXVPSsJANNv8L4kLV2Jmk5SMJ+XU9
	tVT0qwtETbQUC4AiXIdFYUPGYJghxFHC3Ra07KrtxECNc1P4yK7UVVf907qmt8Ma
	NpKwC9TVALZfH283YWiTvWIOXwb671G7xddrXh/aJHSXJ+KoVXHyz8pBUv5YIsQH
	4XCRLFIK9NQaObMCufTVA==
X-ME-Sender: <xms:c83KaJ_FFJW4SV3kJnMmHqi1Pj9wKerjOUoMjecmcoXJUTao9JdGKg>
    <xme:c83KaLTaPB9ixBNb0DaIx69aryFDpaQDFA8QYj-elxJCelMQS5F62uk2RyeUk_msf
    TZU-_kzjGgt1EEnNA>
X-ME-Received: <xmr:c83KaNdEBj4cIqqTo2Kvo1lYlqOZMtHhGn3RbWmRs319zTiDIVxLmi2Iq9UsuBNIRWtjIxEujI6c8vI7k3en7XpFbsq64TNzo_7bFvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegfeejhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepgfevgffgveelledutdevgfehieeitddtgedtueduledtiedtudetvddvteeh
    hfefnecuffhomhgrihhnpehrvghfshdrtgifnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgs
    pghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohep
    phhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhs
    tghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohephhhurghnghhsvghnfeeihe
    esghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:c83KaPBNbTrr33IQEzieNAxFUmnzODncjDGFy66YrvtzRwUHGpynmQ>
    <xmx:c83KaPkuHWCUoVTHrAucfHF87Oppml42qdfNmmQQ7HnMaEswHqpTmQ>
    <xmx:c83KaKcRB9QLoPIX0W7R6Q4bX4kGBzCPSiu8rLZhm9JxFLzerqTEig>
    <xmx:c83KaDSJO0f6j05w83STIQ6ibTWyBTGtos-Zm0zxKJH2nnaPAPSMPg>
    <xmx:dM3KaNLoyeMTaoGGa7CYi8NSbXzHLUkacy4rV8lkE0OCHNwXt_X2yTE7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 11:02:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Phillip Wood" <phillip.wood123@gmail.com>,  git@vger.kernel.org,
  "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,  "Wing Huang"
 <huangsen365@gmail.com>,  "Patrick Steinhardt" <ps@pks.im>
Subject: Re: [PATCH v3 0/4] breaking changes: switch default initial branch
 name to "main"
In-Reply-To: <145305ac-dbfb-4162-a603-b6b60df2bc5e@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Wed, 17 Sep 2025 14:02:29 +0200")
References: <cover.1756308283.git.phillip.wood@dunelm.org.uk>
	<cover.1757518141.git.phillip.wood@dunelm.org.uk>
	<xmqq4itarqfd.fsf@gitster.g> <xmqqv7lhigb7.fsf@gitster.g>
	<145305ac-dbfb-4162-a603-b6b60df2bc5e@app.fastmail.com>
Date: Wed, 17 Sep 2025 08:02:10 -0700
Message-ID: <xmqqcy7pf7gt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> Which I only mention because
>> +static const char default_branch_name_advice[] = N_(
>> +"Using '%s' as the name for the initial branch since Git 3.0.\n"
>> +"If you expected Git to create 'master', you can rename the just-created\n"
>> +"branch can be renamed via this command:\n"
>> +"\n"
>> +"\tgit branch -m master\n"
>> +);
>
> Repetition: “can rename ... can be renamed”

Yuck.  I started writing my own message and the in the middle of the
sentence changed my mind and decided to borrow from the existing
message we are giving before 3.0, and made the result incoherent.

I've squashed in the following.

Thanks for carefully reading.

diff --git c/refs.c w/refs.c
index dc569d0358..f15366bfce 100644
--- c/refs.c
+++ w/refs.c
@@ -644,7 +644,7 @@ static const char default_branch_name_advice[] = N_(
 #else
 static const char default_branch_name_advice[] = N_(
 "Using '%s' as the name for the initial branch since Git 3.0.\n"
-"If you expected Git to create 'master', you can rename the just-created\n"
+"If you expected Git to create 'master', the just-created\n"
 "branch can be renamed via this command:\n"
 "\n"
 "\tgit branch -m master\n"
