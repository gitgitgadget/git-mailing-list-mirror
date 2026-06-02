Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4B51B87C9
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 13:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780406180; cv=none; b=dMHLqzfUDl/QbY60BVsFQrLUWc9tlH5atARX+Glw8qypBbfmtCVl17smq6dO4+b8mG1uvCc7SmA8X3e6eH2UmSft0HFt3M/aM1fHZxbRgBCK2t9dbUMMpv93meHEF92e0MgYE6hyXEKi7e8HtCL0spIOzYKZHiuVnju7tF8JuHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780406180; c=relaxed/simple;
	bh=0Awk1Gige4lw1UyYq5Uzz7DSfIeIVOe17UdOMuV2Mdg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KZmIUwRTma0vPgnFv4Hz3oH1h4KcEjIU4vo7g7WeV/SZSjNHIFgW956nDT7PihYtVEx/3G8nngNpKexMHifopzzxL39RJqhtRRZ7sKnIL9YIgPu80L9Eh60gkXoEf0YcuEXMlYdcAuYMt0LXKWoG/0f2cUKwQ+ngkerBb0Zt4Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AUNYpfr4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jg9+LOB0; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AUNYpfr4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jg9+LOB0"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5A7B07A00F1;
	Tue,  2 Jun 2026 09:16:17 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 02 Jun 2026 09:16:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780406176; x=1780492576; bh=SC/fCOOoSb
	i94FH0vaxWCM6Od1p03cmRA6MoLqADZ4Q=; b=AUNYpfr4Detyy4ja3a6Ka7TDh+
	T6OMT+jia82T3idZrJk6VbRvVJD7sMSLGjpAxOAevPuK74/GyYSv8+u9t+nYieLF
	B32N4iraPVp79rUS9V0ZlmNnjrYLE2yN6jSQzr3nCKkjiW9xN/2b2VVXwCqsdklt
	pN0NkF0aRvbl35doh2hU+ZzxcHA86KDF6AWXEQDbgu6DiQ1Fwa3WRQMCfH96Rghk
	HAW07VXabDC8w2wis8/87Ei2z718Hso60SMsI8WTovpjvkCTdOLWZBn+Ngd0+Uv3
	oToXbaT9Let2C1Of/8epPHCToDiyXoqESjhCbFFFbYbebJDG3vUAI5RlqXeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780406176; x=1780492576; bh=SC/fCOOoSbi94FH0vaxWCM6Od1p03cmRA6M
	oLqADZ4Q=; b=Jg9+LOB0YqLWT3fqqcipmMn5aVns+fG7unFCzFYxU3+wxBlulKN
	Zt0yrueULT98GC7Uf1Gv5FtYm1l6eM9Ue/7DP4nraZjSG0eYZ9QBUStMzSrRx8/c
	8IGrieFBq5k/Bh4m/yfrXMtJ+GqSUJxW63FCvp4qkaJYEqt+izzq4tJzE/W5h/4g
	E025/rAcsrG0og7hHYiVlgS6yzzILHWcn+Bh3ylJUPHmMUo9wetF1n/IgkAweO2W
	X+b35F38kTW+vU4x0GUEJPvZZSFVR0ROrUKKBP2bF6x+w2sQ8LZkFUw9GiJummGJ
	p7tNyxAiVjas6TmiXfSSXTvI5lWXsoJp6jA==
X-ME-Sender: <xms:oNceasud2WafTkPc_UTFSbTpbHhdLoS0j74Sz3hP-Vebty1QIuZS2Q>
    <xme:oNceag6JYoHmITLuNIckWc43SUfk3Svt_V3i2DSOTaxU55F-Z8tOOP2a7NGNy5QXi
    AWh7gWNqTXWtai_EUPOAboB_i5ERQ9m-vxdf3NGl9-SJppO9xUJ0A>
