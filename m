Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDA21E515
	for <git@vger.kernel.org>; Fri, 30 May 2025 13:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748611694; cv=none; b=ubmvN7ijoJ7B66KP2fWUr6hE+1ESGqUGrBV0X5pEGNQcXn5A/2mdCDmdIhKSB55MjramQSBzTTmk1aydqHarHTY8EcLjDZ87+bY15YMcQEbQMePEvw4VSp34FKCS11gIyQL80QGCaoDC8RnYaSGIKpMXAXWUa5yhWnm4X0F5adw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748611694; c=relaxed/simple;
	bh=9wZS4FZduojXWcPeo2cWv2BmcVqGSiW4tJkARE5vp0s=;
	h=From:To:Cc:Subject:References:Date:Message-ID:MIME-Version:
	 Content-Type; b=Bjpf4cA+TA55YEO1IKbIG+Q74zxVXcxZLhDKTFgm6yFGIIVio8dd0jq6riBI7WKsK9xy09G0OloeL79Jhnyt95KFdHcHLRKkEFlzvt4kQr+7WvxZlSJUCDiPwuEYSd5GO4nce9qe+X587y04mQLpD8eaFl1UIvXbPjPf1eDbc2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Pnh0XIKF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SXGSxKWc; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Pnh0XIKF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SXGSxKWc"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 79B2D254011E;
	Fri, 30 May 2025 09:28:11 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 30 May 2025 09:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1748611691; x=1748698091; bh=sRgFz8TLHwHcqhLRtr9L1
	lGnz/hFbY+FHaL8rOcFTNc=; b=Pnh0XIKFAgDWIq+O+GHNd5fotfAKKrZxBDFvi
	AZevpmXv0oDLG0aEb0DjFrWVeDNaY7CQHfVvM1G9cQHXNzpznNoxcECmyl4UI6RQ
	Wc9DfoZQHE855lEPzKSKDniEEp1PNegBh5hbuihxAwdkT9fAyMEyvsgkY6b9tKHJ
	0KgtWYXttj5maNMZ+f2O1esL5ISA7WLlqKj8ffYhya0vRoCdvG4PsBerVdwtmSeQ
	eYBe4o9r9wN/at8lkndicU8cmGV/tQJ1NR+seyr25q60ss9AZRnpdATBoLdgs0oI
	EHIGaiFg8J02ftUeLHsZ4JAarWfVP5wgV2KZj2tLQQHttx1wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748611691; x=1748698091; bh=sRgFz8TLHwHcqhLRtr9L1lGnz/hFbY+FHaL
	8rOcFTNc=; b=SXGSxKWcME1Pc1xOcnEMy/deESCzZpkji4bkbjLO3hGYHNtqz7/
	pSu/RLDhtL+qFjhGTv3A/4M2wb1rXI1Yo4Fvqf04fMgZl31dsNwwoQA7/PgUVJrF
	xxGXaiLSVwbkh4IqBYH00CEzDL8qGfpHtTlHHiBv8J+jfWw4thp+EbAj12sV/92B
	CwlgnZdBzcS+jtD3gWid/35VMC//KiFvoQOgceJXe4nImayG59cpw7I2vKGLpplB
	NdmE1C+KpNY6u9gsaumdm8OdU+dKC8ApL3Hnce2pkPpm+4Ze+V002cv/l9MtEP75
	+Seoc3B/YKq+JaFplxgIPv2vB8heZO4gCMg==
X-ME-Sender: <xms:arI5aPpJqIFuy62PlYNUiE9AWXDp_xIOyOrUTY-ZRaQMLALcA19uDA>
    <xme:arI5aJo3jK27HKJKARlRdUpdaFUsPGbB-ViQ7mHVEhutc4wwoBxCN1YXmMvx2ioZD
    gi4sKzjPyJXtuEJOg>
