Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1428B1F424
	for <e@80x24.org>; Thu, 21 Dec 2017 13:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751472AbdLUNKw (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Dec 2017 08:10:52 -0500
Received: from mail-qk0-f202.google.com ([209.85.220.202]:42993 "EHLO
        mail-qk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751328AbdLUNKv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Dec 2017 08:10:51 -0500
Received: by mail-qk0-f202.google.com with SMTP id a2so17843560qkb.9
        for <git@vger.kernel.org>; Thu, 21 Dec 2017 05:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=1m2UafG4BJ8+AHM1ulNS5zhE3Yz2f7tUpWDZrCZexMw=;
        b=WL9Bpd63CfpjGBIsef+AV4BNbmgKfD5e8skF2tas6EnqHr1lLVmyZsCy7zVvXTAMkw
         H4QNm5IZf4zcf0RZWhFL019F4gIbI15cbTzkGz+HKs60iOv8o+NUS02NYxrOe6z0EppB
         bboO6aUORjbjShRHhMRBd3Sl22b9OajE4pocvA4/hlbWTvMrY76bulxFoC5Qcur01OR7
         YNOylWzw34FwACbQ/yU6CMlqCYjn7WML5DElHIamtyuBXPQZ/TFnwO/6RiF4+EIegPtE
         9/3J/zN6WzjXsj9LaU7E+LLZr74uZASYqmpZQbttDzTAMTadnf0Fii/vJcUU2NXCd6Ls
         q1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=1m2UafG4BJ8+AHM1ulNS5zhE3Yz2f7tUpWDZrCZexMw=;
        b=PiR0zY90mKJxCOSZysH8zieblpp1W6hCDlv+DUC3FzY9FUYefJR9I1Vl6R9WBIN1g2
         4UYajbB7dli7aAgvWuvOBcNEw6kQ23GnbU/r3r9mn1Ts7vIa8NPWSfwuPhmu3x/RvP3c
         zNCNefwxbvX0FXbug3a/mMh7VAqS/FI/gyfvEQDFeLQLYEP9O4mBBS+z4C1ADSKlCxVa
         dLrMj6wcSizhEtbicDxpgk+vy4OgJzfeTlHIi381pRpxp/PY6Hs7LnN1vAzpG8Q2R/49
         eG6BGvjdWUIziF/mK7OQur6aAB5I5RiwZJYt7Cp669XExX46SUxGjLRzj3kjULemsbF2
         iADQ==
X-Gm-Message-State: AKGB3mLOYy8FNsRHn8XF0J4Vq6l4QUjaz0KLsIcGKaR+v4erspdQI2Vg
        OGL53ZWbFGWsEoKYkPQVePfizdcZzxzvcJIDWw9dMbPsWUdFTOIgOMFMXDKaOfwRXarlVmCL8Dm
        WjDem2kTQFE8dJrCjU5Sg6YP1CQtKPMwSE6WoQoWrPiH4/pS1zHn50inkYN9VYp9pPQ==
X-Google-Smtp-Source: ACJfBosfovNTfeCS3hjypJVx9bxH9dOXOPvtuRgQqGVAN1FmFIMFEU3wPPrelW1SGRRsGZtTrmkecW67Mgk28M8=
MIME-Version: 1.0
X-Received: by 10.55.18.90 with SMTP id c87mr6854363qkh.43.1513861850602; Thu,
 21 Dec 2017 05:10:50 -0800 (PST)
Date:   Thu, 21 Dec 2017 08:10:42 -0500
Message-Id: <20171221131042.91107-1-dborowitz@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
Subject: [PATCH] config.txt: Document behavior of backslashes in subsections
From:   Dave Borowitz <dborowitz@google.com>
To:     git@vger.kernel.org
Cc:     jrn@google.com, Dave Borowitz <dborowitz@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Unrecognized escape sequences are invalid in values:

  $ git config -f - --list <<EOF
  [foo]
    bar = "\t\\\y\"\u"
  EOF
  fatal: bad config line 2 in standard input

But in subsection names, the backslash is simply dropped if the
following character does not produce a recognized escape sequence:

  $ git config -f - --list <<EOF
  [foo "\t\\\y\"\u"]
    bar = baz
  EOF
  foo.t\y"u.bar=baz

Although it would be nice for subsection names and values to have
consistent behavior, changing the behavior for subsection names is a
nonstarter since it would cause existing, valid config files to
suddenly be interpreted differently.

Signed-off-by: Dave Borowitz <dborowitz@google.com>
---
 Documentation/config.txt | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index b18c0f97fe..f772186c44 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -41,11 +41,13 @@ in the section header, like in the example below:
 --------
 
 Subsection names are case sensitive and can contain any characters except
-newline (doublequote `"` and backslash can be included by escaping them
-as `\"` and `\\`, respectively).  Section headers cannot span multiple
-lines.  Variables may belong directly to a section or to a given subsection.
-You can have `[section]` if you have `[section "subsection"]`, but you
-don't need to.
+newline and the null byte. Doublequote `"` and backslash can be included
+by escaping them as `\"` and `\\`, respectively. Backslashes preceding
+other characters are dropped when reading; for example, `\t` is read as
+`t` and `\0` is read as `0` Section headers cannot span multiple lines.
+Variables may belong directly to a section or to a given subsection. You
+can have `[section]` if you have `[section "subsection"]`, but you don't
+need to.
 
 There is also a deprecated `[section.subsection]` syntax. With this
 syntax, the subsection name is converted to lower-case and is also
-- 
2.15.1.620.gb9897f4670-goog

