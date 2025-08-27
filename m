Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485B62DBF51
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 21:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756329256; cv=none; b=BWR9tbkEDXkea8+OdxqWj248x7CXN+zRKlruK91MuFMNHypx4ssQf+Q40FFaBZHwqCDTq35tMu0tizlGWohDW6kxvyUg21Mao2tTJ5kMdBXjtjJOGzpYyUAuG38Xui1nmg5pfGw04j4Y61cyXF+/yjb/51KW4grKW2Oplwiejbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756329256; c=relaxed/simple;
	bh=fR/FAH6mvAbG0xfDWtcMSymEzafziG0GpCgj87HuIGg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jXcFTm5mx6V1+lU2joEQYK2pX8AGuYkoU6uGOzDwE3punSpfx3zFCoerdEh5J75ICpAfqtmDGirwTpBRvAOwvnzF29U8Zn9ydbTVtsV1FkZUcHCv19KAuUaJXJ+KOg/PvNiqjCdmeeFlymfke5RRXGtVZ/ouATazMJsy5wzSTEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TkUk29P/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ra+wgdx/; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TkUk29P/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ra+wgdx/"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 47B897A0136;
	Wed, 27 Aug 2025 17:14:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Wed, 27 Aug 2025 17:14:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1756329253;
	 x=1756415653; bh=wDH/C8+BE3UmvTaniMqLm39oaRyEo0rRZ1pHetSwIw8=; b=
	TkUk29P/KAkZ9lyJkyVa6bKaMmEEoE0ykJcylIoKQrinjt/uCJMqFxAt54iHUgpg
	NvVjnfFB5Nig9FGNF31wm/RZY7NRNarmv6toQR3DKM/amOrQU6DpzQtKLvkIxMiy
	7UU/JoRys8tkjZExMWghWj8Py0g6ywXR1Jt7pIIRHfRT6J+s918v/xpkxf/RiuxD
	z6/UmGW/du/ob1q6FEzjUJ1Bzm6FIE0ZNdngayVHE9Lx8z8H3rtTdpZLQGjlm/x4
	RjPRguIX2uU86fV84q8N+5o9QHt4YLdCN6YLusR43LW0sR36GiGHVpY+hZ7EGpwf
	1xCUvpJ8FK3I9WQhZxySvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756329253; x=
	1756415653; bh=wDH/C8+BE3UmvTaniMqLm39oaRyEo0rRZ1pHetSwIw8=; b=R
	a+wgdx/L/cEVcyBjBrl75+I08kq4d9EU72zx1Kffon4awT6xywqlsY6QgFj7q5OG
	4vnk3IVT789q6tom+oP0lLDqw7QAeKtGwwzsY74BrbNLpRLuIe3knjK+QE1/MILc
	9tN5nqRKHR3ALc04AzREhNK95s2k/wKYCiVMMLZkvHhAxvr1vLpAhHlC1fZIXFk7
	IaRYGJPG2L8upVImBpu78uJrdc3N530g4t1LIePsYfP560MLSXD9ZxmEIUCIKcFv
	MS+J+C6Rbvp0vkAH1xofSEgrPqBgtMRwZtt4yGBZ1hMID1por1jbf1wxsWPVqMUQ
	szZy3rzRl1nmGuQ6Orimw==
X-ME-Sender: <xms:JHWvaHMhojxM5sXhuVnN-POMdwa3LgSg0u_wTt75fad0FH1hQURTfQ>
    <xme:JHWvaMidA3nsxrfrR4_lPDVhSQ76xxLW0raw6CPGpEiFGYX7bOAMlJSeNn-UPe14o
    6AjpwzVlLlBzW8xCA>
