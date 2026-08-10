Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E629823AE87
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 23:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786403761; cv=none; b=d9aBh7V9dI/pRU1mabUN7Ye9BOlqKSmPoXS7ExM3sV/x5G/9oSR2K7DuGrzIDvYL2Jc9TVkSDiDK1ucPWOF4SFYVJbYi0S48zSc3VPW2bcIbLbsX4rH/xQoNQfRCFj+mJnAD1ZzpjolLSZ2ZtShcFEC5x1QtIDZo0qdTTY1PArg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786403761; c=relaxed/simple;
	bh=KINnzRE6LbCvPbTd4ePMgcLEziYe1MLzEKLJGzwXWc4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SXIdGloHRTVOebQpLYnwTJ/KjyMPuB68TDSbfU//hJCGitBinNS6OyDhzKlpV5B4A1G5INs1QNGufmEl9H8m3Sdy7cbor1GL199NtB52ZUwK1j5fLcy/wKSRU/A6Z9Qb37B7XJjr5uvMuI4ZapCBM5aLxCwW/IPmGeTEGOv7I5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IuL6YaKx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AYMYUIAy; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IuL6YaKx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AYMYUIAy"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0D642140013E;
	Mon, 10 Aug 2026 19:15:59 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 10 Aug 2026 19:15:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786403759; x=1786490159; bh=7cEhfGYt8V
	slX7iFWd70lrw0FNNt9yshhN3XcF7Mm8s=; b=IuL6YaKxwCF7HshknjUythNm2l
	yN1czKc+nxE+/xHt4sNv/PoWdIVfmV4NF5p2dq/zBrYp89w7OSBsQXQ0hoBuuc51
	5eQ8Qsn68HjKSXlMNQisurTvjm37XPErk76EvKK5fvdNCCPSzhKPyw8mApDqQZRA
	BEZU7YSFO7thFqh/2RKzLmsRGkLDwOfyIe5dBs1hgEXz5PSjs4CyPHarQpjJPkDy
	3sctzpBSMxYKN+xql26ct52wVBDCdgTmlZb/yKN5yIh0SW1qBimhOFWViSFiQQd2
	l0dCZC+/tsUzMMIkF/kuszCSNIZ41qlhE/3cTZUDCshviVVBfHA8jiLCpdoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786403759; x=1786490159; bh=7cEhfGYt8VslX7iFWd70lrw0FNNt9yshhN3
	XcF7Mm8s=; b=AYMYUIAy7ITqtHzE8ExW2axQlcT0Plky48uBX7nnTJdzJIy+3ni
	MieQ5FBnm5ul5dWegvR1PbKaVCghhp5Uaai1le6n+2gutYQGyOYB7T4BA5splXAH
	5gTaze0stCat6R0l6yVEgPSmeYU0FsgcVlL8qRVPU0ONjL861AxpJkwIt1vMD/bh
	Sfcl+8/3Usda7Ww7T5cXAJuzed4oTCQO5ujBJrmPo0naNDO2hA+dqgeHrnNbT7k5
	8wA9SGieX600QCPLGPH/cCy6rNaqi5LNtHHJxDr+rxJ7vBSvW+TjXgka8w9PCko0
	c3qE5OqsRl0cxsE7NFc4DyU89m6emhjnYXA==
X-ME-Sender: <xms:rlt6aqKMcqm10NpyICUjjlkQGReB8fjgfxLkg3bpbyN1MYja0SUE1Q>
    <xme:rlt6apBTpEz_JamOtoBV1T0Tp0umS4MEalwDstL0nz_oIuLdrJsScbQLOnLABShkZ
    -aEuITvoPV0pIEz7YeJZ_UFPRo_nViwAoTbg2bzGIoetPHAEbyjUKw>
