Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A96B4E77FC
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 15:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790609540; cv=none; b=Of/BWgIzw/yE0GxHoqIlsGsnbf2ITCwN4uKTJjRg3y5Dhr8egbiRw11T3EnDKG/y3EvtLpd7WuvLf+OW95Lyxnc9pwrtasUWKgBD3QvCBoAoICGHArO5pC8bzPoSXqg6rQZdX3RBDiwqLiHY928ZjkKMZa8uAQ4o7mzPD5OhIWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790609540; c=relaxed/simple;
	bh=0fQAOCP0mygxfLJzhzpBAL/5zJlRqWidXHD1dpUcs+E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DYDWwmOsmrDpAmdkUXi/kMqOaB9+uJTsYO3UeK2fHCLcZJGTi520VCoyXQjKsTf1zXlZN2iKWH+jgcu9JANo02PW6+pWOLPCsKRQzzQSZrw4QD1uQpFB9k6tRQWN3zs9Hu9lBE08KLU4+D9igGiZaE1TpQeYdUmKYRiWE44V5TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ienTQzzg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V8pBDudd; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ienTQzzg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V8pBDudd"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 32582EC0169;
	Mon, 28 Sep 2026 11:32:18 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Mon, 28 Sep 2026 11:32:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790609538;
	 x=1790695938; bh=LzjmbmMxm4l4do3yddFngZXtRsabm8HsROA8QxOBuMk=; b=
	ienTQzzgFbT0MySVftQ/HExZL9ooDcExWF076K9onMar0s7fJyz0BFNwwcOkhjL0
	7fRTTpNwd0wYwHzUfqOlerH6YtYyfpQtCrsofx2Bpf5vNVEynl507noqNzG8KY5c
	O5hTJ21M3bzVJUGaGr0xYfdDVDerDY+DhjbW8BNX47SUyAecULoI7cdVUndt5b4i
	molqsuKGuaXQqEdbeIe5jMDVXK5lvRvC/gc24eMafBMi+JSCqLRsYa4aospF/s1/
	h9d+8UjOn8YhgcZ/fo+pSJDmDeiPU8hxtOhLS33sh2jf5r1snh8JuDzmgerAbv1s
	Sy11dxtOsOwj4iz41mhHLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790609538; x=
	1790695938; bh=LzjmbmMxm4l4do3yddFngZXtRsabm8HsROA8QxOBuMk=; b=V
	8pBDuddYWHEiQgs/1TqTHyF4v0QYf8wdI1gGCDugFWpO6YiSvyYWkEWU2RzOWEOl
	0hjH33LmxwXu/XPR6GMCOy2n5k4HOpns963b4mfgDydKgjndEG/h4xRtQSDSmemi
	utyrLEToYA8DHIygGGFHuNa2IQ64mm5ZQWW/SyVopRF6CBtfaMEsfvjbAxurRsMr
	0ZLmN30px+O40kUDK97bTRzr+wZ9nwErMpue/QtHf1qIYcxpwSVgFewER/x5UTDk
	WNXt+aMbj7rmsHCmwlvSSPUtHMdAaDQltekQlk09hKaiZ7wcdzO/p4bbLllVoF6t
	ZxxUS+y+e5RHODfkQVxBQ==
X-ME-Sender: <xms:gYi6at832FzVcN_pqyVZBdFn9rYJNftTPTRY6n4TQxF6ruJ0d9gnYw>
    <xme:gYi6av-pThA4OsZ1v5ngujR4IZ0zIoNbe81Zx7KBXhPNcyaYYdN7zqOuwyaI3rBBt
    6ZUv4FA3pHuYSPA6jhkRq1S-nKFCw3Jw3vlfzGy5olvqMzE95HjTZo>
