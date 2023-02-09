Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C8CC636D4
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 00:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjBIAC3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 19:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjBIACY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 19:02:24 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D951F5EC
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 16:02:21 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5005ef73cf3so3204017b3.2
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 16:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K46XHE2BLqdDbnyWSR0bU7t4XlcU/9xs6xJD00qC73Y=;
        b=oDnqvPKed0DuFaC0OU2OsbBP1SLR/R0STZfssp+5GzChtrX2r6nTKI5NIM8sGWsW9l
         BLdv5OWCv5eF9NUSNrQYFT6XZcPTjOCHjfD6MXuhzMS8j2tCq/OLQ+FvwXgAb+COb9/F
         KqfDmv5KZva7NeEFQZotK8ti9K4pJXfO2tNw+sK0p0rZJuynia4gu+cQLcT9Go+yFyMc
         F2onF/5DQqKvJy9LvY9Ik8UGbL6/9dhXPPNR7EWOia+UxX7ytvYGXeZ3IBSVyYqeUxtj
         UkE2LD+daByd2Uwc891jshz30C/bRFH9yHDRsf29qAYM8Fj7l9pWDFJrY8nus5GwgS8z
         IlJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K46XHE2BLqdDbnyWSR0bU7t4XlcU/9xs6xJD00qC73Y=;
        b=hjmgNRmr+j1NTxCt6Wk0+P/LWgTTYLWS9DgBmO0W/xuLrSRTxK3ltf9zVZWAzxtEZR
         8gozOYQiJuCF02qO8i4TDfuVMhSLi4vHXR0EkhFhu2wgGv1DwGOaUn+CHDFifQjyLW7O
         ijeRD4mV9FKxmkZMQZ4i4C/1gd8X6QG1jI2KZS8BZ+hjFf6cccrTURqVh8NPMhL37AAG
         w5iZwFXNTJgIc5QBFJoVLrvUJLDadA2aGWeN10PkkPzv7j8ws8dALDVpFZdcdF6cDO1s
         UQLaIy5jUoFu/sZbM88hA/5HUZwrFZEdE0fFlF6igJYLS5g+6yTKZZnEaYhP6bz9yIt8
         lcdg==
X-Gm-Message-State: AO0yUKWMYrm8w6XINtu92LVh+QNDuctALiBXXaTEDjfPRlZ+40FFJMMo
        WH9pPubecxamtjv7QwCZ7yMKm1BS5chcACgZooA57jhjE3T0m7gsMfIhvMqwhLNUMeJ4TqM5Td+
        fQQjaI3syjpHmzFDazroQo78VzMgeMDrsjKkuy3RPcP8H5C6WEt4j6b/6+RCRjz81kA==
X-Google-Smtp-Source: AK7set8bKina/gNC2LHiPpMysXlYLCrbnq0pRdfbV8Alt/RJpwu88D3g7Z9wie2kiKQLnle+HywQvdWZiUlYkMA=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a25:67c6:0:b0:8ad:5075:f78f with SMTP id
 b189-20020a2567c6000000b008ad5075f78fmr5ybc.0.1675900940267; Wed, 08 Feb 2023
 16:02:20 -0800 (PST)
Date:   Thu,  9 Feb 2023 00:02:08 +0000
In-Reply-To: <20230207181706.363453-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230207181706.363453-1-calvinwan@google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230209000212.1892457-3-calvinwan@google.com>
Subject: [PATCH v8 2/6] submodule: strbuf variable rename
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, avarab@gmail.com,
        chooglen@google.com, newren@gmail.com, jonathantanmy@google.com,
        phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A prepatory change for a future patch that moves the status parsing
logic to a separate function.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 submodule.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/submodule.c b/submodule.c
index fae24ef34a..faf37c1101 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1906,25 +1906,28 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 
 	fp = xfdopen(cp.out, "r");
 	while (strbuf_getwholeline(&buf, fp, '\n') != EOF) {
+		char *str = buf.buf;
+		const size_t len = buf.len;
+
 		/* regular untracked files */
-		if (buf.buf[0] == '?')
+		if (str[0] == '?')
 			dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
 
-		if (buf.buf[0] == 'u' ||
-		    buf.buf[0] == '1' ||
-		    buf.buf[0] == '2') {
+		if (str[0] == 'u' ||
+		    str[0] == '1' ||
+		    str[0] == '2') {
 			/* T = line type, XY = status, SSSS = submodule state */
-			if (buf.len < strlen("T XY SSSS"))
+			if (len < strlen("T XY SSSS"))
 				BUG("invalid status --porcelain=2 line %s",
-				    buf.buf);
+				    str);
 
-			if (buf.buf[5] == 'S' && buf.buf[8] == 'U')
+			if (str[5] == 'S' && str[8] == 'U')
 				/* nested untracked file */
 				dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
 
-			if (buf.buf[0] == 'u' ||
-			    buf.buf[0] == '2' ||
-			    memcmp(buf.buf + 5, "S..U", 4))
+			if (str[0] == 'u' ||
+			    str[0] == '2' ||
+			    memcmp(str + 5, "S..U", 4))
 				/* other change */
 				dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
 		}
-- 
2.39.1.519.gcb327c4b5f-goog

