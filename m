Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173A9C433FE
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 21:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05A6560E8C
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 21:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbhJ3VfM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 17:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbhJ3Vev (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 17:34:51 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAC3C061220;
        Sat, 30 Oct 2021 14:32:15 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id d72-20020a1c1d4b000000b00331140f3dc8so3411857wmd.1;
        Sat, 30 Oct 2021 14:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MfpBG6jZHkGiGTlmQ3BefyjOhq9+dLrYOFlICPqSfCs=;
        b=FCOXM86daSB2xETbXdP4WFfHz03q+K7ECSZc0QOuWqAl7/n9lQsA/0ePCcLJd5ubpZ
         Pq7g5BxEZZaR4dpdAM+ViiUwUQu7dpKHxqJ8b4wUj+kHYbSqGrQJFJnAq/P2CZ+8oKxr
         vGX1sObH+9lAIpWQYJ9EGO4TUxJo6ywEEYRTp63VJes44K6/n9xrBW37Zm57cDf4DcKq
         SuulWU8p8zmO7+3bk+InHth2yaJgxvsBDteu8aktz0xeXWi2jPnfl49LNIsUYQVU9Dtb
         /rct4OpPdWTslMgDvvlMV+5TlMZc9UGv+cfu/hdlXYwlgU093xE7XDk0Sd9IiqQIc7A0
         79SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MfpBG6jZHkGiGTlmQ3BefyjOhq9+dLrYOFlICPqSfCs=;
        b=ytg9ztB17v5S99aPi/ZXUe41RIZK04iQsGZl7TQFGWHG/B5sqi/NChnkDzd7J9AAH2
         xU1foa9yN5/einSl8jK0r3E8YAS6FyizWX8beSg2fwjpMNXFcb3crs5KoRBghluadrgF
         qEVRqR+b0rmU9AGvk10paYf7lgwzHSZKP6IX/zRkv0jCOEXLmUv+CXbqh3sZxH5sHidM
         MZGTWPeCe7a18Whiog4Q99JrhcYJdrJU2Zh1aXKgoNDHhWdRCpCRIJbOwXOhc+aHtGWW
         OdAW3qp8TyqMqTp9CSoxge6rTtUCa86iEJaG1DavtF3//5UYF+eaOj+YsX2430kOy7a2
         QC2g==
X-Gm-Message-State: AOAM53087wmh7DC+AJuPls7WEtbCWXGsqFDF0y4Z/ccOErnzs2p6eFzX
        /v8+T5V95FBzEAQNVtcGJ1E=
X-Google-Smtp-Source: ABdhPJx7N1sEb3urPrxcy+YCJk2U6czS559baczXaQWLhkpOcEW0aLRdNGJ/vB9D5Z6fwTeJt0o0Uw==
X-Received: by 2002:a05:600c:4108:: with SMTP id j8mr13723234wmi.139.1635629534488;
        Sat, 30 Oct 2021 14:32:14 -0700 (PDT)
Received: from sqli.sqli.com ([195.53.121.100])
        by smtp.googlemail.com with ESMTPSA id c79sm2948689wme.43.2021.10.30.14.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 14:32:14 -0700 (PDT)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     mtk.manpages@gmail.com, linux-man@vger.kernel.org
Cc:     git@vger.kernel.org, Alejandro Colomar <alx.manpages@gmail.com>,
        linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Subject: [PATCH 20/22] setpgid.2: SYNOPSIS: Mark BSD versions of getpgrp() and setpgrp() as [[deprecated]]
Date:   Sat, 30 Oct 2021 23:31:30 +0200
Message-Id: <20211030213131.140429-21-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211030213131.140429-1-alx.manpages@gmail.com>
References: <20211030213131.140429-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The BSD version of getpgrp(2) was superseeded by the POSIX one.
The BSD version of setpgrp(2) was superseeded by the POSIX one.

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 man2/setpgid.2 | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/man2/setpgid.2 b/man2/setpgid.2
index f3be0eef4..2f09b246e 100644
--- a/man2/setpgid.2
+++ b/man2/setpgid.2
@@ -55,11 +55,11 @@ setpgid, getpgid, setpgrp, getpgrp \- set/get process group
 .BI "int setpgid(pid_t " pid ", pid_t " pgid );
 .BI "pid_t getpgid(pid_t " pid );
 .PP
-.BR "pid_t getpgrp(void);" "                 /* POSIX.1 version */"
-.BI "pid_t getpgrp(pid_t " pid ");\fR            /* BSD version */"
+.BR "pid_t getpgrp(void);" "                            /* POSIX.1 version */"
+.BI "[[deprecated]] pid_t getpgrp(pid_t " pid ");\fR        /* BSD version */"
 .PP
-.BR "int setpgrp(void);" "                   /* System V version */"
-.BI "int setpgrp(pid_t " pid ", pid_t " pgid ");\fR  /* BSD version */"
+.BR "int setpgrp(void);" "                              /* System V version */"
+.BI "[[deprecated]] int setpgrp(pid_t " pid ", pid_t " pgid ");\fR  /* BSD version */"
 .fi
 .PP
 .RS -4
-- 
2.33.1

