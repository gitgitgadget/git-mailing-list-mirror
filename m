Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E698329B8F8
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 16:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750696025; cv=none; b=E60Q03gk0E3ZyLWcNQ3UhLSW/RNMAy+xs0QnayulQPSwmBDyszDBM66j1cUXPRr75q2FOrMPzl7HcKMBRnstB3L1tqnsoU+kGkfwtNdFocqHWhj2kgHsgSGvOP3a7GrjDN1o6s7nR8dcoVX1Jr8eaE+Pu8IvqDVLRg98U9Tn9/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750696025; c=relaxed/simple;
	bh=CTHAhiRm9zl4+ZwFKt9iFmbMX7dsJQ+TDjcJISWLWmY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qcrnd9Lti4Ml4rjOmoDMtDTgocDrB2n1/dfdRyxSSam+wp7c9eIrCSzrMdda+WYmf27I1pSrqhD/sgrBi0PJZX03NvKAkAc9eEmeHb0XTUSSTac3pIzAxu6f+8qmxoJ/msGVnoA1DDmop11HQvhrVnZ1UaX/nDEaRswXzF53Iyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vF2TmZKU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aXqsBBNM; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vF2TmZKU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aXqsBBNM"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 12DBD114013F;
	Mon, 23 Jun 2025 12:27:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 23 Jun 2025 12:27:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750696023; x=1750782423; bh=hXnQSiME4Y
	iuH1j/YuNp5zlk2WCZCaOXvnA2YuMNeNM=; b=vF2TmZKUfAyrwmnqY89Fr4e7S5
	Z5mrh2A371vWKMlaJ2xtYqUEpTuhb39y3H2r4zsR3DKI2aDbzNHLzvTNoOd006cD
	qCC62lfqKcB4vz4cdOLe2NoCZaYBReDwsIPgdepMfGgKtcQnt6G5VjhSqQjiVr8Z
	uUQULxjoX0bpctykXo+1rVC3DTKL1ziBk3FEUKcKCmYv6nTykBaeioqG3A6ZpiFh
	DTv5ZGgNv4XXyCziLiU6E5QgWnaSQjQEJNRqFnrUMNq1wQPYzqN0SK2Sqc01I/DK
	A8P6j6v4XkhLz859On0Errjw+k18CL6rtL6owhqXvHWvKewZGaWw9G0KZ9BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750696023; x=1750782423; bh=hXnQSiME4YiuH1j/YuNp5zlk2WCZCaOXvnA
	2YuMNeNM=; b=aXqsBBNMYtmNDlqlsOiUb1aWJC9EJFlLEKyJYsQeMtzo+UjgsTA
	2HVI3g4duJKanSI2oNknedr2HuBlf5pQe/myKqw7lv0D2PLJLSl6VrIXIIgc0KmI
	vSwd1BS52iTe0b149piB6jjcY3dqdDvZRpp9fyHLD5/EBz/ReLhZNBvEbzJc6hUN
	kirJJRO7wsKU7YgeHAcmY8/JlFRooOhkD3O3ciqCdy2EotLOWgUWjnCC9TqMxcJA
	2Tt5rbyoGCY0y1SbP0cgQ+FY8GV7jhrGWonq18sBfCPRaVdL24kjCS1xCs9S9A1r
	B6YKZwxxbdZKYo6GUkpTVVh4R95DEgGWE6g==
X-ME-Sender: <xms:VoBZaIDHiqPqwT90Z6EK5JOrpgzhCNYO3GNY1CD6Bl-fLZX3_NGElg>
    <xme:VoBZaKgNSoOqLM-QSOBEwPdToPiKHgAroa4WEZoV9D1Qf1mNZfR_CVucEmbrvIZ0q
    EocUVimO31YEjCCZA>
X-ME-Received: <xmr:VoBZaLkYDa27KrvISIKoA0Lck029AmGcoxIPMhGmgD2rrDpaN1M7V9yzHvuyqBus5dX3Kkd9PzlFp2-0ACuzxY8KQ2wakZSr3qBtbiE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddujeehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghgrrhhgrgguihhthigrtdeksehlihhvvgdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhunh
    hshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopeiiihihrghosegu
    ihhsrhhoohhtrdhorhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhooh
    hthhhprghsthgvrdhnvghtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgt
    phhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:VoBZaOwoOfAojXXZiTHgR3yZCpUq_h5Ipvy59WPrGFWMEVfvzBdDIA>
    <xmx:VoBZaNQ47kDKtVPM8IkQp11QcPmKV5KsBmzWHEbXQRvgfQlL5CrMkQ>
    <xmx:VoBZaJZG02j5vuJN33ZcyCs0gqKYFeJ84Y9VCjerIH3feNGRtf11fQ>
    <xmx:VoBZaGRjRQzQtGAvVFNYdzUsromgPzrakJ6QgJvHvK-WDBm6DRXXzQ>
    <xmx:V4BZaI9ELhORncm0fXFHbgU_lAV7M_R5NJg9aQ7f3vauG3bW-Tr6wd3B>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Jun 2025 12:27:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Aditya Garg <gargaditya08@live.com>,  git@vger.kernel.org,  Eric
 Sunshine <sunshine@sunshineco.com>,  Zi Yao <ziyao@disroot.org>,  "brian m
 . carlson" <sandals@crustytoothpaste.net>,  Jeff King <peff@peff.net>,
  Ben Knoble <ben.knoble@gmail.com>
Subject: Re: [PATCH v19 00/10] imap-send: make it usable again and add
 OAuth2.0 support
In-Reply-To: <c787a41c-97c6-437f-aae0-52132c79db7c@gmail.com> (Phillip Wood's
	message of "Mon, 23 Jun 2025 10:09:25 +0100")
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597F9CAD0DA83152E651194B87CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<xmqqh60a4dk6.fsf@gitster.g>
	<c787a41c-97c6-437f-aae0-52132c79db7c@gmail.com>
Date: Mon, 23 Jun 2025 09:27:01 -0700
Message-ID: <xmqqy0ti5sq2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 20/06/2025 16:50, Junio C Hamano wrote:
>> Aditya Garg <gargaditya08@live.com> writes:
>> 
>>> v19: - Use xstrfmt() for OAuth2 strings and strbuf for PLAIN.
>>>
>>> Aditya Garg (10):
>>>    imap-send: fix bug causing cfg->folder being set to NULL
>>>    imap-send: fix memory leak in case auth_cram_md5 fails
>>>    imap-send: gracefully fail if CRAM-MD5 authentication is requested
>>>      without OpenSSL
>>>    imap-send: add support for OAuth2.0 authentication
>>>    imap-send: add PLAIN authentication method to OpenSSL
>>>    imap-send: enable specifying the folder using the command line
>>>    imap-send: add ability to list the available folders
>>>    imap-send: display port alongwith host when git credential is invoked
>>>    imap-send: display the destination mailbox when sending a message
>>>    imap-send: fix minor mistakes in the logs
>>>
>>>   Documentation/config/imap.adoc   |  11 +-
>>>   Documentation/git-imap-send.adoc |  68 +++++-
>>>   imap-send.c                      | 405 ++++++++++++++++++++++++++-----
>>>   3 files changed, 407 insertions(+), 77 deletions(-)
>> Looking good.  Will replace.
>> Should we declare victory and mark the topic for 'next' now?
>
> I think so, the range diff looks good. I've not reviewed each patch
> but I just had a quick scan of
>
>     git diff origin/master origin/seen imap-send.c
>
> and it looked reasonable.
>
> Best Wishes
>
> Phillip

Thanks.

