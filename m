Received: from 1.mo584.mail-out.ovh.net (1.mo584.mail-out.ovh.net [178.33.248.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD98298CD1
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 14:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.33.248.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751899501; cv=none; b=WcGhLVkAwVJ7EiUPIzMBXVJMGG4cTkwYK+A3sJiiA+4SlWGhW4gMU9r36CDYdWGAgyRX7JjkpOlVZr5SlCvooOx9Dlhk+heyHzMKnQJkaz37p9JJN1HqAn7iGjcgEDR25BKHgx0UeXOqOelbnlSTyFeKtqdR8oK3VCAcaUs3gnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751899501; c=relaxed/simple;
	bh=S+bU2YKlLTJDHdSyFcn4IKHkxups/QNcjzyWnNL3XBI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=A8hfMahBx04qUT3uDZopEMj2BSrjycAU4Ye8FtBIhclPiOyjD5NT9lI7YzaJ1zpNK7LAyOS4ZROqJ2M3sBE/9ahu1u9qfroCTMHBQxGVJZKMuiXSYjWHUkGL9gD05igFiCqsKa1Emm+aPIRy6cpxWxEh5186D0HlmE8TcYHk+n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redoste.xyz; spf=pass smtp.mailfrom=redoste.xyz; dkim=pass (2048-bit key) header.d=redoste.xyz header.i=@redoste.xyz header.b=vPzKni+b; arc=none smtp.client-ip=178.33.248.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redoste.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redoste.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=redoste.xyz header.i=@redoste.xyz header.b="vPzKni+b"
Received: from director3.ghost.mail-out.ovh.net (unknown [10.110.43.183])
	by mo584.mail-out.ovh.net (Postfix) with ESMTP id 4bbRNg4cN7z8Bph
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 14:25:39 +0000 (UTC)
Received: from ghost-submission-5b5ff79f4f-fh8bz (unknown [10.110.113.35])
	by director3.ghost.mail-out.ovh.net (Postfix) with ESMTPS id D377DC087B;
	Mon,  7 Jul 2025 14:25:38 +0000 (UTC)
Received: from redoste.xyz ([37.59.142.111])
	by ghost-submission-5b5ff79f4f-fh8bz with ESMTPSA
	id 0tuVKOLYa2j0TwAAkbPr8w
	(envelope-from <redoste@redoste.xyz>); Mon, 07 Jul 2025 14:25:38 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-111S0054112a195-06a0-41ec-a7b7-a0684b03a896,
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
Date: Mon, 07 Jul 2025 16:25:28 +0200
Message-Id: <DB5W4LH0MI5K.EJ0IILQ1IWR@redoste.xyz>
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
In-Reply-To: <05d66f9c-78b6-4624-a0e3-32235df05105@gmail.com>
X-Ovh-Tracer-Id: 15628335135047849365
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -30
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefvddtfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlhcuvffnffculdejtddmnecujfgurhepggfgtgffkfevuffhvffofhgjsehtqhertdertdejnecuhfhrohhmpedfrhgvughoshhtvgdfuceorhgvughoshhtvgesrhgvughoshhtvgdrgiihiieqnecuggftrfgrthhtvghrnhepjeeuteeiuefgleevvdffleeiieeghfdufffgieettdeuhefhgfettefhleeihfeknecukfhppeduvdejrddtrddtrddupdeivddrfeegrddvgeelrdefjedpfeejrdehledrudegvddrudduudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomheprhgvughoshhtvgesrhgvughoshhtvgdrgiihiidpnhgspghrtghpthhtohepuddprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehkeegmgdpmhhouggvpehsmhhtphhouhht
DKIM-Signature: a=rsa-sha256; bh=S+bU2YKlLTJDHdSyFcn4IKHkxups/QNcjzyWnNL3XBI=;
 c=relaxed/relaxed; d=redoste.xyz; h=From; s=ovhmo3968190-selector1;
 t=1751898339; v=1;
 b=vPzKni+bqA/sqc3z2rKfC+7lVaK3pXs5lg8/6PCzXKACUTHtPMOvD3qsRr9NCrAPEEnp4ecA
 fw30tFEKQ2ACsq+SjwASWw7vFYFMg3BfBNl77Un1RQfYZEXtj19ODp3v5JQAlhedX5gIGCsWk62
 QcAFkrDJr5oMrIoDhALyzKKrtZJw99/SM7BKpd2ICg8Q3TBinVLIliJ8P2Ik+hfcp+RKJ4HQ9Qf
 vpKnvsY9I8vR33o728T7XM9FvVgLpvzWa0kHW94mztXxeeQWqvh4OPw+daWAMagh6TaJBas18yB
 iivkXhS3QZR4n6JyYw3dqWtpnnj8Ci7qLJgd0oB3MzB/g==

On Mon Jul 7, 2025 at 11:35 CEST, Phillip Wood wrote:
> On 07/07/2025 10:02, Patrick Steinhardt wrote:
>> I think this exported environment variable now leaks into subsequent
>> tests, doesn't it? We may want to do it in a subshell.
>
> That's a very good point.
Sure thing, I took inspiration from the previous ssh-agent test and it
exports the ssh-agent variables without spawning a subshell, so I
figured it was fine, but it was only because test_when_finished will
fail in a subshell.
I guess it's probably fine to leak only the ssh-agent variables
accross tests and keep TMPDIR in a subshell.

> The idiomatic way to test for an empty file is "test_file_is_empty=20
> <file>" which avoids spawning wc.
Thanks, I will update this.

> As this test is an abridged version of the other test that uses=20
> ssh-agent I think it would be more efficient to tweak that test to check=
=20
> there are no temporary files left over. Our test suite is slow and=20
> tweaking an existing test to improve our coverage instead of adding a=20
> new test means we don't make it any slower than necessary.
I moved this test out of the other ssh-agent one according to the advice
from brian on the previous version. I agree that spawning multiple
ssh-agent is definitly not the best for speed, but is it worth it to
make the test failure less clear?
I feel like it's not the best to keep checks for temporary files clean
up in a test that (initially) only claims to sign commits.

--=20
redoste
