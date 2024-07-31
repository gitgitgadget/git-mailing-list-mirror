Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7529C168B8
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 15:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722441408; cv=none; b=IhW19YQA2yFpz1YtZBcpKofoyDPhr/WBiGcMN8L2cN0gkkf752t6ZJ+Pi8/+4k8VnxnvDFzWpSuPPvMGz3tqi0SBqt+I55gM/uAWPD3/0RPwfg3khpO7KttfOy/yBRwJ4y+Mdrk91SCJZ8I3dMM9KWKYoYagU6/YAaQr0XNZDb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722441408; c=relaxed/simple;
	bh=Kg0qihdEB9fhNBk+4P+F32dstFhFbnFHtgAkGFukpqU=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=lxXxSO5n5O6flTxXO+a8/09xqO3I1sO0nIylBOS9Fd+lpAU1SG6aLPQcpqkYKaBajaqeWiTd2PocGaY2Qs7yl6AUv9oqYMMrTq/tkFNF3GyQo67bCpVjGJtDfeoJxSjjaiH3q11kWxkiWroximw9KKm2BE/irH33HpbUArA394o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 46VFuYnT3265922
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 15:56:35 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>, "'Patrick Steinhardt'" <ps@pks.im>
Cc: <git@vger.kernel.org>, "=?utf-8?Q?'Ren=C3=A9_Scharfe'?=" <l.s.r@web.de>,
        "'Kyle Lippincott'" <spectral@google.com>,
        "'Phillip Wood'" <phillip.wood@dunelm.org.uk>,
        "'Josh Steadmon'" <steadmon@google.com>
References: <cover.1722415748.git.ps@pks.im> <xmqq7cd18srf.fsf@gitster.g>
In-Reply-To: <xmqq7cd18srf.fsf@gitster.g>
Subject: RE: [RFC PATCH 0/3] Introduce clar testing framework
Date: Wed, 31 Jul 2024 11:56:29 -0400
Organization: Nexbridge Inc.
Message-ID: <008901dae362$386ae280$a940a780$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQE2Q9x0fuag13GoRDOLG7kBaq5wcQG2RBBYs0yKY/A=

On Wednesday, July 31, 2024 11:51 AM, Junio C Hamano wrote:
>Patrick Steinhardt <ps@pks.im> writes:
>
>>   - The clar gives us the ability to pick which tests to run via =
command
>>     line parameters, which I personally like more than picking the
>>     specific binary to run.
>
>One thing I am very unhappy about the current t/unit-tests/ is that the
>GIT_SKIP_TESTS mechanism is not effective at all.  If we can wrap =
clar's test selection
>syntax inside t/Makefile to work with GIT_SKIP_TESTS (or its superset =
equivalent),
>that would be a great plus.
>
>>   - The clar replaces some test assertions that we already have. They
>>     feel a bit more mature, but overall there aren't all that many
>>     assertions available. If we wanted to pick it up, then we'd =
likely
>>     have to add some more wrappers.
>
>That is a slight bummer, as importing an externally developed one is =
with the hope
>that we won't have to enhance or maintain it, but we'll see how much =
burden it will
>be.
>
>>   - The clar uses longjmp instead of manually having to `return` from
>>     functions in case there was an assertion failure. This is easier =
to
>>     work with in my opinion.
>>
>> Also, note that I only tested this on my Linux machine. I have no =
clue
>> whether this works as-is on Windows, but I do know that libgit2 tests
>> run on Linux, macOS and Windows. So it should work in theory, it's
>> just a matter of polishing this series.
>>
>> I'm happy to hear your thoughts on this, even if it ultimately ends =
up
>> being shot down.
>
>Thanks for getting the ball going.  Let's see how fast and far it =
rolls.

I'm sorry for being so behind the curve... what is clar and where does =
it run?

