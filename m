Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F131C54B2
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 21:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741640925; cv=none; b=ilem9bALWT4usYjFyyYs28rhmgifM/8HrZsYnjiBVNtv+pg1xXlC5PDFmy+dyL95xNbp+Z+dwjM1C1arsCz442gJYBmrKrmf0uySU5vuo+i4nJnpXU7DpZqnEqNPaQNdYib1/vJVx39KRRB+T8V9j+rp8I4iyo9FrPTM7h6kU24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741640925; c=relaxed/simple;
	bh=IOPHfEQHRrORLuuK3QekojD/AWX0TT8WaQlsIm2ThCg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dv7WfIWG1UgUX5cG5Y0CFieg37jvBbscXvC6FoHEurAri/3OtQjIXV3wGCh+58qNxXHo8xGv34X9iOPwFBwImKUKLs9rj8Jdm7OKD/8ED8Gy+y1CAit5KoOvKIChQJ8ZeNqOaWRH6bTLB3sy82HrWG5paRuo45iFSt8vvRr8x8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WG/Km5x2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IvofgYi1; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WG/Km5x2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IvofgYi1"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6E8822540121;
	Mon, 10 Mar 2025 17:08:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 10 Mar 2025 17:08:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741640922; x=1741727322; bh=optu/Zp9tH
	R+GSrQVgmeBZXoKF94N7iAI/YufJMe02Y=; b=WG/Km5x2XUoFnoTvmciU3KkVru
	RFwuIFz9rwHVv9C5WzFS88aSKrbb+o8b6MNjJ45wMLoozXqB0eTxo8oUHFT2Pewc
	j7r+qB2NNtyR+7NcM+nrC16+0j9ufUDlcLoe1T4JhelK0ZRZnYootj6NaJYZcIhO
	/h4bpzh2p9agju93CZp9RcebzEKEgbrvxCZbSwQQi/ABXruqGoHloxzRHbpz7dZR
	4T/qho8NQ6pCxLc4ThMxO2BOR10c/9tP34z2ebtYHF6dAoPVWpgRVxieMQOnixds
	5D8zDAd3OvNeCxCbz3MRsDaMfc5TGSdJNCuT+eWPFFNIAZTf/oeale8e38ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741640922; x=1741727322; bh=optu/Zp9tHR+GSrQVgmeBZXoKF94N7iAI/Y
	ufJMe02Y=; b=IvofgYi1vBgeQIlE8QGc+tkG8e3J6pPJ/580E4LTs8pEGOhglv8
	XL9HJ/4m8PoRV4PHALkhOCTh38nN06qcBrvrVNzyNmHyshKoo69gGzn01p/kiqe+
	kcerJxLkdLFOC8PpfvxqREL1ugaMGhMxZgdHY/flsoOs+wrI4rnmXRv4DX07KRa0
	D2F0P8C9kJPZqErYXIPhqQHjXTdZchrnsomUdMPjcAyaE2mHwqbntkYLmhRZCvox
	j6U/clyvyqy42obOd4c7v1TATEs3wryGbUCf7Y8XJJF+yHxf4F9Q+DjElu5qQsJe
	GkGpCe/BzzIjgfqUV863zGVpZBWF7c+639A==
X-ME-Sender: <xms:2lTPZ0jKj-KGs1ENwcD3-1rwBYbzGe0N9ujl9mAcNq317hzMx5_B9w>
    <xme:2lTPZ9DsS9nBs8vIZNRvg_Xp7O6X9OH8MC0dLFUYtALQwCBjFyEy4CwJ2AfybpoWa
    7_jq9cmg93VAxvs8g>
X-ME-Received: <xmr:2lTPZ8EMN2Pf-OCt5lClVuO-h5X9wINyHRkMULZd61-GqqqXFloCLa2fuGw59vaSC5kov3EHgQ2-A4VlPu4waM7q1_gXmI837eeH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddtfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoheptghhrhhishhtih
    grnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:2lTPZ1RAtRjDf01anGLMzH6Tg-w4i_wM_eCdOjVyNeJWRp1Qb36QhQ>
    <xmx:2lTPZxygq752aM40o4dqbKzoRzJgtB3WOW61XA4KSGnHJcHzU4qkzw>
    <xmx:2lTPZz7wosOyMgMIcX0X-kciRBVwO9Su-j7J3g-vpVBJGujPnoYO6A>
    <xmx:2lTPZ-yP_V_O_9S3h4zlNjx_5_8zBuUR2ytSHauxna0SGKoj5WMlog>
    <xmx:2lTPZ0oB7Wr5URwTYXv7sT54dsmke1c53T9PsGSqi-uG4Qw6bA1G9w9D>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 17:08:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  christian.couder@gmail.com
Subject: Re: [PATCH 0/4] rev-list: introduce NUL-delimited output mode
In-Reply-To: <xmqq34fk7hb7.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	10 Mar 2025 13:37:48 -0700")
References: <20250310192829.661692-1-jltobler@gmail.com>
	<xmqq34fk7hb7.fsf@gitster.g>
Date: Mon, 10 Mar 2025 14:08:40 -0700
Message-ID: <xmqqfrjk61bb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> As this topic is designing essentially a new and machine parseable
> format, we could even unify all three formats into one.  For example,
> the format could be like this:
>
> 	<oid> NUL [<attr>=<value> NUL]...
>
> where

(0) "rev-list" that gives only a sequence of "<oid>" for commit-ish,
    as well as "rev-list --boundary", would fall out as a natural
    consequence.  Bog-standard "list of commits" would see a
    sequence of "<oid> NUL", while a boundary object would see
    "<oid> NUL boundary=yes NUL".

>  (1) A record ends when a new record begins.
>
>  (2) The beginning of a new record is signaled by <oid> that is all
>      hexadecimal and does not have any '=' in it.
>
>  (3) The traditional "rev-list --objects" output that gives path in
>      addition to the object name uses "path" as the <attr> name,
>      i.e. such a record looks like "<oid> NUL path=<path> NUL".
>
>  (4) The traditional "rev-list --missing" output loses the leading
>      "?"; it is replaced by "missing" as the <attr> name, i.e. such
>      a record may look like "<oid> NUL missing=yes NUL..." together
>      with other "<token>=<value> NUL" pairs appended as needed at
>      the end.

