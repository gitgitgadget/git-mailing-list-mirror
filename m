Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAC23BED70
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 16:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781887254; cv=none; b=XdOAvenhg9z7j2AuEhutlKcK9/nMag5+8baNF9zuiM2XMO3q0ZX3WYnPomm2UUg7nSiLn9SjZafnQ5EYMKAalZ5GvaiZr8rfpiTK63bZYGwBexUMuW7sE9DX3EC9xTSxRGNQBBJl9U4g3JDeZLKyUcRaOkeqchRxZsu2XGPy+p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781887254; c=relaxed/simple;
	bh=/FvwtLdROvkWvMxtTiQtWQhOP3CI0aHe0D15aB+x/cs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ldTiL9hHppi/iHNw0C37BThSMOIjCuryMSZWxplscYJ8scjkYLpr46tPY0clHQILAeplyYzpDs3X4o8P6XzRoZODDWFe1FPYjFVq3BcRPdJjqj/rO6NlbfekCjKvEWJQH9Z9oMRNm8G8QCLSuwJGLJw69BRwmjeUZ3sPsqA1gb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=n8YTzISY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NGSOyvBm; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="n8YTzISY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NGSOyvBm"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 9C6021D0012D;
	Fri, 19 Jun 2026 12:40:52 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Fri, 19 Jun 2026 12:40:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781887252; x=1781973652; bh=nlo5AueJ9f
	c9kUcyeXazlqd/zngK2BJqw+IVlI+MTbA=; b=n8YTzISYXQPGDj51PnQ+uSzc64
	TsphxX4lhtH0dzW9ak87uOtTuPSGvRG+xNkyRu9dYUqmwnpgUBitWX6nqyXrITSR
	IbFFCcPLyoB7TBowfGmbOnylF9U9k3WbtKR/LHk1xYx2G75Ui81XK0b8NO9MGgtn
	ZfkGHe3yZEO897pwLUCVBatn5NfzXzX0XNvtUsNAebKlB09BxsfUqi+g1zdAtJXW
	t9+oXI6MEJfgdyKiJHxSUekPhS1QMo0dTd1Fmu56Cykc9LXMI9p8Bl6ONlVj8jeq
	nDDywGTb3GjLWKckBgyItXH3LK5JB0Khn5iaawX3cw8n7XisS/9unNFUOVNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781887252; x=1781973652; bh=nlo5AueJ9fc9kUcyeXazlqd/zngK2BJqw+I
	VlI+MTbA=; b=NGSOyvBmt+j2igEKnwATiyKtuUKg+mXh9XaFFLuFIkbxa7ucbD3
	6tVOi8u9Mm2UcpaH4QKfiVEbmT5sQbkF8tgvkM4RMIWqHHOg+HtFHAnfB/0leJxF
	t7Sse5xFlE5vSFALvHGYDxpHo9qA386rlmXFdsJWlwhvp3TIvHdt39ByBldjtlSD
	Ig/utzb/Yt0jnKY/vE+HT6c9ZIAzS8/a+4ruSi8E6Zefk+an54aicNnT3CtIWPnY
	WhkgYaT14qeW7xLVo2ld9THqDg/YJ0Qmn88RKOclpKddX0Y8gI/uUjfBvDum8Loq
	5OadJjOZI4d1XJ/p6iZ153IUysk9D+cz0Bg==
X-ME-Sender: <xms:FHE1ag9Q1TZuVn9bF0swmfu62fBb8xfo1npajPZgEAi2FI-GsNyljg>
    <xme:FHE1avl2wemxw8EhGPzM9H7RhWkFJ356uOMJWBp5kjDihXI_lLPqs3YfE1nEVzyjz
    kPZ9yAFgb1HZYj2K7iazSPDWG2cG5c-KZLfOtBcx9OEIEPOssI8hg>
