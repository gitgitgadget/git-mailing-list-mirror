Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4517346FA7
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 12:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768306283; cv=none; b=IjKgRVsHQiYgmYDwCg+3hl1X9+R274fLrO94/A551I+ICe8mR8wKOY9qhBPOvT0llWl8AcovV500tbytcD5y7D4NADfV6ecK/j9gwSjQG94rVkmL9Wh2g+iAlSO/82m6WP1X5z1xbBXBONR8BqT+nr+LV/hmNFZOneOhMgMMRUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768306283; c=relaxed/simple;
	bh=OxTT3L7MrOEucVY8486Rb+OGMb6vzPXpCAprrVTjZKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uewcPw4W2zlMce/EMmBq5vFNS2NJjGOpiPekx87UWbkMAGIYyZM/JAyJ1F3mITUJSq2zP5lK6ubqQ2dROV3L4vsWFKPCPm+zXZgXSuMOhXZMzaVarxm7pNY1pwK07yVGsZCUoeqhA84E34tG4GjulhRV9UKJ8CL3xqZ7ayd4z/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JNyv0auX; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNyv0auX"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-38307233c98so50266821fa.2
        for <git@vger.kernel.org>; Tue, 13 Jan 2026 04:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768306280; x=1768911080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2o7SrVLdsl8TDvc6NPbp3VFvuvUwOgsiUE2PmdF56K4=;
        b=JNyv0auXWMW1Fne4jaagUM4GcuzaZZfPyV6vc2Zah8AY4WrvNU7YIWnZgaEDPWJZBi
         0URclWierbjBYeKM96/AhVogWOQrvfdrDyzYG+yRaOqeU7xtTM0HBY4hPNE2rX5rxoha
         swLXZXdrfwKVd2GYUON0yUxtUhB6JNNrq902yfqqZ5hag7cFcOBWpwkq6GJfd98QtVxP
         dbgWHPdns74cxBjyzqXv8briu5KGOXQXuJ37AIWU6d6Vjc1j0u0L2CBViSVKG/q0BCtM
         goGkgl7ZDgDhumMBzDgwFVL3DXGsTTFOlcE5rUJe4B1KW0hkEkYzhLU+Ffwl/aHgaA2V
         bAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768306280; x=1768911080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2o7SrVLdsl8TDvc6NPbp3VFvuvUwOgsiUE2PmdF56K4=;
        b=CeoxxAyO3cUvKDp1j4rEFEku/cfSLq7fUFJSckHV+txf6kFOS0O/TcamUBf6SWtLdv
         Yuhy3427HQKc9OU5lz6ytOFX1eKgqCyrY7ShXm8v7/Xs1ifT+pe5KuucCC1Zcep/Iby3
         xr4j6RL9eFNaeyAn6IXPrfpNQaMD8DpEhAHRNoq0oUqY3mpn7+PAA95mfoBD4uWRluTu
         5XdYEKRPsz3FtnGQBu5Q2/ocE+Evc2O98CAziKJI7uUW6zaXIhSZid2LIlVM5tBILeyg
         HTrR5KQWPJswDdCPIVGXcT1cA9dBupgiADnT4iCVA3djh9KlDRQBhLus7UmFthH8Ib6x
         iHnQ==
X-Gm-Message-State: AOJu0YzGSQqfpRdDtl13WDzVBKyq2cAc0Zhugqo023Tzf2z0a6tou0Mg
	GpUfe5RuUz5FWqjB2KkLqTLAYVSxAx2uiuG7MDNVkfW8Eam3U9UtzgB0
X-Gm-Gg: AY/fxX7SFWMRiFIx3kH2NCYtRtl7kITYOxXPB6reEztiuw25lLMbP6qvYVT5NZ3PUZf
	grM4guF/5djxY2l2gOOBy5lI2DahDwOIGVcNT47bOyDtbjXp4o5xR31o0ZhhCKpTGWiwxaP+Ai3
	XOsjKTpfFewIjrwUdEejioSFDm6kGfmdvyTY1pzpzWr9uiMtF0R2uBPFMxIstqm5cAuu4ON9ZNI
	eQZ5we2HAbTSrf4GJTWE7CvWWEgzXGUxogsLSx41s/+hBurT/m79WBrEOoX4NlMWWwOLUnTZ/HB
	4Nu+A+gMQARY/9yRhURlldJvNQVas5Cvqfc38OBChl1MsTtE6zkn8Ay4vitGDhXYHMVVspSutRh
	wdKg/LLUr3W/Nv1zuOs6eEX5QJDm7qsnkWKRK96kwewT3OOODYVFrB4Ly85n2rRXw+X8RgDk5su
	1ed7mQX/wd4sJDg0YDr0kgXl8OXCYKQoEKzDKdwg2aVag8+CaRORWlnE0cbZWdyPT2h55D0j4=
X-Google-Smtp-Source: AGHT+IE0oDv64PMMZiAI+MbfFzw3jx5H27Mbe6dL7CZU+ZkCO0XJ68S7gHk/xB0XXMPlP+qKHx7hTA==
X-Received: by 2002:a2e:8a98:0:b0:37f:9c07:7d7f with SMTP id 38308e7fff4ca-382ff708977mr54402821fa.36.1768306279593;
        Tue, 13 Jan 2026 04:11:19 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-382eb7cc214sm46757151fa.22.2026.01.13.04.11.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Jan 2026 04:11:19 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: phillip.wood123@gmail.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	gitster@pobox.com,
	haraldnordgren@gmail.com,
	phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v17 1/2] refactor format_branch_comparison in preparation
Date: Tue, 13 Jan 2026 13:11:18 +0100
Message-ID: <20260113121118.49541-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <d8ecb19d-8a17-4979-b663-a6d928709e4b@gmail.com>
References: <d8ecb19d-8a17-4979-b663-a6d928709e4b@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> I'm not suggesting we design the feature around 'push.default=upstream',
> I'm suggesting that we design it to respect 'push.default' so it gives
> sensible output (i.e. something that resembles what "git push" would do)
> whatever the setting.

I guess I'm still not getting it, maybe explain it like I'm more stupid 😅

'push.default' does not change the output of git status, which shows a
comparison with the tracking branch. I wrote the code to only report push
branch status when it differs from the upstream. If we use
'push.default=upstream' they will be the same, so no need to report it
twice.


> Thanks, I think that would be cleaner

It's in the latest patch now.

> I can see tests for
> 
>  - upstream differs from the local branch, no push branch shown
>  - upstream and push branches differ from the local branch
>  - upstream and push branches match the local branch
> 
> I can't see a test for the local branch differing from the upstream
> branch when the push branch matches the local branch. As far as I can see
> in that case we don't show the advice when we should do (and we currently
> do show it)

I added a test for this now, which I think proves that it's working
correctly:

```
test_expect_success 'status with upstream ahead and push branch up to date' '
```


Harald
