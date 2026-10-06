Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F13036CE19
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 16:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791302483; cv=none; b=IeYenBlvstJ0nPZ+WKk5HWYkcnJiNKooRBO/wRd5x/CcJjzwikr5s1zPGsdKGtX7qV43zGFu4vT/IF8vFCMkYsxfFwZORmArWnx/DtVwyf0wvZfrAGxl9kjRU2teySZb4GMEp6ck9DedAl9Ceu93tN6wnzQrpqm6OobOW7rK3KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791302483; c=relaxed/simple;
	bh=ceOCnWtRd6pqbRPbMkXFa3tniYF2d/UTP77a0XGAKDc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dkUJ0+Snrr0oslAC4srrEABmZHzeRuDJCnuHUyGr7RX2y8NeCGvTUfI4MK+oLcQ9sJ2ALxvjVQNiswza/RMB/A/Djpr0r6fkctE86pK7fLpKf1CrhChex/kG9tooYJBwBWFfr8DW++V3sCxQRI7Grvl4K9fNZmn+myHHfH9hMGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Tzr0zOMV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rmn0tMnP; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Tzr0zOMV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rmn0tMnP"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 52DC61400094
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 12:01:21 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Tue, 06 Oct 2026 12:01:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791302481; x=1791388881; bh=C1QJGAI1OS
	/xaftHRZNKDG84Y3h7Xm2b7FekVenM5+o=; b=Tzr0zOMVsgLw4r6Q45WJUuTnob
	PQKS3AMzL0rSgXyQIX3c8+RDDtmsI1JrCVllmuxnQZvUrfi9Ns9JGg3fTAVYr95e
	G45f8p+1pzxaDdosChN0cSYjecFGwav4Ir3HP/zJwO65G0KQYIYWSvB/DT/eYDOZ
	wiI3Qrce8uV6R85d43u7c5ZZo2q2IhcFCr5bQlIS5UpxjzMpEJKkxHmMu+nDFQBP
	0ZAHnAfbT0Tn4D4/CMlcIhO9qheSqD5Sx5IUK7LUixRj1XWHMV9Mfrh3UKxYz6wC
	fGgFNJYrrksu3i+xOjcbp2ekAZiy0RW/Y7RMAj3DRxhdTIS/le3ZWzys/LHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791302481; x=1791388881; bh=C1QJGAI1OS/xaftHRZNKDG84Y3h7Xm2b7Fe
	kVenM5+o=; b=rmn0tMnPMZ4EM4tHfmv2/ZABOvEiQ6v0tWQ7EaehkZgMbpV8Tgl
	t7bV/91Vt5/0NqzM/p1YtnDtYLfSy4c7zzpB1iHa8/Y5xXNJJqjA8aLdDsoSBopB
	03NyintQyrPFBnE4e6E5uxq3w9B4AuizsT6V9QDi+QCJ+L+dhwOOFpSU7Is5IXK7
	LANULWcmJkOzYk6e5wIJIK5Sm9c3yrggWrUIA22T1/9UQcJ6I0onr7Fw5pIiEPGz
	s3RshaLf3K7QX3fG4dNm9Icugr8BT+9y1yyLcIZEj5H2z1yG7yc0SRV4e7tsr9gU
	5g12HgYOeYixULgtaCAeGQtgsSvg3ujnrcA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791302481; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:fghAQemWBR6cUnTWn6owvCxlohoIoBagD592sIF6T6xeEkZ
	MQzUXpeA4Wgxgif2atCFLKYobLhLc6qQXuMiV0OfZOe+b8PYYWdhCI7D6X7X5xWo
	MQdOvVnEFIjv6Z1M1QuLFlPLxF4KZ4kg1CKKGLVtAUZAbogZGmIVK/HKuOOW5gTN
	RZ/nYv9itBbmPFjzr76iYH+SzMHt+9NmD53yWfU7sz7ETqv7ny0MtzQrMdeEixwr
	KWTiVDRBw5QLFmIfQ+p33/ZJtuWDI+rqDK8AyYBai+xMQP7Fv8lTXXTLTM0Whzlg
	Zm2kyJOlzUbzxvXOR29vHvBB0UtctTArBvkUuQQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:2Z9VfwESZozhkoCFNLWciteXwiLHZ2b3VkzVt/ebFRk=:ceOCnWtRd6pqbRPbMkXFa3tniYF2d/UTP77a0XGAKDc=;
