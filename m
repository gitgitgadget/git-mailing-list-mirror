Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7F725F975
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 07:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758871558; cv=none; b=ktAUiitkCjoRMg3iOHUyOnipUkXGGGR240cEyM8STVgSieerKz/C8gV0ZvFVm3ZHRGxPLWkjhq9CyNOWJMOAqkM2/ugq9GMMAmLIcoe3x77VqIMNOIAguW0E9iuJtt7nBaPkX1fQSw+ioEze406ZPpzKrg5VzKqMoKB/2q8k9+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758871558; c=relaxed/simple;
	bh=TeIPUDS+vHz5/TMx+yGjf8YtEH83rc8jg7WK7iZfgrA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DT5GMp03CHYeY6yMT3WpAkwVL4KojngHSkou3WwN22fF2uAJXpFuB0D88Zck5z+Sdl1NBCiFnqlm0O2r0vQdyeK3Z1NrwaiLdRjjUfTpqIISFRBALpeZwWfcTxNcFwzjoitnnDZ/1YUhS8CYWMsMVsTLnWwmpsSjvq/pKeZ5uQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eSs2NwH7; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSs2NwH7"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-62fb48315ddso3272942a12.2
        for <git@vger.kernel.org>; Fri, 26 Sep 2025 00:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758871555; x=1759476355; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UYfDe4BgEwoLeRMRSq+TFdffhHPG7+HnprKnPi5I8Bk=;
        b=eSs2NwH7itNx3+3r0EEaRUCSSqaFGg3axe+0DXWeQVa1JTV//EoPhsGm6NMT+Oq+GO
         Via+d+x1QJlCph2ulgKR8PqWEeIl5hLsrLLTdyIS50oGX4Tz7/dViuSmURHjzcFV/evu
         AZ1KhXweCNJMZq5LvZ97QvrCwNurb4kfSHoLkpA6dQMhEsu1/iugJB1d+C7RwjH0aGZW
         I7l3rxpkcd4JcgGzzinQJI/g5e6OQW2zSKyCKIwpSjCxA/hhXfCuLKMLt2JKU7EwEhAa
         emNG0UVJGxkiYvg/GgvbjMSioXAFWiS6h6Ba1g4juP/MzeCq+D1Hub4Z21GlhHf01Ke9
         ikbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758871555; x=1759476355;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UYfDe4BgEwoLeRMRSq+TFdffhHPG7+HnprKnPi5I8Bk=;
        b=MODKy+bc1/zk2EBujm+AWOJ5Wx6A3iyS1jJalexB0bb96K36uzj5VMqNkg54GCt5o+
         PCg+aUkphgFxZ83K6HvcNW3PWP5806U/fyBqVZC4w1UIgoY8Nh+ArPkhifaH/DdZvl0J
         DW4g3TPMzhgBSyTey/OToUJpZ/5Khbl+osbMLqbOLM3d6/84o9O6M691KqUtoODqyyZ5
         tYY166dFTnqAj09ntV8Gzf6LIr0TBnSrPtdjEBl1quXj5IYeBJEX/cb8Nu9lOaB0qP4N
         0YSEgQIgqFgPSXgvK6L4blGgtHA1CgBMQFG3Q/SVG61N2FLtFBMnX/sdY07RGtXMoHtC
         IJXA==
X-Gm-Message-State: AOJu0Yy+q0kVCH7b/g4JXXiPc8Zr1NXWPoqZE3wn6AOSUu4Nge3Dl53k
	uYJTfvTYKhk6ag8vZbN2oJrwUV/jdbHN+c2PrfuwFSWwAjW2p/BdeNpg
X-Gm-Gg: ASbGncuuuOTS3V4drorzqq0XWXI91EkyNYv2AbnNrztUOqxY2qOJK86DYV1kb7jXDHm
	xdpyZorGUzXZ6WDD3YwA5QOfgfGbSm5kfXtcd0zMApw+jYwRtla+eUOEy+l2yM1VTDjkBwIwp1+
	/JGxpsvCJ7XCYzKfnTMbKQ/qamgEoyCFIWNcxrZR4udZQ6yBPfA5CMYjE6y2XxuIkjkySqqFAtc
	+xYIV22psUMMfD4a24L3g2ZvFVX8UTYijyTXADQOfN/l0/V3ouPvM6QPuUJwFBmuw1E4K91Y/L5
	eJF9uA5aDWTSYer0OjivbAy2A+xGBHiAt07TawCEV21zer4z7wuMn9K2BkxGYuZF0UvuBvi1Z0q
	c4RnCalZ2iOQFt7OM6jDXL8mf1r7r
