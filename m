Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7F93D669C
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 17:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791393817; cv=none; b=Wul6ppT8XEBy40n9sTiP2MP9dQzeb2QUV4A7alamQCX2LTNhCaPQrbr/HYU735W2yGk8lDnGNbIGxEWOtnduNE+hf8Sl28MSg//gmuqCuD3/tY9TH67gTDRkqOuxMFWv6HGghERsv5C0zR3ytrvlWNUqvLDT1/Var43o2nyjpwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791393817; c=relaxed/simple;
	bh=34Y2pg4DngiFfkG1kptkGhv0GlQuddEi3RK8Zpu8Ln4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PBuHGqAm19yJ8ZipNAhkfZ+e9pOZI/7lSfWWONZKfjLzUQaeVcCOcj+y2tODwePWRQBZfnyZw4er0Gamz5Itnpd9A+RvEX+UQgXb6j2V4baaPyPhv55H1rgHVToht4CFFCi/rqUp0kxlvu3+5g7pVeMEcHDde4xtoK+DE3AZU3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PCMmAfCo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IF1wiqhv; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PCMmAfCo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IF1wiqhv"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2B2541400175
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 13:23:35 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Wed, 07 Oct 2026 13:23:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1791393815;
	 x=1791480215; bh=1SrsQqtoP3WiwEEYEZHm8rA50JC7zaHpb1fk6pUad+o=; b=
	PCMmAfCol4MTn5RgT5kBVwTv3ExNSNqVAqroFYBFosHERUYgcPnDypvhDx62b4/z
	Ngw0bF4LWvd04l8ny15kub0LRFbP9hGyVWGcDvRq/VOV2Q90mQ4g56jn8PmnonVr
	xISm19kS1bmL++JrJkRIICfVV3GM626FcDJ5Wz8tbYaw3+/3/vkkTzQ75kpexjSR
	muMulU/EfyE4j6G5UqD4OrGPVI2GbreDKBsaT62p4hCIrwSF1VZ1hu8vb5evasVq
	Z/05hDTGVbzgCZRaII86Xyo/HgFdnvsl2F3+PhErBPh9HZWwA5fX55mahMUBS9eF
	sWFw0BX1sBkcN3lgD7DioA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791393815; x=
	1791480215; bh=1SrsQqtoP3WiwEEYEZHm8rA50JC7zaHpb1fk6pUad+o=; b=I
	F1wiqhv0omzadPtSzNybF0gBl0BUMsFuBbOXUVtMPncLeBz4xV2/npCD9L4h0Xn1
	pc36eD/4MRo9s3Xx72sN8WwbiVoBflAdEsMP6QXyNpPe/aQQ6Cford4zj1UEPli5
	MshkWUnOq44XqsimfICPiAn6AmFybmXvpJzZCfC7uMNH6hzfYwOeb39RrI8EZfLh
	2SyV9s9rOS6dRVRPyjwm7J76SW0nkhSv8nRe38EZEJTjDIdrzbilJWlHzzZiJldl
	RhXCCtaAIb3y4bUCpTBs/TjeFVj1IpFlw4M9Q00vOkxmy7hRE+usqHJmvylJcY1O
	3CURlrjNRNAtK6UUN3/jg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791393815; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:KIWzJOTF6jpgZcwvykxhoPUnGtjV5zvof+yfWhMuZL0hEol
	9PYeqmTgrNeTDte1AbsEUVfEifrs6A8Ek/cMV2HgcZvWlYNhMDDqCDyUEKRrWwxL
	57Smn9/jtxrmDMiNIx99sUtWBYccvLwn/oWdjWalb/DKXaJXvgt7e3qAQjIlgLvh
	LD+mDq6dqbJD/deERXZpUDe0k4AUNvPuKK6Pkoy5VJJEHENNuFzwtinjDaKATVUM
	pWr3K/aUzTT0bF5LQ1KcvLbid6gxw/hpsXd/IG/LxUdqNDbKJ5IurzI+S2tD45R6
	IudPtHx7tAFYWIS+SDcGjclo5vvUXjncAiE9pBA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:8zOq75756kIl7iLKFIPRV9nEy4VyiwG0XgAtso/Ryjo=:34Y2pg4DngiFfkG1kptkGhv0GlQuddEi3RK8Zpu8Ln4=;
X-ME-Sender: <xms:F4DGasJowYEoRjvZh3waOB-DqXpDeAAq0Do4zCr07yCxP8N2xJDZWQ>
    <xme:F4DGajneIYSqhHNq8i39nur8ogVFm3VhcJRJOEZRaw-9iaOnRg5VoJmBXRhFKbhxj
    nR1gsc5xDFd5tiNiCPy3YFRu-iQkzJBPhmur4J3osfvvLsfda-tlQ>
