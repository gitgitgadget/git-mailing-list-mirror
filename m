Received: from 6.mo576.mail-out.ovh.net (6.mo576.mail-out.ovh.net [46.105.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0004429E0F9
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 17:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751823473; cv=none; b=JDedswZHvYl8xlYdvSFkA93T7nP20y+Th4AT5vqYmaftPNC4/SDe4q7EYpH/wRHfLzaWbtNVTeK05VCbSsxWY0sLpJHGIEMcs6wYgqvNdJN7fCVT4YXWATF5dvLQ6OjQpZObzHz7edPC5lfAfCbo9fGk18UOqQtcBXbTAYDGrJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751823473; c=relaxed/simple;
	bh=r0WrIgsvsDIcuyfuNKzZp91/mNqm+09/z3VdXXut/4I=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=jdqTwDibZTCabHx4UlFtwHHYxZvxdlC9OYYnC7E/PwkmNRZqxZhSOEFzBnge9zdt+TLEknTXz2sZ9hGUWZCwgSrwrSfBsK4kVd5v9XZ3CSk3A8JxfQ4VapI2rJlpw3Jc0tlA7du1OfHCBOSGqYB5YWDNWYPpXpM3qwRkh3lIogE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redoste.xyz; spf=pass smtp.mailfrom=redoste.xyz; dkim=pass (2048-bit key) header.d=redoste.xyz header.i=@redoste.xyz header.b=ghqg1jOC; arc=none smtp.client-ip=46.105.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redoste.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redoste.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=redoste.xyz header.i=@redoste.xyz header.b="ghqg1jOC"
Received: from director1.ghost.mail-out.ovh.net (unknown [10.109.249.19])
	by mo576.mail-out.ovh.net (Postfix) with ESMTP id 4bZvJX4VpHz60X9
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 17:20:12 +0000 (UTC)
Received: from ghost-submission-5b5ff79f4f-4zhm4 (unknown [10.110.101.129])
	by director1.ghost.mail-out.ovh.net (Postfix) with ESMTPS id DE275C15F0;
	Sun,  6 Jul 2025 17:20:11 +0000 (UTC)
Received: from redoste.xyz ([37.59.142.95])
	by ghost-submission-5b5ff79f4f-4zhm4 with ESMTPSA
	id Yy0CIkuwamh4yAcAAS1fKg
	(envelope-from <redoste@redoste.xyz>); Sun, 06 Jul 2025 17:20:11 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-95G001ca824b82-5cac-40d5-82fc-6af36068a7b2,
                    03B360DA9A158DBC4F736A687BEA6D6B8F7DE961) smtp.auth=redoste@redoste.xyz
X-OVh-ClientIp:62.34.249.37
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 06 Jul 2025 19:20:08 +0200
Message-Id: <DB557SHQD36C.2MWS0EROQIBO5@redoste.xyz>
Cc: <git@vger.kernel.org>, "brian m. carlson"
 <sandals@crustytoothpaste.net>, "Junio C Hamano" <gitster@pobox.com>,
 "Fabian Stelzer" <fs@gigacodes.de>, "Elijah Newren" <newren@gmail.com>,
 "redoste" <redoste@redoste.xyz>
Subject: Re: [PATCH] ssh signing: don't detach the filename strbuf from
 key_file tempfile
From: "redoste" <redoste@redoste.xyz>
To: "Jeff King" <peff@peff.net>
X-Mailer: aerc 0.20.1
References: <20250704230829.29696-1-redoste@redoste.xyz>
 <20250705192113.GB2496172@coredump.intra.peff.net>
 <aGmGCmkwC1HlSyog@fruit.crustytoothpaste.net>
 <DB4HMD2HLG24.1V8Y9JDW6BACQ@redoste.xyz>
 <aGnDO3HIAQgsRbnJ@fruit.crustytoothpaste.net>
 <20250706031337.GA3041790@coredump.intra.peff.net>
In-Reply-To: <20250706031337.GA3041790@coredump.intra.peff.net>
X-Ovh-Tracer-Id: 12703528651241198997
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -30
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvleehtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlhcuvffnffculdejtddmnecujfgurhepggfgtgffkfevuffhvffofhgjsehtqhertdertdejnecuhfhrohhmpedfrhgvughoshhtvgdfuceorhgvughoshhtvgesrhgvughoshhtvgdrgiihiieqnecuggftrfgrthhtvghrnhepjeeuteeiuefgleevvdffleeiieeghfdufffgieettdeuhefhgfettefhleeihfeknecukfhppeduvdejrddtrddtrddupdeivddrfeegrddvgeelrdefjedpfeejrdehledrudegvddrleehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehrvgguohhsthgvsehrvgguohhsthgvrdighiiipdhnsggprhgtphhtthhopedupdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheejiegmpdhmohguvgepshhmthhpohhuth
DKIM-Signature: a=rsa-sha256; bh=r0WrIgsvsDIcuyfuNKzZp91/mNqm+09/z3VdXXut/4I=;
 c=relaxed/relaxed; d=redoste.xyz; h=From; s=ovhmo3968190-selector1;
 t=1751822412; v=1;
 b=ghqg1jOCmdFyzuv088EfTdbhUbL98OgvlImgyDFxIurgO3RKHKwx11gEMdm47oIaxMGqTRb0
 x/LIwJ0zBjGZ/Bohh4QxX47D0OHtGANPkz0F+/A4OzVaBQtDaVokDDDf1cHDUBw2NW1RPhJUq3b
 fsrwxzEOaFyJIJ7/6pBPHAtLxX6hgBl6pZNyOi8i5G2BTSiid6jFSFwgCoEcJnEw8tKOjwa2oMp
 8tm29uUNMVHeJgroOZpTbOiHCqUSDZDaRcLGtM6DSxQd5dVcfuCgMqjx48kdmEWFm3kSLc/VcZj
 G0Qm8fo7z+G9XEkYdx4vn4LicB0cV3pZZI/ZjEdJUt7Gg==

On Sun Jul 6, 2025 at 05:13 CEST, Jeff King wrote:
> And thanks redoste for your patch. ;) Sorry if bringing up the signoff
> issue caused any hassle (but hopefully it will lead to an improvement to
> our docs).

No worries! I completely understand your position as a reviewer and I
don't mind if it helps to improve the situation and will help future
contributors.

--=20
redoste
