Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858A213A258
	for <git@vger.kernel.org>; Wed, 16 Sep 2026 04:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789532599; cv=none; b=FGAXsVvIGFiQtnNeIRhyXC7jEoh0GNDfzYrxxQl7CYcO3e1ZF/Hp6qaLUFdxLPhoPv4rUHJdGQGo2ejnO2pv7igKhlw2hu3s7hbnwrVdVq99rsbubc0U7/ngFa/e+4+NipEWcwndkRi0LyKhY8x7ZCgOkFRLiyzmCxsdwBkUNW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789532599; c=relaxed/simple;
	bh=qy43RNYaISEEYRIx/c+gl3BFKv+R7PKoA58PPxlZH+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O1QFo47i39eFibuDdYw8iDKs5WZSZDxxzJbJJTo0d59GTvVR9y60wAYgyvd6WVD86X0HkLlmC4DaLqRCa6WMsfdyobC8QoeSxT3YmrFjMozpmoDWCr1YGbCUw0tNmbEyV9SB+TNHeKymALW6Wi9Va112li9XrWj29sprM4j4FBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gtD+4/Gz; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtD+4/Gz"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccd4f99dso417626a91.2
        for <git@vger.kernel.org>; Tue, 15 Sep 2026 21:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789532598; x=1790137398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2lgZq2N7YcT+icZTSD5aPy1rn3VenP5dMmgZEn54Pa8=;
        b=gtD+4/GzuYLa3QfoCmn19LK/0zUjczd7KaytoJb1qNG1nNZbJghCW3g5ZO4B1rMLs8
         d1tz6GVx36NZ9mLpv5K511HNDDtMY03ZDvsGrKOhy1TFM8H3AjQ+BDqJ1Lp+L7NjPjxp
         Q7A+f9RHH6qTCk3BpffzVZMvZzGEdmHe0g7I0FABSm+z4P/IiAcV7TpSht+2nyj1m0oD
         yegNDelFnEQS8LE+5ezoGx+5EFhcpwkYoS6st3DfAvqWvXAyiA4KaJ9nMev3pc+H/EF8
         Q+ZQBBz4B4pf4tG7x1/2Z/DYI2SZ974Z6oQ8pe9F4ZK0lTNb9JlrBTnGDhEv96zUtvDM
         c1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789532598; x=1790137398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2lgZq2N7YcT+icZTSD5aPy1rn3VenP5dMmgZEn54Pa8=;
        b=o3L+aW/Gebf8HWHqe1wEm1cLc+z5QmH0HZmPr2PPFC/Rzosp25ouT7bYL+mR82TsWT
         kwwyhL213GwqCU5gTxo2qlwAPjd2vkMSIkc2Ln+AUF1No+Azp6HekHx9GX7Xwhi6oG2O
         vlnuTXu3+wPEXjfDDgjT1gtGBf5dwi0qM+tDH5s/Q50qVzNi07SedXDwtlJwZQPmqV2H
         s2Eg0peYW+NtqXllmnWsYAymDcPnsudUfwxowvBeHroz9QhqtOLyvL6nN0VD1mQncSWm
         if1UE2JoqicUxbtqCKLPd9fy50q2lOLcij3R+7fM9RBRh0/1gIlmLS6baTvoB/5pgHiu
         yUUQ==
X-Gm-Message-State: AFuF++n3aQZtICl7xzK0edm15dlPFel76lYas+xdh+gl5ADMjK0dDc9f
	jHw8wtjB/AQJhUEkPdR0HL8N7bTxYtLvlDjkPpCCRmOIk1nMglcbzw2HT563+A==
