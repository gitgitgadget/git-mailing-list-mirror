Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0098E236A62
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 20:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737059863; cv=none; b=fz7j3cxulpS/191hrxezdd0Mchm+wt5MIt1wlZvX2Z/DNjeYjXfcKCYYp9YQTbUoRzrUO3QAOAWpfwrvV/ItuBavSGnwkTopEPr1Nu33Q3AXNvEllBH03K/n+of4nLn3Zr+uC927ZFWk+YWUulD4aV3DAPG0XmlsChVpQDyT7Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737059863; c=relaxed/simple;
	bh=7RrCA0xCxArgaPMrmiFW6+fDKHXGh+5RN3YaWlfAA5U=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q+pBimJ7pKex+VJFh3q1kzAdkAZix/lOV+YXGHwQh5BMy7MDIIbVQidLzJiPZ6jt1uOD3okoJpte5I62uy5jTBi0vHn6jaM+sKlB9ecy+e/uGC6gAmmaf+DsPkI5AH+sVwrmjcew83MCNikfg/48x56ANCAT35m8R/FsSMs0auE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=6kn3qGxD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xPCBr6Tq; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="6kn3qGxD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xPCBr6Tq"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 062A811401A8;
	Thu, 16 Jan 2025 15:37:40 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 16 Jan 2025 15:37:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1737059860; x=1737146260; bh=PxkgtdMs0p
	wCM/bxn+GaK8/LA109VdRXjw0k6YNTxsw=; b=6kn3qGxDl187lE/775jkoHM2MI
	IrS8BKhPruwb71oWvxHETipS3Tsm5QUnlaaFXPo3CTjbQlv4Fk3Q0aiGD0/BJEFv
	bzZYt6etubCjDJU/jr944Rx09nS/PnOHeT84y+wjrp/qTg8i+AhCMd0kB2NxDjok
	eltqm5r1aoUwOEBNc/xXAf1lznqKyrAI2DeEWXHBal6ynlPYqCDfP4cWC1dsQ9d2
	UsAKIgr5z5C1D9Fi5G3Zues9C9xTc+J3crNC1925A7qSWilotdmEat/eM3bmf3O7
	cudsAD8PfTqaBpVm2kRbkQjQm3da/ymztmBUMcCj28tP2X86vm853GktvzSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737059860; x=1737146260; bh=PxkgtdMs0pwCM/bxn+GaK8/LA109VdRXjw0
	k6YNTxsw=; b=xPCBr6TqkO92SFKKddOIz+ksA0VxnRuw0F9sN9MBa2xClmPivUb
	cvc9C7eXWrm0oqCkczrbVNn51ONiko2pGYwE3poDFx7DdQLFnv68iBta9l4eqoTz
	nDa9psMrxZptvVI5Y6OyXw8jajzKtgDqEJ6gFBEKwp/SD1K1pNRgLzFL/spNCRGv
	AuwHFR+BzTggp1l0+inEVXVfXGWJgIfekr5jwGGpT0/r1DI67VFcJkp0PnnTvVKK
	MahV+1HNhNyo8NhO++hnVB7kWDf3EUl0pS8zTuDFvsLvtYZzPaR4lo4Eck5yMmc6
	0fMe61+BgrEYw00Ob9IjJ0ezZ+mhccrSUxg==
X-ME-Sender: <xms:E26JZ--pk66oAqQhsBqYmtnPco2tTXaI4purOwkFc81yPfOvTS-KXg>
    <xme:E26JZ-sw1jGv9Vd252TvjV1J4Rh-af9eZ0_LqPvTanRWeJT5CO9mV5Gx8vt0bHK6s
    hkhN9vIqucszVtP9Q>
X-ME-Received: <xmr:E26JZ0BOKoIEx4IVU_a4QWifUZAw-EGIT1GNTBYCYApNUjirFkj1NZUzlRO17lcxwkSb0NMW7YrC9yZLWMYg8mT2aXrgIcYYLpKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddgudefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvuf
    gjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeekhf
    euudetkefgtdeugedvgfeuieeuvdelgffgfeekvdffuddvvdekuefhieefjeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:E26JZ2c9NFYqrVgyNgiUpOb9tWW20Esx7DwF6ZXJTsTYHflLSJgrfA>
    <xmx:E26JZzNzoMzR6fjd9KDDVtXQW8nKfsEMlp6VnNC3DRskh71KZj8LSw>
    <xmx:E26JZwl7uzWuQ1baOHzg6YzHH7iaFdX4_RSrea8kRZjH4fjkMGaBnQ>
    <xmx:E26JZ1sKR_7_Qe04OgxWsYJ7Q-pYRgl2NkoxJiDqKqLPj39H1FbtPQ>
    <xmx:E26JZ8aTZRh57URHRy2VG-KNQ3U9fOYHXfmmjE8NVsxaeROCyWesAOA4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 15:37:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: Re: [PATCH v3 6/6] builtin: send usage() help text to standard output
In-Reply-To: <xmqqv7uesm26.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	16 Jan 2025 09:30:57 -0800")
References: <20250116012524.1557441-1-gitster@pobox.com>
	<20250116012524.1557441-7-gitster@pobox.com>
	<xmqqv7uesm26.fsf@gitster.g>
Date: Thu, 16 Jan 2025 12:37:38 -0800
Message-ID: <xmqqy0zapka5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> The above is a bit of a lie.  There is one strange thing I did,
> which needs to be redone.
>
>> diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
>> index bed2816c2d..9bd4b29c5b 100644
>> --- a/builtin/fetch-pack.c
>> +++ b/builtin/fetch-pack.c
>> @@ -176,6 +176,9 @@ int cmd_fetch_pack(int argc,
>>  			list_objects_filter_set_no_filter(&args.filter_options);
>>  			continue;
>>  		}
>> +
>> +		if (!strcmp(arg, "-h"))
>> +			show_usage_and_exit_if_asked(2, &arg - 1, fetch_pack_usage);
>>  		usage(fetch_pack_usage);
>>  	}
>>  	if (deepen_not.nr)
>
> I think we should just call show_usage_and_exit_if_asked() before
> entering the loop without changing anything else.

I have worked on a reroll and moved this piece to the "oddball"
pile.
