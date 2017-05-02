Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD2A1207D6
	for <e@80x24.org>; Tue,  2 May 2017 01:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751252AbdEBBCu (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 21:02:50 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:33852 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751161AbdEBBCs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 21:02:48 -0400
Received: by mail-pg0-f48.google.com with SMTP id v1so52293951pgv.1
        for <git@vger.kernel.org>; Mon, 01 May 2017 18:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9QkIdxhM4fxfnet4fVDbcxa0U7M/M2wlzcEayrEby9s=;
        b=Zi9sQmpuKX4cksWNhxHIlHp9DuA9hL/M2kdKAE2CtpQlWunkKC+7UgzJaCvetyXFw1
         6P4uQaDgCaFVqeTpSRWpyUA2hmSXkKA6+ZoxvYyA9V1ch92IXFarQ2h3b3LXvaa4B8zs
         2Dgvbl4VEU38GoT9p8dMfehOdss0g+IUSMkq4rouq2oR1IuoNomhKTH4Ztz9RgU/su5k
         J0ijLyBbOG0u+Of2Xa2vhiIuKT9CIcGeyWTjk7pkgEbvjC0C6JNa+KlVEE6IatyO9a+e
         YXzfoCJymvU1trcUKHKZjCnLN143wUaF9coveU8nDZF8X0TCPyy4o/OSEBgXVBZ3M3lL
         GfWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9QkIdxhM4fxfnet4fVDbcxa0U7M/M2wlzcEayrEby9s=;
        b=Q/JcTSLIaLVMAy/yvCo8a6R878FFOU/RmUirmU5OWovtZ1i4hoVDDaG0bHOJ3rMel7
         HyedzFbOoW0jx6ZWZSCjhmd4c/OMSlgiYaND+qWCpLvKTEl10P17XUuerEvsoAU1iNRL
         KH2Kibw8HFGhyMibG0u/i8y3tWCrG3EBsdU8hRVn/OQhogU8IlAnQjWXegPS1iOWCJmI
         FA2zZdmWn8erwi2lw/+TYq0sj+J1LwZnDDp7c3mR5eb+HUXfExl/hDWxSp/EVSG2kXv2
         bPBT3rI6fmC0LFMlz9Vkwks1bDxv7VG9asOfzFYVC6cymcEvGQfVsJ9nToOkk93fL2++
         QhBg==
X-Gm-Message-State: AN3rC/4jHyqvYOl1JJrz9wa6I6wltShZI1m4H7WNRyz+CMquYc0hiaNt
        E+dy6CHoqc2JBWZb
X-Received: by 10.99.23.67 with SMTP id 3mr23985965pgx.4.1493686967794;
        Mon, 01 May 2017 18:02:47 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id d1sm13532526pfa.56.2017.05.01.18.02.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 May 2017 18:02:46 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, gitster@pobox.com,
        sbeller@google.com
Subject: [PATCH v2 2/6] submodule: rename free_submodules_sha1s
Date:   Mon,  1 May 2017 18:02:35 -0700
Message-Id: <20170502010239.179369-3-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.rc1.294.g07d810a77f-goog
In-Reply-To: <20170502010239.179369-1-bmwill@google.com>
References: <20170428235402.162251-1-bmwill@google.com>
 <20170502010239.179369-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename 'free_submodules_sha1s()' to 'free_submodules_oids()' since the
function frees a 'struct string_list' which has a 'struct oid_array'
stored in the 'util' field.

Change-Id: I0c52fa3af1b1492b196bcf52f8b8cc8f5daf085d
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 submodule.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/submodule.c b/submodule.c
index be0f5d847..46abd52b1 100644
--- a/submodule.c
+++ b/submodule.c
@@ -738,7 +738,7 @@ static void find_unpushed_submodule_commits(struct commit *commit,
 	diff_tree_combined_merge(commit, 1, &rev);
 }
 
-static void free_submodules_sha1s(struct string_list *submodules)
+static void free_submodules_oids(struct string_list *submodules)
 {
 	struct string_list_item *item;
 	for_each_string_list_item(item, submodules)
@@ -779,7 +779,8 @@ int find_unpushed_submodules(struct oid_array *commits,
 		if (submodule_needs_pushing(submodule->string, commits))
 			string_list_insert(needs_pushing, submodule->string);
 	}
-	free_submodules_sha1s(&submodules);
+
+	free_submodules_oids(&submodules);
 
 	return needs_pushing->nr;
 }
-- 
2.13.0.rc1.294.g07d810a77f-goog

