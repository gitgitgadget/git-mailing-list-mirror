Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41853DD51C
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 09:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785405048; cv=none; b=nxlv/GO6te7jyR3gC92+lSC1qt8+sjMOC4jCef+umED+FQkJ34ygLjJ0C2Va89Wgkd77qFauvhqPwr2BkwHrXZ5DZSRVcnqMa6mvlnfLf6LRM6AlDFJhz/Rq53I+Ynhd4NldElcOUmac+C3Gv6AnGWZCf7YuHL7Ej79Su7zAvXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785405048; c=relaxed/simple;
	bh=fUuilwLWcfe4dNoUL0NliRe7IEljl1gWAIxymbospdI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=GINWlbaItFnLC/0BKwvxN3FdGtrelJhnVsV3heZ+4i8s+gjBhHLSMyp/P8893HwSysvWVGcTb9UUCNxL33NqwyKNk6S6Yg9LgfpIulVBYtMLBkd2bru3OvMTOF9mHRnpMhn6g39XLW97ydKjYEo5FLr6TRVk3Ykd6P2S8GXkrHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=qahZs6/l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B4N5QAww; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="qahZs6/l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B4N5QAww"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 134DC1D0011D;
	Thu, 30 Jul 2026 05:50:46 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Thu, 30 Jul 2026 05:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785405045;
	 x=1785491445; bh=g27KkoHY8BHq3lQGlMT3w+GpWdCyRgjE/Inx+zklb8c=; b=
	qahZs6/lbfutHkvbtZ1Bovii2lfbY2V2R9ZiZnKS2rXPiYtW0lpSMTv1FbJ/XZhf
	bdjmynzsH3bn18kRm7qH2LrHd3J4P+ITEKGFCEHz9QqaBm9ECNWJ39uBlbLQR5z1
	ssirTx9jDFlGABs/oEc1V93evZQ1XlKba/KVZY48MVTiKdTT4sfxEp4Uilry7Dcv
	ivDggn3SoZ406fKJDDSQXRA4/YlX04BwuS55GD3hvxSRViGPMat+kHsTLMZvImY0
	5m6dfasYZDqvfnIPnLnDbFTq25gYbFmIUq0ZPZVMyKPfmDbwR75PhEsSPQyKLnmr
	lRwAD2afu0d40pbYjeZfGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785405045; x=
	1785491445; bh=g27KkoHY8BHq3lQGlMT3w+GpWdCyRgjE/Inx+zklb8c=; b=B
	4N5QAwwNLRChK7nOxrFI5yoSGp9jbj1uRUWhEJ+lCFrHqgtNRGWdOjrst4uEAnJ6
	s0FmRmkjQ+FjphYR4VoclbfOsqmvzJMQYRh1Q31vn4YL+cgrefdEcpfGtfmGUnZp
	oaVes7u52VrA7eK9QX2E0ZjUztBstxFHqApKkKkAw5/Xbd6jRIq6xEI/rUbA4EkZ
	10oQY8X3haHVeuimXglCNymoNylGa+1tzFK+/c4HQj6EdMHfDY10UGiGqHiqu/nb
	hCViigmPVnDjx5c6LLxjfgCCJ3BPixyaZ+1EM5HCrQjgcZkgPHUpOpTHZlYtoHbs
	2v+uJnbdqlIR3k8dyE5/Q==
X-ME-Sender: <xms:dR5raps241oplQ_o0slpvbmPEZwn4yFpFq6FMgDUYUqEs4PWwJ0Y7fg>
    <xme:dR5ratRVQHIiI1725BbRZ5u2r4bCnIQmuejvdSH1PwdUH3_1CXqyk7YMAHhpUJoaq
    IT-0fohhEqDM9s9Qwe6LrGDiLlScux6u-6GJ9_qSF9b7ie3WjsByA>
