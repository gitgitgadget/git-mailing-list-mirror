Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847E81C695
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 07:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791876099; cv=none; b=pr5B5GSDekxvxyk8N1TjRCqUe9Pu7Y9TFgoa/xaHnBso/1Dbxt6JIihrjh78o5brgajdGEJf0lbC8L6h8J/MgeBYPvvNHGJbyCkPm6irDGUW3z5e3vVn+38BAHDL+3ueTKL1QhpOkpkjTq7JVt+fFfcf3xcH0ychqWtlWGJnwjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791876099; c=relaxed/simple;
	bh=S2Wm1SOf5RFUJgf8+3GlDyY9DyY88o2dYGsuzqRoN1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYIW1p9EEzzAX3mbSlHckIgM4WHba6bKGtBwqUAuxHFbaJJYZQT6TBW3j0sldzYxetpTcaXxqJmpvRP2qK1CkH/6lU6TdecemU5s7SLYUMTOLJ6xWZM5NHJVj9npaISUAyG4VcYyizWY5H5MQlOUUIDtSaqm2VuzQBAa6foNQ+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GT2ho5rx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r97LATLK; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GT2ho5rx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r97LATLK"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 93E92EC0265
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 03:21:36 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 13 Oct 2026 03:21:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791876096;
	 x=1791962496; bh=ZF5WJ/Cw49zYft0FIGeGsn7gqxYOhVI5ymhia9dR22E=; b=
	GT2ho5rxPI8M/nSmThoysF4VvXSnx7ct2nGKMpXErFZpdvBwF9BtX0oTGN2nr6eh
	1SJu9Chvghb4X1v6sa5d/odTQsqSRWuqXeBNgiOVuXqJ0aJs8vp/LP1sUJyny6Wf
	JJUpcLOx9A17+EqxFLAJ+2KR5fDTTHcSiaWIU4UEanHJcwFMKcJocP18UGYPDrEY
	crdxVRQnb6gxdtMEOC3bv0JemdBUjIjWaDPvEsFleY4zZF3zevKSHjxS/X3Yy82q
	2cN1ygDKVy3jfNPApLwKb4tplo5MUgjLhCQ9fsQgYnPvg3+PsG4UUyU/XGKWOeVu
	/FoZyeZ6fFZEb1ngWLKgHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791876096; x=
	1791962496; bh=ZF5WJ/Cw49zYft0FIGeGsn7gqxYOhVI5ymhia9dR22E=; b=r
	97LATLKToy0qulGS0CWCIqBzdeO0Lcnsr5hEuMdI04g/zC8YCHnV33WToQfIPVDF
	EIhJgBCpvJKnblEZ4qHieQJdMiuZ7i8Ab4Di/6kRiEo+VFMJjwepsEDdzLTxBmzy
	gzAS3IMaHkmyaf3t0hDUupo4Vtbqef6adHKepMfQ5B3BPPBYTJIkv7RreZwqNIDe
	UA6bo5wj9bbz2qwYLH3glaQcNS8RBy06SK9YsGcpo2QbL3xHuwBT3kzCAP7zkS3F
	o4cpAR367IlMxakoU3H8QIvRZrwXNt1s2NBtTN5tez4xaUCfuYdxNpe2PD445tSu
	NcuB5Hp1Fh8dS6NUrnUCw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791876096; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:nWfbLWe66n5pssh8Wb20ZoaD6bsLsQQPyPaidHcXXic9JQw
	u4q7eKlKROKwfxifCOAALrZG2yr1LxezbsDKVFBtCCDzTHvY49QKltTlru7KKVRQ
	yCyXpYVsxaM0GA1940nE/tBRhTR7zIjMZ6vtukc1alHmoq5zEF1MkRB3/utNAtzK
	kSK0V9xaoNtqHieTtXvTm06pyzGNaLg1Egng7hNNuyOnG/g+UTF3yyptVfF0kmIn
	+W+3nVgYiUROS4xt1fKu2P/BYTVuCsT/ZS7bl5GWbVbCGy5d0uziPmCUevuhK8ln
	NWvcUlswl/UC4PkLZCmjzG9mpDf/w1rvbAjosSw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:kaHz1F0EKrACR8KtpXy5HraaCnUJHfYErG1nU2ePDg0=:S2Wm1SOf5RFUJgf8+3GlDyY9DyY88o2dYGsuzqRoN1U=;
X-ME-Sender: <xms:ANzNao-d2_qhIWCdt8s4F2BX69P98wfcBU4WLzQQOeZdtiofUE0iaQ>
    <xme:ANzNanl2EXw7DGllP2FmR90NebmhQywnT91JAks6qRiKTeuTQTWYgFqaHVP0TJf3-
    zXl0PlkO54x2s06t4-vAa16embfS15rQM-wZxsU9IXMCtGBmbpZ-MY>
