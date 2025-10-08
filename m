Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C721D20296E
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 21:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759960713; cv=none; b=lNv2mD0xuIsxvQGbvsrgd52pfTRb2Y3ufuJ4S/xMbEyWkBEwLK/Br04jdxTOKcZ0nhUpdciJSEhaCglSLRNoyyw4uyFtBfN6BaGe1fyd7TPl+ZTVn+Vv4QKJeaaAoOKiT7QoiVgdCxprXJuhCk819C3MO43cN62pRX3ffBFjUJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759960713; c=relaxed/simple;
	bh=t7NwvUbdma1igQvPfNd8ICZffZwRDF73X/wBdu8GlQg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=jEXlTBE2jfo1YDMNxXXZvXgaNPXwAZZxjweAfp2DIztcDrNCYKmADcUbKNzURbfqcsT2LZyvuuQlJSbizn/sJ1vXxwYhysSSj+ipdaT4u7MfGTd11/QKRyp0kAx111+jxCjI4NtSyYFzVN2Gpudm+PAgY0601AYPVnopVxNTjmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=IiHlQAmM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ufFk2ZP5; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="IiHlQAmM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ufFk2ZP5"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EEDF57A0038;
	Wed,  8 Oct 2025 17:58:30 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Wed, 08 Oct 2025 17:58:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759960710;
	 x=1760047110; bh=t7NwvUbdma1igQvPfNd8ICZffZwRDF73X/wBdu8GlQg=; b=
	IiHlQAmM1Cnd//K2YSzU/6HNPSyqDBa/BArX4Y5iBYdSXqS3+KdrrEYxF2MjIZOp
	Ol+GpTMoyQBpLXx9bcX7RjxawiJ/mVQjsmhVrykdYGtmrKuvQOWVqErts+yz7a1D
	J1/MXbpy8eKQmk7s9fY4HjYbNaBZKhFx6s9G05PlgChvrfXg74ud3+lOtYdsPvZ9
	h6AYEe+TLBkgNYn4ILUIyLDr1TNKBh9S+o96riTmwgajU7n2eN3UupGRYP+0IsPX
	o2ElwOVlssr9P3f9aTIbzU0FMvurSjfVSm8wBLsnvFOSgcLb7wIofGcHzI1cBbGE
	78GPvw9gNsVL8+qzefWZgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759960710; x=
	1760047110; bh=t7NwvUbdma1igQvPfNd8ICZffZwRDF73X/wBdu8GlQg=; b=u
	fFk2ZP5h9ukBiaKCST6Jz85QMQ2uqvNqSuTbpMR6qTJMsGV4zq1GdJ4Ij8Fglxhh
	nqFsPzZ52bo2Xfxuqom3AxmJg6SCj+hSB030J2FD8Mn8Hww8s7ULMqy94bop4jjT
	TFTe+S7zAwIB7Lpb1k/8lXvCJshZY2cqJRAAdFX5B2bBs2EsqCIHdDCLtnoarTxE
	JEPv26J7BT7rMzHr1MwAWjv29hi02TUIfeaijYEToXWx/53FhT6+fk0b40qq5mWt
	NowEiy9xnnhZcGehXQ3nyz+mqEewrjb5+qfjIr4gb8c5kMJdgNQC2bqNA/Vj/WY7
	mnslSuLcW4Op3iQ/beybg==
X-ME-Sender: <xms:ht7maB7wse4uKd_lzUfpX8D3pu80cPH2y_AHEv6B933GgrDUuc86WAM>
    <xme:ht7maJsEtbovoSs3V_yagR8LvWUv7G3cmJSiGKJUddFIjc_2m_OKWPSVhOFxmRurV
    rz4IvyUSyhjpQI_mtgMV6FeWf9yNIziSbYF0UoS8VxHKLlIQjf6XaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdeggeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepmhgvse
    htthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:ht7maOgWVEU3p_LHj9RZL-Zt2uUiJmlF9V-nhckFPJngYR5ko2Jg8w>
    <xmx:ht7maM0-YjjkNcjZiIJR4I9K0VjbxdIxf3Jf3aJ7uI1jjIEILr83iw>
    <xmx:ht7maAghfp67qH6GBhbCc7z8zHcj2i0jinwY-vvWDdbAGRteO2iL7w>
    <xmx:ht7maEeOV3_4lgLCdbEDTDFkE7o9of1U3TPbXt7KFT1CvqLXNQZWjQ>
    <xmx:ht7maHrFgOQe3cE4MUF6dXjkJ9NOOUSWP7dDvnHw3JYBLNNuuL-pj5QI>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 78B341EA0062; Wed,  8 Oct 2025 17:58:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AtAKOKhqNxG3
Date: Wed, 08 Oct 2025 23:58:09 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Taylor Blau" <me@ttaylorr.com>
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>,
 "Elijah Newren" <newren@gmail.com>
Message-Id: <75d82bb5-f2ce-449b-8387-fc1d63ce4e78@app.fastmail.com>
In-Reply-To: <aObVmU7m4PahMsEN@nand.local>
References: <cover.1759873165.git.me@ttaylorr.com>
 <d7931dcc4380757cfd4c6f24b5d746da2294f40b.1759873165.git.me@ttaylorr.com>
 <85dbe67e-f252-4548-910d-4af29939806a@app.fastmail.com>
 <aObVmU7m4PahMsEN@nand.local>
Subject: Re: [PATCH 1/2] SubmittingPatches: extend release-notes experiment to topic
 names
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025, at 23:20, Taylor Blau wrote:
>[snip]
> I wrote it this way to account for individuals listed under the
> Co-authored-by trailer. I'm not entirely sure that I'm following the
> latter half of this sentence. Could you clarify what you mean?
>

Sorry. I tried to say that: I don=E2=80=99t think =E2=80=9Cprimary=E2=80=
=9D makes it more clear
that one should use the Git author compared to just =E2=80=9Cauthor=E2=80=
=9D.

>> But it was noted[1] that the-topic-summary doesn=E2=80=99t seem to ha=
ve been
>> used much. That=E2=80=99s not surprising given that the instruction m=
akes
>> the-topic-summary blend in with the rest of the cover letter and does=
n=E2=80=99t
>> signal that the author intends for the first paragraph to be used as
>> such. This patch shares the same problem.
>
> That's fair, though I admittedly dislike the idea of prescribing a
> format for the cover letter. It should be clear to those (such as the
> maintainer) who are reading the cover letter closely whether or not the
> first paragraph (or two) are meant to be used as the topic name/summar=
y.
>

I think saying that the cover letter should start with them is just as
much of a prescription as saying that they should be marked with some
paragraph-prefix (and be somewhere in the cover letter). Some people
might prefer to start the letter with what they think are important
call-out information and get to the topic summary later. For example.

>[snip]
