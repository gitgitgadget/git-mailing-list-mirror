Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FA337B01E
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 07:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790581757; cv=none; b=OGxSJMc5TRIqKxRXLyT9uqLX0E0JsrMxrr3yulaBIMy7Ku+9KRj+aScR1IFi4jIWndPwkV32mQc7BP3U9yFPtd5qgJo+XlC2fUGotaVB8W9zgB5sK1bhlu9GA/CFm/WGH2pv4/auXZelLwvpSCRXHkSbq3ocUxiUzTHJ1FQkeqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790581757; c=relaxed/simple;
	bh=/qIW1rqTVlEFJofohmljBOXQMkjctza4eGM06b9XCM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vmw3HgTSdahmogMAUTuS1LLUUVMHtknh5Mf8T8X796q/GNF0VNG5QdVzjHolDQpFaxvhUy/6TEkbvnydpOGpBVx7B1W0ddEl/nL5HValHHXKMqn/BSile4uptNlGJvITgj+ThmIa7TYYzBynkR7Ior0g/58t+MgRSmBVwTyJ2so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B1wfIPRw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Un9f5heU; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B1wfIPRw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Un9f5heU"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2530E14000A9;
	Mon, 28 Sep 2026 03:49:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 28 Sep 2026 03:49:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790581755; x=1790668155; bh=L9Uml7nrmR
	ddaBJ7tgJ/C/YBtV0SgqG2G40xH87NGX8=; b=B1wfIPRwPr8gUmcaFLYLBodE0q
	kQKZ1E/J1KbYOTVlntDYx0TWgIS6G7+62x0+qm/bzxnbC+bekFhb6NtxX7MnVr4a
	U3jiEXJT/UA5ngfg8ef+XrZfowrECVJ1xEbR5j3tZfea3xijjBHdo/3K55lZa32O
	N5Qeo8+ynYkgj5s2z7wUkyei4J6uSMLvd0jKy4UnIRs2RjLE79kJJXUzT/tZOcgz
	PyZ6b5vY58R5wXxeI62+He5OzeEkin8+DhwjBF3yg6itgcaDoUOYEz4u3HUbtmpr
	jw1z4b/XaRgIgvC0NJdLJfnZbe52Rwv0di7wnP0V5Cv+ghtnB4uxb3yu64MQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790581755; x=1790668155; bh=L9Uml7nrmRddaBJ7tgJ/C/YBtV0SgqG2G40
	xH87NGX8=; b=Un9f5heUV+800o/v46vyKPc1uiFmAkFYElphG+/FMGoSMvGPc28
	bxRrebTmv18UJAxkbebhY0w/oTXWuk3VGcFIEbrpSULeKpT2LmCM6P0bqyUN2DXO
	IkauPl47O8Y1QVVPm0RUXAIvmdKmYuRHSpmM4CyvR32bSR/iW2EZBrsMdg37AzHE
	81QqpppVLvwwhdY3z0R6LDA5jTNcT3Qnfn8c8iPwcPz1OHCe5Et3okYG1w1YCywG
	Q0evU63CYSrNIz2Xx7Zwe0XyqbFMO+yRMlWsYECiHwTHM8MjP71DcvXOojt0TTdg
	l1i31k9m12LPWYF/NG0rreNDg3LtW6mioZQ==
X-ME-Sender: <xms:-hu6an9YZZa_Rx0mr9QFiu7pLfw1vOC1HhemCsLSzDdmF1CU-9bklg>
    <xme:-hu6akY2bFxBypXp573Up-uJ3p8EmAS6TIkj_crpLXhWS5yFc6NkV293g2GcqOMuq
    mreJY3iT0g_7ewoqN5bS37xS_YE33sYXHZr7MnRf47aRBaaCmXTOHQ>
