Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5846C433EF
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 10:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbiBVKe3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 05:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbiBVKeQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 05:34:16 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588F215B996
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 02:33:42 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id h6so32193528wrb.9
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 02:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=D6VYAnT0XkwVz5TLj2sX77R0z6b5cAQMShUfZW427wg=;
        b=A3WkudGjONOfaQJLZifjWs7C3jEjGIehvyGNruT3xV4A9jiMM3sPkputMZ8D0HFw6a
         Vw2FOGFycj/NjC0N9KpJrz434w6sW4yBjfz3oPeIEHYc0KBYkzrO7RgFScIJD0veanBH
         bgW/WCX3Gpz6nzKymxjC8XTxEVnbNrXZXd2grRpqr8hYMzRjTI0rRLEOso81K3R2IcdZ
         HbRwxQIXMj5kAPAi08lOZJvUkirh6Qd/qdfWp67H1z8HQ5Kn5RkmEaTj0nBopQQsaXlx
         T9Zg9hUVMBmWfT/ZysmOxvHDz7ickhv6bXUTvCHKT3Mo22W4lr57B7VhYJs5iYf5mer8
         NRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=D6VYAnT0XkwVz5TLj2sX77R0z6b5cAQMShUfZW427wg=;
        b=Fq5mkPOl23+zXrmJmGqbx7n8mYmtNvaOvH9EkU7jcOwiyRlXzcuenzUg8zGg28jkNA
         J8EfCqRVZMlPjhkhe1Godubh6NSGVuFOsZ7ySUQw/DEgk2QcI7wLVJ+IyBjoV0AK/VhI
         LcuYxGqCAnV5ezXQshQaLhym31FiMlWwiRQjX/CZRhMVXkl2KsndghDqRbP9FSyNKi/B
         0Sh8v1Kwo4qWTwTQZgSHI2so2mlQvGa3QFkGswFmFnSbRc+DMyigxn+BZt8Qa7uRDOjy
         HqReLRd1tO8CRZpUdqxLMtg6HkUuNmo7Egb7MB7smzITDJ2bIQsygMCBvYGAP14z7yu2
         5Eyg==
X-Gm-Message-State: AOAM530fM5sc/RaWBZOFd3LZ54FvNQ0vjsZzcu6UtZsmDQ0/7ICXMaK+
        Xdyesgxb7Fa6UYqDQCAyYFuuLkKjtBw=
X-Google-Smtp-Source: ABdhPJynuZhBVAdN/DB2Y5aUKgZGsTnonaoJQIcjyXE5PEltvF/Cl+S5chUirndJ/XfQxVMruyZt/A==
X-Received: by 2002:a5d:62c9:0:b0:1ea:940f:d929 with SMTP id o9-20020a5d62c9000000b001ea940fd929mr1569332wrv.164.1645526020844;
        Tue, 22 Feb 2022 02:33:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j12sm3450739wrs.1.2022.02.22.02.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 02:33:39 -0800 (PST)
Message-Id: <eb5871db95b12500cc0a6b8b0e3a82ed9e8fcfbd.1645526016.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1155.git.1645526016.gitgitgadget@gmail.com>
References: <pull.1155.git.1645526016.gitgitgadget@gmail.com>
From:   "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Feb 2022 10:33:36 +0000
Subject: [PATCH 2/2] rebase: `preserve` is also a pull option, tell dying
 users
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Philip Oakley <philipoakley@iee.email>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philip Oakley <philipoakley@iee.email>

The `--preserve-merges` option was removed by v2.35.0. However
users may not be aware that it is also a Pull option, and it is
still offered by major IDE vendors such as Visual Studio.

Extend the `--preserve-merges` die message to direct users to
this option and it's locations.

Signed-off-by: Philip Oakley <philipoakley@iee.email>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 07221d0ae41..97f704bb297 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1205,7 +1205,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			     builtin_rebase_usage, 0);
 
 	if (preserve_merges_selected)
-		die(_("--preserve-merges was replaced by --rebase-merges"));
+		die(_("--preserve-merges was replaced by --rebase-merges\n"
+			"Also, check your `pull` configuration settings\n"
+			"`git config --show-scope --show-origin --get-regexp 'pull.*'`\n"
+			"which may also invoke this option."));
 
 	if (action != ACTION_NONE && total_argc != 2) {
 		usage_with_options(builtin_rebase_usage,
-- 
gitgitgadget
