Received: from 12.mo583.mail-out.ovh.net (12.mo583.mail-out.ovh.net [46.105.39.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A3A1A316E
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 16:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.39.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751905368; cv=none; b=iDhNonznU9QxjbMB1Wfx7PqTlu+1UoZwhSZzXJ7wRv8+673BpnAIbWMKF+oIQCAWoRruOhNH5WPnKDPIOA3MEYS+XNDOg01IqHnEV7FfE9dn1GetFHZalE7ddKxJeYsRwf1jIA07vpFTIjflRjdOKkVOykki0LYprxIrxKiKClo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751905368; c=relaxed/simple;
	bh=NOtvoysODMWJcMhClgXYR2TaNDSd8wW8MjAxDWtI0FM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=joKoQd2sYzXeWxXgYQoURV18zmHNPdLH2ByO//H+MeIlw/8h1Yz/FRb65Qk+zMHjN/qMMkrmr5mksBnGxV9lTL2s3dYzGx7v8TnbNVDzHN6SuYB4SCACr6D3t2VtKT7LWruMHIxcJUJals2tER+AWlOB6BFDRcQBwH4h5shXVFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redoste.xyz; spf=pass smtp.mailfrom=redoste.xyz; dkim=pass (2048-bit key) header.d=redoste.xyz header.i=@redoste.xyz header.b=IxiIw08E; arc=none smtp.client-ip=46.105.39.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redoste.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redoste.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=redoste.xyz header.i=@redoste.xyz header.b="IxiIw08E"
Received: from director1.ghost.mail-out.ovh.net (unknown [10.110.54.85])
	by mo583.mail-out.ovh.net (Postfix) with ESMTP id 4bbTzY2HnTz6X0h
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 16:22:33 +0000 (UTC)
Received: from ghost-submission-5b5ff79f4f-f42j5 (unknown [10.110.113.120])
	by director1.ghost.mail-out.ovh.net (Postfix) with ESMTPS id EB8E1C1635;
	Mon,  7 Jul 2025 16:22:31 +0000 (UTC)
Received: from redoste.xyz ([37.59.142.114])
	by ghost-submission-5b5ff79f4f-f42j5 with ESMTPSA
	id /2bEE0f0a2iXEAEAZnShUA
	(envelope-from <redoste@redoste.xyz>); Mon, 07 Jul 2025 16:22:31 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-114S008f60d3274-2e9f-44cb-9850-3fe81ba5cd83,
                    D0C7EFB74D5D647EA3E92B704F5959655B36BFB1) smtp.auth=redoste@redoste.xyz
X-OVh-ClientIp:62.34.249.37
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 07 Jul 2025 18:22:25 +0200
Message-Id: <DB5YM57RVQTT.35ZS2BA5SHY@redoste.xyz>
Cc: <git@vger.kernel.org>, "Jeff King" <peff@peff.net>, "brian m. carlson"
 <sandals@crustytoothpaste.net>, "Fabian Stelzer" <fs@gigacodes.de>, "Junio
 C Hamano" <gitster@pobox.com>, "Elijah Newren" <newren@gmail.com>, "Patrick
 Steinhardt" <ps@pks.im>, "redoste" <redoste@redoste.xyz>
Subject: Re: [PATCH v2] ssh signing: don't detach the filename strbuf from
 key_file tempfile
From: "redoste" <redoste@redoste.xyz>
To: "Phillip Wood" <phillip.wood@dunelm.org.uk>
X-Mailer: aerc 0.20.1
References: <20250704230829.29696-1-redoste@redoste.xyz>
 <20250706173450.12995-1-redoste@redoste.xyz> <aGuNCGNk96DK4GzX@pks.im>
 <05d66f9c-78b6-4624-a0e3-32235df05105@gmail.com>
 <DB5W4LH0MI5K.EJ0IILQ1IWR@redoste.xyz>
 <7130651b-76a6-4eb1-93cf-c9e237d398d7@gmail.com>
In-Reply-To: <7130651b-76a6-4eb1-93cf-c9e237d398d7@gmail.com>
X-Ovh-Tracer-Id: 17602600622602032533
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -30
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefvddviecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlhcuvffnffculdejtddmnecujfgurhepggfgtgffkfevuffhvffofhgjsehtqhertdertdejnecuhfhrohhmpedfrhgvughoshhtvgdfuceorhgvughoshhtvgesrhgvughoshhtvgdrgiihiieqnecuggftrfgrthhtvghrnhepjeeuteeiuefgleevvdffleeiieeghfdufffgieettdeuhefhgfettefhleeihfeknecukfhppeduvdejrddtrddtrddupdeivddrfeegrddvgeelrdefjedpfeejrdehledrudegvddruddugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomheprhgvughoshhtvgesrhgvughoshhtvgdrgiihiidpnhgspghrtghpthhtohepuddprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehkeefmgdpmhhouggvpehsmhhtphhouhht
DKIM-Signature: a=rsa-sha256; bh=NOtvoysODMWJcMhClgXYR2TaNDSd8wW8MjAxDWtI0FM=;
 c=relaxed/relaxed; d=redoste.xyz; h=From; s=ovhmo3968190-selector1;
 t=1751905353; v=1;
 b=IxiIw08EgYEVDeYjcxU5+mmsXqwr8XJc/k9nl5yHqnRXQ5VkqZZ7pw7wax7nK53oePuUH5+7
 07TN94xEnI94Ic9NrOQ39WTkxunFSSms8fWYcl0NbtVSGThubxn3fGCxHxAw6Sj52U1XnLuCLPM
 T1X9EDtIEp0ReZIo0xPdrHTztnQznxkhJdXFVevi0AHj47X8PFEtRVMVFw233QJCreMKdd+mHie
 lqW9GHqyBCvIvnO+o2dO6hbHTxHDbj+CROjHI9t29xzvswP+ht8HOqQJZ+bfmNNFS4GslyCJR24
 eC0BzTarm6T7XZimhBAPBvv14whYXTtwvQOriAm+y4nvA==

On Mon Jul 7, 2025 at 17:26 CEST, Phillip Wood wrote:
> test_file_is_empty will print a diagnostic message if it fails so it=20
> should be clear what has caused the test failure
Uh, okay, this makes sense and I think it will be clear enough.
However there is only `test_file_not_empty`, `test_file_is_empty`
doesn't exist. I will implement it in an other commit.

> The way I see it is that the changes that are being tested are related
> to commit signing as the invariant that we want to assert is that
> temporary files are cleaned up after signing commits.
I see.

I will update this for a v3.
Thanks for the feedback!

--=20
redoste