X-ME-Received: <xmr:F4DGaqHcHC_ymL1Y0B5vrX_64_Y9157aecuGGYfHdun_MiwXFf67ErLrLeOgS1ZFtLhILShxuSojsQ-hTw2ZNbTG9SO6g0ade3QG>
X-ME-Proxy-Cause: dmFkZTFoIMzLxtAASLvWLtHR09RiW/uPY9r8apOGlI9eKeiIdsXvQpM7w1VfEhivKAkqb8
    wHs10r9Q/UivsfoRUhp2Psib1mXKCUNglGen7r9v1vlP4soBRhzu1JI7sxbiHLO0Ah9Chb
    JSvtkonsceZEeLpjE35XSRoTTs04kkasQ4PlK6S0bOxYKx27ENaEW452XJcrx/vfGEEZWJ
    PzRVmSZsWqk6g+vthh6QCuUKOerc19nrygzlZugBf1PU80hqKmzfvkxubZvYffIDzaE5EG
    PVwGaQhvGALNl3v2gGu5nhMl4uTR0rTyVkC9JoMn2K+dn1YNLuRF1iDL9FBNUNJ8/XadTf
    Gb5kJ6QNp92HBV/HQtpSxXGRtX0v978ihAbwWsQfMUcrjezedawavv0r/7gT/pqUEzncCu
    z4T1t6yjnnx7rx/wcm7yRECpDlzCkkdM0hUITBev3w04FrB9qZy3/yjLvOvVnPZBai2m8L
    df8K4SR1teUmuA36EFXcp3oJCCZY2mYjV6G73CSe73hUS7ii0yONPhdiaQwHDD9hjCW8Ij
    aO/WaCpDSQKQq9n3QVbkbVpaQ8ZFg2w8ueT5eKzJe8Y1fi3TGJwZd2cOQgHcruindW3bmy
    q4yjib+9tTvyIY2ZWD3tqkjf4l8oYo7tXr3y34MF47CII5h6l927fmGbCDEw
X-ME-Proxy: <xmx:F4DGajEauejMjsGdSFXIq6yA-F2NcSY9-8ILz4dyAgGmkRcMnLuc-A>
    <xmx:F4DGanOo5XGMa8L0d_RTH-DHtA2iVxGtydm67jG-qWNSu8iPpPwMyg>
    <xmx:F4DGaiGMteIb_QV9ghSDwy0XJZOgdTE8g1xdGnC0du21WYGADIJ-qA>
    <xmx:F4DGauNZcd0WGotYZpGa0VS9XLnpWhbjHnHntZoOmRMltGKdlBUZmg>
    <xmx:F4DGakPnIlAKMdz8_dCF5LI2Fdx83hiOLYVp9rfrz-w278U4xiK_uXH0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Oct 2026 13:23:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Scott Chacon <scott@gitbutler.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/4] faster SHA-1 collision detection
In-Reply-To: <20260929112544.86511-1-scott@gitbutler.net> (Scott Chacon's
	message of "Tue, 29 Sep 2026 13:25:40 +0200")
References: <20260929112544.86511-1-scott@gitbutler.net>
Date: Wed, 07 Oct 2026 10:23:33 -0700
Message-ID: <xmqq5wzda0h6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Scott Chacon <scott@gitbutler.net> writes:

> So, spoiler alert, the code in this patch series is mainly AI generated.
> I would try to fool you, but too many of you are far too aware of my
> actual C skills. That being said, I thought maybe someone here (especially
> those of you working on server optimization stuff) would be interested
> in the speed increases for both the server and client in making sha1dc
> quite a bit faster.
>
> This series ports the approach of Sam Reis's sha1dc Rust crate [1], 
> which gitoxide recently switched to [2], to C. 

Which means license-wise the original is compatible with us, I
presume, as they are "Apache2 or MIT, your choice".

How can you/we be sure, with respect to the current AI policy in
SubmittingPatches (which by the way was vetted by SFC lawyers), that
your "AI generated" code did not "borrow" from places that gets
you/us into trouble?

> The end result hashes roughly 2.7x faster on the Xeon and 2.85x faster
> on the M5 Max. Single-threaded index-pack of git.git goes from 24.3s to
> 12.7s on the Xeon, and from 16.1s to 8.7s on the M5 Max.
>
> Hashing throughput on the Xeon, in MiB/s:
>
>                                 16KiB    1MiB   vs OpenSSL
>   OpenSSL SHA-1 (no detection)   1234    1129      1.00x
>   sha1dc/ (today)                 435     450      2.67x
>   shani+avx2 (default here)      1002     901      1.24x
>   shani+sse2                     1075    1008      1.13x
>   portable+avx2                   553     654      1.96x
>   portable+sse2                   603     681      1.84x
>   portable                        466     565      2.29x
>
> In other words, currently collision detection costs about 1.5–2.5x on
> top of the hashing itself today, but only about 0.2x with the series. 

Thanks for these numbers.

> [1] https://sam.dev/blog/faster-sha1-collision-detection
> [2] https://github.com/GitoxideLabs/gitoxide/pull/3008

And the pointers to the original sources.
