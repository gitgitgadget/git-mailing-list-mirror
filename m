Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 927921F597
	for <e@80x24.org>; Fri, 20 Jul 2018 22:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbeGTW6L (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 18:58:11 -0400
Received: from mail-qk0-f202.google.com ([209.85.220.202]:56166 "EHLO
        mail-qk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727671AbeGTW6K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 18:58:10 -0400
Received: by mail-qk0-f202.google.com with SMTP id z18-v6so10287730qki.22
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 15:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=6cCWDjzEcKNfQLk7xKm+Te2DfVy/0Awf33ETtIfiCqc=;
        b=hoEdNwXB4pkeDFF0HrV+Wg6kovHTspSbWxGjmIA3n+Ps/LyfhTuJbcjb6NwtXoq6cb
         l4OoM5PqYxBaZZHZcoF0WT3Dl/HC/dk/M0v0Kb+UqSXuWXFJkG4k4qvGyuFMeUTE6zHl
         IfgTbJyR/JEsY5YerOOrtco06NAr5QDhR558JGnWUMjMfV1vaWXEkUsrcQuJnHWyaKpr
         Zkjj7HzHu/LTlRo/ZwrZnNmfI41WWUNxrhT8eCOF0e+B6ymyelmcyqnj1XS0xf1p0En2
         p5GPtLbKILq5GwJtv3J3HO3NG2IqMYX+7vdb5x23pUo/kviuFjchHbHbzf9EKtSWeE6o
         OkUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=6cCWDjzEcKNfQLk7xKm+Te2DfVy/0Awf33ETtIfiCqc=;
        b=TR3Y2r0CxNdA+dcv0cCY6bY06GwlVEIWeYLqBmMD9Oi/zKA74KlMyvIZVCOsAz2GJX
         klByPlO2YbsF2HF7tT+Z1Fd3Dg2I5o5BGZu/i6T061pILIO6x5Rz+oArc3uRUsEstbJG
         EiK1e+Z0JfrdSsT3+5YYdu2MwgCWStyBq6TgUR+Yr6+qqMeDM0yOKD0aQcAmgziIi1P+
         J3ILNL6iqLZf9i6H+f/Vetn83ICuuhHxILPUrFee40QngpL6IJFgMa7JyCyljEe7BzX6
         9KRebcfJ1lqsRV9yBzSoJGF0ulFL+ayGS/kxLPklDRHED9q8d/8DAmu0wgtqUW1mbcBI
         CR5A==
X-Gm-Message-State: AOUpUlH4H5P5gvlRmNUBfsVt24ilhajCV+badv+o0nwRZ695W0eIAw1e
        hFa0pDGCMIzROETy78zbN5OOjk80i9LeS89R7jMwWE42VF3+WjC4hyo1vMQSz3TMG29oYGjQ0zE
        k5SLFSvZGbmccCZRbNAl4jOtY7x3WIJxlpVoZ0NXicsXiN0QjjdmWhvltig==
X-Google-Smtp-Source: AAOMgpcy0BabUpCETxzsHy2hdUf6H4h/rHqIvBPO7ESDsUx3BuyiDKwgQKbyGj36GUEahGr+21sDF5i+sC8=
MIME-Version: 1.0
X-Received: by 2002:ae9:c004:: with SMTP id u4-v6mr2020981qkk.40.1532124477894;
 Fri, 20 Jul 2018 15:07:57 -0700 (PDT)
Date:   Fri, 20 Jul 2018 15:07:54 -0700
In-Reply-To: <20180720192749.224284-1-bmwill@google.com>
Message-Id: <20180720220754.257158-1-bmwill@google.com>
References: <20180720192749.224284-1-bmwill@google.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Subject: [PATCH v2] clone: send ref-prefixes when using protocol v2
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach clone to send a list of ref-prefixes, when using protocol v2, to
allow the server to filter out irrelevant references from the
ref-advertisement.  This reduces wasted time and bandwidth when cloning
repositories with a larger number of references.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/clone.c        | 20 +++++++++++++++-----
 t/t5702-protocol-v2.sh |  7 ++++++-
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 99e73dae85..5c0adbd6d0 100644
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
 
@@ -1134,10 +1135,18 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (transport->smart_options && !deepen && !filter_options.choice)
 		transport->smart_options->check_self_contained_and_connected = 1;
 
-	refs = transport_get_remote_refs(transport, NULL);
+
+	argv_array_push(&ref_prefixes, "HEAD");
+	refspec_ref_prefixes(&rs, &ref_prefixes);
+	if (option_branch)
+		expand_ref_prefix(&ref_prefixes, option_branch);
+	if (!option_no_tags)
+		argv_array_push(&ref_prefixes, "refs/tags/");
+
+	refs = transport_get_remote_refs(transport, &ref_prefixes);
 
 	if (refs) {
-		mapped_refs = wanted_peer_refs(refs, &refspec);
+		mapped_refs = wanted_peer_refs(refs, &rs.items[0]);
 		/*
 		 * transport_get_remote_refs() may return refs with null sha-1
 		 * in mapped_refs (see struct transport->get_refs_list
@@ -1231,6 +1240,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	strbuf_release(&value);
 	junk_mode = JUNK_LEAVE_ALL;
 
-	refspec_item_clear(&refspec);
+	refspec_clear(&rs);
+	argv_array_clear(&ref_prefixes);
 	return err;
 }
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index a4fe6508bd..9c6ea04a69 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -181,7 +181,12 @@ test_expect_success 'clone with file:// using protocol v2' '
 	test_cmp expect actual &&
 
 	# Server responded using protocol v2
-	grep "clone< version 2" log
+	grep "clone< version 2" log &&
+	
+	# Client sent ref-prefixes to filter the ref-advertisement 
+	grep "ref-prefix HEAD" log &&
+	grep "ref-prefix refs/heads/" log &&
+	grep "ref-prefix refs/tags/" log
 '
 
 test_expect_success 'fetch with file:// using protocol v2' '
-- 
2.18.0.233.g985f88cf7e-goog

