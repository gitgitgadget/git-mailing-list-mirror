Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0ED2571AE
	for <git@vger.kernel.org>; Thu, 22 May 2025 22:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747952676; cv=none; b=XQE5q9Z8Bunv1Y9Lwe7JChEMWNsZh4bARgHgGNdXLWxpxx/YYvwgXwsEQMppyjmdV4H/LKEAhi/IqMVEkhqCw/dAq1VYVQv7JZqTbTkcwBgZ9NPJ9OU8NDE17JFsEcLM9GLfA1bGNkGivsTR8jif1sG/E385SiijM+8G2yZdPRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747952676; c=relaxed/simple;
	bh=9pApZ4RWhFYYhjsdT5ZH1mWLbcU2j8FzUYeuvyGjHdA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=MnBOywPvtQ33Yq9BDXLV8vylX+f/r5f84jJ10LQ9Cq/mez8niRZjqwjvJqGRXQOaieOEs8yDqEFY3han7xQHq74s4+2rEYivwAmCqOMFBsdXj08+KUOtWdRh4dAeIWXOtFQeXizGHE2OpuHJjcTDybVbDn3b/L/NOq0HoyQ/38c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=buAxKsIw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kWvZZdFQ; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="buAxKsIw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kWvZZdFQ"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id E37A513805F5;
	Thu, 22 May 2025 18:24:32 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-09.internal (MEProxy); Thu, 22 May 2025 18:24:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747952672;
	 x=1748039072; bh=vyByY5ZOqJqJaZ8iuoyIFpNIIc6vkgrUTSr7Sz3wUBU=; b=
	buAxKsIwNs1d9IbE6d+F4TtThYOIJnh7qXRwWMMLakCHIrETRnyhegQyEojUMY08
	48iKMrP23Nnt82oGqnDvz04sLo5qdjxENTyKYuha5CQ3dRsX2HSMV9Sfyg5HpRzY
	JzCQ4jj8Popb4Ck/Lx7IzHK0Exl4aOKnB/o/NckqhdQOLKpER6k+I8oCIp2sYjmg
	0nRpuCnwEFKnU+FXe5eI3BdCJg1da/S+OoV8tiqqQ0a5rIjBWBWpujeYFID0p00s
	BjrwRxO/TwID6UtrOUOwbI+j2ZqUvJoVX0KHcNj57/1BSYELJGakZsFI+85mW5Vr
	A2SR/TD2u+rgtEd/Jzp3Eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747952672; x=
	1748039072; bh=vyByY5ZOqJqJaZ8iuoyIFpNIIc6vkgrUTSr7Sz3wUBU=; b=k
	WvZZdFQ5A47zu+oj3S5cvk+wSKe4DxXS800LIwIVEgOPnYiLosrR0yCYRnNGKac8
	k73lXxCbSIiM0ZG2q/YXmzD4I4k/whprVKuExOwrVFw8jDNwtQM1fNce/alAYDQh
	cJSVBJ0XKwSV59WB0FOT8cWs11vtg+3vkRTRg0ldmfunfs7BIePKMUhya6mDz/bU
	JoG1yBcGs6E2evHn31sM4zCbd4rYGP/BY6VS6F4dUPl6M+Cn5Wri8TsJaa3M3kuC
	XpOHnynTbf/IFx/chNHO9d9/7u4SetiYE2P+KSqgn5yOcmVigic3xYVG1KbiAXaw
	cA7vgeWPJZVPmoPmiTUJQ==
X-ME-Sender: <xms:IKQvaG1Crs7fzReoxB8JyzmkbGtXQynSAIHhBOSKNwJBoIakNOqyE-U>
    <xme:IKQvaJFSUpqRQeSDK3iqhmQ_-C2jMlcoWnVB54Z_5qIgJwam2V-NcpNEpOqiubyyQ
    JbZP3lTOJYPmYTx7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdejudehucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgj
    fhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghugh
    hssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghi
    lhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeegjefhheeuvdegjeekleegud
    dukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrsh
    htmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehmrghrkhestghhrhhomhhiuhhmrdhorhhgpdhrtghpthhtoheptghhrg
    hnughrrghprhgrthgrphefheduleesghhmrghilhdrtghomhdprhgtphhtthhopehjohhh
    rghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:IKQvaO7FR34Kxm6Z0u8vkq9lMXyw8S1SHaTlK8Ktzr3qBMVzDuZwLg>
    <xmx:IKQvaH2GrmDPJloyTBeYZ5AOzL7FL-oQ9m6PuIFAXVl52VyJjleqDA>
    <xmx:IKQvaJFVo5T0SD55VriN95jaD7FnGmWC75nwRLKIp51lytnJi9T1Bw>
    <xmx:IKQvaA9R_ihhDQbFLtHVQ7syytr85CpESdaIpA2txdRXBS3kB2HpMA>
    <xmx:IKQvaMUsRDChWSjk5bc-nAD53UrZxxGM6PgxYG0zJPpYLA4MCs0KdPL6>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9A7EC3020061; Thu, 22 May 2025 18:24:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T69771ca448226c1b
Date: Fri, 23 May 2025 00:24:11 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Mark Mentovai" <mark@chromium.org>,
 "Git Development" <git@vger.kernel.org>
Cc: "Junio C Hamano" <gitster@pobox.com>,
 "Chandra Pratap" <chandrapratap3519@gmail.com>,
 "Johannes Schindelin" <johannes.schindelin@gmx.de>
Message-Id: <91c86145-1a78-465e-a08c-2fb727dc5a02@app.fastmail.com>
In-Reply-To: <20250522220235.8650-1-mark@chromium.org>
References: <20250522220235.8650-1-mark@chromium.org>
Subject: Re: [PATCH] apply: set file mode when --reverse creates a deleted file
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025, at 00:02, Mark Mentovai wrote:
> Commit 01aff0a (apply: correctly reverse patch's pre- and post-image
> mode bits; 2023-12-26) revised reverse_patches() to maintain the desir=
ed

The way the commit is referred to is almost like the usual
and recommended

    git show -s --pretty=3Dreference

But with a semicolon instead of a comma.

> property that when only one of patch::old_mode and patch::new_mode is
> set, the mode will be carried in old_mode. That property is generally
> correct, with one notable notable exception: when creating a file, only

s/notable notable/notable/

> new_mode will be set. Since reversing a deletion results in a creation,
> new_mode must be set in that case.
>
> Omitting handling for this case meant that reversing a patch that
> removed an executable file would not result in the executable permissi=
on
> being set on the re-created file.
>
> When git apply --reverse is used, reverse_patches() will now additiona=
ly
> swap old_mode and new_mode for what's represented in the patch as a fi=
le
> deletion, as it is transformed into a file creation under reversal.

The usual way to refer to code behavior is to talk about the code
without this patch/commit in the present tense.  I think this is talking
about how the code behaves with this patch applied/with this commit.

In my opinion it helps the narrative flow since something right-now is
problematic.  Therefore (see next point) do this and that to fix the
situation.

> Tests are added that ensure that git apply sets file modes correctly on
> file creation, both in the normal (forward) and reverse direction.
> Existing test coverage for file modes focused only on mode changes of
> existing files, and only in the forward direction.

It=E2=80=99s recommended to describe changes as =E2=80=9Cdo this and tha=
t=E2=80=9D to the code.
=E2=80=9CAdd tests=E2=80=9D, not =E2=80=9Cadded tests=E2=80=9D or =E2=80=
=9Ctests are added=E2=80=9D (and the latter here
seems to use a passive construct that doesn=E2=80=99t feel in line with =
the
preceding paragraphs).

--=20
Kristoffer
