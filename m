Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5941D966A
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 15:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728315910; cv=none; b=o4PZd9D8c1+ADQwh+LJx9GF1JBovHDX89Et4SPDOqaRgPqVYTWOYLaBI8DgXo65bowIedrF7jtVD/4YQ47cJ6VuQT1h/UuTQfnrkIBjbDDIvRz2rhsIuvRlNBw1Wsdefo7gbPa5zcRR3B1TEYLsFMQq6YLoZ/ecEU79uP37ALSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728315910; c=relaxed/simple;
	bh=5IRBBHLFTjObzoxfx36IM0JExG2Y93zy2kaLKedvxIo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=tpvR9e0mFiTEPecPoasWvJtBj36p6WN+iHg8lQm8KY++P7eaSZ3zK953fdYGtwvl3SOtnXgkYg+uKnyJjOHRAKwXT08J278WMT6RJdEWauvVlCojhtNpdMPuJaNDhPdowps4FevZtf+LDIdcYTYQgpduBrj5PQyhj8Mga4NR72Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=B5fHEMb3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JM9vNxPE; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="B5fHEMb3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JM9vNxPE"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id ACB5013801AF;
	Mon,  7 Oct 2024 11:45:07 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Mon, 07 Oct 2024 11:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728315907;
	 x=1728402307; bh=DtjBol/tlNCVb8mCyanCKoGh3A9EQvnsZc6ocmf9FZo=; b=
	B5fHEMb3hcUeOAc3BK4wfVAbULlTsgWUnSl6sFaNyerU7NNFdezHlgI3gWQwcr+8
	WqeHeCVzjC7hx9n3cDGAS2VBVw8YlD2OLxt0HMk7B+76MX6BQyZWFTEw13KRvHfe
	AzQc6vmvPk9ZXvlTIcmQVH+HM0MQ/eoPOY004oWE/HWD4ShOCR3mzN6cUPHpeP7z
	c7jlv1c9JUnTQLNZ7vzGNxLTrhvQe83g+X9Thmo29ubFLVVpvAW+Thjh57+TLNo/
	CWx50KlKa5iGzI35B/rdNBuc0hILOxb2K12HlB/fp9pubkz5W4H4f4qbdy1TU2o6
	zETqAFBpLx91mODfDKyVMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728315907; x=
	1728402307; bh=DtjBol/tlNCVb8mCyanCKoGh3A9EQvnsZc6ocmf9FZo=; b=J
	M9vNxPEtMdTiOQSMfoCcXBnTlXVSKdS3Sd4yjJxoU8cheXpNmHdoZKiPslOC0P2U
	CJOc8MPEmwHjum1BBo3Ws2XeClPQ8AwZMXApUzSO4YVYvRVU1zyEr3ls9wyGnTME
	AVfzLKdyGwmgcgRE6pzBdw5yMHfcQCsnJwE15bhlwYTTSdXD34OoxCyzdVKHEMLd
	u+7ulE4Uxw8Ovun4tVp8e3GM0DWvZTHsj8cDDjzko+wki6A+IyEgdDsStVwmD7V+
	J+UNGUYXL2PoRm/7TlJxrFIOGDg/ShZalO1pwvQOzYIwKw8+2RmHs3pVcxBCUeuU
	baPgle97ft/hoD4iuhVvQ==
X-ME-Sender: <xms:AwIEZ_e0PZ0RGQh9BIOwgojmbrAm3YqKIpuYS9YJJpgtDfuJZ2jGk18>
    <xme:AwIEZ1MThrF902W1Smx-oy3iCPvnTwCbNX1lJ7WzjAAH8MEW04XpQe8AneWpRQCva
    krCfZ7kivj00UHeuQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnheptdeigfegjeegjefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfe
    ekudfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnvgifrhgv
    nhesghhmrghilhdrtghomhdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrd
    hnrghmvgdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:AwIEZ4gkV82yHINMs3zyiXvrfO9xAwUzl6DyIrgicLYYx7l09awFPQ>
    <xmx:AwIEZw8qMJv-ldqsZcHD7xccdyr8syiOHb8thEgTFMzACUFBZXwQ9g>
    <xmx:AwIEZ7smY10vUNq-UZQBHHF9sx6y8WSW4KBnVqP2ANznv3jjkMTBoA>
    <xmx:AwIEZ_EbTjdm-ZXFrX9j4lHu26-DjzZExK0L9ohSgnEeli-q5vXA_w>
    <xmx:AwIEZ7Ku6UJHIX0OjBVhBK5HN_oSSyLtmeSDg9z4ojCuynoOgOOGcqJ->
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 55B60780068; Mon,  7 Oct 2024 11:45:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 07 Oct 2024 17:44:46 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Elijah Newren" <newren@gmail.com>,
 "Kristoffer Haugsbakk" <code@khaugsbakk.name>,
 "Eric Sunshine" <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Message-Id: <5cfe7170-3fd5-432f-b6af-702b8cb2f611@app.fastmail.com>
In-Reply-To: 
 <CABPp-BFG0KQVzu_AT-GwW0rg0Ly3uVY1+M4Sgh5E8Gn9A=5BKQ@mail.gmail.com>
References: <cover.1728298931.git.code@khaugsbakk.name>
 <4057d6386125e51fd934f92abd11c62a9d24a832.1728298931.git.code@khaugsbakk.name>
 <CABPp-BFG0KQVzu_AT-GwW0rg0Ly3uVY1+M4Sgh5E8Gn9A=5BKQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] doc: merge-tree: use || directly
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024, at 17:24, Elijah Newren wrote:
> On Mon, Oct 7, 2024 at 4:11=E2=80=AFAM Kristoffer Haugsbakk
> <code@khaugsbakk.name> wrote:
>>
>> From: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
>>
>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>
>> Use `||` directly since that is more straightforward than checking the
>> last exit status.
>>
>> Also use `echo` and `exit` since `die` is not defined.
>
> Not defined where?  It's defined in my scripts...  ;-)
>
> Just kidding; this is a good change.

:D

Thanks for taking a look! I=E2=80=99ll send the second version tomorrow.

--=20
Kristoffer Haugsbakk

