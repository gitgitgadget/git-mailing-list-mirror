Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F925175A93
	for <git@vger.kernel.org>; Sun,  5 Jul 2026 01:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783214886; cv=none; b=uhAQZVZxpFEMjwsy5C0CmRrGdeIHGevXIRGGCNeDJ8ukgL4yrzmnzjP9N+lUh5X8ErR2dEeCkHG9fYoCrUpKbnBXJeMFytbIHcCZmnddKXwUfFk5hu0QlY9CeSB/WC0iIYEfl64139GrY6HYOr2W9E7VyeM/98+SSCKALoI9ZB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783214886; c=relaxed/simple;
	bh=OSyra1VpoQ3SoYN06Wbc5XZMKxc21HSTepEbSqy5M0I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CTMe6eV+V4fr6tzThn/XDAsjbdHllArPHnTYSEtxNfEZa+JKsG3xWEuaw/EtY45Y2maN94zSvny8y7CauhyB1xUmogQrbMEVBpq0p/0x5ZDg6mt7QCnuy0gaSbfbJX6CYTDEwfKVUngQiT2+h7EV3tyJSDRdrnr13JBmR6xBQ18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Vmk6mHV2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o4hyrHUS; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Vmk6mHV2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o4hyrHUS"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 81F457A0065;
	Sat,  4 Jul 2026 21:28:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Sat, 04 Jul 2026 21:28:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783214884; x=1783301284; bh=cy3NpNVtQW
	k93MaJfCWkjXGXovQckvSysUKO0t4HOco=; b=Vmk6mHV2T+XBQOA5KEaLmz8AII
	MX7fEnotf65VCa5azxJLlV3QphcL1Ghh737dRrR7yufEY5xOFDohfSwfBlkjO298
	Q6qzPruNbnDq6gqpdfbDPuqXoCk/AUJOohcZkssgv8Wk2Vt4Wfz/A/nEOJmlM6Q4
	kB0q1P3MfCzXac/vunwoU0mKeO5XxTNoqjqtCbKRD5f8ITZmLxzN5xWLczIM7FC9
	X+3e4PZydr27ScP7V/jbmtueepGq316Ttc69JRbqIcdbQAkhpyF4dU3v7oU5uvXg
	dWwoXg9FJidI5s68fghBK5kh9IdjXDX5sRDzkuAAJy4xCdkOjdBrkDegFN9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783214884; x=1783301284; bh=cy3NpNVtQWk93MaJfCWkjXGXovQckvSysUK
	O0t4HOco=; b=o4hyrHUSayFPplroOPTjKBz6jss4SWeddwC237GkuiXIMS7ElyA
	3CMbxzRrILmPTwEpSGA+OAi8BlB7ZGgBWUEZ04AR+2JsYVo+eSL30LC8UUo49PY/
	zrdyn9MfTbZFv/Nr+WACNZMQS+/DL1pI7SqVpv3dEjif8X5/6cWVEXETj9J/kmKv
	8a1/1mV0oHxa56W/ata226TNqA49PjEOw3KKEeFKOsVhBQUKYmHs85HmDf+aNuII
	kUeT7S2Y1v7gWyeACrFfL7/X2L2KERohn+2gSazlzBvWhi6hD1MfAg1596nEmMxz
	2d8br3F9vS/9soO1jIpdFIdwXgKl0ISW2mg==
X-ME-Sender: <xms:I7NJatQ_9cCQ7QorsZapj3zi8LBW3Hgse7b77Bz5UNrHTyqtljivLA>
    <xme:I7NJatxlY5IVHIY1HmRt4OuyPqwLvqArt5fTnxMVjkhQ0lKnKZL6WR7jW_daryMWc
    wixJuOomJuoSxMfj0G_bv-nd5I7Dj6_HCyHTski5BIIvSaKj2lT9g>
X-ME-Received: <xmr:I7NJan0UkL4RnGQqN2VopyIRqTzLZUCkqB3L_6VlQoYTpHVzbvHmCOa4BG3jn2iLClFRTAxq8t28sKTr2VY_DbZA384WUyUGopGqVAI>
X-ME-Proxy-Cause: dmFkZTGvmVUcOmLRKaOMDTbdZfNtCe0pt14VjWp7nxRHmVYuqWTjM1kKPwda2uvwL8Ia4e
    TrEF7Otl9U14V/yWxWfwGQKbCjLiWaIPGZZ4fIHtY36ptD1eBVlyhbTcxjAO8QFopAXmtc
    eCyL/4JAeZJqpQ6sbGAFTvRbMyalnltUcKKs5gj3ovshE23yiKu+uSUgWSysa8BNOpiKfH
    ZTjARV2Ie3Gh5VmKYbSz4qp10243dAT3pFOpRA2XdF2U1J88XullDh6D1y/Yx4JDRfUsQm
    o1KuMB8NJMtOJkW6W6BpVhjm25Ak4EH7xGj1f861/ZiVb9EIfB3GRQbu1RwxkjwioZrZUc
    00r8LhtXXN8BeIV5gpNbTAonOigK13zQvn68dcqvBzilzEEm4AXQcM/PrkPJ32tz6aCAbk
    bCVyUmLT+qdExfJU+43J6ZWKpsVv0NTgXE7oqyG9r/Q2r/as/NZvrNUR5WQVlzrUdiVmhp
    UzDbE2FKFjneokOWFg/d+zwh7OrMOHe+6OvDdUZPgg1g+9si4Vx8w6xpUSXzQAIm5RElJ+
    HjEKbfUf0zLf5mu2X2Y5W7hu1hcitsE2WjMiaUzwP8eRRl6/FOi4MlJJH6oyW46fjVa2rc
    MzLoYKAl4lruhKBHE40hDU82MU3bMep2zjm7Vj3kUNzHpAYtMgDTD+Sa6rpg
X-ME-Proxy: <xmx:I7NJaj4VHbiwS-tmmVLCUtAQM8I9qPEcvJYsHoM-7bHOYmN1SQKaMQ>
    <xmx:I7NJaiX14It0ACSrYNy97Hk-kQ3ifC05FeONbjNu3CIj4M2t-SPCtA>
    <xmx:I7NJaqDsuQ1EaRPuSvl4YJWkVp12hnD5dqd08nDWEKqiu2g5sTRIYg>
    <xmx:I7NJap6TLE4ysz7s2_l0XtaIiogSjXWo5rwyyllRjj7jGWwDo0S3mg>
    <xmx:JLNJavXYzSl062zTjMc_3TZE7R9iprI1KxZPhInoF287ER6KJnpg-Olm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 4 Jul 2026 21:28:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 0/6] odb: refactor source-specific information in
 object info
In-Reply-To: <20260702-b4-pks-odb-drop-whence-v2-0-b0af7468ad95@pks.im>
	(Patrick Steinhardt's message of "Thu, 02 Jul 2026 14:01:58 +0200")
References: <20260624-b4-pks-odb-drop-whence-v1-0-8d1877b790ac@pks.im>
	<20260702-b4-pks-odb-drop-whence-v2-0-b0af7468ad95@pks.im>
Date: Sat, 04 Jul 2026 18:28:01 -0700
Message-ID: <xmqqy0fqdy3i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Changes in v2:
>   - Rename `struct object_info_source` to `odb_source_info` and the
>     `sourcep` pointer to `source_infop`. This follows a suggestion made
>     by Justin, as the current naming is too easy to confuse with the
>     actual source.
>   - Link to v1: https://patch.msgid.link/20260624-b4-pks-odb-drop-whence-v1-0-8d1877b790ac@pks.im

Thanks.  Queued.
