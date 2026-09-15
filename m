Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5090331EC0
	for <git@vger.kernel.org>; Tue, 15 Sep 2026 22:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789509752; cv=none; b=m3K3TcaGpzAcZqjwGjh4Wr0AYaQGTAFij0qjQttXzKzB6f78WI2jaQaiwIqGgQ74HixIYi1yao0v19KfAGM3yxMXGJccEemYanUhWNsJlynsgtpBu2N3fx+3WrZK70uh4JOdv9COUELHH/SNftGqKDt1NMKMAWZJuWlYoDnGrNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789509752; c=relaxed/simple;
	bh=fxpiutgLyfOuoaPX3z5u+lKvrwvn7aHPp6QZHM0hG/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qWjcWuxXNlMEBpmQfSkpwHZ5AtslqxdWEl70NhemJRSNSxQKfs4mX5QsTEbFHqziTXpVK96+JMuY/9WlMTon9cBmsyF3zvJofZBlAh3SlsNhO9ORE3/OPQ4UcFTT6OmBMSvd961a+KeN6n2N/QZPETR1Gcf2UcUTRjhq7+bJbRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEtYBlpY; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEtYBlpY"
Received: by mail-yx2-f13.google.com with SMTP id 00721157ae682-8716a5baf64so2452487b3.3
        for <git@vger.kernel.org>; Tue, 15 Sep 2026 15:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789509750; x=1790114550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0qFbq4XTc/6PKP+0AB4mzYIWHZzPoknpDAF9fTBlXoI=;
        b=cEtYBlpYqsGaNnu2rR996SRuAtcqXAoEaUat9mgCnlYtuWBu8dlnnk6EtdCa4efzhl
         ktxQdb5XE7xXGFFhcWkiA1P8tpLP3kvKOaaFkA/saU5wDUAMNcI2HsqtTb8cX7fA5Ev7
         1ETsE04GkzVAznLrXrQgbMEYZruz53EmK8Th1ueeAOfcq8vm1Clw7ZYrF+Mb9ftERa8T
         Dj5hGq51FMyTOGIkzuMBR5uaagC9+a03VVnF2j2Z17nMtPM18QWH2vLwjR3ET0RiwidD
         h1aslVMkMjPuJunugzEX7Nln/PPIRxGKyfEs3mohOqyUn2NyDVX4nPYObcslQHgEgFth
         kkyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789509750; x=1790114550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0qFbq4XTc/6PKP+0AB4mzYIWHZzPoknpDAF9fTBlXoI=;
        b=v6HuDPa6bmdAogJvwN29mXHOPV5qDpsoo2NTOaRfikiQr1UlzZqtuNZht/yiVPLr1h
         Lw1YzdnfCpRe6G7nl2lwyIxOEiuMP3HDwTuW42QUb4/3mEQVuBRPGQubT7roEwNBpeSv
         WeW5vdn+o2D2LAoePRSqPT2MacPt1dQeFA/9dV/XRml4ss+FFBnZ8A+mloZoV1x98XDp
         LCfWPW4flmRuM0vYLMNzOGYl4eny3VrgNDBWUpbCMNoaF9aD097FLiJaupMWIS69FGry
         ZSu38tgiSh7LrtZerPMkqYnNmQ+vWHneWODXWVi3YphVqkHgyeTs4d4fq2gCQYNBeGpr
         iVaQ==
X-Gm-Message-State: AFuF++mH1fNdbQc9uKi/1o6vKm+z1BIpLHJ4isHPo8mzuzz3U48WWP7f
	AIUz5MAbBulcNCyUXnnFjAOS7D5oP081Y9SxzRLLyoI1ifqJkRpyxrpg2XJrjljJfbI=
X-Gm-Gg: AYBFou1BCmkmcgfgwvQLvj/Ot+2CHdQIQqQHiFIoGTWop2NOUatsdS+xA3/M6YqylaG
	khCV3VzCwpcb4EqP7i9STyDmPGUAmGLDdQEfMctjp45hyeYY3bXpkWQMBYD5AAzznhfrKh0Bv3R
	urV6VhEndGrVtKYcsuYuOXArsz8bpix12VVTRYHrDkSJBRtH4Lx/q/w6SiZALB/1WSfuSj/kJ9S
	PLf8Uu4xkWY+u/mFtV5P7CHT92ZEth9zmRcI5pCryTn3lbnaGrlbsUhfr+EsGeTIu6sZtlAWRcO
	y6wl7Xtgb7IxtU5qw4O+lWMK77uOsZa8TYjV4IeZoBmVWQ96FBZvMrWQ4Hu9vkCcL6BBsof19QN
	GD16wOZkme4bxdu262/A7Dk/4stKJkmUM6uk+4ssSqQkAuRExAp2FwzVjDDrFqb/HRRwPHOG3cu
	8d1qHUprXxti9xpni/G2fL8GuOTnMyuhlzKP5yX1r+qV/NGpnEhRMma3NAI/RDni2Q9wjPRus5N
	S6WF2MBZWJ/97LagjVBs7xl2/s54OZUJKWlwZkf1BDm0vagGWH2LvVVH18CCzpK2bIXA4c+rdpO
	/eU679NJ/a13ryC4wR90vKe3mRP4V2OjRuOqjfsoIvBtGPsCNA==
X-Received: by 2002:a05:690c:6d82:b0:873:5bb2:6c26 with SMTP id 00721157ae682-89228add246mr1340547b3.45.1789509749543;
        Tue, 15 Sep 2026 15:02:29 -0700 (PDT)
Received: from localhost.localdomain ([2603:7002:a00:5733:a91f:bcfb:6325:9373])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b81cefc98sm58345585a.33.2026.09.15.15.02.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 15 Sep 2026 15:02:29 -0700 (PDT)
From: Andrew Pleeter <andrewpleeter@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	Phillip Wood <phillip.wood123@gmail.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v8] var: support broken-down idents, signing key, multiple args, and -z
Date: Tue, 15 Sep 2026 18:02:28 -0400
Message-ID: <20260915220228.42819-1-andrewpleeter@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <xmqq33va1lcg.fsf@gitster.g>
References: <xmqq33va1lcg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Junio,

Thank you for the guidance, and I sincerely apologize for the lack of
communication. I had posted replies on the GitHub pull request and did
not realize until now that GitGitGadget does not mirror PR comments back
to the mailing list. I certainly did not intend to be silent or ignore
your reviews.

I completely agree with your feedback. Packing all of these features into
a single commit makes the patch difficult to review and overcomplicates
the history.

I will restructure the series for v9 into three separate patches as you
suggested:

1. Add the -z output mode to git var (-l and single-variable).
2. Teach git var to accept multiple variables (argc >= 2) with var=value
   output.
3. Expose the broken-out identity components and GIT_SIGNING_KEY.

I will send v9 shortly. Thank you again for your patience and direction.

Best regards,
Andrew
