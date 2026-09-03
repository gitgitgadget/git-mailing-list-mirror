Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C5F511E66
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 20:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788466281; cv=none; b=npXxJDoGSFI1wN0U1BJP38AfLZ57sZqdAL+85bhg6V4fxZLQ1b4ET0lMAqAq7aUofvPI9M1/j1qGm86j76URwkhqQChHdXSbEsbKGWxUEo6AcCdNEFiTn7+jFBot8M2OFONIR2JDcLSqBz2A5fm2jLIR8yfVJWCRzHDMwHAX9qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788466281; c=relaxed/simple;
	bh=XaIq5W99Hn/3lUZn1twyJU4qOg4iRNlM2aQYMd5oKB0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r6qwTOa4HMML4kQywEl8C3u5UJLkEyPo1lrs2ZEFysxP0yMibZvprwj4oenOTamD0g4NM9pLwN3nAG3iCM1b2CK+Li+V+71VSYmaA/ZIU+QGl2H5s5rIu9wzFq56k43PYa0p66BcwNQQNWTpwoxNQ/GqKIZgL2i4+jLR00tp0zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=e5DdodAs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cgOHU/Yx; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="e5DdodAs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cgOHU/Yx"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C3A7B7A01A9;
	Thu,  3 Sep 2026 16:11:07 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 03 Sep 2026 16:11:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788466267;
	 x=1788552667; bh=95jc36vH0TWc+UOMRgliAoQf5jm+u3lO/4Wj6ncVUmc=; b=
	e5DdodAsCQsAH5yZ/12q75HxaPLQdgKMti3tE8mqpe4ZsW00H0XQX5t9emQSPRAk
	GnrFD/sldlvL52YrHbfirrMOuh6hTIupoKNPmGnThUWreN7sgt/z1WdzSZVWhgZW
	GVgmD8nrhNI854KKpqm0SVAcvNiuCh9wSzJzgqs11IUx0k6e8San1GGP+2xGqe1W
	XdzUfdWxCvnSCMy1IguOScMYZ5LOLdVfLuf5/pvb5cd/jSTJxyFxLs/iw5MJ8eWh
	4dCdmtUa213/HC9h9JGBZYCvU41SYLD6auzp/QXLsb7iY0RgXdjD8igTKCLFKbIW
	C1zae6/AL12VF+dDJNPvQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788466267; x=
	1788552667; bh=95jc36vH0TWc+UOMRgliAoQf5jm+u3lO/4Wj6ncVUmc=; b=c
	gOHU/YxTaVOoL2uG/G3a9I5VST3nE2VOs/EyguHV/8IEMpr3CiHIZV+DkohOyNTh
	Q4KinGs8m3k8r09Ei33NAsvRqhdLR1zwtaouG41h2LLktXs6vW2lVya+bpyYrghD
	DUvtOjJM7HO9U9eVG2cx+XJxPVQAxol3efMRAPtkgrlAjOH8DfGsWgQrVm9MQwsO
	iq5p3fT22fIDrv86EeVKFcdMibGR6NaDUP/Y0IQpgjvC7vTgt/C7KnnIfG6qC1G8
	70+SiKj86qPgZiIWjdUzRU/c+Du+ssXLRJo29qHRY8vnzyhb6U+bU+JbsTHcywKZ
	P8/jdttuOgVaTqZ76zsVA==
X-ME-Sender: <xms:W9SZavs9AreMa7ClXwihBnObTPS-CjesoZEfPQgmsgeLPripbiYvgg>
    <xme:W9SZan7d2W7wJqYcy12UH79TtegzESpTOhIoVM4b1xFa_VVAJU2HmZ67Ejs4uIMyQ
    FeKea92y3cHaSqASwOcw_fOnnEt6hhwbNQsfzuQgU0x-ZpybURrMDqi>
