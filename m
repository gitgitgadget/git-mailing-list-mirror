Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4AA355F53
	for <git@vger.kernel.org>; Mon, 11 May 2026 02:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778468187; cv=none; b=UYsO7eQiM3UIO9gfmdS0J4et6Dlk56Kz2mWjx2l8RU+s5eFEFLU90eqGw0o8Nem+LB2DLeOVYX1852Ok37ouazacNtUO8MnztSn90LzUhHxIzCLSNStJVELJ9bjGBqlWlM1Q1rYQTJpG1sAa3pGDvoCVMRL4CuRB2J2l6Tr2KnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778468187; c=relaxed/simple;
	bh=lAbKKzBta5YDq32xkuWmZwtk7Y7fJUtMTZb50//SZ/g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mXtJTc9m5q9uDb30iB13mXLKhnGQgg5kW38a/b+dyZyu4KYYbRbMJszyTvgKlRPZ2wEfhnj7ZKkM33nb+idov+dmbzI3wXashTfUX9h8PPneKrg44W0vLMhpJQ4LsbdLfIqSSSdHeXwM2r1TnjcekheYOW24/NAIufyuf+vosMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ym6MxTAh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PbX4V8zK; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ym6MxTAh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PbX4V8zK"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id A74271D000AF;
	Sun, 10 May 2026 22:56:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sun, 10 May 2026 22:56:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1778468185;
	 x=1778554585; bh=38CNi4g+dtmUx6USN4oCVHZ3okmpuajd3WygCRKx+HE=; b=
	Ym6MxTAhYvXkZgS4W9+fIsO76biNDyYKtKHvaOOzzoafBa7+TlWNkSPLYmzcuiAD
	cKMFqjTMA+rMg7juqqoxQ1I7qbxjAZCe6arnIQmXT0tWuB6y5NB8FVt1h6qL4/08
	U4fajklHs00EYGaEw+Yr/SzaYXQpLAakd0KSH7xrcuqhua4mlFNWoy0nDvxHVGMh
	PZZkQKjgzPBzSstDaRFIaqNkzBs8y7M2j78lb7zh5IdCnUTncI5OBuyMQg+7oAGH
	WIskhdNz5oc76x2T6HMoTRoj17NHpriO1xskk58vJbcYl6WjLegPxD9lRxjEg8Je
	mNVKsAzyhYTgN1/99LnZWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778468185; x=
	1778554585; bh=38CNi4g+dtmUx6USN4oCVHZ3okmpuajd3WygCRKx+HE=; b=P
	bX4V8zK7m/ksIoIHM8EgybyK68CYtt8Wq2EgpvnHhm2kUKGZpO2jrtI2KOjAO60e
	82VkZsL5qu1fZ+3jAxwnwCl+NXxQGX8ARSZHi7QLU9eT1us/Vy8k4Zkig4Wqi495
	jR+7kmkaUgUciaKkSK2Q3jPiTlYO18RrodEcFHEYV5dmk0OSPIkenhTFFKbuDk55
	z8TCOcvD9lofVeEPc/3QXkZObUYz4Pz7dlgRryaMv3ZjaA/IFk2JcYZcGZg0/wMZ
	mJbXwehbJnRbkVPnCqECUTWwgfcmByfiQ3ATE0wmjZ1cHEplA7LTov1VrD6aQuyg
	FFTDHzmwN8TmSnLHkmcUw==
X-ME-Sender: <xms:WUUBak_kcGYakmXrcFkUHKVyA3TZy3bqt4gjsBUs5h9WSQWyjDmPpw>
    <xme:WUUBaprtkJlewJGbpT_Yu1tW9X8Uayq6W7OBmNoOwloWLBzA_X2ILfMwHlbQXI3nn
    ENxTCK1WiHt9RGfdsnDUbMwj7Z5CBsRgGxV2e1bTJXC2skQDK98_Q>
