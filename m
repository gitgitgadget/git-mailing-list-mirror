Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A273F1AAD
	for <git@vger.kernel.org>; Thu, 17 Sep 2026 05:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789624182; cv=none; b=ABUbXnkAajSsyffTMn2dNQliU+NWGSKwei6ugKb8QXiQZRN2e8A73Wqn3nLW/x96D03Rg4EjiGP0IU7EhQAbTSAAX5QKgdbgOucJbMTVb95fDvNX+DiWiROFuTB1jrLSWWrK7K3lgW8FA2/l/gvTdyD7tTo+eOQdUKm+gXkpaec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789624182; c=relaxed/simple;
	bh=tReoqWIHmoXrMz6orLI6piwdF96iV/JY2gLVp65/QGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNh/hCL0xnVbU3xyYklryoO2AdboxyqIOJ4YJ4C3vqw/wvcMoYMYZV73bzBCaTcnolXcdDlSWrrjeIMIr9ztFQyfISm/qZGVL2BtPRcVONRoi4Mo1pUTyITcwx5uO1bH9nk4IagIzJQFJMcn0TMhgLyL0VtcWOCdO+x5S/ayDC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dInZvCWo; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dInZvCWo"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f55efe5so72189166b.2
        for <git@vger.kernel.org>; Wed, 16 Sep 2026 22:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789624179; x=1790228979; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7zjM3WpW4q3U0rNgTwXCFH7zO5TMg3FCjqpP+BLR3F8=;
        b=dInZvCWo1/CSp2VonOjy3IpmraTB+pDyePm8JE6aGrUXlOk3gkrv6vMWjLE4QuZ3aL
         bIP8CNb4RDFEiCJ0rBdiHfCXY2cBureVCP31YwOfFKzbFxw0KozDYM+tLZtMsEmxiZUm
         ivX9g+mDmlWPxPpP5CMBj7koArBkLoGnlF8ALockqnY1x7uViHWsVu/5Q9Em/M9n21zu
         IKCFAklku+26vwTphmpXcXJm6Fig48atixzTn9V2lGxisVQ1pVue4bnqZyRWzSQSPCXV
         3A8WCSQURnH6D0hnIqVftL2P6jXqCXawpYqktZdPMW103ocoP6yhcGVVOn9WwQsqbzHZ
         kDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789624179; x=1790228979;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7zjM3WpW4q3U0rNgTwXCFH7zO5TMg3FCjqpP+BLR3F8=;
        b=GlqgqjMuiS3VyZJgY1G2smyddhWEweu8JBusSXQ/vcp2jjBT7QK8NzYtk3rBrxwSmo
         qMRYlOk9rMMwnAprW+7Bk3oXvMSVjSlHhQqIyCfU/H/UMfRuiLHhRYLMEBtmD+36uazr
         xqpkaO7aFrdNQg2L8d6pIKEwyRC71nP8uzWunditHw0AWAHAyVLcyK4Gtq2qkLSHYXfN
         tGlj1EL2bFFCEhL/i+NMnXQaxFBzYXVxetOS3BR6HQmg8NShxaUMpjgrqwl+RVIIKvdh
         xGSJM22nPQN1jJfrFA1M43R1OJV5ll47dZR8rs3s8KPyg7MWfFSF9yw+VM8p07NhYc21
         8+hA==
X-Gm-Message-State: AFuF++kuoE6FOOiGF7wwAW55fTaK/wGFwQ4l6PJsjy35fo5TCsnBUedO
	OaaPmHAZ9EM+gxuMVOWqsqVuM+y/X7IpxJIaxCm0H3V9ncZvomxw44Hv1qMU7Q==
X-Gm-Gg: AYBFou1/tZa9V4dqHA8S9aZwNaElHHZhbETuTmau7M4UiMfGCm1oP1NbtN9ym/caHyJ
	7IM0lswFoh7FHOhSK6bJn66t5igFzScyhTmv9X/9jtboLwi/hjSYuMwUeZSJtJHbUo0ofdoxeZi
	CAfOPDz+ebhoowfgt4CXHZiga6HIAuk8jptXOulaj9UkDOl5G6zAIrv0VCefps7m4mjZjyyZItC
	D76Bzpzq4cRvH2KUN22pcecUt9+qHBFWhbl8+pa3XrjHR34SAdOkBuA9ljD+LMlIZMmW4vT2tXv
	W0sdOizQ5FHhm5KF9B7k/N2upjZLSXe8OosWlvEGI0bMrx8Oqw0Km8XKOuQMpionsceXP9L1q9z
	vfpMYj8RrkU9M2AERN7zvnhEG0XIuyF9UhFEliACKPetbl2S4kFe9C4hwUoyRfYDdyiKTj8OpEm
	ldYL01ehUMEuERssqjpiE7twlfwQsbr3YajuO3mf5md+/pQfi8yVBFnsyIrhp19sFNyhzkAXzBM
	lpiED0Qg2M2be5qGd7siO98VVt3zUlsWY/22g5yVJBkKtUYsimwnGQNHOGaRhj5Qjuf
X-Received: by 2002:a17:907:3cd4:b0:c25:5faf:b207 with SMTP id a640c23a62f3a-c29e51cc690mr342021966b.3.1789624178994;
        Wed, 16 Sep 2026 22:49:38 -0700 (PDT)
Received: from localhost (20014C4D24E59B00EDB70D4029CC4D29.dsl.pool.telekom.hu. [2001:4c4d:24e5:9b00:edb7:d40:29cc:4d29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de667f38sm234490066b.56.2026.09.16.22.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 22:49:38 -0700 (PDT)
Date: Thu, 17 Sep 2026 07:49:37 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2026, #07)
Message-ID: <aqt/ceazKbzzmZBC@szeder.dev>
References: <xmqqzexhuia0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzexhuia0.fsf@gitster.g>

On Wed, Sep 16, 2026 at 12:07:35PM -0700, Junio C Hamano wrote:
> * sg/precompile-git-compat-util (2026-09-14) 4 commits
>  - Makefile: precompile "git-compat-util.h"
>  - Makefile: reintroduce REFTABLE_OBJS
>  - cmake: remove any "$(*_OBJS)" variables when parsing Makefile for sources
>  - Makefile: remove XDIFF_OBJS initialization
> 
>  The 'Makefile' has been taught to precompile 'git-compat-util.h'
>  with GCC to speed up overall compilation, while excluding sources
>  that do not include the compatibility header.

It works with Clang (and probably with other LLVM-based compilers; I
tried the Intel oneAPI compiler) as well.

