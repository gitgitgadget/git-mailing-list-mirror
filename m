Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5836E42E429
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 18:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570380; cv=none; b=TcAU+SLKEcTB1VX76tme1z29pZM+YZkhWdVUaqym+KMngXwIfB+hoowT+ucZzoSg59i5i/ye9/4UoVn6bmsljLLOu8+xZ41W402x/qDhVIeB9s0YEKISBvoKT0BhkEd7Aop4GQeps2LGdY3i9lvy3IrOPG4JpvopEhY3r6waktI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570380; c=relaxed/simple;
	bh=tbkNR/fkwWFG+pASu+K10ZTus0r+c30T+gljJDx9YzU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I+H0B3tq3Gyvc8jqDEoHyE2Zknl/HfK4FRct7QCyWWjdQm1RakDtphkYGSD6G38XU/CHmfWKrsFYhXW70eWA2L3RMQb363TVL0hLmR4mCfyi2DKano//pJC8tJSqrRty/5tBcbcdK0r37Us20AUNZkvdYsX6fTWKD4KkS+4UyGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=i4UM90yT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fy5JrsC8; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="i4UM90yT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fy5JrsC8"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 736991D000E3
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 14:26:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 09 Oct 2026 14:26:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791570376; x=1791656776; bh=FjUXzSmF7z
	RrO60Hc7G9Xuv5RYQ3iRZCfmoN5Totj1A=; b=i4UM90yT3Spoa06O/yLIm9Xjjg
	aLZdSOC86b96vpufmfQUVSFY2cz+TyZV40uWRqYpZD20+ECnvGTplc05uK8H4GyD
	hoVXYfheQzzW/QuvTpwXZkHAKO+eXSaB8bewzYDurCie9FmTbA+L8tfmWw+8jYRy
	3tS5a7QtB+KdorcR34ckc19BpvlYMbSWVYZkdOXK64KPIRX7bxtfqMJSfAN2HxSI
	pq+MJ2raH1nbEp+xWaEFzXJ085mcKvzh8nVuLHBlzVh9yB50C92fcdsfUv0aGfCB
	C+7LKqnmHpEietBOFsbwqzsCK1HQtFyMN4UZn3H/Wg6qGP5ppEUPkfd+zeSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791570376; x=1791656776; bh=FjUXzSmF7zRrO60Hc7G9Xuv5RYQ3iRZCfmo
	N5Totj1A=; b=Fy5JrsC8BPfGblYQVf2RR7hRozYukPB+pkUczOHoQTtrwyTVseP
	e/C4gdFH8LoDMuxW5RAXYBoyDm5wVeDoSB+WjTNScto7f26OHSGlwqZv8jvJR/1V
	QhhtA+q/9LXpxJ0QbDmU58INMr/eaEMABMYkFCmh3W/l8EG2MERc6KJ/nmUTaHnk
	u2bBP+A+Aq0oXQI6I9H97IvPUVbNBax8rGvnedaSgQ2J75t3eI4Y3+zQZfk12WlP
	SJWjsPzMwND/BKWu9Akh5kUU9+IUWO/mL/81Rtv/UgFFbSIA9Z/wIJW6WR2Hdde5
	j4fozhnCnQdHFFX88yLCh1eWaycFH4N337Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791570376; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:P5eJI88uOJAHqyuB/yxEfIeR1cP7/Q2TJNdN6ML/H/hlvTg
	TP2vhZlRxRFZcuvc/t6g5HgMy8gsgLT2K/7wLCdTFXMovbQEajTHxIsc7QIBNqML
	mqIFC/soowi+vP+SPIpU5fRy9x+i0U+eZjR819CcJNjtN/EjCT5G/71wgSCluqvU
	sZpN2w58sFGrMn3AgT19kbNXGLdPUz0BSc5IeAp6yyIbjjK1YlZbOyvG9kku64nk
	JHZIDbEb/xhvmfLGgIY9CZMM5O+EmsQiaibRjJooXFvQEb9WVte9XKPZFljZPp7o
	OsQ2VFxk6qk5t81SDao9t3ZX/jb5tY2UFH8KZKw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:fbF0QXxNmYOmsi21TcDHK99dLsoIjOEiTb7OvZJH9LA=:tbkNR/fkwWFG+pASu+K10ZTus0r+c30T+gljJDx9YzU=;
X-ME-Sender: <xms:yDHJas2UEZB9EBexbB28Aj8a4TGYTTuv5HAk_bArSFHiOUwDfW7JHw>
    <xme:yDHJapWN9hRHMgadeQXFdQOGv-KmEThfezxp1qAoJYKtfd3weJpI8QM1aOxFPHvNA
    JrtR0Z7QzmYuCV9UaowN6Fih7aY4AiIj-bMV4uKRiM-q6c7NJARcA>
