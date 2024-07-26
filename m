Received: from 19.mo583.mail-out.ovh.net (19.mo583.mail-out.ovh.net [46.105.35.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B510917B40A
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 12:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.35.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721995433; cv=none; b=WJxccvl5kFqEpwLtRhFJf6UjzHneeD8W+/5czOuXSqJv4z0V7+C8w2gVXAP91jAAWCjdY9WDh3H1RDxnkjKMnpSKogZZGJTJLNuP95BLORMbaHCog1vsioSthQ9A4EaWlMsnOPbnQtGR1xrmgmaGG8yIE4pZL4ku7IvcxGjCLOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721995433; c=relaxed/simple;
	bh=NKO+rHXJDlfe7CEtVF++/KL/AIKc213V8YZX03ztS/Y=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=r5YAtZ3XzPiXJ2Y8FUmCZ7qk0HHafMxqtOfDQ78IJSD8BjZw3gpOr5cqo8fMBu1b8BeVznmppZYlhVTLK5RpPvPTR0l0qUyeAomSsOJxx4IMMiwQNO/9S8m15WxjLsp1noDM4Ygyi8l4mwGXbVrQD71ldvfVAsNcHO88c4S9/qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=3mdeb.com; spf=pass smtp.mailfrom=3mdeb.com; dkim=pass (2048-bit key) header.d=3mdeb.com header.i=@3mdeb.com header.b=l6ws+Ots; arc=none smtp.client-ip=46.105.35.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=3mdeb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3mdeb.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3mdeb.com header.i=@3mdeb.com header.b="l6ws+Ots"
Received: from director8.ghost.mail-out.ovh.net (unknown [10.108.25.63])
	by mo583.mail-out.ovh.net (Postfix) with ESMTP id 4WVgn169ccz1RjH
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 08:25:41 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-54rms (unknown [10.108.54.44])
	by director8.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 86DB11FEBA
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 08:25:41 +0000 (UTC)
Received: from 3mdeb.com ([37.59.142.101])
	by ghost-submission-6684bf9d7b-54rms with ESMTPSA
	id Xb3fF4Vdo2Z6dAAAN4Kx3g
	(envelope-from <michal.iwanicki@3mdeb.com>)
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 08:25:41 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-101G004d5954d09-e74e-4ed2-8cd4-9c558056ba24,
                    55FB58B3AD844CC57B6C5185286253E45BD67BBB) smtp.auth=michal.iwanicki@3mdeb.com
X-OVh-ClientIp:89.73.147.156
Message-ID: <3856e339-3c93-4c29-a668-334bdd7bff7a@3mdeb.com>
Date: Fri, 26 Jul 2024 10:25:40 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: =?UTF-8?Q?Micha=C5=82_Iwanicki?= <michal.iwanicki@3mdeb.com>
Subject: Does GIT_SSH_COMMAND apply to all git commands that connect to
 remote?
To: git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 6738792417491574523
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrieehgddtgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepkfffgggfhffuvfgtgfesthejredttddvjeenucfhrhhomhepofhitghhrghlucfkfigrnhhitghkihcuoehmihgthhgrlhdrihifrghnihgtkhhiseefmhguvggsrdgtohhmqeenucggtffrrghtthgvrhhnpeffkefgkeffueekueehffffvdegiefftefgffetveduhfevgeekhffggfelhedvgeenucffohhmrghinhepghhithdqshgtmhdrtghomhenucfkphepuddvjedrtddrtddruddpkeelrdejfedrudegjedrudehiedpfeejrdehledrudegvddruddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepmhhitghhrghlrdhifigrnhhitghkihesfehmuggvsgdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehkeefpdhmohguvgepshhmthhpohhuth
DKIM-Signature: a=rsa-sha256; bh=NKO+rHXJDlfe7CEtVF++/KL/AIKc213V8YZX03ztS/Y=;
 c=relaxed/relaxed; d=3mdeb.com; h=From; s=ovhmo3617313-selector1;
 t=1721982342; v=1;
 b=l6ws+OtsNwsV4B5AtcVyTgCHx+zpQxneqVbJ9v9rycM4WOlDVYDvdjk5uCsRwX3rHdlTbL8X
 g8BrisTZJP9D1BqcoMY+kg16PLGrlkaVUkj0K7V8Iqr3er66v95hXr3sXA10j47L7N/eMxz7aup
 R1u5GoKJf9feNSbYKN2Y6GGGBFd6EIOuWA13ev7CoE51wrEw8m++gj/mjx7NUn2RONjPbWYd+PM
 HP1ZtQQzLrnq8ElzyBd4kNzquLMtQUiXKOfmm/fItTlzyfYoZHy+ZO0kLKXU+jrCPu060CjGzJQ
 W9hQAYBwRnyJj2dmIh7zIz7DBuQw4bYLg0IC5r4zqyP6A==

I'm asking this question, because in docs it explicitly mentions git fetch and git push. Does it apply do other commands
like git clone? If yes then maybe this information should be added?

https://git-scm.com/docs/git/2.45.1#Documentation/git.txt-codeGITSSHCOMMANDcode

> If either of these environment variables is set then git fetch and git push will use the specified command instead of
> ssh when they need to connect to a remote system
