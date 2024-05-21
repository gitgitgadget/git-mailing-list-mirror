Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C7D610C
	for <git@vger.kernel.org>; Tue, 21 May 2024 00:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716251879; cv=none; b=DRjmbn81WZEKl9XiENnxd7v6tngnUKVVZCsulFhojfRQAR8g8PRYSYftuK9GSAOCjwmW53f4H78Q4op9j2YSCz5JxH89HTZBe4nQcNWPNDGHYuhQWLZ6eUHZtujBa5v8m9X9J+abRkbx1Eqv5Z5zfr3n28cNYcQ15PRXQRrf6jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716251879; c=relaxed/simple;
	bh=CQBJcDOrAPut+KGlDbGrXZYMF9b+G3m35BoDgrHhGKU=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=oHUymaN+vVeEU40uxDMfaQgH4n9BjxvSJBp4otAUMZ3xaO1xXzBPDligvzxVLltokBJv4fTK9LxhlpgkMwV1fj2X0XpqOH5Jec+HOxfAhYt7/maX+iO0x+Phk0Lfl+7TU5m/d7wO/+p7DAsL/YPK40RETANjjwBabNkj2AKI8eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajPaPWRt; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajPaPWRt"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-34de61b7ca4so1979114f8f.2
        for <git@vger.kernel.org>; Mon, 20 May 2024 17:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716251876; x=1716856676; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:to:content-language:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9SqEVBLuRoaxcXdvtTEM5HJVqLaYkz7/ZfAuR5Y0NYA=;
        b=ajPaPWRt+YyyXLYthCJm9GBkdXFRGmcQ2s7viduQnsLfT0mPW63AxAjTOWh1rjrdYz
         YPfZLHBU8SLYGffVSG9tFy7S57Ps12lu70600FHRFM2YVNhZUzmDaPkk3dNKK7iDW76a
         l0nG0JJ7SnCqYVxiq3X9Ezy1/xhB5bq1/7TrQxHtH5nOV7/vWz9XwdcdHuj30HSNkjyQ
         B87XLYtcZfDsgZjxtS6Q8nqbjTIN5mjeZFMWULU3XYhj+2IVayW8/ltgr8BaRKKcAohZ
         5DWgCnCq0+/aWzU/aLJRJyHSHllfZSVFZUNex83KCh0eKyveICLT3PS9GqDIxQCiQrxg
         D/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716251876; x=1716856676;
        h=content-transfer-encoding:subject:to:content-language:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9SqEVBLuRoaxcXdvtTEM5HJVqLaYkz7/ZfAuR5Y0NYA=;
        b=gElU0nQf/asOSUyAYOj6RvSxPzMReRvOYfnYYKh6SvPHxzpkEi/PZVmCvnjbZUpgix
         hKtkQvZrNLv8WKOXnjQjaU2758miQ3FFQVTZb8mf5M9zLB11dwVrhL3+qC6flCzTDsMU
         SqpZzDomksflhPnKcOCOuQEbYaO7GptG2DqffIDsqJIbWaTzmJX0BVxuBR7Ka7BvXxUh
         G36CpJsSDBA7ymBLTaYvEDGlC6vk54q0TO4E51bcKFhzkyLtmQProAw3DFPiWRMRX7WS
         pCFVr37gOZe49xZE+dI0a6lwmUDHqgmm08hn5mhZLW0fDJkiCdcX3TUAJkxyveFo+dKJ
         oGcQ==
X-Gm-Message-State: AOJu0YyJiq0AXGWaJD1AM4Cpa7V+R2LQcT8LnE6bLm6sOZp1mHr4Avx9
	57CFAJcA5ykpzPo57X00rzgrdtJtlmPKaWyz7Bgy4Vfcu7YWW6z9X6TJxA==
X-Google-Smtp-Source: AGHT+IHJgTSn+/fm7SV5CO+/eP6i34a+T49J+hnNWdn02q2ZUw7TxIMyuA4WghCi7SyniY47X2gOlQ==
X-Received: by 2002:adf:e785:0:b0:34a:7a97:caa1 with SMTP id ffacd0b85a97d-3504a61c7bfmr33032872f8f.2.1716251875918;
        Mon, 20 May 2024 17:37:55 -0700 (PDT)
Received: from gmail.com (173.red-88-14-51.dynamicip.rima-tde.net. [88.14.51.173])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baacfb9sm30255294f8f.68.2024.05.20.17.37.55
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 May 2024 17:37:55 -0700 (PDT)
Message-ID: <1dbe4c61-d75f-45d9-95d2-ac8acae22c56@gmail.com>
Date: Tue, 21 May 2024 02:37:54 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
To: Git List <git@vger.kernel.org>
Subject: [PATCH] add-patch: response to unknown command
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In 26998ed2a2 (add-patch: response to unknown command, 2024-04-29) we
introduced an error message that displays the invalid command entered by
the user.

We process a line received from the user, but we only accept
single-character commands.

To avoid confusion, include in the error message only the first
character received.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 add-patch.c                | 4 ++--
 t/t3701-add-interactive.sh | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 2252895c28..d408a85353 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1692,8 +1692,8 @@ static int patch_update_file(struct add_p_state *s,
 						 "%.*s", (int)(eol - p), p);
 			}
 		} else {
-			err(s, _("Unknown command '%s' (use '?' for help)"),
-			    s->answer.buf);
+			err(s, _("Unknown command '%c' (use '?' for help)"),
+			    s->answer.buf[0]);
 		}
 	}
 
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 28a95a775d..6f5d3085af 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -60,7 +60,7 @@ test_expect_success 'warn about add.interactive.useBuiltin' '
 
 test_expect_success 'unknown command' '
 	test_when_finished "git reset --hard; rm -f command" &&
-	echo W >command &&
+	echo WW >command &&
 	git add -N command &&
 	git diff command >expect &&
 	cat >>expect <<-EOF &&
-- 
2.45.1.217.gdb529f37a6