X-Gm-Gg: AYBFou33DmEktchLme0VQLZoozDitARKOlqFYnKeA7xsjgxTJlBj79TsGuJVAvmx34v
	qJE9ilHCo5xnJyddKLVN8k4Y+N8oD0HBbYcBg2o0uzolDT+D2xs3TnU/TeuIYSOZiB/hw1xYGSe
	HHuo9QQGdTb6NdhpFiY5NaN2flIi31adNWTyzKSXKNqE/vIo9GQKZsfL3NnUUff5uEAQ8SdgqhE
	6oJYH4mdnPiFLXx7JYrY5tGgDSITavrhC4D3kTenIxg5Xb3rMyaUBdpEYN2BcsO5GJUsEgLWNH9
	oXCWke2uksZ0Ej36u4kxpr043u7Fl1lUzYSDgtgoTdIJKbAwMVfiQxWUKvIUV+OZN6/WEXUEaSj
	B+LbatQiCmA0bFGAUockH5mgKtpB8qZ4Jjdy6zp/3Bt4BUQkeRexxEd/DEkx4aHWaGm3EEZD9dq
	iYOK9LrezvTZ8ImO19tUJTEo9khJkZVIGdrxrm6C5c0a7vlJEt5g4mCYs4EgyUvyHSnv4HdD1Hu
	z3ejVSY0HA3Kplt/7pHm/hDIYF8RA3avLPY5psF5Ln/8E/Qmxy929ZYtfn9riumteGV5olLxjyc
	EPTk43NZIh4F1dzKXvxbOLY=
X-Received: by 2002:a17:90b:3b86:b0:39e:d2a:e2dc with SMTP id 98e67ed59e1d1-39e1e4849a4mr2651245a91.12.1789532597620;
        Tue, 15 Sep 2026 21:23:17 -0700 (PDT)
Received: from MU00187702X.monash.edu.au (dyn-49-127-70-83.its.monash.edu.au. [49.127.70.83])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1b90a5a0sm2123356a91.2.2026.09.15.21.23.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 15 Sep 2026 21:23:17 -0700 (PDT)
From: Yongqiang Tian <yqtian668@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] compat/winansi: fix die_lasterr() argument formatting
Date: Wed, 16 Sep 2026 14:23:12 +1000
Message-ID: <20260916042312.35891-1-yqtian668@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During WinANSI initialization, duplicate_handle() reports the handle
when DuplicateHandle() fails:

    die_lasterr("DuplicateHandle(%li) failed", ...);

die_lasterr() collects the formatting arguments in a va_list, but
passes that va_list to die_errno() as an ordinary variadic argument.
die_errno() consequently formats the representation of the va_list
instead of the supplied handle, producing an incorrect fatal message.
The other current callers pass fixed strings and are unaffected.

Git does not provide a va_list-taking variant of die_errno(), so format
the caller's arguments separately with strbuf_vaddf(). This consumes the
original va_list correctly and produces the complete diagnostic prefix,
including the handle supplied by duplicate_handle().

Save GetLastError() before formatting because calls made while growing
the strbuf may change the thread's Windows error value. Convert the
saved value to errno only after formatting, then pass the completed
message to die_errno() through a literal "%s". This prevents any percent
characters in the formatted message from being interpreted a second
time, while allowing die_errno() to append the corresponding system
error and terminate as before.

The updated compat/winansi.c compiles with MinGW GCC 13. A Win64 probe
under Wine prints a value derived from the va_list before this change
and the supplied integer afterward.

Signed-off-by: Yongqiang Tian <yqtian668@gmail.com>
---
 compat/winansi.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/compat/winansi.c b/compat/winansi.c
index 3ce190093..5547192a2 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -7,6 +7,7 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "../git-compat-util.h"
+#include "../strbuf.h"
 #include <wingdi.h>
 #include <winreg.h>
 #include "win32.h"
@@ -438,11 +439,15 @@ static void winansi_exit(void)
 
 static void die_lasterr(const char *fmt, ...)
 {
+	DWORD err = GetLastError();
+	struct strbuf message = STRBUF_INIT;
 	va_list params;
+
 	va_start(params, fmt);
-	errno = err_win_to_posix(GetLastError());
-	die_errno(fmt, params);
+	strbuf_vaddf(&message, fmt, params);
 	va_end(params);
+	errno = err_win_to_posix(err);
+	die_errno("%s", message.buf);
 }
 
 #undef dup2
-- 
2.34.1

