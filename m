Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B505E3876B7
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 20:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775160557; cv=none; b=qJtVJMZVViDwQ+VyLlKcp0Qf5Tgy89ba+DRo61Fp1ueEo0q7V1zwSQ97XTtAq2eKVfkW8KEScnKtE6ORzBOoC1aRPW3dah5BOIkdTNScqwZhfFehkLFVZUVgVzJg3lPc58TdzwPwR54iKVlQUTzj4KxEbzS+x/VbRh8ISp1DxDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775160557; c=relaxed/simple;
	bh=KxnsZ1qI4B1kOlh8J3PfsQAiw2uYIpc5eBlHrOsgzVI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eidHRydgLyolS/Ut4+6Pw7wangg8RPvrIk2e7UkzGBtEEWpDAwysX0u0vm7/Rtmb6GqMAzMI001W/rKpJeWkKu895p0+1BVyeHZJM8QDa5d3lBmgG/NBsr0rB5rqcap0S9sxNiVlWdfgC5mtJNci0bt3yk6RmZ8mBJLgyHwpKwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gI8UgA8e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GD5ujBjI; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gI8UgA8e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GD5ujBjI"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EC24D140015A;
	Thu,  2 Apr 2026 16:09:14 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 02 Apr 2026 16:09:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775160554; x=1775246954; bh=JyrsQcWUki
	vfWaNUDKFzV5OgD+mr+6iXlt8MX8XOdoc=; b=gI8UgA8ewYOmj5XTy+4/rMuSU+
	jR5p7GGl4uUSMhp9A2IUTgJqk4VdMp/fS8FO80tnfh6uroDjmkAWp8CWK3d4WAq6
	bjvuyzuNpK0XJb3Q3gaL4t3UuX5DP5pRE2eXxv6ILb4Su5MAlwjyKUnqDwHVUcKf
	DWMq33DehX2dwzIP9vDiVXDtxBScJmQkehSaaXewP+twFwzIuua/0ZS+W1dpHgix
	EI4r1C2PTYABy637UmgSOQ83zlSykT/eqTr6VJxpGTqmW8A810iX5AvDrau7qpj4
	QdrgXKIfM4BeK6lO5HymMxo3ZEzS9yNiwVvDDdrXXZbG8YFmshq5tjxF14UA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775160554; x=1775246954; bh=JyrsQcWUkivfWaNUDKFzV5OgD+mr+6iXlt8
	MX8XOdoc=; b=GD5ujBjIKpKLo/OPY61krXcchYMCwFes8SLKd511QzZUOLwXngt
	6FRnO8t25W2AqWKg7kPHlsYIE/hqCZ6srZ0r0+cYYGjs6vf7nUJd5XQnEHjiNcpK
	I64pw61OnTzxBIgF1NZ465FCy6IQnr1RQQKle6wlD1SGtoWGEVRoScAONvWeEH0b
	RQn1i7cnTfDOuOp5jb4AW/6f6JQwdPT/RYBQJTjq9RJHeTC4uU3XrmJ9Dh6LII0r
	T3QzlK7j+uleUJQOtSxFzTVFv9SNoU1VcKvS7vDrY4N+lDEXf5drdRuIXJ0XwjaH
	ZKNnQWc9nfmHk0Qygzvlqql9dWaTl6dv9NA==
X-ME-Sender: <xms:6szOaXmRP5tU5rBvAHvzCCKBijju0At3JopVkx_t4Nsgrh7OCEryEg>
    <xme:6szOaSSeIfKD9vSs3Jshgo37UxE4mEqCousSEqYrTZ-G_e7MkMernLqPlPBYHAEAI
    cD0esT81C9xF0Id7wDdZgMY6GZxCe-NsAoPcyYk8zgNS-scSyicGQ>
X-ME-Received: <xmr:6szOabC1EoKDq9jw-G5cCFnafScgsXazvwwfOrS8VwPbXfgjcuy0JyLXyKweUYzHCY6w-PcoyQU_xWlX1Mr6pZW5KMkgwRmMlA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeileehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtre
    dtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgs
    ohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffue
    efjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprh
    gtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehvihhkihhnghht
    tgegsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:6szOaZT_PThKVvXwjQ3xUvQmrZUUJ17qJp68CGqC1Kd6ZqjiSIfj4g>
    <xmx:6szOaZpF1gRipBELGvHOir2otYiB_xHgdI4rlThTx_EZYoCB6IzUjg>
    <xmx:6szOabx_TVIXy2D-JB-eBylYc-JRK100w4eIlqNUPdswcgBEOHPXXQ>
    <xmx:6szOaeJU5eI5ErCBZV9wTEAwUetBnxN15HSO7lCKUn5wb3JtrDdGuA>
    <xmx:6szOaWTdkOaedGPIQxIw3LsFh6EmxCX-0VfuggzNqKTroHysWjKJbu3q>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Apr 2026 16:09:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Trieu Huynh <vikingtc4@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC PATCH v2] backfill: error out when HEAD cannot be parsed
In-Reply-To: <xmqqcy0hp25j.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	02 Apr 2026 12:56:08 -0700")
References: <20260402191359.11304-1-viking4@gmail.com>
	<xmqqcy0hp25j.fsf@gitster.g>
Date: Thu, 02 Apr 2026 13:09:13 -0700
Message-ID: <xmqq8qb5p1jq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Trieu Huynh <vikingtc4@gmail.com> writes:
>
>> From: Trieu Huynh <vikingtc4@gmail.com>
>>
>> handle_revision_arg() returns non-zero on failure, but do_backfill()
>> ignores the return value. On an empty repo with no commits, HEAD is
>> unborn and handle_revision_arg() fails, but backfill silently
>> continues with an empty revision walk and exists with a zero return
>> code.
>
> "exists" -> "exits", I think.
>
> But more importantly (with Devil's advocate hat on), what's the
> downside of the current behaviour?
>
> You tell the command to backfill, the machinery does not find
> anything necessary to fetch to backfill, and successfully, quickly,
> and quietly exits.  That sounds like a graceful exit to me.
>
> Is there anything wrong with that?
>
>> +test_expect_success 'backfill on empty repo fails gracefully' '
>> +	git init empty-repo &&
>> +	test_must_fail git -C empty-repo backfill 2>err &&
>> +	test_grep "unable to parse HEAD" err
>> +'

By the way, a more relevant thing to mention is that this change
will probably become totally unnecessary in the presence of the
ds/backfill-revs topic that is already in 'next'.

It does the usual "if you do not get revision range, fall back to
HEAD", so

    git backfill<RET>

in an empty repository gracefully does nothing, while giving
revision ranges explicitly, like,

    git backfill master..next
    git backfill HEAD

in such a repository will be greeted with a more explicit "bad
revision" error.

Another lesson to pay closer attention to what others are doing in
the same project.  This would have been easily discoverable if you
attempted trial merges to 'next' and to 'seen' after you tested your
change standalone (well, that is how I recalled the other topic
anyway).

Thanks.

