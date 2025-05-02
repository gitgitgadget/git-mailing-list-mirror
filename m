Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D6318AFC
	for <git@vger.kernel.org>; Fri,  2 May 2025 16:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746204552; cv=none; b=aP6HSntertfUn5Ga7fYycrNJJItJbO2P0p4ruvyo4S/1SZO+ngZg3cttBk+CWbq9foE7XKdnEU16pEFqwFKS4MPqHixz9B55y76jOwxXJKKPKC00XhRBq0BAdz0XeaTVsFXtBbpDd2cz4Td6uTXjf/VhA+roLCzvCl/fRawl31Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746204552; c=relaxed/simple;
	bh=olBKQVA4eF+scc5KEGOrXI2R+LBRDXtnD8tf0FsT1pM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kFlzOwxIns3xzbcZ0wLwau6hLnBlAFsjtYCjiVjVL0dcVBnIAxvnyfEUxxxkg3XrwWRYQs7cYsbU2m94L2Pktg+udot1Zh8SuYgleqEhJdR3IfheoP7pUM3tDi0NXyS/XcN7w3ujH9ukJmiGPeo4FR1HL3pJ+saP54oFWzxDlog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=h1Ilc05K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lQGOfm85; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="h1Ilc05K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lQGOfm85"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id A5D0411401D0;
	Fri,  2 May 2025 12:49:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Fri, 02 May 2025 12:49:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746204548; x=1746290948; bh=FK2Vs5acye
	CrcYQxKW5pEq6EkWRnsoPtIjGw+VrShos=; b=h1Ilc05KBWqY0aH8+BbT0+KWwO
	zyTCG27TuG7ev2zA5HxjIHPHZSM631LP5PK0xQ7/B+gQijU/hdmt173mbuXah8T4
	c9GeGD9N7JDeqicEVYBkb65JCTFTal0/BYCkEe2DlA86kDAY9Eire4vcrdrRJ5lu
	hFm2zyWMg38+Puq1kwg+pCssr2LiWQp+s/XUZ0C3Qklq5gQF9+qoSmjGHcwog5Ep
	bU83aXbhqB+UyFnIjJ3Fmtg1smpwCi7xG0dEnVcf+EsUjOuzfkDO3NCrx0dggoNA
	lwGX5Wu/5QOYp7hOPpZiITYc14DsmBQA6+q4gmNh/KnHTtBCBSpkyEhvJuIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746204548; x=1746290948; bh=FK2Vs5acyeCrcYQxKW5pEq6EkWRnsoPtIjG
	w+VrShos=; b=lQGOfm859U9jZk1oCdmz5+fuuYTXBkGfRAlhjrUWlgBgOAINgdF
	bbI+V99xtJN1gdgSpUAmmcNThXTti9S5gRWRV/E9NSuk4Qw0APMC5pfos1Ve0EZ7
	JWh4G6eSEdFUf1dOBXIytTu+VOpWFcCBQLEM4ybn5nCTqwSML2sFO8vapJbYPdQ+
	Sk+MzxZD7DufMKsu8cfPP6XvZaGMdooJmZzgQ1/iCspzYeZ7yi2f4tlBXOm3Qo9j
	L8T4ATd5hBhJoDIaOQ9ll3rYTbZEkNecfF5RRxpq81s7HJ0rSHwc+hHT6ytzTcQn
	BHwlztg6et3zHwDwWiUYRty7+IFpe8iKGOg==
X-ME-Sender: <xms:hPcUaJeBWEZUV1p0DbwK4YASn-c_j1ktgUlsDoXkf0Dz0KfrGawR9Q>
    <xme:hPcUaHPzRikKUzTJUOldZb_gJS4VfXhxCWnzHRuN2wFT9dqPxeTHYgiJw7aYtBs2r
    NYfAUwFedgePyRd_g>
X-ME-Received: <xmr:hPcUaChSU3F3JH1VlWq605_S8QOZkw4atlppEzhBw6rPIBo3VESDgf2LbZsnVfP122DWEAguSj50EOvr8td4XcAUoHR-M7jGvXZ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedvleejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:hPcUaC9XDc4Py9lnHFv2F66WO-lgmKMCoAh2oybzBL2l6BZHJ0G-pw>
    <xmx:hPcUaFsdmhURgtjkHb3BAbv8C6YVqsT2cvuQ19eDUdDWhI7LR75zIg>
    <xmx:hPcUaBHeyCN6P80gjWOE_EMg8jEnUK0bhwTHDV2S44eh2ElKkL4yOg>
    <xmx:hPcUaMNkU5xMMqkVX1pMDc08cGnZ97E8w9xwxpYtxszKUx4wzl7QWA>
    <xmx:hPcUaOuYAXyvkNdYs_x14ju5Y0AnAeNyqoCHINGFdLYgYcjmoQSfNE-x>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 May 2025 12:49:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] whatchanged: require --i-still-use-this
In-Reply-To: <aBSLgTlfwSc1u_bH@pks.im> (Patrick Steinhardt's message of "Fri,
	2 May 2025 11:08:17 +0200")
References: <20250501213452.370729-1-gitster@pobox.com>
	<20250501225958.2947677-1-gitster@pobox.com>
	<20250501225958.2947677-3-gitster@pobox.com> <aBSLgTlfwSc1u_bH@pks.im>
Date: Fri, 02 May 2025 09:49:06 -0700
Message-ID: <xmqqo6wbufel.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I was briefly wondering why this variable wasn't just declared in
> `cmd_whatchanged()`, but that's because parsing is of course done by
> `cmd_log_init_finish()`. Nothing worth thinking about too much.

Yeah, it is between "cfg that is conveniently passed around the code
paths, even though it is not a configuration item" vs "a file-scope
static variable that will live until we decide to remove (or keep)
the command".

>> @@ -656,6 +665,10 @@ int cmd_whatchanged(int argc,
>>  	opt.def = "HEAD";
>>  	opt.revarg_opt = REVARG_COMMITTISH;
>>  	cmd_log_init(argc, argv, prefix, &rev, &opt, &cfg);
>> +
>> +	if (!cfg.i_still_use_this)
>> +		you_still_use_that("git whatchanged");
>> +
>>  	if (!rev.diffopt.output_format)
>>  		rev.diffopt.output_format = DIFF_FORMAT_RAW;
>>  
>
> I think it would help potential users of this command quite a bit if we
> explicitly told them what the replacement is. So maybe we can extend
> `you_still_use_that()` to accept an explanation?

I doubt it.  The reason why we remove something is not "because a
better alternative exists"; it is "because everybody *HAS* switched
to the better alternative".  If we need to educate folks in this
message, the plan to remove that command is still premature.
