Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84ADA1EE7DD
	for <git@vger.kernel.org>; Fri, 21 Mar 2025 08:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742547180; cv=none; b=Moba7ZAyRYEI5M6zDkchYsK8n4P9xebPOELCVejMO+SqRJ8Dwjij6q1x0DQBWUWiwBH5yrctEkdIMmD+r8v96Vb2wP65ARWC0IDo/O3EugZFIrkIFC2IzDulc9oxSLMXqLLwSxwKWoUGxCClghz6QsihMdCzXWEtSG1CsNoDhjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742547180; c=relaxed/simple;
	bh=KHhE/Cyh+pl1q8WlC5DkitpSfEsZaUYnuLOhdujS/5I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qjh7O+mhMiSUfFcInQHuTKG/nTTS3F1bwro000r6oGFjVY0TFkge7cJ/cGOaIz5IjbrutWMAqUie1ZJAfcirkXaSYOQ8Hc5wUPO+U175TlScJmiYqJWtVUYx1acgOm+lzJPkf6iJt081+GKNLQ8mROoKcMm0vXGF/pNM9DaNawc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=woYmaSts; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=flMeS1ZB; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="woYmaSts";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="flMeS1ZB"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 56C77254012D;
	Fri, 21 Mar 2025 04:52:56 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Fri, 21 Mar 2025 04:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742547176; x=1742633576; bh=VYh9PpV1+q
	JxydeQmsiDyJCsRqZgM7DBtHzhhRUboEs=; b=woYmaStsNMimJ5OwdIQW/zYGbn
	3XLEq8QRUQgFzsRSTq356qb94EgLXxuKZgOx9VcOKi/VhUVc/hnVqj/RCvDnvgAU
	qTmFJWsaR5vldX6mXF/gI957bxk7hu2OuFfhBqYlfIgTVVOm7V+cVfvu8ayP1HFd
	iuON/fnjf6X2el/otM4zYOkQG4BNgMqcU5nhRlQsI1wTY4gCGyRoO/+r+3JRvpKi
	8QGiJjTV7Er7VrBcz1xi3nf9dnFP0GQPw77E7bgJKeYmx1k9MXXnOVsMmmdwpRWl
	suyLeC+zm1nESP4Sodxpdmh4wl0QOUww5cNoC6hQetgcAcTgreQLQe02DCFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742547176; x=1742633576; bh=VYh9PpV1+qJxydeQmsiDyJCsRqZgM7DBtHz
	hhRUboEs=; b=flMeS1ZBvifiosYqfETT2Ze64lM6ZNqmkfZgcMer9r8tXVheRKH
	o7CjdTRqRSdh6b4OCv6ZPDXrgQNufshxT2OQFspuv+qqxTBg+whz/F0KVrGxE9ra
	/PRsSZSSc6pYlzTv9HGSQKpazHIBa8EkX2vPLC/QpwGegbOBasetAGI7ktpKpLgI
	XfWjGwjAFRS+yt0h2IdgwHEoi4Gg4ahpQEa7u+mpCGrRpMGh7ioTAVlOWwAvfchB
	xD+cLOWu9xmx2HAKiyHJBoVv490ZBn0+vL0+mXjhJhxxGk9Wh9pLVkg69OY/j56F
	lv0QhOULqn3mP7bFrlFq/c//CZiPzr2yLLg==
X-ME-Sender: <xms:6CjdZ6gHMoD_yZ77kWvmHslnJW_9Zpf040YQYgHfMT2kejkad8s1rA>
    <xme:6CjdZ7BOBI-EHMbJrM2vSocmeeFETWfC1LGgUBgcTQUVYuDcfzxyKJjxUUfS8mTqJ
    3lV_TkGirkxqAGsUA>
X-ME-Received: <xmr:6CjdZyH5J-WDjvG-nOPUdP7fZnBXTcgZozbemVT_Xr5KQlcArjMRexwuvMY7TGDdku1uwUBO09LmtoG0X8bmSB-IzZvvIw1iGZ7smG4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduhedtieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:6CjdZzQlKAmnEss1LtAblOLF2q6_patHTvkukhvrXrSrmJuRY6CnIQ>
    <xmx:6CjdZ3xTuJcs_zD28qak6SrsHhLdXcL1shEi7dt40O9zbkUavrLDbg>
    <xmx:6CjdZx6QszP18nUU0QDpwUnryT6Zzs0r6k3evCub51jlxsYivQeVVw>
    <xmx:6CjdZ0ziNKlmjplGGYUdTGxtpHsCw4gsoDud_Ikn7GdXXrK28bOw8A>
    <xmx:6CjdZ5vuS-Z7fVSzfbCI9auGEspF_uENj1UZ_NO8t-1xG78pmGYpw02a>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Mar 2025 04:52:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Justin Tobler <jltobler@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 1/2] remote: allow `guess_remote_head()` to suppress advice
In-Reply-To: <Z9ukDuvsLXhYTQAP@pks.im> (Patrick Steinhardt's message of "Thu,
	20 Mar 2025 06:13:50 +0100")
References: <fff634dh5qeb4rgjqn7cru7v4a2voj4us4thvwtttxjcdnu2bu@jvv3htcon2ul>
	<20250320014646.2899791-1-jltobler@gmail.com>
	<20250320014646.2899791-2-jltobler@gmail.com>
	<Z9ukDuvsLXhYTQAP@pks.im>
Date: Fri, 21 Mar 2025 01:52:54 -0700
Message-ID: <xmqqjz8ivk7t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Mar 19, 2025 at 08:46:45PM -0500, Justin Tobler wrote:
>> diff --git a/remote.h b/remote.h
>> index 6be5031f64..49c7b644bb 100644
>> --- a/remote.h
>> +++ b/remote.h
>> @@ -395,7 +395,7 @@ struct ref *get_local_heads(void);
>>   */
>>  struct ref *guess_remote_head(const struct ref *head,
>>  			      const struct ref *refs,
>> -			      int all);
>> +			      int all, int quiet);
>
> I think instead of introducing another boolean parameter it would be
> preferable to have a preparatory commit that turns `all` into `flags`.

Good.  And when we turn that into a set of bits "flags", make sure
we make it unsigned, not signed int.

Thanks.
