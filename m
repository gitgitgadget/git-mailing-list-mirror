Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E79E3DDDB8
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 22:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783721723; cv=none; b=hFOLAOcg1+hmTTdkJ8k6ampYsr8HGkkRB97bup2JwUaPjrcUKtC09xZC/yLOH1hGJHughCi1TzcRUgo/AiWqJjvfwXc907ntssnLOqhg6AFjpLUsrBbuPtL77GYZ2axhe+qpZqpBf7gT8/Xu6pOIPzua5GGoDrjH77PTlGDREuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783721723; c=relaxed/simple;
	bh=2Ranu1gcKOicFJWaY0qKyNY9Jyox4YLPY95b+KOmpEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BylleI1MTTk6kJjtAjoa+5ptM5shKcd1vraKM3CU3v0SlokscRS3wg9cQm+kvB/J1rR6u6P8ZiM/S2bEW5wuCzuT76f5m7PLsVFlYFndI3TKgvly4lcVhgrD8dVIAU3ipHGv1N29jxhB/AGibSX0c+M8JD3UEU8DrWlmakm7zcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=bEORyDko; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="bEORyDko"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92ed3993c1eso81817585a.1
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 15:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1783721718; x=1784326518; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/Ei3rKtE99sWFQ6ohFX9FfGvgpKrB3VPUuMFdVkx5iU=;
        b=bEORyDkoLECYuTrsYNS/jcbENOVkdPayo8Cd6CfvcimgDw5rEvaHiQDXkDkhtnwVvE
         kIzz+6alj/xYjdAu6XXPEm9lKSTSjLiE/Yd27G1tu7SC9Grw/IJJuK1bHIHa9c/nx7C1
         ZjFSiRoDFHoShcVqyeLWwsIdqkAJ9hU4GPU9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783721718; x=1784326518;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/Ei3rKtE99sWFQ6ohFX9FfGvgpKrB3VPUuMFdVkx5iU=;
        b=QW1yYn8mB0jMbZhymdZXwXeRYn2h4S8bIGoZHqCe1nRnyazLvz6GSGTd3gIM7piYIJ
         Ur7anQUcx+pJeaV6znXinXcjmqJeanAwBkbtUf67V/NLGUMTigSZiA4NwCUR0UyPB2mq
         rLPCiYH54AdGIKJQ4bBhRI+4jYn9p5c5wIb5g1PZI8cKYHkiRjmbOuetWG629ghdIeP1
         71T1pkgxl3LaiAwFiGniYpc9sTPp+UXpEEUKW01yPT3C4d+XCSd2Z1SpmuECop3dZGbu
         iorfUERtN9VtqVS9dtIS/2h5fvPgnWWoLBvfppiE5FHXdJRNlfbNmU03F61nVCpuIn+q
         jG5A==
X-Gm-Message-State: AOJu0YxPRkjBLR9YNz3usNyd2M1ZVaA/HQvFJP6SH8OXqT3z7xsKIVSt
	6DRLLh+XYuKtsca5WKFGZvNfFyQ5LPxLvVeBoL/Dsoe6NVgl+ZQ6XTglJngQXsuocE8=
X-Gm-Gg: AfdE7cm36Y02PLj3uRMGxsjkIwdxYLXQqhTA3A+FiLuRJYIZPCcLE7U45Rab1DOSsKU
	C7hS57We6Cjl0qkcY+vvHOOZhVlt/qF2xLRjHhGTU/HWFaDdXTpTTFKzKvcWnuuOVtEyz5xqJPZ
	6FKCsj6HDalP56U0G7FL/1Tm69cFQZo2LAuMmZ+Ng3+5zEYCE7HYGE3ykM4vYgjd8WX4RNM/QJ7
	GD2jKGfYmquTktIe0663+T9Mt/T6T76wpNYAnjvZEjCDqO+Ov5Abx0ObUHLBrlN/Mpr1X9Rg8Ri
	SHT2q4u2Jz/7/+Z7A+JPaRldqZbWsUQTYmoU8AvhUMT/z7RJfN+8IY8nwRAabIZ++0Iwb4CfLuN
	/ymBZXw5Esnbk2mPMmELIxhYu2C2wPFkiho+VE5j3QQv7/wxKF3tXW92RkJef2fagyXL1hT65dq
	XEFgDCZyu2370WGEMtaW8Gq16p
X-Received: by 2002:a05:620a:45ab:b0:92e:cba5:3053 with SMTP id af79cd13be357-92ef2e36f22mr114074785a.77.1783721718181;
        Fri, 10 Jul 2026 15:15:18 -0700 (PDT)
Received: from com-79390 ([209.249.37.133])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee59223e7sm301405585a.0.2026.07.10.15.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 15:15:17 -0700 (PDT)
Date: Fri, 10 Jul 2026 15:15:14 -0700
From: Taylor Blau <ttaylorr@openai.com>
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Kristofer Karlsson <krka@spotify.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 0/2] commit-graph: fix topo_levels slab propagation
 regression
Message-ID: <alFu8gZURKhYr1VE@com-79390>
References: <pull.2170.git.1783418384.gitgitgadget@gmail.com>
 <pull.2170.v2.git.1783609382.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.2170.v2.git.1783609382.gitgitgadget@gmail.com>

On Thu, Jul 09, 2026 at 03:02:59PM +0000, Kristofer Karlsson via GitGitGadget wrote:
> Changes since v1:
>
>  * Fixed wrong commit title and date in the reference (Junio, Taylor).
>  * use test_expect_failure with the correct assertion instead of a # BUG
>    comment (Taylor).
>  * Simplified commit messages.
>
> Kristofer Karlsson (2):
>   commit-graph: add trace2 instrumentation for generation DFS
>   commit-graph: propagate topo_levels slab to all chain layers
>
>  commit-graph.c                |  7 ++++++-
>  t/t5324-split-commit-graph.sh | 24 ++++++++++++++++++++++++
>  2 files changed, 30 insertions(+), 1 deletion(-)

Thanks, this version looks good to me.

Thanks,
Taylor
