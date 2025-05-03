Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AE42F30
	for <git@vger.kernel.org>; Sat,  3 May 2025 01:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746234320; cv=none; b=bPStCbtgL7MlJMeSypaO4ocrjgCTUqytXxXCKL8di2WQlKt1Ai+0OKD/ppslvZXAYCCghDa2v0lMkC2y9J/TYUmxICGTa1OIs33FNJ2GuVccHt2OZ5BFTRdU5ITUCdKmWUnjb2wPH8HkH9+0UWl3sbps8RAeorZ4Mpf+sDvbK8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746234320; c=relaxed/simple;
	bh=ORxcHNKkjrq/A3CY0vgXndr37B47FycXO8EZ4GSgvuM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pAmV6wjE1oMXHaUxuYpVUsNJhj8Me9Ezbr7LbRFCImD4j2QLuQfvsz8uKKpIjOParr4E5/pPeIJhQWRy9LjBZLaNKV7ojHgB2ubef+GPwwJURxyxb3h+Up5e2PJnRpgnQSAsxVzya0zgpobOrEwaO3bfpFZKc9+fv/pu+vqFYAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XDHKUaGO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t+Jjvup6; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XDHKUaGO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t+Jjvup6"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id CCCB31380F25;
	Fri,  2 May 2025 21:05:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 02 May 2025 21:05:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746234316; x=1746320716; bh=KcCj9ZzANh
	fh/XEm6jeKdHhyrTTFVp8ID4BRtgGxyAE=; b=XDHKUaGOGM0A6Bzxdx6Ms/r8Sm
	8MmHcoyUYtDMlDpC/rTaVSIoQj9NBZMXCNLaVkthQJWiSKG9DtNC61Na9+n+DkA+
	FTfgI/7ly+i0IHG4zTvV2MzPrAxrrpqZfmz5mUfelwb7u6fvhU9VLtyQy1Ukgo3V
	fOhR/lnckAT0FFhQQlG6Qntxulh50Lmio2Y4P8iGL2s7KhkbJrDLN8AmEYkHEWpy
	z7vC/35VJkHQX+0/Tp9yzfsMAqIFe5CX0eiWxmildlGzV/0XFnLnjAk07tGzZy03
	0I3LciUtxvmOtDmoZuZSlEjd037ZcpgqWSB7KtgcK4I8IlCWeiZ3jFr9uUyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746234316; x=1746320716; bh=KcCj9ZzANhfh/XEm6jeKdHhyrTTFVp8ID4B
	RtgGxyAE=; b=t+Jjvup6/VvhQSEYrmTCslFN0cZsjv7NXkxkhaNR0doFcyZRn+A
	QA2UxQGv6CY4cPzK3weMrCFmZrE1zjF60HS9rRLt5koXJqnNhdeH55My6MLvFfjx
	SGEU4CQhPtHE1RfvDbNOWpR+bHENsrdydr8aAq5Ybvq+Ji7xBaDaHukMGfSd+A4J
	ZT3PDY5UVUJtEDACyLLT6KBZwBpL6T1fveFnDX0rOb+RqRxnt9f/MKAbU76Og5BM
	Sj0KVCcJ0oEAvm4tvfG3FcRCsOjU6EbGHmvdq9C9GhVhwqeQ9R3Ia88g+Ly4Xfsk
	DYP+/oMJZ51f8GOSoN1He1fZc4v4RTWX3lw==
X-ME-Sender: <xms:zGsVaOBBkhL4dPemNvG6wzP5E03J5rFEy0L4L-8AfsJOgsS83ruVRg>
    <xme:zGsVaIho65Ffb_eslCZUkceCymlGlI9OF_OzqRbJknpHC-6aARJ92kTOmEkLCcTV4
    a9GvbgAHuqazkA-UA>
