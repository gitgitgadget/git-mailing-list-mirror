Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27F5397352
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 18:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788202606; cv=none; b=LYJuwmqPAJdjJDc0d12YLQaWC7B9mUEV+111lcWgmGCwBMOGzRNhHfOzxRExOl/j6Sw3gTlRdRVFB7wbEZxYG561sNsza1l4jXt3V8DbFvr6ruHAlQzhaFnGZaBiUXfKFAdp/voMSGc+lG+pcxHdzhR3WCN9tR3NmTb6ohoQ88Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788202606; c=relaxed/simple;
	bh=PyDkfMVocexJfgLvX46MHEw8Yr2Hekezg0G+gh0ZxL0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VWcJbzLBxHHNc4b/5Mcqwwvaq0mOPsoyPhpsZbukJhBK2Ar9DwHIhXMDHj2pojiVCZby99nwwN+18S5DaJZGHj1OOhUNn0kmVpe80GK8O4gJMYIQrIotMH/sjZ5ME8Cw8xyqKCVMhJfh7wDQFRJ7o88NEsSgsxQXlOYVeMBiO1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GdBhNlIx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PG/LpUtM; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GdBhNlIx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PG/LpUtM"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 58ACD7A01AA;
	Mon, 31 Aug 2026 14:56:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 31 Aug 2026 14:56:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1788202603; x=1788289003; bh=HBEshXg89C
	auA1RCQFxYk7drMJPAUDiiUBvBb7Udm8E=; b=GdBhNlIxU+Eo7Begh4WlEThlRe
	MaUfJlq2G4oqsYS11EMeNre2t3ipRAA4kz1E/jb+arWbWuUin30uQdE0RPhp2tzJ
	naj1barR11jvo2ZF12FCyf1+E4O1Q4w5ruMWKlRMOH+qXwump+xOnmQ8mluKaLwm
	M1nGjzMhyL7S1M23KbtVTitkoOauzAIVlZeaih5p8XbtMmw2QfQiGd6KtiGxV46j
	R5TSmw+7Id9XxWzaeZrd0mPlWw2/owTK3PSyAh5oF5OOujdoYxwzriO0doEglzLK
	+k27PihTzs5edqK9hf2568p4O2zgvXFa7gZq2nzHJTb+GtrL3JpgZ9Tde9ZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788202603; x=1788289003; bh=HBEshXg89CauA1RCQFxYk7drMJPAUDiiUBv
	Bb7Udm8E=; b=PG/LpUtMsxapaVj8spedsMEn4Do12rtAXVIsE8x/RTXM6gR5soL
	g4RsAs/uOy0xW3PMmSZpa2osvsrq6VfF8M2v/5oY5m49ad8e6XdirlV4pvyKEe8g
	5SwEN5K69cEOB+bYo9VVLf9SRzR9T+I277opJs7CFiYEg+v9e8UOfkg3BEKZIe7M
	YW05i96Va9FFJsmMohO9HX0UNvzY0KS4bT4bp7KUoCg8dReACtiKjjAo5jNOFaxo
	Leszt1uDQZxoOoij5nroAITvY5su9bFIseA8lzcQSWmHJrdcSBhEelbVeWR3NC6d
	BtjDiWCMsJF2zodWyq3M7Fe2XZJ9LbxEw1w==
X-ME-Sender: <xms:a86VamVSrG9fwMzP72EooHYS3FIhZtnupODUpF8RGQzSfWl4dqAE_Q>
    <xme:a86VaqDKU5v6PxsMXQ5MBm8yvyA9N1r0R_0Cy1SiT5FfTGK-tn_rwdxgvHx4x5VmS
    jdsj-MQpBosKd6rg25yJyEeBw9EGbN9iuB6_32pOiC2Yrf-pzjkwRA>
