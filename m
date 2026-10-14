Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355913CAA53
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 19:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792005896; cv=none; b=QEq/gTXeGsvgaXzsURQqNJRNFPXrJ74iXVZqVFPSnHiry4xfusTx0cJwzVy2VXvLIQONDP+p9wc1QlDh74dwUZxjbEvGuWeqI0abYZ7H0ZjC3liJfnpETfLlze0M2IEhhb8hoUQ/u/r27yjVLx61na1m96hmLOdOc1Z6Py1M6Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792005896; c=relaxed/simple;
	bh=7aXS0q7VSvxwUGYOV4u4lxRTUm9FelBwG06Ay0ievzM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IjtLNblOqPUwDPKwjvvhhzRPCAq1gUQwpT0zhEZSGmWdjyXu8JldeXj5JN/nWc6U6LRNtt8zHpWubFkiB5uRe4rvYBUmZzDBmToKTqfg4+7b4uRmYFepHUWDmfAsLHxMrB6UbzcjgeNr8Apf1o7rqX2zyqsBxdY8m+bGTOKdXfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TySSHVcu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aSyjkTip; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TySSHVcu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aSyjkTip"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 382531400102
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 15:24:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 14 Oct 2026 15:24:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792005894; x=1792092294; bh=GbTR/kiIUv
	lgxp0YWGkigxQt+wxpwAtDK6K6PcRo6Ho=; b=TySSHVcublk2Hcyz6IETsEFDq+
	Q9ZcvdrbXXR6OkuWQs+2SE5pKpCnFhqyr8eNJQeMNPAv8zgLDEvMCWGGEX6oSlvB
	nOT6WBFZaEwCQpJQ2bAtdLH9rmb96IFHGobCufA+nS0QuAJ5rs51KJJiwWtAIzEH
	B0tzQRf8xq1zSunqlY2xhd0OiLRINnWxOS4OmYIJnMy31mGOFe+LFAytF+GIALhS
	0J4+Wc4Pf9iH44rHyz6i4rK+nFTppHbkW8iUACpcA/Mw5aFxTKk2XMzqGh3I+Oxs
	cR89+WYAJ6HlB9NxdKXI0C8rp7/33EF+8GSj1nE0OfSx6kYa5IVQc3bVFesA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792005894; x=1792092294; bh=GbTR/kiIUvlgxp0YWGkigxQt+wxpwAtDK6K
	6PcRo6Ho=; b=aSyjkTipTEv4gak1WcpBRp4yTYt9x/0sLcMPZ5ouvoMQaTF5Y1s
	9L47ipW8C3ZUAIxzJXw+iIbtosM064rvUhOdzt/Rj9DYJI1kqn8li96jignQlbSk
	CSruMCWBQeLJD2CEyJ9uHiHD2clfskSAkPOo5+AjeuMx7gxVDOr6kqd+KW6FQthJ
	GYAXXSr1wfwKsf9BQqIYNh/ObYl1nblVy9pW+5I0lA9Q/+3anFYVgPS+MeBtSaTm
	KdIH3W9EtlQukN1iFQVfjMuDnJcmJDL/5x4yivwxXNJB+S3JLOMr7vSclvniCKyk
	2sFjz4dB5nakYAtthuPWxX2TbSekq1LS0zg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792005894; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Wn7ONYGjVna8gPAh0PqoP2CWqr9B6XUrBhTzH+apz/baYIO
	Ib0XCwv4M61UzfM1+BhPA1V8caXSGKozRgWR7kxGBSNafuT6lkLEbC2OHIgv8NZx
	uIawXNSdiMWxdTI3zFmqwI7wL+whjajxPz10/r1loYXIUYbDD26cTfSdxs48Prsv
	wApWatzUzZchwnmllK6fpVEjy/o4vC35otXNnx41f1ExVtIHkTUoI85zvzsL6SHY
	3swPIei3o2e7g1/EWYFKFhSqK+5PjwvuPxwoetyb4Zl5C+8cmNZxaX6cHK3AVwj3
	bD+3S344GAzpTXM1fn7/BTdYx1fxuY+l6thvZJw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:lcO/VwtRZuB/UgMRaHW0TiouSuFLNhPlz3UBE7Mq3EM=:7aXS0q7VSvxwUGYOV4u4lxRTUm9FelBwG06Ay0ievzM=;
X-ME-Sender: <xms:BtfPavTim3PkkpWk27If7cRI4L3_9suvWv-K-APMGhZJqj_3mz4Big>
    <xme:BtfPanyaZXsd6ZyycBWt2tpacx93w1tBSP9419i0mZgenSGwiefUmFNdJ-o8bRf1J
    NEcCvjw40mypVeuXF9lTfR7ZsiNU4wk3LyqqLD3z1-EdoGw0j6X5Q>
