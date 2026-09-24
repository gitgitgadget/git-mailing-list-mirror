Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3245946AED1
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 17:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271829; cv=none; b=TNxeMUZxfNonhmKAUG/nIaRhl1kQKGaFXuo8kgFfUeJYpnG8SHJEbsn0GByovHaSRVqSsvDqIKOmTUqE/VTvDdnc8iOVvtkbROxJiNQPhYkGGkSo+pZxtg64bFLslOdZWgaKBZdwSCjjFovNrVUaqZk7nUqieWmtLSmR+hIHItI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271829; c=relaxed/simple;
	bh=BLfsfz5w+U+rnczNBdX7F+ArNJYIJg0pgH890cX9x34=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z9OIAinbRyIgbOxuaLwz+xC7jXIXMvBXiCZ3JGk/J4lM4Qzes6nfuV+BTY1HN2w2UR2xA09knYAsbXcM3H0fqi1aSxVxUfPonbzoWGVekJDwb08Z1PD7iLKK1vdgW512rOSjHLnmi+9P8L3oiALs4WLLIudqwc9lzFArb9y0HO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=tNJGceU0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dneJIjy5; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="tNJGceU0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dneJIjy5"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4301D14000DD;
	Thu, 24 Sep 2026 13:43:47 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 24 Sep 2026 13:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790271827; x=1790358227; bh=RLAfleNMmU
	M2+aIDdDw+kpHjv6H3h7yNuPYeY0ZV684=; b=tNJGceU0uHzNsQFU0vgUcXLIAd
	5TIjQ7mGU97TfUXiDaMjb4/X9zU5Lz91GXHBMQHYPiwrn9AjR9aH6jfUCFBxhr3u
	vNMxEvfhWVblb01zK+MdxenrOUrJhD4GKmmbL5VdPyl1mL7T9X0lpXSTEdp6OY0J
	nQLX2onEVRCvVJtLHX2KisgxmAcBO2pJZNBL0t6la3OjRzd/8WwZnEkwN4V2UHZr
	Iq/P8jsb5Lfhswlq9dqb0oxnuRi2KdbZEJ/QSXfaYkrrA2vOBah1LDJVVPatitfr
	qESGhgdmYA+Iq1V+1chZEjUB8KCllVo4YDH1L6syWsfh437OGqgok56itA3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790271827; x=1790358227; bh=RLAfleNMmUM2+aIDdDw+kpHjv6H3h7yNuPY
	eY0ZV684=; b=dneJIjy5lk8ppIBqp2a31TlX4n/dCqLFQkwQ5QsAGGL2JyA6V7V
	P/CO7IZ/PVw1NitCoBMRAIBj8wEDrD1OunFq925r/I9KDKmldn2s3TrDXVHpOP2j
	pKso701N/UxhId7zsC0LumufEYgUB2AZ2bZ6aHoEa1MhBalzY9s7E4ERhqbnMIHf
	TYCAKhl51vUNSUyI2lV/ZQBfNst97qX1PG8SsmyJATi2XLaqnBBXcC0UgLYBVu0j
	b3DTn7O+pIM/eu34HnvNxa3T2xaFAqZAZdFOntQhq/kU8zBB/7mJyFe/8t4vk08v
	0imguRqNopnkjtWJwpCwHwr4EtD4zQUH//g==
X-ME-Sender: <xms:UmG1aiIMUWIWrRFbHiDBG8HvNqCkeQphq6am-MVIinxVqTy8JAnkYw>
    <xme:UmG1at33MVDxZ87F2lzHHuEtDHtZQUw5Qvm__w79VvfhVXJjOghKjr4s51oKXv7ul
    u4TDorgIW0ch2ApKJjc20_8BkIEkuud4XOEHJZqbzIAYQ0D8ek0lKM>