X-ME-Sender: <xms:UBvFaoJWGN159VyLzIforoVrFsQLRqFSi8pk5g1LXHzL0I_e2Q2Rfg>
    <xme:UBvFavCHGpj7Z08U2ju-IWumpxbdiHM2Eabit96NCXkjj1-dEITM7Hoo9sYLeq4Ut
    OQtiM1IkCJtqenC1NRa6no-4QY-P3q9s51JyC68DVCqWA8jIYKXtA>
X-ME-Received: <xmr:UBvFahAUwK1rnFRfUQHGv6wQkYBe-Js_hLGbxZdm9x598sRna0YSxZ5GhomxQ6Qt0fezQjR2iDExYcIzFy4NJvoMPDN_W17g0MKM>
X-ME-Proxy-Cause: dmFkZTFMpg9LvOMDoLAkuoIwXtx9I1LDDTLOc8TLyEMTKAMML1v4VtCr2YoxwoA8z+7jvO
    K9KoJQGQ0rnk7jczEhDtuyzdMaBbz8Y3N26Z8v6EAl9vxFiqZzReviTdZurbWOjfzkeQEn
    SiXUyhZ1BIpNLzp3p0dTuLkgu8EJGS9eqi6MuL/IfV9n9Nt6v7EnROcCufw5fs6W1p1PVz
    tt9nOrq+pyG9gYdK/KIBORrUGrPgZemxPhiJ7C7cOlZX/DwvqR9uyx+otZp0KmteBYLO4Y
    VritiVFMQiKX8BZOhM7B3Rt9vRa0fbJKzkpsWJk+sQ2hQT2QUDSzizpeNdqmBawoD1ZOfN
    dH6XfP2hxWSATR4In2nmQbxDdTvbrwBxzlsPBgKpB0B2PG1iDUy7OFXlHcv+ZBx0xwOnPK
    VpiFyq9v51YjOUYVJEE4E3jj9DmiOfbFqzS9eTL0Ur52wl6Li0Q1nmqSMhxpelChG+k/rk
    gQrwuPrqgWsk1HMGEzs54eefG8N+m74n/7MT+YeI3HAf5X+P60EIDHGfKbMoer81lasQMd
    iF3FyufcJOwdnrdKmgiOT+nDOxycnaR+bFEUgJXXwBhME8wzwXnTE9FYFL38wsGJ6dfJHq
    3ouDr2T/LcJQNC/aZOX+j1HviqYs/p06TXs6k6ViY7NDeYoOSymFGdfpIlJg
X-ME-Proxy: <xmx:UBvFahAVMHEoTWGHeyl6S4z_ztmWJYXXU5cc0hAYntUpS-Yfl_09CQ>
    <xmx:UBvFasoUO-RI9m5JdtHo85jONFm209qY4fWHnRfoQpBRIoUufnAUFg>
    <xmx:UBvFarmvCZw1e5rFeXv57q9B368f2xxKcFMpun08DbFDcDt6sgNwSQ>
    <xmx:UBvFasxPxebvGiGvIeQXWtaecSWlFHPQSvP7-gYgELOc0jMnbj3-Tw>
    <xmx:URvFaiTo33aVY82RIX-j0NWIiM4jeso8odr1dqTNIEfJu9Sdv0eo66No>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Oct 2026 12:01:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Todd Zullinger <tmz@pobox.com>,  git@vger.kernel.org,  Francisco Boni
 <boboniboni@gmail.com>
Subject: Re: [PATCH] doc: add more examples of overriding LESS in core.pager
In-Reply-To: <asQ56mv3VbiYmtwk@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Mon, 5 Oct 2026 23:59:39 +0000")
References: <20260919163725.TExDduTp@teonanacatl.net>
	<20261002234203.4064847-1-tmz@pobox.com>
	<asQ56mv3VbiYmtwk@fruit.crustytoothpaste.net>
Date: Tue, 06 Oct 2026 09:01:19 -0700
Message-ID: <xmqq33uig6nk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2026-10-02 at 23:41:52, Todd Zullinger wrote:
>> +Another way to deactivate an option is prefixing `core.pager` with
>> +`LESS="RX"` to remove `-F` or `LESS=""` to override all options.
>> +This is useful if the `core.pager` command eventually runs `less` or
>> +a command which respects the `LESS` environment variable but lacks
>> +command line options to override `LESS` options.
>> ++
>> +One can specifically activate some flags for particular commands: for
>> +example, setting `pager.blame` to `less -S` enables line truncation
>> +only for `git blame`.
>
> Sure, this seems like an improvement.  I'm not very particular on the
> wording, but it's good that folks have the information that they need.

Thanks, both, for writing and reviewing.

Let me mark the topic for 'next'.
