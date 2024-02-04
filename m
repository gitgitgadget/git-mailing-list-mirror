Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C2D6FD1
	for <git@vger.kernel.org>; Sun,  4 Feb 2024 05:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707025726; cv=none; b=NFHb/TUNAbEsqjLVO5EZvW2ZShmqyifvaBUkXpl1iw/R6h2GPw4XLf13V/rM0GWzvKlVmLHPOWvC5Z+oqeTQJlhwxSPFFojuIcfjpucGvRLootPTxTeuZ4d0n6jIpZbcx+YtgZkZFyghnLYmrRAX7Xx4bOvvY2Cj0LBnLtFi9HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707025726; c=relaxed/simple;
	bh=7OzWWH480D9y4QRp1Ct6fFzJEblka5C8hZrO6UjedzY=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Ni2d8731wR4psu33wc+GvuQeAZAwlhtsbPOAy2Ff4TQ0QkO64nZUXRlDsxMBNyymdWH2vFkVpeSaysRM4MaOjxqi8EBMjA5mjxZn4RqwnLu3fC5zgqHPhEywkkg0J16p1UZzh1+gvt5tAIR9JqeVoh+5RePakpeUOAmIjetOQ1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OG+LvfzG; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OG+LvfzG"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3392b12dd21so1790067f8f.0
        for <git@vger.kernel.org>; Sat, 03 Feb 2024 21:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707025722; x=1707630522; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkl11tAQxhk6kNYb+NxUU1IaiaU4nY6Syst86cT/Yq4=;
        b=OG+LvfzGOBxHeXMSCSMT4lmzLjckVybHfDZiBY1OOLWYaBn9Tj/iCtvYgo0izzh7d6
         Mg+lcCZG6faG5xcK5eQpiIg6yUXPZYZrz2xoQrB2Fo6BhRvpMY38OG0LxUm58+Pqkgat
         5swAaEkQtnwV+wtFaikM/TaRj10jcT/zBajdJp9HvyyfqxYHhdba/uoDXcZklEv7JfBk
         dkce8Fc0JJYBvoGGNBRzPNcMm4r4IrD0ZgubDSDQWQXcQYUG6AmkbhV+nfwP/E/vI0Ra
         A0Ql0CMXRF3lXcsax8UKFkm9G2g8Q64penEnXftj0OfpRJBFyuzqEA2RumwZV4r3o93O
         KQEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707025722; x=1707630522;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bkl11tAQxhk6kNYb+NxUU1IaiaU4nY6Syst86cT/Yq4=;
        b=rrcfX2UUsvbCiC80j5ocxqLc38NRbK8UvLdQc8OMO8anvlWVBPQJNTCxhSIuhFxxJw
         usKM6p9MUlt7JyCu7m+FQPaA27kHRQgHjxH8xi3l82l8kB7M04cPzR1i5ubeIeSZa2t1
         DcBCzk2kopHvAFZxG4wRywXtFx1IqrexEUuvb9TbeNPa9BfvrQHCPf8/DrUZ3nSWW7JE
         Y7UXjoT/rxQgS9NcuiXtAHX3uHukZd9qY5PFrHMw1HeVMtstQDNjSqbQ7rZIJHjf4PgV
         V/QzL+JYfwqOdZY5WRkb2YPxZBgR3xUMIAUaJZGxBVk02+5xMOErT8VAUn2fuZ/MRTj7
         uqwA==
X-Gm-Message-State: AOJu0YzIZZuIcdAr00d9nfSV8VYlgIRalpgtRBP81ZtMFGqMOCh7e29A
	ZKtFDOtjnAFyR04QUuiLjskIL9fC0P3CslC6AOQhYh7cGBMjr/tN8XPJ0wIU
X-Google-Smtp-Source: AGHT+IEfbY4ZsuwEeiCcO+PGINTgJSaYJIT22TCyBPq9ifxExTXcWETBQYjy2ml5iCW0GFuJjAKZLg==
X-Received: by 2002:adf:cb02:0:b0:33a:e70d:4fb6 with SMTP id u2-20020adfcb02000000b0033ae70d4fb6mr3480933wrh.37.1707025721714;
        Sat, 03 Feb 2024 21:48:41 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU5gxRBNI/lF8plVkLl7NqUK2ue5S+xmSZq8pTopthx/CwwL9Jn5c7IBbb5+EF6iWEO3aAeh5Ok+nTBxnrFrRUHOWhrO0qz7wI=
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c6-20020a056000104600b0033b35ca71c0sm976754wrx.108.2024.02.03.21.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 21:48:41 -0800 (PST)
Message-ID: <858d6f94e79ba388267cc24f43ebf68998cd56a8.1707025719.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1646.v6.git.1707025718.gitgitgadget@gmail.com>
References: <pull.1646.v5.git.1706416952.gitgitgadget@gmail.com>
	<pull.1646.v6.git.1707025718.gitgitgadget@gmail.com>
From: "Mohit Marathe via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 04 Feb 2024 05:48:38 +0000
Subject: [PATCH v6 2/2] patch-id: replace `atoi()` with `strtoi_with_tail`
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
Cc: Mohit Marathe <mohitmarathe@proton.me>,
    Mohit Marathe <mohitmarathe23@gmail.com>

From: Mohit Marathe <mohitmarathe23@gmail.com>

The change is made to improve the error-handling capabilities
during the conversion of string to integers. The
`strtoi_with_tail` function offers a more robust mechanism for
converting strings to integers by providing enhanced error
detection. Unlike `atoi`, `strtoi_with_tail` allows the code to
differentiate between a valid conversion and an invalid one,
offering better resilience against potential issues such as
reading hunk header of a corrupted patch.

Signed-off-by: Mohit Marathe <mohitmarathe@proton.me>
---
 builtin/patch-id.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 3894d2b9706..4e9a301e9fb 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -1,3 +1,4 @@
+#include "git-compat-util.h"
 #include "builtin.h"
 #include "config.h"
 #include "diff.h"
@@ -29,14 +30,16 @@ static int scan_hunk_header(const char *p, int *p_before, int *p_after)
 {
 	static const char digits[] = "0123456789";
 	const char *q, *r;
+	char *endp;
 	int n;
 
 	q = p + 4;
 	n = strspn(q, digits);
 	if (q[n] == ',') {
 		q += n + 1;
-		*p_before = atoi(q);
-		n = strspn(q, digits);
+		if (strtoi_with_tail(q, 10, p_before, &endp) != 0)
+			return 0;
+		n = endp - q;
 	} else {
 		*p_before = 1;
 	}
@@ -48,8 +51,9 @@ static int scan_hunk_header(const char *p, int *p_before, int *p_after)
 	n = strspn(r, digits);
 	if (r[n] == ',') {
 		r += n + 1;
-		*p_after = atoi(r);
-		n = strspn(r, digits);
+		if (strtoi_with_tail(r, 10, p_after, &endp) != 0)
+			return 0;
+		n = endp - r;
 	} else {
 		*p_after = 1;
 	}
-- 
gitgitgadget
