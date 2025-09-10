Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CF922333B
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 21:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757540694; cv=none; b=P4+34m69lBycbvWdz0fVzuqssi4TptOg1neotozZEtef2DZVoNHarBmZd1M03isYEQUpEQzZLsp+L8axOboBGKOp3HkuhMjy22r9IE4XbFHAW8iSuOXb5rPdCsr8npaL7ysEk+4G0xkFpmGRb6yBA/9ppiKFD/9LDUu72Uwlj8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757540694; c=relaxed/simple;
	bh=vgrv9lRqfhrku75RoVJIVgnBnXHNbrPUC8ZdEd2OqlA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=e4NDcLOpVoGwS0y9/4ZyoY4KIqMfNOIRoG5CCWL+BgrSj2MPoZy7Ym36Z8ePO39EEHQXvKe7f2B4NSZEBL8VpEQkrKcdGlUOVlBRVM++ZGFkiye+r0OhDROHEU6aARJFNfbHccxsUQysNl3uw0m0lPSYuplOEF/Bbon5je87pW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=amb6tU0I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ON1hoeL0; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="amb6tU0I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ON1hoeL0"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B1B4A7A024E;
	Wed, 10 Sep 2025 17:44:50 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Wed, 10 Sep 2025 17:44:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757540690;
	 x=1757627090; bh=VGzRwUFy1pYnjeCc4f021PFiftfZH5eRJJ6i6rBmQoY=; b=
	amb6tU0I7baPQtg9x3mm8fjJNHqFQ22CtiQI9B6pywPWmmKnczWfXP3frG/D8MEe
	IjPaTr/zA+dQU29kbDXLP+D/QXvKgm1ehG5VqM2nKS/YOUN7cs6B05Y37l8OiFE5
	ae7EnB/uhABCfQZ68Oy7rvOETOQ1eMORDEgdiLDOFEh4Y16aTULogc097wFhBY4B
	PoQ5RUiH8MeM7S4HkP+gUyyXYfZuo0ttU4GeoMmPisp4YIhs9qvYbVeGtjEzWFHn
	vVm7mWwAgeT5mzj+GfieFbQBS+W1fDIGqMombobO+4Da4tpjJrVC3xGumXqX2Dwt
	/ZQdtnJAY31SZgy8uhrRZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757540690; x=
	1757627090; bh=VGzRwUFy1pYnjeCc4f021PFiftfZH5eRJJ6i6rBmQoY=; b=O
	N1hoeL0cmeSNUYyxcl6ZVGak8IPtkvgBzrezt07ZU3Yt2jZEoek4+Va57nGqj9w+
	819J6tMFXUFyuMjqXEavEuoNNuELFVR50+tzCmqUctgWwBexRm6BFYtOMJL7bZnx
	Tjsv/bVxfpzIX7bqtViA1/UvgxrUHeXCy8tBDUPzI1t9e3pTSfhKfu/ukWxTPsiF
	k/fLKZIB3mU3oBk+Fq/9THJIzfBPR4iFx/q1arEoiPsW+5yjj6hTV4NxOfQUAGbE
	zMSUcKiwjEu+7FosG5xODfnh3tzuJlyPnm/4zSOVrFwrqd0sxujHnw6HwTeviros
	+UPZN2ul1uCDRP7S+/ITQ==
X-ME-Sender: <xms:UvHBaFGISsZ5Q8VSFvNXk3u04X_63AGOFbsHY4vLww1J1OHpAfSxaoI>
    <xme:UvHBaKXs1pQXML4cEUkD2JVwz8TAs-5faJEYEyD1KBIqsZLWU3x1U59MEp86m1afj
    PurGhO_GvdRpqiNhw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertd
    ertdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecugg
    ftrfgrthhtvghrnheptdeigfegjeegjefhheeuvdegjeekleeguddukeeljeektdevjefg
    iefgfeekudfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
    pdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:UvHBaNKjHr7jYYfQFc7A9_iVLNfCUFfRHLSO9lvytfizsZLQRskaCg>
    <xmx:UvHBaCHqmIVKohED3s_3pgBf-G5xujHR2ZeCB6HyFo_Sg7KngVqH4g>
    <xmx:UvHBaHpBeVYOQgE6MH28QBPV7NqTMJoSzV6WEIMuo1anGfel_w3B8g>
    <xmx:UvHBaLQvgca-HbD6avc0-aCVNUS4FjBOoLT6NwtBVCBowy3be3lC8Q>
    <xmx:UvHBaJp31p6LInMJhXmHlPctovSNuVuASZoVNcgfd4KO-BBH-NVTI5W8>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5492B1EA0068; Wed, 10 Sep 2025 17:44:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Af8krf9zh_4Z
Date: Wed, 10 Sep 2025 23:44:29 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org
Message-Id: <22481270-9ca8-4b30-85ea-dc2e960175e0@app.fastmail.com>
In-Reply-To: <xmqq8qimq99f.fsf@gitster.g>
References: <xmqqjz28v21e.fsf@gitster.g>
 <226976fa-2805-485c-b01e-138e06f9c7bb@app.fastmail.com>
 <xmqq8qimq99f.fsf@gitster.g>
Subject: Re: What's cooking in git.git (Sep 2025, #03; Mon, 8)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025, at 23:37, Junio C Hamano wrote:
> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>
>> On Tue, Sep 9, 2025, at 03:37, Junio C Hamano wrote:
>>> * kh/doc-fast-import-markup-fix (2025-09-08) 1 commit
>>>  - doc: fast-import: replace literal block with paragraph
>>>
>>>  Doc mark-up fix.
>>>
>>>  Will merge to 'next'.
>>>  source:
>>> <09aaad696895c18c6d4dda7d6a2f4b77f84f39ba.1757363213.git.code@khaugs=
bakk.name>
>>
>> Nit: The ref still points to v1.  Although v2 just has the Ack:
>>
>> <724b975078daf11e17f26472c0da5638a5d1ca86.1757366352.git.code@khaugsb=
akk.name>
>
> It is not just the ref.  The updated version has not been picked up
> at all.  Thanks for letting me know.
>
> Is it just Peff's Ack, or any other changes added to the patch?

No that=E2=80=99s it, just the Ack. I didn=E2=80=99t write a comment on =
the update
since the range-diff seemed enough. Let me know if that=E2=80=99s a bad
practice to pursue.
