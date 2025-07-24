Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32161494C3
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 21:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753391436; cv=none; b=AcrNf89qQLG6+RQ4E1PAJTITZRisnHhf6nbsiHVRHoBWHGj11TX/MH8bReCqNeHZ0Kv5EtrnIl5Uu7ftt3dNDggGwHiuyKWjbeAtcS3AefjX2wY8Z/iHQQk0/ju8xx+YLceEjyMqJ/WuEANaF2h7cq41uUKKrkznZe5Q/sF9+oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753391436; c=relaxed/simple;
	bh=N4jfyE49cunsoKTWSaQ08UgQjqbfr/r3dfWyStmA8u0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PVyQFYscgBNLtkx4FWnALM/GVmShfv0zssWhb57pgR0zvIGisXRUUVVf4SyEEOF9Igo2VE9ccONedEC4fcRqrY3jxdbmSyaMuCEFk2Yt69Ko6dPToNK+d5IQhiih+88bPzYSlSvTNJe1Z3y01OHYTSo7BpmKGgrW3dL8e16234A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iHnN/ZCe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QD973/sk; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iHnN/ZCe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QD973/sk"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 95CA2EC02F2;
	Thu, 24 Jul 2025 17:10:33 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Thu, 24 Jul 2025 17:10:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1753391433;
	 x=1753477833; bh=dFo2vrtepf6UT8mSuuQm6d5I54k2wcbWkcxVy9qrxaQ=; b=
	iHnN/ZCe4cU2Cm4w1kyas8l9uXwaZxAvHy5+CSN/ZN7a2EtWkULQe9Iwia6EHpFl
	52cu4iPT/yE9bmq424nyM/QO3cE4ZzCczCtH89UEioJj+lXE+iZDo24EUvWS8BKG
	PI00rE7o6Qkq2HAw1WGQIOGVNx6IkR+bkwuTsdX3wBhkdnqjh3NIl3pLOm63pn+T
	QsFZQ/rro1m06xHLf9lsLNQH/9yae3X3taCQAeYpRVxmz400IfuxRIbxt/ZhiiAh
	divI3uE8TUBuC4r0HCMZG+rZJE/vU9MY387lIiVhDhAsOD2peAR5q3gJkV0qPwxv
	DEPPnaC7xxT3upeUdyZ6Gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753391433; x=
	1753477833; bh=dFo2vrtepf6UT8mSuuQm6d5I54k2wcbWkcxVy9qrxaQ=; b=Q
	D973/skytwWbaCHoC2AKr7lCpnUqb4Po1vr2f8YVln/YbbEU167RB993UzZ4tcHY
	Yb1lfAasDSitasdiIqNmsrc02YlsRt0Fwmtu9cDczugAa8mZWmJ/2DYetXRxwSuh
	kXoIv4wNGlXHcl8Mw1ciesRAxsRWpX+PyK+netucGFfu6T846jOMCQoRlCLnKdy/
	RFLrIliLQSAw1d/3gDbeMDbe9Wt+DfnYlE2p5KVMHrVpSr8AsUgAXOSAKklOYXSW
	TdJlTEBmY0xppLV/7+181pTr832ffUIomO6AWfNyWDN9RTe52czBntW+zB4V4pN6
	dO4I+Kt8cB8zU9brgELdQ==
X-ME-Sender: <xms:SaGCaBf0Fc0tPzUkzZD9Iv8VP_XVTVDfqBmObbInE0S9Ygx_srWGvg>
    <xme:SaGCaKsq7KUnXCTIR9KX6iYVNJilIotxLv40sSiq3efrcQl92YaXNx8DXaSHWf89o
    MptVt-PIte0efKKOA>
X-ME-Received: <xmr:SaGCaA_3KPk8AMRBEh37hOZHBwkJB4G-wEpxAWeIonRhexrZSLrQooH-oq-0t6Bl5oBN3NsBuxr6jhaPyYPZfNtguqZ1AZP2rJqNrvY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekudeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehk
    rghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:SaGCaF1oUt3TbRloPgQs3uKwkx7948Lmb7dRzJPRxs9Y-4e2axSvdg>
    <xmx:SaGCaFBXkiUWJox0vHlpZZ5T-rIisY_-qQJzZthbnr7BF5BLSlBJJQ>
    <xmx:SaGCaBdVuq3DkKryme_OuMW7wTRBzY2lOHX-NZsE29KSl3Nmy2-cUQ>
    <xmx:SaGCaC4mbrtTbzdstd5UDwJb7T6dnUmGb-ZNtzeMVeGw2jnr3JaxQw>
    <xmx:SaGCaBPgFog0QFM_P3twYtsjv-ofcMCJAmG5yS-lWgmwVspJtpkwfok4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Jul 2025 17:10:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH 4/8] builtin/reflog: implement subcommand to write new
 entries
In-Reply-To: <aIJdSCPEHoiWWxrP@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1bor?=
 =?utf-8?Q?=22's?= message of "Thu,
	24 Jul 2025 18:20:24 +0200")
References: <20250722-pks-reflog-append-v1-0-183e5949de16@pks.im>
	<20250722-pks-reflog-append-v1-4-183e5949de16@pks.im>
	<aIJdSCPEHoiWWxrP@szeder.dev>
Date: Thu, 24 Jul 2025 14:10:31 -0700
Message-ID: <xmqqa54tz454.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

SZEDER Gábor <szeder.dev@gmail.com> writes:

> On Tue, Jul 22, 2025 at 01:20:53PM +0200, Patrick Steinhardt wrote:
>> diff --git a/builtin/reflog.c b/builtin/reflog.c
>> index b00b3f9edc9..d0374295620 100644
>> --- a/builtin/reflog.c
>> +++ b/builtin/reflog.c
>> @@ -3,6 +3,8 @@
>>  #include "builtin.h"
>>  #include "config.h"
>>  #include "gettext.h"
>> +#include "hex.h"
>> +#include "odb.h"
>
> This series is queued on top of v2.50.0, which doesn't have 'odb.h'
> yet.

Thanks for checking.

Yet this is a topic to fix breakages that happened even before 2.50;
"git refs migrate" started migrating reflogs in 2.48, which had one
fix on top in 2.49.  For a non-security bugfix we typically do not
address anything older than the latest release's maintenance track,
so a series that would fix on top of 2.50 would have been more
appropriate.

