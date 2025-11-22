Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFA23594A
	for <git@vger.kernel.org>; Sat, 22 Nov 2025 00:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763770223; cv=none; b=hhGVgP7DBCrwa0pZmRB9GtbGEZIB8AZ9SBNpJIaYR8wWcPdSJii+9O7CtkAMHeIctqNQfbSwYv1NLBta2Y+HyuXAu3qeOBkrm7UgtskeDrrYTpSoWX3QnnuJvS1kIubN5kOJXZiScC92gM7S5X17Lun52u1fl70S9pu54k25AYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763770223; c=relaxed/simple;
	bh=OKbYppnZDrVfOVRyKjnb0aRHB9w7G/bEpR/Z/6qf/Gw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DwX5APIHEmvG6HDYSp2BV76DitMwacB0yben7MYK55a29HO5N6J0d1sYO4ZnQHCYoJRfK1pZzjEX5HdsDi/YCfUQ3G9SEB/9BLoDuqRM/dsPgDyNzdeepc4u5nu5bCm0erp3/JeYEr4AwBNQiDNPhTzm0tLp5x3JsTlp2BVibI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=J3s1XegV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S3QrBmwa; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="J3s1XegV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S3QrBmwa"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0A5CC1400150;
	Fri, 21 Nov 2025 19:10:20 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 21 Nov 2025 19:10:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763770220; x=1763856620; bh=XqcEXUh0qI
	yXkyiLT9ez6+9ryVAx4ilrT5OTPkvlniQ=; b=J3s1XegV7yGdXohc2wTTN9xDoa
	V03mfP60ItqMsP5A8Idm5EHJgzV1eDRg47qrZVq5ESYK1ZYCrS0TyR1t4eLcB4DK
	zy+aAoh8Gh5cCjEF3WtuAZdgetjRyRBrpz+96jVg1sjW0kt9B5tdRKzXFTRhWcHS
	XReMG6mF2AiXiDRIbbM9bp6Xj0rjsVXqvKv02/QzFCkqAH6RLQ5t1fSbTfHTQMQt
	npOj0how3whFz29U5ovuFURsWgO242R3iAeJZdDQczkFris4Ctk4xH3Jzs0Xhidt
	A/UBvmRc6GIwbsU8/A/n2KCEE4rr1dX8PT4FHkHEwS1J6lm46pIopOpFo+ZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763770220; x=1763856620; bh=XqcEXUh0qIyXkyiLT9ez6+9ryVAx4ilrT5O
	TPkvlniQ=; b=S3QrBmwavfi4i5dtczLTj9mkOwYoScfVmHR4omIXL7KURkN+lsG
	A4uUQdKk9fXrXnWD5uD2iTXKBQMJRhbg5qf+Ad7q15S++klx2Q8w7JgWgp0KssKK
	HnkJm6qW3nBxX1OWwqr1PBmNQlE4nbepwE7oCQ+PbitunMfvbwvVOrLZhnWC9lvV
	ipRmO5tMA+nUyIRC0RM3gYMHXjIsBR/svv3Uw4eq+VJPIfU5tv0WlXUh5Lsuiy6k
	rU5w0qRDJzW+kdzaoj5uMRrUANSbWCF6NOS3eRRE8vewCtYMcg/k65PAt3dnDPQ6
	QxzoojF1Ch8LZqWavmhXIrhviG/p6ILUofQ==
X-ME-Sender: <xms:a_8gaYJmKYbUDo9zgEXkYJhRK1Ge_clb97dYO-PubW7P2cQJ_wal3A>
    <xme:a_8gafBXvqg2B2IYpcUvac3Pd4SZL9fU4uHrHyI_rlztaQzcrktrVklSTQrzdz9sR
    x9BCSzBU0zddaQr9wblP_M7h1MZ9i0t4EqKnpshX8kdtlFQLuCp>
X-ME-Received: <xmr:a_8gaRCkX7CZ99FDyFSgA4HQ-KnbuJgtR5AToMHt_4s3oKEgITJrpnzsC7UGgbQzbT1sE6krBh063SqEQs3uDBDun7yyEI0XEM-v>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfedufeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkees
    ghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:a_8gaRBlgKoR9rekdt1AVh6ZwuEjWwWojwtkxxqDjim4-nM213CfJQ>
    <xmx:a_8gacokTTNWLmgKfSpivkO46p-EDAkhwZyNVk1u3B2grz0vRDeDUQ>
    <xmx:a_8gabl_GkE-dIxUmEEVESLcUfc0a0waGHXA4GHYVLiEl7m1dyzI0Q>
    <xmx:a_8gaczfzQm79gv5-RHJdEz7tR4ptwHBIlXy6CsN3sYiMGR2XSntOw>
    <xmx:a_8gaUS7GbXUp9TbTnFaFuWkwopnxN49XDq7PPSk0DYrxnhjWDYj3Yas>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 19:10:19 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Justin
 Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 17/19] streaming: refactor interface to be
 object-database-centric
In-Reply-To: <20251121-b4-pks-odb-read-stream-v2-17-ca8534963150@pks.im>
	(Patrick Steinhardt's message of "Fri, 21 Nov 2025 08:41:02 +0100")
References: <20251121-b4-pks-odb-read-stream-v2-0-ca8534963150@pks.im>
	<20251121-b4-pks-odb-read-stream-v2-17-ca8534963150@pks.im>
Date: Fri, 21 Nov 2025 16:10:18 -0800
Message-ID: <xmqqv7j32ahh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Refactor the streaming interface to be centered around object databases
> instead of centered around the repository. Rename the functions
> accordingly.

Good idea.  

> -	st = open_istream(r, oid, &type, &sz, NULL);
> +	st = odb_read_object_stream(r->objects, oid, &type, &sz, NULL);

Calling the thing that is returned a "read stream" is a lot more
trivially obvious than the original name "i(nput) stream", and I
like that aspect of the new name a lot better, and the structure is
also named appropriately ("struct odb_read_stream").

At least the old naming was consistent with the usual file I/O API.
you "open" istream, then "read" from that istream, and finally
"close" that istream.  If you insist on having the noun first before
the verb, call them

    odb_read_stream_open()
    odb_read_stream_read()
    odb_read_stream_close()

perhaps?  I think _read and _close are already named appropriately.