X-ME-Received: <xmr:yDHJanICzhbUA6tOTwl26DHCfxeZfOEmjd9yTDgOHjBM-zcslFq_ZFTsKuYvooDlmTCDgIBzrfi0fP2LquxaMhNaU9LjEVkOOMdB>
X-ME-Proxy-Cause: dmFkZTG0PlZ8DpE1A6EaTkz6uinoiXB+GmQq91Q6+ZShyPjxuOOhmcqFeqRK0970+yBBc5
    JfV65eHuax9YCt7How91rJuRiLKo1uieQD+eUsyeEeImGwpSFnTJXX3G5/VwasjTWTMRzH
    cGKPiyHBEalOl6ssbHENk3RVcUzFwytm4Xg+fHA0kMuHJMvADuihWdQQKC/n+qBXqV5Joa
    d9hUU3oEY1YiaRRB4OcAWnaqnn0dARUU7nBHuOx29yOGXd4ZDYAet1oxqax5LDwYCOLcYr
    Gan0wEMFJ/XNWn+miFDZIZpWmmZdi11mN0IAkWllSRlykpsXW/4TTWUcvP32SyYZ5XsdF8
    syOFXOhnH6SuowG7gNukPzeu4HNcfbBQ9VRZwhXJ5bXJpmrpjpwPSM0EuBbKobplU1HWUq
    TqkcnnXAyibCjOyYG/a62f1WknR+u/FVexNkhM0xALUV99GB5lQFh9O9Zwn8XLIWVypVSH
    YeMxOF3fvhZUQ3wUONLt3a2qrjFF6ELrCW6kHz1ZoSQX8rpwAITq0tQPzy+xHjvT19ISbS
    6YYWzhaDtNDGNwzaibZx9U9728A1gufJ2ruHHov0OxuN2uqlB+Nvub9NE5ZIyW62OHkZH/
    BRR4d3CdlLXYk+Kh+3+TGrdSEQZtgeQ3wj6dPDrEBR7BW/k2dehTeG0KOfkQ
X-ME-Proxy: <xmx:yDHJar3ksHfBjPTzuN4Gm7S3zTLBe_tZeJVAunoRhz9KRia5MLaYBA>
    <xmx:yDHJat4GxO9b-S5vAaqh9D0vT93SuQ-wakS1k3mhwigrTJCkomjTVQ>
    <xmx:yDHJak_Al1-NfK6TMMlX0oExF142d7QMsk1x1b2EfQvr1Nz2C5bY9A>
    <xmx:yDHJakU3EklsMJWMsW3R9P2Fdp5qQ4wXJEGLcm-QEy0MqiyCcgGAlA>
    <xmx:yDHJamYOMhrKVjXwDfr4QVRxZIvJFVRM9ATbz0yjM80ATe57mAya5Nab>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 14:26:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  Jeff King <peff@peff.net>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v2 5/6] doc: git-cherry-pick: link to new merge
 conflicts guide
In-Reply-To: <62b70e9a02dfc9c5b5c980b71bb0507fa20cc0b9.1791547213.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Fri, 09 Oct 2026 12:00:12
	+0000")
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<pull.2237.v2.git.1791547213.gitgitgadget@gmail.com>
	<62b70e9a02dfc9c5b5c980b71bb0507fa20cc0b9.1791547213.git.gitgitgadget@gmail.com>
Date: Fri, 09 Oct 2026 11:26:14 -0700
Message-ID: <xmqqse2epw6x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -When it is not obvious how to apply a change, the following
> -happens:
> +When it is not obvious how to apply a change, there may
> +be a merge conflict. See linkgit:gitmergeconflicts[7]
> +(or `git help mergeconflicts`) for a guide to handling merge conflicts.

"Obvious to whom" was the first thing that came to my mind, even
though the blame largely lies on the original.  Can't we get rid of
the above pragraph altogether, and "See new one" at the end where
you replaced "See git-merge" reference below?

> +When a merge conflict happens:
>  
>  1. The current branch and `HEAD` pointer stay at the last commit
>     successfully made.
> @@ -36,9 +39,6 @@ happens:
>     conflict markers `<<<<<<<` and `>>>>>>>`.
>  5. No other modifications are made.
>  
> -See linkgit:git-merge[1] for some hints on resolving such
> -conflicts.
> -
>  OPTIONS
>  -------
>  <commit>...::
> @@ -259,6 +259,7 @@ $ git cherry-pick -Xpatience topic^  <4>
>  SEE ALSO
>  --------
>  linkgit:git-revert[1]
> +linkgit:gitmergeconflicts[7]
>  
>  GIT
>  ---
