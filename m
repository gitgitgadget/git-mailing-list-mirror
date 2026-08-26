Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8170F2D94BA
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 14:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787754910; cv=none; b=EffrColk8HU7tbpG5Qo/E+8uZW9g2Mf8ntP0qTefS4AHcjrz07Fi6upXHhsynl+0h/BK3tHa4J/A3XztFvFQOlIKIcjB9CNxNMG3PBFKLx8lV+zKP5qonCe5T1Apx0IKKzaG97h50j80oR64kxXMI8fG546WQP5V9KUCOM8YLHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787754910; c=relaxed/simple;
	bh=OeOd4Qd4ePSoBaA5T01e3aujF9B1e4hQOviJ85fsuSY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U1sTXbWMiawNGgutFhZrXfWnvBd8dDzh32u/81iLLXf9BqZFGTNTRPzy0e8qq/TVor5S50lLgi9yx61X0cy1opriTNIKt07GP8fa++pYAclEbBXir5sSFX9LZ6MvcplacghNQizs6ovkcoMynyBn7g+MQ1FNFbPridvI4OKyqIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QwRLPdW5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XWbP0Ohk; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QwRLPdW5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XWbP0Ohk"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id C40D31D000E9;
	Wed, 26 Aug 2026 10:35:08 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 26 Aug 2026 10:35:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1787754908;
	 x=1787841308; bh=RNWf3j6Mxq4aFHIRJZE/a2uRRFIJu740wWr+9JLix7E=; b=
	QwRLPdW5dOAQyGE6oTHGtYE7wB099kbIMa82juHeEAhYlCU4Mo8DpndhJXHzMQTk
	uCU3COhONjysXGvTLNaoux/zPRuMYIClIf0YfdgY0Vx/EfD41PlwbelsG9oUrHEw
	3X1QWBB5MSX230BxYdwUVCK1c5ZtadBvXCKPRm+HoCeEF+SVa/SCW/b9Su3NaINT
	CSRPY8wMXkrbTRVhq2Ewem115XhXUqfhkYefilXylUWMWGGCOR9pzvu5a3D4/BQT
	FC1wYFWo9hgl9iTe6aWRW5337b1HOA0m6kn65NSlg1AzNlnqauBBLIeO8aEbkTku
	ncTGbrlb4+NOSvIPKXLrHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787754908; x=
	1787841308; bh=RNWf3j6Mxq4aFHIRJZE/a2uRRFIJu740wWr+9JLix7E=; b=X
	WbP0OhksDA0CL4QukFy/Lusd6J8FjEiIvOFM+WeXUlPhWEkOg4kUhBKVQfVI1ngf
	BLiHT3mDSRFmLf16ao6g+OJSpzrJrX32sZtHeNpJq+vQIKn/KgG4kkLwYs0xJt6q
	spXYSdCI3cEZK120U2rOKZweLB3fSvO2tej9JISSnhz7HvLXImWcwWEuOrqglsI3
	4q82OR81GC8jri+WrkLnuWkZ5mnQTsfSemiu8fLl5OcISx7ZhooP/I9fOplbFqB2
	BnUyzSRUKzmdSS4cEYz7zy2R4AVALp2cTrBOZmxeKk+T4wwv9Q4db+9gFkaiBT4N
	BrKmWN+JFVvx2TMFTfOTg==
X-ME-Sender: <xms:nPmOauecV7xFNKpxuMgbLwRVd9JKmOCAvz-x1IjjjqagZz63kRpjmw>
    <xme:nPmOavpPC5FU3IWCR5EZBPbLJK58BOQunl5iHiQuRhPk7-t-gc6wE3M7wBQKAtJqZ
    7sZf9SjF4FnR4HFC6WFUMBH4fJVYOW1qjsSfiI7NrGDqswnkxle>
