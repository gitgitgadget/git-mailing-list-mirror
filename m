Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9695BC4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 21:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A57A60F39
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 21:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbhHPVKm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 17:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbhHPVKl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 17:10:41 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C78BC0617AD
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 14:10:08 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v130-20020a25c5880000b0290593c8c353ffso18145307ybe.7
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 14:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+Vu0e8HWyExKevJfKr8agDTmd134b1/87ePU0sCd1Qw=;
        b=IiUWQHm/OaiGeRoI2AGHfciFP6qlzmt0NXmbsIoTjCD3DdqotFwd9ED2L22fLfxleB
         35YftMnni2JNJ9efJM11dmI1JFPGkcju4BlozYIqdP1XVeYjchuaHuhpPTDq3M8Hw11J
         EwkCooRhEZjD96OHbUD64oNRuBkj3pLNtmBKoy6UiOjdOrhHpVrS+jRa315SpBjTphM1
         rUZsBUkF5OEiDxmXwpLFa5YQSDNiBPGQ3R3+NtgeOe0F1S8qSdupGnN57VxlY3Lwkxo5
         oFD+6lBBPo+RgPCfjuTBTLX7dlfSvwhhgOJ6o2XPn2i8iNDP60EYFfaueMSBZKeUmBrC
         NE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+Vu0e8HWyExKevJfKr8agDTmd134b1/87ePU0sCd1Qw=;
        b=R05DDCYp4ggJ+M3L54hUV2P56588duVF0TMTPS9VR+Rg+VicoZ9wDJ/hk898gKPurP
         IT95y5nW0nA+XBBZ0nXJznqKBXhYcuv9QDDjn2SB31mIehgxo9DLpIWfORlrJSXWfnVE
         9KLdE8WAJkY2wwIWdl5hl20ePSHoW0iihUOAHv0v+zkJXXytqHPxJQOylp8mcUbqRGKT
         Z9+2cSDSuvsWTZ/nIFASlNjAoSkpwbvKVTlQngRTTn6bqMG/lSP2Puh/t3fZexd7Hups
         DoPHj6vgc0Xph6lVypdOBAClsgdrExAjv9oIWdV95EvsBztbbRczkKtp2vj5dwtxFNsr
         o5lA==
X-Gm-Message-State: AOAM531d9QEYXSX3FdwXKpCqbTvK2XV1pvXdVbSJYviovEaWWNvK6vIT
        ssTlldk/npLwFfgnflTsJEztyssid7vqOt8AvalvBO9VUYvYjhcJnTJgLUdJMmdG9knSYC5w3nB
        e32paElpv+O3Ikr6C9HEikCCtLv/svn5Oz8NePPcSCSCHEkadJfaYhFmHcBiMo6EoxTaJPYZaqH
        Y7
X-Google-Smtp-Source: ABdhPJz0ewmPCwOEZxoDN257Th/ZYmZCOkYFKL1Yg1OY0LdQa1MzxGE5gNP9VgPAWNKL+/JprVBJDv73LFhbJ0D2VXwg
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:bb93:: with SMTP id
 y19mr24245ybg.266.1629148207787; Mon, 16 Aug 2021 14:10:07 -0700 (PDT)
Date:   Mon, 16 Aug 2021 14:09:54 -0700
In-Reply-To: <cover.1629148153.git.jonathantanmy@google.com>
Message-Id: <050deacfb7df41192b57ac42c5ea8fb646106d78.1629148153.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1628618950.git.jonathantanmy@google.com> <cover.1629148153.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH v3 4/8] grep: read submodule entry with explicit repo
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, matheus.bernardino@usp.br,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace an existing parse_object_or_die() call (which implicitly works
on the_repository) with a function call that allows a repository to be
passed in. There is no such direct equivalent to parse_object_or_die(),
but we only need the type of the object, so replace with
oid_object_info().

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/grep.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index e454335e9d..9e61c7c993 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -457,27 +457,27 @@ static int grep_submodule(struct grep_opt *opt,
 	subopt.repo = &subrepo;
 
 	if (oid) {
-		struct object *object;
+		enum object_type object_type;
 		struct tree_desc tree;
 		void *data;
 		unsigned long size;
 		struct strbuf base = STRBUF_INIT;
 
 		obj_read_lock();
-		object = parse_object_or_die(oid, NULL);
+		object_type = oid_object_info(&subrepo, oid, NULL);
 		obj_read_unlock();
 		data = read_object_with_reference(&subrepo,
-						  &object->oid, tree_type,
+						  oid, tree_type,
 						  &size, NULL);
 		if (!data)
-			die(_("unable to read tree (%s)"), oid_to_hex(&object->oid));
+			die(_("unable to read tree (%s)"), oid_to_hex(oid));
 
 		strbuf_addstr(&base, filename);
 		strbuf_addch(&base, '/');
 
 		init_tree_desc(&tree, data, size);
 		hit = grep_tree(&subopt, pathspec, &tree, &base, base.len,
-				object->type == OBJ_COMMIT);
+				object_type == OBJ_COMMIT);
 		strbuf_release(&base);
 		free(data);
 	} else {
-- 
2.33.0.rc1.237.g0d66db33f3-goog