X-ME-Received: <xmr:a86VanwOtyp0lSPCr07mljQeuoMIlv-_XnaPT1XdJDNlUbR9dugeZwWij9duwW86GVODzofnD0tE9qF_aXKc7WvEC6RxyZoWCg>
X-ME-Proxy-Cause: dmFkZTGU75+kVLYNZk2piXWQue4igNIC0R3gkxxKo/8pos9r+KQ/reWfV4Bi6WmSx4r0Pc
    mN4HJGLJAYqwZLNWBK5Gawf/LWEkrQSQoK/xHdY/5r0sYBqzX+orAopO0M9cn/OxGAuNlu
    wfgl0ThIB8pOnP7EHGhktTZrheElo2KtOJnD6W+c6I36s/6kpu244oPTYm5eKlp7mmy3FW
    stlg6XKLyU1WMVAE5sA9kcsCqpg3+fgk8o62JbcJXZwyvSfF9SROlOQTqzfYidJeIYulI9
    UxaB7tZFeuki/uOkl+Wb3h0VYxzEQdeJDUoNoi51dxeny5GSeLRruduQDS51ujLs4+dXUr
    rcoxgleuZRbUvU/ik1jHQwFcPiXfrMu/FjsAP8lPTCsHTTKvKaULI1jvEcQSM/qcD1dVgo
    ZxPG5H/yFyvX6+BB7X5dU/ipQ9dgGGh0jxV1Tx6G2HXIhanXqtDRhhM9iMLB++mkmoXWjU
    P8oBw2AAw9pn2/vLpU5Fq+rxAx96xm0IEC89fEGjbvJ68nsyb+S68Yar2UopalNMy/C2CJ
    KXNbOEHfZq4bJlJGYCJswEj2pfPMgnYoJidqcEcZHbis1DyuaQrLv9N4Gpv13LxETZyhJd
    sb4jr09zUEaXiXOvKfk34vbLRJGDUpTTEnR2K0lUnF7gKcnmbZgEtxv0zE6w
X-ME-Proxy: <xmx:a86VanAWD3IiFplG2zbIZVRlplNLy2RXcM9u-hm7xJkpo73AZ-NaQA>
    <xmx:a86VakapNlikjJArrbKVOoMAGJZmB2fHVnPAaf7q2aHKBYYlIcoSQA>
    <xmx:a86Vavh3dHYMVizYNQhmdHmiWhP9TJV60dxcyac7iKmQSFQmbsuwjA>
    <xmx:a86Vam7u0imxoj2rVsSRYSXkNKojMvnjrR02EHaBDMq5XtV4fAhP1w>
    <xmx:a86Vanr-ab3shFVfH5xOyiBj_LJUp2tlX2e-eHyyILGof04UefkHlIcO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 14:56:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/4] worktree add: let worktree_basename() return string
 copy
In-Reply-To: <xmqqjypdj6g4.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	26 Aug 2026 07:35:07 -0700")
References: <20260825180350.2099-1-l.s.r@web.de>
	<20260825180350.2099-5-l.s.r@web.de> <xmqqld9uklud.fsf@gitster.g>
	<18e65a59-2d33-4f47-a5eb-ca5971cec482@web.de>
	<xmqqjypdj6g4.fsf@gitster.g>
Date: Mon, 31 Aug 2026 11:56:41 -0700
Message-ID: <xmqqfqzuw23a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

>>> So going back to the confusing part of the log message,
>>> 
>>>     Remind ... to worktree_basename_dup().  Among the three callers
>>>     of worktree_basename(), two immediately make copies of the
>>>     returned string before using and freeing it, which makes for an
>>>     easy conversion.  Convert the other one from resetting ...
>>> 
>>> or something like that, perhaps?
>>
>> Yes.
>
> Thanks.  We do not know if other parts of the series gets more
> serious reviews that necessitates an updated version, so in the
> meantime I'll reword what I have locally.

And nothing happened since then.  As the topic was in a good shape
except for the confusing part of the log, which we amended in my
tree already, let's mark the topic for 'next'.
