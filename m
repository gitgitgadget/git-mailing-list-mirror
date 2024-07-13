Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A598139CE3
	for <git@vger.kernel.org>; Sat, 13 Jul 2024 16:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720887966; cv=none; b=kghh//EnGS86qr7MVgAbsLqM1RMNeqkaSZnvzf7/ajxppAbm8HkHPBcEXsjV3iMwzNs6MrFRJaOVuOsYACfUFs3hLqW3F1nWUDLUBjW0cvIGxXgxkXNT4R1q4Y5dRYQpjyAL2quFR6e7qH/8+xhpc8jZISnM5817OaXfUE+rQ/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720887966; c=relaxed/simple;
	bh=w/187xnG9elwvHdLpVh4hSLP3s7GuAOdbH72IcQUAOc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qZIPzdYlYWzhUhQSs7mTuHIMxjwUmCj6D6y806XDN37aaD2IkZlI3RVGx2+kzVTUAx/oJgvvrCYziheYy4Da3F1UZOdRjrRVSYi3FYwonWXR/cJMgICIBJl8jyI9DgV5xOiKQdXL1L7KVr3fzocbbW4R1bOIUHnLQELtxAxxrCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aGeJrQTu; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGeJrQTu"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fbd1c26f65so17623515ad.2
        for <git@vger.kernel.org>; Sat, 13 Jul 2024 09:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720887964; x=1721492764; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UWvEnZt5p1zNWnnjSeqZWVI/pIW52FCSqPvmNZoxcEs=;
        b=aGeJrQTurV5F/LgXoo05u1q/q7CzyxbFFcefX8kIXBzdNLvWWPuockLEjr1JKi/t7e
         V+GoN8PvCEgXy0aZQJFQsD/dDNcPk05grkFnAcgXZFIsdRW9x8m4L4xEWsItIW2k+ykf
         0oTx6l2g14kAcgh3O0wHYhqM3epIStubVX88poEycRoabE0yDCRhDOuU2613sCpzx75D
         iyXWqsOu3MqbAYfwCwhVoEEbdupsXDtW+60iH5h11n2elOgMGDB6S6cvsu4Uq78sxJdv
         YbepuG5ky5QfwoCqItiKXYl/SerrdTzDRvO8lBVVUunff9//UOu/tugt7a8b9zJJhNO0
         tbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720887964; x=1721492764;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UWvEnZt5p1zNWnnjSeqZWVI/pIW52FCSqPvmNZoxcEs=;
        b=lglaL2ehbD12zV74/Gwp4LyhUryeyjP6pV1Ubq6eqfsoMcrZro27W32OaJG5xRGRBF
         0S6cO52VcDYPeKWW6W9JrID/5LQugGaW/dWDooigphtbQrSbqCkug0USQP/+9u8Lvexr
         iIb959q8BOnkU+OMV+vokxukxoImltRCEJuygSg3//y5e84Qo2ceFXdIjxFvuGhYQK2E
         dL19rAEpAHzLYsLFagSIvmb6aYf/rJiWUXgp8ZIDlN9TN2ZelFDN1CboqRtlpVgJAP3T
         utU6iwZM5ifdNG8oQCxsJ/aoJkBbk/dKKOeqCKltgiqUyycX9Egr6kQ4i/+hkr2/4ajK
         /aUw==
X-Gm-Message-State: AOJu0YyPrCJQcOwGuhgjNKHxXxPK3lfIiP6kSh/5CIcr0RyiQ7nJKwU1
	UzKlm8W0N5PGLeex+u79ZEpVVhSIReZ5tm7jiZyfjlvL/4T1XirsZcP1OQ==
X-Google-Smtp-Source: AGHT+IEtULzesbZ/twGFKQ8+z5muqeNb9DGLEuVGbJphdLK4+NFX3eQ+OrZnBl7KtVVyvfxj2MkMwA==
X-Received: by 2002:a17:903:2443:b0:1fb:8e00:e5e8 with SMTP id d9443c01a7336-1fbb6d24f9fmr130466495ad.10.1720887964294;
        Sat, 13 Jul 2024 09:26:04 -0700 (PDT)
