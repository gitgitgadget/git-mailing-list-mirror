Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336E017278D
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 10:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732099373; cv=none; b=dcju29E50IkCzOQtU+DkvR2Sxg0Q7SMr6WPJSdFELTqE1AF0rZD1HJun2BWN//ix+rUTEepXIoRldMKLNqefiB/kRTPjPZHZvcTqWZ4M6qtPSK/UQsrJFe1mOOUvrMtELIFdUq+EptUU6iLor73Vqz7IGnfkJXGOIsyRcQBW7Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732099373; c=relaxed/simple;
	bh=HdeoW1LqCj9W1W6NGXPF2drR3nSB2+Ye0yV88lsT+WY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ZE059iRb3eo/dPdsi/jvH0mW1LUVXlxDfS/6tCqALbxVn9WJrWwV1QiOH6wAE9buD08vD28GwB2k+21i7LHpTxtezhpA811fniqr6dXTHfLGb+koaMjWsfXU4XNlmbljNMqJyp28O4YgKUtJNgJmJRmXPI4LWbUwHrPJOsVumNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=YFmp6zJE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vdJafkjW; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="YFmp6zJE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vdJafkjW"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 2DA4B114014A;
	Wed, 20 Nov 2024 05:42:50 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Wed, 20 Nov 2024 05:42:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732099370;
	 x=1732185770; bh=HdeoW1LqCj9W1W6NGXPF2drR3nSB2+Ye0yV88lsT+WY=; b=
	YFmp6zJEe7qTjtAPDWCyyjMk1S1klqPC4GKd93czKpCgllakuZmdXXK98YzW0HiN
	YsaeDGocE+zBXu++IcBJuLHJRpPJbVr3fTGQhMmEThdVs5jDvxgop/u/ACbdm5km
	CaOMfNZlZOm68lEYrlQG20MYoW5dm+GUbOq1/qFYx6CNfSFag9iSRh4TG+V3Z2Qr
	csbqMK3fBqhP2XsMbZ+xYxA8Nvx0aGqZLkyq3bB0em7KAm14DoHuOz4A0XgTiI0W
	lfRZYRgf/VoZFx9SIZxkfCU6C0Lm/m1RngfOaIehafS/QQ9dbuzAcVdmuTaHslUr
	9Z2UGXTEvDDkbP2tOQghkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732099370; x=
	1732185770; bh=HdeoW1LqCj9W1W6NGXPF2drR3nSB2+Ye0yV88lsT+WY=; b=v
	dJafkjWmp9saocxZmU0oucFDuZykX/GObrBHx+MM8NJ/kDJnLXwIzO4LrXYaSOgi
	RpMGy88qn+8Bo/HE6nxm8AVLtQZJ55n9z+eUVwZ603XglcOR3rxAGfYjdQK563Cn
	g65QJb1xKWn/vT6Ssirp7BlKQWbc5B33XSmzzDHzHOZwGmN/Jesuq2gITHltz0UG
	EEAM9JA9tOI58k5Lokk8+Twbe2o6c34aiv5jmQHS05G1NUm3P2T2DW3ny2V+XaMI
	urCWLh33nKeDPLJqKgANKgN/yW7OiOFERioFsprWhOFAasnoI7sA+3RMjzbuJuNy
	VTdVDKg0KF6Yd1yx+hW/g==
X-ME-Sender: <xms:Kb09Z9LR3pKjCyxx4lxls6qXN-WssCHQIeh1DjnnViyHuSuxsI_DKQI>
    <xme:Kb09Z5Ie8Iqu1KSOBALcT0U6KnqfawxuwVl6rCgcK5kRmWHEYmmycDFVwYJNo2x0Q
    2AmXVkoVpKf6R_02w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeggddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeen
    ucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrght
    thgvrhhnpedtiefggeejgeejhfehuedvgeejkeelgeduudekleejkedtveejgfeigfefke
    dugfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspg
    hrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhi
    khdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Kb09Z1uIrKV7MJ98tOM4d72iTCQVTlkZwMy3AcF0bNP8u9WD6JjI9g>
    <xmx:Kb09Z-Y8v2-nUmiA85Key396R1oS6CBcs_BOwA9l63FQdJmm9IoACw>
    <xmx:Kb09Z0ZWbzmWxZk2CXZAaZZvPcHTa8-TNfBg5o5TV0wFtS3WIhf-Cw>
    <xmx:Kb09ZyA8WTn_Hao54vsAN3mIKxFDb0kF_xvEGWXWCxiVC1-hAZ3_6Q>
    <xmx:Kr09Z8EFIUfjaZ4PdqfUgM-ZoRbw9MWzls9SB6XJNTOUe-eSyCUOoQUH>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CAE6E780069; Wed, 20 Nov 2024 05:42:49 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 20 Nov 2024 11:42:29 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org
Cc: "Karthik Nayak" <karthik.188@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>
Message-Id: <afed1ddc-90fd-446a-9da0-b8e8f3fbb903@app.fastmail.com>
In-Reply-To: <20241120-pks-refs-optimize-migrations-v2-6-a233374b7452@pks.im>
References: <20241120-pks-refs-optimize-migrations-v2-0-a233374b7452@pks.im>
 <20241120-pks-refs-optimize-migrations-v2-6-a233374b7452@pks.im>
Subject: Re: [PATCH v2 06/10] refs: skip collision checks in initial transactions
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Nov 20, 2024, at 08:51, Patrick Steinhardt wrote:
> While we generally cannot avoid the first check, the second check is
> superfluous in cases where the transaction is an initial one in an
> otherwise empty ref store. The check results in multiple ref reads as
> well as the creation of a ref iterator for every ref we're checking,
> which adds up quite fast when performing the check for many refs.
>
> Introduce a new flag that allows us to skip this check and wire it up =
in
> such that the backends pass it when running an initial transaction. Th=
is

Missing word? =E2=80=9Cwire it up in such that=E2=80=9D.

Maybe: =E2=80=9Cwire it up so that=E2=80=9D.

> leads to significant speedups when migrating ref storage backends. From
> "files" to "reftable":

