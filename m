Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4ABC8EB
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 04:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783916426; cv=none; b=LUFHG7J8SqVZvVLWDE5tSDqnHPUNKyzMdKRylGRSuZoxf+EeItYT5yvHVkm6PwtzTdqsaJxQD1fjY186rkYhXWA1yisDyRIaKwK1XynMCsGESB4wSptPdXJHU8LDXr/pyPw3fBrsdO7IsG6iQPld9GCYfaMqMnl0m8tAd+/xIVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783916426; c=relaxed/simple;
	bh=nkEZeX3UI4CPEu6b+V4EkV32AdV1fBIy2BUfTivi3ns=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U5W7DW/2iPG7+XuiIcFkZgfoeWVOEKkiUtjHS8VPZClo9jlLlQhMHbjeZvY/CQ82idUMR32NQSpfRZzPxIAQysaHDV84Oo6+7yglLDlpQ94zijc8sP9yPEUU0nTHmzHwky9AkCdqyEbIMojHG6YqJqvKqK6XVQwLDrTtcMD0MJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ER74sB7x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fuxiM9X0; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ER74sB7x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fuxiM9X0"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id D00C51D0004D;
	Mon, 13 Jul 2026 00:20:23 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 13 Jul 2026 00:20:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1783916423;
	 x=1784002823; bh=ezNhZDDg6GAZbqAguvWMMCGLtiPigRMZXxvgjg5z+HM=; b=
	ER74sB7xqwixoBKYiMjYEyHgdGynFuWx2aIsUU85qsaG9CJUMEKcR76Vp65ebzIg
	CG7rl11CNUshvp95dO+Qhzlc08ld7csg7JNbuHGNloLET2EJataTp7btrhfabEex
	NHHbSHUH1s1bh+GcXp9540HbWzXLBADdQABoZejzyeMuV+W1AEcgcK2s6j4X2Z9V
	1fro1wI4xkS6kkBTp8nCXXSWxihv4mpuXU5pT4mWW9X3NCeRMY4uVwnxV/yyFfJG
	pf5IrIzYYL2igaXufWwnrpcAWVuUQiyjdDo4fIkz8gjggPSR2LfhwRdS0uHg1FzN
	FNmwVVFCzBc9ZmkjmLKqng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783916423; x=
	1784002823; bh=ezNhZDDg6GAZbqAguvWMMCGLtiPigRMZXxvgjg5z+HM=; b=f
	uxiM9X0++TU0pv5Fl33B7l+G/MvR+L7k8gxl5+1BoOCkLIDTCDj1AEy+27SgLs9K
	G9bpOzISQfB64I2yL8pm7NlGg0h4QWl6Wp0sb94ZuIkJnBi58gWIu5eeLm59YCNT
	RqX6bwGgIjSOGfHi9mz016E3aIYZWPv3WCv8Nrerhyx6WvXDabEcV6+aLBVphD+F
	wsXUD6rgLvsVnSdveLktsSszhwSwpEsPdxjDUHcVFgOFRj+kDxJlPhIZZu3EFNRf
	yS+PwJt/tKAJLKT6oviByx6K06F6S21Ui2AReBsO6nfBuvb3LEzG0hqCiCp70n/1
	r0Tcxb/K9ISFNvgZ9u+SQ==
X-ME-Sender: <xms:h2dUasPnxvqwvpaaQnbAFAw3KvVQIQRrEmFzeeRimXpmLFWNQRnFqQ>
    <xme:h2dUaqbXf-5lUcVL538YMiPMpvdBBjRazFpOh0Ul4BswZbGoQFK5xbYVeV1HK0Ofj
    Ebf3gafd6AhN6zvlQ2geN5Uxs4-5hfesqL0aJZsPJi5lMo9NzVVWg>
