Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D3CC05027
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 19:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjBFTzM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 14:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjBFTzK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 14:55:10 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1D22820C
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 11:55:09 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 200-20020a2505d1000000b0088347752c5fso5894086ybf.18
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 11:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7wDWayck+EYrCiyK81QVcBck0sLiH++NhfCi/d0wYrM=;
        b=SxcfopbKOQzmS4EgWcg+9/kYcnZKW4G+oJtw1P2hbYdsgRVZTuooOukV1JfSNG9RBm
         N2kMZIG7tkOozroragOI9ZCP+oXPyuO3PJGPeGLGIQk+QDOv5iKAeIX07ksD9SMlqkou
         1TS/GtmIaqHYOo96ps6Y0ItXCpMNp0VgFwy1QLvvxlNoacsTNmxBbZaViaNMvnn7thpy
         5x0N2QBaxQVdQX55odojDJUKlmOrwjqGq+hAtJjhUFz8mZwABPmbJ3ZuuIlkn1+k62RR
         9OpbVv6NmduOb6ex9SCEHyqu8ZImJnYxL35XFbKDnD4RscgFTJPGRSK8FE5XTwwyms5Y
         WBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7wDWayck+EYrCiyK81QVcBck0sLiH++NhfCi/d0wYrM=;
        b=Hnv1lT5x2TfR066qJycFhC6GfPBPnz1iRP82u+QWNP0ONwxdKlFgwXDMXWcJbzuEk9
         5U9kBwWcnOWoiqudCNPSP73rLPDaTk4xU/bIKklNIPlangqHjmlNcpETUkWmDYlEtl+j
         LbANyib8mpH56fxZEsi4LRgiFZC0VVjysvUWf69LQPvKJJb7U/UExU1qD2adl8k8sJT/
         ocsr80LRpyGhNPc9pzDPtuUjiMSN5qejef7e3rf+VK5nuDdxKK6P1qsRy1srpO3Nk5qG
         ItduaZR/zb3KI1cqMJZDuiERm63ld4ZnioJl8sr5KX/FjfiPExIlATDwXIwmsC6qaYW+
         Hbdg==
X-Gm-Message-State: AO0yUKXbojOB0W5y/0ypJvh3UgM1z9AQ9YN+6Qpng092chImOCCPadwz
        d8XcxCc+ellJDpnWn8wvunEDmwWnfNWbo4aAS49rWoU8eR4keJN+2N6VJi6WmNxQcXX8C7KpmXh
        8YaK2Zn1yyQvE6sZ+GjOuQwzUQWpFfGSU/dW7O/LF92pG2x/nGHR0IBwBw0462lzFfA==
X-Google-Smtp-Source: AK7set9eDwudm4auiJ8q5G+wg5Kd00h7vNAwLjaYk0u/dy29MGciz63lx4g7HZVwNEbiwUrFZ5O7RQX4VVW5PRQ=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a0d:d7ce:0:b0:525:b159:ce3d with SMTP id
 z197-20020a0dd7ce000000b00525b159ce3dmr0ywd.3.1675713308045; Mon, 06 Feb 2023
 11:55:08 -0800 (PST)
Date:   Mon,  6 Feb 2023 19:55:03 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230206195503.3113048-1-calvinwan@google.com>
Subject: [PATCH] Documentation: clarify multiple pushurls vs urls
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While it is possible to define multiple `url` fields in a remote to
push to multiple remotes at once, it is preferable to achieve this by
defining multiple `pushurl` fields.

Defining multiple `url` fields can cause confusion for users since
running `git config remote.<remote>.url` returns the last defined url
which doesn't align with the url `git fetch <remote>` uses (the first).

Add documentation to clarify how fetch interacts with multiple urls
and the recommended method to push to multiple remotes.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 Documentation/urls-remotes.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/urls-remotes.txt b/Documentation/urls-remotes.txt
index 86d0008f94..61aaded645 100644
--- a/Documentation/urls-remotes.txt
+++ b/Documentation/urls-remotes.txt
@@ -33,7 +33,10 @@ config file would appear like this:
 ------------
 
 The `<pushurl>` is used for pushes only. It is optional and defaults
-to `<URL>`.
+to `<URL>`. Additional pushurls can be defined to push to multiple
+remotes. While multiple URLs can be defined to achieve the same
+outcome, this is not recommended since fetch only uses the first
+defined URL.
 
 Named file in `$GIT_DIR/remotes`
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- 
2.39.1.519.gcb327c4b5f-goog

