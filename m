Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29ED3955F4
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 18:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791397124; cv=none; b=bRhXfoxLnYCahdHXk5VfGOwWmerVJyg+ibQmUOaHtwmdrAVLKHcjJMSk01sHRsJ9H9CvwqvDE9FwM/CgZjLGfRIRV8oXu0w5+grFJ/tEKCxupuDInaYJH1D/FyGvCzE551oMHDl0svX4bwSuOpl0iAyY2W2iOMq5N8Q4vOHyPOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791397124; c=relaxed/simple;
	bh=24xhDRbbXAV3QbDEcsv6S0foTc3BxOFPHQVhC2LgSIQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S9w3fTpBgmcNxfwmqxGTJjLWDXsP5+YinmdVpW49bnF0Bu+VM4B0p2csLlyMqMKMjEOs74Mys++2HL3Ujp3eNFfTSnkwMBocVX21EA4WZEruGBkon8DHeTT1ONcMd4zdC4x1AEL29fX4pONnNnADYP05EJ1xmVNUGcsB85MfdqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NHkyfize; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ipgYNRp7; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NHkyfize";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ipgYNRp7"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E6D427A01C2
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 14:18:42 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Wed, 07 Oct 2026 14:18:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1791397122;
	 x=1791483522; bh=xpeFn9MlyPZ6vGKNM4XnRSG3TuXAHKgYzUmZnl4X190=; b=
	NHkyfizeuquZLXW4oU1fHvZ8x+0fP79llJFnnKPiPCCyJ0sWF62HQ1dJ5G2INXYg
	JDQvUMLrmXhFnmM0em0UnmVo/c9kr3aejarpSaR54RO89+2eLVNI04+ahI9V5KoC
	hYUaHgr2ZNaRYHw3w4VWmd7TSvuJYv/hFZ5uBfd343pzpUp20OpA+B8sTWqzyuqi
	aRFYVlePICDWCLaMCcsVdF3+/xA4bUyClPkb745HSLzR9qw6x63nvgUxXF2w40VR
	f8NsQ/3c+Cn18uhIJ7cUZZuJN9tMBeISG7zLs6k4Y0NIosx9o+MNIg6YBf4AR0PC
	QDC2PVap00H1q4zbcexoFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791397122; x=
	1791483522; bh=xpeFn9MlyPZ6vGKNM4XnRSG3TuXAHKgYzUmZnl4X190=; b=i
	pgYNRp7B5npktBcPITmAK2WQSDWYlEcgsoeKlyWJ18vcnsnI2EnNoVMU/8mHO9lZ
	JXkB30WLhnibB4mZhlZdSHcCD0oU3KqsomgQRC8ewjaC9+Kh3csFpremPDS+rQKU
	bfwVYjYcaXbJ6XDJWEwvyK+5K/cOUy+Nal2N2TN0O4rBAtY6+3bkzzMhErNjkjCV
	6qJc9fNYzeBQ/K5LweGIjPf6l+i0Emw+jzgTsZMm5UdwosqQFITV2pQAcj0VvTbg
	0NQJFiZiz882ywtYiHszyIYXer8SscsEG82m0m4CTi35HGTPCHP2dCv+KQscO+09
	ooVt/6prBCbTZAJPwIycA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791397122; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:NhpURNHQt4Y6jfMcJipX/aUFQuooYr7JuchLNktzpTA90O8
	kCK9lDbgkSktD9GS01GgwqyP7FTpXjSK8QsQglZ5KCxqZfs3lfKqngJebvAt0Zf7
	BkdiZyRXk+oedFwEgtVAz987JaT9yoGP6e/ueE+RcKdwzvXxiFyi7y8OBp7J6VjF
	1rrpkzVf4ohzGXtgnCP5IG9DyQSrS+D46+MDMrwRxf9GkTRJMl+TVd4X+hbZdV7z
	NOyMJPSjzG6+revK+XR1qPVQdu+qCPbYlJVGQsaa/MAY3wohUqcU4QYnWpDHkEaP
	mDMojyrCDeHKJrF4JiPEmndL1c57lVyzEa1spcA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:DopHtvNC0FuHm0T+gy+rOPt6nEZLbDHU4FFUJHGRH7M=:24xhDRbbXAV3QbDEcsv6S0foTc3BxOFPHQVhC2LgSIQ=;
X-ME-Sender: <xms:Ao3GanjT_ErJo91iVpRHAIUtgEt9PhOxLTEz6CNEt3gMdwg84OjwRA>
    <xme:Ao3GamTeERU8W1wT_ACZVYzXTWYIfcYd68n9qMNpuOmAFKG3X7vSgD9dPLrwoohC7
    7wlHVWlRRU6BJrjuXwvCCQXMZelisV0ExOKRTn0YFCQtg_lL4qk>