X-ME-Received: <xmr:oNcealL3fE_nAJ8XgWPe-KyXZGx_aA0wxIDRk1DwtY3HupnwfDX4PpGlAjDt5PMXARNpQekKNwwkD1Xf2wakx_-ljBr-CmwBrcJv>
X-ME-Proxy-Cause: dmFkZTG1+GNWODoo3raqPLNV9HY/wJWCuI408gVed1wUcU1Q2Hdd7+1yAHgDiJLdlm0iRm
    97f9RiPMkV6Ik1tWQujHB2VxJOlSWOyZvt0hc04gOVnM+gRaFqgvKQkbJhf0f25N+/2rF3
    I7hcYensYrNmQ0ag8HMBRCg37+J67JJKNK7ar37oqFLbMOu/6T9tb1uf9NOTWqgfLwV19N
    GmE57IOCfcXIBe9iq1FYPphm70f9w/NXlJS2sh7Av9KXRA0M2HhpkEtJA2E87XP392lP7i
    xZJzy/4bfnhQClVMMA51WSA45i5GSzq739mowhnINZUUsATg3hXwYr9sz/K2n9fY/LBIKk
    25R+G6ZfG3J0WK/S7pmhq2UdG3tfITq4AMIAZEg0v/z36Sbcx8ISFaIUq3F80C1vhOS0pu
    SVY/8BbPOdaKEYR/eLoO2AjfvU8THhMeAWPIE51L1g7J0iEDFzeRrBYO34lBE8F270c6ax
    y+J/zx7NSQjCixmYSLUrXa6s/swlTfzbNxWuS8HmsX02kc1W4cViYz4rfyHVI7rxFQlada
    5z6llgZhOGOfQqRyxp77Mho+czM+ix07Nphlkode6V1ef8eE9daJplpHn+bmIBmu1FLIlA
    ppCj2UG6YTqhfA8+WQnN7YSyc1aOUIUK6xcLp8pA4Kl/mYS+xNI5WeIokKsQ
X-ME-Proxy: <xmx:oNceao59yyKihSRBzKgzoOyXD-gg1vbFzUuMx8kg4gQIUYkRUNe-1g>
    <xmx:oNceagyFu_Arj5r93UM5Qcej_f3MsRRByWtAjZJBUKgFqe3uCXBHpA>
    <xmx:oNceakbvARMEmWxs_-S9XDnHBf13RUU8WjGYvb-ubzMRcZLt5smrhg>
    <xmx:oNceaqTOJovPs7Iw9GCldGIn55lpBSUJ4XvsUJb1Gl4auDd4emtZdw>
    <xmx:oNceahCWjXc0UpXLuQFJ1sl9mPkJZbrNU0nMZqdNyX2wCco5qrNmiyl1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 09:16:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/4] t/lib-git-p4: silence output when killing p4d and
 its watchdog
In-Reply-To: <ah6uZ6tdIh38X2uZ@pks.im> (Patrick Steinhardt's message of "Tue,
	2 Jun 2026 12:20:23 +0200")
References: <20260602-pks-t7527-fix-tap-output-v1-0-db3da2a1b137@pks.im>
	<20260602-pks-t7527-fix-tap-output-v1-3-db3da2a1b137@pks.im>
	<xmqqecipxp6g.fsf@gitster.g> <ah6uZ6tdIh38X2uZ@pks.im>
Date: Tue, 02 Jun 2026 22:16:14 +0900
Message-ID: <xmqqtsrlw09t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Jun 02, 2026 at 06:32:55PM +0900, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> 
>> >  stop_p4d_and_watchdog () {
>> >  	kill -9 $p4d_pid $watchdog_pid
>> > +	wait $p4d $watchdog_pid 2>/dev/null
>> >  }
>> 
>> Shoudln't we be waiting on $p4d_pid (not $p4d)...
>> 
>> > @@ -175,7 +176,7 @@ retry_until_success () {
>> >  
>> >  stop_and_cleanup_p4d () {
>> >  	kill -9 $p4d_pid $watchdog_pid
>> > -	wait $p4d_pid
>> > +	wait $p4d_pid $watchdog_pid 2>/dev/null
>> >  	rm -rf "$db" "$cli" "$pidfile"
>> >  }
>> 
>> ... like we do here?
>
> Oh, good catch. The statement basically doesn't do anything, which isn't
> much of a problem because we really only care about silencing the error
> message when the watchdog is being terminated. Will fix.

Thanks.  Another thing I noticed is that they look suspiciously
similar.
