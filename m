Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E041F393DDB
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 08:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784278338; cv=none; b=SVHmWvjctIXEEBPDZ0+8raE7McmhNjHFttcw9aONSRrWGp6NX5YP5teXlvXr9ZWpc8wmcJXsvptt+yuKIELvT9QwCsMwp5uAxaucZsyZlxLMlyziHr4bQcBhUN1rgLpVopc9lqCtktGNkYGAYKdVQ/mlAXCa6FlENFKU27ggIts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784278338; c=relaxed/simple;
	bh=PjUO1k7uDackg/IlezpHYLqnxIE2VRzRaAl5XGiPoQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxAHfAzakYlJ5lkY06ddqOuWzNBbx14kkovkshRQJyx6U4ap9ocaAOvqm0rxodjmeVyutEn0zIbzMKknEIzvRNGeU9puazguCpqfApj1+H2Og5MerW9NCjNgHD2KDdi1EIwBUQqNHX6q3H7U9mD4XHFjK9+I7+3lhV5W3RE+qDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ARnuTzU2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L0acNA5Q; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ARnuTzU2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L0acNA5Q"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 234477A00AC;
	Fri, 17 Jul 2026 04:52:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 17 Jul 2026 04:52:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784278335;
	 x=1784364735; bh=PjUO1k7uDackg/IlezpHYLqnxIE2VRzRaAl5XGiPoQ0=; b=
	ARnuTzU2BuvhUdzN5saG/fAfpJd1VwgpSqn3yzgR53c6EjbVHtVVksqGk4DtrzLo
	kBU7FKL1dHisN0KV8ErdK1dd4Tq4o3znH0KoqfGx/GRHJdq3OveLMvm92DB0YTYG
	p0zKuOfPIWJI1vzkizjnONNun5b5V2aqXdOuNdQo1D+ttTnTo6N487Pivl1S2CL3
	yiVnbAuqgF/sqQnbla8YWO7DfXxKYIbxutpyfP/L8h6Ka6QdtZnIw1zQ2X4yX5dO
	zCeWN+StIyLoiT21lETNvL2QY7+BaivPY0ajEhoT2FIfRO09hx4iJF02IsMpmN03
	EHFu3lBaen4rb5Vg85RkYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784278335; x=
	1784364735; bh=PjUO1k7uDackg/IlezpHYLqnxIE2VRzRaAl5XGiPoQ0=; b=L
	0acNA5QEFQ3g57166WYqz5LKFVDZkkTVvav5rxkD4McVpoYq95xYByP6vpnb6y6S
	wQApiqPDIvNhxU2F6HhGBln/gQdd7R6qDH5lcQdrf/GzRe8M9y192N6PLvzfyqJ+
	421dBea6TzQ55+Yf/QvyolNyOxKqKPn6VP/v6FrxqeSVfu2fT1kRzyRzUCITHCQ0
	NCMGZJa0/xl4fOtXYa4YYiHbjF/xmAVC8+J/umAGzZvqgapxNpI0lHH09AzonmGa
	Ddgt1fgt4wDOk84gNFlVfKJ61CCiT7gFJv10elG7W3pLB0xcShlAYZkaBGlmi+71
	YAioTVsIzcQUDXBjq8/Lg==
X-ME-Sender: <xms:P-1ZajQkeLivgkEOQCgXom9-7BHVrNyOry-DGFCoMSuqNLoTbrfzKA>
    <xme:P-1ZasMZcKWatYFZEmxB4RTzJBhX6UDjgw-iOWTCMr0C_vAcBdnmg-VY8x3YN5787
    VAymZkUUdTz_EyZMMYTFU2LoxTzr1pzwSPSKV7yHkXomUQdmnr3>
X-ME-Received: <xmr:P-1ZamMyIjY5-5dWOFiX26r7UhrCZI5vH1kITnLWeypRzdEOrNtkg6rqYVhQUm581LmTCc1xNlDon7nKpuyTC8c4cSZLlo55zz_iH39x7QU>
X-ME-Proxy-Cause: dmFkZTFR67wIySSZqoPi7TByp6rHdtUMg0NDa5Q5dtdCwjlvrlZ4KlWG0JK283nZxQxETL
    RTppaBEm3Y+hnn2c/hHyEuhe/mQ1kHw0DK8JDgHa2Z2YCJdW9dWlfL3Vqt+hDuV9P3Un34
    MGEoDyDrfhAFY4KWME5pYpy9LuZjmnQnKWGJKRb/m7FPS5ZumwZ8HdvTBs6rxf8toOPKGV
    1WkcHZO/Mtj00NmMdVSHEaG4LnDb2HMulo3p2gIIJOg0Uinnh2nvxCt+E5JoAH4eDUUk26
    zTSXsWpym8/V1tJdPYC2s3lH3FbyJj/2INkwJvkC8bfa0DdB4/Kl2uB4rBkvq769a2STWv
    QeJ8nT8ZOFmCiqIYoSr0EP7ePclwR1ew6R2yjiVZWgbJLxYr19tMB8F0FvjWhocbRgtL7v
    KdDSYhApbN1P2kkOXtPK9Tz1+ZNIbpnWCuU45lNPztUbB06l1mgGUyjB9ClF7C0953N/lN
    S4szOu7A5G5qsHf3bJPvBswIUEsUMZtONDgNqbqZgIBB/ZHRw6emGH9ZPx/WueS+K4fa80
    JhDYMTnzei56t1dw9HYRc6bSldduAFnrDtg2r3kmZID/ydQMNg5g2iet+d/szIboRv1LHb
    YAtI5uc/NoPaZmeWjOE8A8W4glcNQm0FeTQv/vjXEkRMgFeL3zaxnTCPY01w
X-ME-Proxy: <xmx:P-1Zasvp4vv9IvOi24LQXoFN_Cjz7oebnLtgQhK2kkFF_Tmee9q1Kw>
    <xmx:P-1ZagVpLxl9cmuNXkL08CEo5H6HRWkvJqcms7qUT9bbokpOKEG5nA>
    <xmx:P-1Zaku2t4KgSR4onehJ2J8G3kAE5rLCKqGX73xyUWysqfgQB_YRqQ>
    <xmx:P-1ZasUJ9zoRZG3ikg0WCXlH0DHP1Dgloo3WON7PguNTY7t_1nC-ow>
    <xmx:P-1ZasN1c8GWTn77DVjRtvWCSMS3f6nayAoy9-n01KiR5fCLj5gZJr6u>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 04:52:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 76079606 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 Jul 2026 08:52:14 +0000 (UTC)
Date: Fri, 17 Jul 2026 10:52:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
Cc: gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH v7] show-branch: convert per-branch flags to commit-slab
Message-ID: <alntPJy2VwVK75qj@pks.im>
References: <xmqqfr1i6tqu.fsf@gitster.g>
 <20260717074208.61303-1-gatlavishweshwarreddy26@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260717074208.61303-1-gatlavishweshwarreddy26@gmail.com>

On Fri, Jul 17, 2026 at 01:12:06PM +0530, Gatla Vishweshwar Reddy wrote:
> Thank you very much for the thorough and insightful review —
> the performance observation about subset checking and the
> suggestion to remove MAX_REVS entirely were both excellent
> points that significantly improve this patch.

Sorry, but are we merely chatting with an AI or is there a human
anywhere between us and the prompt? I feel like this thread is becoming
a waste of time.

Patrick