X-ME-Received: <xmr:WUUBalqkDqO3eVvBqK4I3NMG6kgQ8ERB4zmDqoMUJ8f1F_LlAy2ptiGH13T95Xl3kKee3545E-u7E0z0hdJmtPO4RuEWjXpFjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudejkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekre
    dttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhes
    phhosghogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuve
    elgfekfeehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnh
    gspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggvlhhk
    ihguleeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhl
    rdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepuhhsmhgrnhgrkhhinhihvghmihdvtddvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepkhgrrghrthhitgdrshhivhgrrhgrrghmsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:WUUBas1kG0w7NpbGjX-RTucfsg4AZ7QIdQUemAfrSy1fiFrr4VVh5A>
    <xmx:WUUBajEX7pcYrAAXct7ZatmCr9nNmJ5aiNfV7exufFi2x7a1Ui4cmw>
    <xmx:WUUBanE2JfuTpMABwOB2c7hDxg0NHLxrrbIuBzuiazaEspZ-zn8KSg>
    <xmx:WUUBam6Uob7cgqYSG7C5F4lEZtBH4BqqiQINWeatT96UrhRi_1_DBA>
    <xmx:WUUBasIWV-5O_iCtAfTj-9ZbZMyrMoytA9pNZsZsjCRkZr4O20vpPsLB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 May 2026 22:56:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Bello Olamide <belkid98@gmail.com>
Cc: git@vger.kernel.org,  phillip.wood123@gmail.com,
  christian.couder@gmail.com,  usmanakinyemi202@gmail.com,
  kaartic.sivaraam@gmail.com,  me@ttaylorr.com
Subject: Re: [PATCH v3 0/8] environment: move core config globals into
 repo_config_values
In-Reply-To: <CAD=f0L8-_3sDGGkCzF4WA0xmUtaY_qiz__3zq5AemLgwTsqvsg@mail.gmail.com>
	(Bello Olamide's message of "Sun, 26 Apr 2026 01:31:17 +0100")
References: <CAOLa=ZQDXn7181VfHpcWtNOSjTh9nzM3YnDTG_X1Vqh_v64bwg@mail.gmail.com>
	<20260423165432.143598-1-belkid98@gmail.com>
	<xmqqqzo27fnu.fsf@gitster.g>
	<CAD=f0L8-_3sDGGkCzF4WA0xmUtaY_qiz__3zq5AemLgwTsqvsg@mail.gmail.com>
Date: Mon, 11 May 2026 11:56:24 +0900
Message-ID: <xmqqlddqu013.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Bello Olamide <belkid98@gmail.com> writes:

> On Sun, 26 Apr 2026 at 01:02, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Olamide Caleb Bello <belkid98@gmail.com> writes:
>>
>> > Olamide Caleb Bello (8):
>> >   environment: move "trust_ctime" into `struct repo_config_values`
>> >   environment: move "check_stat" into `struct repo_config_values`
>> >   environment: move `zlib_compression_level` into `struct
>> >     repo_config_values`
>> >   environment: move "pack_compression_level" into `struct
>> >     repo_config_values`
>> >   environment: move "precomposed_unicode" into `struct
>> >     repo_config_values`
>> >   env: move "core_sparse_checkout_cone" into `struct repo_config_values`
>> >   env: move "sparse_expect_files_outside_of_patterns" into
>> >     `repo_config_values`
>> >   env: move "warn_on_object_refname_ambiguity" into `struct
>> >     repo_config_values`
>>
>> Are there differences between the ones that start with "environment:"
>> vs the ones with "env:"?
>>
> Hi Junio,
>
> There isn’t any semantic difference intended between
> the "environment:" and "env:" prefixes
>
> I shortened some of them to stay within the recommended subject length,
> but on a second thought I agree that consistency is more important here.
>
> I’ll standardize them in the next revision.

Does anybody listed on the CC: in the original submission have any
comments on this round?  It seems that v2 iteration was commented on
quite a bit, but has anybody checked the latest iteration since it
was posted?

Thanks.
