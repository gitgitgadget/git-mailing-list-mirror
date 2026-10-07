Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E70D37BE6F
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 17:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791395012; cv=none; b=RHEQMXrRLMjqZRQ9mc5meAGanx7HpUfAnZtPMHzORpWdv5S2WOt8TjlulgKYg44g7aeGTVE3WRMpfvdnExa4hhbmYijf7bv94fd6vQQowa7G/0nZN152El91kh+F62BKrvNL+sfY6qYshdt6IPJA+tsyH1DKt/DCa7E/dTFH5PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791395012; c=relaxed/simple;
	bh=XFfx3MVQ788HT3xb03V9NAXsxKWyykS0suvi6PTGph8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ApHDQQQMWDZ5cdm5xHVYrIL4aGHoyGLNICFHv+ZFZAhfO5nieYgetHjN+VMKp89zk0EO56ri9B81O2P14j0lmsZwdGaLiR3oopshllXOKZzdgbCc7esjjxKAkwbzh3+Xdl8WwrLcL6CCZDhU5Gz0MKcRuej90239TnO6pntV1Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ffFVXNGz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mHSM5Xxz; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ffFVXNGz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mHSM5Xxz"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id A6266EC045C
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 13:43:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Wed, 07 Oct 2026 13:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791395010; x=1791481410; bh=toCiBWY59s
	8/P63viZGsNXmtiW1V1LPanSrBa3NrEdU=; b=ffFVXNGznPLtA49hx2hJ5jUCnw
	hqlsB0qTehx2FH/aFVD/SFtPK3xjysgBHidc9aNaemzH/7knuIHqvdakF0l2MRId
	SWDSczRQQXr4n8YmqjvApsCEurgR+TgkwQIuHuLBVCJ2ac4FXKbwizRFkqb/PkNa
	tdh4dbPdSz+zKbaHkYlUD+uZWM2dT6xAft8fmVPnw+nbuKK6boRia6A7IG+Zn4SB
	9GkMG2KEFV+ayWwLXXacNCzaRcO2LPTbd7X42PcPlbBCt2lMbp3Keia6zGrpgFrn
	cMTItxaFEVXy9LpXXkhFLPxrYtA2IzBLBiVKe3WK62yqtjNrew37X9RaMzeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791395010; x=1791481410; bh=toCiBWY59s8/P63viZGsNXmtiW1V1LPanSr
	Ba3NrEdU=; b=mHSM5Xxzw2WbcGIkJfF6ZkBq1u4VIruLdgX+SZQrQwSWxOuqAfv
	SrVXrw6e203tNHQQZVMXG/npy6H+jsdVk1ZtXovn0GzvsldZUoi7isN3ObRI8WeO
	qsmxJTempxfWWmqOes5z1IaEbtVHL0QQObY4rd3AbuHkvNZzJWDlf9R5wAfYOEzC
	EygHvXnWnY7hjlB1eZjVcSpkZWhTQ+N2c94EaQVIf7t12jz/N1SycjVtiRGdlF34
	pARNMu31jwWxG7+BCznLld9OQFkZv6e/D5HLVFNjIe1x4RVeIGcpcdN+xVwKqZdO
	C/mlsaNZcyD1SM4OKBJYkaOXbhf4YShE4UQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791395010; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Utw2UjU1iGzPEA1ui2/YGI2NGOtjX1XDQ5DLqhSW8exmK06
	2rkjB0ZbgpwjCoDZmk+GhBXF1bMk1hYm2C00Bugt3AwyACkt7ZnCzXMb/5c0wPFK
	AhzPjtTYrSXoUL2l2vdwVEDlX4Zl97Hk5+GXhWZk2Ac61vKWqnF44xWtfFM7q2OD
	mRLarx//OPWsKDgjWyblnj4k1HKPXBarmnSbqmNMy1lfEdOewUaNc2hrpL5D4YcV
	IV8toUlUo0taj98kTgMmc0IpYMORms2GGmwp3vAu/cNnVFpqSg0lte/MI5mOzihU
	w0QCFGBt1C7LxQ2XGOHFS5l1bu+bFTiR+VjHrTw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:xxlUhPJOyMJILfXfOxuHHTQGZjFaAMpxWNJk+g1e464=:XFfx3MVQ788HT3xb03V9NAXsxKWyykS0suvi6PTGph8=;
X-ME-Sender: <xms:woTGanVGZh6R8-SqaUybDd6zSzMqC98Jb_oM-ioSkxnUa8LM19Fjjw>
    <xme:woTGagSMZM36SiasXCd-co-aBCArmaKFXkHQwxobnMxY4YH4f0t7_e6jbwzmsqbnE
    AEidz4x_voL_qRIal6XEaBwxFZBlK6reaY2z_GRXA9VlViZTg7DGw>
