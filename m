Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6957801
	for <git@vger.kernel.org>; Mon,  5 May 2025 20:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746478151; cv=none; b=N0sHF0F5YDc5c6yaJeN/Ha91tcyymv9Swo25Cu3zZec1n2NQQafy+IJreWP6WzYG72FdxACBkuB6lQDC8kz0tJvwsyltOa/U1pZwkWqJpczRXYKdDK9K5PvtmxR67+fB17CqvQkr2OLWp1BAA9Yl2blxEvelZyyy+NTO5y+YN0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746478151; c=relaxed/simple;
	bh=CQbLUIFNfvPpWF9R7pUjJE5OrzhAp8JniflOZuRRjYI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mXJ0940d/JpkVLd49EFE6ET9ah9GQnkvqZID9UA9rQXWrqUr1S+F2i3+GZrHyF1cWR7dbQkVSfSG3pd2Gwpc0A/4Tupr0D7TVAn3RZ56EL0ZyytIJ5ZmwTcH1FaYzPfkbKvlcettxSTfHdVfTcDOa98uwtyvDM9KmdoXLD1M/4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pUcHu4ta; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tY1rxe0w; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pUcHu4ta";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tY1rxe0w"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A7AD7254029E;
	Mon,  5 May 2025 16:49:08 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 05 May 2025 16:49:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746478148; x=1746564548; bh=fX8bmI9yre
	gZqutOwnWA7UtNxjXTCobTXRiaOpCgEZ8=; b=pUcHu4tatBbC2no9dD9kE+l/7c
	zQfUyPdlgsOIQwFzu98pWvAxB9GuQ1T7E9LqSHj8MxOY9LQs9jPp83cT9Fd4BrP/
	FsVv78Df91HnliTS/ooCDcZ8KG/wxMXi1/qMAGKtAG/sE6avBTJlFQ1rNqi0DiX9
	QdUml0NTz0oh21XO+i6KLVldO+qE648QbDqN52mdzk4YxImhNpa70ELztKQ5BzxX
	4zUaFNP3HbbbeTqwp3RiIpz/sSgha2uWkDZPOfKd8b6wXfSaxDaH3zssl8SDzaUw
	Mn5sm1tkZ81eowvnrbFdwz+g1tW8W0KT51krpTpUpCKUoxz/O7mgHU7lms7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746478148; x=1746564548; bh=fX8bmI9yregZqutOwnWA7UtNxjXTCobTXRi
	aOpCgEZ8=; b=tY1rxe0wcIs9I9IDaA/Wx+3P/FMzo5gSmCmzN3utDIL805Po3qR
	RV9bUz4hBHdCqtXodD3vwMWqQK78hPY4vTrrztV598xERMQNqNoi3lQKq6GQhrNf
	vShzc3uZrcrc0AUviUkjOCHLKAjSzzq1fwZ/9cJx0Gr3lbjrldGu2Uzm1u2Xi63Y
	tyiCGYsAqstm52R4NVAIIW44fhgb0JpTrS8p9otQcjoIQF4UUEHh5KWY379M1n4a
	FNweyHbMhuxAM/La3u2Aw63BUckCB3zjyR9NPxRsgqavDGPGbXTqwwkM+Fd/Kg8x
	jFBpDESWNP/ll1ewNzfvXMYJsWlbtIBp+oQ==
X-ME-Sender: <xms:RCQZaLCMQnRp2ZlhaMsd-PBnus7VxKwgN47OqDkCQMri7Yc-HECUxg>
    <xme:RCQZaBgj8uRe1hReUuSJRf-mPOIilMpzqe0IJT6c8gih8ShSTVLC1iWxo2yZ02m_C
    1Sa3LLepsl0SJwpwA>
X-ME-Received: <xmr:RCQZaGnZICga0QKmeBFTTPjfB-7D1JUG29D8jlmlUbWrAGZZ8k8QdiX2_-8UO03F4u6PznLLFIIVFBq_5BlHQA_fl0fBXS1P9-OB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkedvuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefg
    feeivddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:RCQZaNxTAFlMPjnftHjS9WMvh4XfCPKaoocdkeFBFbDoIOiJ9SwYPw>
    <xmx:RCQZaAQhj4MnNr3US0q9x_dAo9UHJG2qzn1Put-bstPuJXYIuUUDSA>
    <xmx:RCQZaAZDMQQes9yHnEIU2JiA4aIbZihQqQIfB3tnC09t7Lg49AKObg>
    <xmx:RCQZaBR_Vnugwk6qxiViDYpkjTHnVSDOG6-qVod_bp1l-qByeVXdYg>
    <xmx:RCQZaBB_vrqC3JxaeToajfEoDyhjiQAtfqXEzNTBQ-ZIPUGisRH57Ecb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 16:49:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 4/6] whatchanged: require --i-still-use-this
In-Reply-To: <aBhhAZJYXAhBVw61@pks.im> (Patrick Steinhardt's message of "Mon,
	5 May 2025 08:56:01 +0200")
References: <20250501225958.2947677-1-gitster@pobox.com>
	<20250503005814.3030099-1-gitster@pobox.com>
	<20250503005814.3030099-5-gitster@pobox.com> <aBhhAZJYXAhBVw61@pks.im>
Date: Mon, 05 May 2025 13:49:06 -0700
Message-ID: <xmqqfrhiokal.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> While at it, update the documentation page to use the new [synopsis]
>> facility to mark-up the SYNOPSIS part.
>
> This while-at-it change feels a bit funny given that we don't touch the
> docs at all, but I don't mind it too much.

Yeah, that exactly was what I was thinking while rereading the
patches.  I think it may make a better organization to delay it till
the very end where we do add new material to the file.

Thanks.
