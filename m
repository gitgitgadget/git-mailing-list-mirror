Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F337630146C
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 13:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780407411; cv=none; b=pyeg6UopmPNyW66XivzjqxyivA+ORjAjBbTIeTSeSgAqq3GeuoPQq6z2PBCSRzhUjfEjQpGmhFm/k0C+/XZT0dS0/t2EHQNVQKIGrUSqF7SlXDpUXIj8dLB62pGQyAWIQ58S9YE5KDA/EpEcWnQ0HYIQM47iiCJM3aNck22GqtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780407411; c=relaxed/simple;
	bh=Jhgk0y5GywYZeUMdr2mKMuoJPgwC01cCUlUL+j1BKKg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bN9HtSP0hSIeKJEK8/4nTaDJmyyhQCcg94ZNAPcWLKOKNQ9VwL7kT3kHvJZRY1hSIjHmUXyX7NwYiOvwBOmxYY2aNwcA0cQG94eECfpRJ8eDTeHC0HgDudWLD3MRC/HrF8f3jnr2Dl7mZy4uJxBZ9oLEZAzWe1jLsiISEYcH440=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Pw9bAGzc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g4XNHdhz; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Pw9bAGzc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g4XNHdhz"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 03DB77A0100;
	Tue,  2 Jun 2026 09:36:48 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 02 Jun 2026 09:36:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780407408; x=1780493808; bh=Vt0NADytKg
	xa+k/Lz6Foo6D233bHWXXP69hcekxflW0=; b=Pw9bAGzc6TVGowLMLvadInQcKI
	Ykx+xHkwessRge2J/+bWPL4U0+vMtDaBh1w6W6ZaeTl2IlNhnEHZzl28ELj+LwYO
	Qt3dCyFTZj0xyH7S5McrVSRbU31I1gUieSzZVOjVLtE48+VYbH/SbB8s0C9XcpNt
	sEFxeJb+XzS5vbBIU830gaSok1/GBthiuxIbe43IYThSSKp06/WJRVIZxXSfWrxb
	7ysw2jdBL098+kg+0qrCkUWdiQTxOUQ8SPuVd3GSrm/aAkRPlPImFZAzoPVGVa5j
	8yMGbTJRoWMM0nsQL5yubeU0rQqCKBZdJnTCYLzRCfaJmb+NXwagF5bNLzew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780407408; x=1780493808; bh=Vt0NADytKgxa+k/Lz6Foo6D233bHWXXP69h
	cekxflW0=; b=g4XNHdhzfldVst3AfPjLNvD01ItKFWXk3CCuDFYi/oslVG9kT6h
	bygH8jyNRlPJlgkX1pxwPp6YvD2USR9pqt1/5JSo4HlYMxNtzmVrFtA8AwHor0Kz
	PBfKPgQDcaUko+2JKZ0+nXB32s/2dzWim+lBeexgjZgfUGZhzTQgvqYx+mXxFR1T
	wAkcF4G7mPPJVswusa81E5irkfNMLM9xWo+iGolWKBnWgVGo1zN/XCbOqSVzY+S1
	zT4K3tsv9piBm+xEsYRXaLHnECXkllQV3SdLo4D1Fh/6PB9+8ErrSo5zokuCnDVN
	lJ03KifbBeAfivBWsg+Dl1kX/lAUKkLEdLg==
X-ME-Sender: <xms:cNweasmuGXThedm_5B3VJJytUC4HKasVxkEkpUO5excdhBUe-o8DlQ>
    <xme:cNweajT5FaMAW5Stbwk4kqKXztPKkDYmP5e4IgpKiLV3DEtvEQZgtpVMln1K8oVb9
    uG51pkzaECm9awEfKN7bLyspT0y-QaeXAa-Xsi-AmQEVNjAgeqgLQ>
