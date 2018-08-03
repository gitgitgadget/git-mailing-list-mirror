Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA2F41F597
	for <e@80x24.org>; Fri,  3 Aug 2018 22:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732111AbeHDAWZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 20:22:25 -0400
Received: from mail-ua0-f201.google.com ([209.85.217.201]:45487 "EHLO
        mail-ua0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731816AbeHDAWY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 20:22:24 -0400
Received: by mail-ua0-f201.google.com with SMTP id x17-v6so3613520uap.12
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 15:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=maR0KUSznaJU/LpOI5iuSUOYnwqVZhNDK4RVx8ah9Fw=;
        b=cXg8P+sWfD0UYxgXtJ5EtUROfRt3OxOZZ20A7TVJE14iAU98gs0Ud14+0/INh0joyB
         tt5U089VTvj5j6vpcHJjXIEHp08H3t5VLaXokCT3qf4dlBeaymIimNUVx4groD4jnXmf
         6mq92VJLBCZxeKu4ELMF9xlluwYvgNVNk9r7roDvH/wMQXwylygvKspW7RA4pJ8xDP8d
         P/7UL0ryO4SKJfDA/kppu/wNgql7Sf6OSGkRHXUpZWaDfL1qkNX5Uq/T7E91bJ01RG8P
         e6uncPWD2lXXLr7GNRQ8ScFaortkQSjdvodNiWJvBMlFuS2sCLMzZRAa+0q1kKQ85caZ
         Ohvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=maR0KUSznaJU/LpOI5iuSUOYnwqVZhNDK4RVx8ah9Fw=;
        b=gg42ghx5Ca+b9TsfDNJemEIBZls3aJUwyAeHP05wSixHodrASBqmZi0yVhb2oD9uQ0
         8toHL71ouSOkYhJPzjjIjveo9Qfhxz3GoZcTbQxWtZ8cTIwRireaQs+LNJ7yLd/rLxs0
         LM2VXTT38FNf6sMnzoq+E33HhvE92aoFdJThFWjcbDS0M+qsc3s2Yt3xx5qPGcd2mNKF
         7aLePb1cnlNSx1L5uiFfRqy7r1JIp/l7CPfouYrbDCqoZ4EaI+hx8Xcqo25/0gJngRSZ
         vxoBqn4Xo3AeoHL7BK3xn3KdXP8IGeXwulxYrzAwjM9xqBQ2oGsHGJymOHpdrzPZ3EA+
         ajpQ==
X-Gm-Message-State: AOUpUlG7kCHnrSZA4116Mbnwr4Mif7F8Kpyd27H2A9FSvBgUwUngK8TG
        rnU5KzkKpGHdUhHcAcf/7mNDGKlE51GINXP80vuYjmrNjJ1fay5qhtu0JWmEbTEvqCaSQpsGVRe
        E2URUWvT4HIOvJUWS2Gvw2SoRZF9a8A4m8KjOF4jhYZD36naPwviMH6ROD7pY
X-Google-Smtp-Source: AAOMgpd+QUkBHqO4XNiyqGk1EnNDglU4QHJX/7aYzbTk2Rb6aow/bzK1vP4uxONbnvrIW7XbGY0zYfTesYai
MIME-Version: 1.0
X-Received: by 2002:a1f:a0d7:: with SMTP id j206-v6mr4554729vke.123.1533335051451;
 Fri, 03 Aug 2018 15:24:11 -0700 (PDT)
Date:   Fri,  3 Aug 2018 15:23:19 -0700
In-Reply-To: <20180803222322.261813-1-sbeller@google.com>
Message-Id: <20180803222322.261813-5-sbeller@google.com>
References: <20180803222322.261813-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.132.g195c49a2227
Subject: [PATCH 4/7] builtin/submodule--helper: store update_clone information
 in a struct
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The information that is printed for update_submodules in
'submodule--helper update-clone' and consumed by 'git submodule update'
is stored as a string per submodule. This made sense at the time of
48308681b07 (git submodule update: have a dedicated helper for cloning,
2016-02-29), but as we want to migrate the rest of the submodule update
into C, we're better off having access to the raw information in a helper
struct.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/submodule--helper.c | 37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 32f00ca6f87..40b94dd622e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1446,6 +1446,12 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+struct update_clone_data {
+	const struct submodule *sub;
+	struct object_id oid;
+	unsigned just_cloned;
+};
+
 struct submodule_update_clone {
 	/* index into 'list', the list of submodules to look into for cloning */
 	int current;
@@ -1465,8 +1471,9 @@ struct submodule_update_clone {
 	const char *recursive_prefix;
 	const char *prefix;
 
-	/* Machine-readable status lines to be consumed by git-submodule.sh */
-	struct string_list projectlines;
+	/* to be consumed by git-submodule.sh */
+	struct update_clone_data *update_clone;
+	int update_clone_nr; int update_clone_alloc;
 
 	/* If we want to stop as fast as possible and return an error */
 	unsigned quickstop : 1;
@@ -1480,7 +1487,7 @@ struct submodule_update_clone {
 #define SUBMODULE_UPDATE_CLONE_INIT {0, MODULE_LIST_INIT, 0, \
 	SUBMODULE_UPDATE_STRATEGY_INIT, 0, 0, -1, STRING_LIST_INIT_DUP, 0, \
 	NULL, NULL, NULL, \
-	STRING_LIST_INIT_DUP, 0, NULL, 0, 0}
+	NULL, 0, 0, 0, NULL, 0, 0, 0}
 
 
 static void next_submodule_warn_missing(struct submodule_update_clone *suc,
@@ -1574,10 +1581,12 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	strbuf_addf(&sb, "%s/.git", ce->name);
 	needs_cloning = !file_exists(sb.buf);
 
-	strbuf_reset(&sb);
-	strbuf_addf(&sb, "dummy %s %d\t%s\n",
-		    oid_to_hex(&ce->oid), needs_cloning, ce->name);
-	string_list_append(&suc->projectlines, sb.buf);
+	ALLOC_GROW(suc->update_clone, suc->update_clone_nr + 1,
+		   suc->update_clone_alloc);
+	oidcpy(&suc->update_clone[suc->update_clone_nr].oid, &ce->oid);
+	suc->update_clone[suc->update_clone_nr].just_cloned = needs_cloning;
+	suc->update_clone[suc->update_clone_nr].sub = sub;
+	suc->update_clone_nr++;
 
 	if (!needs_cloning)
 		goto cleanup;
@@ -1720,7 +1729,8 @@ static int git_update_clone_config(const char *var, const char *value,
 
 static int update_submodules(struct submodule_update_clone *suc)
 {
-	struct string_list_item *item;
+	int i;
+	struct strbuf sb = STRBUF_INIT;
 
 	run_processes_parallel(suc->max_jobs,
 			       update_clone_get_next_task,
@@ -1739,9 +1749,16 @@ static int update_submodules(struct submodule_update_clone *suc)
 	if (suc->quickstop)
 		return 1;
 
-	for_each_string_list_item(item, &suc->projectlines)
-		fprintf(stdout, "%s", item->string);
+	for (i = 0; i < suc->update_clone_nr; i++) {
+		strbuf_addf(&sb, "dummy %s %d\t%s\n",
+			oid_to_hex(&suc->update_clone[i].oid),
+			suc->update_clone[i].just_cloned,
+			suc->update_clone[i].sub->path);
+		fprintf(stdout, "%s", sb.buf);
+		strbuf_reset(&sb);
+	}
 
+	strbuf_release(&sb);
 	return 0;
 }
 
-- 
2.18.0.132.g195c49a2227