X-ME-Received: <xmr:UmG1ashxdniroao5EoL48YR2zHwCb7RCtleGqQVUsb_zTVfthBnopaSNRYkBjmf-mpZvnZtzYh3PeOCcgIvToBq06rKSgD745Ucq>
X-ME-Proxy-Cause: dmFkZTGqzIiYjBAz4AUggdCrWQERdsVrxjbQnsOn8YdJE5h7B7omooiXpR/53ivPWIVfLb
    /SgydiVmfLCsEL4UIZFRNpG+eNK2neK05bikaRQ6kOGu2plQIE+Z/Y8EXSR1hi4MyJlH5g
    qN0fFNuhn+joKwuL4C1nEm9sCprvnqZ8zfgGcGGfLvUjQTFyN5bJCjQG8FEoGRRGB9zQVD
    tW0xKz1xxkJDWc5oSRhmaMnsP1ChZXOCVdhbW6aiZLeOIPvqnHJ++QML3sDLD1nHXcV7zt
    iMF6BC+5sSXiKhzO8btZbG8Pe3bQbuuhcf+/OLGYK8wvSsGyjNvPBnFAflEMBPOrW30DEU
    6tmZqJq2QO5ZGV+pWAcreLFCvpI8NKBbYv7c6l61pdwjMQV+i68rnwaSAZO14btdo5aGr0
    UGxZJhkdSsxzFPRZASdfyF2DUcxz3+JtaQRzNHEZY3XwHjBu1GZy+vrnYFHJDTOfY7TDvV
    acHOziPKNq2emr6sb8c9SqfXDHi/d4C1qD++F7IoVjv+WTWNlz3xtx+NNNFoSuHNFyPjzF
    m57AJlgq3HX1o3OeIH4/rbdxlLctQlI+XpfITx0KEMBfYetjLV4hfJ8nXGjhuibjNkVcoZ
    Yj/kCUwSlPnU1p6R9UCnMgmQJLvxkQfwK1mZ5AkZGB7sgqmng/iXFXObcR9w
X-ME-Proxy: <xmx:UmG1auWR9exotdE-boxcUrX5pxUr_Jv6rr_iLzOE5FJVfF-0yjW0MQ>
    <xmx:UmG1arWrNAG_25fC9ldmtP4htMxaZblWkZ5u3hBnZJtWmfhV6vLeLA>
    <xmx:UmG1aujYvaW55E0SapaqU9Whm_zMwN3AmkQOriQ6UD-bxYURiFW2WQ>
    <xmx:UmG1amZBnlZSYrQ80HaEDZ-gb6-TyrRBZ5qgvLzwzjgK6ceIUmIZ3w>
    <xmx:U2G1apHMYzfuUB-IL64IpapZG6fv1DXB3vTVjBMtDdMInwnCxAWfvJ11>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 13:43:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Pushkar Singh <pushkarkumarsingh1970@gmail.com>,  git@vger.kernel.org,
  peff@peff.net,  r.norouzi@proton.me
Subject: Re: [PATCH v2] reflog: fix default expiry periods
In-Reply-To: <arUvtE67n5_MFM4C@pks.im> (Patrick Steinhardt's message of "Thu,
	24 Sep 2026 16:12:04 +0200")
References: <20260922165433.591551-2-pushkarkumarsingh1970@gmail.com>
	<20260923102140.25475-2-pushkarkumarsingh1970@gmail.com>
	<xmqqpky3ahvo.fsf@gitster.g> <arUvtE67n5_MFM4C@pks.im>
Date: Thu, 24 Sep 2026 10:43:45 -0700
Message-ID: <xmqqik3u35pq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Sep 23, 2026 at 12:26:51PM -0700, Junio C Hamano wrote:
>> Pushkar Singh <pushkarkumarsingh1970@gmail.com> writes:
>> 
>> > The default reflog expiry periods were swapped when they were moved to
>> > REFLOG_EXPIRE_OPTIONS_INIT() by 85658275702b (builtin/reflog: stop storing
>> > default reflog expiry dates globally).
>> >
>> > This caused reachable entries to expire after 30 days instead of 90 days,
>> > and unreachable entries after 90 days instead of 30 days.
>> >
>> > Reported-by: r.norouzi <r.norouzi@proton.me>
>> > Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
>> > ---
>> 
>> The above reads very well.
>> 
>> >  #define REFLOG_EXPIRE_OPTIONS_INIT(now) { \
>> > -	.default_expire_total = now - 30 * 24 * 3600, \
>> > -	.default_expire_unreachable = now - 90 * 24 * 3600, \
>> > +	.default_expire_total = now - 90 * 24 * 3600, \
>> > +	.default_expire_unreachable = now - 30 * 24 * 3600, \
>> >  }
>> 
>> and the fix is very straight-forward.
>
> Is this something that we want to fast-track for Git 2.56?

Probably.  The accompanied tests in the patch was not as nice as
what is quoted above, if I recall correctly, though.
