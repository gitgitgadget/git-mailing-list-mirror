Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678A64C7C
	for <git@vger.kernel.org>; Sun,  4 May 2025 16:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746374732; cv=none; b=G8kuo3NwWbG0jH/9J1wdNx2u9+xBbIxHStvNBYB3KOjfh1YIRLouejCBtAYhLgnH6xv9UFiBL6s+nq70YDiTWoJGROhBVXsk+zpUHqfEt6iFj8uAP2OdcRR93z6mwA8//bEoRW8zzGTdAnVnOi1YHak80tkCebyb/HabiqbNCbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746374732; c=relaxed/simple;
	bh=Ae3L8tL/FJMp5Q8m2/7iqwD32JLCDSCIPOILB79GS5w=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hk3074LSMKPjYZWMr3IADHLUXMwHLcW+Af0OeUR3AJhWcixq6r2ABIR+DiHz6BMP9LbdB1fWuU2+NWCTjghodt8/IXA7Ng2osPXzU7Ca1ArMHmn3EDeSd2QlyJ3JJLvEsSlNcPeqb+rGuPvHVeuZNGrwg7yOq0XB15vhoct+tzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=JTYSRF5T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qMMMbOFk; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="JTYSRF5T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qMMMbOFk"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 4C5901140089;
	Sun,  4 May 2025 12:05:28 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-09.internal (MEProxy); Sun, 04 May 2025 12:05:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746374728;
	 x=1746461128; bh=Ae3L8tL/FJMp5Q8m2/7iqwD32JLCDSCIPOILB79GS5w=; b=
	JTYSRF5TKHxTP97gZE8tKuTTZXUZzhgc7hdL9B4nq9Lb7c2y+jtb5U1C/5J7QAZB
	83f/mKd7+rfHK4AE8gPsMTsgsHnj6Ap201/RsRNGAZ0b+LTyucYnvBOqK171jlVI
	9VcBpSQwTCThkyH0L8Uz4iqrTFQ63/6mOOqziYcErzSpf3J74pXTUeDGgppiPSkE
	diDrddk1fAA0K1/vwgkUk/W3rS4NE63+yfa6Axrl6gGtFVEWs+TmNsyZHfoMD2QF
	lAykn9nruV+ttYz+pgQgl617zmTe3woYrnp+hb2pX/qqcXfUsKixoXFoGI9aQZ33
	cFs0pzCyI+KPopuXMhmloQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746374728; x=
	1746461128; bh=Ae3L8tL/FJMp5Q8m2/7iqwD32JLCDSCIPOILB79GS5w=; b=q
	MMMbOFknp8Azc1oOM2mpmO2uzykPWKqON5dWcKuNl0G2THoXj9B3O4vEofvl2Jox
	/th2qKc6kRQYWmpV7jl03D2WyuIfcCFw0DqoGkMEcNLjbAL9WqlXSApVmIIXBkdj
	Qb6zln5Xbtj3ka8WQd/DzDzYLC8QRxghdgcs1z0jX53CvouH8T1PKbQl69SkdC/V
	GvM4t3YTSLcTp77Pd5TRILx72Qt4UJbUvoEUJBH4D1N+V+ioOEggh4BSSudOEwBX
	UnMBk6NN/ypFk478w2AxXW86GrJk48NPRJWYpFrg2TPp8K52SKARxl/ardTSjGVq
	WUv/Z6w3H9RWwSMG6U/NQ==
X-ME-Sender: <xms:R5AXaLjXUcyfHHHpc6Q2oLb2iVgMv-g9-mc84Coytnrd4WF_7TetBcQ>
    <xme:R5AXaIBFPjxTwkiKscGnNsONVQaNvdaTn6INbs2IesJpkDmivVaIPgrjfYnWZiE6W
    aFguviA-QKqAIeK1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeekieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertder
    tdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrh
    hishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggft
    rfgrthhtvghrnheptefgveetgfelhefhhfefvdeuhedufeeufeejffekfffguedttdegud
    egffeggfegnecuffhomhgrihhnpehivghtfhdrohhrghenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprg
    hsthgvrdhnvghtpdhrtghpthhtohepmhhirhhthhdrhhhitghkfhhorhgusehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghgrrhhgrgguihhthigrtdeksehlihhvvgdrtghomhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhulhhi
    rghnsehsfigrghgvmhgrkhgvrhhsrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:R5AXaLHvVKIWlW0DZlnuhv4IggbdtV7uYrN7_oP3K-2hY3SZNryrgQ>
    <xmx:R5AXaISAkidGAvyZd280yC_cpn3UQMPLmxCAx3omHUJMIg0Q31tULg>
    <xmx:R5AXaIwUy6Z19l16U2_ovpvw8Pz-W0HVEzvz3RyyoEGs34IQkipt_w>
    <xmx:R5AXaO4j5FKY3wa-UKmUsugcxcPZdVw3KrK3X6-rMevUQkEUY4hggw>
    <xmx:SJAXaBK7WVDyKn_yQW_RbCGeill-3i0SWH45-mbhu6sngLB6BVMSInsZ>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 28C54780069; Sun,  4 May 2025 12:05:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T7c57673a799ce033
Date: Sun, 04 May 2025 18:05:05 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Aditya Garg" <gargaditya08@live.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
 "git@vger.kernel.org" <git@vger.kernel.org>,
 "M Hickford" <mirth.hickford@gmail.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 "Julian Swagemakers" <julian@swagemakers.org>
Message-Id: <96413038-8b21-44f7-b426-ea9d61b90cc0@app.fastmail.com>
In-Reply-To: 
 <PN3PR01MB95976EC68E23CDB5A77AE741B88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: 
 <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95975D45B072101812714C72B88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <a2ceea8b-8354-4316-88ec-54111fb98d69@app.fastmail.com>
 <PN3PR01MB95976EC68E23CDB5A77AE741B88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Subject: Re: [PATCH 1/3] send-mail: improve checks for valid_fqdn
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, May 4, 2025, at 17:26, Aditya Garg wrote:
>> On 4 May 2025, at 7:53=E2=80=AFPM, Kristoffer Haugsbakk <kristofferha=
ugsbakk@fastmail.com> wrote:
>>
>> =EF=BB=BFOn Sun, May 4, 2025, at 15:54, Aditya Garg wrote:
>>> [1]: https://datatracker.ietf.org/doc/html/rfc1035
>>> Signed-off-by: Aditya Garg <gargaditya08@live.com>
>>
>> Finding the s-o-b here works fine since only 25% of the trailer block
>> must be valid trailers, but it=E2=80=99s probably best in general to =
separate
>> footnotes and the trailer block with a blank line.
>
> Sure. I'll wait for some more reviews and send a v2 tomorrow.

If there are no other comments then that=E2=80=99s just a nitpick. :) Ma=
ybe a v2
won=E2=80=99t be needed.
