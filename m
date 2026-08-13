Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFC747F2FA
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 13:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786629157; cv=none; b=RZPpuSyScYED/5Wi4QCAqa8wBk23hF4OpdTNZGruaTZ2NFfhSz4V1R1+CUl0RWGaTl3rW3kGhYXC3zr67HaPi20W/c3Xu+8Us8rRfCbLQa/lCLd3ux1h7LV7bmd6Rger2ozTijX2G+P9J8R+MUSEB4ohRYn5MNlnRmaluf70M3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786629157; c=relaxed/simple;
	bh=6WTKosmwGUU9PrL+rPLee/+ff1u8X1kMzFffLlzCqoc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FvS9rs3D3GZE+Epw8j8d+pOlnaqnNF4lTahgn6Wq3DGpvAzpklpe9ojOzOs/KB7XohwMdRzii6kjZbQTSyk+yIP42GRejlZTmSbajJgcB/++qbMcbqdQBvZ0ZRN4MZGNRm0tlTSpxW7wLlX2UEmqjpiIio6eVyTScCm9ja6uuG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PgKpSkFl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dajyhd3u; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PgKpSkFl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dajyhd3u"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 27762EC0224;
	Thu, 13 Aug 2026 09:52:32 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Thu, 13 Aug 2026 09:52:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786629152; x=1786715552; bh=vNu1ZyfOW5
	n31/7I3nXfc05m9xArMDtAmZ8pFvNSwNs=; b=PgKpSkFlcJAOZqV4ZMpWtCnxeP
	hbc5mj9wkcUDYmtwyD6cRzHdvHYmmSYsthgXNzZLVwZcMDEDQJGE0lmxsCuWSJiE
	UgKkENs/7OgXyC9UrmGfWWt+N+LSXST5d37jORj8BZjqPKntuKPM9udlGDm2JyCn
	0HQs5PZTmJMqCW7xIM0a9D97o8PSvg8n1hG4qwyZgL2rH8igGHVfZHroI61jvTD6
	2FY67s5N9Mtu1KWWlRhnj7ch386FOQKOO89eL4yqnLMcYIdwW6J0vWcq32UAs+fi
	1cR/eTtmsMGH53Yd3MSYHNSo6xgVgROjkmNpijCM/l7I9i7vIq2mH64ni/jA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786629152; x=1786715552; bh=vNu1ZyfOW5n31/7I3nXfc05m9xArMDtAmZ8
	pFvNSwNs=; b=Dajyhd3uquqA4GJOH+GBySVR5Qs78DGYEUQhBnZ/XSLbYvbw3iw
	1UxXP/ZKRRQtO54XSUPDrK9FHHB0Z0drqT1RppU26Dr4D/n+182yk/gnwnW8NT1y
	Dtd7KUWfN3we25isI/Jsalir37mKzAtjpmdRsps1OP9tnEwyv8ugrMmutOKVq1Mq
	BAo6W/hAe+ldgEhFF8u+uLXiOxKhiLgBownTUIRpBDbLNkHqGwSKUSySr6eyYyj4
	U9HgU13imDHPRnmzY7RqlotX5s2I+pebtq9ETCAijMFOJIwsiBDliFphaIi9N/UO
	nq3hEcX9dSpkYXiAtcCohenylEa83Mpmj0w==
X-ME-Sender: <xms:IMx9asoL4ZwtvuadZWL0nkERgKfBZGQznLrvOneOmSsGANJ5vh4yFg>
    <xme:IMx9aphnziGI78JxjN0iXSeqYqcZhePqOBZoaKvJyFuzHcYGUhk_hfXxKXlXMPZ_D
    dg7WhsiklR7tBbqfOyyWB-f9OEIXxx7pV2mV26PADslv_Ja76r-LwE>
