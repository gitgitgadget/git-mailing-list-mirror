Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0ED26B2D3
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 19:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763754169; cv=none; b=fqD73XtfehuxA8xRrwcC4AUk/WLu6RUNFnEupsoZ4oUG8eawzEGWTZIxaVeIDsuY5NpkS+f7UAFI/7RQfRG2jIFVF2eSpnAdS/odKNUTVfzaQdk5snKzNXSx5BNSSaMw/hWrwHQMFHMQe9GKwjlbbelxDWhLWZX5FKQtMkCz2gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763754169; c=relaxed/simple;
	bh=Ajpamcd+cU9LcExzfyVOAxOMSl4V0SYZMgjwT7/upDc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oXqcyDrA0wZbh0fna0JM11SDgFbLetQbfEcKAjD4g769WK6f+CAOzEUok5aAfh/WFXp4ycbOghW5gWq7FVsN15ntcsU0GsF+9I55pth2E7VABLZKc2+uf/M8UjBmwNZ4qhsFCnfhceOSuminL3BKuhdqMBACyeYcvx+C9KbDbLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=at+PflXG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=y4+f3pcx; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="at+PflXG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="y4+f3pcx"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 496007A00BC;
	Fri, 21 Nov 2025 14:42:46 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 21 Nov 2025 14:42:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763754166; x=1763840566; bh=5/JjfKIdKP
	xhPoFbbg9XzAnKnJn9aq6yJ33mIEOVNEo=; b=at+PflXG7qHKjldXcgK7v8FXl7
	1VxpZVuUuEWYPOB1We65g0NMHWomtQSz0iy/0mUmnbXehntcHKpaIBSh0ksg3rsi
	441Um4r5kLb+gTEESXkbO2gLIgowi/du7/pC9o0P+V59mu0ALW4nOxIoo5sbxcKH
	yUSWcVqJebWPBwfMZNoeDN8zMeWNDtx/Mz5IYGu1ZsaB9taWeCBUZM9nUlErjA6v
	dpEg4g6/LGVKCJmFtGAsNgxg7aW46pcB+CGYcAYNdSLfvGu4CMlcklcj5RTe4fKA
	ok5Cuuoo8NodmtAZHcE0PZcmkqD5Pelg0BQdevFcCkrk5brj4aoC9WsVDVLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763754166; x=1763840566; bh=5/JjfKIdKPxhPoFbbg9XzAnKnJn9aq6yJ33
	mIEOVNEo=; b=y4+f3pcx4uq55kFeHAbgMZOmySD5Q/o5eQukvBs4bYNnu9PnzKx
	2nZt7/x9vFeezfdxlSvOqNUTOlMZWG9OOLZ99xRw6C72B9YkS5Rif2+Yk9Pl5VWd
	QMyKV956qJDNm3Ad/PwfNxn3FGlUZPWr3s+W7RIZNShqE5XlZHT0x59VD8biWzaj
	FRe3jfV+2b0MO9TyVebXOGv1Qi4A2WUOdtWDlueqL19GU9D50e5D6pRCT2HR/seW
	ljq1bbEB9uiXmz5DGKINgAuF+9HgkxOHQg0AjZuAfWZvzEgr+STajztb+jTHyg90
	6GbKRXrQqYopIxdk1qAy/NNf4U3scNH48wQ==
X-ME-Sender: <xms:tcAgaXQHpPcpEm8qYWNnQEnLtKdD9BZS76RFIzNkfy3rkx1BGbYDIg>
    <xme:tcAgafpKpmFX01Sz1NC78RWX2NnFDYAhD-KWHMQ_YU6VC3CB6gEF5TV2EV2pNGCCG
    zhkGkZgwt4TFUU7n9WdpW-Arp8PCMKSMkH-y9jFjR2m9L1FpXjsTw>
X-ME-Received: <xmr:tcAgaVIbtYgYP2aXpJ-kyFTj0mkakCwqkAT9GZ7JWM2OAfzINc0e7UJQruK8z2t_eGvZVTDUsG0ZOxXqlVL5IfUwS5pAmgMSCH3e>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfedtkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkees
    ghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:tcAgaSp44bx2aJh1PFLiHLX9aQ2yiNDczC2KuNOyNpeQNJT5bDBCQQ>
    <xmx:tcAgadyiw2UgBHPyIMM5fBveQeuy5JrFGD12IyLyWdgZTn8HefrbGA>
    <xmx:tcAgaWNZagdNAYHXt2X8M-OFC_YOVYeLIEloYKwZReFkYErlFrSlug>
    <xmx:tcAgaS5JFExQLHMx88FxLK2i-nlhYThQimVDEwWkmVAL2jZJZp3VjQ>
    <xmx:tsAgad7yDS199IjzEntCKnKriDroSLkqXRh8G8RdLCaj5fl-OxAXyGWA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 14:42:45 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Justin
 Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 13/19] streaming: get rid of `the_repository`
In-Reply-To: <20251121-b4-pks-odb-read-stream-v2-13-ca8534963150@pks.im>
	(Patrick Steinhardt's message of "Fri, 21 Nov 2025 08:40:58 +0100")
References: <20251121-b4-pks-odb-read-stream-v2-0-ca8534963150@pks.im>
	<20251121-b4-pks-odb-read-stream-v2-13-ca8534963150@pks.im>
Date: Fri, 21 Nov 2025 11:42:44 -0800
Message-ID: <xmqqh5un41fv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> diff --git a/streaming.h b/streaming.h
> index f5ff5d7ac9..1a3de6812e 100644
> --- a/streaming.h
> +++ b/streaming.h
> @@ -7,6 +7,7 @@
>  #include "object.h"
>  
>  /* opaque */
> +struct object_database;
>  struct odb_read_stream;
>  struct stream_filter;

Extremely minor, but "opaque" used to refer to the fact that "struct
git_istream" is opaque to the users of this API.  In a later step
you'll remove the opaque comment (perhaps your change in that step
will stop it being opaque?), but until then, you'd want to keep the
comment next to "struct odb_read_stream", as it is my understanding
that object_database is not opaque here.