X-Google-Smtp-Source: AGHT+IGwJIML44yz7+9Ngzb0EIvAU6/3S12fhOHAB3heZZh7bQAdYIeLkt75s4bOcQSGVg6bX03DWA==
X-Received: by 2002:a05:6402:430e:b0:631:614f:8f88 with SMTP id 4fb4d7f45d1cf-6349fa73ec9mr4835035a12.20.1758871555042;
        Fri, 26 Sep 2025 00:25:55 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:2fd5:3bfb:87f3:d768])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3af54desm2368795a12.40.2025.09.26.00.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 00:25:54 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 26 Sep 2025 09:25:44 +0200
Subject: [PATCH v4 1/7] refs: remove unused headers
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-228-reftable-introduce-consistency-checks-v4-1-c96fd8551c0d@gmail.com>
References: <20250926-228-reftable-introduce-consistency-checks-v4-0-c96fd8551c0d@gmail.com>
In-Reply-To: <20250926-228-reftable-introduce-consistency-checks-v4-0-c96fd8551c0d@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, gitster@pobox.com, 
 shejialuo@gmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1344; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=TeIPUDS+vHz5/TMx+yGjf8YtEH83rc8jg7WK7iZfgrA=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjWP/6lLT4PW1bu/CVX1Pa4GPvR3IZTfFIdn
 UcXr1uW8hzwPokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJo1j/+AAoJED7VnySO
 Rox/ekcL/iCUP1VPVUwGbEHwseGV/zuet4hAv7DI/pi6Wb5VauG70ZtxO0Bdes9ryhi2zQuMV96
 L2wbQNIfUjV+f6Od2VtBNqPFxncu1UBoDm9iGMXwbetaeyDrnULS8N0zVdAzEOS0oCqzLl5k5JD
 1LcZGdHVevOhWtxQp4GQKAPv8vcflB4/Rj5qPhEo9IdDfdkjhoBY0R4QrjdILH97+MxIuC0UpDC
 DdG+LtqYN/nZLKozslQjC/yZY+tgY3uXTiEBUk4gjJPsqJ3AWTvp04OOzptYLcmA1wMyhlbSlDP
 u6Ra7L8j8uFGbLhrAyYkQGBh8VlGOTPqFii19ubMYFqKbXPZk4rtCrNfeA8E2FNuAfkS+pzKEBQ
 FxgBuO+WN7c5zXuhxjnny9iSSLzErnBhV0yiHl53kDJvRt0jM8qoz3OhSGlD8VnuETS7nhgfSOU
 +RAzZvm9yyueGpalv9/8as+mK3clOOiBHMLFTbZOMaVZ3+Lyk14XDKOFXpDgEG4g6GdI6BWXu/6
 GY=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In the 'refs/' namespace, some of the included header files are not
needed, let's remove them.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/debug.c            | 1 -
 refs/files-backend.c    | 1 -
 refs/reftable-backend.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/refs/debug.c b/refs/debug.c
index 1cb955961e..697adbd0dc 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -1,7 +1,6 @@
 #include "git-compat-util.h"
 #include "hex.h"
 #include "refs-internal.h"
-#include "string-list.h"
 #include "trace.h"
 
 static struct trace_key trace_refs = TRACE_KEY_INIT(REFS);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 1b3bf26add..d4fb033417 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -20,7 +20,6 @@
 #include "../dir-iterator.h"
 #include "../lockfile.h"
 #include "../object.h"
-#include "../object-file.h"
 #include "../path.h"
 #include "../dir.h"
 #include "../chdir-notify.h"
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 9e889da2ff..2152349cb9 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -11,7 +11,6 @@
 #include "../hex.h"
 #include "../iterator.h"
 #include "../ident.h"
-#include "../lockfile.h"
 #include "../object.h"
 #include "../path.h"
 #include "../refs.h"

-- 
2.51.0

