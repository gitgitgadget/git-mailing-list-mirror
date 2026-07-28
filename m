Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9D043A7F1
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 18:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785263199; cv=none; b=urbqqVBIPXLgwFPEDc16KVE3AUqcXF6IDzwgxqo0eVhv8LTYHkA3g+gxlvx715VWDsRyeMctisHifAeLoVOu5Cub8er/N4Kb0tA4UlKZaO2bqkY2z+CAhsRH5Lu5+2bn9J8NehGm/g02kG0Hv1Lk4VRPIGHKXuTowybx1Cmy36U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785263199; c=relaxed/simple;
	bh=WEw7bzuDS6NIpL/exn1P2KGi5tu5AoRey399fnfv4Dk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FvkrpwoOOUKhjMjXWFF0nLztelQw+tw+v4rwxg8n9KJf0aNi5UlGhZf9pyMiIVYIazUkzS1FeyZEuhJgnXIeRERjP/ELm+W/f0VC3U5yDa5lGuWpp9Rr/xooYLi9gDB1zN+jvmiXFQlajSbO4/fYOG8VGx8m/Hh37lkAa7filSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fLah1RKV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nia5tqde; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fLah1RKV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nia5tqde"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C14B87A0468;
	Tue, 28 Jul 2026 14:26:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 28 Jul 2026 14:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785263196; x=1785349596; bh=WEw7bzuDS6
	NIpL/exn1P2KGi5tu5AoRey399fnfv4Dk=; b=fLah1RKVn1UGP8CDRjpKDBHpxf
	CbqtHh9AcU0okHsygxJK4in7wJPvQ7woU7ef7HJw714PgDezNY7V5T0rO1tyRiTM
	3apiW7xJZxJsaY5xYulsxymOD5av/GovUwtk9JNjHc3Q5L5zxZnSTJt8J+LoOHEy
	Md3NsICGrOHTiI7fEYARC6Rqelachs0XhHn0xcsh/f7E3kZNyl5ltl1KSt2c76Mf
	/XnrIY038WloX/AV9+Qczld+fGLt6BNlMp55tMQMCBS3Jmfv3gkgH1kCxx0y30N5
	AcRQjBujBguir0Vqc6d10meH5eBBhdDSAQn2sKJvfcTUs7due9qoXZdMSAMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785263196; x=1785349596; bh=WEw7bzuDS6NIpL/exn1P2KGi5tu5AoRey39
	9fnfv4Dk=; b=nia5tqdeXZAC2mCT+fOTqw6pKuGn/1BOiRmJDF+0CilgrQf8DeK
	ohw6eS1JgKwr5xpLky8d7dN82xeZyE03UP7lbnROS8+4mdSYjS7IR7hn2YOquv/r
	O75VMXAcxJg5VdPhfA+UwkGqZnNulQYAFaDAAnQTstpLRCnbYyWCZN2HHS0L7zHF
	EJ3uUZelmtfvOtQuutSavRwi5+iNclVEZgWNhJS/ui72G9WP8hB0f0L63IvYtaSz
	cm5Lv1QYyhSymhy/Js/BgShl6u2ELKtJ7PMrZaY9bKKnsPvPmbrqBLw1iiFkUTjQ
	eIcKIEN1AOHdh3TiJZFsLvCOvsTG4tBhlYg==
X-ME-Sender: <xms:XPRoakN4wpT2E8Dg0x3rI8zSXUs-hS23D27TQZScy0RIBSQtavJriQ>
    <xme:XPRoah1NyiFkKPmBPR2wM1wMwdIHgVgCoXoyPerKjrD33yrmpBrL1WqsxyJSs4Ypm
    1yfwbl-7ylriIrPRyLb4l0sBh5QDUNh-CEDbrU30hefKypGib6_>
