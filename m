Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9002AF1E
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 20:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721074621; cv=none; b=fnHySL5rGLvgJhDlDLYzJsG4kTbp5yq+9ON/UbPvSNJoAIzvSJseG8mpP70Q9PqSowTL+FMV8raUtCh1ycyAJjqAOHjOhz4c3QI9Qnbqb7zk47jlWGHkUF46Z2DHnulB/Kt5nsaxRTmouXDc3M63U2RehZn6yVDEu3luEWmNqmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721074621; c=relaxed/simple;
	bh=yhTDLWpx8uPeTYdNZpFMlj2ZbCzenjebYjaSL+OHFbI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=SN1WjT1DtyrwW0BaGue85u5wjtAQS93cmH1jB25t/htPEsC0QjTbXwLxhKZKnoXJNgr3KoWchz2Xv6oz9prpu9zvZwbmH6Ri1Cic7HJ599PalzCjPdDDaP2lT9d9BozrPB8a3sOS+iiD9q1+woP2R/5WYEer7P8SygaKUxIcouY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPc/3cb/; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPc/3cb/"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70b4267ccfcso3529733b3a.3
        for <git@vger.kernel.org>; Mon, 15 Jul 2024 13:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721074619; x=1721679419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5bRG4bQ8IHEkOJrYeFSzdf5TdJ9gKyML12FWszXlbXk=;
        b=aPc/3cb/t5yT7zEXAk1pxfL+IRG2gsJ8TqKNAt/GK55LXI1FVLIjU1etmh7NdHBw6h
         RDqIQB2KooDFkm7ts1GcZrhvrR95M/GbfIVhajVxfoIjK+eAdy1PLQeWy/LfGWBPcO5W
         todMTY5UhMJZC6yOPx3Ky98eSd+B4s+6P8N8z3M5m+1wNfwl2G9+J1hIQzrEIG+03GtD
         VuzvM1JcqS/hMamRRtidZUBu6RvPAaKx2WbH17T7Gaa1qhcbedkbkry2Yy1xwZ/sOhzG
         uq5a2pHbNaau7kgAPi0zEPOm+kPIiwK+s4ab/GtXZrxUDiwq87RCpzHfAVtv+P9KavV2
         FPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721074619; x=1721679419;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5bRG4bQ8IHEkOJrYeFSzdf5TdJ9gKyML12FWszXlbXk=;
        b=FjfELuoZn1UxnCDqIrd2rOP9OInyMlHkE1EuR+ppCv2/+lyIxtVpz/c/KUcdRuJXai
         hE9iLNblEmFc1Gx5MgZrMRms2HN0tg3GZQXOHl/WUXYemFVt1xgPfjl8prrvpa4ysyjg
         1e3dVBGgjlx4clmQCau2wFzQ/rpWyEDNhNxhMHCt7EKjVRVxIV8WP/wcpET5Uee3qPiM
         L4XUVARW5ITy1hBwZoMykle6e5w6fOr3FwaJbbD6AZXZ7NO4wIy9nMN65o7hSBLwyJlO
         KoNqN7kP8wHgw/VqfHwZiL8wf73wsUMlU5EZQZZXDH8CryML1fozlU2HqhujhrTPNJSK
         B9sg==
X-Gm-Message-State: AOJu0YyXGjc6+XZX/Z/SbLTsmTsPGPMVnuoUbtoXTe1BpNEJ3CjBg5Xl
	WnV8/lxGipa1EYFiPBZLfhNXC0kTF71bPQEWk5bxPspnYRJ8cYSXWAxZ6Q==
X-Google-Smtp-Source: AGHT+IGwIhz0AxVjnWo2i5WJ61rFakL+PRW4jiuBINl0x8I6NNtAp6xPddheBc5rFJiHkPp449EZtg==
X-Received: by 2002:a05:6a00:b4a:b0:706:7052:205 with SMTP id d2e1a72fcca58-70c1fbae7e4mr199280b3a.18.1721074619264;
        Mon, 15 Jul 2024 13:16:59 -0700 (PDT)
Received: from gmail.com (p4453252-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.169.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-78e338dcb64sm3714095a12.20.2024.07.15.13.16.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 13:16:58 -0700 (PDT)
Message-ID: <a70bddd4-ef2d-488e-a2cf-48515f5df357@gmail.com>
Date: Tue, 16 Jul 2024 05:16:55 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 0/4] add-patch: render hunks through the pager
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
 <ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
 <efa98aec-f117-4cfe-a7c2-e8c0adbdb399@gmail.com>
Content-Language: en-US
In-Reply-To: <efa98aec-f117-4cfe-a7c2-e8c0adbdb399@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Make the test name more descriptive and avoid unnecessary redirection.

Thanks.

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

Interdiff against v3:
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 2ac860cc42..c60589cb94 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -612,11 +612,11 @@ test_expect_success TTY 'print again the hunk (PAGER)' '
 	test_cmp expect actual.trimmed
 '
 
-test_expect_success TTY 'P does not break if pager ends unexpectedly' '
+test_expect_success TTY 'P handles SIGPIPE when writing to pager' '
 	test_when_finished "rm -f huge_file; git reset" &&
 	printf "\n%2500000s" Y >huge_file &&
 	git add -N huge_file &&
-	test_write_lines P q | GIT_PAGER="head -n 1" test_terminal git add -p >actual
+	test_write_lines P q | GIT_PAGER="head -n 1" test_terminal git add -p
 '
 
 test_expect_success 'split hunk "add -p (edit)"' '
-- 
2.46.0.rc0.4.g229d67bbd7