X-ME-Received: <xmr:ANzNamW6fkwChRa7QxEKC14TLDia1VrzNj87Nzm6-pRbS3wakBlDIQ>
X-ME-Proxy-Cause: dmFkZTEJyMzfHzBbm5XSSBsF7NbC4X3LERGpBrAbOen36lVZySPzB40LYgvhj62y1cAxSV
    kswh2wXDu8p4wl5QxPIt56tduvJadJjAExXHeAdpSUt1Yf6szgwb+k50/a/tAh8qZ3+l/f
    bxAG9KjO0j92Sr4eAOkTlRISrlkGDwhrSJYspG333DsNknWcfanJ31pFNBTH4cOMrkGN81
    ZciWBdeGXF7aopOvg3JuVcFIZ9yVqDFHMXmUOY81TbJ3iQyduopdwwy49+N01XzjccKEtQ
    jpN+jmCJV8+qaiLltRP5REUxFLluXVpElVpmbt9kUj3mUlJTWU7pl0bC8ywAuCp7hhVpnD
    WDQTdMY5dbh5tBoln32dPp1/XE3SPsYX6Xezl4ipuekiOpzCpXRaGUzqqs0HuHWPZQki3E
    Sb9al/k1HmCCdcVEG+kpbvtEmU4hLP5koy/eSJpXAiOvk7uhBndCT1XNMdH7tOkV/hUsl9
    6UHdNn82Rrhn8wziNwH+Auh6F15rveZauRapqOS/h1iPFmrDLYfUo/0/MzTk9kDybWgNPO
    9x+L7JPpDVqD7NcbOGhB5NjtJ1YbB3fXJNF/XUguOLgxEy33kGQfFqVeXbvkxI8+afRag+
    L0ng4e0XIC9dVFPRm8cqSJYIRTOMo9I7Y8VRIS7v/HCBp9MkVbeer6TQ2z4Q
X-ME-Proxy: <xmx:ANzNakFFKV7hGIlkg9YAm7FG6YeHQQShGlp-ORQ3TSiO_ss5OGrSQQ>
    <xmx:ANzNaqefzJam029aXQZ1xlNf-fGJUIrvP62JnmFlZFEmcHK7x2wemg>
    <xmx:ANzNatJdgBAuITBbIB3o2CSFEfkgFXfQ8UYLOw33YiLtlWbbQPIn9g>
    <xmx:ANzNanHmw0oywJHkgM2_BL10R7hEy45lOoAR64reboLJWm2hZFWspA>
    <xmx:ANzNaqlpOOzLDvszEpqhXIS-yAU9NvWtz4vbXDX7mQyWs-Y8uvLU1BqH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 03:21:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7757c3ae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Oct 2026 07:21:33 +0000 (UTC)
Date: Tue, 13 Oct 2026 09:21:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH v2 5/8] ci: rename linux-TEST-vars job
Message-ID: <as3b-u7SzE3uPwQx@pks.im>
References: <20261009-pks-ci-housekeeping-v2-0-6863d58ef691@pks.im>
 <20261009-pks-ci-housekeeping-v2-5-6863d58ef691@pks.im>
 <askI1DGldZx8ElIN@szeder.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <askI1DGldZx8ElIN@szeder.dev>

On Fri, Oct 09, 2026 at 05:31:32PM +0200, SZEDER Gábor wrote:
> On Fri, Oct 09, 2026 at 01:32:02PM +0200, Patrick Steinhardt wrote:
> > The "linux-TEST-vars" job exercises Git with a bunch of non-default
> > options enabled. The name of that job makes you want to cry though due
> > to the weird upper-casing
> 
> Yeah, it's an eyesore indeed.
> 
> > and because it doesn't really tell you what it
> > even intends to do.
> 
> It intends to set a bunch of GIT_TEST_* variables, and since it has
> test vars in its name, I'd say that it does a decent job at conveying
> its intentions.

That only tells you anything in case you evne know about the GIT_TEST
variariables, but doesn't really give you much of an idea what the
intent of that job is. But...

> > Rename the job to "linux-exotic" instead.
> 
> Seeing "linux-exotic", I would think of a job running tests on an
> exotic Linux distro, or on an exotic platform...  but it wouldn't
> occur to me that it intends to set a bunch of GIT_TEST_* variables,
> simply because there is nothing in its name to indicate that.
> 
> I think this patch makes things worse.

... I think it's still a fair point. The question is whether we can come
up with a better name then that is not an eyesore and that gives you a
clue what the job is doing without you having to know about the
underlying mechanism.

A couple of names that come to my mind would be "linux-nondefault",
"linux-optional-features"... and not much else. Do you have any
suggestions?

Thanks!

Patrick