X-ME-Received: <xmr:arI5aMNgAKSPW-Ko9vhMHL0HHJcClL1l32LY7nAait0NCx94wq-InGqmuVk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvledufeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufhffffk
    fgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceogh
    hithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepieegudefueei
    jeejvdeffeeiueetkeekvefhvdfhiefhjeekheehgfehteejleevnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosgho
    gidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepghgrrhhgrgguihhthigrtdeksehlihhvvgdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhulhhirghnsehsfigrgh
    gvmhgrkhgvrhhsrdhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhn
    vggtohdrtghomhdprhgtphhtthhopeiiihihrghoseguihhsrhhoohhtrdhorhhgpdhrtg
    hpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgt
    ohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrd
    hnvghtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidr
    uggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:arI5aC7Rv70uxJtgaezJN4W7fY0ySobRzuVcmm4SUnFdefkzgi_vqA>
    <xmx:arI5aO4oRxeEkukzNQGlNtABLpgAVRsPbTA2KdlTjRZjed-KxzVUpA>
    <xmx:arI5aKjdYHhJgw_Rui1XZRrYNk1WZUGYq2rp1V9phpimGypL_9T6Kw>
    <xmx:arI5aA7i4MFi7EbrFZXFcbTUJQjGeDm2bkRa_q2v-H6_w7ALPrLrNA>
    <xmx:a7I5aOeUr-cNGqBM05KvbiVx0xkjUUCjSNVdbMIdtuTkmjBVBvkVQe6R>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 09:28:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,  Julian Swagemakers
 <julian@swagemakers.org>,  Eric Sunshine <sunshine@sunshineco.com>,  Zi
 Yao <ziyao@disroot.org>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "sandals@crustytoothpaste.net"
 <sandals@crustytoothpaste.net>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v5 2/4] docs: improve formatting in git-send-email
 documentation
References: <PN3PR01MB95971131BD3CD89771F19E5DB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<20250528070521.17379-1-gargaditya08@live.com>
	<20250528070521.17379-3-gargaditya08@live.com>
	<xmqqa56vl1uq.fsf@gitster.g>
	<PN3PR01MB9597008B30AB91C9539E7C8CB866A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Fri, 30 May 2025 06:28:03 -0700
Message-ID: <877c1yb53w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

>>> -When `--compose` is used, git send-email will use the From, To, Cc, Bcc,
>>> -Subject, Reply-To, and In-Reply-To headers specified in the message. If
>>> -the body of the message (what you type after the headers and a blank
>>> -line) only contains blank (or Git: prefixed) lines, the summary won't be
>>> +When `--compose` is used, `git send-email` will use the 'From', 'To', 'Cc',
>>> +'Bcc', 'Subject', 'Reply-To', and 'In-Reply-To' headers specified in the
>>> +message. If the body of the message (what you type after the headers and a
>>> +blank line) only contains blank (or Git: prefixed) lines, the summary won't be
>> 
>> Shouldn't 'Git:' in "or Git: prefixed" be marked-up somehow as well?
>> 
>> As these mail header names are all literal parts, shouldn't ehy be
>> marked up like `To`, `Cc`, etc.?
>
> I think its ok to let these remain in '', and deviate from the rules a bit.
> If backticks are used, it will be a mess when rendered on the website.

I do not think I agree; bending the rule only because the density of
literals in a single paragraph is too heavy does not sound like a
good application of a rule---it is hard to justify such an
exception.

>>> -    by 'c_rehash', or a single file containing one or more PEM format
>>> -    certificates concatenated together: see verify(1) -CAfile and
>>> -    -CApath for more information on these). Set it to an empty string
>>> +    by `c_rehash`, or a single file containing one or more PEM format
>>> +    certificates concatenated together). Set it to an empty string
>> 
>> What is this change about?  grammatical errors?  non existent links?
>> cpan links?  It does not look any of these.
>
> Non existing links. Checkout the website.

But I do not see any link in ...

>>> -    by 'c_rehash', or a single file containing one or more PEM format
>>> -    certificates concatenated together: see verify(1) -CAfile and
>>> -    -CApath for more information on these). Set it to an empty string

... the text that was removed.  The reference to verify(1) is a
command in the OpenSSL suite, right?