X-ME-Received: <xmr:woTGahkKAJ22c-v7orSnxotW8tapzeTJggjIwukUJEdYqQS9ZwB3_XmCVPWNa16ZNgQyKfrx69j0gTRAPWO2t6is46IHs_ymnypY>
X-ME-Proxy-Cause: dmFkZTFwuLqHkDt6c7h1AC2fJlEppviXtAhTSo9J/ApUQGv9ODpl0cjuXtclLuWD8GDL6W
    CY9BiIwJTdTMZ74XkC5f4D9jCkhKV+y+xRLyjyRMYpq//DW8yCNQjzHRHJ0wCwaiBWCulU
    Hs8uAxYLEk5qINFwW9xRdRIOwre+fM6aMzcnCyBJkm3pYqQigwSVMq7BDXGcIt54Ns0lZU
    nVQH93pZ75dZ5IbyfS/cqBj0Nxrc7f5Sm9VHTgC2YIwCzCDsZ4sSYxDKllYpa0b/SQdnIf
    et8ZoBp060IogZ4c1LE9r4VIYIbkaZRp6JlTpqJ/mpagGTlMVSnr3YAlfvmiKAdQMSRCqv
    3EoU7tD7bQUg6HqtTniIW4jEzDt9GpxZhKSFU8q+pCKzv+c+4fAcAtzzb0Hr9H/Tpi3v+P
    kB2r4wkkB/X/kf/o6f/oaMW2HEB5YfTpo4ePYrThUi8OHpPOsNu2ifWKP/ig8aKoYwnqSN
    gwHRCE4FVJvGyPiSFs8npxvMaBDRp8jzJuyJZ21uv7IsH5CXtc6DIhJGPiPhBY18YwqWxZ
    BKwYXWTCbpMqNrhmhgR6nrmN+t9nOhz/eJUj5c0V7Gj3mm3TkOS3FJmgXsYVzQKYjs53A/
    wKlzKyQoVEzFdnp9nx9mfZ0QrfpCOF6rdklKgOcl/8CVKVh/5uzGnB4PCByQ
X-ME-Proxy: <xmx:woTGam4icDEfa4A-SH3BTF1QuSPUSUy1BIB0cvCsZtQ7OP5EeHHF0w>
    <xmx:woTGanjY72A3qGsBp1TSl_5V9bPqjm7oUj31mrYA-bNJaGQ0uQEf8A>
    <xmx:woTGajH2o-8WVO_vkxYAdTsutTAyrt7EmBFKY0Vfu-Gtl2MbAMbtWQ>
    <xmx:woTGatSWuF4_7LoLc8z7u-g3hmcpASi5tfhC0Mae5e7PQAnoZ6g4tA>
    <xmx:woTGatDRGl8Mhg3LBHVIeI40LVfjljrqcpmjXdiC2mrELWGvdsXjJnuT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Oct 2026 13:43:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ravi Mistry <rmistry@google.com>
Cc: git@vger.kernel.org,  phillip.wood@dunelm.org.uk,  code@khaugsbakk.name,
  sunshine@sunshineco.com,  abhijeet040403@gmail.com
Subject: Re: [PATCH] blame: default to ignoring revisions in
 .git-blame-ignore-revs
In-Reply-To: <20261005211213.1896012-1-rmistry@google.com> (Ravi Mistry's
	message of "Mon, 5 Oct 2026 21:12:13 +0000")
References: <pull.2224.git.1789169384240.gitgitgadget@gmail.com>
	<xmqqse2kma4o.fsf@gitster.g>
	<20261005211213.1896012-1-rmistry@google.com>
Date: Wed, 07 Oct 2026 10:43:28 -0700
Message-ID: <xmqqmrsp8kzj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ravi Mistry <rmistry@google.com> writes:

> "Junio C Hamano" <gitster@pobox.com> writes:
>
>> While wanting consistency is reasonable, the description above does
>> not quite match that goal.  If an untracked '.git-blame-ignore-revs'
>> file exists at the root of the working tree, or if a tracked one has
>> local changes relative to HEAD, the local repository behaves
>> differently from hosting sites that operate on the
>> 'HEAD:.git-blame-ignore-revs' blob.  It may make more sense to say:
>> "If the 'HEAD:.git-blame-ignore-revs' blob exists, it is added as
>> the initial element in the list of ignore-revs files.  Other files
>> listed in the configuration are also used, but an empty element
>> makes all elements that appeared before in the list forgotten."
>> This rule should apply whether the repository is bare or not.
>
> Thank you very much for the detailed feedback, Junio! Reading the
> committed blob from HEAD instead of the working tree totally makes
> sense.
>
>> Somebody has to audit the parser for these files (one unabbreviated
>> object name per line, ignoring whitespace and lines starting with
>> '#') and ensure that the implementation is truly secure.
>
> I looked through the parser in oidset.c (which we can share for
> both the HEAD blob and configured files) and peel_to_commit_oid in
> builtin/blame.c. Mostly looks good, IMHO, but there may be two edge
> cases we can tighten up:
>
> 1. Rejecting lines with embedded NUL bytes via memchr in oidset.c
>    (where strchr and the check after parse_oid_hex_algop currently
>    stop at the first NUL byte and ignore trailing bytes on the
>    line).
>
> 2. Passing OBJECT_INFO_SKIP_FETCH_OBJECT and OBJECT_INFO_QUICK in
>    peel_to_commit_oid and peeling tags step by step so missing OIDs
>    or tag targets do not trigger lazy promisor fetches in partial
>    clones.
>
> Does this plan sound good to you for v2?

Are you presenting a different plan, or just adding details to what
you quoted from my message above?

I delegated because I did not want to spend time on the auditing
part, so if you are asking me that these two are the only things we
need to address, that defeats the point of me delegating it to
"somebody else" X-<.  Hopefully a v2 with some tightening the OID
parsing may entice folks (who are hopefully interested in security
related work) to chime in and they would help us decide if it is
good enough to cover these two points and nothing else.

Thanks.
