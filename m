Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EE82594B9
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 15:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761923780; cv=none; b=S8jULU4+mW+fIbL2wjfES3u7SzSlzmbSx6D7kedRR6JTIcBxjicUjVsQZr5H6fA2rSgU8EMKnqtqOs1Gnz0FmiCFmihnUOLe3/bld7LijD9AnMf+Hm2E0VHBqivksT2o9hKWz7+USv5ulmA+HUr2l8nz+HcvD2F99vEXZ47MKIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761923780; c=relaxed/simple;
	bh=dUmKb4kIyWcAhxa/sYt2VWCfA/K+JidK7nQEgSnUlho=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fAUuuKtIWrTGAehpkE9mChNsFunlvBOZbKY4a6d0Q5RRCrWX/jHGCBo37AP6f6Pi52iUit4jT0rp3ovHsEvn9f+CwCO8rSDhnCHuAmcWIA17CacIAJK7r7ZlpK1hOovZeGGD5OWgcK+FKr+JUjnxY9Mjobak5sBjhLE9VU7WSHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=L9KoPTYv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XCdSTy6a; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="L9KoPTYv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XCdSTy6a"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A29DB7A0053;
	Fri, 31 Oct 2025 11:16:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 31 Oct 2025 11:16:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761923776;
	 x=1762010176; bh=gndlZ3fJpfYtwyiCQ9dSzZAPm2KmpeBEbxhHHfD1kGk=; b=
	L9KoPTYvsih3mxpup6KgU2W0mAV2Y1z4uAxrroZwyJTcnmXHyYXY3xg6X/qvcETm
	OqFlKWoEAYW8tbhdv5Cn6uN5NMznimjIcdW6MfIldVm/+XkE4LTGRqn6pS/yDj9g
	p1VNMv6Xq+ddfcOLXC5/gLOluwuP70JDlnTVuC45uZJVRBPV1qRXUhlAKIjGKXuc
	GMzIYqqFhbTryTSBzHVyhK3D3alVAdJwvuZdbVRp1v0L2IeeXp+0aXFsrluLZ1m7
	isPyXax5SjJAlhmpO9zRiWSb9KgR0rbGc+LNdi2v5amQpeM7pyot5qX3dNFa0UAA
	GDM/vw64HOa3uSNZM4rSwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761923776; x=
	1762010176; bh=gndlZ3fJpfYtwyiCQ9dSzZAPm2KmpeBEbxhHHfD1kGk=; b=X
	CdSTy6ahOSkVuJp/J9qIIXF30XjYQdg8maON4MKPk/1XEUkub0aoRRVCK3WdKVhl
	UEuOFda4gyFLyIHri5xnhXlByy96/vnmWyl1mN0L0DM5XfX5uYygRKE550XfiCS8
	EPVYp0TXJlRkSVmVQSvVZMMUjT/nIT5JZ1XNbVMDiHUdeJFVi2FekCz3V1Zh3MIU
	HdN19E5JYAZoRZDQs6iz5i6xqKkJWrh4e9HEQz1tUfZVp3vLIxiK011xXxRf8gFu
	51C77zS5qDhagDaOZKGwZvwyUUiWKXvaM2rC56mXAnGXimLRXzbZRQvvuUKZCuvK
	U5OVbfWMUj/N/x736dmfA==
X-ME-Sender: <xms:v9IEaWbF7LI76l27sp5OP0XnNEOiOKi-5-nj8aDO5P50oRY-BAcslA>
    <xme:v9IEaa7a0ttJ3yVZJGXEWTGw_WL6zJsjWju-qmNUecfuoZh94yqjL6nvXdNEXkrId
    El39eMccIW7npg1jAYj4Oxzqh-xOV-kZ2x7MK4QzJxD0xsB8_27Yw>
