Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567DD52BE32
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 13:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790689415; cv=none; b=C02EjeIRIFDKVjAB3VFZHHiJRU2rhntb/0jl4OcULvJr2eCb6nNijvR9w4+fd254C9O2Uv/1nFW7xmDLIO+/3vmzeKI3+vnN2riM3qfiU1YZ/COVlBeaU2VXDi3dU7DgmreaRkvfXkA8IxtoBd26MwXTJxvJyhwcbDq6ZHMTkBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790689415; c=relaxed/simple;
	bh=dlug1/ioqzFxcIQdJNGgq/Gy5Zxi7xh6OTWDUsGNOQI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=j5rCzBBA6FrV6Hfh+YwS/a5lefhAxaP//Iryh0qjPSAloywdq7woM9Hg72Nu5+w+Bq7GQYDR6n1sS5dQSGckw6VN5Z8flLDg9KzQQE1XMl783aCFPJivWRu2XnvYCdpsw1x1x2v0zRFUPCCMYYjIp/G1baCgHSl8l7OTL0rk9ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=eEkq2hmm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ejx/P7Pr; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="eEkq2hmm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ejx/P7Pr"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.phl.internal (Postfix) with ESMTP id 1F0E1EC1070;
	Tue, 29 Sep 2026 09:43:32 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Tue, 29 Sep 2026 09:43:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790689411;
	 x=1790775811; bh=alAkG3h7oW/D3IEhwMR8d0CbkSLxGAFvrKxuY3X6ugo=; b=
	eEkq2hmmMLiCSX3ZfXmqgb7177kzXyAk2Wtmw2YlofYjnPhg5VMFiggIYYZ3NMhe
	KfFBTwWCBZ/1aHBSdtGfR8yQEgI67quRnjs7LJz+YkcigoBNIMSjQMjupl7ik9P5
	RL2ge91fbag0Z5YOMGaqUbnefXuG/Sasd+F7dXpyZNk+/Ej428LMN/VfEUUWdWSm
	hcGVCqPW1vJMFUBCOqScSDdV6zZyf7X9FLbawfkb6J9OqpMzDnSHdKxP6GVbSctO
	joQYi4dYgaes/Oq4pxZrN6Ub8a3n47zKIdbcjIV8qUD50SRckA+LrNDqjEFExDHc
	M7pQ4L82EQlj68t+pyWZ4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790689411; x=
	1790775811; bh=alAkG3h7oW/D3IEhwMR8d0CbkSLxGAFvrKxuY3X6ugo=; b=e
	jx/P7PrIVmodmGOD9VwZmu+qOwkrgU+pwWkw+o6mlphXq2bZAxR9dJShOXGtbEOp
	LGuGTCLz7wyt3GMjOA1DFFpmE1Gz3cT3+UzpSQqqW2YaovztJrhdnQ14pHSuYvp0
	NOlp8kXMkpXSwaRiPWCeYAKvYtqSR02OwglACJUVOLLhnR4oOklfLZQyS6qz6UrW
	BsdmplHbYAIPammCRuvov3KkH/zjrLJQIaM9rD9wreYFCHoXv3ZM9bGWMQiwbhl5
	dyN9OygQ8hHfWZEwrYjSI3D12ksMV1dTcT9Nfp6k4q1mDSmURew6vRIELlSwQvEs
	e6V8oKo7g8H25IDPKjbMQ==
X-ME-Sender: <xms:gsC7akuAfdvB_747tUEZFapWt9ToMs2bC6pXbr0nk6m_1jz56LjU-0w>
    <xme:gsC7asTVZWDef0YqeCQCjatQO77Ocy_Q8M2xcRMp4df7rY8P7I203u00xkUr1bbBd
    H6KpDz9rw1AqAnByy132_DMRmRuRyUNV7tKvPqWq5eyGt8AgMQ88HGI>