X-ME-Received: <xmr:cNweaoDbrTbxuwKf7XjGumlBlk9JwyVvyylKgaP47VDsgBzWzX7ivJwHVAlLRH7w9ZSkKzKCqNHlaSWQVIEN9HZfP8tO_5Dvr2Kr>
X-ME-Proxy-Cause: dmFkZTGH4aRFsH8WZkyTo9soUfM0j4oNy4QKJe5TP2hU5qTSl36xVyOqYndVej9n9i9CZx
    F5VzrZl50KusmCDW7CiDynQJpMEOutcOeb9um4vRu6eFHJXC/VlJ42aJlMcgJD9Sw4G40n
    09V8jAIvYu78TICAydxkJ7fXWQzcK1vpZZgP+K/HEVx1BZMLD+CAUm5YtN9yzzpTzRSgDl
    bO77cEigyP5yyo+qRcCZQaUvqstR5vd2P2gxMOjjBeHdCa6RwujTaYnVCw+ITuPYZMke7T
    +WenY4L2QALWzfR/s2JX5o4eaKIZmyf1tEzgeCfzNDa0h+STfGuiX/VXjAmbUkkjf9jrQF
    8ZpWSfvm/hUyfsDDFsCUzO4ipXaaOOlXeUoH6eR1fp1/kA8LJJqUFln+ZFACze/fnJk70z
    DyrLKeYvg6hAn+Uoh7e2AeMtGAKuN5HxG0ejO85K88IHEKhHk3QioZ5Ama5A3GUdKFE4dE
    AxIAH2nuSz45TXX5k9y7asHvHPEJcwtcWd5fdGG1qM9s5I14xuI9zdURSbPBkhWFA0exYV
    cB0STxTjJPQiq3uQTqLfNLKKNEZad2QuFj7C+S7K3sXC75eq5lgZ2ffXrxe+j8ES2g99m2
    R34eRnA/XyNa8ZHrQfIsMSJjjJHP2ZHEvBpgUkDSYDAmmPDRvqMavrP0Rw2g
X-ME-Proxy: <xmx:cNweaiT5Bb4XKraO87_5HSjmqR5oCLvAdX3OugzQBgEb9CI5mNaKBQ>
    <xmx:cNweaurn8pWpbRg6x1GasA0v8g8W5sQz2gpxsoMzxKsUA6VkG_Nctg>
    <xmx:cNweasx7EtdbYIn6MAUCXxHDLCY0WFJQTWpfp0dqZs8C2upvkmxI-g>
    <xmx:cNwearIH-6O1NRAEnQwwYH-YA-Oq9n1XkoITvc4QFIWB3mw9iX_sXg>
    <xmx:cNweajYR6kaUlyjoewdDCAQyU4bCnoTG7dLUsWApa_kQE5R46HBIl4Vj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 09:36:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] SubmittingPatches: describe cover letter
In-Reply-To: <ah7HZuy_WRCD9ZZ-@pks.im> (Patrick Steinhardt's message of "Tue,
	2 Jun 2026 14:07:02 +0200")
References: <20260602090808.87837-1-gitster@pobox.com>
	<20260602090808.87837-3-gitster@pobox.com> <ah7HZuy_WRCD9ZZ-@pks.im>
Date: Tue, 02 Jun 2026 22:36:47 +0900
Message-ID: <xmqqh5nlvzbk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Jun 02, 2026 at 06:08:08PM +0900, Junio C Hamano wrote:
>> We talk about how a commit log message should look like, but do not
>> give advice on writing the cover letter to sell a series to widest
>
> s/to widest/to the widest/?

Thanks.

>> +[[cover-letter]]
>> +=== Cover Letter
>> +
>> +The purpose of your cover letter is to sell your changes, explain what
>> +they are about, and get your target audience interested enough to read
>> +the patches.
>> +
>> +. Make sure your target audience can understand what the patches are
>> +  about and why they are needed without prior context.
>> +
>> +. For a second or subsequent iteration of the same topic, make sure
>> +  people who missed the earlier discussion can still understand what
>> +  the patches are about, so they can judge if the topic is worth their
>> +  time to read and comment on.
>> +
>> +. To help those who are familiar with earlier iterations, give a
>> +  summary of changes since the previous rounds.
>
> We might also recommend to include a range-diff in subsequent
> iterations. That being said though, I just sent a small series to the
> mailing list that recommends using b4, and there it get this for free.
> So no idea whether it's still worth it to then cover this here
> explicitly.

I think these are orthogonal.  What b4 helps you with is the shape
of the letter, how it looks like.  This update is about the contents
in the letter, what you convey to your readers.

Of course, "format-patch --cover-letter" also lets you do range-diff
or interdiff, so they come for free.  But the above description is
not tied to any particular tool to prepare your cover letter.

