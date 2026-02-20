Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0CD2F6192
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 16:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771606414; cv=none; b=UAMH7tiCBeFW63bQnykg6oTyGBSdiRHBLNZ2P5UXKpFwpMeMNGyIdRvLNx66DCbr/yg71ei18meOE34X8r0vyT+bT6WSMiE+9mDZbx8kUIK7h6t3HS4zXIJQ4ISjeWbW0F3cteeDlU879sTG6E0ofjikdvq0+eH5dBBZexm7i7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771606414; c=relaxed/simple;
	bh=YrjOL6E9i/oYIdot0nKX+UrTCk57bryYKvJe4DhidY4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ejm+ZlieXAfUPaA/Wm5ssQiWVQEMXVv496PeEWV1TQB2N87+6IiOLPQTUrHohV4mfiifFHBEXSXbWc/YgSu8t3fYdSM+O0P+PKNvOxZB0bUOzS2XHpHzcQ7h+R/rYE83KJH71mRSZOoydJsUXicvbJrxvnwRHUxaEikao8//oaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=2pgqPNT9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KpgHdwDW; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="2pgqPNT9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KpgHdwDW"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 36841EC05A8;
	Fri, 20 Feb 2026 11:53:31 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 20 Feb 2026 11:53:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771606410; x=1771692810; bh=vZWecQlMBW
	gvyr+HPWYTler/SKrDKRWWry3JNiDoQCs=; b=2pgqPNT9AW95RwYQswtcP+E2Qm
	SSt5WtsPVdEb0g9EZYlms3R6PN/gmIiJCFbt06fz9pXF3bwnznKSC6mHD/4KL+z0
	vJUdshS7xG/1bb8fDkrUzX705ESaqMBa4zeYiArJySyd/76j9ivWvDqxfh1F8jdw
	w5f5we+443b1CT9qZNG6OsQGlpW5+LeRHcqEnBX4BBrjMMUAp5kXcTID7cf5aAFC
	zDHdnD+ZUtPbBYGFMdLBvmD7VNvrdoKE3H2stt05i/HRGDkcIS434Em3IV8zmhgo
	QsCiwRm8hvSBi1lSYzJTTq/Mgp8i78nTPqt5iVHibUFmhtqF76RgwWmuuDxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771606410; x=1771692810; bh=vZWecQlMBWgvyr+HPWYTler/SKrDKRWWry3
	JNiDoQCs=; b=KpgHdwDWGJXcAbieZ2uvBZf5iaHNO3nx3qvR1qv6c8PaxLGq7kj
	tlstL+1I65g8KJE24LyS6GcWWb9I0ZfVupcSSgujag9Zw6NZIlUIf8ve7J5Vnd6c
	W1TJToK8Fbj/yUkT+gObsoQxuV+AAIVJc7oq3kj/3IDHvXqcDanfJrd6B59FlpYm
	Z7qMULNlq9VlVlVOvVbbRKbLrKGWTCH+qc4lMxa3nREzWq9oGoNK0zVUvcwzZCfb
	meh4HcW5rIv3Ra4DAmkcnrZTB0tqRArsaugFj9KdEnoLHa/trm69/AtZibwmaa0i
	TkfTYcVVH6pgtmgmzwst5UeHQjtd4g5U0VQ==
X-ME-Sender: <xms:ipGYaeu9a5ePY7wZyclprGDjZK9cC3rc5B0layzvDu_Oj7ORkb1oFw>
    <xme:ipGYaaXlUT-3DdYo_NNa9nf71s-evyWtnwia9J3tFhzTSUV7SNrTN-a1WzMVisbHr
    VPZ-VbMyeoWISmKrQ7xL38nY8HCRGpOlEww38sdN9MzUs_XAqmwyA>
X-ME-Received: <xmr:ipGYaSGYX_f7eIfJDBZEoMRW049ryeLRZolIwH9ZGjuaIxroQDfUyZqcW9noTtBZx8ptHPbKM78V_-YT_7oDN2XzopXWYvA2kA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdekleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ipGYaU2Wbpg6MfSuyBXzgJ7Ek6W2jP-8I0dTGDBR8gkqtFjvrDpjYQ>
    <xmx:ipGYacPpMMxz5dRNmx7iozw8BbtJmwW1UB1GviVzLQ5KHXuIUAIlzg>
    <xmx:ipGYab4TmYBoBXVp_cS62SP7uMt_RoAmJUge7E--cfFLEf81U6sZUg>
    <xmx:ipGYae1jS5bzKzCiTAkmX3kuNo_AGwos2cBN2xmEYfvn6CAdUdNbPg>
    <xmx:ipGYafSemmDwMj-uSaS3i80V78N96gcl4TBvYiA8TC0-fKEjoDL87ssl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 11:53:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v7 5/6] refs: allow reference location in refstorage config
In-Reply-To: <87342vfmud.fsf@iotcl.com> (Toon Claes's message of "Fri, 20 Feb
	2026 16:36:58 +0100")
References: <20260219-kn-alternate-ref-dir-v7-0-16f27860dbdf@gmail.com>
	<20260219-kn-alternate-ref-dir-v7-5-16f27860dbdf@gmail.com>
	<87342vfmud.fsf@iotcl.com>
Date: Fri, 20 Feb 2026 08:53:28 -0800
Message-ID: <xmqqbjhjz793.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

>> +static void parse_reference_uri(const char *value, char **format,
>> +				char **payload)
>> +{
>> +	const char *schema_end;
>> +
>> +	schema_end = strstr(value, "://");
>> +	if (!schema_end) {
>> +		*format = xstrdup(value);
>> +		*payload = NULL;
>> +	} else {
>> +		*format = xstrndup(value, schema_end - value);
>> +		*payload = xstrdup_or_null(schema_end + 3);
>
> Also here, why did you put the negated condition in the if clause?

Hmph, would it make it easier to follow if you swap them?

	if (schema_end) {
		*format = xstrndup(value, schema_end - value);
		*payload = xstrdup_or_null(schema_end + 3);
	} else {
		*format = xstrdup(value);
		*payload = NULL;
	}

Maybe it is just me, but I often find it easier to follow if the
case that require shorter and/or simpler body, or the case that is
narrower (e.g., error condition), comes first before the main logic.
It is in line with preferring an early return on a more specific
condition.  It frees readers from having to worry about these cases
early and let them concentrate on what is expected to usually happen
in the code.

In this particular case, I do not know which one I would prefer,
though.

Thanks.