X-ME-Received: <xmr:v9IEaRAtvbpeXrJt1tZgSm5QXfxMNT_kFbWp5PlazvCrnojnp1FbiDvPSJ-5ciNCGKl36uYtHo1qOX_vJOIIWMLD2k9FAoPys3qF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieelkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehurdifihhnughlsehukhhrrdguvgdprhgtphhtth
    hopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdroh
    hrghdruhhkpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:v9IEaYfpxOdFJnHXMihLPbWJH-tKxJaNIX1y8QtmdY47mYVpA2ficQ>
    <xmx:v9IEaYIAVEmdNVJrKMXUPJoaaELMJcnCgKezhewGjb1aEWtL2zFvxg>
    <xmx:v9IEab1EgtxAac4QCAwkd20BEdRbHMMXL38j8MFeUct9zKpjGvLZaQ>
    <xmx:v9IEaShtOHohGtJKwB3Yt_OYhjv8grFo1sLfseohBBK6H3Ojb7a7Pg>
    <xmx:wNIEaRQSyALIYRrdaeCl6a7EJ12iDeK8mGYpxOZ9I24F7uQXfu3GaILa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Oct 2025 11:16:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Windl, Ulrich" <u.windl@ukr.de>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  "git@vger.kernel.org"
 <git@vger.kernel.org>,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [EXT] [PATCH v3 6/6] add-patch: reset "permitted" at loop start
In-Reply-To: <77991a11c53f40b8b0a050a4d081809a@ukr.de> (Ulrich Windl's message
	of "Fri, 31 Oct 2025 10:28:47 +0000")
References: <c72518099a3b465c8761e41210fe3fcb@ukr.de>
	<fe8e8097-2b05-4dd2-a754-f59e4ba5f95a@web.de>
	<ed73a585-5074-4e36-9f41-228909513237@web.de>
	<77991a11c53f40b8b0a050a4d081809a@ukr.de>
Date: Fri, 31 Oct 2025 08:16:13 -0700
Message-ID: <xmqqfraz2jb6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Windl, Ulrich" <u.windl@ukr.de> writes:

> Just a comment of personal taste: I think declaring an anonymous
> enum inside a loop is just bad style. I think that gcc is smart
> enough to optimize if "permitted" is declared outside the loop, or
> make the "permitted" use a typedef for a "named enum" (declared
> outside the loop while the variable may be inside the loop).

If this is more than just a personal preference (which to me does
sound like), a patch to improve it on top is very much welcomed.

The change itself would be just reverting the code movement, drop
the 0 initialization and resetting the ariable at the top of the
loop every iteration.  But the rationale being that it would give
compilers a chance to do a better job, I'd prefer to see a compiler
person write the proposed log message, possibly backed by data
(perhaps "generated assembly is objectively better---compare this
and that" in this case?  I dunno).

Thanks.

>> -----Original Message-----
>> From: René Scharfe <l.s.r@web.de>
>> Sent: Monday, October 6, 2025 7:24 PM
>> To: git@vger.kernel.org
>> Cc: Windl, Ulrich <u.windl@ukr.de>; Junio C Hamano <gitster@pobox.com>;
>> Phillip Wood <phillip.wood@dunelm.org.uk>
>> Subject: [EXT] [PATCH v3 6/6] add-patch: reset "permitted" at loop start
>> 
> [...] 
>>  	for (;;) {
>> +		enum {
>> +			ALLOW_GOTO_PREVIOUS_HUNK = 1 << 0,
>> +			ALLOW_GOTO_PREVIOUS_UNDECIDED_HUNK = 1 <<
>> 1,
>> +			ALLOW_GOTO_NEXT_HUNK = 1 << 2,
>> +			ALLOW_GOTO_NEXT_UNDECIDED_HUNK = 1 << 3,
>> +			ALLOW_SEARCH_AND_GOTO = 1 << 4,
>> +			ALLOW_SPLIT = 1 << 5,
>> +			ALLOW_EDIT = 1 << 6
>> +		} permitted = 0;
>> +
>>  		if (hunk_index >= file_diff->hunk_nr)
>>  			hunk_index = 0;
>>  		hunk = file_diff->hunk_nr
