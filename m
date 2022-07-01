Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48BFCCA479
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 10:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236593AbiGAKiO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 06:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236431AbiGAKh6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 06:37:58 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22A3796B9
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 03:37:56 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id m6-20020a05600c3b0600b003a0489f412cso3430833wms.1
        for <git@vger.kernel.org>; Fri, 01 Jul 2022 03:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y1KdZzlEl603rC4dv7KtuN6rmyFK3ewrfSxDzDx7+Nw=;
        b=kihGOTFlOxiYIgJ+BUv23hhJ6bgu07S773cztuR/JFP9zt1VkW3egZxGaQWfaBOzK+
         +xhsxjJ1RKN5S1d4JXtItUHgRMP3HGqa8GSsMQGTZgiMCimqzl+tpsoU+HKWnsquk2zZ
         K9tAnxByb8psJnvRsuFNhZM5dncXKX7+dD5AZjZF+8beaJ//b88Dnli33SHc0DoMEz3P
         EaN5l+h928TKRob0n2GmJBRe2gKtmP312vTsiJYekqcQebWa2F4gfogJdh34+g0iRk5L
         IpdLoii5gwDdXn19taDaPXpm5sLziI0fhHIfCXLQUsaBSyf306eCPLip/OhnpPIBZf10
         gk4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y1KdZzlEl603rC4dv7KtuN6rmyFK3ewrfSxDzDx7+Nw=;
        b=QyDdkRLDtlekoM0q+u7vz+jFzlzFB9pt6s+qCX5KhA36aCsO5jIbaZP2bKGQ4lOIsb
         gbR6klhZh6DQu4xcM9Zrtg5wfbEehjv4NFDvc1Z0fC7fmCc7DQhiv7ZrISIcxmlFHtdJ
         Yzb0DwWRpJodiQWBR6r8B8pYmnBQKEVYHxUq65KH/CSZAPbWVG6RHiWpdwmPlQ7YkvtP
         gwe0dEIjU39TWB6kCm7+PAK19iAU+y9pWYd4KSXlwNy0+EeimsxHEI+Xzc3gb4bSVzOY
         o5SEpBpJj7edUb4Fx5xgjAWkvXy7OU7Xxvpr6jQR5G7xz+NAsgijqHMcO3JgyY2wvczX
         USOQ==
X-Gm-Message-State: AJIora857xDoRVejnWdkOd4Jxln7rCxslQblD0CgM/XQT4xEuKE8bi4s
        WXMyO+LDdF83vm0I6/o4qpF13A+D8I0aiw==
X-Google-Smtp-Source: AGRyM1u15kQxR+YfFmTnFHFRY6kXjTLtmgJwOytF+6YSTXewA/pwZGWRDObPsZVZWP2aDj+ApV/XFg==
X-Received: by 2002:a05:600c:6013:b0:3a0:2aec:8695 with SMTP id az19-20020a05600c601300b003a02aec8695mr17102419wmb.192.1656671875237;
        Fri, 01 Jul 2022 03:37:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r12-20020a05600c35cc00b00397393419e3sm6229871wmq.28.2022.07.01.03.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 03:37:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 8/9] test-tool ref-store: fix a memory leak
Date:   Fri,  1 Jul 2022 12:37:39 +0200
Message-Id: <patch-v2-8.9-937b4cdf07e-20220701T103503Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.900.g4d0de1cceb2
In-Reply-To: <cover-v2-0.9-00000000000-20220701T103503Z-avarab@gmail.com>
References: <cover-0.9-00000000000-20220630T180129Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20220701T103503Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak introduced in fa099d23227 (worktree.c: kill
parse_ref() in favor of refs_resolve_ref_unsafe(), 2017-04-24), as a
result we can mark another test as passing with SANITIZE=leak using
"TEST_PASSES_SANITIZE_LEAK=true".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-ref-store.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 9646d85fc84..4d18bfb1ca5 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -96,6 +96,7 @@ static const char **get_store(const char **argv, struct ref_store **refs)
 			die("no such worktree: %s", gitdir);
 
 		*refs = get_worktree_ref_store(*p);
+		free_worktrees(worktrees);
 	} else
 		die("unknown backend %s", argv[0]);
 
-- 
2.37.0.900.g4d0de1cceb2