X-ME-Proxy-Cause: dmFkZTF7pQB11PI+VnYLtUOKG6NaNcbXBSyiFFAfU9BMnt+oXJBzpP6AtbtBG8VHj2q7fY
    dYhXNdjuO0Kie2MCHiCU3N9UtyPiBER5fOjsribspJeqQNtO6DW0914N1n4iAX+kOm/L1y
    91REoHTvanM4fcWD39a10t5oR6eUozBR+ekViq/i+rtwz8OnbaNU4OmfaBAcMavJIuTCSz
    Qv071v84RSHsm3gLsSuJ58xIpfk7/drdXryzXGJvgXk+axGlh15Vu8lnirERmJiDUrYk3c
    TWp3Mz2pvbjTIn3CP2kRir2LenHNHGIKNznLMqDuCK3y9LF0b3Ty2N0/0TavvVaBBDsBqt
    aoMvbOvYtoV7pSlU6hET1FiK++swrp8zFZJdZaxBa0XrcTg0HwXjValPRqvOTmRPqZ+fMz
    Qx5ViexMYqAL/gkyghetvrtI0TAqCSdWYHdHAbY7xlGZgdOPINSQ1P4nwT/jZ46dB8qXb1
    SHPAMQ6GUwPn/tOazhN2gL2S+sG065m/51nlFaj8zzpS4YEtKzp9jmu+MnU24V5FDhTXLq
    MoKlvhwJWAmzr5JE4ZzjEkgwgQH0OGyVh9B21WfpEXuc2Bhch8gJrQlBrmuvqyEYBKywA4
    i17w/wJPafxyGBFypteafscz+i7o7AsL5WZF6KsKz4tYP6UPxxGPQsq7x4tg
X-ME-Proxy: <xmx:dR5rajYN6Uslv3KRKTQEiMry4OjneALahpY9HbFnQNaEtCodyL0IoQ>
    <xmx:dR5raruTzpn88AbShyhUuPeACnDmMNfVvsznzVPjcw9Zx_-6btUYhw>
    <xmx:dR5ratO3iNYJAFQUrnVn8tmElfUSr6Rmx5GLzLb3_TEBCMtxtQ6zxA>
    <xmx:dR5raq71ES0MCeo-20DYNp16ykCcGtmGXdqHkuvpXRQN2WuBAN79fw>
    <xmx:dR5raqpwFggQDZThbGzNrY5bqLJ6WdzRIg4j915CZaHA6zPt2L6t18DZ>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3AC0B3020073; Thu, 30 Jul 2026 05:50:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AQZrh2uv-G2V
Date: Thu, 30 Jul 2026 11:50:24 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Toon Claes" <toon@iotcl.com>, "Junio C Hamano" <gitster@pobox.com>
Cc: "Kristoffer Haugsbakk" <code@khaugsbakk.name>,
 "Siddharth Asthana" <siddharthasthana31@gmail.com>, git@vger.kernel.org,
 "Patrick Steinhardt" <ps@pks.im>
Message-Id: <e3bafdc5-2ec8-4023-bd78-46017273c40b@app.fastmail.com>
In-Reply-To: <87cxwxofgv.fsf@emacs.iotcl.com>
References: <V2_CV_doc_replay_config.767@msgid.xyz>
 <V3_CV_doc_replay_config.780@msgid.xyz>
 <V3_doc_replay_improve_config.782@msgid.xyz> <87cxwxofgv.fsf@emacs.iotcl.com>
Subject: Re: [PATCH v3 2/4] doc: replay: improve config description
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026, at 14:04, Toon Claes wrote:
>>[snip]
>> -This setting can be overridden with the `--ref-action` command-line =
option.
>> -When not configured, `git replay` defaults to `update` mode.
>> +ifdef::git-replay[]
>> +See `--ref-action`.
>> +endif::git-replay[]
>> +ifndef::git-replay[]
>> +See `--ref-action` for linkgit:git-replay[1] for details.
>
> I'm not sure about using "for" twice, how about:
>
>     See `--ref-action` in linkgit:git-replay[1] for details.

That=E2=80=99s excellent. I=E2=80=99ll use it.

Thanks for taking a look!

>
>> +endif::git-replay[]
>> diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay=
.adoc
>> index f9ca2db2833..4de85088d6c 100644
>> --- a/Documentation/git-replay.adoc
>> +++ b/Documentation/git-replay.adoc
>> @@ -211,6 +211,7 @@ to use bare commit IDs instead of branch names.
>>[snip]
