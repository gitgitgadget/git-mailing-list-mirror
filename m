Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311653264FB
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 18:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784054038; cv=none; b=YU5D50VnLk9K2lcg2sMTSZUotEnJJK+d9gOzJMlIyfHNLQbBvCih6td4uLImk/2r/Wqzx6W/SzcNmObpnaMsf10DuMtDRdGvIjs52qQxNZX/NRa/rGeIYEnViWxovBu1O5rikqa0nxoO0EohxFlj6a+FWr9T6yya4r2fqXm/gtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784054038; c=relaxed/simple;
	bh=BGb43MaVKWCicfMtLX57eTnBSsy9LMhSPGGAeXb/ry0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fgaktErPUMj/mre8gM8d7bZIJnP8IHdPnPIFSTvp6TiX9FE52KnrPk/lzvnf90N4pe6RA/DR88EKAaeQwcMijaTnVxauGRpP8fD99zgNE41G3RJkbGqYY59gy/laRd+VKz5aL5TIa36ErVuigY8UiDZXGDE8yGEKky8ZLXrLZt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KD2hQejX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WIV/yV7K; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KD2hQejX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WIV/yV7K"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 4DF88EC01ED;
	Tue, 14 Jul 2026 14:33:56 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 14 Jul 2026 14:33:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784054036; x=1784140436; bh=fX0LdKslYb
	JX2acQjmvTDOHZ++FwspEVAgcDL2VzP6M=; b=KD2hQejXdcbC0KlI5ZjZufJjD2
	fI149dac3WIH6boHRVu+5KaOavJjjebgx8wLnPJJSe7KiiittvA74U8ivC9OS/Cy
	Gehoy+UZxiuVmcg0ePlZwkHoBkGnTkrynowbNR91tzQ0FA/rqM4malXJYkdRasa0
	ccBocN9LvTTTtm+rOMW9uXIk2TlyCt6QCM/hA/lNLKnNRbXx7UwiH3+5ulBnIfkC
	byQcLkNfBUT4RsufZHQBHLeq5a8JfoADizBHLE3O30qs2+s4vH3f8Wi/Os0MNGFF
	XdFbSIpHqO9fTdTUoHm1wG9rqXvgvNZxqnMHnBNxAM3ijpBG9xwm+VQzqFPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784054036; x=1784140436; bh=fX0LdKslYbJX2acQjmvTDOHZ++FwspEVAgc
	DL2VzP6M=; b=WIV/yV7KQarYaY/xFUupGb/seeEOlUKYNh8OD3UgpKCUtv7UaEv
	MhHbzR3nEj8ZXhmNR+S3KmS9258LhCRQL0Gmq4w4qd61pj4Y9g6VadWzYVUIZxA6
	eh9p3wZzJCzJgz+ZWcqPMS5c3P5fybuzZVpRmr86AR8mHkznbi/H9+bH4BOqpu+S
	MSTZ679JVzNnhuQiwaxzaP2eFTYoLoSBV5fojNu+CFVN3IXhlV+SN1iDaw1W0WlW
	UV+MqAwsM9MCSEAMCGRiKNaneY/buzPSzai8k7kEpN5GWwPhWxLG5mVr2jCr+Y6X
	7SS/G9hT9D+amW49wY0pTrXjmFdEFJ/Cm5Q==
X-ME-Sender: <xms:E4FWavJd0IAok2Ox9STvF5sM7ZWzBfrWcVm3IYnQo4_98CbI4cwoEw>
    <xme:E4FWavtSA_zDB6sRkzrzayVk_u1xPsoxhghw5FseZL7jMrrmT-81jn99X2b5usqPv
    RX1htR2OHzjgM6bas6pJ5wcUTQKymd7AEnXMgqqfyvJqhXPzVEJXA>
X-ME-Received: <xmr:E4FWasIPAue1yFw2S6CFHMLj91mvWdTwsFOqFxEAPi4DlMEJQTlqJLbcOMdq05XMXa5RDl5q7a9ao1LMxeG9IgOdXqxjc2trmX4j1oQ>
X-ME-Proxy-Cause: dmFkZTGN1KCLDcciECrP0OOtDtoktsqrzkHvfFngSscYdjgs5L047vM1VApZkqdFKiaEY3
    gJBaF7iKMhgA/6RZgqgMAdb0QLNEPUQBwDgJ0uJEJwVhfFaAFa7upL4XtIIbetJ1u0EZzn
    54yuCH2pplyoHPQjPfSbb4La+iI3+Kf9RJKwfQkHMvCuW7qBwEpEfoHm05ARZoP6Y2mA5E
    0u4R8vb9EtFMUVtJh7cXnj6Qbz6/OAsDZVC4KThLgWIXA32VQL7F6vwSWkYkV1XkC3Vlh7
    ysvWUqlOBX6Fa6zISh/c9QqTePIHno7Xp3fPfFskqqjyuLruC8BgHZA63ug+5LWeoOK/Np
    6Vku1l93Tgb5zAAmogt0c74bskYrU4g1xGqZTBAXS07efLvZacMIgxjJRTp4+Lu5SW+Gf1
    x+GYoDE+4RLHxaPcCwAbZPl3DbyRiQDjp6tEGN88YjTZ37CMf89xctnfAejbNZEc8pgC/i
    mTQgkzdZ97CalN7b+Vzz+U9dpldaRv1efYzO28ztgKw+lPTtQBJvDpuxRxscPrXUoZSl4b
    CHA7LadTRvfkJ1OMijK7354JF3MiuLdsDaf3z3fR+VCNzRVEJwJhCkXBLXLFbw1CRhGjYG
    0Yr358K0iBYk+GPGMqc+TZ7DNkVU6R6t6c/zzfz7o9dSykQ9qZ+DLiiSHZ1A
X-ME-Proxy: <xmx:E4FWavMCVinGfllhUiT_JuX7ZMmbLj2lkfabkuMrilUGQsYXysaa-g>
    <xmx:E4FWanVrZ65Tav4DAN54R22jdzMJbYzlQBhKzvInWSUaOc0rWxfrIw>
    <xmx:E4FWallWcovL3LeZ0hopFyLRtwL5k_orY28L7XR_A634wFXoOg7yOg>
    <xmx:E4FWauMiD3XVnCj_0ZIAUQasjRkfo2QYkaZ9q1tFQpuIR45VAWbfbg>
    <xmx:FIFWaqSB7dvmYtfaUS-bWuv54OZT9lrAaIaVUnGgvjvEZNiE-m_o3LK7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jul 2026 14:33:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: chandrapratap3519@gmail.com,  chriscool@tuxfamily.org,
  eric.peijian@gmail.com,  git@vger.kernel.org,  jltobler@gmail.com,
  karthik.188@gmail.com,  peff@peff.net,  toon@iotcl.com
Subject: Re: [PATCH GSoC v17 00/13] cat-file: add remote-object-info to
 batch-command
In-Reply-To: <20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
	(Pablo Sabater's message of "Tue, 14 Jul 2026 13:44:56 +0200")
References: <20260710-ps-eric-work-rebase-v16-0-66e07b58a8fe@gmail.com>
	<20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
Date: Tue, 14 Jul 2026 11:33:54 -0700
Message-ID: <xmqq8q7dto8d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> This patch series is a continuation of Eric Ju's
> (eric.peijian@gmail.com) and Calvin Wan's (calvinwan@google.com) patch
> series [1] and [2] respectively.

Yuck.  I thought we had this marked as "Will merge to 'next'?" for
some time and this morning I pushed out a merge to 'next' of v16.
I'll revert the merge and replace.