X-ME-Received: <xmr:FHE1auXw4ZZWk2Y8fJfMzyY9XxqBEP88timtLbe6JjVWFjE9ZgJ9XPX1Kr1BiwlWbGuvKb4nE4ebmwue04gyIXr9Jv8nbyl9uXkK>
X-ME-Proxy-Cause: dmFkZTEmXXMK9/DvzZVKTkXErXX59kO7YcTxqLB6fEfBHCXe8x8oDJUMWqras8NjdsN2qE
    9XWoxBPmxLk++RcLPf0STLSpQ9SS66LuyybEACtJVHJZWoumsxLNg2Lyx95WAc/J8TYlDZ
    7yl635rRZyadMpOFkhdRYYPWDBMZTq6Y0WWAQ75sYjSKHPup5TRrBmYr/c8QW3T1iLMpVM
    TPipJAO2lpbO2+kBBAxXFtPspcuxUEEy0f02W2e4bgCvifwDaaRQ1NvWYtLWWs634FiKsB
    TAj6bj+uvNO9/z6L7qxqYw2WkKVO+ZIH5vWfob1dN87iBjukWJrvoKyc9qeEAT846Wu2Bd
    XV8t6eCOlD484gthF/5qGUo9LWsAzHvJr02aytgSKoA7KimsUX8Nqrsqd8qUEMhOD6WOvF
    hDku9A5GkxUVwNQ4zTU256f4Sr/KAMJAM54RrlnWfhdNOo119SK3cI6+D09YRpIftUgbYP
    r2fbNe65deTbeaQENJGDN5X09b1CQJzF9twL/Wcl7io+QCQbKQH6Vp3bgTa6jZrdi/0VZy
    Und70gW6wSYc77DROyj4dRfU8UfDYHLlgMsOyz09cXE63BJX2gzckEI9zZycDzI67NAVJP
    rj82xvVVwY8IsfGRIZ0jtL0LxdG6wuqgCL3GNxYrbaL3hFY9Y7lisLDx7KfQ
X-ME-Proxy: <xmx:FHE1asF5XmtOrSxQMmT_w21h3GQmf479IGPvNlx4jmW5H5QzCwTtxQ>
    <xmx:FHE1aif6nmm94SseebqQRNfPUjSOOC93dyudTLmmHymWPR4ecBE-Lg>
    <xmx:FHE1alLmXz9oty8_enez4DQd27pdavJe38RARgHjANO3WfUWYu2baQ>
    <xmx:FHE1avEElOpKbLhFH-GfB2R2ZJzUv5dAXQN3i19icStjSSf_n76ioQ>
    <xmx:FHE1ajU3TSvvZIdO9y0Af9m8Hx23yRMsqvelWxh8iS995_d37RyVBYj5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jun 2026 12:40:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Justin
 Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v3 15/17] odb/source-packed: stub out remaining functions
In-Reply-To: <ajTRK4nBxyv3YIgs@pks.im> (Patrick Steinhardt's message of "Fri,
	19 Jun 2026 07:18:35 +0200")
References: <20260617-pks-odb-source-packed-v3-0-b5c7583cd795@pks.im>
	<20260617-pks-odb-source-packed-v3-15-b5c7583cd795@pks.im>
	<xmqqik7frapn.fsf@gitster.g> <ajTRK4nBxyv3YIgs@pks.im>
Date: Fri, 19 Jun 2026 09:40:50 -0700
Message-ID: <xmqq1pe2lbzh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> diff --git a/odb/source-packed.c b/odb/source-packed.c
>> index 42c28fba0e..decc81aa52 100644
>> --- a/odb/source-packed.c
>> +++ b/odb/source-packed.c
>> @@ -503,7 +503,7 @@ static int odb_source_packed_freshen_object(struct odb_source *source,
>>  
>>  static int odb_source_packed_write_object(struct odb_source *source UNUSED,
>>  					  const void *buf UNUSED,
>> -					  unsigned long len UNUSED,
>> +					  size_t len UNUSED,
>>  					  enum object_type type UNUSED,
>>  					  struct object_id *oid UNUSED,
>>  					  struct object_id *compat_oid UNUSED,
>
> Thanks for the heads up, the change looks obviously correct to me. I'm
> also happy to send a rebased version -- just give me a nudge and I'll do
> that.

Nah, I expect the other topic would be ready and among the first
batch to graduate post 2.55 final, so it is not too much of a hassle
to carry the merge-fix around for me.  I do not even expect I need
"refs rename" for this, as the merge order will unlikely to be
flipped ;-)

THanks.
