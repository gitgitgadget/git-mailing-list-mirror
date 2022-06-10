Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9A7C43334
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 19:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349925AbiFJTw4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jun 2022 15:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348291AbiFJTwy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jun 2022 15:52:54 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C1E24D68D
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 12:52:52 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id l5-20020a170902f68500b00167654aeba1so54207plg.2
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 12:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dAnmDFp0xz7Ll/kgzscPQE5Nr6NojDFdlF0cunZTfPM=;
        b=OHWZu8kcPLdO31L2Dc+4vVDWf7DtXTDiIjLhRNPYm7Pl2PQhzoa7VLGqoGgg+Lr43j
         b5amMiHNrK8v35k1DDBknKstNY0jf1LtQ+tDVw5+32WWg+WG0Ix4sy36tmHO9zB1oouN
         kf7PGwqYAe6EpQRozBok3MY3EZk1VNnEFHdoXH2US0hz5+7Kt6KSLajgNHKVd24yAMjo
         jaZfIwLWxzDxeR7RoIVburQhmGDjO1JHWbmWZaX3mljvX+PnDeXMCv3ZjNA6dCgUrlpu
         b+ShvH/uLxa4rlG+2sG0zhLajkdO6kc0lxKsACrzsT3SlpsogK5aSOmOE3zcqWxQ9ZJs
         hwIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dAnmDFp0xz7Ll/kgzscPQE5Nr6NojDFdlF0cunZTfPM=;
        b=l9Chp+enXOTH+/ZJtmyPpRhZ0s1yak1vwY0Did55AmEK3EzehmHDkw2hvWJHCN3b4m
         rACqt7+npd5b9EkpHYt/8NjvyTaZc0jL0/x3FeRF+q2Kyr6LT6nhbKYMPQiVg/6G1bRI
         uSVsiFaightQGFZWf00LRZQKuPkRy6v2Eh2FFInzKc5R4XgM2rGhuZOhQqr81bZgaA81
         Wa8W8WW74EqUSiksp9CPaHEuUAm5F6L+R+3+2p5+j091bQRS31rzpQucAynqcL9zn4+k
         4ezVrQylXr2647MGLUeZAwQIUL/ZsP7IUN2c4BdKuZkh4YtRGvp4WuwbmaCUHM4roI9/
         tnyA==
X-Gm-Message-State: AOAM533YYbxufFsBcB6p/xyH6gu6oQDdkSWvOgdcD994z28rcT+uIIZV
        bD37XpaytdNM+MWE+m71IFYyJegOYH+LDUAxJaYayPSAZ0tA00hO0Rf6DvrWsnk1eVYVzPGJ1O8
        WDdnceUzGphLAQQVtSD+fMA2kUBkrE2BoslMpl2ZcqSoLCaKSyt9lS4Y7I1m18PboFL90/5G1CX
        Fd
X-Google-Smtp-Source: ABdhPJz6jxmKFdAPozvxxFqMNVgjsBGrcxXvXQ99DXD226U8w+/rA3gUbrKdzNKwyHHow1LWeu5tX2IL/JHfO8RLtF5L
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6a00:194d:b0:51b:eb84:49b1 with
 SMTP id s13-20020a056a00194d00b0051beb8449b1mr37545725pfk.77.1654890771959;
 Fri, 10 Jun 2022 12:52:51 -0700 (PDT)
Date:   Fri, 10 Jun 2022 12:52:47 -0700
In-Reply-To: <20220608210537.185094-1-jonathantanmy@google.com>
Message-Id: <20220610195247.1177549-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20220608210537.185094-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH v2] fetch,fetch-pack: clarify connectivity check error
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the connectivity check after a fetch fails, an error message
"<remote> did not send all necessary objects" is printed. That error
message is printed regardless of the reason of failure: in particular,
that message may be printed if the connectivity check fails because a
local object is missing. (The connectivity check reads local objects too
because it compares the set of objects that the remote claims to send
against the set of objects that our refs directly or indirectly
reference.)

Since it is not necessarily true that the remote did not send all
necessary objects, update the error message to be something that more
correctly reflects the situation.

The updated error message is admittedly vague and one alternative
solution would be to update the revision walking code to be able to more
precisely specify if a bad object is supposed to be available locally or
supposed to have been sent by the remote. That would likely require, in
the revision walking code, to delay parsing any object until all its
children has been parsed, which seems to be a significant undertaking.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
As Junio said in [1], my original v1 code doesn't work when an object is
referenced both by a local object and a remote one. I tried looking into
making it work but it looks difficult.

So here is a patch that just changes the error message to a vaguer but
hopefully more correct one. I wonder what the community thinks of it -
I think it is more correct (and means that we do not need to say "it's
not the remote fault despite what the error message says") but at the
same time, many people are already used to this message (and a search
online reveals several web sites that talk about this).

[1] https://lore.kernel.org/git/xmqqh74upyz3.fsf@gitster.g/
---
 builtin/fetch.c | 2 +-
 fetch-pack.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index ac29c2b1ae..15737ca293 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1133,7 +1133,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 
 		rm = ref_map;
 		if (check_connected(iterate_ref_map, &rm, &opt)) {
-			rc = error(_("%s did not send all necessary objects\n"), url);
+			rc = error(_("connectivity check failed after fetching from %s\n"), url);
 			goto abort;
 		}
 	}
diff --git a/fetch-pack.c b/fetch-pack.c
index cb6647d657..91269008cc 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -2021,7 +2021,7 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 		if (args->deepen)
 			opt.is_deepening_fetch = 1;
 		if (check_connected(iterate_ref_map, &iterator, &opt)) {
-			error(_("remote did not send all necessary objects"));
+			error(_("connectivity check failed after fetching from remote"));
 			free_refs(ref_cpy);
 			ref_cpy = NULL;
 			rollback_shallow_file(the_repository, &shallow_lock);
-- 
2.36.1.476.g0c4daa206d-goog

