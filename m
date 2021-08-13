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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F259C4320A
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 21:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B4166109E
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 21:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234783AbhHMVGH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 17:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234786AbhHMVGD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 17:06:03 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E572C061292
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 14:05:34 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id ns7-20020a17090b250700b0017942fa12a8so1962482pjb.6
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 14:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+Vu0e8HWyExKevJfKr8agDTmd134b1/87ePU0sCd1Qw=;
        b=XZb+OsImuybpKm+UjeFKO92o2wQpy91wskvDscWNirx3yquBXdROIRtqpegmMpqQ6n
         6vpcSF1AuNP5v+xbMbFjleijewArHsHMyPGgQK/fiIrXQW0Gqoivy0I9fPQWbktxvX+S
         ysjx5KKK9zklElr4n0ziKnn0K+VIDN4ys68V3i52KASC1fOSeMXGpcLKaAU0OGc/fPhu
         XO9hURo2td062iJGX4mOOYoK5Kw1M1XFsIBtuIdvMzBqAaZQQDNEb2nAToFLeUwdvp5h
         +jXyHq8zib7hNJGg7LGQLpw7HZUYo7/QGy6/Ro0EqfAccDj/d2p/zRTSU8MeRHtCorEj
         ZIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+Vu0e8HWyExKevJfKr8agDTmd134b1/87ePU0sCd1Qw=;
        b=AK6sGyQO3lRHOuU03F2mNsclypjxYsqSbJ7pz3CGIB4nTz9+vHHyEmTsv73Bd7W5/X
         MWigPxWaKKd4OpNotUA7ehflwwN49TJy04FI/iX3JzyWQOroLi9a7ecQPJuPPb6Ogs3z
         jgQd4lVS734iWHBFtAFykC4EZfNGKqTkzEuc8Izlg6uzfsXlIymIfL7zSBYo2sMO0xTC
         6JEZCNkFZ13ANIlNVZGCK6d0s/Ka3pc8yUCNeZJ/9hwunSJ4gctaIdGycqmVqEyr7k6d
         E9JOf6+nNGmXRUdaDCYJdmxON9Kf7TLRpTZimhBOSYo1F0B46eJmB70G/7Exvz0WLw6i
         O7ww==
X-Gm-Message-State: AOAM530lYxupC/gC0xqag/dbAI1YWsOyuALmIeaOLWBlMaB4xA0oEDFP
        3IAt3RrrmIlHEWfbpKxsHF5lF3KmSCfg1xdZZetv0nyRf0j5B4Q3OcYLlUAN9Bs5BYxEZYvf3o6
        QjT9DJEKx92yuVAC+MkoQeAyL1i4JP83ODfxd6BXhsvezbAFILG4O91fG0n+sNAbyxO38k0IMaD
        OB
X-Google-Smtp-Source: ABdhPJz4QK3dqagfQu8HGrTTQpUjgvEmpHgRP8ttHUiubhMGWHZYYKsZgOXEOkO+PD/AHwDJlzqIGHIdtPy8ifpzlbQ7
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a62:8491:0:b029:3dd:a29a:a1e4 with
 SMTP id k139-20020a6284910000b02903dda29aa1e4mr4224677pfd.13.1628888733819;
 Fri, 13 Aug 2021 14:05:33 -0700 (PDT)
Date:   Fri, 13 Aug 2021 14:05:19 -0700
In-Reply-To: <cover.1628888668.git.jonathantanmy@google.com>
Message-Id: <050deacfb7df41192b57ac42c5ea8fb646106d78.1628888668.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1628618950.git.jonathantanmy@google.com> <cover.1628888668.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH v2 4/8] grep: read submodule entry with explicit repo
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, matheus.bernardino@usp.br,
        emilyshaffer@google.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, steadmon@google.com
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