X-ME-Received: <xmr:W9SZagKLaJhPuswIl38c0NH47DO2RrQvHJIuWTRKBeTR8kV354JuYM7DNnzHA4cDQZ1Uc9MLmHh1EbCmg1V0ARV0ZY38psTeUw>
X-ME-Proxy-Cause: dmFkZTE1m2xnJVzexbAtfCgQTK3W1AUnlMrc4OqbhbbH416vwQm2VUebr8Bld4I205cnrX
    R7E+8kgUArJosZwpAtW7W8P9LdtYWnx5vri4Y3lF6URz7iAMjkE87oEIXdV6L/eA5OMwC+
    kIwzc+vcFP7f4P0FS3E5+wJrsF2xQiF52bBcqz6SS3/sk6AsQsvZPMTpnAB24Hv3YeYJSF
    isQFlcHCBZXTYSs+dtNsPz+/pkfwRSzKu3C7pjhWFMlHjfkj+K0ir/hT8tgQkRr5EgzTtC
    ybXnk+Jx3Um/Kl1wzeK9PxI6MPtX6L4fKTb9Hieb0SZupE9xDvj9rje9bk0REQKhVN84uF
    1vvDsXqP68WNZx0H/p+YoD5dhuM4c2gKkR5bw3Du1/PDlPRfDBgEMQqv94IDs4mi8wEo9K
    aZOBFDICDgCkDQdfJsmXuN1p+nsOURH2JoQlmjBO74e2TCsQ4NA79mjou/0Pdd65Lez/aM
    D7sx1mtg1QXu0Yh5kFCWnwzJVVkp6riXr4IEYWeq7zxSZvY9Oi8AbY3T/AH81/QEET4lMN
    lu4RHu6HTo7Y0OuaGRjhM8HUDXQCnd/ZISSdiP14HnTKRY9TRHha/T4OUIPsfeqRRi8Jng
    /p52HKCACaUQm+xNjDUfYaFFW7RbEpuAxb5PLdvfvYK1D/T2PlIQsH7A3ghg
X-ME-Proxy: <xmx:W9SZan5_CZzzOaAvFV6qIC_IF8tQJElKCXaVsKcyPyANJUxIUJZaTw>
    <xmx:W9SZajz4Hy_wp2zFlo-5Aloluvl6UPBvHJsm2GRMDoDkLVrbyre5Gg>
    <xmx:W9SZarYahLPgfX7EaXnLhel81wCzs4s0COCel8aBb7NQv7Peai7xmA>
    <xmx:W9SZalTt2QA3SevlPEukWIO-tB_FMMwdQlIh_bU6TQO8gpKObkiNqA>
    <xmx:W9SZaj4Rthg-GTMfsNR1VrSjC3UsZlf7dQJMGdeedmoxLpjrwCT2pszC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Sep 2026 16:11:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aleksei Sviridkin <f@lex.la>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] push: fix --force-if-includes when remote-tracking ref
 has no reflog
In-Reply-To: <20260903200015.36849-1-f@lex.la> (Aleksei Sviridkin's message of
	"Thu, 3 Sep 2026 23:00:15 +0300")
References: <20260903010547.85469-1-f@lex.la> <xmqq5x0mfgyh.fsf@gitster.g>
	<20260903200015.36849-1-f@lex.la>
Date: Thu, 03 Sep 2026 13:11:06 -0700
Message-ID: <xmqqo6ee9jtx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Aleksei Sviridkin <f@lex.la> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>> your sign-off must be the last line in the trailers.
>
> I took Assisted-by from the kernel, which asks for it. I could not find
> anything either way in git's guidelines, so I followed the kernel. I will
> put the sign-off last in v2, and drop Assisted-by if you would rather not
> have it.

I didn't mean to say that Assisted-by was useless.  What I meant was
that "LLM" on that trailer has no information contennts.  Which LLM?

We have the following in Documentation/SubmittingPatches by the way.

[[ai]]
=== Use of Artificial Intelligence (AI)

The Developer's Certificate of Origin requires contributors to certify
that they know the origin of their contributions to the project and
that they have the right to submit it under the project's license.
It's not yet clear that this can be legally satisfied when submitting
significant amount of content that has been generated by AI tools.

Another issue with AI generated content is that AIs still often
hallucinate or just produce bad code, commit messages, documentation
or output, even when you point out their mistakes.

To avoid these issues, we will reject anything that looks AI
generated, that sounds overly formal or bloated, that looks like AI
slop, that looks good on the surface but makes no sense, or that
senders don’t understand or cannot explain.

We strongly recommend using AI tools carefully and responsibly.

Contributors would often benefit more from AI by using it to guide and
help them step by step towards producing a solution by themselves
rather than by asking for a full solution that they would then mostly
copy-paste. They can also use AI to help with debugging, or with
checking for obvious mistakes, things that can be improved, things
that don’t match our style, guidelines or our feedback, before sending
it to us.


