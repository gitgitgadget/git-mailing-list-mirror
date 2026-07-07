Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CEE31A55E
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 22:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783464671; cv=none; b=Oyx+UVUVC0CeU3J1c7XAOKu9I+OWR6HBHrJPeDEP+/tsKByjOviIWnleSWg8++wmkLHSyJqaO9u0ZjiKmqCwOXjAlFWrC55yElFa7Q65akger+VmCmYvsH4LQicsYstAs/3VLgoVhBONSWWdVdK6YjIZKVkbu/UgRdk8WBbnfYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783464671; c=relaxed/simple;
	bh=1kA2d8LDzS2ycqov3VHYJALqDA45Xx3PU0gqbLspFr0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bP8mOGDQpzitxJFn2B4RgSqr4jU5KRxrn3kiDBzzyZjacFSGyPoR8gHdNwJMc6+oQ1sEiIOQ/UpWbYdnIcjIQfvh9ySuFlh0s5ToICl89XgfXz6nBv0r4peVPn/1i1XAxirCJ+iDXoJXItooBbVXOTEZk+IUznU1kp+yyf/rZGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=h4ppRC6U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rq4XGh5T; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="h4ppRC6U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rq4XGh5T"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CC6191400010;
	Tue,  7 Jul 2026 18:51:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 07 Jul 2026 18:51:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1783464668;
	 x=1783551068; bh=Enj9tKMLetxkBU2XIVh2bB/lRtCOfzYUf+fi1rp0lS0=; b=
	h4ppRC6UyUkh1iXzIBlKVEZtv4sn9Gidr88a55OVkxeTvCM+YN+v0oD8XrTfIYDP
	yzE/AT+67bNlo1rTAu+8T1A60X2nBASzLuogue4JZJCiRIhK/TsLkP/LM3ZD3Xxt
	rIu5pIqwACx0K4wXzU8zboMIuNoteYinJS4YWrVRDxxzxIqSKu8NBBqBg+9huew+
	6oXxiNNuXAxOan8DTvG6LGMOnDaWS2aOFhKz3NEuX8eW551JM9R2rlgr73NFOua0
	01Pg4tr0SiNzUvn7xzYPlMVQ2EFlaTsZ+gHn3Z1Q7IPFL/o7e/l5XTFHQ8OwyzDv
	1jID/JFPgDfSZoC6cQ7Y7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783464668; x=
	1783551068; bh=Enj9tKMLetxkBU2XIVh2bB/lRtCOfzYUf+fi1rp0lS0=; b=R
	q4XGh5TOmJH2agQD2AuVirjN7JO3YFcedXhkrA85DnUJFuKjO15+fXuJCkR3GiUN
	ZQwgHLl4xW30bSPMbnBuuVZv+pw7F7Rj8SjHmwVHFH75h6pdCHN9NEcz6O7FUGRO
	y5OO3iZiOkO2UzhrHpycXitSX8mvlqlg1Gu65PnDuPqfLlEn2ztnYQ+5cuT8Ke1I
	rtRbz2ew+gqg/Xf80Lkx4VxQYiVlnyM0afHtaGTaF5WSLtwR+YChuZTiAw9IHglY
	s4+Mg6si7QKHmwg/8zC/j6yBsjnIkArNosc9ZbXn1lCZajHfBKASURPNKcjXY+Sy
	CQ0gPMXTJIkxceXxi630Q==
X-ME-Sender: <xms:3IJNagMn8kavrJtyBHVzqEf_9GXJ7jcF42jG1eHEroxoPrwiQNOj5w>
    <xme:3IJNauZFvQYiPfYrzANwk6EtMGSv8Ug4B99rQCOfOuPUXXdHocNhGSNMMF483cNYB
    g5yUtu15V042WCQh2uA0byFQt-w25acmAme0WG3b_nS67b0VfQT0A>
X-ME-Received: <xmr:3IJNakpv6QPFKig3VNatIttjQPnJ8cvl5AUSPG_yftH8Q_PiIINg6kensN12_XOfZ6vwOW5aI0gc2IfybcaFo9pkV2gdAoU6Ud4xZ5I>
X-ME-Proxy-Cause: dmFkZTGU8mIFbn14fvZ/Ba0iBvC32v2q87+pNN3nJi3LRc8fp0cxM276ulM8vho+WqF2xw
    1LcbOruPdPvWnG+vad/55pTBas48mQQ2+hlDxgDDaQu+ZwOJzmnI+HFWt9je6+LtntbbNe
    8DedFz8Z6MMR3c5ON82E30Au54k4FRSMEqU8z5jF8UHyg1BNlHGYJD2Dxs5LZvYNERX/pm
    X7kRP7a5txu0tw9aHRf8CJyhgvADVb9i6JTjOTT9rXdGoHdreE0b+qFt0AZZbt4TYvBSZM
    g5QWcz1F3vuwrwpFtC7ohVCscK44uzKfZcWMe1/DN41Jz1dVRBV9dfaFGVlQym5OUJFNAN
    BkZAtvgUlsPeZM8ewJs2cKvY5z4vCR3Pl4Ka+iFgpSGi/WliUmwBqdGseKe8rPekrO+C2E
    jEckYvub+S95Ck2r+vFJmEWklcAEkZtEL0mVv5Cpy5CZ7io0kWIxmz1+gSZX3OGrjVV3Gp
    2E4KqZ7Ob2SuBhAT3nrTlUFFEvBuWK0VV/7Uf5A8r7S7bSCHKYzdPZlz0vOw9x57BJlecp
    EHRjiH+XJzhaE/VAN+CVbhgsNRNrT0slnmitw3Ja9Y9y6rlybgXQORo5KBSvVJR3WQmRK2
    TKkOp8hzCh79fV6U+F7Gpbl+chmAjC2Y+/wU3dJwLAGVFCv6ih6HJEqsc/OQ