Received: from gmail.com (p4357013-ipoe.ipoe.ocn.ne.jp. [123.222.98.12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc43febsm12090775ad.234.2024.07.13.09.26.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jul 2024 09:26:03 -0700 (PDT)
Message-ID: <ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
Date: Sun, 14 Jul 2024 01:26:00 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 0/4] use the pager in 'add -p'
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
Content-Language: en-US
In-Reply-To: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Rubén Justo (4):
  add-patch: test for 'p' command
  pager: do not close fd 2 unnecessarily
  pager: introduce wait_for_pager
  add-patch: render hunks through the pager

 add-patch.c                | 18 ++++++++++++---
 pager.c                    | 45 +++++++++++++++++++++++++++++++++-----
 pager.h                    |  1 +
 t/t3701-add-interactive.sh | 44 +++++++++++++++++++++++++++++++++++++
 4 files changed, 100 insertions(+), 8 deletions(-)

Range-diff against v1:
1:  4a5b6e6815 = 1:  6b37507ddd add-patch: test for 'p' command
2:  bf8a68ac37 = 2:  5497fa020b pager: do not close fd 2 unnecessarily
3:  aabd7da4d6 = 3:  30e772cf7c pager: introduce wait_for_pager
4:  ff51cc32bd ! 4:  f7cb00b654 add-patch: render hunks through the pager
    @@ Metadata
      ## Commit message ##
         add-patch: render hunks through the pager
     
    -    Make the print command to trigger the pager when invoked using a capital
    +    Make the print command trigger the pager when invoked using a capital
         'P', to make it easier for the user to review long hunks.
     
    +    Note that if the PAGER ends unexpectedly before we've been able to send
    +    the payload, perhaps because the user is not interested in the whole
    +    thing, we might receive a SIGPIPE, which would abruptly and unexpectedly
    +    terminate the interactive session for the user.
    +
    +    Therefore, we need to ignore a possible SIGPIPE signal.  Add a test for
    +    this, in addition to the test for normal operation.
    +
    +    For the SIGPIPE test, we need to make sure that we completely fill the
    +    operating system's buffer, otherwise we might not trigger the SIGPIPE
    +    signal.  The normal size of this buffer in different OSs varies from a
    +    few KBs to 1MB.  Use a payload large enough to guarantee that we exceed
    +    this limit.
    +
         Signed-off-by: Rubén Justo <rjusto@gmail.com>
     
      ## add-patch.c ##
    @@ t/t3701-add-interactive.sh: test_expect_success 'print again the hunk' '
     +	test_cmp expect actual.trimmed
     +'
     +
    -+test_expect_success TTY 'P does not break if pager ends unexpectly' '
    ++test_expect_success TTY 'P does not break if pager ends unexpectedly' '
     +	test_when_finished "rm -f huge_file; git reset" &&
     +	printf "%2500000s" Y >huge_file &&
     +	git add -N huge_file &&
    -+	cat >expect <<-EOF &&
    -+	<GREEN>+<RESET><GREEN>22<RESET>
    -+	<GREEN>+<RESET><GREEN>23<RESET>
    -+	<GREEN>+<RESET><GREEN>24<RESET>
    -+	 30<RESET>
    -+	 40<RESET>
    -+	 50<RESET>
    -+	<BOLD;BLUE>(1/1) Stage this hunk [y,n,q,a,d,s,e,p,?]? <RESET>
    -+	EOF
    -+	test_write_lines P |
    -+	(
    -+		GIT_PAGER="head -1" &&
    -+		export GIT_PAGER &&
    -+		test_terminal git add -p >actual
    -+	) &&
    -+	tail -n 7 <actual | test_decode_color >actual.trimmed &&
    -+	test_cmp expect actual.trimmed
    ++	test_write_lines P q | GIT_PAGER="head -c 1" test_terminal git add -p >actual
     +'
     +
      test_expect_success 'split hunk "add -p (edit)"' '
-- 
2.45.2.831.g9e4974e3d4
