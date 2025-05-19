Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67ED2676C9
	for <git@vger.kernel.org>; Mon, 19 May 2025 07:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747639095; cv=none; b=RJm4CVnYG6hay6pN/nIHCH7I8jOLyECuTdQ2vzq6Qyd/KKSs/FqzAcRXubBmpc1GAjyMmHPpucB5MmhNWMrtovLQC7b2oxiYh0uVzn85uZ9Fsj0TZCMHIKBgJjVTb2BmNVCGVzFok81FLwXldfITE9jiXKHVGJd/hV7Weck2r24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747639095; c=relaxed/simple;
	bh=QuSf0Ub8giAPalVTSUu1ZwOX5rd49h8yc893tZUDsyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvat0xVE7NS+M6++CTk9Sb9zQhO/OfhS4OHRHUD0cYpT+StmZ0oLp8yWxGMvuDWMjEtNtvDFPWG+Jt1Q/jqeKSf83CnOaAGUW/WOyQiogdLlJJjX18JDaf7DrMvkkJrLj3iBt1P5o+v6GGKQosJ15E0vJym+ZXkrzBdqr6eOCdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IqigA0Du; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QMeKI8cf; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IqigA0Du";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QMeKI8cf"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 92AE625400EF;
	Mon, 19 May 2025 03:18:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 19 May 2025 03:18:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747639092; x=1747725492; bh=5qUJPo/n5N
	wlU7MLhGX3ZSynqdEen+6TbiljcG8ZWHc=; b=IqigA0DuehdglNtFnXKHecP+hV
	/SR571knXfmqYnKRC7iJJD8/1Z6kb/0Cjp09qoN0SUs9b/6XkQGlEZiqc0Pa6zRA
	crvenxQymGnl7uQmHoE5VgODWDRDqxTpkKoGkPW3q/lgeGt9joziqxdo8iy0wdxQ
	F81NOjCyWkuKEf8lce+93QvDUmzBFKMOdz+PX3DM9aek2qQ1FiJGCf2didU3xHBO
	o/cCNs4JnERpri7rVy7JNC9/khFpekWRfvprRaJT9XrCBchlldtQvka8qaxwEoD3
	sY88NNIScsCZtOpwQ8QJaq+IEMOafVu9Phsd7l/a7PyYD2H79DgM3Og6c6uQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747639092; x=1747725492; bh=5qUJPo/n5NwlU7MLhGX3ZSynqdEen+6Tbil
	jcG8ZWHc=; b=QMeKI8cfYcISz2d4EN3aZij7HgngEW2S2Vk9KqI1lN3wJkLoGsC
	0X6cPT01KxWrxmQIMJ0DMuFxuma+bKPrQkXSUcHdUTze9k9GUmsuoL6kqdBQVVGv
	vzER8OBe87T+Uf8V4oo0nKhm5lbSJW7u4m/mIRhCOx7w7KltcIZQ11rDacXfIBOB
	/orYXB1ABbS7sD+/s4T72sujP8UZrXnAmFlD/ZuZm4nEPQKuC9zeAEJpAZP6dBAD
	YlqYynbqNI0qP0+ptypdlCHRzQ+uqwkcRlvWZIvkHXAdfdIW1NTEvDHRR4LMUmF1
	GkC+RJUN7DblAoxQCcguQgmoTE5gbnod76A==
X-ME-Sender: <xms:NNsqaPQJDFrla3kiwEkWnNdDhajGCXMs1wZmJUh4sD_ZBD_8MUpSWw>
    <xme:NNsqaAyR9zST-6LyR3-q_hn1nTagST5G-cuxZhKkUFdHc4ZGqlYl0QjyTxvxoaf4h
    D4SyEmsBZnIlptfVg>
X-ME-Received: <xmr:NNsqaE3iKRCBjs_sKnrnHMv4QVClVOHCgmF24Hq4eHnoEikUeK8Kd_oQ3zCNq0QWkJcfJdLxvUcwoy7uz2Wylc1qXfvAuCEw4_9kgCMyZPsg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvddtjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhgv
    jhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:NNsqaPD0BS1T10wDyfm4ykO_wLD-6w4yi2ltRKFIFmPR1vCkSFncHw>
    <xmx:NNsqaIiuHK9lI5YGkNaEoKyTvcRg1sNcTlKwNFUthx69VklEjyuTNg>
    <xmx:NNsqaDocS6pZaVE1kbGqlTkXfjDwybcw-ZnS5wJFwG0Vqh2tS78cDg>
    <xmx:NNsqaDiybMGqLuwqfAENLNcPMwxqODCpbYdPppfNSMlivPKZQlXtWA>
    <xmx:NNsqaMdD8uyWHtMCcwytGBwpjnTiN1SXzKGVO-Hv6ZufoYqp9e5hIzXd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 May 2025 03:18:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a530a6db (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 19 May 2025 07:18:10 +0000 (UTC)
Date: Mon, 19 May 2025 09:18:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 8/8] u-string-list: move "remove duplicates" test to
 "u-string-list.c"
Message-ID: <aCrbMeRgC1sdRm8O@pks.im>
References: <aCoDB9P5XV1lHMil@ArchLinux>
 <aCoDobl95P_VSaes@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCoDobl95P_VSaes@ArchLinux>

On Sun, May 18, 2025 at 11:58:25PM +0800, shejialuo wrote:
> We use "test-tool string-list remove_duplicates" to test the
> "string_list_remove_duplicates" function. As we have introduced the unit
> test, we'd better remove the logic from shell script to C program to
> improve test speed and readability.
> 
> As all the tests in shell script are removed, let's just delete the
> "t0063-string-list.sh" and update the "meson.build" file to align with
> this change.
> 
> Also we could simply remove "DISABLE_SIGN_COMPARE_WARNINGS" due to we
> have already deleted related code.

I think it would make sense to explain why the test helper itself isn't
being removed in this commit.

Patrick
