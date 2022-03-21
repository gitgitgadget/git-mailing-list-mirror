Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4790C433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 23:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbiCUXLG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 19:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbiCUXJA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 19:09:00 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E91C3B5021
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:15 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id r190-20020a1c2bc7000000b0038a1013241dso374070wmr.1
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=74Y/pQydY/ksADNHRzSGGxn3AcdvAHVNEsdGZUW+1tk=;
        b=kIdvIsuxim+LYLabEfC1cI2FYZTOHSxgBZGovey5XJgdBba875rTprqrDJGgXeQlu7
         AZoebQUw3JeEf9COnsaHXlfxenTn81Fm7XYLosiVv6GBjC0yzZchETZKxMB5casY0yM5
         htWcVM9g+LynyIGkzCe5hs0of6xpFVyT4F0RCmQNivlKZc51qH9jGSBC/xyp4IzufOgM
         u/zcIjuggRF7rcOwWFdhnanEF209fkv0c2t3JXu9H0I7OQE4/wIJmVxQKAd6dQbm5iH3
         DtrJVrMa9JOdEyDGFEamBpHfrpFjIhFBX/1F/5xe+nXBIPwkw0jbUwDxjojeirLzppfz
         wfpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=74Y/pQydY/ksADNHRzSGGxn3AcdvAHVNEsdGZUW+1tk=;
        b=r5CdvDB7wNH1YtgnRn4mFdIqJKFqXlheu8C8D5kChZoGucDGeF184ex3SCYTMgTqiD
         sEEPDd7p31uGZ0RAEXvRIeklmouhDBlHHhbZ/nx660epRzFmMaiKOTe0+od8tSVF+8gb
         bkLZBAJooj4ETrBOaSRYrvssupkXSxFJkqIvmCX70/r0lAI3kE5v5r7zY8Xu/ihjy8H6
         7y13D1YwXYTb4O8dCaJeJmu6paI1du7Ay1xdRKKslozZQXNdI6ZU5OAUSyBaE/JxOdDO
         w3VNc6xrXyKT067AJ+vSw6Y5kl4OCwUQ+ixUQbnm5w+y1pK5hcBIs+sd5Q1sjXFFq1Pt
         Ja+A==
X-Gm-Message-State: AOAM532TGEpkD5Taf+LeNVQEqxHTSa4N5df0yyiut0eT3lvbnysTlKfb
        I4ZcPp05Ca/lGc/85whVOYmtyx6sEjs=
X-Google-Smtp-Source: ABdhPJzaACq0aVazyh5KJ2PU8/+wd3KZ3wMnNHwkjfaRPNgUf5/L3vSoOhMhKWeJ1bK94TWyed1Ogg==
X-Received: by 2002:a1c:f604:0:b0:38c:8ffd:dbb6 with SMTP id w4-20020a1cf604000000b0038c8ffddbb6mr1095358wmc.43.1647903356230;
        Mon, 21 Mar 2022 15:55:56 -0700 (PDT)
Received: from fedora35.example.com ([151.24.239.1])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d440d000000b00203f2b010b1sm10022910wrq.44.2022.03.21.15.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 15:55:55 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 17/41] shortlog.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
Date:   Mon, 21 Mar 2022 22:54:59 +0000
Message-Id: <20220321225523.724509-18-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220321225523.724509-1-gitter.spiros@gmail.com>
References: <20220321225523.724509-1-gitter.spiros@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The C standard specifies two constants, EXIT_SUCCESS and  EXIT_FAILURE, that may
be  passed  to exit() to indicate successful or unsuccessful termination,
respectively. The value of status in exit(status) may be EXIT_SUCCESS,
EXIT_FAILURE, or any other value, though only the least significant 8 bits (that
is, status & 0377) shall be available to a waiting parent proces. So exit(-1)
return 255.

Use the C standard EXIT_SUCCESS and EXIT_FAILURE to indicate the program exit
status instead of "0" or "1", respectively. In <stdlib.h> EXIT_FAILURE has the
value "1": use EXIT_FAILURE even if the program uses exit(-1), ie 255, for
consistency.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 builtin/shortlog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 26c5c0cf93..0763c94df6 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -381,7 +381,7 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 		case PARSE_OPT_ERROR:
 			exit(129);
 		case PARSE_OPT_COMPLETE:
-			exit(0);
+			exit(EXIT_SUCCESS);
 		case PARSE_OPT_DONE:
 			goto parse_done;
 		}
-- 
2.35.1

