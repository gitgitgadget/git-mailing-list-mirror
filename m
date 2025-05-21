Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031B31E3DF9
	for <git@vger.kernel.org>; Wed, 21 May 2025 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747838974; cv=none; b=E84zCfkyPMuuYeUT/nsQtKLw5+aEYKE8KRGe/kfHhOtkFhl5rkTxiMLT5y3VrmMJnxhoW+gxSZNcql+7UPyL8KJGGs+T2KGcanDhf/VgEmLugcRkDU7P3ajGmpcZsE3Q/SlsvJmdXaHqngw0fV1wD/ZdKkcVHyMsFvfnBoxOvKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747838974; c=relaxed/simple;
	bh=DAgTn3QByYSb8GgM2/pfxIHpC9KybK0rKgbMqaqeNU8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=LwBuzyp1OMfAdilKjSZAE5IOTQrJE1eY/JJ4fUD7xJUoEj/gFQXBks5qjIzQqeHiRTIJsDaF3HDsLlrSAGSidwe56XB4LxdLmXVwzTes4ccMQL+r6O3go08Df6USX60rEMPULfNMxgDHENBqnUtwBtUPS1HRtXc+tyIuTXr+ljw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=bIH6xWQP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i0DnKil+; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="bIH6xWQP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i0DnKil+"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E8CEC11400DE;
	Wed, 21 May 2025 10:49:30 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-09.internal (MEProxy); Wed, 21 May 2025 10:49:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747838970;
	 x=1747925370; bh=0JZasy8NsiBJ5yj0000StlOr1jtD6wqggHTk3DF84iI=; b=
	bIH6xWQP3wnOjZvEdj5aq5Gf3RoYp+Hp7r5qxw0aLlwbc7Au5R8adSspk1OIzy+Q
	wddoyleYRO2QYCoa/5IJSMuloX/miguDHRef8ytKofS3FuQB+ip+Z62BdCXFEAsU
	OpDHKjl7+dJSiXOUOJ9HU+PyaGco09JQ/L7brXThGfLcD3JDwD++s861je0piHjm
	45uQyqNWQi5eLDvOEDytATGtHBsNKlKTmR0ElelLhYohyfpDT28KG66yHlrcX9Sz
	4lVYepAc+fLg4beHpmly0gScdHrupc8lon87PgeTU8Pyqwt5FP0ua8D2KFapt+/v
	XRp/Oq+N8bvAPw+1WZ101g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747838970; x=
	1747925370; bh=0JZasy8NsiBJ5yj0000StlOr1jtD6wqggHTk3DF84iI=; b=i
	0DnKil+yuqEh7szbiqfv613wRIlZKVWlQU10Iw/eXxm94k3ktVj1UYXLNrIDg6O8
	AYgbZKQ8vH7qeuV1HXl8nNDvF9ac3xoQejvrLcwCqNmG+6gBBjREyGzg8NHhkn0i
	OxFOxfI3EftxhT2qBif8NjX9k8B5Z5ZR3EiQs77pNVft2B9CrCQzLolL6HILputK
	hIEyGwaKgGh560fg8HhTonthLI0OLNCHsHz3XQiRvUAeZWXcnn2vF4EPRlDlvVhl
	7ImCkc8nVS4RvA+EkoyFH1QT15hxB/ztMvAAApPXqEs03A4EWGi68qpoZYKP4IYZ
	0Si84xQQMVcJmnirgyKgg==
X-ME-Sender: <xms:-uctaDRtwwEQszrIPVy_9nhR3M3yA8AaCxLCMaj63rHble4uprsTONQ>
    <xme:-uctaExTOGCI7sRydkvdrCWqshzli3oDV1TAgbhf0CK8k7w5WqOOIDIIkcYr2ustU
    MKZSodCrQRjy2zu7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeffeeiucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhep
    fdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhh
    gruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeeg
    tdejieetgefhuedtuedttdeigfdvgeetkedtuedtudfgkeeluefgleetffejffenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhf
    fhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtoh
    ephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepugihrhhonhgvthgvnhhgsehg
    mhgrihhlrdgtohhmpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmh
    gvpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:-uctaI0XQjwmMMA85PILomsnzaPUtVg0WybbCDtdPvy-PqbKe9iODA>
    <xmx:-uctaDAhLEpKCVJXVLgMAa9lnx6Px8o4i7SS_fKuaunyyKcm9sLPfw>
    <xmx:-uctaMgFH69QXRVVJL8KwJcwtqNMusPyGgjcRAhvAtoDQv-KKRggUQ>
    <xmx:-uctaHrCrbQLq7mB39Rn8lZjuBgP1n-zBnAcRyDZ1dJNkMnGSu6gUA>
    <xmx:-uctaK8B5GNetukiHIoLjsgZgo1Qt0fAh5C1BVHg6Qp5-Pg-yTrPR5g8>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 97B51302005F; Wed, 21 May 2025 10:49:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T35ee799f00e81f63
Date: Wed, 21 May 2025 16:49:10 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "Kristoffer Haugsbakk" <code@khaugsbakk.name>,
 "Jeff King" <peff@peff.net>, "Teng Long" <dyroneteng@gmail.com>
Message-Id: <8ddf10d7-d666-4298-8319-7feba1af85a1@app.fastmail.com>
In-Reply-To: <xmqq34czhyz8.fsf@gitster.g>
References: <cover.1747763769.git.code@khaugsbakk.name>
 <68e5eb78040419ba64e256910501c7e37194b222.1747763769.git.code@khaugsbakk.name>
 <xmqq34czhyz8.fsf@gitster.g>
Subject: Re: [PATCH 6/6] doc: notes: treat --stdin equally between copy/remove
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, May 20, 2025, at 21:19, Junio C Hamano wrote:
>> +	For `remove` and `copy`. See the respective subcommands. This
>> +	option can be combined with object names given via the command
>> +	line for `remove`. However, this is not the case for `copy`.
>
> During my first read of this paragraph, I somehow read the first two
> sentences as "if you want to learn how this option behaves with the
> remove and copy subcommands, go read the documentation for these
> subcommands", making me anticipate that the remainder of the
> paragraph would talks about what happens when --stdin is given to
> other subcommands.  Apparently that is not what is going on.
>
> It may be simpler to just say
>
> 	Only valid for `remove` and `copy`.  See the respective
> 	subcommands.
>
> and stop there.

Yep I agree.  Just leave it to the subcommand sections.

-- 
Kristoffer Haugsbakk

