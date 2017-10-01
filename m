Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD66720A10
	for <e@80x24.org>; Sun,  1 Oct 2017 17:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751460AbdJARmW (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 13:42:22 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36099 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751355AbdJARmV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 13:42:21 -0400
Received: by mail-wr0-f196.google.com with SMTP id k10so2406729wrk.3
        for <git@vger.kernel.org>; Sun, 01 Oct 2017 10:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NziQrcYl1hRq+5VIwQgAW5Mov3mg3XQunerunwEj0oU=;
        b=eah+G/1c60KIihqam0Hr01gffsEFK1tpCauGcEbN0HAmtlSkQLn+PWet5fGtwkvKDS
         h/zc8GXHdG9Se5UTNr/U6jEsxlg21lZwWlmg83Wf71GFFjyWU80YYMHffcFGfpSP6LmG
         x4u+rCMPsgZqaP/VvGRG31XClBCx+e3fbr6hoBXZyd1hkkKVN36uWpCfvAvPYZhnu7tt
         vlCsU7XrDjVwvcW/drZaXyLWlENcYbNWm/Ibx3OwOxMzp21GZ/F+G25tgv5fUFAmFsxC
         3HX/zIjOOvA3+UhS5vcvoZn8buM+SiXSMSCKJ+JGqAQCduylhbWorSpA/kwOKKhrF22Z
         T+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NziQrcYl1hRq+5VIwQgAW5Mov3mg3XQunerunwEj0oU=;
        b=EOKs7Z8GBgI7Nm/icIHPAsPX6DGWk3fSZBqaCu6sEth2POOhLgS/X97NTEDRdSswSm
         B53EIRRG7Qn7ncTjAdfSxniY+d/f0w5weSG+UEhS294VrXQmqX1jH6+Hku7OmTZaJEPr
         6Nf+tmLemur3V8WzzsBqmrwpjocHtaXplzkFLC2XGagsFQ6lnpBkpWMroqGeESo12ZG+
         s7rANvnLCLJWTq7vd/hKcxW5ikjjYHI6haolz7pG44h9jBvj++p/ysMLAxm5HJfBbJX7
         czqfMxi8IuyH3ZHdUT93qmWpAYcLaUNhLkc6QoC3RIbhscjU6Bmi3JcUZ5w7AbZxd84H
         iKkA==
X-Gm-Message-State: AHPjjUgaZSpwvDZiW9L3s2IurfTO7gFxNyzHWNOKi7mDWCwESqFVQfoQ
        pC2OfAMoGeJvjaXDyZ3lfnoTECzr
X-Google-Smtp-Source: AOwi7QAwuWvuXRBCYH86ughkYSJJ4J3yeGG6/h6m8YszUiB7V0hEnwKEYL3tfizc/8aiPkXNJidItw==
X-Received: by 10.223.146.37 with SMTP id 34mr7792451wrj.79.1506879740018;
        Sun, 01 Oct 2017 10:42:20 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id l80sm2949949wrc.21.2017.10.01.10.42.18
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Oct 2017 10:42:19 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH] builtin/: add UNLEAKs
Date:   Sun,  1 Oct 2017 19:42:08 +0200
Message-Id: <20171001174208.1693753-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.2.666.gea220ee40
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add some UNLEAKs where we are about to return from `cmd_*`. UNLEAK the
variables in the same order as we've declared them. While addressing
`msg` in builtin/tag.c, convert the existing `strbuf_release()` calls as
well.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 builtin/checkout.c   | 1 +
 builtin/diff-index.c | 1 +
 builtin/diff.c       | 3 +++
 builtin/name-rev.c   | 1 +
 builtin/tag.c        | 9 +++++----
 5 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 3345a0d16..2daa4412a 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1298,6 +1298,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		strbuf_release(&buf);
 	}
 
+	UNLEAK(opts);
 	if (opts.patch_mode || opts.pathspec.nr)
 		return checkout_paths(&opts, new.name);
 	else
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index 9d772f8f2..522f4fdff 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -56,5 +56,6 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 		return -1;
 	}
 	result = run_diff_index(&rev, cached);
+	UNLEAK(rev);
 	return diff_result_code(&rev.diffopt, result);
 }
diff --git a/builtin/diff.c b/builtin/diff.c
index 7e3ebcea3..f5bbd4d75 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -464,5 +464,8 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	result = diff_result_code(&rev.diffopt, result);
 	if (1 < rev.diffopt.skip_stat_unmatch)
 		refresh_index_quietly();
+	UNLEAK(rev);
+	UNLEAK(ent);
+	UNLEAK(blob);
 	return result;
 }
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 598da6c8b..9e088ebd1 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -494,5 +494,6 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 				  always, allow_undefined, data.name_only);
 	}
 
+	UNLEAK(revs);
 	return 0;
 }
diff --git a/builtin/tag.c b/builtin/tag.c
index c62779418..34efba579 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -552,9 +552,10 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	if (force && !is_null_oid(&prev) && oidcmp(&prev, &object))
 		printf(_("Updated tag '%s' (was %s)\n"), tag, find_unique_abbrev(prev.hash, DEFAULT_ABBREV));
 
-	strbuf_release(&err);
-	strbuf_release(&buf);
-	strbuf_release(&ref);
-	strbuf_release(&reflog_msg);
+	UNLEAK(buf);
+	UNLEAK(ref);
+	UNLEAK(reflog_msg);
+	UNLEAK(msg);
+	UNLEAK(err);
 	return 0;
 }
-- 
2.14.2.666.gea220ee40

