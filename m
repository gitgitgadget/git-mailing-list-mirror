Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EB951F404
	for <e@80x24.org>; Wed, 27 Dec 2017 22:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752647AbdL0W5S (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 17:57:18 -0500
Received: from mail-it0-f46.google.com ([209.85.214.46]:44895 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752473AbdL0W5Q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 17:57:16 -0500
Received: by mail-it0-f46.google.com with SMTP id b5so26514908itc.3
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 14:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iWX9tKx3+c8soSvj4NzQFKjRR0skHvVWcNO9WnxbSOI=;
        b=kyiIlNiyXWWEtMlS9x6musg2AK7ALs5MZaS3+BVQAEo0rvL9JnfB5MqkGRK1abhreM
         DKBG/R2KqqeQpZUo3ZpmlXcyZEbHdsxetqfof6yThEuKOltJBl5GcSwxax5LkW+KNgCI
         VtewqFw8cg7rI/CAklb8K4en5UP6CvdNgse09M7fPASDNu0I2EuigGgZBaMMXE8jpvYc
         PemiNxuMjLLbb0H5chB7lu8H5RvNHMLTCrVdxhkpk3UU9CTbkN6zRaceuuZ+8yya7Okz
         UHyYQLOPXFbJuRCCRp+d8uRZAWwWCca8A3IeL9+2QA6Q5S/gNkL3KhGtP/oyosU5Xufe
         UcKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iWX9tKx3+c8soSvj4NzQFKjRR0skHvVWcNO9WnxbSOI=;
        b=GVfdNXEnHKUzrtRCKJ5OQ/fPbmdg6IMXBLuMzS5Rxz64HkBXu1KfonjMD2/yc39/a4
         NW6ugbQOwyBKzSdqYOqADo+lPHpMeJ4rwDpxRGB+ukc5LrNcgjEgD3wD5OGoBtv3hVJn
         UnU9oHyG9fvKcSa5HCxTXvW1DUrg0kPFFGu+jzI8oAWTtukK/gee8AlKbx8TCjwL+3tq
         9UyCz4478Ginl0vbFPYAanYGEJasnGI6fgO8CqUtc3+SodL+R3Khe2GlO0o1/0gInOf5
         RjNW/gACYLEgug6WGhlWCXhPBqcIpIYKLFVnR7mAoaIC4MK8/pDy/dZybj0gl0YV1a41
         aGMA==
X-Gm-Message-State: AKGB3mK8tdP0+dnvu/1PmCv8U86lovjeZDDQqmP5+SpvgYGbXCmUn/nB
        ctcJDdJL5WANwprhPqRHmTqV+A==
X-Google-Smtp-Source: ACJfBosXRtoPTLgOz0BQ35k4QLYskD45Zx7idhBtduvERxYXJKnycGO5Zwms2r2ysY0VDkIq0S4sIg==
X-Received: by 10.36.253.73 with SMTP id m70mr39016252ith.49.1514415435795;
        Wed, 27 Dec 2017 14:57:15 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id y19sm18131515iod.46.2017.12.27.14.57.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Dec 2017 14:57:15 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: [PATCHv2 3/5] t/lib-submodule-update.sh: Fix test ignoring ignored files in submodules
Date:   Wed, 27 Dec 2017 14:57:03 -0800
Message-Id: <20171227225705.73235-4-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20171227225705.73235-1-sbeller@google.com>
References: <20171219222636.216001-1-sbeller@google.com>
 <20171227225705.73235-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It turns out that the test replacing a submodule with a file with
the submodule containing an ignored file is incorrectly titled,
because the test put the file in place, but never ignored that file.
When having an untracked file Instead of an ignored file in the
submodule, git should refuse to remove the submodule, but that is
a bug in the implementation of recursing into submodules, such that
the test just passed, removing the untracked file.

Fix the test first; in a later patch we'll fix gits behavior,
that will make sure untracked files are not deleted.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/lib-submodule-update.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index d7699046f6..fb0173ea87 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -885,6 +885,7 @@ test_submodule_switch_recursing_with_args () {
 		(
 			cd submodule_update &&
 			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
+			echo ignored >.git/modules/sub1/info/exclude &&
 			: >sub1/ignored &&
 			$command replace_sub1_with_file &&
 			test_superproject_content origin/replace_sub1_with_file &&
-- 
2.15.1.620.gb9897f4670-goog

