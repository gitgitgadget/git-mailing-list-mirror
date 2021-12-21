Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4382EC433EF
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 19:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241667AbhLUTAq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 14:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbhLUTAp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 14:00:45 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6F7C061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 11:00:45 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id j204-20020a2523d5000000b005c21574c704so27154195ybj.13
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 11:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=A32I9VDpGnIQZNhWswNnziw9ntapto5SnpeQHmUQitA=;
        b=hFU9Cc0mw4P6thrg2bWS+Sp7fE4RC06Ve8jO4ETL35g9iQevfxT1FtW+NF1qy0iq6P
         C/N79awQUJU4fCFwR6isqvI6sTeq1C38F2jEU/8FHPPr6SUhR66bpbA1LT8gs4+tNzSk
         P39V9W6TWRzODBhoLupaediEIzl3XqG04XqHC6UwiNQa1DUuDp2uPSjGBWuS3n41Jm7i
         DDzlNhNUJs5PH8BtD649nqQoXhDZ/BGQihBKDBmFiWV6sOS1t7VeTm+pzQ1ZP/X75CA0
         /UQSwtBk7YRMRuY2//ioBq2OW2pBqm/uQ0PpJsAvlLPTYJzrJEQyLxKcBFKvRAZcFtsv
         r90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=A32I9VDpGnIQZNhWswNnziw9ntapto5SnpeQHmUQitA=;
        b=xixvDuQccBp4N3LtL+H/1MXvWyUAwGt/wk+ZGI6em2vV7D+BsdbbrdfnPMY3Tr02mt
         OkIHs5dqz+1F4uOlE916LB3CTPKwG2Mqzug5ET3e6vYu4+e85w7sLtZ/G7iZGkHTjbMf
         RAgHdsROFB0/GAse3ShE+orOKl+/sGTOL8w1mtFCltT1i7UHe8KDnWwOKQ8298d04IR2
         9Zn4qjvgxjscwnhpeOHuizVKmMWcOYyB7v8zgZwjcUm4HjKHNxcz5ZHoyODYwHwIyj15
         rXEZ9zerwG4umOmcepP1bNe8TfFLrvvFUi1ao+qthLoifHopbYBcA3OpXOjsloerHzYv
         yjQA==
X-Gm-Message-State: AOAM530/u0vblz3WJdtraQxlLm/MLJ/GfISqeWO0bmhEOawAlaBkxcWd
        nTTUQwCE9Wz482Lr0RfJ2TjJQlgZB6/7nJ+oI2vtMmNXNyXLavAolb1q7JCUEUAEqn3JiKRUHWF
        3/wc9sxQKJLJGez+o/etM2uK7zAHoVWghBQcv/2npgW2MMLa5up6joQq+VTb4UdU=
X-Google-Smtp-Source: ABdhPJwUQGLEe2L2nMOJUFqbqfaXy7ZGYt8s2apEQfbZjECNzztiG0q+x8E3UsOGsZO2hRLKCFlP+QBAIlHACA==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:e4d8:c4fc:fa70:c18e])
 (user=steadmon job=sendgmr) by 2002:a25:50c4:: with SMTP id
 e187mr6708934ybb.489.1640113244509; Tue, 21 Dec 2021 11:00:44 -0800 (PST)
Date:   Tue, 21 Dec 2021 11:00:42 -0800
In-Reply-To: <25107068cbbf8c9ce6886e66e25dff19e072583f.1639425295.git.steadmon@google.com>
Message-Id: <a9453065c2e89d79fc117363fe41fa10986e06d1.1640113138.git.steadmon@google.com>
Mime-Version: 1.0
References: <25107068cbbf8c9ce6886e66e25dff19e072583f.1639425295.git.steadmon@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2] l10n: README: call more attention to plural strings
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, worldhello.net@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In po/README.md, we point core developers to gettext's "Preparing
Strings" documentation for advice on marking strings for translation.
However, this doc doesn't really discuss the issues around plural form
translation, which can make it seem that nothing special needs to be
done in this case.

Add a specific callout here about marking plural-form strings so that
the advice later on in the README is not overlooked.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 po/README.md | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/po/README.md b/po/README.md
index dcd8436c25..19fabb4acf 100644
--- a/po/README.md
+++ b/po/README.md
@@ -221,6 +221,10 @@ General advice:
 - Adjust the strings so that they're easy to translate. Most of the
   advice in `info '(gettext)Preparing Strings'` applies here.
 
+- Strings referencing numbers of items may need to be split into singular and
+  plural forms; see the Q\_() wrapper in the C sub-section below for an
+  example.
+
 - If something is unclear or ambiguous you can use a "TRANSLATORS"
   comment to tell the translators what to make of it. These will be
   extracted by xgettext(1) and put in the "po/\*.po" files, e.g. from

base-commit: cd3e606211bb1cf8bc57f7d76bab98cc17a150bc
-- 
2.34.1.307.g9b7440fafd-goog

