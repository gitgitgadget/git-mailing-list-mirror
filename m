Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB85D30C157
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 22:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783722364; cv=none; b=EaxwVaVT5HmNodPv5fAIoKeQM3CHUpLu3PZVoBY1AcUhyAUInT895MPOOKBDTPM5p0666JvtiXn+iFlC2rPQFDV0qTbTOFlQybqdfsG5UUdc5WoUpMd7SPPvvuEdTSa9NHRBpjJ5slEhpZHwtjW/gwCto9uVNzT6PzMZC7LJ79s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783722364; c=relaxed/simple;
	bh=JxbUfMHC/z5WZh4Af8Pr9Oms53kOcsKlfWwuwDv5kSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SqbAtu8JL9zQl1YWdMMKhMKRlsNfgtp138avttbuVwxQg5HdT9NQ3vyV/eCdYAiMVQ7ZJYjuQhp5u0QxDITC6So99qVPRZZzFgy0klJuDPgWqNys0J6uMlYOP9P5oLB7OEKSSMxjkUeKx5ytA6Bp5mB7KuK9Jgt9Lre/hQxDASM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=DB1OP7Aa; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="DB1OP7Aa"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92e51d3d83cso73438385a.2
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 15:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1783722362; x=1784327162; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IrdlYegV9vi3TW/lKhPWPyYQEUdAu8h3Bb5BTTdEOsk=;
        b=DB1OP7AaZpuhDqazfrQUlszInAnPtxumi6u/xoAIt3zL8HBPsazvP1phZmYXVIS/ep
         MO1XbWe+31quM4T4J3VOwWN4YWejSkE8F+JbJ29EpZR4UDTkAHCwg/8VOROKznxdM1/F
         gMWvJvnoLr/+BBoUd7Rd1Nva5PZqiViuyeSK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783722362; x=1784327162;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IrdlYegV9vi3TW/lKhPWPyYQEUdAu8h3Bb5BTTdEOsk=;
        b=XFFYtBgGlDfCSRquAmyNVzBBpE0ToUC/3AW6d8cIcgZB63ihlkKqqirtipB+y2ZBjt
         ded8kiUKWOdIxeQqqvDVAhA2F2gu0laRldj+WRczVb46A92fM2cn+KDLmdJHMUpYql9A
         Z2UqIaKx2rGAfjWI/TSyEPmJPEbeRqvMAIB7MCw4y8uqPyTYaO3CRWrnnfwA3zx8vDZP
         c40xV7jOc6k59W44EOMG+ijbMGDSyKt74P8DTQ1w7GI/2qab49q71oCAnwFy73pU2JYv
         EVAzi30det1or5poKJWNj3I+5ZfPvevc0BfhkXJIPWvPAzPqAAcOLUb2W1GKPcGd1C/v
         dHMA==
X-Gm-Message-State: AOJu0YydncIuZdgBin5nIkauFPyenubQ+SUlLC696YZSCIvm1GPDuDl0
	l66YDa5OhccuF2xmFsnAjpeo4nsgP1ZVNJt46FGK5dyahYOxN+/eckeBFM2wje0le80=
X-Gm-Gg: AfdE7ckL2PJlu4KBcbw8vYRm3n8M/vi2KpajLSZFCie++YMsZeKNjN0FgP3Htxd6o8S
	PB+qVdB6oK6uU+xg6pYxZB79oktE9R/tmgfMOwlwWBG6vMqXeemgPrHRFSWaDC/2T/LLORMq3ia
	rw7BykfDW9cR2hfqXghqCW7UfooXJRxp8ulaGUr+ez3x5yFPVivp893mNdawkTossbTG40Ff1cM
	I2Ty8r3mfvmCfHEzBrK8OTOfC0CEV0Jv1bCR8QiQ9X5C1LaCNygZ4/tN2PUbBHYN771pK/yEvxb
	2dA6n9S0v1ZAI+uzl+ekpi2EwEAsgA/4Pz2ML3KcF0wpTySJGH/y2zqYYe4LI9P3uoJN7hdSkGo
	od4qHwCZ9retttb1tuClgrq3gmIAdDVCCXVs2eBv1O+KSdh/pYYHuZRfkX+Qu7AjFRD7ym1ANv2
	LAccvfr4JhD/OgUBh6tLOYXKWp
X-Received: by 2002:a05:620a:4151:b0:92e:c116:bf08 with SMTP id af79cd13be357-92ef2c9db28mr115851485a.81.1783722361604;
        Fri, 10 Jul 2026 15:26:01 -0700 (PDT)
Received: from com-79390 ([209.249.37.133])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d61fb9sm294040585a.41.2026.07.10.15.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 15:26:01 -0700 (PDT)
Date: Fri, 10 Jul 2026 15:25:58 -0700
From: Taylor Blau <ttaylorr@openai.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/8] pack-bitmap: mark object filter as `const`
Message-ID: <alFxdsQz9zRMrScO@com-79390>
References: <20260710-pks-odb-for-each-object-filter-v2-0-3710a9cc165a@pks.im>
 <20260710-pks-odb-for-each-object-filter-v2-2-3710a9cc165a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260710-pks-odb-for-each-object-filter-v2-2-3710a9cc165a@pks.im>

On Fri, Jul 10, 2026 at 10:48:54AM +0200, Patrick Steinhardt wrote:
> The function `for_each_bitmapped_object()` accepts an optional object
> filter. This filter is never modified by the function, but is not
> declared as `const`. Fix this.

Makes sense. "Fix" this seems to imply that the existing behavior was
broken or otherwise incorrect, but I think this is fine.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  pack-bitmap.c | 6 +++---
>  pack-bitmap.h | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)

Thanks,
Taylor
