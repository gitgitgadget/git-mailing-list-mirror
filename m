Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0214A18
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 17:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737567518; cv=none; b=MW4W7E1a38CuJibjYFEaFmMGpYyRk7sJhgGlQwW1OpdsSJ5xuqqOdOGM7kQGMzEZMyBfAi8GkrCYasptTlHvsEWE6GZm6DwaJBd4le7S+NSjuu8Z+CSotiX1IMnS2vcRkbA9xkix7Xzj2urh/0lvqoWnCeZpJvOqo2JurkSZR2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737567518; c=relaxed/simple;
	bh=+9EWtSFcZ0pLIZsFBj/ZKQ/PCyPB94H2F2bKpxaYK9w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=adL2GCOe+tHX7St+RxKWDjxa8gYEVKmaIW9I4q+bAxEjBMsswxfi4RmbsnidQXPC6CbY0zRbeHj0+wJHMiJY0nSIVW+Ex0ZmFHSdcnM0+dWGyWmKNevVRBhslfhRPTV3rERWg8kBwAnKSYgtwZmR6VQ75F+ymH9IYFAMYSOUw+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hcpfqwGY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P17/mbrn; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hcpfqwGY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P17/mbrn"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 605BB2540110;
	Wed, 22 Jan 2025 12:38:35 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Wed, 22 Jan 2025 12:38:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737567515; x=1737653915; bh=2gc1m2SQos
	OJnX6OvM0xvZCMhhMJG2gETbFcYp6DHGQ=; b=hcpfqwGYhWfOnuyCmxgDJq0vt6
	eGub3WugBRtjuJ/nRJ6wWVkhdSCgIGsILMGtg0sB6n7sQQ4jeWfDzphHr5Vf8S4E
	8KDabsFTt7LUqf+deufEEGh7kgkGHJ2Ta4FwnMedG7v/lioaJbZvHrTgv2Nyin6R
	96tzByJrLlE72PUSQnAbvjh4KUWmFuOe+QK/QRSZSFkBBCVHt7PnV31jRk1mNQgB
	bGXlW7T1J59jsT0RsMqRiZCpfcnsxv0gGCpKZiblfFNacjH17iUuTF8hXK1lGS6w
	9Xau3bTIKQt0m5OSt4FM8DiWR2BkDyvdvR54mcDlGIIzLcx3GhQ4r32PUKwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737567515; x=1737653915; bh=2gc1m2SQosOJnX6OvM0xvZCMhhMJG2gETbF
	cYp6DHGQ=; b=P17/mbrn7fDqcf24mW6fJeJKwS7vGZfnPPyP3a7X0VCuCWm7G7c
	tAWIwdjUye4SZs5WlI8dwlTgY2CycOgDqOl44SLcS2Uac/OPI32v/e9RYhsFzmQR
	JeiguOG1FteyR2W5UK4Bn7/ShLNcrtxmzy18B+oLJKOvQNVILLKFIms3AkFkD0ju
	vpPSXf41vN5nAdWtxiCOydnB6yBnX/j/o4vfIZI37k3PFl6kHd/YHAFs0GhAAH3B
	uuCw5frxvtNXj/FPNKowppd4K+bG6Kt4CDKb9C0vBI5yn2pwpJcWFGQagxTJEth1
	j+uqlfUToJs66v3LtJZ3M01CfjPof57DUkA==
X-ME-Sender: <xms:Gy2RZ43GqxmPCFoqpRKh6gvruo9rf9jK84IXbTKwhQlH87p5-Pxm-g>
    <xme:Gy2RZzFUeNqvGSboMhxCrSAkZnEx_DjxnZfvHTOCemoWyq6St1wR5594pPOO8qWvB
    2_XMRdz4Py8idLMmQ>
X-ME-Received: <xmr:Gy2RZw43bDPobZjCxuaGUGyc4cSxdS_Kycx3ju63Esdo_cajl6TBlu6czZ1WIeEU0mBO2ZnroLtRFqmIRespyOBMJWlyHPgxEV91>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejfedgvddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeffieetueejveefheduvdejudffieejgeef
    hfdtvdekfeejjeehtdegfefgieejtdenucffohhmrghinhepghhithhhuhgsrdgtohhmne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhs
    thgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohh
    grnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Gy2RZx1xVUhdamppXSUqFwyl9WXauemoYVeInTXKHRUPvfyb3krZ5w>
    <xmx:Gy2RZ7H7ADnhKt8R9fuMa6_-u7EXll4VP26iRhRzu3B0eDFvGClaXg>
    <xmx:Gy2RZ6_Mni398N1cGnUbOOSlHC1AjPhNRsfZ3u7qRnz5agSrXDuzYw>
    <xmx:Gy2RZwnyc_6MDOIrF1BzBmlnjx285t3WEBfllxpSeJk8BQ3VIWBbjg>
    <xmx:Gy2RZ_hYhLfv2lm8yXreej5YfihyNumsKb3WwI2z0Wp-YEw7NOq_GxK1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jan 2025 12:38:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Jan 2025, #05; Fri, 17)
In-Reply-To: <CAOLa=ZT4nws0irdZKUuWc70Rv9RUNQuSXnGAt1SnE1O+umSReg@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 22 Jan 2025 09:28:40 -0800")
References: <xmqqwmetgdgm.fsf@gitster.g>
	<CAOLa=ZSyEg8G9g1B78VRymgfk9eo=d3KkhD=+S14_BSqaAO2Mg@mail.gmail.com>
	<CAOLa=ZT4nws0irdZKUuWc70Rv9RUNQuSXnGAt1SnE1O+umSReg@mail.gmail.com>
Date: Wed, 22 Jan 2025 09:38:33 -0800
Message-ID: <xmqqa5biyciu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> * kn/reflog-migration-fix (2025-01-15) 1 commit
>>>   (merged to 'next' on 2025-01-16 at ae8f9ce9a0)
>>>  + reftable: write correct max_update_index to header
>>>  (this branch is used by kn/reflog-migration-fix-followup.)
>>>
>>>  "git refs migrate" for migrating reflog data was broken.
>>>
>>>  Will merge to 'master'.
>>>  cf. <Z4mUizLNUdq_1BgY@tapette.crustytoothpaste.net>
>>>  source: <CAOLa=ZTL9n_DPhNr49XAd6bT838kc09oVx_AH7Pb4o8VK_xQ9w@mail.gmail.com>
>>
>> This seems to be breaking on 'next'. I tested it locally with
>>
>>   GIT_TEST_DEFAULT_REF_FORMAT=reftable meson test -v --test-args='-i' t1400-update-ref
>>
>> my local tests were made on files backend, and it didn't trigger on the
>> CI either for some reason (I shall investigate that soon). But dscho
>> (CC'd) reported that macos builds for reftable were failing [1] for his
>> branch and I could bisect it to this.
>>
>> I'm yet to understand why this fails and also why the CI didn't notify
>> of the issue. But that is something I shall do next. For now we need to
>> remove it from next.
>>
>> [1]: https://github.com/dscho/git/actions/runs/12906424058/job/35987723223
>
> This is reproducible when the leak sanitizier is enabled and tested
> against reftable:
>
> So setting up meson with:
>   CC=clang meson setup --reconfigure -Db_sanitize=address,undefined build
> and running the test in the build folder with:
>   GIT_TEST_DEFAULT_REF_FORMAT=reftable meson test -v
> --test-args='-ixd' t1400-update-ref
>
> reproduces the issue. I haven't found the root cause yet, but will
> mostly call it a day and get back to this tomorrow.

Thanks.  I'll mark the topic as on-hold.