X-ME-Received: <xmr:rlt6ajCH3dDNk1I_NdsDsWSI3CB7AK5sscuIcO49vY2M75FlwlPW8QNj5FMS5Ft6c_fBwktajMfMOG8Rry-9SNcjikt7SR4swQ>
X-ME-Proxy-Cause: dmFkZTEJ7jMbYF9eAcWFZ9QabU4AvGdZMB5K/pibEzuX06SO7t3M1lNH3fYFAfTk4jFSxI
    s1xOLTJubopP9SGouzrh4p5K9rCD8UMqIdkNrMStgun+V2ixHvz9aWVXQ2JS0LAKwdAU5e
    AHhr9p2qfKJN7KTBumMJzhQadLh81mlJF1bH05rVZLHZzwOUTI0zCv8ABaWDreBK5ZV+zp
    g2yH16XoQoExPbsakxbPEA6xhwgJozWhxYQ6lj04rAiKTaaOsMc+rVa4Ix30gF7DWC4h7Z
    bRYwYStylSZkQr6OOfFDLi7lrTxEPGjAVi+mgXtYv0e8/DT+LbhEKfhXVY8vidcq7fQ3Pd
    dOs9Rn9Nww8nICmmVWZh3pM7mFcFrFNo3GSjpJeh/3Hbo1Dhc8w+902hqh4+Cy2tGFj9B5
    eoq8Uip5Ad6FqQUGgyj0Oh97MfrotUrY+YL2MnmQnypt75VcD5a5DtEQIhEm8Q/01mBvdk
    8E6Jw4ugl1QzqR3fuTHnqIGKLJy/DpBWRMRDnpsZtAOGn9suL1dqRaS1UfZsmltoU/SuOr
    xgYkU90JKziElvfpION3zesgeQ/zyTsDRyPbZ+C7jOGQjoZAwidOEcf3KxGuoilJOcjjF8
    rf2j74n+W0w+EDnorlnRhjC8NSoJv8aoEnqsWXYXgE3E/ITEkS32SuqueWBw
X-ME-Proxy: <xmx:rlt6arDZqLtAoCosNroaMPEvltqL0wvofFJaf70nnkx1vsYZhwbCXw>
    <xmx:rlt6auqMzh2u2Kw3a_Hn55yAS25lS_XQnqQO0S8ItS0ExBv0XU_jnQ>
    <xmx:rlt6almVQBsAQRTQcV5pmaqFO8ysqcvdmFjlRwJhTAODVHLRdjFHAw>
    <xmx:rlt6auzU8tLhZK2TbWtxZR_Y2iN9-yOYVxGqeEgYgfl9ZxNaeUUDyw>
    <xmx:r1t6ahaMSM-EDGjL0jYa6eMqIVx2wRq8bnRk8LJEsMbBM1OtIOXKRW0N>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Aug 2026 19:15:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 00/12] Next size_t stop: pack-objects/delta
In-Reply-To: <anQmffJEhKxttUjO@pks.im> (Patrick Steinhardt's message of "Thu,
	6 Aug 2026 08:15:25 +0200")
References: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
	<pull.2175.v2.git.1785946479.gitgitgadget@gmail.com>
	<anQmffJEhKxttUjO@pks.im>
Date: Mon, 10 Aug 2026 16:15:56 -0700
Message-ID: <xmqqjypx5zyr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Aug 05, 2026 at 04:14:27PM +0000, Johannes Schindelin via GitGitGadget wrote:
>> Changes since v1:
>> 
>>  * The return value of sizeof_delta_index() is now included in the unsigned
>>    long -> size_t work.
>>  * To assign correct values to the now-widened max_delta_cache_size, a new
>>    pair of helpers are introduced and used: git_parse_size_t() and
>>    git_config_size_t()
>>  * There are now two references regarding the provenance of the
>>    deflateBound() formula in the corresponding commit message.
>
> This addresses all of the comments I had. Thanks!

OK.  Shall we then mark the topic for 'next'?

    ... goes and looks ...

Hmph, some leftover unsigned long assignments I noted in my [07/12]
review still disturbs me, though.