X-ME-Received: <xmr:zGsVaBkK5uXKPKPK1wpUeR97RUg6cVIqY3J6qWIZae6TlauiInV3SI3UnNu98JyQp2lZwEW9B_kWWkDvfNfr6PJDFu73exkicOWS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeefleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlsh
    estghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtoheptgholhhlihhn
    rdhfuhhnkhdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:zGsVaMwu9NE8DR65_IIEfnhxmhAmsH1dG0u8_CAVvv1NwiPZMESx9Q>
    <xmx:zGsVaDT5Vg9eFswscxgGSeSR7p2PptlV-9F0KBZ0vuOuiTCLK8HkLw>
    <xmx:zGsVaHZvwwD99z8zuKhxLZxo0UjZ-ZBo39sOhywG5tplzBcfcec_MQ>
    <xmx:zGsVaMQKwHCyv1HYUlVLBiOO13NgXBH-Ofo858tTHyjjGPw9DViTjg>
    <xmx:zGsVaL88wfjjDpI33XSjSg-qHGV28TtYqxxkA0rZMIxmVvB9BRIeBWJ_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 May 2025 21:05:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Collin Funk <collin.funk1@gmail.com>,  git@vger.kernel.org,
  shejialuo@gmail.com,  Jeff King <peff@peff.net>
Subject: Re: [PATCH] wrapper: Fix a errno discrepancy on NetBSD.
In-Reply-To: <aBVp51yLwxBpRskt@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Sat, 3 May 2025 00:57:11 +0000")
References: <20250502233403.289761-1-collin.funk1@gmail.com>
	<aBVp51yLwxBpRskt@tapette.crustytoothpaste.net>
Date: Fri, 02 May 2025 18:05:14 -0700
Message-ID: <xmqqtt62sdv9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2025-05-02 at 23:33:32, Collin Funk wrote:
>> As documented on NetBSD's man page, open with the O_NOFOLLOW flag and a
>> symlink returns -1 and sets errno to EFTYPE which differs from POSIX.
>> This patch fixes the following test failure:
>> 
>> $ sh t0602-reffiles-fsck.sh --verbose
>> --- expect	2025-05-02 23:05:23.920890147 +0000
>> +++ err	2025-05-02 23:05:23.916794959 +0000
>> @@ -1 +1 @@
>> -error: packed-refs: badRefFiletype: not a regular file but a symlink
>> +error: unable to open '.git/packed-refs': Inappropriate file type or format
>> not ok 12 - the filetype of packed-refs should be checked
>> 
>> This portability issue was introduced in Commit
>> cfea2f2da8 (packed-backend: check whether the "packed-refs" is regular file, 2025-02-28)
>> 
>> Signed-off-by: Collin Funk <collin.funk1@gmail.com>
>> ---
>>  wrapper.c | 14 +++++++++++++-
>>  1 file changed, 13 insertions(+), 1 deletion(-)
>> 
>> diff --git a/wrapper.c b/wrapper.c
>> index 3c79778055..4d448d7c57 100644
>> --- a/wrapper.c
>> +++ b/wrapper.c
>> @@ -737,7 +737,19 @@ int is_empty_or_missing_file(const char *filename)
>>  int open_nofollow(const char *path, int flags)
>>  {
>>  #ifdef O_NOFOLLOW
>> -	return open(path, flags | O_NOFOLLOW);
>> +	int ret = open(path, flags | O_NOFOLLOW);
>> +#ifdef __NetBSD__
>> +	/*
>> +	 * NetBSD sets errno to EFTYPE when path is a symlink. The only other
>> +	 * time this errno occurs when O_REGULAR is used. Since we don't use
>> +	 * it anywhere we can avoid an lstat here.
>> +	 */
>> +	if (ret < 0 && errno == EFTYPE) {
>> +		errno = ELOOP;
>> +		return -1;
>> +	}
>> +#endif
>> +	return ret;
>
> This patch seems reasonable and correct.  I don't use NetBSD, but I do
> often test there, and I'm aware of this infelicity.  I'm surprised we
> haven't hit it before.

Thanks, both.  Will queue after fixing the proposed log message a
bit (the sample must be indented, especially when it contains lines
that look like a patch).

> I suspect we'll also hit this on FreeBSD, which has a similar issue in
> that it returns `EMLINK` instead of `ELOOP`.

I won't expect Collin or you to redo this patch to cover FreeBSD;
anybody with FreeBSD box/vm can do a separate patch on a different
day.

> I do wish these two OSes
> would provide an appropriate POSIX-compatible `open` call when set with
> `_POSIX_SOURCE`, since this is one of the biggest portability problems
> with them.

That may be true, but not something we can fix here X-<.
