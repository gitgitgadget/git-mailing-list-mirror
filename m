Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D9537CD31
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 20:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781641946; cv=none; b=Jgk7/SKSEIKORrqtFJoEyifyUS05XSQEo2CEZDHmeT4Mbvxpyb97eTAwrBKaX5FnBBUhOZzzrJFPDqnnM5aIKxmMnxvv+TxHkNpOckBPyYhWLb2IOHznd0u22wdDQzSxa3n7NNoG8pGrGFK3Ok8y24FUytDdCzKkxEkPHYgBi5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781641946; c=relaxed/simple;
	bh=/HwZ7CUrqNx6IujgvchLo0B8OsTN3sn6gO9FOBx3oeY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=SNowurrw8yinIuSa2q4Y6rUix3bBeefLMoP6DgZ6fXjFepcO0FyvuDYwVtTfPiBzubY9moW1BvXFU/zhgGMmVNlJUbn1Ip8SysbRzL8bJjFIUL58aFpSTpSgXeWqjafliamIj+42c6u1pP7JL0wt9su53p5RYLATArPdtcFw36o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=oFWWXxhX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RyJMor8i; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="oFWWXxhX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RyJMor8i"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B94AF1400039;
	Tue, 16 Jun 2026 16:32:23 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Tue, 16 Jun 2026 16:32:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781641943;
	 x=1781728343; bh=cyTQlRUJBvnIZ+EnOOhiNSd/PTadOESGaAQQEkuFjHM=; b=
	oFWWXxhX1OOCu+MJ1JLksxlRBDy7+IXn1sGru7Zgxe7SO2qbrQuVzVveAHWI4GQx
	HB3IvfyYYR+FbN288wGGW/rAFaFq4gLWYIm+ymreF4QEEakZeH47cOeiafnqUhom
	32kevsAny/XEqiT47oU7B5Jw1Iuy3rx/Xoe9nz0tQOJ6t0uf5xSNJQryrfA9IXr2
	/wUZlysjbLBN6q/28dK0yE28I3PDDeFzLWd72rmkub1CZ1dHDPLwZrd6VLDqWMZU
	pzXNLPrWjYp1jcV1bqx345t4SCd7IOMJN6PQTPJTEdFPndU62a3wthW2c2xdaex1
	qy1m6nksb7u6sOTt57oUIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781641943; x=
	1781728343; bh=cyTQlRUJBvnIZ+EnOOhiNSd/PTadOESGaAQQEkuFjHM=; b=R
	yJMor8iNCXy6WLL8bVeAthNlkW47VLH+w/uixWWfpjmKc6dY0IjQZ4durp8V+Ivv
	Rzh5or2++i1Bme7F73dz+aopiuyampdvfO+LsAQgX76GnyIvdq8sJ+Fnq8p3L+MR
	+E2njqjNbNqYf5EvulWC33mJ8FADjJBa2GXNRp+J650t903T/PeBmNu5lI1mQe04
	rIpBSn2ytbTFGn9HXzf875emPFja3PK8VIYL/6rC49ZHwkSgN0CKtPNcvKhKDFVH
	oPQiBa5Nua1gY5VrXUdtztgRFq2l6oh8sdf2k7wHbxvVf/waVQgLx6hh15EJB5Zj
	DqGFSjPX7uoeCJth2u68Q==
X-ME-Sender: <xms:17Ixaqb4fRkzO4N2FIQOSJKTgN5zO4CRodYXZpn7kzWJVtvI4klTs9Y>
    <xme:17IxaoPWnhDerIjce_VClcDcEcNkiTm8NZIQOPRRi3OzU_GwQjTlOFpUgveHbX6ct
    NfojU2DHuMxVbo1IfByCaoAh07hnSVfcdwewXJQetWYWMTzRY0H>