X-ME-Received: <xmr:-hu6ajPUEpfydphiO2766F8jC8nJVbBigfKHfeLOYRgGjMN5Bcea-w>
X-ME-Proxy-Cause: dmFkZTEw7kk7ak1RNHDgFCz1LJ/HWSt732vckJjjMfeNVdnbxn4XylxiFlF7pKx097bIcA
    Ltj7vACp+kM+sECQDTjGZVRdMUKsG0pzEi7zG4rmc01oQ3RHqYhH+TWaW2AkflstMUXcXs
    2fnwSsOWmlpcBHFSH/TlT4/SZ9gJ0uJ/IBbOKW9z6puMHjIMcQsUrd8V080LNCc1MHUhxw
    rp6dEWC5RoEkdTcy5/KBAmRTasoKb5cobfDMVW5418vnbtE31mDG+L/lEfT41vbkMizFxZ
    DF+zvs5x2ag9DzwxKL9/mFrtuxdh6JRJmXezYFS6kr2Lbq7NuHHc0jJbfy88MkBnUc02uB
    6bF+rDSPXQ65v3oaOjmuXKiJwvCbojVIAFKEsXb86jsFsHA/+kQCFtKbXWYPUE7s5+8iH4
    X96R7nhkmSTG7fO7Mea2aeiuz6V4i+PjZpb5+YlBaXIg86EpDwKHEymEwxtEeqb+CAqwca
    6WJa2U+2M/0GVvHXGxahIbENRVDh8to86nlDO/f+RBqbntLVFHY0h7Cv7uQWqqNq8IYy0X
    pbfxGt6KCv6p6fz/aWc8eWrsxQiUWYvjkeW+FKPFhCH/qyYyWVCzg7Cnn+DU5Az9PpQWyw
    AqV7J0+C42ad/ySTUo7VS1MVexJdWP267CUxNE/hJ842Lo3hMKWNsimQ3nzg
X-ME-Proxy: <xmx:-hu6aoCL-2iMmmjGy6t-HQFUpb2Opb6JqZKSyLhWwnPwC5RbuBKi9g>
    <xmx:-hu6aiLBScD_yw4CcG-Vl7Q5K7FjRqa6YcKXHWLBgI2RGRRiHbpQvg>
    <xmx:-hu6apPCrDju121sDUQewhLi3KKCJ8lb-VHfx8-Ju7sTpSiHoBeKkw>
    <xmx:-hu6ao6ob8VQk79GL36GzHEhKktSGSXheZbZS21xRQA5RggrEqAxJw>
    <xmx:-xu6ahJRJ_UY2sxZIAxQWPbg1qs2uioCAIbhoI6j-DtqOIkpBEQ1R3m7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 03:49:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6d11f9b6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 28 Sep 2026 07:49:11 +0000 (UTC)
Date: Mon, 28 Sep 2026 09:49:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Thomas Bachem <mail@thomasbachem.com>
Subject: Re: [PATCH v5 0/3] sequencer: leave auto maintenance to the end of a
 sequence
Message-ID: <arob9B6PGV_T3Fmg@pks.im>
References: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
 <pull.2217.v5.git.1789670534.gitgitgadget@gmail.com>
 <c67ed25c-e54b-4289-bfb4-67f86beb6df6@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c67ed25c-e54b-4289-bfb4-67f86beb6df6@gmail.com>

On Wed, Sep 23, 2026 at 04:07:23PM +0100, Phillip Wood wrote:
> Hi Thomas
> 
> On 17/09/2026 19:42, Thomas Bachem via GitGitGadget wrote:
> > Changes since v4:
> > 
> >   * 2/3 takes Patrick's wording, with two corrections: the sequencer itself
> >     spawns the "git commit" for a resolved conflict, and the apply backend
> >     belongs to "git rebase", not to the sequencer.
> >   * 3/3 opens with Phillip's sentence.
> >   * The header comment of git_config_append_parameter() is Patrick's, plus
> >     one sentence on a NULL value.
> >   * Both tests got a comment on which picks conflict and where the sequence
> >     stops (Phillip).
> 
> Thanks for adding that, it is easier to understand what the tests are doing
> now. This looks ready for next to me.
> 
> Thanks for working on it

It's already been merged to `next` anyway, but agreed, this looks ready
to me. Thanks!

Patrick
