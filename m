Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CD514A611
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 17:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728493831; cv=none; b=KFM+n+34SGmZpE1RuL0ixHjFZB1y64pMlcleq7rDXAz20ngoj5n6d9STz6Us9uTelO6o1kTugiXRh/ogKoSF9cVcSa1VpZesTrz6lDKCCZPUQYIBKP9Oe0BCQC4E1Fnrl7ZuGUaKQxsF+DMI0OstCz8tQEpvnTe9GARe4bfvEPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728493831; c=relaxed/simple;
	bh=eI37GdXRMuRRaRTXostOSS+EkscZnkxQNOGBP07hE8k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MEZs6axMrzaqJJLWOxejUOrP0bTEfa0K+f5y4gNDorKH6k6cm308H2FKL5ZPHHlewhGXvDXPuR+3KXXX+PQBVxUmc2UX9nOrcq1RXrdLcofkdIyoEAKLmDp4Rm37RH6fBrhHwLI1zL12hQ8b/oDn10/3crb19OCCvG/jjw10Cgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=whcVPVI3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KrGy7Cyy; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="whcVPVI3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KrGy7Cyy"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id E1B9113801EE;
	Wed,  9 Oct 2024 13:10:27 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 09 Oct 2024 13:10:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728493827; x=1728580227; bh=PGhs5CfQ7Z
	R1Ivufzj4Hql825XFmFLzpwfcGkke3YK0=; b=whcVPVI3x45MfPHtT54VFf1SHI
	dPcbsMVUkPwbL/UjbnifV/5wpcOOs5ih4GxLQA6bodcYOrl4XO+/he9DBO3x9sJv
	Cx8v9UiorUhIIXBqneRdnFN/8bOoSy4XdoAl4VOJv8NDBzV4VwEca9i4Ae0Dp3Dg
	u6aBAKucHNfS8kVype3T0ylmQQ609ceWZ3mJZLPspz1lPif7Kea1FIN5OGGB3Fa6
	+0XshVDYiqZWi9ZrMMKTATXz3EkvBu98ruFTRvE2uQL8i4qIkqt5Oq4nB1OFLjo/
	DeZiuGkWWcz5csZx3pJe+HK1p/F6OQPMzRF9yhWhI6aqWXaVzgTabQypNqbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728493827; x=1728580227; bh=PGhs5CfQ7ZR1Ivufzj4Hql825XFm
	FLzpwfcGkke3YK0=; b=KrGy7CyyTYLe778P+E62IFMEv+PtsvSYQtbCHSLN22YD
	UeQOa4ejNxD9kcGKiJasUOqT9QUAdvzxSNzc0cCjxty7ym/Gho2jdAael0KSTUX7
	BH3tlG7fTBOEayj3yk7Njb9YVWbKAxTZtQxXUQFp43pfEk1XiR6dsSYPQIVsEu/E
	a7BFw2Tboqi3g+DhuPiVAGgWeC1RrVufw3rQvKgLSIp6t8bf/uaRoUZ7EVfts4dp
	4CU4TS6/4wuOaBqpRYg8O+sMisQLts54fIJAPK56kebkObQ+uFKanO95M1pEOOZc
	jhuBZjhpS6LyNsNKguXO/XpUew3GWZV/UYR7zIvbmA==
X-ME-Sender: <xms:A7kGZxmSTlEhMooDVfUigEvpweKrc0ARH9vIVkPtvr7yIj9th5CXrg>
    <xme:A7kGZ83GuNrkx1JMx2G4JsUDuIpeaHLtFTKxepSOS1QhxGD9T4NV0PmoQlOk7ycFq
    QQecZGVkamGq5LBUg>
X-ME-Received: <xmr:A7kGZ3orpSWSctcsPk0tYPmx1Qe0KFPHdooT5EUDFA14y0zjOBqo_V8sV-9KehxTOLQtc18FB8xIyMaJGWYXmUEhZk6sh4JLra8L>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehshhhusghhrghmrdhkrghnohguihgruddtsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:A7kGZxmLvpG1F0ABBVoh8Yhai7OIEoEH5kXhfsOeDUujliIc-NTukw>
    <xmx:A7kGZ_1zaWTxJVJ3wjrI5EkuTKTFmBZQDxHxM5kVixbQPkB2WMEjtg>
    <xmx:A7kGZwtNPlOX2AT3X4sgM-PILkDidazVxQiQ8xZfqVZrYJbsqwZlLQ>
    <xmx:A7kGZzVBgG3HFtj_nTojPh-ZEI1eOcNcnWEPagn9uHMSBLPKlPbS6A>
    <xmx:A7kGZ_9gjJWM_-JHanQ6bZdy2xAnOB4NrJHJ7hXcpx58okstr9a9czRW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 13:10:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Shubham Kanodia <shubham.kanodia10@gmail.com>,
  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2] builtin/gc: fix crash when running `git maintenance
 start`
In-Reply-To: <5798c31e1ef9346e7faf73f8c80b32c436937a8a.1728455715.git.ps@pks.im>
	(Patrick Steinhardt's message of "Wed, 9 Oct 2024 09:08:33 +0200")
References: <CAG=Um+0mJW-oAH+YLC3dWEU64JwS-zMkkTiFWYBe4g6HMbe-iA@mail.gmail.com>
	<5798c31e1ef9346e7faf73f8c80b32c436937a8a.1728455715.git.ps@pks.im>
Date: Wed, 09 Oct 2024 10:10:25 -0700
Message-ID: <xmqq8quxw6bi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index a66d0e089d..e75b485319 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -646,6 +646,22 @@ test_expect_success !MINGW 'register and unregister with regex metacharacters' '
>  		maintenance.repo "$(pwd)/$META"
>  '
>  
> +test_expect_success 'start without GIT_TEST_MAINT_SCHEDULER' '
> +	test_when_finished "rm -rf systemctl.log script repo" &&
> +	mkdir script &&
> +	write_script script/systemctl <<-EOF &&
> +	echo "\$*" >>"$(pwd)"/systemctl.log
> +	EOF

We deliberately include one SP in the name of the trash directory
when we create it under t/ so that we can catch a bug easily when we
forget quoting "$TRASH_DIRECTORY", but otherwise the name under t/
is safe.  

But this use of "$(pwd)" is a bit iffy.  It is expanded when the
script is written, which means the script is designed to write to
the systemctl.log file in a directory whose absolute path is known
and hardcoded in the script.  We assume that the leading directories
down to the t/ directory from the root can also safely quoted by
simply enclosing inside "a pair of double quotes", which might be
iffy (obviously if $(pwd) had a double-quote in it, the quoting
would break).

I'll let it pass (and will forget blissfully if nobody screams).

Other than that, looking good.  It certainly is good that there is
something more widely supported than "cron" so that we can write
this test as a generic one, even if some of us might not want to
touch "systemd" in the real life ;-)

Thanks, will queue.
