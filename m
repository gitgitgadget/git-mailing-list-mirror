Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.107.222.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792841498;
	b=yUE6D5indnvF08/hhZ5mAhcLKxHed6F6qFlnyXKzTIcPCjcHs8lYRAQlofhBrVqc3wPA
	 sumfZKZ/5YZ/DuChpZ6NC1G8D/QcaO5YRsbE3A2P6ZEcWVVsah8ejmbJc8YXezrQ3ZUMj
	 ClSuvJ3Uel117ZaKReUpkR/l/Xe4SYsLorDWxkuYOsQFCfMqbkY/J0EBO17woqZTfRD+f
	 aI5s73DqQ/0Gdx2Uq3M/inyPNg3uPB1xQ5QdNQmvjHxZBzPxOyl3CkrNfH2HEsBFzjn8T
	 tXsl5Ap33+cN/tVyaBpcWiVZFQ1iG46UyAglQ+n0Mdf4SXsWwL63o9RVeyeGeDVODLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792841498;
	h=DMARC-Filter:Received:Date:From:To:CC:Subject:User-Agent:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Hcd8HsSftTRZj4H5rHeDI1GmLPjkdsQL43V4oIcbxL8=;
	b=pIzOtjf3fl5uLPcUVHi9SzmOzumjLWmu/hRvRTsieVra9tyeU+qVSN1CwxdsHhAqRlMP
	 R87k1juZ5Y6/WJVIVkPv1EgemhtT7gfwEwIprwd/kkCmZ35kwJZA3E4zr47ANvLcI5cfQ
	 FhgxFbgaI3EHVO0o5XmNwT6fOJJAMUBm2Hmm0xJ3g7i1hfKFnqoeg3nMQcQrSEsaR41j9
	 MWn7yYfEKuWzIP3W2k5ZAwmn/uHbnS9o/pUwrtJs5yJgR8z8EDZlK2XJJBwwxCKMZr4ud
	 XQ7IjUdaATq3GTWF2UErBuS3F04jt07rYZTwy1eBdvIijZ1n+I4WgQ1d8b9bT0AlSQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=zombino.com;
	spf=pass smtp.mailfrom=zombino.com;
	arc=none smtp.remote-ip=91.107.222.152
Received: from mail.zombino.com (c3.zombino.com [91.107.222.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D850606A31B
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 11:31:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D850606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zombino.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zombino.com
Received: from ehlo.thunderbird.net (unknown [176.235.169.138])
	by mail.zombino.com (Postfix) with ESMTPS id 08A541C3C596;
	Sat, 24 Oct 2026 11:31:25 +0000 (UTC)
Date: Sat, 24 Oct 2026 14:31:22 +0300
From: Adam Majer <adamm@zombino.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
CC: git@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: discussion: sha1/sha256 repositories and convert_commit_object
User-Agent: K-9 Mail for Android
In-Reply-To: <atk63xoG773PzGq7@fruit.crustytoothpaste.net>
References: <ce3756bc-704c-41ff-bf8a-c060a2848aeb@zombino.com> <atk63xoG773PzGq7@fruit.crustytoothpaste.net>
Message-ID: <70D18A25-A2AB-4237-8C63-063CEE8BBBC9@zombino.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 22, 2026 1:21:20=E2=80=AFa=2Em=2E GMT+03:00, "brian m=2E carlson=
" <sandals@crustytoothpaste=2Enet> wrote:
>On 2026-10-21 at 17:37:13, Adam Majer wrote

>I had noticed that the mergetags were not in Linus's repository, but I
>hadn't tried other repositories on kernel=2Eorg=2E

There is about a dozen or so mertags that I cannot find their objects=2E T=
hey have references to other repos, but trying those, they remained unresol=
ved=2E One mergetag had some 3rd party url, which wasn't working, but http:=
// access allowed me to resolve it=2E One from a dozen missing resolved=2E=
=20



>> Would it be possible to have a little different approach? For example,
>> mergetag headers and other unknown headers, maybe we can consider these=
 as
>> just text and copy verbatim in convert_commit_object? I understand this
>> would result in different commit ids, depending if coming originally fr=
om
>> sha256 or sha1 repo, but since git is not really preserving references =
to
>> these objects anyway, this may call for a little flexibility=2E
>
>I don't think I converted mergetag entries in my original series=2E  The
>problem is that if we don't convert them, then we also can't validate
>them because we don't know what data they point to=2E  We don't make
>assumptions based on the size of the hash because in the future we might
>also have SHA3-256 or BLAKE2b-256=2E

I'm not sure that is quite correct=2E Any supported hash function should b=
e unique enough such that we can just try all of them=2E So, a mergetag or =
proprietary headers, if we just treat them as text in conversion function, =
they can be retrieved later using the original function=2E Hash function do=
esn't matter for their existence or validity=2E I'm assuming here that the =
original repo containing them is not replaced in the meantime=2E

Basically, I'm assuming that a repo url keeps their original hash function=
=2E

The most important part here is to be consistent=2E These shouldn't be con=
verted when available and skipped otherwise, or history becomes nondetermin=
istic and depends on ingenuity of converting person to find these objects=
=2E=20


>That means that the original point of the mergetags, to preserve the
>signature and contents of the original tag, would be useless=2E  That
>doesn't mean we couldn't skip converting them, but it does mean that if
>we do so, we should probably just stop writing those headers because
>they're no longer fit for purpose and we should consider them a failed
>implementation=2E

My problem is these mergetags have url where they were published=2E But th=
ey are quite missing on the git=2E kernel=2Eorg in these repos=2E

We can still convert the objects, but references would go via loose object=
 table=2E


As for unavailable submodules, like in NodeJS repo from over a decade ago,=
 I think they'll be unconvertible=2E It's not really possible to skip these=
 without making a mess of history=2E Or perhaps you have an idea here?=20

- Adam
