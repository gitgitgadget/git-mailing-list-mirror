Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B46DC46467
	for <git@archiver.kernel.org>; Sat, 14 Jan 2023 03:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjANDrS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 22:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjANDrP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 22:47:15 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85ADDBCA5
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 19:47:14 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id 200so11332168pfx.7
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 19:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:subject:to:from:sender:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ffgI8We2sPbtu64rMrNRppeZQPx6F8fObKIIk4dvwpY=;
        b=fUIO1GPcfUMQoQEm/wP9NE6mTMAGmLEIoSUbOO3K67ApsYoqzx6ObgoxJ1Kc9uF3wd
         iT/DIhICCwj3/wFo3EJHKxjYIXXhkQxPgwFlvtztBttAf1yvqDsH8iNilh1MCchKJoJG
         NR1sgUVYpM7bLLVIBtdrTENYjJFdcg0l3HoQWrlaPGBu3jK4qiPgHkKcMi3WElXOFMxV
         gVt1vpVN3+oWNY2J0mvD+AH1LvEi57nKxSPHIdrfz2i/9HhzSzBu3dw5lXmdZKcpwy5R
         h8Hv5deaKQ7RGxyep0vCROl2Z0J3RmanlkYAuD5gm4Xs60iKSiScx2Bm7OK9QqJuZxVq
         Ejyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:subject:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ffgI8We2sPbtu64rMrNRppeZQPx6F8fObKIIk4dvwpY=;
        b=2WPIj1WZhjgU91p1VMdhNKOAz/f9Mee9/5ggeGelFKNMbxBu7QBBst4GOOTtd1a99B
         zXXcc+OTJCtZhPBOsQe+X5wPVkkROOl8+/MMEE9emQPtnyKMTV4Xb2Sk7wd9jWA03D5u
         5WUIpmmskK9SYuEu5wkI3+DyKv9QawzkrOE31dthjaUBtRgyriB+xD+Ozx05+PbrJNOO
         U9vuwIzZ1+8aEzcO++hgy8X4XZAB0O0/GZdOqAJVlPcHvTupagTSID1acajBdGhUypls
         LsgsZzYctmO8wb7+HqJuJOiMQAlHXJ32LutgOOzMIeafDGIPNcYw7B2gYWWSu62HURbl
         psEA==
X-Gm-Message-State: AFqh2ko1ElzU5vjqib2Iw7KEOTCdIoPgJiqF9KeezgAN9hAgM3qCcISR
        4i/7ARYAs2DDXwo92zDWjxe8S78z2lI=
X-Google-Smtp-Source: AMrXdXvoo+UEu2LiQv2BzUt1n79nbli9RX3ZSsIzrzkf7O+sFjuwsNPQX0i9vZ+XPd/UvSkqrPLZMw==
X-Received: by 2002:a05:6a00:e8d:b0:580:c223:90e9 with SMTP id bo13-20020a056a000e8d00b00580c22390e9mr72712973pfb.6.1673668033623;
        Fri, 13 Jan 2023 19:47:13 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 132-20020a62198a000000b00575caf8478dsm14372811pfz.41.2023.01.13.19.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 19:47:13 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] ci: do not die on deprecated-declarations warning
Date:   Fri, 13 Jan 2023 19:47:12 -0800
Message-ID: <xmqqv8l9n5fj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Like a recent GitHub CI run on linux-musl [1] shows, we seem to be
getting a bunch of errors of the form:

  Error: http.c:1002:9: 'CURLOPT_REDIR_PROTOCOLS' is deprecated:
  since 7.85.0. Use CURLOPT_REDIR_PROTOCOLS_STR
  [-Werror=deprecated-declarations]

For some of them, it may be reasonable to follow the deprecation
notice and update the code, but some symbols like the above is not.

According to the release table [2], 7.85.0 that deprecates
CURLOPT_REDIR_PROTOCOLS was released on 2022-08-31, less than a year
ago, and according to the symbols-in-versions table [3],
CURLOPT_REDIR_PROTOCOLS_STR was introduced in 7.85.0, so it will
make us incompatible with anything older than a year if we rewrote
the call as the message suggests.

Make sure that we won't break the build when -Wdeprecated-declarations
triggers.

[1] https://github.com/git/git/actions/runs/3915509922/jobs/6693756050
[2] https://curl.se/docs/releases.html
[3] https://github.com/curl/curl/blob/master/docs/libcurl/symbols-in-versions

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 config.mak.dev | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/config.mak.dev b/config.mak.dev
index 981304727c..afcffa6a04 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -69,6 +69,15 @@ DEVELOPER_CFLAGS += -Wno-missing-braces
 endif
 endif
 
+# Libraries deprecate symbols while retaining them for a long time to
+# keep software working with both older and newer versions of them.
+# Getting warnings does help the developers' awareness, but we cannot
+# afford to update too aggressively.  E.g. CURLOPT_REDIR_PROTOCOLS_STR
+# is only available in 7.85.0 that deprecates CURLOPT_REDIR_PROTOCOLS
+# but we cannot rewrite the uses of the latter with the former until
+# 7.85.0, which was released in August 2022, becomes ubiquitous.
+DEVELOPER_CFLAGS += -Wno-error=deprecated-declarations
+
 # Old versions of clang complain about initializaing a
 # struct-within-a-struct using just "{0}" rather than "{{0}}".  This
 # error is considered a false-positive and not worth fixing, because
-- 
2.39.0-198-ga38d39a4c5

