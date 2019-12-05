Return-Path: <SRS0=7IA6=Z3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF178C2D0BF
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 23:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84AA72173E
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 23:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJyc/+zv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbfLEX6E (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Dec 2019 18:58:04 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45590 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfLEX6D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Dec 2019 18:58:03 -0500
Received: by mail-qk1-f195.google.com with SMTP id x1so4929903qkl.12
        for <git@vger.kernel.org>; Thu, 05 Dec 2019 15:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EG5GDGPbJQIgNAaxanxcuYuUP1bSVRhCTaW1ioomEfo=;
        b=hJyc/+zvF7HsnOnHPkL/fVVkNepj8DE5EyoI2wn+dXxBNAm+JxoOoTLtUVK40aySRe
         okOkeK8ZTaEsj51oYn3P/Bn8KVTHXMQ8a3iVD306FRurYHxBEFGvnMMAbSXbYrpHITfN
         Gwqj5TpG8cNAYnLgvgvUSeH+mqyp7loeqiNwHO+4Gze6xlVbMOs3F/tW0nDOXvdV0h4k
         COnD9wqUJkzoq23x8Rp63HsndhcMrQsIkBkS2e+j9wzHv/ZNYytGPWJ5dAWSquGy2mIf
         /N069xUH7H74hpZN2OfvNDLWs253ABpvCwgnBJaLIT22TJnt7Hza58fc6whYRhJToD6/
         G6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EG5GDGPbJQIgNAaxanxcuYuUP1bSVRhCTaW1ioomEfo=;
        b=uRV65xTt+/XHgarXSSI99JCWk/Y+FUfhvSgs092xmtUXqeT7YVZ+TjHSOH7QGqgV1g
         5kTyhcKrbkp/qF2JfU0mgri6qXBkE2Co+oSdjZZkxUqwYuUQyytuxNlfyJnww6EuTCLr
         UOAJw5hN824mdNBGyvrqtBSKOgZzI8M9EwKNMEvqrKhhIlF+DHVzwoF1HGjNcMYvsD3F
         20x9vMdtp7xMXOirpPgz4ZyCEjwCAu7LhkuP2Nc0pVo5NVyqsLMZsMGtZQiu9UMznN6t
         tmCJ7yIzWdXLQrq6tZ4cUtCg1veOdjdaFW+6DOQ5b9lh4bMLMfIy1cjc/kxHE4a2L2fd
         R2OA==
X-Gm-Message-State: APjAAAXz3AynXPHIhq4Syk4UAIYP+w+xHTsKhjDN+DXijylvXMYluKXb
        G+ERyo1i9FG51oURbidXIRD/lQ9ny48=
X-Google-Smtp-Source: APXvYqw7q3IX4O6blKX8Mhq6sgXS5qlJGEwfNTnEY1H300rMMAr1o0jgZfNqhVs2XtSv91DkhmqU5Q==
X-Received: by 2002:a37:b601:: with SMTP id g1mr11306351qkf.114.1575590282136;
        Thu, 05 Dec 2019 15:58:02 -0800 (PST)
Received: from alex-torok-7530.int.uberatc.com ([216.99.208.249])
        by smtp.googlemail.com with ESMTPSA id q34sm4641975qtc.33.2019.12.05.15.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 15:58:01 -0800 (PST)
From:   Alex Torok <alext9@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Torok <alext9@gmail.com>
Subject: [PATCH v2 2/2] rebase: find --fork-point with full ref
Date:   Thu,  5 Dec 2019 18:57:04 -0500
Message-Id: <20191205235704.31385-3-alext9@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191205235704.31385-1-alext9@gmail.com>
References: <20191205225322.5529-1-alext9@gmail.com>
 <20191205235704.31385-1-alext9@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

rebase --fork-point needs to look up the full ref name before calling
get_fork_point in the same manner that merge-base --fork-point does.

Signed-off-by: Alex Torok <alext9@gmail.com>
---
 builtin/rebase.c             | 4 +++-
 t/t3431-rebase-fork-point.sh | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index e755087b0f..821994f676 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1980,8 +1980,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		struct commit *head =
 			lookup_commit_reference(the_repository,
 						&options.orig_head);
+		char * full_name;
+		dwim_ref_or_die(options.upstream_name, strlen(options.upstream_name), &full_name);
 		options.restrict_revision =
-			get_fork_point(options.upstream_name, head);
+			get_fork_point(full_name, head);
 	}
 
 	if (repo_read_index(the_repository) < 0)
diff --git a/t/t3431-rebase-fork-point.sh b/t/t3431-rebase-fork-point.sh
index 78851b9a2a..6ecdae918e 100755
--- a/t/t3431-rebase-fork-point.sh
+++ b/t/t3431-rebase-fork-point.sh
@@ -49,6 +49,7 @@ test_rebase 'G F C D B A' --no-fork-point --onto D
 test_rebase 'G F C B A' --no-fork-point --keep-base
 test_rebase 'G F E D B A' --fork-point refs/heads/master
 test_rebase 'G F D B A' --fork-point --onto D refs/heads/master
+test_rebase 'G F D B A' --fork-point --onto D master
 test_rebase 'G F B A' --fork-point --keep-base refs/heads/master
 test_rebase 'G F C E D B A' refs/heads/master
 test_rebase 'G F C D B A' --onto D refs/heads/master
-- 
2.17.1

