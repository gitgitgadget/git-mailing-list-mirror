Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD0C2C031E
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 22:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781129627; cv=none; b=cfaJSGNr+D9MKkKpYoTkLl50PPGLUwuVr8EhK6p30dS/SqAsXq0ZR3NuDDgHN0nQj3s18iI5gNvTZFcIxX+1tsTlmPoZTfqtsbE5nb0kLBqQWJSJw4q1ThnFVen/jQUuoZM4J/ohY45/KmeF0poYVXtbui3stvjD+OG0AutX0kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781129627; c=relaxed/simple;
	bh=JEmv23xkAivzl64YroQVMXZEz5DD8YxMB0DaWo3dleQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=st8JJHOPTPARt4dikFYAjE2z6Z4Nj9wreVvElqdbkCgmelXjmB25gzNJgDMywWuXz8JbFUgr5E3joKfSqApGYMS/Ms5/HQoE0CGi1YsFzdr7jUoiRicyjQSE7dgFkKi5rIfEtLj+7FMkTxeASLgxEWenKYSn57Z5CIlwCnu8d8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=PEdk5tG3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kSgrpLt+; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="PEdk5tG3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kSgrpLt+"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6C40E7A011B;
	Wed, 10 Jun 2026 18:13:45 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Wed, 10 Jun 2026 18:13:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781129625;
	 x=1781216025; bh=JEmv23xkAivzl64YroQVMXZEz5DD8YxMB0DaWo3dleQ=; b=
	PEdk5tG36Vg/B24kas8Vw+808pW0IFXqY8LBj1oNg7xZoygziN6bBWe9a8CpSQL0
	UCFWxXRsf5zqXsZKOmJB3KHlJgMfsBOm7EpL4nQ39Ovc93zFZU8zDCaRE2H6Grim
	LAkh5T/UJC06vVegeJVtMqSiIhcGknAO0Hucon5L/dRqWJN7kPJZWI9vabQftSSp
	rLW3rutZ5iAds8NQgQoYKOe1aaXVcCYTNo6ucFI/6TC7UGCq/JCBfPBM8rHb4e91
	JOdXCh3wM7gtfgUwWyZGJWoA87+NWv3/DymhB0xy/Ir6FDsbc+2tBqR/ydCHCApS
	7FOKYRywjoLvz2KJZHWFlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781129625; x=
	1781216025; bh=JEmv23xkAivzl64YroQVMXZEz5DD8YxMB0DaWo3dleQ=; b=k
	SgrpLt+tabCXGOBI+2zD93sVuznr7A+oGoaYgYdu/YwnAhZortJz2yu1bUbCTHXW
	B40QsA9XdXDcsZVZ2xWUlfyqHNzOmAf5BqEHMlFcXROZW3bOWgbG3PIzcIK2nZVL
	6LPdKsG1X0I/uHLSqtBdRuysVNSNDHZc1hi7MtncUkrBAAOVeb2fxZlB9wz1mIe+
	BB2aEp3mkFt6Z2jsilu13yY8R878IWrgHSY7rmDoL5774y2659Anf5TH0OA4lHaS
	sBBCzIgHIIbUF/S+oliULSdHHLPRySVI6f9j4jwSQk6nbaVDzZXGFD7KZRrpHsI3
	F9wAXGbHUdQNpJqPl7EOA==
X-ME-Sender: <xms:meEpasd3HrpIta1_8DJ6utWd9PyGUMUVnGQNrDdM8ElUTPIE_dFIRrw>
    <xme:meEpapCdmHeDEsnv5BgDsRHTQ0bsROsOXXN5b6YjaQddOOIOb4tND4drbXSolLmXb
    LiRNttdEu0yfEYWzw-CwQseC1xoAk-E0XggnzJojEGQLRYbWOU0kg>
X-ME-Proxy-Cause: dmFkZTESJodQ2Fn87JhTIRfJNXmXVUaavcE28jRzCdqrPtozM/sODDYJTs/6vcvwadw/eO
    LTy2oUC20wM2LPBBbe64og382xjizdtpRYsTer4IY6gCp4GG8MVGPByzVD0KvjU1ahXQie
    WQgutZqZZKVrY9zJnL0xb+9LreqIhr630Z406m326B5sMqqEXTyvFRSd22jWVDIJ/6gCo3
    /PTgrBMCplQuQU73Fa1ZV8XtOCbWRrodiOacySKi7Vvb3/RY+TL9sPfPTUtxNgxMDyZ48W
    BcP8DUYEmvRzhimbtQl871vBnbz55gJEE+x99G98h1uNCJLozqJPEDf+kQjgwjCxYoquci
    6S8n9NUYJeTcmoC+MCASdyaQt6V+gxvF7W6hnS59SAOMKmYBuni6BZrCdVtXgX+GQJAp+2
    6v+WKhaM1ppSap7OjAigW4gkD0LWWhThUx/d79X4u7eiAzIVc54+/auVDyua6HzD3AC/tL
    ki0mWyxf2B+Mni9MO7wJYrZ5niBpKyWJZlxXB71Zf/5/sQht08kVJUvH5VLPCjGh/6HUUB
    k8jiD6gv9XPgOAwPtfZElMJpkRsD8Nj3eHMpl3TDcPCLi1ZD19+0GXOCDyHQI7pnf0ZOIF
    M+MGUKzVu1DMrOEadpGz8LiUF+SE50dB67ZoWrznZVp6qaamEx7U59W1ffAQ
X-ME-Proxy: <xmx:meEpanAe2OsOQJcPm5wp8pCiIXbkMj86CRXVTAhFKip2tH2LKDnXQg>
    <xmx:meEpavC_PkvKRQxORsCcaTjbsk8l18Nap3AJkILDqYpGyxx6OTOKjA>
    <xmx:meEpaioWf7C5NmVPg47OAqAsh8xm1ubY5gwvWfHUN98r0CWbvILAhw>
    <xmx:meEpapmFujJXRfeV_b56A3dO1_F9PPqrtyM8p4SQ56YIU2ndrp-jEA>
    <xmx:meEpavnX8rJY3cul2iZwb649JbwpWS-_v1dNNMgSy8X7XuKGOOBHNno3>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1C8A730201A8; Wed, 10 Jun 2026 18:13:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A9L0VMjJXkPo
Date: Thu, 11 Jun 2026 00:13:24 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, "Christian Couder" <christian.couder@gmail.com>,
 jackmanb@google.com, "Linus Arver" <linus@ucla.edu>
Message-Id: <a6c5a9ec-a118-454f-953c-1323aa716c54@app.fastmail.com>
In-Reply-To: 
 <CALnO6CCg4ubVz_VJuFjn7tvXqADR40AdjCFJ6xfRcms9a+GQWA@mail.gmail.com>
References: <CV_doc_int-tr_key_format.533@msgid.xyz>
 <V3_CV_doc_int-tr_key_format.8a3@msgid.xyz>
 <V3_join_paragraphs.8ab@msgid.xyz>
 <CALnO6CCg4ubVz_VJuFjn7tvXqADR40AdjCFJ6xfRcms9a+GQWA@mail.gmail.com>
Subject: Re: [PATCH v3 08/11] doc: interpret-trailers: join new-trailers again
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026, at 00:00, D. Ben Knoble wrote:
> On Wed, Jun 10, 2026 at 5:24=E2=80=AFPM <kristofferhaugsbakk@fastmail.=
com> wrote:
>>
>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>
>> There are three trailers that talk about how a new trailer is added.
>
> 3 "paragraphs"? :)

Oh doh! Thanks. ;)

>[snip]
