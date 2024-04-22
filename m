Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3493A18132E
	for <git@vger.kernel.org>; Mon, 22 Apr 2024 22:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713826452; cv=none; b=PGIBnPQByhjtY8hzvpOBvXNAJyT610U0LFpBdSm5ZAMO3898ej6zbLWDxpAqIfA0p1OnEeimDyeVMSLcl+yeZkktX0369D8QlrQaVnF28+iMIz6wc75ScMiW/XG7zcVyAMuu23Y2Xv+d1UVIzdW0Xv0r2qOuyYNLzCHKgKaFn08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713826452; c=relaxed/simple;
	bh=782ITABcjibzu6XpJ327ueZxKUGUhHkhSwdeziPOGXs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=S7Vm5FCDPRwKBuokLh+Nc+A9ObShv5M99Ev6QsweSeW48z7vUkXSMi1NAbwR6rum+uDs0novfoSyidHLX7ZGl8zHqF/HbiiYu2k5QgoSyWdykTxxFkD+1P0rc38RcdiQzTO/Fd1Ic7hILlkvu7e2WSmTi8k7kA3FzJUbUlP28Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJ73S+g2; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJ73S+g2"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41a70466b77so9503695e9.0
        for <git@vger.kernel.org>; Mon, 22 Apr 2024 15:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713826449; x=1714431249; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x1B9lLTHGH+HLm+8bch2P/Zz1SG5IoHSSc7YI+HONNo=;
        b=CJ73S+g2zBsRQlVslJ5zDkqEBQf9UJJk/R4mupiuA0OprbL2lXiPdH+0kS/gl4Dqj4
         jWXdxeRVqiyO4247JTBNiMTyNrX/ss27GgwkCUL3XMS60SaA7rMWrV/O45UM9kDW5mhI
         YxnSMDPniMvDp/BDpz2kOyA85uwJRxUvYUAyjD7hU31dpL41O5CwHdsETWwXw+XS24m6
         3qh9nAz9pKyiWlW158RuLWVVBWOevss+X8gnewYxp5/4AmHyaWbMOCcz/meFYEFfplsF
         W0sJd/StKnvqsde3DnqTAAVxSmLe08TjR/xBygPonuI9fYXZhR9dFtnejEpodYAVctHG
         JS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713826449; x=1714431249;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x1B9lLTHGH+HLm+8bch2P/Zz1SG5IoHSSc7YI+HONNo=;
        b=M01EveEZD5qy/hj5brF56gfX/yrdImTpCK/3CLkuRSWD88Ih+Ldfzbwffi66SYdARl
         vqaP0UJNJ47WT0xzSFmMqiR5MEafLlA4NljTEtERPhTmoullTYN2TAEIHiZyDodv/AtX
         P4In1oieozYhiEnmgAtdDhNJVzisS/VMbSig5weL6iotmfn7LIEH4P7pxJ319Z0yVz4k
         zuCZ0voEtXdAJa3OrfBTC65VZF26DV3ptcU/Ws3uccTcBKjLHMzs9pIb2zuHjWdFBIMD
         e4AkbUY7mggsqRLny7VzQsaVc04rmJo7DQy+2cJyKtaiXlgTsH2VC8oG/fj7kBeIyZ4q
         OGvg==
X-Gm-Message-State: AOJu0YwkarTL6JGBgR2EOVJyPby0A0MvhHC/YJ0hOsl6E/xQBC1uXcRp
	o7WgegSQFwI4cSS1lUmaiOErKdJ+BlwS+kxdlFPEa218s/50q+NyZ1xFSQ==
X-Google-Smtp-Source: AGHT+IH1aWfQWQflvkZ1cOnYPtAl2/MnFG2WbjearBGnF1Qds/QCJ23n2DDlm+YDymXvQEpV5kU3gQ==
X-Received: by 2002:a05:600c:4e14:b0:41a:aa6:b59e with SMTP id b20-20020a05600c4e1400b0041a0aa6b59emr5505988wmq.5.1713826449491;
        Mon, 22 Apr 2024 15:54:09 -0700 (PDT)
Received: from gmail.com (247.red-88-14-44.dynamicip.rima-tde.net. [88.14.44.247])
        by smtp.gmail.com with ESMTPSA id q15-20020a05600c46cf00b00416e2c8b290sm22082853wmo.1.2024.04.22.15.54.08
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 15:54:09 -0700 (PDT)
Message-ID: <791e97af-f233-4c06-9c5b-2b9ff758736e@gmail.com>
Date: Tue, 23 Apr 2024 00:54:08 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 2/4] add-interactive: plug a leak in get_untracked_files
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
References: <b7b2d0d2-245e-440f-a7cc-fa0df1ce73ad@gmail.com>
 <69f86760-96ff-4c62-9649-4627652b7c19@gmail.com>
Content-Language: en-US
In-Reply-To: <69f86760-96ff-4c62-9649-4627652b7c19@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Plug a leak we have since ab1e1cccaf (built-in add -i: re-implement
`add-untracked` in C, 2019-11-29).

This leak can be triggered with:

	$ echo a | git add -i

As a curiosity, we have a somewhat similar function in builtin/stash.c,
which correctly frees the memory.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 add-interactive.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/add-interactive.c b/add-interactive.c
index 6bf87e7ae7..e17602b5e4 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -865,6 +865,7 @@ static int get_untracked_files(struct repository *r,
 	}
 
 	strbuf_release(&buf);
+	dir_clear(&dir);
 	return 0;
 }
 
-- 
2.45.0.rc0.4.gfff7e48949
