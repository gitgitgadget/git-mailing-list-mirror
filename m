Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DDC368D65
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 15:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790694192; cv=none; b=K68Nuz1JhfOGT5oZ5jfzxUVSTtDNz2G0A8GY4UwNm4pTNI6EdaDD60qMG7clRlcdU1aF893rYRBmd1utuRwC/Df/lNokgRPzsQ2XgOQeBxgENEPuAnwRI7Dvv/RuA0wPmYX8pb1luHnuukJkroOy/bby27U8MPFMVEgWGxW3uL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790694192; c=relaxed/simple;
	bh=g57A/zLlbrorV7W2/IyE4PcLAdEmhenYBFL0WR0hD/I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lg0MwB/SP+YR/B4MMc+3xKpthfz5sKrcKzaarkpLcKfY73to0/cVkEPDJxSBcBLQRPws1toF1JgWDP/qKa7huOscGTWcxv18FABRhuzv2j/CL2yoJsX6pz3FpcJpcpBEVBISCWq1LFKZkobdvjNXmLduXW4yc0byMcdIA5L3Ekc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XRioxhXY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=msLJC2L6; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XRioxhXY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="msLJC2L6"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id D128C1D00093;
	Tue, 29 Sep 2026 11:02:54 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 29 Sep 2026 11:02:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790694174;
	 x=1790780574; bh=f8xC4s0nQmRN/4ysQ4CVQwpgmBE4Xh/X0vvfLMfVuxU=; b=
	XRioxhXYwPG98vUL3941XjQUaGOdQ7p2T/+UFyZhGRbsujpNAJ8TY4rL8cq59Uso
	9yh/BQFveCeZIIn7+K12QeY8I1B5zCuGK8OI5wncgiM6Fiqp0dF3GkQX0OtvZwik
	hdgGGfbQIS/gVZSAtblKMHJglpTEkHEVylwFP+ty0+8k7BGbAof0A5n7gTb4ME8H
	9rKfcaq9rrMja6bYejoFbOVDu0J1qx3Bs2aW/C4hc3Q8YDPXenfa11Z4t5uiCDW2
	5/qEXXYN6CvaYdhXotFZ/xL3gvO8+o4j4K0Juc9obrtO1RnuQihoRqWzBP4Yguxz
	p3f/ybgo414aPx8Al7Blqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790694174; x=
	1790780574; bh=f8xC4s0nQmRN/4ysQ4CVQwpgmBE4Xh/X0vvfLMfVuxU=; b=m
	sLJC2L6YipXEAVEnHATNcFZQ4PniMl+U/UDLZiEzywmhH/zC6vhCHKZma2hhIwz9
	Zl9RxSYgJmqXFVtuBdHj8lktruMdGNFXtCu5yfO9dnho/k4Jn92YNIjo2WlUGa9t
	t0ipZvRCLBorRlKcrJlmVIoOd11bidEBhmck2ILcrKduXgMncmgYAy5wfJ2kkV5U
	ung4CMuOO2zTep3gmQQMXT8ttEkCVNFxnuV+NSJ3X8sIHJ5l6RCIjzSDLfZS5oSv
	yTVUlixAnGjh9OKf53dfGaC6mwXD03GMS2ALvjP/MooZhi0z3Xq7xwU18hDzUz1W
	0hzYUfHQ//GCEf7hv3Nhg==
X-ME-Sender: <xms:HdO7akDA3mMzV1d5MkYjP-75QGyT8fKIV-N7Ew119KNauKWQVAaA3Q>
    <xme:HdO7anPJQPB73vPYm3OvEAf9XUDDm2WRpfD0VArnxwJvw2NTVxoOJfHn8pvEBHMcW
    E4z3ONVFG8a-E0bwASP_BSslWPL8KRKUYeypso3Tjtnn4nOUd0oX9Y>
