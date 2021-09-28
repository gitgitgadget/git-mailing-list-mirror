Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BFEC433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 20:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75EF361157
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 20:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242603AbhI1UNG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 16:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242692AbhI1UM6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 16:12:58 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627CAC061749
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 13:11:18 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d81-20020a251d54000000b005b55772ca97so140092ybd.19
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 13:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=g9NiPhmvd3iIq+aqdMHRHTZSIhgVyvtcXxiZvrp8lD0=;
        b=EqhPBzQOoCasTBRi5vx1yTt8qP4d3K41vdboHvDyQF50buwPvliWaMnOH6iep/g1Sk
         gWJLDK3w2LhGOTYeUagi121cYcJVUG6YBBeP3GQiKnQm+luwz4iO2WnouJSddnUDWvQe
         OVtuAD5iCdvvz9KNwh4X4GYrDYHBlEwA8DNKJuemxW3ogHPma/OJAntGXnGQ8jIdAQtR
         i7F8FaYn5twoZbgqxOt0NFO9Kam3QImERqmrMtAK327v8XESuQkMBf0iTZq82buDCqPB
         Hg42f/EGbGBclyCFVTCLARxSXBLT2vv02/9hdKqWbeqoT/jGc47rCMU9SI1wqTj02FbQ
         gOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=g9NiPhmvd3iIq+aqdMHRHTZSIhgVyvtcXxiZvrp8lD0=;
        b=5/ni9lvKMxKiYTfMXWUCK/i30aGfkl/qbYmHLMsd+GS6vqnKtn6YFp91fS85/gwcvl
         eyaxP2NXn9c8/ev0LKMjURd9zeq/pIWNCTIBETsFqL5L6/3eD+CUD/DRQNTUGZuyi0VG
         Zut/Em3aTlA8xC+aqBvWwVXMY3kP/hzeiiPuJJ3sCmReTbceY824j/RVHVKLd4mek9R3
         zP0RQcrz6/ZWNrJ+vmgIFTWmy3T5K4xoHGAqc5FnugzVARgz/0QdylBY5JHJnqN+9Mxg
         Qjxukhy3SdT5sg559/QSMinZsW4VJ/PHEKMG+9OP0TzecGxxLePlITIlHYGQg5ZD++zy
         guJw==
X-Gm-Message-State: AOAM532hgBUY7ZZfhlsIfffbGMLWvvHtITbX4GKvymk4gpxm0MITehfy
        XnJ8ExIZfS2EK/ME8oq1RgrmE5uhsLShXOBlCYls++/o11A2CPgK7aZA6zsP5VzqlZW00w+lziV
        aPE6IeLv5u4gM1bQjV9lsqYDY7zuPMtAARLpmjOPeX2jryGI6k0NG/2eaxldVzztUkMKkf17BTi
        NI
X-Google-Smtp-Source: ABdhPJxwOm2G+Pp92vkC3rCta3bZWSBe+ObF/iXLxxnazhWhB/hwHAQvpSeUYpm6DgYc/Wa9WYiXQ7FabawVdYkLvfYm
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6902:72d:: with SMTP id
 l13mr9661454ybt.168.1632859877588; Tue, 28 Sep 2021 13:11:17 -0700 (PDT)
Date:   Tue, 28 Sep 2021 13:10:55 -0700
In-Reply-To: <cover.1632859147.git.jonathantanmy@google.com>
Message-Id: <cef2a97840111dbdacb74f881b0790e54256d18d.1632859148.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1632242495.git.jonathantanmy@google.com> <cover.1632859147.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH v2 9/9] submodule: trace adding submodule ODB as alternate
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        newren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Submodule ODBs are never added as alternates during the execution of the
test suite, but there may be a rare interaction that the test suite does
not have coverage of. Add a trace message when this happens, so that
users who trace their commands can notice such occurrences.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 submodule.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/submodule.c b/submodule.c
index 992890321a..188552531b 100644
--- a/submodule.c
+++ b/submodule.c
@@ -207,6 +207,8 @@ int register_all_submodule_odb_as_alternates(void)
 		add_to_alternates_memory(added_submodule_odb_paths.items[i].string);
 	if (ret) {
 		string_list_clear(&added_submodule_odb_paths, 0);
+		trace2_data_intmax("submodule", the_repository,
+				   "register_all_submodule_odb_as_alternates/registered", ret);
 		if (git_env_bool("GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB", 0))
 			BUG("register_all_submodule_odb_as_alternates() called");
 	}
-- 
2.33.0.685.g46640cef36-goog

