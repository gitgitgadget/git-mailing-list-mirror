Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5ECC433FE
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 05:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbhLQFMS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 00:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbhLQFMR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 00:12:17 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F4BC061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 21:12:17 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id q15-20020a252a0f000000b006092c637e21so2681135ybq.5
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 21:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iRslzlzSujQNxNYyhz2OdRj84YHnhfPdyZMObUi2dNs=;
        b=fJL4NHFYuACvntoDrTFvOh5B5JqVaIf0/jC9+vSa9uw1X03N235H0EhbP9YBKzTYg6
         Mo1fy+ezCl/7ls+TjxkokremPdmtPfu7U8d96Auyg91SctqTMmZp5zFl1El9DSEFigT3
         90d3b8L9axp/HD6hFbheWaXa6WQz3enpWT2rnSlDI375B80PSa9W4M+CrDQbvOJSQMZ/
         Ba6ishmZBB61DhcOWSxEQ4LRptksSLx84KG6GNtFr8+b2mdgXD9msjIRC6sTqm1dwG9v
         3o/68aIYkkYifsW3qcBOQ5Q8D0WkozjkPEmPbHuTRDNrRBliNl/2WunTJmkxgRAZVbVk
         un0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iRslzlzSujQNxNYyhz2OdRj84YHnhfPdyZMObUi2dNs=;
        b=Rn4EVs4pfv3AqRROH9QMZ4qKNj5nYoENit8ICTmgEG44TEvRW/9peKRQ4GXKCDSjAW
         eYjWdDBh24koKSUh5/rps3vm0BD0HfAO/oUwW5GV7F5i8LykOROtiJKPZVQEw6KKNhki
         WJURotcPs64ON2q9c0w+LqtquYBetPrjuq8G1m9LTBYS6MwuOcEcMItpX/5Gt0vZWyyr
         76n/pbUZ8B9jkRXLnam7eWS+IEYcSw/vbFVKP0RsAlCM2zQeK6N2Sobf5nHtFoSuRpQq
         bVcWPoG+LVjsf/kP5Nl5G6Wibhip7kVkcz7g8lrX00jGuCf+SyLV3g+EOW4w0ipQC7Vm
         hxTw==
X-Gm-Message-State: AOAM533pxOikALjxiC8hu/V7ixCRlPs+Rd8OJTPt82Amtldz/z5HW1WD
        A2UMiMqUilZHltaIz6Sian7SuWJ9b1eaIz4fyH2Ic780rEr+EjXqacoTf7l1QGCgZ5ODfAvVlRj
        wSfYcBGgL/s5LHyc8FYhampDzvoGFS42ypcRNTZrYCKdufP6qzpy6USdKpGA2S6c=
X-Google-Smtp-Source: ABdhPJwbneGY07rBUOp1UL89yzwQbj6AKI1kKOETmkDE+cE7GQKFlLDLoPgDdu/ezsBR+69oDvekfsgmforVXg==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:a37:b5e2:96be:e5d5])
 (user=steadmon job=sendgmr) by 2002:a25:ce0f:: with SMTP id
 x15mr2305682ybe.584.1639717936748; Thu, 16 Dec 2021 21:12:16 -0800 (PST)
Date:   Thu, 16 Dec 2021 21:12:08 -0800
In-Reply-To: <cover.1639717481.git.steadmon@google.com>
Message-Id: <a818a6561b2cb30f7dff9f52629cbbcf21658740.1639717481.git.steadmon@google.com>
Mime-Version: 1.0
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <cover.1639717481.git.steadmon@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v7 3/3] config: require lowercase for branch.*.autosetupmerge
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, chooglen@google.com, avarab@gmail.com,
        Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Although we only documented that branch.*.autosetupmerge would accept
"always" as a value, the actual implementation would accept any
combination of upper- or lower-case. Fix this to be consistent with
documentation and with other values of this config variable.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 152c94f29d..54c0e7d98e 100644
--- a/config.c
+++ b/config.c
@@ -1577,7 +1577,7 @@ static int git_default_i18n_config(const char *var, const char *value)
 static int git_default_branch_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "branch.autosetupmerge")) {
-		if (value && !strcasecmp(value, "always")) {
+		if (value && !strcmp(value, "always")) {
 			git_branch_track = BRANCH_TRACK_ALWAYS;
 			return 0;
 		} else if (value && !strcmp(value, "inherit")) {
-- 
2.34.1.173.g76aa8bc2d0-goog