X-ME-Received: <xmr:nPmOas6xoaZq6WY7homzCA1EOJXRgsXC5jMX4oHGuZX7_MbHj-Txb29st62iGMW09c3Y76qN2GB8g-2plCEqLaovGB5tQtxnEg>
X-ME-Proxy-Cause: dmFkZTFMlu8BDZfcni8oCfF26/3a0EWmycp1LEKiNiuG7Qg45suHotDFXTYGk0wg5ErLCV
    VVNMcqEswBLaSrSrpsDpKZJ1VRilElt8xI4YXRLFAHw8c18wzCeUnOS45E2ji/y9qGZuk4
    hu5sBpkZu+vUNRCx8axxCD0RgBlU76WGRz+bu+w6ZzUkui2krHck9E9PrXzuqEHkE9KxU2
    ru7350oLePq85gvQQwMRpSCOgaQa1zt5a1iCVl0N1OJpfoABSIyD51s/cv6KMt/U0bHV1o
    gDvLF+0QqHRe343YtZk+oS9tXytMg95mSIJFr5DhhDW1Q9+5lCzqkY5kuorWV5UNjcU0Ga
    lfofYWUeDvrotWA60prtHF7jc7+pwcEeuCzS813UGQdv0oGFdfjeYQT1sF64JnnqebRTCj
    ZKiLXhc+SnI7kUOhAzeUy61G2ptBAE7xyWvEpW502P3+eKIT48TdPx9fHevjjrGyvJTkl5
    1Ly9L/xD4lO6KDIOJkivNgXFXsEiTMox6CKlMGlbBoHdWlZbBr67KnF0+cE1qPMgQtjMxz
    KAtRyT/ytgvMQvqu3zqghH1YQmVaPN07i+mI0KXUckhSZSkXBUglbIL6Aa6lY5wOsN3tCC
    4PMEu4VgkSgJUR/M6ywrfpiDgXTFmz4zkMtnhpoXmgjbmAdhXTPDb/1m+hHw
X-ME-Proxy: <xmx:nPmOalpMSq_r6XSVl9S69_s7TS-weqGUfPOjhXc2uAns8cU4XsUMgA>
    <xmx:nPmOaujZlDydQcHPdrrTMWBhxILscxWKU3u9crbpD3lEET7XTTDcSg>
    <xmx:nPmOavK4mKP89tJUU0GxRi2uGRhH1hFpTgQ1_QOhPgmo2df_twpTRw>
    <xmx:nPmOauA0G6cfopEG4yPf3yNe8bEPuQASs53hNDD5-eorbQv7z1BnRw>
    <xmx:nPmOarRJFbtr8HtzRqBGLFe6_aobjYnJ88FqnWj5gXBJAat9Mj5pLrA2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Aug 2026 10:35:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/4] worktree add: let worktree_basename() return string
 copy
In-Reply-To: <18e65a59-2d33-4f47-a5eb-ca5971cec482@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Wed, 26 Aug 2026 06:37:47 +0200")
References: <20260825180350.2099-1-l.s.r@web.de>
	<20260825180350.2099-5-l.s.r@web.de> <xmqqld9uklud.fsf@gitster.g>
	<18e65a59-2d33-4f47-a5eb-ca5971cec482@web.de>
Date: Wed, 26 Aug 2026 07:35:07 -0700
Message-ID: <xmqqjypdj6g4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> On 8/25/26 10:04 PM, Junio C Hamano wrote:
>> René Scharfe <l.s.r@web.de> writes:
>> 
>>> worktree_basename() requires callers to do pointer arithmetic to get the
>>> actual basename.  Simplify them by doing the calculations in the
>>> function and returning a copy of the basename directly.
>> 
>> OK.
>> 
>>> Remind programmers to free the result by renaming the function to
>>> worktree_basename_dup().  Two already do; convert the remaining one from
>> 
>> This is a bit surprising, depending on what "do" refers to, as I
>> read it to mean "Two callers already free what is returned by the
>> worktree_basename() function", which cannot be the case (or they
>> would be segfaulting already).  So I must have misunderstood this
>> sentence.  I count three callers of the function, so two do
>> something while the other one that needs conversion does something
>> else.
>
> It's confusing because I changed "callers" to "programmers" last
> minute and forgot to adjust the next sentence.
>
>>> resetting a shared strbuf to freeing the allocated string, which
>>> requires the same number of lines, but no arithmetic.  The added
>>> allocation is negligible because it's small and there's only one per run
>>> of "git worktree add".
>
>> So going back to the confusing part of the log message,
>> 
>>     Remind ... to worktree_basename_dup().  Among the three callers
>>     of worktree_basename(), two immediately make copies of the
>>     returned string before using and freeing it, which makes for an
>>     easy conversion.  Convert the other one from resetting ...
>> 
>> or something like that, perhaps?
>
> Yes.

Thanks.  We do not know if other parts of the series gets more
serious reviews that necessitates an updated version, so in the
meantime I'll reword what I have locally.