X-ME-Received: <xmr:Ao3GapVk3a1twmOxAUVeh1NpcC500_b9TLnKLyOZHGrF7jKJ8qHgnYHS3a0oMI9bmMdNACLbJOJ_xq800bz-_ETsl8obGZta4mnP>
X-ME-Proxy-Cause: dmFkZTElTXw6gzogHT4FfN7Ep+Vh/FaEMIUCT5Oh+3PEwNbMPX3Npj1D5K/WYARSfii6NQ
    lvp7xMv5GuJEVyWSyfbi6N5jygincZ+65Mz+01Hpv4JHeRBKDbWjt+UcnOWWHx0OBSuKBQ
    v47CPlAYqpHW11VLVoaHHmzsOGofyA24Z6v3x/Cct1xcgDMR1PQuItvNmgNZW1N/V+lMQZ
    IwMyYk99PtexmQWyGLWawOKnkhHCVir6Wqca+m926sNlC0OtcTd/R0VJxTp51dTiVrEvOF
    wqr3Yf8UH4OzvP0r5+h1WGMBpZ1+78GmztBecdHHI+NKjizZiXPh69/MPPr7RfUR7IPQBJ
    KnHv14Idyz6zJAuq51jroy2YrZvrblHIsvkuINnMkeDEfXz/gHArh7Gb49EuKwVCHfahx2
    xYudkOJ2P2luIu1WJQLt8xU4D0JwvtLYsnKkLk5nlfk0a/q4WLoh4or0TfxqcFzcnV6bl6
    ov2vA98qm82K1wAYmP4TDgvfOmECA0VrHrCjNQq6FppeBHufZMs/kAKrT7SwlShSg8uklc
    g3OqRRHCp/m2rTmpmGmSC9JihGuYYFfVDdcHpHBSRcEmvZUnzB9yQxbI/qpujdH8oHZX99
    oLqHLJnfmZXnUmIChXXJA/phSzXKPeYcDtrpeQGv59fHtsQR2lnlrF2aO9Xw
X-ME-Proxy: <xmx:Ao3GaqQfrW3CGfcs68jJ0vMuwJEhaduhO_0nNXBnDEVllHVSo_PjZw>
    <xmx:Ao3GajmlCOha0FTT4VIfuI6gX3nA70cOPFl0griJDCQDfZRO8OBwpg>
    <xmx:Ao3Gag7v-KDAtyngCtyxKiPzGE3A2W6FJmr45_ACMsvmwmM0Rh_PoA>
    <xmx:Ao3Gapi4hilGqaMsS0035wkb9IQj-tPtOB8IgaPAOkou2TxmxqZFaA>
    <xmx:Ao3GamvA9IQXPh8-KaF0VS5ntAp0navyoiYV_2AHZDla32GQ5luDcVLg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Oct 2026 14:18:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: graysongordon-gl <graysongordon1@gmail.com>,  ps@pks.im,
  git@vger.kernel.org,  peff@peff.net,  avarab@gmail.com
Subject: Re: [PATCH v7] http: add http.sslVerifyStatus to check stapled OCSP
 responses
In-Reply-To: <arTUNYVvCNwX1pDp@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1bor?=
 =?utf-8?Q?=22's?= message of "Thu,
	24 Sep 2026 09:41:41 +0200")
References: <xmqqecfez7ie.fsf@gitster.g>
	<20260915162348.97792-1-ggordon@gitlab.com>
	<arQ/nOH+o3XwQFD/@szeder.dev> <xmqqwlsb63o9.fsf@gitster.g>
	<arTUNYVvCNwX1pDp@szeder.dev>
Date: Wed, 07 Oct 2026 11:18:40 -0700
Message-ID: <xmqq33uh8jcv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

SZEDER Gábor <szeder.dev@gmail.com> writes:

> On Wed, Sep 23, 2026 at 02:47:18PM -0700, Junio C Hamano wrote:
>> SZEDER Gábor <szeder.dev@gmail.com> writes:
>> 
>> > On Tue, Sep 15, 2026 at 12:23:48PM -0400, graysongordon-gl wrote:
>> >> From: Grayson Gordon <graysongordon1@gmail.com>
>> >> 
>> >> git never sets CURLOPT_SSL_VERIFYSTATUS, so libcurl never requests the
>> >> OCSP "Certificate Status Request" extension and any stapled response a
>> >> server sends is ignored, including responses that explicitly state the
>> >> certificate has been revoked.
>> > ...
>> > This patch was merged to 'next' the other day, and the last test in
>> > the new t5585 fails on my system.
>> 
>> Sorry about a premature merge.  Since we are not in a hurry to take
>> this topic in (or no new feature topic in general), let me revert it
>> out of 'next' and give it a clean slate to try again.
>
> Well, if you hadn't merged it, we would perhaps still be none the
> wiser, because, alas, I don't have the bandwidth to run tests on the
> seen branch regularly...
>
> However, CI does, but I can't seem to find any CI runs that failed
> because of this, which makes me worried that something is wrong on my
> end.

Well, I was bisecting between jch..seen, making a wishful assumption
that there is only one topic to blame the recent CI timeouts (see
[*1*] and [*2*] for examples) that many linux-* jobs spin forever
and time out after 6 hours, for the past few days.  I finally found
out that 'seen' with this topic ejected, even though it seems to
fail jobs that depend on older version of Ubuntu, does not exhibit
the time-out-after-spinning-for-6-hours symptom ([*3*]).

So tentatively I am ejecting it out of 'seen'.  It might be some
funny interactions with other topics; I haven't tried to push it
alone to see what happens there at CI to test.


[References]

*1* https://github.com/git/git/actions/runs/37377476653
*2* https://github.com/git/git/actions/runs/37568540157
*3* https://github.com/git/git/actions/runs/37662034989

