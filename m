Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4976E4438B
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 17:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753811644; cv=none; b=fydqmEb/lvXxJyDNdru4lFtjBvrx9IX0z8FaAkvA1I/j0DjeFonzrA3AORMnV9pJ6EldsWGCCzMljKUKbO4SdYw314p+Jw+3ubd7oU/s4scApiE18gi4/QmYc3QtbUCaF2CmGKOvtBwazok9IGOKmkaNJX5D+V8FnoWOcraeGK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753811644; c=relaxed/simple;
	bh=ENXZ85cajQ27uMLiNE4cmqMinWWhj69F4U3beNtH7Ns=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LFttDooSgRBWMkULogb4I7U2KqKywZZEobbKDnULBcuhnLnDg3Mml64qJltyfE+mKyFv89aU0j4niSFOsr3oAotfME+V+KZL1ts6iUZWbOOws0hWbTI/kRnjGhBpl2bP4Kdzv6rae5KLWym3/SCPB3dmof8zuojRH8DbCc4vTSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Iww2EtWl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hUpSNhnd; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Iww2EtWl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hUpSNhnd"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 3858B1D00B4D;
	Tue, 29 Jul 2025 13:54:01 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 29 Jul 2025 13:54:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753811641; x=1753898041; bh=oMWo6IktQB
	A9tiNCBP5OdmxgzvVFOr/KT75BIJbskv8=; b=Iww2EtWloB3G22tXZWYVVJvbDC
	ncCrGVLpQ8zQmxJcktzGOxUmJL8gRZ7gYUhtM61PSSNigWo/c1X/YBvEuZioKRwq
	steBT3tvSHo25u17f/k2TKb0Q4LL4+AX19t+pgQo07UISHnfHaq6ngpRkaeO9IQa
	ntEznEgk3n1iGzzXHBZSL7/DQP5m9fPZAJ0JYuviuAKoty0PjP2KUSXOYOkH2Vpd
	rETX3WBHcWaksjCTqNz7fmH5/gYgbVdH5wC5NlUX/fHLA3LtcWTMfGoAqA2LDNZb
	1+gW6bLjylG/jeNpDcPBA1ZAU+WmEHtyINTEAJXM0733iiz7nvZJnOl94QaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753811641; x=1753898041; bh=oMWo6IktQBA9tiNCBP5OdmxgzvVFOr/KT75
	BIJbskv8=; b=hUpSNhndG24f2N4i6NJoVye7Lz3FLvMT9fIPEDogMkteXW3dSE2
	ayHst5MUBA9TnwPkWcevmYpih7nSfk5KelbHYeheSYsspQ4PgNYFA3WArQKnz2+i
	/MWgyme0V7z6/bcYnVLQer0R9LzIfYBK/KJfWI8VhaHTW9q98DBOtt7kEiJKzY0d
	h/gWpb70fErEkAnxxdxBtt0jmeCtH7bjvA44ugexxUhXXv+nTcEfT2WnjMVpZoc7
	jgY7nqSVenPHSkz6DaDFVZf2UAOaF/IoeoOBGKEh2Aqh7K0bbLSpdUJnpmoqrvlm
	pOf5qbfqF4JqeYGBq9ZEdYj0Xdkb+e5YQeg==
X-ME-Sender: <xms:uAqJaIxA8GITu1SewxDmJEGI4yewhnbJ_WkPdEHe2EiSn3BCGnwUQA>
    <xme:uAqJaHzWa4YA9Klv09ik4X_gLkgbDEHGSeBVxn1-PNqsgLL38tUw_FLpEK2k3Ezmv
    iEEgAmHRIKelv_xaw>
X-ME-Received: <xmr:uAqJaAzljuZUisjWK_beApZ7LpPRndn8rjHzCCcfgU4NCsU3858WFWOadFeOhrDiSlGCa6T8F-p5HoAVWc8o6c0NNYUBgx8CVk1cgg8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelheejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegrhihurdgthhgrnhguvghkrghrsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhope
    hshhihrghmthhhrghkkhgrrhdttddusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:uAqJaBYLxlBA0yunJjSSZJl4z4I2zEhTlk_2JvxPPgiD-HvTiR7VKQ>
    <xmx:uAqJaBXWjKJfIqk2o-yaz9qd0VrLEhltadM2uf-MO9KCo6hi20SUTg>
    <xmx:uAqJaPhM46WuX3HEnqLViafIrI46P8oVFy998NyvjFWPNJCyvqR_lg>
    <xmx:uAqJaPvW_9TTJdbJx9-FZvbDsEgHGE_nGuez9KGuQ1ZDgKbA8DFAmA>
    <xmx:uQqJaAzEEkuqF6kW9252MSH5uIWmqkeoUSLLpHevHDerS75Tco4pDpHC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Jul 2025 13:54:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  shyamthakkar001@gmail.com
Subject: Re: [GSOC PATCH 1/2] environment: remove the global variable
 'merge_log_config'
In-Reply-To: <CAE7as+ZwiMENJDd6rjnF6w9tt_mJ=Kzf-t9U6VxAKmCdacOgbg@mail.gmail.com>
	(Ayush Chandekar's message of "Tue, 29 Jul 2025 23:00:39 +0530")
References: <cover.1753804956.git.ayu.chandekar@gmail.com>
	<c82620a1f54ea6760bff204fd2b5fe5c2df1896c.1753804956.git.ayu.chandekar@gmail.com>
	<xmqqfrefosdj.fsf@gitster.g>
	<CAE7as+ZwiMENJDd6rjnF6w9tt_mJ=Kzf-t9U6VxAKmCdacOgbg@mail.gmail.com>
Date: Tue, 29 Jul 2025 10:53:59 -0700
Message-ID: <xmqqbjp2q3wo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ayush Chandekar <ayu.chandekar@gmail.com> writes:

> I will mention this in the commit message, but do you think this
> behaviour is fine?

I cannot answer that one immediately after saying that I do not know
if this is a regression or an improvement.  

If you still pushed me to answer it immediately, you'd get my
default position, a conservative "any changes in behaviour caused by
an internal code clean-up is bad and is a serious regression" ;-).
