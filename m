Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE82A19E7E2
	for <git@vger.kernel.org>; Fri, 13 Jun 2025 17:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749834083; cv=none; b=Hp+xH7XVO0S8iMs9pruRaj6ZvvN7WdHVJm53z0SG5gq8ZJvB2JYGVffozxM7uA8OP6xvaEHA0rBKfPj7OtcBIVF7PA+WLCMQh7MObSLO3VQuHWFMI7RlhLZ+DbRkoXJjScY+tm/H7TtRP0c/PtQ3C1Oz0Ah4l6RJzRGScghdE2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749834083; c=relaxed/simple;
	bh=GjrSaOeFcM/ot2Xax1WRluq2ptXNpTGyzixfgXV8hh0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=WkQXe7XSJmNMuS3ri/gZdKHF9ap0KAtTqnqvXUiwHB8pivRto6aI1XyClRLsEKH6YgjqlR+7w5N/KP0xu54gpVw9hKHzeEXzfjsYQADesY+nvKeyUkjGTHaOknELhQlXve4zfY3qZw4QMUTrndn9XNCagnAlkoHmCXWv9nOtkmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=gA/vXjaR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NrKQqGhz; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="gA/vXjaR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NrKQqGhz"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id D9CDB1380315;
	Fri, 13 Jun 2025 13:01:20 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Fri, 13 Jun 2025 13:01:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1749834080;
	 x=1749920480; bh=BSL5yVNNjyYrV2wA0gd9xJ0AHmNPBc73vwXDU6ij/6o=; b=
	gA/vXjaRJ2gxnOd0jiSnOfbteQY3vEcdh8T6tNhpJvSYB7/PAj+xVNLsr8rxb2VA
	xC3ugYU13stPiJoh3B91VdTyFtguFIDno3iDdzjSM/oFDQ20xMcipW6+ggq+LG95
	dg82+MIhnuTZhFTVI7lHsp5vwVKZloIxIwqwBz3cbDR4csoNJuecXR5MtF03VjxL
	xN2UHcKCnmhd/1bJXOY6jLDO1nhEIZ/8Hwjv170ffuAPupohzxGwK0fIHiTTBacY
	xjLG3XydBhxwoF6e8H0oswEt4CJDFf2JJpO9OjiIp1eG1SzQHwe73lGYuUvM9N7P
	O8Zikoe2zkBVJuOGBBCfCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749834080; x=
	1749920480; bh=BSL5yVNNjyYrV2wA0gd9xJ0AHmNPBc73vwXDU6ij/6o=; b=N
	rKQqGhz9Ppign5nVjJBKDdBxmOxiMWsozPqFQqMNj/iB8Gzf4Byn9+VYbu74bT51
	qKwI6Rns0DCXMUksmfUjJXI45MWMVskaemeAYenwDrBHVZiL7Lbh3a4zEqQDESpJ
	TEj1Ith2cmf5x2hz3scNWqt+KeeLTtxBDrE1Yj6pokf1SD8+x18xBgsjO9gzT4YX
	5VuQBwZHZJCt+1l9bfzKkAvreCuUTcXU8t3GtlPXS6hTSkJJboGyLsDvsw8O2C0n
	dxNoVfuYZa+0GT3Vo0WpRVCki1jIahT8TPS7+7HjcQSAK/iaPMoYoI40rhBILnVM
	xyA05OsE62vSLmUDz6d2w==
X-ME-Sender: <xms:YFlMaGt6xuyIB1sSbFGGdmzIovjmKpre_vyD_MX2TMDDi4nxzgMPNQs>
    <xme:YFlMaLddGA_5gdZjCIJ2SN3lBRxyaslNDmuj_0ucfPYpdlkrJx8EcRz-JxqPGcg2Z
    vHG5vM6pkbIxuakGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddukeehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofggff
    fhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghr
    ucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhephedugfevgfefgfffvdfhffdv
    veevgeehhedutedvgfeuffejveejudegveefvdefnecuffhomhgrihhnpehkvghrnhgvlh
    drohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnh
    gspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlvgig
    ghhuohdutddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggugh
    gvthesghhmrghilhdrtghomhdprhgtphhtthhopehguhhokeegieesphhurhguuhgvrdgv
    ughupdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:YFlMaByppl87EndV9W4Lj121gxEnOpaq3nMtpTtClRnb7Y8as-q1qQ>
    <xmx:YFlMaBOVmOhLvgEEd5HNs5XU9l7UPehNFE5m9a4bX88w4QW4F-LJnQ>
    <xmx:YFlMaG9PrkJGtqfNIK_5bGF2UGa54TatiepydIQTcKV7rPEkxOIv9A>
    <xmx:YFlMaJUo0PzJs7AvnpdWLdswaFIYT2KItTg3_DXnWJDhbOOwoeiEVA>
    <xmx:YFlMaO1RfqXbyHmnelUx-9Q_2HMvPXa_ioVWnZGIukGyGch27YYS3wIR>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8B4CA1EA0066; Fri, 13 Jun 2025 13:01:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T4cee296f729252cb
Date: Fri, 13 Jun 2025 18:59:48 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Alex <alexguo1023@gmail.com>, jinyaoguo <guo846@purdue.edu>
Message-Id: <44066126-ece9-4c77-b38a-292b6f748955@app.fastmail.com>
In-Reply-To: <pull.1997.git.git.1749833577767.gitgitgadget@gmail.com>
References: <pull.1997.git.git.1749833577767.gitgitgadget@gmail.com>
Subject: Re: [PATCH] Fix memory leak in function handle_content_type
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025, at 18:52, Alex via GitGitGadget wrote:
> From: jinyaoguo <guo846@purdue.edu>
>
> [snip]
>
> Signed-off-by: Alex Guo <alexguo1023@gmail.com>

Like what was said on another patch[1] the From and Signed-off-by names
need to match.  I didn=E2=80=99t see a resolution to that?

If forwarding you need to add your signoff after theirs.

[1]: https://lore.kernel.org/git/xmqq1psfxgyv.fsf@gitster.g/

--=20
Kristoffer Haugsbakk