X-ME-Received: <xmr:gYi6akW_m26VrsakI-DyybguQmQletOIMYFCNUF-OXUsZ3acfPcxaeOSBjISLTYSYarmZP50EqijTZK8Q1mZFFqJVSF0Gw4d-_90>
X-ME-Proxy-Cause: dmFkZTF+uTZo0LPnqrkiYa1k+jKFZB6utu11bENJiGWGvEi3jyQ8txkDDdrzNKgVZamdXr
    eX+GKFIumTsuSJY4DpOHeeUTRz+DsNTcR9Z1y7VT46VgZ6JCip3jtRybinHCu0HHF25PK4
    r+oBVyp3smih3cKwUpgwdya0DkvMmGfM2e3ISRAZLpG7Dliht/GUwhYjUG4z5zcwXBy2wb
    artZDgU6rAvuYqTtx8KoWMJn0Rj3WNZPTK4YUO9AxpbzDi+1zsw7IJ+mu03IUfTUjR3bZ9
    fgPTXo9ILy4qW5KiibfmdgLc0tyE/MY43tjOwajRA9wh2otXXLVq73ncoO3xU0iKYSQ0AJ
    Iu0S+GRcCzXRv9ijkTFtmCczYfgrPLOzBYpuz5HyKyCA55miR8YiGSyAt8YJe1p2obFJPO
    IRIIsdjA4eDYOZIOY1o/sVYKFRWttxarvcCHZXafcxorKmhm5T3CpwQKzV2O6w/rYWeQqu
    u5d+S2UkOZr7ZvCd2KFXweg3/4A0j/QwJprs7XWWFqJVVmHzVrTbFJuIc3qEsmNhjF6P1a
    5xxCgjT3gloKioh1EFzv1+RhiqT01C1USUNKQ5OBzCfkN6u8D94BVdCSriG62s8fdMfFTS
    NUTW+AwoCbL7uFR/FoYmXDFS12Hsl5ga/HgATlbVXL8/UKB6SFeDFyNu8gqw
X-ME-Proxy: <xmx:gYi6akdBqSZJtRGQYlSTm7M0QrKcPe82benGo_MXRiHgm08I2KovQQ>
    <xmx:gYi6alaw9RUUMMlLcbnVCoJzWoP-v-WUlY98z7TUkcys0S8VEIHWZQ>
    <xmx:gYi6aoPDgvbUSOsRs3XYGzUs0yOLKEX_mVg8ualP63QNNMzrlRbSCA>
    <xmx:gYi6ajUqahD4K1ctpFHZuA-0oZ3eWAc4a8aj1Hlfo593zwdhIS-TCw>
    <xmx:goi6asG4S8JABEyB99m5di340KMAiDbhSBG98u9jOwfL7AGPsHctMoT->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 11:32:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org,  Eli Barzilay <eli@barzilay.org>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>,  Elijah Newren <newren@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>,
  Victoria Dye <vdye@github.com>,  Adam Johnson <me@adamj.eu>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v3 5/5] builtin/stash: merge index in-core
In-Reply-To: <CALnO6CCL6-7Ze0az68NRs2PAr+VJJ=ihU0s+C+DK-bsMB+XGww@mail.gmail.com>
	(D. Ben Knoble's message of "Mon, 28 Sep 2026 08:03:12 -0400")
References: <cover.1790168285.git.ben.knoble@gmail.com>
	<cover.1790425008.git.ben.knoble@gmail.com>
	<fde7fb7988b695707c6f2776adc18eec7fe4696a.1790425008.git.ben.knoble@gmail.com>
	<xmqqmrt1pvd1.fsf@gitster.g>
	<CALnO6CCL6-7Ze0az68NRs2PAr+VJJ=ihU0s+C+DK-bsMB+XGww@mail.gmail.com>
Date: Mon, 28 Sep 2026 08:32:15 -0700
Message-ID: <xmqq7bk5o0hs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> On Mon, Sep 28, 2026 at 5:40 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
>>
>> > +                     merge_incore_nonrecursive(&o, merge_base, head, merge,
>> > +                                               &result);
>> > +
>> > +                     oidcpy(&index_tree, &result.tree->object.oid);
>>
>> This is risky, isn't it?
>>
>> If there were catastrophic failure (e.g., missing object that were
>> involved in the merge), merge_incore_nonrecursive() may stuff -1 to
>> result.clean and return without populating result.tree, and when
>> that happens, result.tree->object.oid would be dereferencing NULL.
>
> Indeed… unfortunate. Thanks for spotting.

I did

	$ git grep merge_incore_nonrecursive \*.c

and read all the current callers.

They all have code to specifically check for the (result.clean < 0)
condition and error out before touching any of the other members of
the result structure, so they seem to be safe.

