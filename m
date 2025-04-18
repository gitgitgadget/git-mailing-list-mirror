Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9161B4243
	for <git@vger.kernel.org>; Fri, 18 Apr 2025 20:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745008193; cv=none; b=AMfr2nrKDFFaATcSK+FpusUYFC/3gvsJS7RrhkeTqfs+MIfRn9iGbNDmf/NfBmfSDVQGL+Ru/KozEbDj/i/FV9c6sq3ElTJ6nGuNKLmTtWJ2HSO55rKL56X+i9Ja+SWup9vz7vVc+MfLwrj/rDuYPZCSe5VyYsERvU7/+HRxVFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745008193; c=relaxed/simple;
	bh=NZsHHqjMjfoEjFnr9B7nBEJ5hjK2ceh3oRErUXG9Qbc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bmrgqFRnqNmwDgjtuRonmzhWweeEQEdErVDFK8zPvKZ6gu/oef7uQda9RPfT1CiuGOaR9euP8hRRh1Az/D2TTkzblRMDpHjm3mvUDiHLH79xSr7P9NbZx3zBwjTr2BKNYDRORSjZi1Vym+2w/niUn53zjku0DxvjKrTSKE1WY48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Pcr4RgWK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n7QKdZTK; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Pcr4RgWK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n7QKdZTK"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4DEAC11401C0;
	Fri, 18 Apr 2025 16:29:50 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 18 Apr 2025 16:29:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1745008190; x=1745094590; bh=PF+nS8rDKQ
	JDd/fU35NOfm5QIAOGSbNus+1tet7XE+8=; b=Pcr4RgWKompoAYLughWXPONpnX
	2DDI4fEuFc7dm2AZdZSmYMnRP7fAX/SqTZu/8Q7Cflq50g5JOJ0+DidOIZ5OLobK
	uTcd2weyyjCtZBakjhM9Zkt0UQqs0CO4cFFIu7Oc+mm9ipsRfX7EScziooeBqg76
	enmvl3sGREbJMUSKqhRZ/5Y04fn/08CRexXU1jRTlWCtLZjn8DVx2xGPMcEEH/RX
	W/1JSt3cmYeWBMyKv5+nVouwH2SDCMCbPeoBt24xqFqBYcaLRqK5AfAk6O1xx1Xz
	LZiczA1rgRy25cjTBld+ohje61+HS+ZCHYI6XHKVWFZX9TSYzgzEEuvuGTGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745008190; x=1745094590; bh=PF+nS8rDKQJDd/fU35NOfm5QIAOGSbNus+1
	tet7XE+8=; b=n7QKdZTKVg3VXlgKhYOJKpXiTcpRDr26EbXMIBohXk4Ew2yb9sf
	E7QN46+Coloc222zrjE8lAkpbY4TEwNkYY4dMbpyDU1xXf+8IZ6W9h6hb34DFA5B
	26PoyvXyhjNGUrB7eIPeYp9TRptKHJl00Y8ltegUw6npPHdycrZmplNDeEupPYwY
	n2NUXuW2notM+i3rAdJFXVSX6GFG+1yBRR6WN6MpYXqTJeZiXuRf+4XbpaS5Wr6M
	VjamA2tpIf7eH9ozKBwTzZRSE3YL3CG2AEZyXh0DWHoIyGsiWWkuo3lSRQF6G8gc
	RUWmlV4BvHrYQp/wVHT1pGTHsFmi3jRnQfA==
X-ME-Sender: <xms:PrYCaCiLa4SPkZK_Zk3WcYhoTDbRRV6b84QSnQb4D0No_NXWXGwRAQ>
    <xme:PrYCaDBMpkH6CQXRmrOlZBI8P9_kzoSn6faQ6-xkbreFdqh24s1oDhR8vT8dMhI5X
    addEqdsh-5AvXruwA>
