Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAF83F39FB
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 09:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590168; cv=none; b=IH2SXy60mh+jnJvsLQHmGzZBAXY0XkTd8EnoNw1ZjWK77hxv2ZOXQCm4yfhswdMcW1athIVEE9RCnJmaew9TxIf3TRfftWzmD0onCK7bejaGuOwYypYQojAznZhN8vlTdTyfG0GzaZLtiGkUArpiIFG0wTOjd2oecNDXz/lvJ0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590168; c=relaxed/simple;
	bh=J45cIBCD/CJX+cJQg5BTK1qg++hPlZoPMVsoiJ7NKhk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZuS8+KcVGtpzxuF04yPtKKAuN7AIC3V9ecO3f5MK2IsKcRIHkPJhhJ4kULgNDs8SK2eIuqCSeDIfRAbTugYHxRbuep01Jjmuk4wm3GaNILGRkWVCCmPVEceoScK77TTXHQyzF0MMCHmBQrM88Mrzzw7GiraT4qBOuZes81HRa28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYs3AuiB; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYs3AuiB"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92e5d6f35c1so134246385a.0
        for <git@vger.kernel.org>; Thu, 09 Jul 2026 02:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783590165; x=1784194965; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3/AZZzpJ9qPAtx498qquW55OXxDQhQBchm9shD4ykVo=;
        b=EYs3AuiB8O38Xg+Ya++uQx8WiI/1EQd0lM9fOFXAT/iE7Skle7ApSbr7rUCcmdFrB9
         7z6JDaqVpMUIUybu1CfDIAtBF62sY+c/96/J8iKhjo69Dk74VVQUi6RWf6BOIOPqc0Ja
         HSKsy2qjgasZRlVGmHuremoOOFMQXlR5AS5TpgelD/x7xix2YF3+LrkU2T9YS3v7UM3S
         sJON5b2ggl8H9Ro+9y09t+VNkU+/blkTe28gq/FaC6bWAesKXWuFjunyTrPqzkzFP6f7
         E8NUbpNEgPvxdZooDkGA3OiG6Tx03y0n6LjkUMJ9aKwhwQ80hELzc21gcn5JVJMjR89T
         cEvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783590165; x=1784194965;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3/AZZzpJ9qPAtx498qquW55OXxDQhQBchm9shD4ykVo=;
        b=CE5vlBra+Nl0tkfhEXaDCNN1d2AQBdGAAmTP8LP+z1SPB27twoJLvR9C+FzFwuQVVO
         uJBviwAJkJRB9l12Z8izeBpffi5Rg76a1JeIZoQNwWoLHNiOdGbj6DHgiVrC11DzGfFz
         YaKw6xzmcoFacX5kJLmDeiG5Ng140vZZSpYVwkF8hS6B+Tod2vsoyXOCXT2Ecwl010rQ
         U3kgoA+wY5/VirgyaM8uCmYt2d4eQkceVG/o750MKkbEKEZICH7Y8mMUFvX+wCzophQc
         1om+zdOadUKSOxLdfU1vLE2AiZLy+VpwflKyi0S2Osnh5eqUZxKshMvu+qDhSCFG9GnW
         lj3Q==
X-Gm-Message-State: AOJu0Yy+FSZOg2cs+kpz5Rk0/c7SG+x4cG5ggEUCXTwTZcSrgS67xKvM
	P3lPzhUeDLu0WNDvdjVdyaUp3LN1a9AIEkF29plBc2wYr+10RNgiwdKZFO2N7HWe
X-Gm-Gg: AfdE7clGuDz1m0Q7dYTnsrh+W7ndc6l9ucKaWfUAg7s3Gl34NaAyHJWtdX8NGamTNhE
	WLUBGNacUXh+TmcKfSXFIFeiAKXg6RC88RN3GcV10cF+V5ScsDYFrhUB+DabrGp/DvmG4bFZ5SI
	9cWdkQZtaPzz1exjbilQGQFRfMxDkDD00ELYnXvbiGygZg4rExdvOm0DArOrZ/+FTXMOTIH6QD+
	avO0XwOhVG1iLPCYD5F2FeB8P0oCXKmlT/ffle1fznc2uautpaG2Fdh8kC9mXGjlsVjTbwvDDWH
	NjnvP5eACa4amzEuzgpg92klNHMGxmNkTI03XrWqT41pMnc1TO9cUG5LADYyoo7UzmObb0kjTCH
	uESVwlbpk3qFInoDVLdGZW+d5fVOIqW/7scf+5vSPouKcrF+zdMsynwsxZlNiltNNSkWiQr4tFy
	7UPGGKHvFDbrb/
X-Received: by 2002:a05:620a:4410:b0:92e:c199:e09d with SMTP id af79cd13be357-92ecf9165f7mr626537685a.73.1783590165491;
        Thu, 09 Jul 2026 02:42:45 -0700 (PDT)
Received: from [127.0.0.1] ([20.84.47.35])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90b9db95sm1586353685a.14.2026.07.09.02.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 02:42:44 -0700 (PDT)
Message-Id: <d7bc7fce35bb169a20a4ae9a1630e7080e133b23.1783590159.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2174.git.1783590159.gitgitgadget@gmail.com>
References: <pull.2174.git.1783590159.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Jul 2026 09:42:31 +0000
Subject: [PATCH 04/11] reftable/stack: guard against NULL list_file in
 stack_destroy
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When reftable_new_stack() fails partway through initialization
(e.g., reftable_buf_addstr returns an OOM error before
reftable_buf_detach assigns p->list_file), it jumps to the error
path which calls reftable_stack_destroy(p). At that point,
p->list_file is still NULL because the detach never happened.

reftable_stack_destroy() passes st->list_file unconditionally to
read_lines(), which calls open(filename, O_RDONLY). Passing NULL
to open() is undefined behavior and will typically crash.

Guard the read_lines() call with a NULL check on st->list_file.
When list_file is NULL, there are no table files to clean up
anyway, so skipping read_lines is the correct behavior.

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 reftable/stack.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 1fba96ddb3..3fc3c0b2d1 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -171,7 +171,8 @@ void reftable_stack_destroy(struct reftable_stack *st)
 		st->merged = NULL;
 	}
 
-	err = read_lines(st->list_file, &names);
+	if (st->list_file)
+		err = read_lines(st->list_file, &names);
 	if (err < 0) {
 		REFTABLE_FREE_AND_NULL(names);
 	}
-- 
gitgitgadget

