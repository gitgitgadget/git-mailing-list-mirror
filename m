Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674A17E0E8
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 20:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758141872; cv=none; b=QuRQD7KXI4DF2zbt/DY4WVCX2WXCRTip/WxkVtW3XFvUS6XSa0/xMkDlWu0n2ZR/fWrhGPe7eC5hQbUWsY1HyupAMHhn7AmQLZHREdKvlDQ8uV347JqI33C5vx2+tvqEc/6bple/BxF0dv6lifNnmBiDWqnu1nJ9MNj4fxiSyiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758141872; c=relaxed/simple;
	bh=vtAiS1LtHmEb4xiQHE7KAYdPkXN5tEQLWkor8rwYTcY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SDliGRbN3HB3rODcGlA9JwxNAvUB/UA2NnxHE6+8cVnYEpLIOeR9ezNVxyd0omTxivDwIbMxt1vvYo5RAen5rcFVNMbSOLIY5oR0GYVXuKZTv9gcFE3HoL3L5uIKhRfq0hiFp61Ok+z8HuJt2dXcvHOEThDdd0f0JzGULyKFI8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vKqrbKgr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Oggo1mkZ; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vKqrbKgr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Oggo1mkZ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 7C3ABEC0272;
	Wed, 17 Sep 2025 16:44:29 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 17 Sep 2025 16:44:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758141869; x=1758228269; bh=CMBCGlUYbI
	/CDpXQaOzULh3H1vnRw55PO09eF1Yj7Gk=; b=vKqrbKgrl7W578DnxQrt7siEtC
	5PPFEYpqEuswV1ZifnXG8OyIfjo0BU5GEDBap6ZnE87O4kKuijDDaiGFhqUtKN3a
	lMfAavCDczNsb+C9OuKH88tJ8ryg9bW8i++KyPL5BjIKlI8EAG0il5grcQVCOflG
	V0rYGJcjRZMVhZT8o03a4FAjdFQOGdIcEF3ZZXKXCHBhwa6At9+fBg6OW1NY/Chz
	RhAxd76M8a/JZb4j/M1AEFdHLWeLud9w7WIfGaB2l51Gn1ALZ+v8Bxrp3qIQIRAz
	QfGkLhfgv0O+OXhzdkWay2rKONYELcuubIsLsWSwgVTDvZs7hteoPRqL/z4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758141869; x=1758228269; bh=CMBCGlUYbI/CDpXQaOzULh3H1vnRw55PO09
	eF1Yj7Gk=; b=Oggo1mkZBsRDnzP0wSufV58lmR6HXVUlfmk9lzcQA0Znv5DxOvi
	Dj7W9TJa6m91WtKKcdH5Gh2MIeba4YNqNmP/sJnX39Vxfvig56B0dWBkeoXWUCfs
	BEMv4z51cs0dcFJSeqyIW6oK921nFVHowe41unCUlRkusBIJjLc6TTC/LgM8mCWE
	NxOCjZtZmsAmGGZVPdNypfyXWo5zglD54nYH7E6qGP+J0307+VTPnnoMn8TEUGkT
	cIuvnbpd7vk8gvgmrSQjkYHmi3jxziI3cum+YyZKxyqpikB3rLj+KxWSMneIn22p
	ynxfTmhwxU9w17Zj8ImT+2a1EudEHAZbIQg==
X-ME-Sender: <xms:rR3LaDQndSwoas42pKHMCjtyuiDngN3JR-ix9alWxlkfQAJvNVtV-Q>
    <xme:rR3LaAT8HA4fThAamKI-KhHhkaXCjvpKAzpL32dA6u31OGLMqJMlxCMWm9IvKW6U7
    7JNtiIYGoqEk7JmJw>
X-ME-Received: <xmr:rR3LaPQPFF6umPZ3MTDl_SE1B21AxjVs_IL9xyLhdhNzoOlL7GKy_EJyR1Bc-ImgjDvrg0QIUdl58S_R62ikIH6zDGapII6SXpMiGVo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeggeeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeettddtveffueeiieelffeftdeigfefkeevteevveeutdelhfdtudfgledtjeel
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhith
    hgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhi
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:rR3LaN6_5ZZpjkxCm-85nAdkC1w5UxslDQtejoNgLPdfq0KtrHUanw>
    <xmx:rR3LaD1_2BIKbxXXYvWKxdeUqflH21LkgI5bEHlH8uSzzWtccIBScA>
    <xmx:rR3LaABD9BAW7WIY2Fc5xJAg9H06ROaPI-khUiA4IbksGY1qOzmTVQ>
    <xmx:rR3LaGPIo2c8KsJ1hYzcDOD_TeM7DRYHuFL9aABPS5SXnQFcbmzY9g>
    <xmx:rR3LaNRCUVBFVig4twWJn5H6pstTVzZnjnlS3tWHQFKebXJ6DWtf6DOk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 16:44:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>,
    Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH v2 00/18] Introduce rust: In xdiff
In-Reply-To: <xmqqcy7pc8ix.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	17 Sep 2025 10:07:34 -0700")
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
	<pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
	<xmqqcy7pc8ix.fsf@gitster.g>
Date: Wed, 17 Sep 2025 13:44:27 -0700
Message-ID: <xmqqms6sbyhg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> This is a continuation of
>> https://lore.kernel.org/git/pull.1980.v3.git.git.1755921356.gitgitgadget@gmail.com/,
>> but I am removing the RFC label.
>
> Continuation meaning that these patches build on top of that earlier
> 15-patch series?
>
>> Suggestions on changes that I could make to this series is appreciated.
>>
>> Changes in v2: High level overview:
>>
>>  * patch 1: cleanup: rename variables that collide with Rust primitive type
>>    names
>>  * patches 2-4: Makefile now produces libgit.a correctly
>>  * patches 5,6: Documentation from Brian and Patrick
>>  * patches 7,8: Introduce Rust
>>  * patches 9-11: github workflows
>>  * patches 12-14: introduce crates build-helper, and cbindgen
>>  * patches 15-18: varint test balloon
>>
>> I would like feed back in two categories: big changes, and little changes.
>
> This seems to also mix in some patches from Patrick's series that
> are already in flight. ...
> ...  Having duplicate commits that happen to do
> the same thing in multiple branches "git" the tool can handle just
> fine, but that certainly is a bad communication among developers
> that we do not want to particularly encourage.

This seems to be even more confusing than I thought.  The text in
the breaking changes document may be based on Patrick's patch, but
it says something different from any of the five iterations of the
original series.  Since RFC v2 on Sep 5th [*], the introduction
schedule described there had multiple steps before Git 3.0 but the
text we see in this series plans to start Rust "on" by default and
goes directly to Git 3.0 without any other intermediate steps, for
example.  How was [v2 06/18], which attributes authorship to
Patrick, came into this shape?  Is this his update over the [v5 7/9]
of his series sent outside the mailing list, or did you and Patrick
working together to arrive at this updated text?


[References]

* Patrick's rust-balloon series (various iterations)

https://lore.kernel.org/git/20250905-b4-pks-rust-breaking-change-v2-5-6939cbf4a0b8@pks.im/
https://lore.kernel.org/git/20250908-b4-pks-rust-breaking-change-v3-6-1cd7189fed3b@pks.im/
https://lore.kernel.org/git/20250910-b4-pks-rust-breaking-change-v4-7-4a63fc69278d@pks.im/
https://lore.kernel.org/git/20250915-b4-pks-rust-breaking-change-v5-7-dc3a32fbb216@pks.im/