X-ME-Received: <xmr:IMx9apg-J8kcLTriuXI7OlIFlWsk-HkiNE51l9-sOhFK_q2Ajvq2wkq6IiOExr3EXf6kEeN6_yRw8rawVGOxHqzf92ruBrQJTw>
X-ME-Proxy-Cause: dmFkZTGCEIigQaZz80MC3chy6qJPpejJHiJwJXTCBETIutsJpqv7jDehuilupQKjFNpwEn
    p7T6vLumj0iJCVOqY2Jcnbb7u30n+usIUtLU9OwyA4GPlKsxlwGqbl/4mHL/r/n9Y9HtBJ
    nAEiaV0OSPJR6pjhYWeK27pLcEXie5pkjQxLmlhOzkneObqLIQCIsthrtuBb+6PfEXos85
    aqCSKOlsPivgQlH8BpR30Q2N7pgpgSAXTgcjLMkmr857rNr5kHBbEeXCUkfoTuDmkuQPwf
    Kt6ECxYvTSDP6FEEE7mbs8D+ixYigvvuXyzuBXAWOi1Ya1VY/YowOA6ghrnMLElNbO8uW6
    UH1kfYRVvmcdeh2yoO5dD8islqNSfL8xEA9RiU8rSsiWobCuzJfDzsQy98ifsnwhzXm8/v
    Nj8bDChP6b1y+CfEkl4ErzYbVcgkw0207tP8m9nxeon4EFur4IepcHZ0LgKTr/nzUodQtC
    PPjOpZY1cfsL1rXZ1rDwWHYKUhz7eJi4P0MCZOLJqDcgEAdAvSjTiTMSx0+S2gCtbwxzjS
    BaYmMqxSXiElSUblsFw7g6LTEZ8yN8WucAga+axXmOAceT5G1tEQh5ewJwd4NBqh2MEdUe
    /EDMBdeUaDfb4XT5il/gtl+Sh0XG51lLOfboXnc7hHq22ghq6TeERNM+PG8w
X-ME-Proxy: <xmx:IMx9avhgs_G4_3MLgVo2R-4sUuhwItzUZuHDqoIGNK0lyHRnM4hM3Q>
    <xmx:IMx9apLWNLzE4OvrDBozd5KcV_PqCO8s_89aoKqbMAH8icf1Ap8MBA>
    <xmx:IMx9auHh2gli7kMtzWmpNKvHwhs8LLzOwXiZMncKK_b2hVrk1NBeHw>
    <xmx:IMx9atSax4hDgXzuHnWqm4d2Do9Db9QOu8IN8DGdNOfi1zXmmzKCVA>
    <xmx:IMx9al7foAp31YmVY8jmrY7xWjBvciOraXej85OdEs-SSKLuV_buo9Z0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 09:52:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] packfile: fix perf regression with many packs
In-Reply-To: <an1zz02GNqDu-0Oz@pks.im> (Patrick Steinhardt's message of "Thu,
	13 Aug 2026 09:35:49 +0200")
References: <pull.2202.git.1786561870638.gitgitgadget@gmail.com>
	<an1zz02GNqDu-0Oz@pks.im>
Date: Thu, 13 Aug 2026 06:52:30 -0700
Message-ID: <xmqq33wiunz5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> -void packfile_list_append(struct packfile_list *list, struct packed_git *pack)
>> +void packfile_list_append(struct packfile_list *list, struct packed_git *pack,
>> +			  int is_new)
>>  {
>>  	struct packfile_list_entry *entry;
>>  
>> -	entry = packfile_list_remove_internal(list, pack);
>> +	entry = is_new ? NULL : packfile_list_remove_internal(list, pack);
>>  	if (!entry) {
>>  		entry = xmalloc(sizeof(*entry));
>>  		entry->pack = pack;
>
> I wonder whether we should slightly reformulate this and rename `is_new`
> to `accept_duplicates`. Because ultimately, that is what we're doing
> now: instead of ensuring that the packfile is unique in the list, we
> just don't care and just append the entry to the list.

I had the same thought.  The current callers might have been vetted
thoroughly, but the next caller might not be so careful, and for
that matter, the code paths to reach current caller may change in
the future to break the promise of ever throwing a new pack at
packfile_list.

Is it well understood what bad things it will lead to to have
duplicated entries on a packfile_list (other than it would make it
even less efficient to prove the non-existence of a pack on it, and
possibly a bit more efficient, depending on where duplicates are, to
prove the existence of a pack on it?)

