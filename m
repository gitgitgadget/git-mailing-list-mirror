Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6859C318EF4
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 23:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770853259; cv=none; b=Tn7QD82JeKtEtO73tCgo/c8MVgxBO2OIU35zn5s4S1C/9mRRxQJqCttU5pQrPanJumli81kEGvjaznqpO/yrM1hX9+K5iOkuKs1HnNeNf/TqSUl97eRO2v5J0Bd4xMJ7zQpjKPDwi1J8BVmsWJkIL7qh0Y0lVz8THrEm6gK2imQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770853259; c=relaxed/simple;
	bh=uY7EJtOLx9PusgQ89CbwJ8ka4dFNoSSViO8ldVfjS+A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s5n9TMirj/gQgi5JPLaZW8ShmM5XyMtKrjiljvRijsyhOkVy/xLkOr5HlVICMIC+DkXuC5csq0NBJEiyGd4z4xsRqVYKJiLCihbO/i2TdSs0Iumgz0aKTfhQ/lKCqoV9RaVeCD7yU9X6lJ8U4NzK+ccqPtDcUIlAMlhj2Uyb48s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ldw5M0F8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Keo4WRRO; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ldw5M0F8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Keo4WRRO"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 900A87A0176;
	Wed, 11 Feb 2026 18:40:56 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 11 Feb 2026 18:40:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770853256; x=1770939656; bh=LRx7dzMrnW
	/m4nJ2Fr8LmXbbCsAqwHF+veva4of5WzA=; b=Ldw5M0F88kWYig8hwrMhdTF7Es
	fO3Ay3kB9yyUUFx3+tcixnLpsUcl4iA/D6gIgpygXJ1E7mHCXRk8auPbvX+01M0e
	c1Fumi/+FMXnThaphwWGTVRiNf5EIPFLjg2wPXSf2FSN5JbN6zCWEvRctePnNWrb
	GoxY3k4X8ci4cKiOwP4jj91ZaIbtWPCP/CFAfyn6TuPMzzxlkR7GxqCgd10uQPmx
	dJfAgZY4xdKdG+p7LTPN5lkWYjpcaDKp952Vc4P7kSs+/iK4K3gWW01zDLTkg26U
	APr/9GpGWE3nEsBD78+ZlKmVkOAq/t9EjYlc7QseaF3157iOWRN2ymfNKF5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770853256; x=1770939656; bh=LRx7dzMrnW/m4nJ2Fr8LmXbbCsAqwHF+vev
	a4of5WzA=; b=Keo4WRROygDazVQdI9qZtusTCH4zF0qqwiIiSPj3HRRMgB0a/sl
	jBoYVPnmiSpFVcgSblpDpR0h8i9yNySSpaQ7KNG1284e8tNNVsKpkrtVf92YNny9
	diEu6TMMwnfnFUufolfi+jYU9Fiiu0YyXwVyrfhi8KDO75Vl2HOqJWfoyj+TrdDp
	tIKeDKMRPmJLrE+Lhff15R+rnW8370+4+eZ7nMCk54L5BEVkX7oQL7IxHCL9egO8
	cYnAq18Ko+4v1iCXW1Z6OoyrrtU4JIW4b1kivSTldmQRHF947++kVLVIHrAA/0rj
	EgxK1OWZumnfiwpWp8QEEj/SBgW2dG8LMGg==
X-ME-Sender: <xms:iBONaSriS_LOOVb06X4rNCYytVXQHu96nhtVtj8hj4lEY-BPhvcqgQ>
    <xme:iBONaYH_CvSBGtB1MkwGiVnG0VOcoQD8EmNa5h9f0c73w0EQvkyW0jTzuLmHovRM-
    LEG9z3bewJlrT6zuoWnIytvV20LZ-p00VLWLLIn0CnD-8SHeqkj>
X-ME-Received: <xmr:iBONaUm4pme8K3L5olF9MCXgwek7XA0zaB-tjPYwwIHzTDimw1FN3nQewQKUJlLQ6wQprIL7XOjH0KDn7shRr-vD2oPbJjQjxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdefkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:iBONabmQpAWN-54YF4-7wUWnGZgNZBlGBhb3tZetjG86LV7Dtvh4Zg>
    <xmx:iBONaVtQBYQhhsQOgc2dhH6BlwjVcbDX6R6zX-2bsFbDBnvCOS3W-g>
    <xmx:iBONael56gQOie8WesZKfDuxrbOix0G3PWhmFucvmFzPBQ4H5p5avQ>
    <xmx:iBONaQtI_J-Jh1IOjXKnQ4uRyH17_CHqc3GAH5EFx7-sgEbU1h-Ppg>
    <xmx:iBONaQNCKc67y94t7c0q3V6Tvbr58xajmDG3ZWZm2tjN04OmdSqlwkyq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 18:40:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: cat-file: dies with --batch if reflog entry is out of bounds
In-Reply-To: <2b07489b-1689-4ecd-9cda-012540fe56e2@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Thu, 12 Feb 2026 00:13:36 +0100")
References: <2b07489b-1689-4ecd-9cda-012540fe56e2@app.fastmail.com>
Date: Wed, 11 Feb 2026 15:40:54 -0800
Message-ID: <xmqqcy2argqh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

>     $ git cat-file --batch
>     HEAD@{7}
>     <commit>
>     branch@{20}
>     fatal: log for 'branch' only has 5 entries
>     [died]
>
> This is a known limitation.

It is pretty safe to call this a BUG, given that everywhere we seem
to try very hard to diagnose "you asked me about X, but that does
not name anything I know about", as you found out..
