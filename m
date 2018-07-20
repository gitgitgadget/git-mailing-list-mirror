Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5D721F597
	for <e@80x24.org>; Fri, 20 Jul 2018 19:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388231AbeGTURe (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 16:17:34 -0400
Received: from mail-oi0-f73.google.com ([209.85.218.73]:48591 "EHLO
        mail-oi0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388180AbeGTURe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 16:17:34 -0400
Received: by mail-oi0-f73.google.com with SMTP id q11-v6so10713349oih.15
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 12:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=WSG1jEeH7DsYsW54BW6vmXr1HO3XcE9DyXAlKCE7xfQ=;
        b=SF5NCwGQ50+L5F3+fDsHhizNIUpFkJrjqPTdzI8fK7IFLGk2gD1ZKKIC3zp49F+4Cd
         PSDbuchzuoz3MohH/coCcL37EYOqIVRXzpNZm48aBE5Rs4Tw+6azNO3x3dtpD8sldtFA
         0+DpewgwxvTMjeCmwb+T18ILMESchFEYidJFw8VFUQKDWDZImjgWuk1k1Y8iv/lv3Ncu
         q3H2fgrHukinD/9WI27lGFbAN/OpC7Us06qsRkR2EgzKxTSWTZnpbXew7bKtDdAtm0Zt
         biPHy+13WqynULjI4oGDxuw0evUd7vnxV7y58pV8RK5jJtdhJkWnfyPaedzP/uVgyzCM
         +9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=WSG1jEeH7DsYsW54BW6vmXr1HO3XcE9DyXAlKCE7xfQ=;
        b=HGuHHVBLhv8xIc4dr1wuslIybavekOB348OmsSEfAI65d0m79f+zLWhOTvts1lJRje
         o/uL0PPoeHfix8fsdQOjPzV2qHfc4ZEQXOZjtgqTE6ytMP326goM0zJOohhktAw9mI1/
         lkeZBq0TWXbyz77tMeTHcEvXynj4EVCMWzpfINRjaD+S9AQ9HBrrN+M8KNLOffTEwXs1
         cYeLNGDmI0MIEB1xvaiPpYcyrDW9ed/88gMOiCc9lQs9mwndw2JdVO6BVj5NoFjwPRRS
         06MpCbvyytx3t6GszPrTE2BWcVaCvFiSq9YirBxXWRZOS4t96wlMZ9A67AhKFQ3GLdXq
         i0gg==
X-Gm-Message-State: AOUpUlH/hV1qwhXos4yLz+MZlQIu/yLoaGvpNALHcBh/RGbjmMsxKbdS
        /WgN6FxzpVfje77zMdr3pgdBe7pwUK9LhDcGdVJpFC/AMT9S8GqhNjPwPUNdtBAa8LF8v1TD1Fa
        JSWcwhLNISYsmRW9Av/EItAIwC4azjB9bQ2gBNjKozKLt50E+ZpYAXKCkxQ==
X-Google-Smtp-Source: AAOMgpcSyp02yERYm0165Ofl3nZIML5m44MwO6hOmNKw4KeqnGgPE8sOCEhiGow9C2y67y+OTOCHc4dI6O8=
MIME-Version: 1.0
X-Received: by 2002:aca:e683:: with SMTP id d125-v6mr1939423oih.41.1532114873854;
 Fri, 20 Jul 2018 12:27:53 -0700 (PDT)
Date:   Fri, 20 Jul 2018 12:27:49 -0700
Message-Id: <20180720192749.224284-1-bmwill@google.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Subject: [PATCH] clone: send ref-prefixes when using protocol v2
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---

Noticed we miss out on server side filtering of refs when cloning using
protocol v2, this will enable that.

 builtin/clone.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 99e73dae85..55cc10e93a 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -895,7 +895,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	int err = 0, complete_refs_before_fetch = 1;
 	int submodule_progress;
 
-	struct refspec_item refspec;
+	struct refspec rs = REFSPEC_INIT_FETCH;
+	struct argv_array ref_prefixes = ARGV_ARRAY_INIT;
 
 	fetch_if_missing = 0;
 
@@ -1077,7 +1078,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (option_required_reference.nr || option_optional_reference.nr)
 		setup_reference();
 
-	refspec_item_init(&refspec, value.buf, REFSPEC_FETCH);
+	refspec_append(&rs, value.buf);
 
 	strbuf_reset(&value);
 
@@ -1134,10 +1135,20 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (transport->smart_options && !deepen && !filter_options.choice)
 		transport->smart_options->check_self_contained_and_connected = 1;
 
-	refs = transport_get_remote_refs(transport, NULL);
+
+	argv_array_push(&ref_prefixes, "HEAD");
+	refspec_ref_prefixes(&rs, &ref_prefixes);
+	if (option_branch) {
+		expand_ref_prefix(&ref_prefixes, option_branch);
+	}
+	if (!option_no_tags) {
+		argv_array_push(&ref_prefixes, "refs/tags/");
+	}
+
+	refs = transport_get_remote_refs(transport, &ref_prefixes);
 
 	if (refs) {
-		mapped_refs = wanted_peer_refs(refs, &refspec);
+		mapped_refs = wanted_peer_refs(refs, &rs.items[0]);
 		/*
 		 * transport_get_remote_refs() may return refs with null sha-1
 		 * in mapped_refs (see struct transport->get_refs_list
@@ -1231,6 +1242,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	strbuf_release(&value);
 	junk_mode = JUNK_LEAVE_ALL;
 
-	refspec_item_clear(&refspec);
+	refspec_clear(&rs);
+	argv_array_clear(&ref_prefixes);
 	return err;
 }
-- 
2.18.0.233.g985f88cf7e-goog

