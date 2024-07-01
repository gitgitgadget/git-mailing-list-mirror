Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61B916FF28
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 19:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719863063; cv=none; b=IFt9Bq0aQqidBnK/f/ebUwX6VAmB3NP+dFemDiHyR4wNK3Lz3rTZqyLe6M0qb7dZnNEOfLdbSjrYpXr0/cN50nIxp6ntlSYvMj6UYjiOTC0SmCfek5x4cP5dhQcO/R1AXbtPixw4ERc5ACOqzWf1AHmquJdsQGsUlkApBPNtNXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719863063; c=relaxed/simple;
	bh=eZGsh5JLjSQUHjuHdyNUreVXRrjGSFj3lau1MDo6EDM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rd5RAlI/E17903AN9yqJh7QMClDqqqdn6CJZXNVGRyfXPWBJgwf3rSnAYhtXZDRK28ywvBK9e6j2AiDj5+2WXmvzWwI495znxDl/unAspeZpr3uCb/oYyaV9gRK2ZpsxFhDbfrKOz4Xo2aFusmzcmCqvx2Qu6PLIJmeC43l0EpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q85V/ldd; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q85V/ldd"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-424ad289949so25071315e9.2
        for <git@vger.kernel.org>; Mon, 01 Jul 2024 12:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719863060; x=1720467860; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Gd7HY9a+90cf+TkEqaae95/vopSlUuiQ2iAYuvd6OVs=;
        b=Q85V/ldd0cTEx8Q6roFQ6nSK6hC9VbdzFOeG/rh9SWtawbSu3H6pglBgZyQKrwYBL0
         n97Q+mAeCV9E2wx/WU3qvJI69jAgjyqlqm97pOlC5a8ChJCjHyeoSSon0yjkc4R4tjXJ
         IW1CoY+/1XlmKoV2Lxz7K2bGOhc9pVV8kTt0AV2rn7MXJ85qUxke1gL/0c0yMRKVuG7H
         Zmm8f132802XPPRyh96RSL55YNLDx/tXlySRAEwA6MTN1u1dUKTOtnk516R0acCABm1o
         pbYPSjP4LsM+pKbkdWBLe8MZDnlWzPqF9lkMBJKk3wXpPHlT/StVE1T+KxTrV8qOGqFU
         jpkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719863060; x=1720467860;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gd7HY9a+90cf+TkEqaae95/vopSlUuiQ2iAYuvd6OVs=;
        b=TVj0yoAGQpk6NuX2BFoNQkk8iJ9cvSpTf2MOq6orYi2uRtSsT0vNcNX12s+ZPnYse/
         yvmLe6K7DobwZNPcvnxH+ZypLBEsUyosqv79BkLJK1Z282cEg6FtFr0lZ1/VUqOu3xqb
         XDh89dWlMo6cKV0/9bFrrqzxaUUfXpM/0gcLBDKCEH6Oon9w50KKK/OS22sYnO2SZ3ur
         pLS+r9iJigon6/JErQu01jacJtfoaBNxF2/McLDqFhqRdQuc02zxQk7QFKs9MjS9OU+2
         t9hTUeBELtP+/XbSI7kwCvPiGpIZWQoAva7H1nWZyaumU/HadXFi9XbjCHXisvm2wK3y
         7nWA==
X-Gm-Message-State: AOJu0YxBAUBZEV9F236Ve36DMVcDlgMpxPKDFLL1ZNZuKG6RXmvYx3PW
	MvuIEcWo6U6JKSB7XPl7PKc4YXl8ElJ1zsJT04bbVgsWIBuNyMT3
X-Google-Smtp-Source: AGHT+IGkoBy0eGHN9GcMeZ1uFTmc4OtPOECrB7XGGTjI/HnPZN7EpRjqR1W4SIku38Vib/9ZQw1WKA==
X-Received: by 2002:a05:600c:2312:b0:425:6275:f7a with SMTP id 5b1f17b1804b1-4257a0098b6mr50507035e9.15.1719863059964;
        Mon, 01 Jul 2024 12:44:19 -0700 (PDT)
Received: from gmail.com (82.red-88-14-59.dynamicip.rima-tde.net. [88.14.59.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42578578b69sm115090325e9.42.2024.07.01.12.44.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 12:44:19 -0700 (PDT)
Message-ID: <86427b9e-9574-4e61-890a-691779a8da82@gmail.com>
Date: Mon, 1 Jul 2024 21:44:18 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] t0612: mark as leak-free
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Jeff King <peff@peff.net>
Cc: Git List <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>,
 Eric Sunshine <sunshine@sunshineco.com>
References: <23d41343-54fd-46c6-9d78-369e8009fa0b@gmail.com>
 <20240701035759.GF610406@coredump.intra.peff.net>
 <7ef69875-b18f-4ccb-be83-e994315636bd@gmail.com>
Content-Language: en-US
In-Reply-To: <7ef69875-b18f-4ccb-be83-e994315636bd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A quick test tells us that t0612 does not trigger any leak:

    $ make SANITIZE=leak test GIT_TEST_PASSING_SANITIZE_LEAK=check GIT_TEST_SANITIZE_LEAK_LOG=true GIT_TEST_OPTS=-i T=t0612-reftable-jgit-compatibility.sh
    [...]
    *** t0612-reftable-jgit-compatibility.sh ***
    in GIT_TEST_PASSING_SANITIZE_LEAK=check mode, setting --invert-exit-code for TEST_PASSES_SANITIZE_LEAK != true
    ok 1 - CGit repository can be read by JGit
    ok 2 - JGit repository can be read by CGit
    ok 3 - mixed writes from JGit and CGit
    ok 4 - JGit can read multi-level index
    # passed all 4 test(s)
    1..4
    # faking up non-zero exit with --invert-exit-code
    make[2]: *** [Makefile:75: t0612-reftable-jgit-compatibility.sh] Error 1

Let's mark it as leak-free to silence the machinery activated by
`GIT_TEST_PASSING_SANITIZE_LEAK=check`.

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Rubén Justo <rjusto@gmail.com>
---

Now with the correct subject and the correction to the error pointed out
by Eric.

Thanks.


 t/t0612-reftable-jgit-compatibility.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t0612-reftable-jgit-compatibility.sh b/t/t0612-reftable-jgit-compatibility.sh
index d0d7e80b49..84922153ab 100755
--- a/t/t0612-reftable-jgit-compatibility.sh
+++ b/t/t0612-reftable-jgit-compatibility.sh
@@ -11,6 +11,7 @@ export GIT_TEST_DEFAULT_REF_FORMAT
 GIT_TEST_SPLIT_INDEX=0
 export GIT_TEST_SPLIT_INDEX
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 if ! test_have_prereq JGIT
-- 
2.45.1
