Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF633C2D0F4
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 17:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F762072F
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 17:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+GupLJi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbgDHR6y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 13:58:54 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35877 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbgDHR6y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 13:58:54 -0400
Received: by mail-ed1-f68.google.com with SMTP id i7so9840467edq.3
        for <git@vger.kernel.org>; Wed, 08 Apr 2020 10:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=HdF/P/GbJmTNn5ptXcQAgR5h+Y0dg+ZdqteA2XddQDk=;
        b=m+GupLJiN8+YSsMHXpmWH6SXV3PtOKnEGOtRzYNXt/9AlnuGIbBI+0yrvLFzDg5QS+
         /636687tOTBb0DCWunjcRRtnID3fiFgPzAHeA6LbN1T4DXuT1LpsX0uK9uu9ZslLkB3X
         EVqoBXN+DObdmzcvOqnKK+5xkAVfKWKasSz7etLQAXXEELjriTAUxIFSY4Se5tV24Pyc
         31cOf/43YQqxVhwBLP6MD/OQc4Hvtl0xihR8HkUhJAfHXho+Sj1l/qLLKTGdo44bj6PW
         ltbqMxLYuyTeZy3LxXdwcBN9DH0I3lj2hWbuZbj0wGFFj+joVKdS2S325dNK+OuocmZX
         mEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=HdF/P/GbJmTNn5ptXcQAgR5h+Y0dg+ZdqteA2XddQDk=;
        b=J8AfewXxK8CUf0Rguhw8U0Z26+Z+XxoM+5QWtBThFg6yni+lb4O3hDp+725o2YFwN2
         NdJCVgAf+BcivBMWwbf+zj34mrvQRqc21C+erZ+PcOTTED2x+CP0kS7cgSjpajfD+mK6
         uZ0PcC8up17rsPuY5Ji+Ta14YwCJdzKC05rg8ykU5Tj5/IFyzZeAf/MO4elCwAiZZzCC
         hilgqmvIYLUMCgNulM5eIMzjT5yezaDid2grJyM4RgkZtI7YV9huDNsObU+l/11HadhY
         SIzBdIIDE8Vx/VM04Y1N3PV4bai6T5tOlfdZ4G61gz0yb0D2xKmF8fOjzdp+B237Jvmi
         OiZQ==
X-Gm-Message-State: AGi0Pub+4Zbum44mQZrvEJ2YtEfhqG9hshuowKzOy90eQwF3jmN+2Fyy
        0NexTlHavKbvBeaNEAnhYVrMMkgD
X-Google-Smtp-Source: APiQypL+gObRaN1kVQWgTPQjtGRr5S1O4IX1Qe/rgjLzk7de97ly4UlR71tcAQneEMVwtkw+IDACqw==
X-Received: by 2002:a17:906:1cc9:: with SMTP id i9mr7646209ejh.0.1586368731351;
        Wed, 08 Apr 2020 10:58:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c8sm85734ejs.86.2020.04.08.10.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 10:58:50 -0700 (PDT)
Message-Id: <pull.753.git.git.1586368729890.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Apr 2020 17:58:49 +0000
Subject: [PATCH] mingw: use modern strftime implementation if possible
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Matthias=20A=C3=9Fhauer?= <mha1993@live.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Matthias=20A=C3=9Fhauer?= <mha1993@live.de>

Microsoft introduced a new "Universal C Runtime Library" (UCRT) with
Visual Studio 2015. The UCRT comes with a new strftime() implementation
that supports more date formats. We link git against the older
"Microsoft Visual C Runtime Library" (MSVCRT), so to use the UCRT
strftime() we need to load it from ucrtbase.dll using
DECLARE_PROC_ADDR()/INIT_PROC_ADDR().

Most supported Windows systems should have recieved the UCRT via Windows
update, but in some cases only MSVCRT might be available. In that case
we fall back to using that implementation.

With this change, it is possible to use e.g. the `%g` and `%V` date
format specifiers, e.g.

	git show -s --format=%cd --date=format:‘%g.%V’ HEAD

Without this change, the user would see this error message on Windows:

	fatal: invalid strftime format: '‘%g.%V’'

This fixes https://github.com/git-for-windows/git/issues/2495

Signed-off-by: Matthias Aßhauer <mha1993@live.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Use a modern strftime() on Windows when available
    
    This is another contribution that came in via Git for Windows.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-753%2Fdscho%2Fmingw-modern-strftime-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-753/dscho/mingw-modern-strftime-v1
Pull-Request: https://github.com/git/git/pull/753

 compat/mingw.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index d14065d60ec..2136744af35 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -964,7 +964,16 @@ int mingw_utime (const char *file_name, const struct utimbuf *times)
 size_t mingw_strftime(char *s, size_t max,
 		      const char *format, const struct tm *tm)
 {
-	size_t ret = strftime(s, max, format, tm);
+	/* a pointer to the original strftime in case we can't find the UCRT version */
+	static size_t (*fallback)(char *, size_t, const char *, const struct tm *) = strftime;
+	size_t ret;
+	DECLARE_PROC_ADDR(ucrtbase.dll, size_t, strftime, char *, size_t,
+		const char *, const struct tm *);
+
+	if (INIT_PROC_ADDR(strftime))
+		ret = strftime(s, max, format, tm);
+	else
+		ret = fallback(s, max, format, tm);
 
 	if (!ret && errno == EINVAL)
 		die("invalid strftime format: '%s'", format);

base-commit: 9fadedd637b312089337d73c3ed8447e9f0aa775
-- 
gitgitgadget
