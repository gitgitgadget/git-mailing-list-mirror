Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918872638A6
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 17:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741712880; cv=none; b=Ku9mmlLPXKYuEkDMloDsARDvZVdnTfoQnDML+Z1dmTbbdgDz/rbtMfo2+OKLr/FgNK61WXsNrsGwWQloM97d/wfkGeYPLu0qZ9CFTc/SZVgOzjg8FlHtpTEiT07j9ZABkoA8T8qP+AWhVjdDWukXUGxfNWhfcaPszeNL/IUnygA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741712880; c=relaxed/simple;
	bh=9hUjKbvtPNZoV3h2getiUdxndgcjlfEpartDV9nbtTQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pGgKLrAMrqLzuCMJaJKZ9yu1JOF/1Ejc5U2P/vJeNFY5NHf2ymXCAIdoYuAmB4q6pkobAXhei9+QwT1j2ByNip99fsw4MU1myUmUO/+76OGTMxhmob1EvkX0z7NN1XMkPeBYuk77MNQwx4wWtCxRt6jKmpbYyTVjYoZrTPb1GsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RMbOp2YF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=8IFiJ0lZ; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RMbOp2YF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="8IFiJ0lZ"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 8564D11401A8;
	Tue, 11 Mar 2025 13:07:57 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 11 Mar 2025 13:07:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741712877; x=1741799277; bh=kvEozte6/P
	GDbc//X0yn0Ix4N4Pfg5zUQOZMFtxQGbQ=; b=RMbOp2YFP9UHzugbqCdiVbcUQQ
	wTU06vXwuryFhRUM2jdvYl19nuYa3xMu2PKjht4ociJk5yETOuwREycjeKvbelE6
	zcswkU3W5QHy5lkiTQJFqo1bY4EcYCSv9A8xGQ/aAuMHYH1Q4FtgULFFNrU9OkgR
	FosylpTeI5sTFU/ZYxFPmUxH2bB9fyDrcwKyz5psPSPmVWpHxIT3mdP9VXeLPhHD
	dnmGBzIoXLljTm+6BGCuNbHVIUak4q9NzSjTVrlSgl3YUkGL3ej5OAvCD5alxpyj
	i5Mkn0lVVpy1KlT23pG/4OxYiN89diuMOnh2ssGEAmaEeLyEmGhIgAi6dF0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741712877; x=1741799277; bh=kvEozte6/PGDbc//X0yn0Ix4N4Pfg5zUQOZ
	MFtxQGbQ=; b=8IFiJ0lZwMP7P5RzcVcrgTP4sbH9nGMIOlEubVjklIfl/tSaZeh
	W5UD+5GTxPu4On9gwLmRqdZcnXvno83Oop8gF/CEZMmmHculuRjHzqqLE/pI05gO
	f2GUpIVNxS3hND0NAyH6sTnbUJyYEAlwTMIp+aoDZ91655IH+RWqInh+tm1Ax1dx
	XeiXqzmxCNnkDbTEGoLJ7Itttoby1N1rrMxlSVCSxkIdUqpKXON9CafC73q+Tbaw
	bxSLF/I73IxW9lwbwDk65+ekne45pXK6oqztFdkQBINLaVyt1ecW2bD0FJpnfdPD
	UCXuljzMe5CsbszA7dSpQOe5mpR30ImGjTQ==
X-ME-Sender: <xms:7W3QZyp8iyw_LQaQ13jCwKxFVzdz3S_2SkdbHpgyGfVVC-HB1cGHOA>
    <xme:7W3QZwq2n3PYB5xQTaK4aeBQjAdZPWqWgDL3qtG7WHOP1IDtbn_2-5rXBe5i8wx4P
    KbsJPYdAyGrhh1p4Q>
X-ME-Received: <xmr:7W3QZ3PWJS2IXoUBgtTo1_YVcFcI5C9fYkUjwxVLot8nBH6GXQd8dkgJNTIGD8Zu5fvIsFLoSXzDQfOeyV-yRUhko-WKGSjEJOYI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddvjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:7W3QZx4Nr-j9t-zF7Nc0WvjYDuq2kQYSx9vTHP4xo7kmKbJBfq4RcQ>
    <xmx:7W3QZx5OPbCM1ujYBeI0LjVCPjwNbZIYl7ECu1EaKffTdH7JljqDjA>
    <xmx:7W3QZxjT16b37edndhCFlNzy_W5N9ArefSPhb4LUBJ_V0OvWyS-eFQ>
    <xmx:7W3QZ74CSs7AXUYejd18jIow9VrMXR6lPl1kjtLDhx6yRAFJ-pDAVg>
    <xmx:7W3QZ7mDDt6mdJHneQEmSJuztEioJp10gvaPIjlsWmB8OIckLh1bfsgv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Mar 2025 13:07:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v1 4/4] name-rev: remove "--stdin" support
In-Reply-To: <Z9AzMaXMGq8BbENb@pks.im> (Patrick Steinhardt's message of "Tue,
	11 Mar 2025 13:57:21 +0100")
References: <20250310231652.3742490-1-gitster@pobox.com>
	<20250310231652.3742490-5-gitster@pobox.com> <Z9AzMaXMGq8BbENb@pks.im>
Date: Tue, 11 Mar 2025 10:07:55 -0700
Message-ID: <xmqqzfhr3384.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Mar 10, 2025 at 04:16:52PM -0700, Junio C Hamano wrote:
>> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
>> index beac166b5c..3f49138551 100644
>> --- a/builtin/name-rev.c
>> +++ b/builtin/name-rev.c
>> @@ -578,11 +578,13 @@ int cmd_name_rev(int argc,
>>  				   N_("ignore refs matching <pattern>")),
>>  		OPT_GROUP(""),
>>  		OPT_BOOL(0, "all", &all, N_("list all commits reachable from all refs")),
>> +#ifndef WITH_BREAKING_CHANGES
>>  		OPT_BOOL_F(0,
>>  			   "stdin",
>>  			   &transform_stdin,
>>  			   N_("deprecated: use --annotate-stdin instead"),
>>  			   PARSE_OPT_HIDDEN),
>> +#endif /* WITH_BREAKING_CHANGES */
>>  		OPT_BOOL(0, "annotate-stdin", &annotate_stdin, N_("annotate text from stdin")),
>>  		OPT_BOOL(0, "undefined", &allow_undefined, N_("allow to print `undefined` names (default)")),
>>  		OPT_BOOL(0, "always",     &always,
>
> I was wondering whether we should also #ifdef `transform_stdin` and its
> single user to more closely reflect what we would have once the feature
> is fully removed.

Absolutely.  That's a great point.

Thanks.
