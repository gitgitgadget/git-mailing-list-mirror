Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7211E4A6
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 17:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721236848; cv=none; b=Ooz9HQysFwHylApHl1JZl/qsIU0dMoubbAKpFu+Twj1aSdqBTD7FvdkwalgOeOng86pPv01kYK/t6Vlma9KdeVgWZinkHk1xYSzc8IBZeWBzw67vWWwSbVLzsRyaCfPRGFUPNhw66OWU/Jqme3VQq7AwOJpiVitlpsd+YCAjFdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721236848; c=relaxed/simple;
	bh=asj0918QInPIPw/wWv4cL6sFDL/oJS+pm3I1VKzuAzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pbWgVRYP+MT5HZgenLqOSckYLp/thiq5pPUf5DELxYdvocU7Nc0ZPTtz2A/WBBjk0wY15k1mxHy++fJYiRe3JkchMllCwkQPpOpIPMgY7E+L0fur3B2X4NIoFHEEU3u7jQ4qKZKFn79DpY1hJWo19pbxy3t+Rf/WVmKKIl5nowU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hA5D0AgX; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hA5D0AgX"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70b1207bc22so5906570b3a.3
        for <git@vger.kernel.org>; Wed, 17 Jul 2024 10:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721236845; x=1721841645; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FX2ta0A7ImfJ/Kb9EzSkhLNTp/WRNMm6vBif/b56EkA=;
        b=hA5D0AgXw1njP+1f+oLS0sQVitbZ6kPje+HY0WO5JchI0td9VtBMGZB42hazF9QcAf
         wYcDqlxcbo1JgXHvpsUgK3wTx1FH+OY+ukoNpWFvrAN9xQy7g5D0URX2iE2D0roM3v1g
         AWw8w26pc+bc43Z2BHWN31s6oOivST4I4c/b6zjhdpiqtrA56kMhCVI5nuqPTsA1JgWM
         tyhpodQo/v1iCK+rhD4WtNBTU0ZX/kMf+KMuObLA0KCAVWOdjiwfR/DP28NmNlv7uef3
         broEi+LZ0DkQ0qSPyoxAp+B2rR7V2IOHgzgE/BPCvngit+uR776+K4+W0WukmMDBco1b
         r7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721236845; x=1721841645;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FX2ta0A7ImfJ/Kb9EzSkhLNTp/WRNMm6vBif/b56EkA=;
        b=wQPxgtT1kVGikXap1fnf7dcUdx6YBZgIbGbRco8nmADDNclOblAk011VKOtk+764zh
         3BL5kkH8mRmm76VfA6lVKeGlZs7gkrYH0pHkk86z/cTkcfc/HOobYQgsY+lSznDxSZqK
         sCvd/r3DBWmNM3sBSnHgZA3weuBn9h4Bm2Ab6G2BINWzGjNoVWxJiglmxztUHax5PPxZ
         5YHCEYd+C0kFbAGsLsciy+KFxwvbnZje121WWFZn+s+o4Cct/aFobeVqqf/Mnj8XQ1Vm
         znlRpOji71gS5CxGgEYg801opisd4bTRSTIdTMZvVkOh5sdP+hjCA0LtanAmMYF8oaJu
         5+KQ==
X-Gm-Message-State: AOJu0YyrOen0wMYgO7Z+DBeIXxzlJZmpEFyndeMXyX7xYQFVLlxw0GI9
	/uNloHzUxHOu2m3HywgHM4nG501b3sUWGkrbHng8cSFN+PRrUUJRMaYakw==
X-Google-Smtp-Source: AGHT+IFnVzTUkFY1y7AS21M9F6YMEj/y/4U4OyR8EYgkrIgU/dPvj1r40kSYDdfAgfeh6ZmjoxbfmQ==
X-Received: by 2002:a05:6a21:e8f:b0:1c3:ff33:2471 with SMTP id adf61e73a8af0-1c3ff332722mr2677945637.8.1721236845347;
        Wed, 17 Jul 2024 10:20:45 -0700 (PDT)
Received: from gmail.com (29.238.148.210.bn.2iij.net. [210.148.238.29])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc271a9sm77944265ad.172.2024.07.17.10.20.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 10:20:44 -0700 (PDT)
Message-ID: <2b57479c-29c8-4a6e-b7b0-1309395cfbd9@gmail.com>
Date: Thu, 18 Jul 2024 02:20:42 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] add-patch: render hunks through the pager
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
 <ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
 <efa98aec-f117-4cfe-a7c2-e8c0adbdb399@gmail.com>
 <1dc9ebad-768b-4c1a-8a58-8a7a5d24d49e@gmail.com> <xmqqttgqyzwa.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <xmqqttgqyzwa.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Squashing this fixes the test:

--->8---

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index c60589cb94..bb360c92a0 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -616,7 +616,12 @@ test_expect_success TTY 'P handles SIGPIPE when writing to pager' '
 	test_when_finished "rm -f huge_file; git reset" &&
 	printf "\n%2500000s" Y >huge_file &&
 	git add -N huge_file &&
-	test_write_lines P q | GIT_PAGER="head -n 1" test_terminal git add -p
+	test_write_lines P q |
+	(
+		GIT_PAGER="head -n 1" &&
+		export GIT_PAGER &&
+		test_terminal git add -p >actual
+	)
 '
---8<---

However, this error has exposed a problem: calling `wait_for_pager` if
`setup_pager` hasn't worked is an issue that needs to be addressed in this
series: `setup_pager` should return a result.  I was planning to do that
in a future series, for the other commented command: `|[cmd]`.

I'm wondering if the best way to proceed here is to revert to: 

diff --git a/pager.c b/pager.c
index 5f0c1e9cce..5586e751dc 100644
--- a/pager.c
+++ b/pager.c
@@ -46,6 +46,8 @@ static void wait_for_pager_atexit(void)

 void wait_for_pager(void)
 {
+	if (old_fd1 == -1)
+		return;
 	finish_pager();
 	sigchain_pop_common();
 	unsetenv("GIT_PAGER_IN_USE");

Which resolves the problem.

This was a change already commented here:

https://lore.kernel.org/git/3f085795-79bd-4a56-9df8-659e32179925@gmail.com/
