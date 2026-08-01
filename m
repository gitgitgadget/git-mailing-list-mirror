Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E7B3BA222
	for <git@vger.kernel.org>; Sat,  1 Aug 2026 17:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785606130; cv=none; b=Gd5a8LQUsP9bmSx0LrwmfAlwv0qWzCYSeemvHmjvPUUh1LLsewmzWL8NqSW6WSRTNyFvR7OvFBRtJB+ZUA+T8JBX0tRIhEFpSc4lNn72WKadklI336j5315Cl4nHvFc+stEHeGMUqfUlIVE0Xw/cLcHk4V5RVEoObj0hItagNvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785606130; c=relaxed/simple;
	bh=nttdz337mO0GJ7sRBgXv6Icqs3nZrWguEel4JWgGKh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KNDKdaexmHmLd+qs9k/BjTqsEXoUakTFk0r7xGiyLeqml+fDBSee1XB8qkunqL8N1Jdl+hxdIEQ+AnYXlUPonXR7NlgoYbpZH+43NvKJvuU3ZL0HtSnQIk6sBXosRIlVvWRQ6Bl9KJeB8emBYSUaGoTu6xorLJbeqR+wysZKALg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USiGy6hQ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USiGy6hQ"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8487214ad2bso3026672b3a.1
        for <git@vger.kernel.org>; Sat, 01 Aug 2026 10:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785606129; x=1786210929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lb6bB6YrMaxkB6No2H49f935QZ9BkVWLUq7NlgqlTiw=;
        b=USiGy6hQ/oqv4oWkCsga3tj6c6oEQtRHcLbejFDfmd0V4eDttiX60tNdfcQDCreejv
         vDqV1lQ8tcvLnQ3VrPIXyrwDiic/0vqo6ytI9IHGwHTQ5xKfKd29iFpX+lNElfY6dlkG
         57ZQ/G1wHWXjXjL2ZbtLTvNd4uzJy6sFxLnd/gw9wtAWx25Bq8vZLRhCoy+zByJprJPA
         L2nNF90fXcP/SQmCpCdrG+bdB/Ik4c5kUxzabFj7tH9oj2EPWf9dw4ozcxwfs/DUQH4E
         aJuBDy5eo30fqWhx4oMEngdRgPxYylmAh31ylcBwXgHYH6dRzWo3lt4K6j5Xb2KMAph0
         VTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785606129; x=1786210929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lb6bB6YrMaxkB6No2H49f935QZ9BkVWLUq7NlgqlTiw=;
        b=HumwWz8K+XArlR6bTD61jO/ug48PMjyvimBmPlKelqJ9IJ7hExO3DBp01VaDFtkDeD
         GVK5F8/SASS/8BgJns8Qguect46e41x0LaT7nl9VIg4prOtRqjeim851VhDoTyJvEbjG
         HlkNYEHuwXRLy44FcshZwSpiy/0S86J0Szaz5d7Njw6xdiDsMGP1iwHM+uE0iVRi7CcY
         Lf6KhlSagCs8x7P3aWZ9gAIMtbfr2TU+K8e6IYHLhB5h1Jyu7EEEnrAR4g6Zevnhivhw
         crVrcAsvpNoniFIVWUKQmKlaw1x5B2sa6PWAMtpTyRltSO7gk70WhkWPsLDSZYXiTR0N
         UcUw==
X-Gm-Message-State: AOJu0Ywyc5rM2zQfOfdic2fyA6c/3Zi73syeEr3BgDeqt60/GlywL5nD
	YPBrkUMfILNC0ya5BbhP+kXbXe/r+35yCR3HUgq3y9UUJX+EwfJYI3CvHwFZ3A==
X-Gm-Gg: AR+sD11fNYjS+k1Hz3gMjkE/cxbXm4GAJ5/825XqMsePrPuCYBh52V1V2hXA7bPQ1Um
	ZmQkCdsjSzsJQ1enGUEKl0H3sXcK6zcIrNYTvGHXVnbYRNRwLNHoKuHFoBMb6fvnRqOGjxNh5WM
	32J9gSvYfSW0UgTrFqIVmK9RwS7s9me9ZOU0S5XFPU12aqzydI5GEuyrR5yK4jNXAwM/FJTURHI
	wTx4lx4Ap4Zxs/ZyJwr+mR019XqFpR4TQ/PMPamcwhste3y9yRZ9ulW4U0dfUtM9CxvCwRN3GW7
	XC3k/Yp97UkIEiQbLSqwJQEwuc+ZHsOsAUiPW2WvmEgjPxn+9mpi0kefvhPqcoXTejiikulAdye
	KfkENjRw7Osoz6Dst7my5zG47ho33DgXNAJ+dCfrqnC3Ge1TnvO2dWkSv2lDWDplEOTL2yJ1AhC
	5DCz9xng/5mnNQ1db7X4S3RGwhBjO7HlqkElzRGegds6xg3mqH8K/yomWX2dlVFfbm1+/lY0YZN
	P+Y/9rhxCHDKcKbzF8k4E6RmTlffQkzyzpqnscO4ykFIKO4uu6INjKdQoSD6jvd3D/txK3ukCPC
	e7wdzHL8PHJvcJXdV52U8YX++NjbKiQUhTlavirqQffiQQ==