X-ME-Proxy-Cause: dmFkZTEVKb+rXyhdPU1h6WAOWbP3Vxq/sxEGxRQLAEZqdQrZWM5GXwWGOS9o/pcgxedpsV
    +ZadWzQaqEnqgrwE4RlNzyyvM0Jum13inAXRUziFDmyANV9Ajs7nEehxa9BumX7UAVyivv
    7To4T+Hd6QyIvRcLh87tscUYT0WCbC5sD6K71qAXsk31in003COnOK9vwYXvEyg5lyWK7h
    CTSsgqQoHdVhIMvj1zMhtY7Wh/AneVCOO+mhbBQHG7oPmp9T2GdxcWpVwyXB4cfVRQRQMd
    50gpGO6+igaIm6xlW2k9qK0lGlosdCxCWfGIEopjSDquZJvFkY0qz1fgDN3DdR8DaCB6N1
    Dn8dM8gko2CfQpmbhN5urjA4dbnmC5cvhnYmLBugZ2VxF38HLt1UTYkd69elDvmQG9/eFR
    aYoDWfk10+DYesV6YI8VnWYcdDGPVwzSea1qhaY/C9FN8PtkiZJid2IRivBD/05qQbyHmR
    zcXF9981Eu1TXgb222p7mq3q64SlAn3iMc3tEbZ9SIffKUmperGTL7vGPYdhDgG+tqunpc
    ezNGaj9oHFjmqrMOt08vRADbENt5mtjPoFlGk9IhbCKESRpt3NMX/M/kBUUC8hKlRpDQW5
    f3HOepGyTAyURXDvKeWAES9SU7rvvYljeFkfQoohIZg8+ykPbJANe6nu754w
X-ME-Proxy: <xmx:g8C7ajaQJPMyZ3PtOqDAZFH0kQxRfKY2S-1iL741EbCYX0LfDv-llw>
    <xmx:g8C7agU0xE06M9ROkHIbIU1TX-2-kqTLwCEkljYFgklioir9rw7ADg>
    <xmx:g8C7atghqZd-RH6QpLZO4Cc3-ZN-BQEsk0RH3OnUFWQPm-lboyBXMQ>
    <xmx:g8C7amVkI6jKYRlR5ussH86Cr_54dgKMRsIOwuG7y0sjHl-_pNnIug>
    <xmx:g8C7auC-qocxsKk1RPW1XxKEOCx2Nv9i-u4UoMg05Q1GgzmWd4kdzPug>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 5D04222C008F; Tue, 29 Sep 2026 09:43:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AjWbvAlWsX9s
Date: Tue, 29 Sep 2026 15:43:10 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org
Message-Id: <3ab2b1a8-8b2e-4469-8173-36118c826780@app.fastmail.com>
In-Reply-To: <xmqqy0clmlme.fsf@gitster.g>
References: <mmkh.cde@msgid.xyz> <xmqqy0clmlme.fsf@gitster.g>
Subject: Re: [PATCH] .mailmap: map Kristoffer H.
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026, at 17:38, Junio C Hamano wrote:
> kristofferhaugsbakk@fastmail.com writes:
>
>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>
>> Map my email addresses for Fastmail and Gmail. Fastmail has been used
>> for some trailers and Gmail for my first four commits.
>>
>> The `code@` address is my canonical address here both for commits and
>> for trailers. I recently posted about that preference.[1] But I can do
>> more than state my preference, namely to make it possible to look up =
my
>> preferred name+email pair:
>>
>>     git check-mailmap 'Kristoffer Haugsbakk <kristoffer.haugsbakk@gma=
il.com>'
>>
>> Which one can use as a trailer command via `trailer.<key-alias>.cmd`.
>>
>> =E2=80=A0 1: https://lore.kernel.org/git/add1abaa-5d51-43dc-9907-d6d3=
851004f5@app.fastmail.com/
>>
>> That=E2=80=99s the only motivation for this change. The Gmail adddres=
s is just
>> for completeness.
>>
>> Although the proper long-term solution would be to fix my domain so t=
hat
>> Gmail doesn=E2=80=99t think it is suspicious anymore.
>>
>> Assisted-by: GNU Emacs
>
> Is this an attempt to render use of Assisted-by trailers that we see
> more frequently these days less meaningful?  ;-)

;)

Just a gag.
