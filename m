Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E55032ABC3
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 18:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761676817; cv=none; b=WMBD9Ygff2K1J93r3gOdmwFTN3G58XUlTyvdKnC/NJj/Tk4DXqxEEfv9aFrE4Ww4a85lzrtNbeUmkepLhucEe4YiNk5snZ7wWnkrdAFPThdDntpsZYyurE89pDEkjd7M7Ddrt16eFW+yo+a0hnt3zzzsFsNADd/yywDiAO/m+Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761676817; c=relaxed/simple;
	bh=Jsj8zUh7q4JRP1svl9GdvQm6T0HJZhzp2o/xoMXZEkQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Y/JmMwE8B9SpE0z8CAKLwDLJxSSUiBOBRSten7DmCDupgzEldcJMHmQEuQXW54FpFE4KpKi3rIwXsPfXKJI/EtbWBQ0jIRWf8BDLP2krn23r/8chTNMquaVcCsZGXGg8eUrVPk34B6P7PQeDyYGj5dQ95TNEdj0dnIG6K4R3lNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ks7hQbiH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NOSR+/yi; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ks7hQbiH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NOSR+/yi"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 345D97A00C3;
	Tue, 28 Oct 2025 14:40:13 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Tue, 28 Oct 2025 14:40:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761676813;
	 x=1761763213; bh=Jsj8zUh7q4JRP1svl9GdvQm6T0HJZhzp2o/xoMXZEkQ=; b=
	ks7hQbiH4dc/qQHo9Ud/pqwJUWF1oJMlw9Xc5Fxe/W+NcOKI/IoBiNkn9+SLViFU
	PgaFpi6NJzNx0oYYv2mh12s0j+2IhhIeVVlZrngox5DLpFQDIwT8HH0C6XAc1Sgt
	bMEL3mGbcw1FzFK1HJGuHT8FYD4Bvv11F189sQlYQpkGj6O7wyGOqHFUwoD0RA3K
	7HVm2EJRQqHg82wx/TWRwjQmyIZ0l2jl+el+94VSghyvBe1RJa2jSi948NxRo8gK
	Hcdx7T93yL9NhHp3KsWKeQheQVy2tRS3EZOIsCHelhDcOUD/9QDAk23tWe4Pjsq4
	0Nw9vAuOaYdzz8Ers4OYsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761676813; x=
	1761763213; bh=Jsj8zUh7q4JRP1svl9GdvQm6T0HJZhzp2o/xoMXZEkQ=; b=N
	OSR+/yi8YKHakdyEVTZ1XtXBCIp5mfqNpTYE+WxnjcVJ2Y+qx+rr1ZNSX303OaKm
	h743rF382VoxLjdmwxOQM4yXbo6pm3uwJq4QHdK2PO1aZltiPeTnhdIeaohDMsfp
	13VpGIYnVq+yBxS583s70vIs6lwcZRLP8LArkZD/2wUCecwjXUmnpKSgS+UXwY8Q
	AXv8b4HOi5WWB/wKR3SuJHQ5uRenUFzzWaAzqjO7/xHOZrIE/rZvFRRzuqK2Ngil
	RWXzKIPItZsob8bTZyDobHTXEweuFRZGmkjLkoELVj1kDYlOXNQfvBCOJxoncpQ/
	Mq2LNxjzLlHkem03MKuUQ==
X-ME-Sender: <xms:DA4Bacin-50CtsOO0tHzR0DpBsjjg9N9PGEG_6EDhLDSywCVWyzsknQ>
    <xme:DA4Baf3z0lRb5WlIqFu0Jrjw2E19fN3iRUF7a-CYXz4LKNH95kBvNsMx-c5lzfbrM
    MVfXZfagkKbaCbmXPPB4JOas09TpBQk3AKc_gVQS73cuGf6e4VK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieduheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedutddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhl
    lhgrsghorhgrrdgtohhmpdhrtghpthhtoheprghvrghrrggssehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    phhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopegvmh
    hilhihshhhrghffhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprhgurghmrgii
    ihhosehgohhoghhlvgdrtghomhdprhgtphhtthhopehsthgvrggumhhonhesghhoohhglh
    gvrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:DA4BaYDTou9LzThC7zCk7mlZ-39Dympb8HcyZSaT8RtrbdHylE33DQ>
    <xmx:DA4BadkOznzNcxfQGzn14CLCt3TTa9e2I5Lu6f0xN0FwtaoZQej-0g>
    <xmx:DA4BaWMgPX_RIsklOUiBFE25pAedifmcueosYvomzX-UODqQg6duRQ>
    <xmx:DA4Baa8zZqYQLfP0fghLA1zCWsoq_xGIGPXx2DrQqrlZgAZizNmwjw>
    <xmx:DQ4BaaXvEN-soT-p3BmjVUw9OCz2yWO7klDB9fUcdnQTpqPV7IbXA82F>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A3DC61EA0062; Tue, 28 Oct 2025 14:40:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AfSC1qETFHyR
Date: Tue, 28 Oct 2025 19:39:51 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Adrian Ratiu" <adrian.ratiu@collabora.com>, git@vger.kernel.org
Cc: "Emily Shaffer" <emilyshaffer@google.com>,
 "Rodrigo Damazio Bovendorp" <rdamazio@google.com>,
 "Junio C Hamano" <gitster@pobox.com>, "Patrick Steinhardt" <ps@pks.im>,
 "Josh Steadmon" <steadmon@google.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Phillip Wood" <phillip.wood123@gmail.com>,
 =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>
Message-Id: <56e0efa8-3412-4a61-a1d9-f1acd03e7ca1@app.fastmail.com>
In-Reply-To: <20251017141544.1538542-10-adrian.ratiu@collabora.com>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20251017141544.1538542-1-adrian.ratiu@collabora.com>
 <20251017141544.1538542-10-adrian.ratiu@collabora.com>
Subject: Re: [PATCH v2 09/10] receive-pack: convert update hooks to new API
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025, at 16:15, Adrian Ratiu wrote:
> From: Emily Shaffer <emilyshaffer@google.com>
>
> Use the new hook sideband API introduced in the previous commit.
>
> The hook API avoids creating a custom struct child_process and other
> internal hook plumbing (e.g. calling find_hook()) and prepares for
> the specification of hooks via configs or running parallel hooks.
>
> Execution is still sequential through the current hook.[ch] via the
> run_proces_parallel_opts.processes=3D1 arg.

s/run_proces_parallel_opts/run_process_parallel_opts/

>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.co=
m>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