X-ME-Received: <xmr:BtfPap08SDMFA3z_I7RGBFGQmO9mkw-sIXdAIC4qBUrJH-62jdL_3Jc7HfuRpu7qeYxPx6q4kVVPxmX2PkDsAcBvuwlFRgru6jcS>
X-ME-Proxy-Cause: dmFkZTE2BU4y9SgH7HZc+zvfq/7c9WuUZj5BYCmQhPdiv8dhEQ24/u9akL2663rEB6LpLC
    LRC60h2K97kKr2IaVCFei/PaIezX2FFcoNOk8i9oHmyyH68yZmCoDRkUjRiRkbfBFxxUcW
    LNVov07ayw+L1fwyGm2VadSGEUvJGOdTRES+ag0VMLDlifqqt6YJiysl4X2IQQMgD9SBE7
    EyLCYb/LagBwVACAMfF9gV3p2naLNq4ezo1MosUs/CZ0FUu7tBFdjBEpxXN7PHs/Kp2vNZ
    bsilqS5GW7f0SGhQHJjOo310qdU9JGexHeW/QQrHU+6MjZEbkHbvsSiJOm5iLTyTUFiPUu
    uI3LyFLINH0Cy2vfB9IGLPAsIpm0vs8UtubnPfXvoB8n1YZvnSUFKvpANUp7rEJdS24O79
    WszGU/1j4Cx39r+ngIRQ8R8NVo842+Y256Ce5894eedtBWP7QXd5Dr5P3qNev+/IsfdZSc
    z26k0vVjvOu7zJ3jg4M/9ZWup0CMdmp5122/YKIcSiPmBpnVBqcDYJurRE6l2iA1sZnHf1
    8gFQv1c4C7OsvWJQXFG2ckO2oGCEYwIN+RYWlgPCFC6+A0yEA/TEv1rW9W8jF8XmfvjcM+
    XwRXohsV2p3HcltQrBoVOs6G2G5lDkaeq9NGTRMeT9LP21onPoKkZpIdBIOQ
X-ME-Proxy: <xmx:BtfPat7qEpxpbYPuA9jLtktfs9eg32fCTqtWOt1Tg4PSCrl_lulLQw>
    <xmx:BtfPakWq-ii4A0_gnLxbf50u7SGaTw7POXkY3s2ERtEwE_1Ub5ztZQ>
    <xmx:BtfPakDL5sOas9KT1FB9qu0xk6foSce3X4wl5EIJ6qTB4N9HzzXADQ>
    <xmx:BtfPar4dyyrLE-bXr9vhn3OR7-rekZGoy98WYiCSLtKlhzCxorE8sw>
    <xmx:BtfPahVpHSsuTvwmjzh-7x5QQVjfxgIzMr7NqgF8c6r5Lm22stdieC4c>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 15:24:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: Victor Okafor <vua.okafor@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] t0200: use path checking helpers
In-Reply-To: <CAPSxiM-VB_JUexggYTMmYcHe7W7pw=XNuMrENB4gZoq2Zo8J7Q@mail.gmail.com>
	(Usman Akinyemi's message of "Wed, 14 Oct 2026 15:45:00 +0100")
References: <20261014105613.49334-1-vua.okafor@gmail.com>
	<CAPSxiM-VB_JUexggYTMmYcHe7W7pw=XNuMrENB4gZoq2Zo8J7Q@mail.gmail.com>
Date: Wed, 14 Oct 2026 12:24:52 -0700
Message-ID: <xmqqtsmoqe4b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

>>
>> Replace direct directory and file checks with the corresponding
>> test helpers in t/t0200-gettext-basic.sh.
> This is a little bit more confusing. The commit message does not
> really show why you did what you did. Along the line of
>
> "Modernize the code testing whether a file exists in "filename"' seems
> better. Also, your patches is doing two things, i.e modernizing the 'test -f'
> and 'test -d'. Ideally a patch should only focus on one thing but,
> since this is
> simple patch. It is okay.
>>
>> Instances were located using:
>> git grep -n -E 'test -[efds]' -- 't/t[0-9]*.sh'
> This part is nto necessary.

Since many candidates are working on similar microprojects (which is
fine) and making the same mistakes (which is expected), perhaps mentors
should tell them to read the review exchanges on other candidates'
patches and learn from them.

>>
>> Signed-off-by: Victor Okafor <vua.okafor@gmail.com>
>> ---
>>  t/t0200-gettext-basic.sh | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/t/t0200-gettext-basic.sh b/t/t0200-gettext-basic.sh
>>  test_expect_success GETTEXT 'sanity: Icelandic locale was compiled' '
>> -    test -f "$TEXTDOMAINDIR/is/LC_MESSAGES/git.mo"
>> +    test_path_is_file "$TEXTDOMAINDIR/is/LC_MESSAGES/git.mo"
>>  '
>>
>>  # TODO: When we have more locales, generalize this to test them
>> --
>> 2.55.0
>>
> Thanks
>>