X-Received: by 2002:a05:6a20:d809:b0:3c4:2eb6:c3a0 with SMTP id adf61e73a8af0-3c92a63ad0bmr3940839637.30.1785606128777;
        Sat, 01 Aug 2026 10:42:08 -0700 (PDT)
Received: from localhost (192-184-169-91.fiber.dynamic.sonic.net. [192.184.169.91])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab4e506csm14886062c88.13.2026.08.01.10.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 10:42:07 -0700 (PDT)
From: Michael Montalbo <mmontalbo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [RFC PATCH v7 08/10] sub-process: add a gentle status read
Date: Sat,  1 Aug 2026 10:41:51 -0700
Message-ID: <20260801174156.2998808-9-mmontalbo@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260801174156.2998808-1-mmontalbo@gmail.com>
References: <pull.2120.v6.git.1785091889.gitgitgadget@gmail.com>
 <20260801174156.2998808-1-mmontalbo@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

subprocess_read_status() reads "status=<key>" packets up to a flush with
packet_read_line_gently(), which is gentle only about EOF.  A malformed
length header still dies inside pkt-line, and an empty packet is
indistinguishable from the flush that ends the section.  A protocol
violation in a status section therefore either kills the whole command
or silently truncates the section.  That posture fits the filter
protocol's callers, which treat their process as required
infrastructure; the diff process consult added later in this series
treats its process as optional, and any protocol error must degrade to
the builtin diff rather than abort the command.

Add subprocess_read_status_gently(): the same status loop, reading
through packet_read_with_status() with the gentle options, returning
-1 on a truncated or malformed packet and on an empty packet where a
status line or the terminating flush belongs.  subprocess_read_status()
and its callers are unchanged.

The handshake has its gentle counterpart in 061a68e443 (sub-process:
use gentle handshake to avoid die() on startup failure, 2026-06-01),
which turned truncated handshake reads into error returns for every
caller.  This series' base includes that commit, so a process that
dies during the handshake feeds the same non-fatal fallback as a
status failure here, and an optional diff process degrades to the
builtin diff on either kind of protocol error.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 sub-process.c | 24 ++++++++++++++++++++++++
 sub-process.h | 10 ++++++++++
 2 files changed, 34 insertions(+)

diff --git a/sub-process.c b/sub-process.c
index 3cef42b088..33bd789618 100644
--- a/sub-process.c
+++ b/sub-process.c
@@ -49,6 +49,30 @@ int subprocess_read_status(int fd, struct strbuf *status)
 	return (len < 0) ? len : 0;
 }
 
+int subprocess_read_status_gently(int fd, struct strbuf *status)
+{
+	for (;;) {
+		int pktlen = -1;
+		enum packet_read_status rs;
+		const char *value;
+
+		rs = packet_read_with_status(fd, NULL, NULL, packet_buffer,
+					     sizeof(packet_buffer), &pktlen,
+					     PACKET_READ_CHOMP_NEWLINE |
+					     PACKET_READ_GENTLE_ON_EOF |
+					     PACKET_READ_GENTLE_ON_READ_ERROR);
+		if (rs == PACKET_READ_FLUSH)
+			return 0;
+		if (rs != PACKET_READ_NORMAL || !pktlen)
+			return -1;
+		if (skip_prefix(packet_buffer, "status=", &value)) {
+			/* the last "status=<foo>" line wins */
+			strbuf_reset(status);
+			strbuf_addstr(status, value);
+		}
+	}
+}
+
 void subprocess_stop_command(struct subprocess_entry *entry)
 {
 	if (!entry)
diff --git a/sub-process.h b/sub-process.h
index 45f1b8e5e3..8655b38897 100644
--- a/sub-process.h
+++ b/sub-process.h
@@ -101,4 +101,14 @@ int subprocess_handshake(struct subprocess_entry *entry,
 
 int subprocess_read_status(int fd, struct strbuf *status);
 
+/*
+ * Like subprocess_read_status(), but a malformed status section fails
+ * instead of dying: a truncated or malformed packet, and an empty
+ * packet where a status line or the terminating flush belongs, return
+ * -1 and leave the stream unusable.  subprocess_read_status() cannot
+ * tell an empty packet from the flush that ends the section, and dies
+ * on a framing error inside packet_read_line_gently().
+ */
+int subprocess_read_status_gently(int fd, struct strbuf *status);
+
 #endif
-- 
2.54.0

