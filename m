Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C81037E2EB
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 15:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768491800; cv=none; b=btfKb5Yn+8MIzyosJXr1IIxchNuSLc4KXX6J/a55+LHzOV/SC9Ft3RiafnmtMjGkTi6wm1llLarJ24ZtMRNwisSwNMmBcOhelMJaYcLr2uxZHpMK9k8FpJiegOQ9vDsotDAOmH7kNdaHNRKry1GaCeyqx6bY2K9wwGzPqCAydmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768491800; c=relaxed/simple;
	bh=CF25JhSaB874yhIZ1WlsWZ5s21rSHHYZceta/KzqLs8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=UpQaxw2oB2Elu29Z1u5BPx9b07yQcJSMRt9yQR2gRxWQpC225w8Uspp+QCKY25CoJzKLC3O8/27ZyP+5ktxgOj6tbPw9Xhn7jP58BR6XmWwWOYxZoOmSuwmxSD8wlj4YPDXIbC+4X8N+j1EYHJO8b6H88yInKhg4wspW9IwFy4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=s/o1I9mj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0Q+vKxMO; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="s/o1I9mj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0Q+vKxMO"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 7D0ECEC02AB;
	Thu, 15 Jan 2026 10:43:17 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Thu, 15 Jan 2026 10:43:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768491797;
	 x=1768578197; bh=CF25JhSaB874yhIZ1WlsWZ5s21rSHHYZceta/KzqLs8=; b=
	s/o1I9mj+5K6BYb6qlz6chjc8UdeqJ+u0vXmwFiRxTvefvlVaoJ6lC+jIOMt1wI5
	Zd0ZCW70fJPc4f8mc2o95vRTBaGsaPdJ5vCYdeUKnMMjRIJTyr85IxBV4Ecvz6qs
	EjAUxh52/04CTkST2+iyhurCmrq4ynEfWj5gBfzFpTqatD7lSJqw2WmvGuBxr9KI
	FN0jFd48x11eIUaTEBOaunW1WjXgPM9HxQfHjTq8jQWfiaF0sBRwmGk4cI68QQua
	Dt9lw1SmXBdjOVvo6U2msLJdsqylbf1lsK9PYsc854pUcEffKgGOd8J4gxMgsjvX
	Lsrm5rSfXS+aFRY3xuCcqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768491797; x=
	1768578197; bh=CF25JhSaB874yhIZ1WlsWZ5s21rSHHYZceta/KzqLs8=; b=0
	Q+vKxMOdQR81eIazx5AdOaT9RdSnneb+TNDEKiwRKfwcmVPlL4NJJi05zOwYdFFn
	0/CHZqc8P6Axlwe0QEDtiEavHBOpm6vbpkl9RufY9NE4IY6bh3qLN8gsKSPHlqB7
	kw0WUS+diHAdzup69/gZEwXkzXQlqLsj3w/exwCoyvIV+cJX3Z99rX9P1oKcBkgm
	NFaEamx2cqmhxAbNt3Fy9PK9OBrtd5oi8B/6iiZGlEgenDshDABN3FPb+WTWqwvd
	rDSTvEsWvku+dsFUDNWCJEHQ42y6K6pE560vzbjuA6kTqc729Uru0CqIe9wzqiuE
	h0VVMn8k/bKrD1RTEMMEA==
X-ME-Sender: <xms:FQtpaa_8wQ1wLoGA3Y6ixUL8ZcUZ32AQJOLBC3kDg53sEhJ8oy1WSUM>
    <xme:FQtpaVikgLNEx2fql4oJUQRFPwlzFg6mKltoqD66S9XEoSF4kBNI4ncDVfkp1CfWf
    UD2b8VQfaBgzX0fwQGfblClGj7QKhu8SuoqsnR6oB5BTCRZ7nZIIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdeigeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeejpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegtlhgruhhsrdhstghhnhgvihguvghrsegv
    fhhitghouggvrdgtohhmpdhrtghpthhtoheprghvrghrrggssehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepsgifihhllhhirghmshdrvghnghesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehphh
    hilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:FQtpaSUxfSCkK6ATIvssMitScJyDVVccqs-_J93dLrCxnjm1ttom8Q>
    <xmx:FQtpafSYQELnMfndwvX0LN0gGGEG1yKq9I5BpKIJp8_0iqkfSh8ezw>
    <xmx:FQtpaUkskR8enbP9lW6prycvHvuu33Cihfpo7Pk5XgLJwSBA0Bel8Q>
    <xmx:FQtpad7QMlJ_fYGPlbrjztvBkP5-RIh3DLvBPj3jcDR9w9eLu4rQVQ>
    <xmx:FQtpaZVdatoJoBzLa0Xoqi_0f2IQ63wn3-eGdSk44VSTaqXEnJZMrCvK>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3B4A01EA006B; Thu, 15 Jan 2026 10:43:17 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AxiLTKoM6H_J
Date: Thu, 15 Jan 2026 16:42:55 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>,
 "Brandon Williams" <bwilliams.eng@gmail.com>,
 "Phillip Wood" <phillip.wood123@gmail.com>,
 "Claus Schneider" <claus.schneider@eficode.com>
Message-Id: <f021269b-c89c-41c8-aa08-2ec2443ac7e8@app.fastmail.com>
In-Reply-To: 
 <de72bf0a9135224ed4c4a05ae00deadc28225ac0.1768376879.git.gitgitgadget@gmail.com>
References: <pull.1987.v2.git.1763057433.gitgitgadget@gmail.com>
 <pull.1987.v3.git.1768376879.gitgitgadget@gmail.com>
 <de72bf0a9135224ed4c4a05ae00deadc28225ac0.1768376879.git.gitgitgadget@gmail.com>
Subject: Re: [PATCH v3 2/5] read-cache: submodule add need --force given ignore=all
 configuration
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026, at 08:47, Claus Schneider(Eficode) via GitGitGadge=
t wrote:
> From: "Claus Schneider(Eficode)" <claus.schneider@eficode.com>
>
> Submodules configured with ignore=3Dall are now skipped during add ope=
rations
> unless overridden by --force and the submodule path is explicitly spec=
ified.
>
> A message is printed (like ignored files) guiding the user to use the
> --force flag if the user has explicitely want to update the submodule
> reference.
>
> The reason for the change is support submodule branch tracking or
> similar and git status states nothing and git add should not add either
> as a default behaviour. The workflow is more logic and similar to regu=
lar
> ignored files even the submodule is already tracked.
>
> The change opens up a lot of possibilities for submodules to be used
> more freely and simular to the repo tool. A submodule can be added for=
 many

s/simular/similar/ ? Although the sentence doesn=E2=80=99t quite make se=
nse to
me. Well I=E2=80=99m unfamiliar with the domain anyway. ;)

> more reason and loosely coupled dependencies to the super repo which o=
ften

s/more reason/more reasons/ ?

> gives the friction of handle the explicit commits and updates without

s/handle/handling/

> the need for tracking the submodule sha1 by sha1.
>
> Signed-off-by: Claus Schneider(Eficode) <claus.schneider@eficode.com>
> ---
>[snip]