X-ME-Received: <xmr:JHWvaC3sy4PZPsuVvCiFB0UYmXimjW2DQHVgASEzGd3M5_On5ZIgvYub80y2B-1nsD78X7GcK3AOgvsjSb1VmxDAwP0nW5fEEryEogM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeelvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpeejgfduuedtledufeetheehudegvdehueehteeihfejveejgedvledvleff
    vedtvdenucffohhmrghinhepghhithdqshgtmhdrtghomhdpkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhs
    thgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghp
    thhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:JHWvaOgywcC5y7TQ4Wn8F-riMkm-lPK_HLRoPRUEgi0obBUWNwkeAg>
    <xmx:JHWvaKdqdRKE_PI-AqlRl3jgjMA2Qn1Y77V5g7Pjw5T2hyQA0JvFwQ>
    <xmx:JHWvaJmGrwXxPLzrBt3ppLEdHF--0jWrPyceIxO0yKmeWDqzsvJrYQ>
    <xmx:JHWvaLur4vyXWXiqQ9KQntj_1SN0soEGe_XtG-YfiEWBSGjDv_4rdw>
    <xmx:JXWvaHmVOSbs2IhLQZk0lfW9R8lgGJvjttmU_keIRe-o42l3BjkQ6dnu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Aug 2025 17:14:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH 1/4] usage: help the user help themselves
In-Reply-To: <9611573e-fb0b-49d5-933a-50d8e0603701@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Wed, 27 Aug 2025 22:36:04 +0200")
References: <cover.1756311355.git.code@khaugsbakk.name>
	<e81023edb2d78d2be0ecffc071f2c5316b0c7a32.1756311355.git.code@khaugsbakk.name>
	<9611573e-fb0b-49d5-933a-50d8e0603701@app.fastmail.com>
Date: Wed, 27 Aug 2025 14:14:10 -0700
Message-ID: <xmqq7byozcv1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

>> usage: help the user help themselves
>
> I think I’ll change the area to the more pointed:
>
>     you-still-use-that??:

Ah, that makes sense.

> On Wed, Aug 27, 2025, at 18:29, kristofferhaugsbakk@fastmail.com wrote:
>> @@ -377,12 +378,22 @@ void bug_fl(const char *file, int line, const char *fmt, ...)
>>
>>  NORETURN void you_still_use_that(const char *command_name)
>>  {
>> +	struct strbuf percent_encoded = STRBUF_INIT;
>> +	strbuf_add_percentencode(&percent_encoded,
>> +				 command_name,
>> +				 STRBUF_ENCODE_SLASH);
>> +
>>  	fprintf(stderr,
>>  		_("'%s' is nominated for removal.\n"
>> -		  "If you still use this command, please add an extra\n"
>> -		  "option, '--i-still-use-this', on the command line\n"
>> -		  "and let us know you still use it by sending an e-mail\n"
>> -		  "to <git@vger.kernel.org>.  Thanks.\n"),
>> -		command_name);
>> +		  "If you still use this command, here's what you can do:\n"
>> +		  "\n"
>> +		  "- read https://git-scm.com/docs/BreakingChanges.html\n"
>> +		  "- check if anyone has discussed this on the mailing\n"
>> +		  "  list and if they came up with something that can\n"
>> +		  "  help you: https://lore.kernel.org/git/?q=%s\n"
>> +		  "- send an email to <git@vger.kernel.org>\n"
>
> Maybe (thinking out loud) this should retain some part of the “let us
> know you still use this” spirit:
>
>     - send an email to <git@vger.kernel.org> and let us know
>       that you still use this command

We do not actually want to bother individual users about reporting.

We may want to catch third-party tools (like we heard a problem with
Jenkins from its users), so

    - notify <git@vger.kernel.org> mailing list if you are a lead
      developer of a widely used tool, especially if you heard a
      breakage report on your tool from your users due to this
      message.

perhaps?  If we know that version A of tool X (or older) hasn't
migrated, users of the same tool will see the same breakage, and
some of them may come to this list.  If we know about their problem
ahead of time, we'd be better prepared to give them a definitive
"Yes, we know version A of tool X (or older) still uses it, and the
developer of tool X is aware of the problem."

Hopefully ;-)