X-ME-Received: <xmr:h2dUagr-s13lWbmnRRZwDmEZla68PUAXI234p79NLFEvWSbke8Rg2rIqeY05rD6Lly84FVgcDxNz_pugD61ICOK4u1Cmyi_ur0HjIaU>
X-ME-Proxy-Cause: dmFkZTEkZ0GsLTFrNttTNk1kDnL0fzyOzjUABnzBn7UPaZDCfF9cdgqp1VjsqqlF6URVCm
    GxNMg2/CHF/Ytwy11v/tbXqV0Mt/iOlRk99RCKVvsk6R62AaaHXH/BERYaURKavdOqAN4v
    9VplIkuwwROQH/Pd2Lt+hTv1rhtw+SyMR+ZCSqPjVqYFEM5BfZZqS7jHCTn7j5IFXT+XAF
    gbVHpj3EZqZriUzp9duTk5dUnQFsYru0G9FgvM8jCOJRBFbSCu0M/ncSj0JBEGuuKhY1/d
    oA6bayBsxx6KJfLj8Ltc+9l6a7UqF3laJy6ZUjibxUgAWRQ/x8ddppqIy8/C1c3ZK+jcit
    mYPYwIl2FCqSV2zVzg8cr656il60UH+1gADuf72FtXdfInYOo2260GkFu7MVI/ZvcV9C2n
    6t35lSH622WsGCQ7eyDVSD3yfZ6bGpEcafweFSU0v04jMGIf4YhBey6bU5VqKnfftj++9p
    Fg2EGJceZ/QkxrTeiRNYC5MR3oPzbmXLVFLMtz5ptehuKZXf5WKeWqLVGRZ605EfhEZz4i
    8uu0qfeuK22vqTN380vH9To35RsE4jLnrT2bszxWIrA7j0UG8+U9+srWks+9MSORL2eZ1O
    RHVXcSgjZOjb2TGRRKxsrjEFwcEHG7yATUY5wviyJeLPoDR1rKAkYECXGKCQ
X-ME-Proxy: <xmx:h2dUauap4mFibAu3FFRUmM-FTzipL5AZ42GHYxZoyxQvjlOFumW61w>
    <xmx:h2dUaoR2kNA6zXo0tbpSXCWkVq3ew4VD-FoYzLBS0Q-s53s_0H6L_Q>
    <xmx:h2dUal6PPlzt_A6oOLoIdoByJuCTnprdIJdVl6r1HYsb-8VV6NC2_g>
    <xmx:h2dUatyI7JeZ0WWSc05XIXYNqxXeCLdaXYn8Kdz-Jol9yDdtBHG7ug>
    <xmx:h2dUamZNo8KZUHQmIcQlGGrch4ppP1G51GnVnPQjCDZD5c1JxAhqcTGn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 00:20:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Michael Montalbo <mmontalbo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/6] SubmittingPatches: clarify the writing style of
 whats-cooking
In-Reply-To: <CAC2Qwm+30zeMQKHc3onqhXG90wgrdvba28TadF=N3-dD1Ah8zw@mail.gmail.com>
	(Michael Montalbo's message of "Sun, 12 Jul 2026 13:41:22 -0700")
References: <20260711192650.2417665-1-gitster@pobox.com>
	<20260711192650.2417665-7-gitster@pobox.com>
	<CAC2Qwm+30zeMQKHc3onqhXG90wgrdvba28TadF=N3-dD1Ah8zw@mail.gmail.com>
Date: Sun, 12 Jul 2026 21:20:21 -0700
Message-ID: <xmqqmrvv1px6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Michael Montalbo <mmontalbo@gmail.com> writes:

> On Sat, Jul 11, 2026 at 12:27 PM Junio C Hamano <gitster@pobox.com> wrote:
>> +TIP: When proposing a topic summary in your cover letter, write it in...
>
> super nit: It seems like the precedent in this file is to use "NOTE" instead
> of "TIP".

Yeah, and not just locally in this file; "TIP:" is actually
not used anywhere in the Documentation/ directory, whereas
"NOTE:" is frequently used.  I will switch to "NOTE:" as
there is no point in having variety in something like this.

Thanks.