X-ME-Proxy: <xmx:3IJNaiZiYxFen8WNekImeUi0BQYbcBpn6JG4x_qbDNtgkRlWMNkiZQ>
    <xmx:3IJNasRp6Ip8b6GGHEqMWenfGl271ge3beM7DhJwsuI4a1_ZRliFmA>
    <xmx:3IJNap6hPHcSY-xfsE6Jm0CIesayuayJzO5wQDZ3JCeJiESgRwnB6g>
    <xmx:3IJNahzOf62jCMW9UyZYyrZ_SNfbNZvHVpNuLoPfj5tCk6UxX0mwJA>
    <xmx:3IJNaqYLYa7rOyRkA0yxoypLm1Ijk9bPsXsYDlb15Wr1n-GAq6pb4LL1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 18:51:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Incremental 'git fetch' downloaded everything again
In-Reply-To: <ak1+dsNQIV8EeSIc@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1bor?=
 =?utf-8?Q?=22's?= message of "Wed,
	8 Jul 2026 00:32:22 +0200")
References: <ak1+dsNQIV8EeSIc@szeder.dev>
Date: Tue, 07 Jul 2026 15:51:07 -0700
Message-ID: <xmqqh5maza5g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

SZEDER Gábor <szeder.dev@gmail.com> writes:

> I usually try to fetch from https://github.com/git/git daily, and
> today morning something unusual happened:
>
>   $ git fetch
>   remote: Enumerating objects: 406099, done.
>   remote: Counting objects: 100% (1229/1229), done.
>   remote: Compressing objects: 100% (1044/1044), done.
>   remote: Total 406093 (delta 207), reused 1189 (delta 185), pack-reused 404864 (from 2)
>   Receiving objects: 100% (406093/406093), 292.22 MiB | 4.62 MiB/s, done.
>   Resolving deltas: 100% (308943/308943), done.
>   From https://github.com/git/git
>    + ffe2b816f5...106a830b98 jch        -> origin/jch  (forced update)
>      e9019fcafe..f85a7e6620  master     -> origin/master
>    + c42f45431d...00534a21ce next       -> origin/next  (forced update)
>    + f6884212b2...73452939f9 seen       -> origin/seen  (forced update)

The only difference I can think of is that 'next' has been rewound
recently, but because 'seen' and 'jch' are constantly reound, it
would be very strange that it made such a big difference.

So, sorry, no idea.  If I were bug-hunting this, I would first try
to eliminate whatever GitHub runs on their server end from the
picture.

> Note that it downloaded over 400k objects in an almost 300MB packfile.
>
> Looking at the objects that I already had and the objects in the newly
> downloaded packfile:
>
>   $ git rev-list --objects origin/master@{1} origin/next@{1} origin/jch@{1} origin/seen@{1} | cut -d' ' -f1 | sort >existing-objects
>   $ git verify-pack -v .git/objects/pack/pack-080fedc9c19f711dd1b22103b382ede8925b90a6.idx | sed -n -E -e 's/^([0-9a-f]{40}) .*/\1/p' | sort >received-objects
>   $ wc -l existing-objects received-objects 
>     406954 existing-objects
>     406093 received-objects
>     813047 total
>   $ git diff --no-index --stat existing-objects received-objects
>    existing-objects => received-objects | 3615 +++++++++++++---------------------
>    1 file changed, 1377 insertions(+), 2238 deletions(-)
>
> The vast majority of objects were already available locally.
>
> What's going on?!
>
> This might be a recurring issue: I remember a similar large download
> from 2 or 3 weeks ago, but back then I didn't have time to investigate
> or to report.
> I tried to reproduce this issue by attempting to recreate the state of
> my git repository from yesterday in a new repo, but no luck, 'git
> fetch' only downloads what's necessary.
>
> I use a Git version based on next, with a bunch of my own patches on
> top, but none of them has anything to do with object transfer and I've
> been using most of them for years.  I don't have any config set under
> 'fetch.*' or 'transfer.*'.