X-ME-Proxy-Cause: dmFkZTGUkSnuL7ekHBWU7tIYbOpKpwMP67Qz6ISXBA34RlMRcYgaQW9UQV54bjS0X41OIX
    UNMvIMNklUCODFyvnwrnXOVDbR8eOLa/N9+IfKuTBEwFA59Uxic3IfQCE18wY4ndxewURh
    xZXWPpa05QlWm6GSM+RNRY8Mz3bbmCeTmX8jXIL3tqX9Uze+NQXN3/05n8gpnKUwI81XlN
    nZgPvO0gpaUHV6fe/w0RfAqkBMFO7M9NJ4bYIA/0ayTcRhQb8HmH77Tnpso0pVPybB406E
    FVyg79/v23HFT97U0+muPSWgbEt8kWiY8vOK711x/GvhR4r2BpxqGXMnLMaNwnWBh78MmB
    kB9by0H5GI+uMtRsNx7mthhVEiUmLnQb+szv5xHnP3p/T+LULtFSL4t+Q9mjWibfy1Mjgv
    5Y5VsqYNTK9qPdDD9/MggA95KBOolhyc7Cb5icYIUW0tIL/+kM6U5EwpkM0HGmyqLToFgt
    GhmStoXm6pM4w/mU1YeK+YrRrjta6EymR/PJNlDvgEgKSIDUztN/FKFGZhycmkiG6yay/D
    zUIN2zZb8Ho38+wJhu0hBmOARokjGRDZYKpG56HvdHDsQEO2p9OmDJ7/+PJNqbcmoDOOIA
    TR/k4LFnuN8IKReYpTViHNmySHpj4fIir8/YW++NydRBsRW0AdVpHk5Q+Kfg
X-ME-Proxy: <xmx:17IxaiF3W1Ykl6tTooXMpap_op3iyZuDwXSYf3dOmnOI4zE8aEJgsw>
    <xmx:17IxasrOUkYw4T5-6NlCSpDt7ayrPxGuvwhMZSBEW0LPFfjarWa1yg>
    <xmx:17IxajZXuYv5h50wmNf2Vq3dQLTs3T9pTlLt2uvBMa4CCfoPUMS-VQ>
    <xmx:17IxatXEPMsM1OgJFt5geerBr4YVifRdrv931IIX-Ue5YlndjtK-wA>
    <xmx:17IxapcjVwL523KRTE4jhwxVp7osl_FAxPDkXnWP1jgWcdg79Fa-WmXn>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8BA693021A92; Tue, 16 Jun 2026 16:32:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AiJygaQzQnU3
Date: Tue, 16 Jun 2026 22:32:02 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Matt Hunter" <m@lfurio.us>, git@vger.kernel.org
Cc: "Christian Couder" <christian.couder@gmail.com>, jackmanb@google.com,
 "Linus Arver" <linus@ucla.edu>, "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <26c2fcb2-2618-4bb9-a6e4-a6135934556d@app.fastmail.com>
In-Reply-To: <DJ5W2I8UYXAA.3O4JQUHFMKP5X@lfurio.us>
References: <CV_doc_int-tr_key_format.533@msgid.xyz>
 <V3_CV_doc_int-tr_key_format.8a3@msgid.xyz>
 <V3_metadata_not_lines.8a5@msgid.xyz> <DJ5W2I8UYXAA.3O4JQUHFMKP5X@lfurio.us>
Subject: =?UTF-8?Q?Re:_[PATCH_v3_02/11]_doc:_interpret-trailers:_replace_=E2=80=9C?=
 =?UTF-8?Q?lines=E2=80=9D_with_=E2=80=9Cmetadata=E2=80=9D?=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026, at 05:10, Matt Hunter wrote:
> On Wed Jun 10, 2026 at 5:21 PM EDT, kristofferhaugsbakk wrote:
>>[snip]
>>  DESCRIPTION
>>  -----------
>> -Add or parse _trailer_ lines at the end of the otherwise
>> +Add or parse trailers metadata at the end of the otherwise
>
> fwiw, I think "trailer metadata" reads more naturally.

You=E2=80=99re right that your version reads more naturally. I went back=
 and
forth on this.

1. We=E2=80=99re introducing the jargon, and the format is often discuss=
ed as
   plural =E2=80=9Ctrailers=E2=80=9D, with its constituent parts being s=
ingular
   =E2=80=9Ctrailer=E2=80=9D
2. What this replaces uses =E2=80=9Ctrailer=E2=80=9D, but it rescues the=
 plural mood
   with =E2=80=9Clines=E2=80=9D
3. This is very soon going to go into the constituent parts, including
   each trailer, so we=E2=80=99re contrasting the concept name (trailers=
) with
   its parts

But I think your version is overall better. It reads better and there is
no way to confuse =E2=80=9Ctrailer metadata=E2=80=9D (trailers as a coll=
ection) with
just a single =E2=80=9Ctrailer=E2=80=9D.
