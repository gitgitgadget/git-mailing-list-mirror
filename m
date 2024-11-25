Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09291426C
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 09:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732528312; cv=none; b=CcL6Pa+GbcXBrTTN1e7goRBzJv8zHAggNVmJleKOKUOXAx57yz+lJCQ6G6ONhtbZER3MT8hXRNuz6xP/m0fSUtfjQ1OhTRPU66mbu4wGL2Zi2hvQb1CaTDqPppei/+trabrsAA5WfF5yD8Aky7IsAqIv+s8Q5QwvXp4vymBJ5PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732528312; c=relaxed/simple;
	bh=hpA6rcGQkQosLH2TGavvi+6kbjF9QW4Dn2PHxMpwfgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1WdY6TFmLxrUosgSG3ylicXdE5D65fkQ8oJcPp01LprUkFUnpIX04F0nw845EdPM/dmmIYobyy8DXU2/DDnRp/hRB+uHtF6ZeonEpzqK/RMbtqH8W030WpXUopEXxrrdIgZlqJvxSdhXP/uAQcXTpQB8hlI1+ZhJeC0a3QIxY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GVoXRjd+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DIXD8VOO; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GVoXRjd+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DIXD8VOO"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CAECE254015B;
	Mon, 25 Nov 2024 04:51:49 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 25 Nov 2024 04:51:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1732528309; x=1732614709; bh=XDV2M0Db+j
	aN152xIDNKENBl/3RpCjJ+MDRNmTxEmHo=; b=GVoXRjd+mRSUR/XN6sG/YSuSFJ
	8N8kUnHwC5HBHGwG9BFa2Z3lb/wiGDP8cUKfw8wobCrjIArUcQFeHBqu/nAr0QMY
	TaBYPDYA/DvtYzYO7OQ54gmEWyCIzKvEZ+5T4SGvof6InloRaPDwBBSUEYwK5q2b
	wowWRYQcOtT77T9yWVMcX+v/yHMiJ/qK8iv+ENXZFKV50wxmH5xebnBRTwMCsStG
	Dp1MWnjQw6X3+R6B4m8ucMo6jTci/jHmGeAnTWaz1Q9paODgQE/Xr9s+TJczInqT
	KxzN6cedJfqEEk9tsiJ+JVv36Ym00UEn8ZUzHawit8ogpGzKs/e2NhP1+NGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732528309; x=1732614709; bh=XDV2M0Db+jaN152xIDNKENBl/3RpCjJ+MDR
	NmTxEmHo=; b=DIXD8VOObNrlwKgVhCIN5J5rKrKanGnf/b2g7yuzY1Ou+qBXAOM
	kDHPFt8VZKOYDa8pJdFOdnCdk0A+rKB+aF8NPc26Oqa/lw7Re707klWYhL9WXL16
	bb3dbo2q8OM57tesnIzI8Hf4t4A5kpzZioekiMjcgizQ/DlhqImemrVfkA6tkAkn
	Dg+od7N6vfq7doX/z5iYbaTXUOozsANUXj1ttkwCdMfAq8vCCwj3LG96guA62oIg
	pFsBXA6cpcek71xhnqj+WwCWZUQnJCIJGDhSB2BS3cotGzF3pJvOnfnTeLzyTwAs
	MOpxj/vQLXjdkRR35xxo6bifdi8L7e3Nd1w==
X-ME-Sender: <xms:tUhEZ5g4-sbu-RireYCOxUb48y8yzmNizxUtkqZzutnYHPmvF5_yiA>
    <xme:tUhEZ-DEeMtzm0f91IyWotRd9A3kDEam3wBkTY9PqxxNuBe6C14EWnCdlq24oZyIt
    BIVzQHrpL8Ni1B_Kg>
X-ME-Received: <xmr:tUhEZ5FrLdmphG9IjE37msYgTBS5Ug4Jl0mhaJQcGJdHbt-R9na08P1sryZM8vcwOlefRaLPHInyr9jb_t4FsAO6sY0gAIWsJJi3teDPsVQIUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeehgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitd
    eludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhonhgrthhh
    rghnthgrnhhmhiesghhoohhglhgvrdgtohhmpdhrtghpthhtohepvghrihgtrdhpvghijh
    hirghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhstghoohhl
    sehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesgh
    hmrghilhdrtghomhdprhgtphhtthhopegtrghlvhhinhifrghnsehgohhoghhlvgdrtgho
    mh
X-ME-Proxy: <xmx:tUhEZ-R-inPs2R5RtSs0XIYpijl0wGWq1auB-ru1CX5xP4q_MnCVYw>
    <xmx:tUhEZ2yjbI5xph_KIIZc8Ke0AubxcoguKtNnVFyWvHnwERg57g2hcA>
    <xmx:tUhEZ045iw-COV8eV_IpVB0gXigUi6B9t9nZ_s5onuKMNyEv6g654g>
    <xmx:tUhEZ7wLSZ6P2ULqeGkz93wPakk8bcg-jQ6Nmj6vki9PMTDVIgthEQ>
    <xmx:tUhEZ1lawtRT6gfgeYubyHFta6VWS472xwQEQOs0XqPg5gQw_onCKKag>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 04:51:47 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 06f3d57f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 09:50:44 +0000 (UTC)
Date: Mon, 25 Nov 2024 10:51:33 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Eric Ju <eric.peijian@gmail.com>
Cc: git@vger.kernel.org, calvinwan@google.com, jonathantanmy@google.com,
	chriscool@tuxfamily.org, karthik.188@gmail.com, toon@iotcl.com,
	jltobler@gmail.com
Subject: Re: [PATCH v7 1/6] cat-file: add declaration of variable i inside
 its for loop
Message-ID: <Z0RIpRh0QlPWk3F8@pks.im>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20241125053616.25170-1-eric.peijian@gmail.com>
 <20241125053616.25170-2-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125053616.25170-2-eric.peijian@gmail.com>

On Mon, Nov 25, 2024 at 12:36:11AM -0500, Eric Ju wrote:
> diff --git a/fetch-pack.c b/fetch-pack.c
> index fe1fb3c1b7..bb7ec96963 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1328,9 +1328,8 @@ static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
>  	if (advertise_sid && server_supports_v2("session-id"))
>  		packet_buf_write(req_buf, "session-id=%s", trace2_session_id());
>  	if (server_options && server_options->nr) {
> -		int i;
>  		ensure_server_supports_v2("server-option");
> -		for (i = 0; i < server_options->nr; i++)
> +		for (int i = 0; i < server_options->nr; i++)
>  			packet_buf_write(req_buf, "server-option=%s",
>  					 server_options->items[i].string);
>  	}

It's somewhat curious that you change the type to `size_t` while at it
in other spots, but not here. Doubly so because `server_options` is a
`struct string_list`, and `string_list::nr` is of type `size_t`.

Patrick