X-ME-Received: <xmr:PrYCaKHo4S_HcML1uPK3kyG7va_AWxzWK5gMF1Gf3fqSwJlbfNIxKM9-R_J0dtoCcTU2f7y2TiHXQ540h-ZGV_Opva8f9wIXH-Fi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfeefudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhutggrshhsvg
    hikhhiohhshhhirhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjvghffhhhohhsthesmhhitghrohhsoh
    hfthdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:PrYCaLQegLHafmOqiAeVi4d3_H5_Z7TEID05m-dr9FCHy8Dl-GtP2Q>
    <xmx:PrYCaPyOVlE-nPcCLtZIZSKTi_BwlwWr5Xs1_aVTRQSlGQrtbdmVYA>
    <xmx:PrYCaJ7lhz9Xg7Ikrw0DTnojya4hv2mzVqT_IR6jkyEsfnoovStnow>
    <xmx:PrYCaMxJbknE2kkVPJnBVEiNHEmnu1UTiacoTEnBDA4rVSXquBkuaQ>
    <xmx:PrYCaCWW6ItJhU5K88_UCzfnNjhh7ljatBew2_wQd_882wqxgaHyGMVO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Apr 2025 16:29:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org,  jeffhost@microsoft.com
Subject: Re: [GSoC PATCH] json-writer: add docstrings to jw_* functions
In-Reply-To: <20250418165651.14125-1-lucasseikioshiro@gmail.com> (Lucas Seiki
	Oshiro's message of "Fri, 18 Apr 2025 13:56:51 -0300")
References: <20250418165651.14125-1-lucasseikioshiro@gmail.com>
Date: Fri, 18 Apr 2025 13:29:48 -0700
Message-ID: <xmqq7c3hb4cj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> Add a docstring for each function that manipulates json_writers.
> ---
> Hi!
>
> Given that my GSoC project needs some form of formatting JSON output, the
> already existent json-writer.{ch} will be extremely useful. So, before
> GSoC actually starts, I decided to study a little about json-writer and
> just found that it doesn't have docstrings.
>
> Here I'm documenting what each function does, as this module is a general
> utility that can be used in any place of the Git codebase and other people
> may be in the same position of studying of it does by directly reading its
> source code.
>
> PS: I'm sending this as single patch as many docstrings are similar and
> json_writer was introduced in a single patch (7545941). But I can break
> it into smaller patches if you prefer :-).

Needs sign-off.

> +/*
> + * Begin the json_writer using an object as the top-level data structure. If
> + * pretty is set to 1, the result will be a human-readable and indented JSON,
> + * and if it is set to 0 the result will be minified single-line JSON.
> + */
>  void jw_object_begin(struct json_writer *jw, int pretty);
> +
> +/*
> + * Begin the json_writer using an array as the top-level data structure. If
> + * pretty is set to 1, the result will be a human-readable and indented JSON,
> + * and if it is set to 0 the result will be minified single-line JSON.
> + */
>  void jw_array_begin(struct json_writer *jw, int pretty);

These are not strictly wrong per-se in the sense that you can indeed
write a "top-level" array by array-begin, followed by array-string,
etc., and finish it with end.  But such an array can be embedded as
a sub data structure in another json-writer with array-sub-jw or
object-sub-jw and once it is done, it is not "top-level" at all.

Perhaps it may be beneficial to give an overview of the API design,
at the beginning of the file (in other words, not a per-function
comment, but a comment covers the whole json-writer API), to outline
the concepts and philosophy the json-writer takes to build json
objects, perhaps?  Covering (I am not trying to be exhaustive here,
but merely giving ideas):

 - json_writer is to build a "collection", which is either an object
   or an array.  An object is a set of key-value pair where keys are
   always strings and values can be of various types (including
   objects and arrays).  An array is an ordered set of values, which
   can be of various types (including objects and arrays).

 - you open an object with object-begin, define one key-value pair
   at a time using various jw_object_<type> functions, and conclude
   with jw-end.

 - you open an array with array-begin, append one value at a  tie
   using various jw_array_<type> functions, and conclude with
   jw-end.

or something along that line, perhaps?
