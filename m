Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F928302744
	for <git@vger.kernel.org>; Thu, 14 Aug 2025 13:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755179237; cv=none; b=DGOLcVN0gFAKaZHBO8EyPMavlRLvchk5A5YmkEVtkNTqMDaGCSxC04i/3USj94BuZvqL4/gXNYg5n3OaMvZ5fhzswEaClGS8U2p1guhCRtrwNcus8joVTIlmYAWqs25N1c22pyNj9Jrwkd5YBBQmFnR3fxVlhpG8xDiISqoxxKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755179237; c=relaxed/simple;
	bh=j7pSxb0zBiOBPLmzpZNUZP1/+AFJx7O8TfT5XlVvQ24=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=pzYaAptLpvod0MQ6rKdtEeHt7a4WlIyL00VCNnsZT1FXmM5zSS0ngc6OpfABj4vFzgSJ2LUARw9vDrH91GYc+gIn0f0QiaZvSPMX72O7WlIWSPLcKNrW3y1RF4/76lXIIWRTWxGPibisPZGEO3IYXY4nm4j1S0KmYlAru6biN5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=CKr/trTg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F0B4uCXk; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="CKr/trTg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F0B4uCXk"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0EB6014000EE;
	Thu, 14 Aug 2025 09:47:14 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 14 Aug 2025 09:47:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755179234;
	 x=1755265634; bh=c8lAPyXADLfkvnE2pLQ4LX1rWNnmy36sYJLsl+XK+D8=; b=
	CKr/trTguuYfLVmgOLNHBEjoKVftsGsRRJVyuhmwGLaAthZlwGUtb0wcztc6sOqx
	GBjhvjN/rhc8kiPFXR71luqL1Ng0HhJaxri4ewbdfEgtfBFTbIgG47tgPcwU5erx
	91mTf+TD1qOrupkTmrcN5odKfahcqeQfxuH1YiRJFjb8hUQTeeyPQuojHqj5tvce
	XUdySLPiMxhbe/nK5+a8Qu+xOWhI6EXxcLHRi3VM4SXBKKTMbD1wjJQ98zYEfjJj
	XtYORJkrue79IAvd1DTRCKuGR91iKJIigbDUSXYLHZxg2AlwoRXZvDOdzmW1Tkno
	nYGUtTxje8S2Ec1i/EUJSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755179234; x=
	1755265634; bh=c8lAPyXADLfkvnE2pLQ4LX1rWNnmy36sYJLsl+XK+D8=; b=F
	0B4uCXkCwzgvsJen1smeJaC2qp9Qf+B8ku+WMFFVaAZZo+QDPES+9147b46/fSUb
	dQqV5qbSLaFzf0TtFQOkdWiY9/yvezyFYeNJ35uoucep8YnhzqoDk9QIeCQpO3mX
	cic8lDepCG2GpyTHbUbhLta/ayadAhfCVkmZCNdndjpANpy1IkF3V6LTkeFmXLb/
	8fCiyBb3gq4r3X80sACpYR9YJBNJLNZjTUxf8Fl0m4sr9ybwUrt/hCx0EtCFMgCr
	ujDQs4gWaUQud7r5XGRwJMG56kCVurLZQ8ubc2EyW6CoCYmqlrKLRGMLCPogmvyM
	hwyjeXi6JZD4OAnBOAJ6w==
X-ME-Sender: <xms:4eidaN_2t_B-37Scp6VImKN46sx0PLXlTJfnonL-n8fsVr8I5LzMfTQ>
    <xme:4eidaBuTqgV6gNNThRdO5pxLz09USp-qu5i-KKpifIg5D2yfm-FnctWAptvOQsxR-
    nf1_QjgFOZggJHkFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeduvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegurghnihgvlhgvshgrshhsohhlihesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:4eidaOn4Wet_XselmgFGlB12bOhhWbdQhyqLCbFTgNkW7wtcRurGtw>
    <xmx:4eidaMvMHfqavpwMd6SXtI5MFMK07_AR-rmzlohn-8WTzifMYOthJQ>
    <xmx:4eidaJkVZCRrWNYBsXQHRfGxXODD8i0U0tF5nFnJ7kPKK5u7qscVUA>
    <xmx:4eidaPux427FD-H-_AT2QPSrlagXSsZZ13QsKqIfLffB2Ge3BMZa2A>
    <xmx:4uidaIjzG8Ev4HOLZfg7NQZk7XcN_WG_TG0p2xw8-7Q2wAhChYTafi3H>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C08621EA0066; Thu, 14 Aug 2025 09:47:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AMTlAUTgAFnV
Date: Thu, 14 Aug 2025 15:46:53 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "Daniele Sassoli" <danielesassoli@gmail.com>
Message-Id: <6fa49c61-5a3d-45b8-a2dd-5c03515a7da8@app.fastmail.com>
In-Reply-To: <pull.2031.v2.git.git.1755177382349.gitgitgadget@gmail.com>
References: <pull.2031.git.git.1755078045397.gitgitgadget@gmail.com>
 <pull.2031.v2.git.git.1755177382349.gitgitgadget@gmail.com>
Subject: Re: [PATCH v2] Document count-objects pack
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025, at 15:16, Daniele Sassoli via GitGitGadget wrote:
> From: Daniele Sassoli <danielesassoli@gmail.com>
>
> 0bdaa12169b (git-count-objects.txt: describe each line in -v output,
> 2013-02-08) forgot to include `packs`.
>
> Signed-off-by: Daniele Sassoli <danielesassoli@gmail.com>
> ---
>     Document count-objects -v - packs output

I=E2=80=99m very sorry that I missed this the first time around before y=
ou sent
out this new version... but also the subject line

    Document count-objects -v - packs output

Should start with a lowercase =E2=80=9Carea=E2=80=9D like e.g.

    doc: count-objects: ...

Or:

    count-objects: ...

Or some other variation (see `git log --oneline --follow
Documentation/git-count-objects.adoc`).

--=20
Kristoffer Haugsbakk
