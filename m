Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779BF1C5D7D
	for <git@vger.kernel.org>; Wed,  9 Apr 2025 16:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744214483; cv=none; b=JsNeobCBvuIOeXxuWUym5mNytxcDCboqXS7kBmumTp0M6pZOaXbXuajFcoZ+H8gTKji8Wl3B1pSzgh4UOdfj4WEHhcgK+x9FJ6c+BGthyYWPoHQIYvWgg8BcAoWnohun47+1lvaxFBYrOsCAbTtgi0kTi/UkQGpDijkuPp7KVQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744214483; c=relaxed/simple;
	bh=JBMZkk1oKddZtiws0epjnw9fAUgv82Fe1dFLWG1z6zc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fmr5lMTOEWpPLNazzUIlJ9ivbGbLgrgmAW7TO0r3DeItZO1/BqpVHeNbwLjkpM2B7L3ThtxKN1BC/fePqS0964AdBbWh+iPRjBM5Q3GgdGZkY8hdiGguwIpKgGozCc1MtZSeh3GjMtdC8i/h3LMnAe8AxQEMZT+YlZswvq9SoC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Fiqq/smv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MoQ0fnrx; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Fiqq/smv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MoQ0fnrx"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 7899411400C8;
	Wed,  9 Apr 2025 12:01:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Wed, 09 Apr 2025 12:01:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1744214480;
	 x=1744300880; bh=ruJDZkzEi6MKbjrt8eN5Dexe6+0bvrIOlky85u6wIQ0=; b=
	Fiqq/smvdVSHvl10dP7lB1GuELtdDF5pfmqfkKdQt4wXf3Rdo02gd9us4qr+xUdn
	ZpRrkp1ziCiv6Yx0Wjb3XLkwAa2iDWwRPILzlTeJI7MkKBqSg2fbeceoUqpbw2MM
	PdBBVRllH4wWsDG8rdd/BG6IoXj15uSCabcnI274xMlnagxQeXpsdmrIs35Bb1P+
	EYhSBcn4N7lrZTk/mSSVFEIwhlRx3H+r9cBlMt7O1nMhSiiAD9k+4zCNXRhiT6cw
	Vr9qupClIhU5C9NGlPsGWntf8dgKnHvs9JDnqwhYh9DSmhYfwEyQn2hWaBy4c82I
	lnz7/kpVg9S497TDW8CAXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744214480; x=
	1744300880; bh=ruJDZkzEi6MKbjrt8eN5Dexe6+0bvrIOlky85u6wIQ0=; b=M
	oQ0fnrx899n2Ztqc2E4ecHFfvLSoKQZoBfltvXlbYwQVLrj+zn8UYCZPoERW3b0G
	PT+38i5kDUvKRTQDoDEf+JJGI03Krue+JgD07c7NATwNajEJ6p+zlbn+gfcFcdJF
	vYfeC6lTcPgH9WMjHpXw4FR8QdeGAzzrNVccC7cvtkxkDZDR54wKyL1lfO7qc2Q5
	9OJsR6WbyNJI3ez3X3kHeDVBKbWmQeEF0j61XOKhLRpLT/6LVVsbcyzuCQmRUWeP
	DtpfJxAdGE4bnAYhCndnqIXXuDpKH11WV9wIn8StUxvSsxVMgH886zCaUqcaAK0L
	XCrEv626rrpoJVWy7Z/sA==
X-ME-Sender: <xms:0Jn2Z-CBcsSNaVjZwutcU0FTIb_Gf1j_NL6GZmd7Ty2rs0oz9KdkhQ>
    <xme:0Jn2Z4io5seB0p9bqc0LDNqM84tFLs2Q4p5mmDdnKcYcKPlOb1FNRlSn3wndcPZat
    cxogXL7sORYIVJ58w>
X-ME-Received: <xmr:0Jn2ZxlKYJ0DLyeLH_Fi1q0RftqtlAqRGrRf11U4qygecIgRijOv7pWO3AU9looR3fVJDlvwQpOjoEuJuO8ovisd4AGwTGeaW06b>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdeigedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefg
    keefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlvghvrhgrih
    hphhhilhhiphhpvggslhgrihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:0Jn2Z8xugcYTagg3YE1d2G37kxkaV4LyXIn-ZLaSW51Fd4TMAh_pGw>
    <xmx:0Jn2ZzQ5-xb0LnpPrt5YO0DMwGNIIQICKn1ax327Q1gblkVVZ6SpMQ>
    <xmx:0Jn2Z3avMtOQx0gAPqdrspAQ2vyADF6mt0MLAhgDL5PAJN30QcbvDw>
    <xmx:0Jn2Z8RKnv0FhkHDyowFBM2PVW1H5Q1thPBMaxajGHKdOaWfkYMnTw>
    <xmx:0Jn2Z0MO35uiSmpiMB3e_p4UZtcU_AXJ1EqZeRlTP3zUEYScg7mB9foE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Apr 2025 12:01:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Philippe Blain <levraiphilippeblain@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2025, #01; Mon, 7)
In-Reply-To: <e9700234-324d-dc63-d91e-9b8f36fabc79@gmail.com> (Philippe
	Blain's message of "Wed, 9 Apr 2025 07:24:36 -0400")
References: <xmqqtt6znch3.fsf@gitster.g>
	<e9700234-324d-dc63-d91e-9b8f36fabc79@gmail.com>
Date: Wed, 09 Apr 2025 09:01:18 -0700
Message-ID: <xmqqjz7ts4s1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> Hi Junio,
>
> Le 2025-04-07 à 12:49, Junio C Hamano a écrit :
>
>> * pb/status-rebase-fixes (2025-03-28) 4 commits
>>  - wt-status: suggest 'git rebase --continue' to conclude 'merge' instruction
>>  - wt-status: also abbreviate 'merge' and 'fixup -C' lines during rebase
>>  - SQUASH??? - <CAPig+cS92W_gYuNsaTvQxiP3xBK7Wpg0__uVkgAU1x0OFJUZgQ@mail.gmail.com>
>>  - rebase -r: do create merge commit after empty resolution
>> 
>>  A few fixes around "git status" while "git rebase" is running.
>
> Note: the first commit is really a 'git rebase' fix, and does not concern
> 'git status' at all. I think this should be mentioned in the release notes,
> or if you prefer I could split it into a separate series.

Thanks.

    ... plus a corner case fix for "git rebase -r".

tucked at the end of the sentence would probably be good enough?

>>  Comments?  It probably deserves a clarifying reroll.
>>  cf. <c2f93d99-2f4d-ee6d-7087-42320c6df0f2@gmx.de>
>>  source: <pull.1897.git.1743181401.gitgitgadget@gmail.com>
>
> Yes, I will address the reviewer feedback and send a new version.

Thanks, again.