X-ME-Received: <xmr:XPRoajl2OQSYBXmJWGJobWGMnKvdEsJeOy77O3MAi-aMqKsWUvsLn7_YeDE7eVS7ky2VHNzw2BYNIakW0EQ9qs14mlbUeyeTNQ>
X-ME-Proxy-Cause: dmFkZTFJqgEPnnW50lbhuqKFbWvJ5vx85z+wpBAHS/fplGhEuPjg1KaFU4P9qIwBRRWcNh
    s4iic8trMgj98G3cf/T2TvpdQr+IP5+bEjlVbR3dJClcMZoWIlalJa/QHqAGwl1Qt7MA0W
    RQwteHYLbX6cNa95HDl+h7jH/3fatpk0W5e9q1rwzaSK+nPvUUP6M7JtX0cqJJRx7Y7q+Y
    YMC5ae8i774MlST2eJXBFXT56rtPoSAUIVffgK7ipQdq16hzaZsUqnSLRYVIdk5CnI/4RN
    7NcT/X/1R2OFeXxzKYgu/9DD57kQez6uuadL0lftxO3RquHBqqvltig/7720KOK1BczsT+
    8zrgLzR3s4NHIzCxruppBvNZ2naZY6RWqPvFMntg/7U7sp5eTZnet2EXL8tNfCrIxTYw/W
    AQRBX6tnfBVmdc8d/+c/EYYNj/iuZfonHQ2LEon8CaqyBeL/wr0751AdylrKBTTCt+6QGs
    InN501opSylRY/d75Xx7WCOFBOCgPLP6uTxlb1o1ExH5lA41O3HPt8GonNpNcP3KAS1UTO
    lhD0fx7e892v1uMFvIwJrGVrXTiWX7tYIbPbsh+Qs1gjgFOrcIRSJRSPG+QiaHOcK0lU62
    McfgwGzHUYl2e4OnfOg6rRi5iB/6WHPqTFLC0myQKIDCMk6Z/4AZ40RnhDfw
X-ME-Proxy: <xmx:XPRoaoW221ytzvRljkPtzH0q-zEViMr3vIGOBHZwiy_fOFy4qrGWdA>
    <xmx:XPRoapvxOb0V8seS-vFFrYT1-R2qTxjyQaRArTfoxp79ptIuCcqX4Q>
    <xmx:XPRoarZ6ncmm_468pH7WKtp7E_x9yQPFANmw8unvWnEwEyg9PAebVQ>
    <xmx:XPRoaoULTp4f1_g6r5UoZkBXBRTyon7uexo_JYuKYcRtAZJAO2j-oQ>
    <xmx:XPRoaj_ySUqm2yFRhdQm1RL1Gc3uGMuudK5rSZzUCs-BU39Li5aJ_uQb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jul 2026 14:26:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v8 0/3] Teach git-replay(1) to linearize merge commits
In-Reply-To: <20260728-toon-git-replay-drop-merges-v8-0-ced11dffe749@iotcl.com>
	(Toon Claes's message of "Tue, 28 Jul 2026 17:45:50 +0200")
References: <20260707-toon-git-replay-drop-merges-v7-0-808ab9b4afa6@iotcl.com>
	<20260728-toon-git-replay-drop-merges-v8-0-ced11dffe749@iotcl.com>
Date: Tue, 28 Jul 2026 11:26:34 -0700
Message-ID: <xmqqy0evc6n9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> As an alternative to dscho's patch series to replay merges[1], add
> an option to git-replay(1) to linearize merges. This mimics what
> git-rebase(1) does with --no-rebase-merges (the default).
>
> The first two patches do some refactoring. The third patch implements
> the actual change. The original patch was kindly provided by Dscho,
> which I've tweaked to be upstreamed.
>
> The --linearize option is only added to git-replay(1) and not to
> git-history(1) because in my opinion it doesn't make much sense to do
> so, but I'm happy to hear if anyone disagrees.
>
> Dscho's series to replay merges[1] needs a bit of rework to fit on top
> of this, but I'm happy to help figuring that out. We've been discussing
> to either name the option --flatten or --linearize, but I've decided on
> "linearize" because the documentation of git-rebase(1) also mentions
> "linearize".
>
> [1]: <pull.2106.git.1778107405.gitgitgadget@gmail.com>
>
> ---
> Changes in v8:
> - Disallow multiple revision ranges with --linearize.
> - Disallow --contained with --linearize.
> - Link to v7: https://patch.msgid.link/20260707-toon-git-replay-drop-merges-v7-0-808ab9b4afa6@iotcl.com

The topic has been cooking in 'next' since Jul 9th, so I'll revert
the merge and queue this iteration instead, making sure I do not
accidentally merge it down to 'next' prematurely.

Thanks.