X-ME-Received: <xmr:HdO7alzsSzhSViUTLfO-yGtnZUhPR46nBRlAEIL-poEv0aDXVJY9MsZO6MWU4hNAgtVfVLf4IN2B4Pcr5x8n_YcU8RZTVtvT_TCZ>
X-ME-Proxy-Cause: dmFkZTFAytltQ0YWlkbWQbtK41cgocU5oIJehtGosXW8LJryDMZ47HyR0fHlH6Z2nZ85hZ
    ZZ88a1Cg7yJiSo/7Ylm1JP9D4lBnCKE18f0WB1d2fStGyBd50Gk5BAZX+VNK8rEURBR/gL
    /LcoUHWyqeQaLI9PpW8MBlpT3VA6F5iCBSNXPNPemBHgTXAh9pHy7QQzYPLdAeXWAv0CQ5
    WNTUcjJUe1FGde6yhmzNPf/qxGxmBOT+wGOY2hKX6bG/q0i8wiX9wMm7EPvFGazpU5u8Xa
    ixBOGxwX6pRfQddMOi0O8ZMb66UhaNcL+5ojeDTuaCv0AakAN5mY+b/+i7DBUswA7RueT4
    z/jQHluzH4i6bS0YGWfbFEvfMEth2wO3CqXrU7HKvgaNVSdBN5qKY3sKmbr35W2e1A0del
    N1Bbzm/XA7VKueD/8waVm3OlceywTufJyMBATDO14hQNanLGGzE54/IeuBihDVa07AgImB
    +Lk+amYRBZEzv2rt8etBfVdsLmRovS7KRQXj7bOwi0YZ3bZozhNlgIbhfhFYkiucuaSH/1
    Oe9GkiD0+jUMQ3HbOeZJK1hDYCWVH/Fv7r7zFcERBPCrUTkjf9QdpqNDAQ4Y3jqBiegugf
    y5rQU6wr7KWk6smVbgb+xX8cgMMgASTZ9Eo/2oNCuQtsnR2PrbKvuP0lLWRw
X-ME-Proxy: <xmx:HdO7avWqyy1CdUiLPJn9gfLZqVOM6x1uWuzTEKghq8_7LvfKSsa_iw>
    <xmx:HtO7avNDBv_UPmVssqsCKEJ_UJFffQEl7iyT3_1vlXv24tq_W4y9yA>
    <xmx:HtO7apA7JCPhrrkTJlWIw2YvnxBj_MGDdPcZg9bATvj4uHJ6u6_c0A>
    <xmx:HtO7akd6PeDQo2Wfl1kukpgR7gJutYznDETFYVtWPr_qDAGwZvbacQ>
    <xmx:HtO7aoODQjdjZxx2F3VjnSI99GFWS5iZ8fs8ZF8hvOqGBq0PueaBDr_1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Sep 2026 11:02:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood@dunelm.org.uk>,  Thomas
 Bachem via GitGitGadget <gitgitgadget@gmail.com>,  Patrick Steinhardt
 <ps@pks.im>,  Thomas Bachem <mail@thomasbachem.com>
Subject: Re: [PATCH] t5520: don't expire reflogs where it matters
In-Reply-To: <89E3CD2E-8366-4C5A-B3A4-8F44AC5F89DF@gmail.com> (Ben Knoble's
	message of "Mon, 28 Sep 2026 16:45:19 -0400")
References: <pull.2243.git.1790606282769.gitgitgadget@gmail.com>
	<89E3CD2E-8366-4C5A-B3A4-8F44AC5F89DF@gmail.com>
Date: Tue, 29 Sep 2026 08:02:52 -0700
Message-ID: <xmqqzex0hzhf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Ben Knoble <ben.knoble@gmail.com> writes:

>>    t5520: don't expire reflogs where it matters
>> 
>>    The t5520 failure Junio saw in 'seen' with Ben Knoble's stash series,
>>    bisected by Ben to tb/rerere-lock-grace and taken apart in the thread:
>>    https://lore.kernel.org/git/a59c4225-f093-4001-b77a-2083dfecce6e@gmail.com/
>
> Junio, if it’s simpler for you this way: I’ll just pick this patch into my series rather than wait for it to appear in seen and recreate my topic on master + it.

Either would work for me, but I created a synthetic base that
includes this patch and queued your last iteration on top of it,
before merging the result to 'seen' .

When you reroll, I'd reuse this synthetic base 4d7270214a (Merge
branch 'tb/t5520-reflog-expire' into dk/stash-apply-index-incore,
2026-09-28)

Thanks.

>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2243%2Fthomasbachem%2Ft5520-reflog-expire-v1
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2243/thomasbachem/t5520-reflog-expire-v1
>> Pull-Request: https://github.com/gitgitgadget/git/pull/2243
>> 
>> t/t5520-pull.sh | 6 ++++++
>> 1 file changed, 6 insertions(+)
>> 
>> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
>> index 27f38ab3c8..bc818605a5 100755
>> --- a/t/t5520-pull.sh
>> +++ b/t/t5520-pull.sh
>> @@ -35,6 +35,12 @@ test_pull_autostash_fail () {
>> }
>> 
>> test_expect_success setup '
>> +    # Commit dates are hardcoded to 2005, and the reflog entries will have
>> +    # a matching timestamp. Maintenance may thus immediately expire
>> +    # reflogs if it was running.
>> +    git config set gc.reflogExpire never &&
>> +    git config set gc.reflogExpireUnreachable never &&
>> +
>>    echo file >file &&
>>    git add file &&
>>    git commit -a -m original
>> 
>> base-commit: 34f06850c16c7f7ac822b1adc71354f11b0f2ca3
>> --
>> gitgitgadget
