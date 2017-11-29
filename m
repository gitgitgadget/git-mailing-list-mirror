Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 531D220A40
	for <e@80x24.org>; Wed, 29 Nov 2017 20:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752150AbdK2UMM (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 15:12:12 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:45314 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751960AbdK2UML (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 15:12:11 -0500
Received: by mail-io0-f194.google.com with SMTP id e204so5008750iof.12
        for <git@vger.kernel.org>; Wed, 29 Nov 2017 12:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YFd3Vp5rAEhdKg2CmKwIu98zcODxNk70s0e+dmEy6Zo=;
        b=qdzXbXNTTy/9Ge2sAPCHh4zKdPS5BFDjAP+lkG/xzB11Qfemyv9dnFrFdTE5cUjC1u
         xGqb+Q7eYMOV2d2rIhZUou7FwUfGodt48MiftDS9epe1WsuayORcpOtY/CgpQLgtCM2X
         VVreK+spj1yGXEuzV/iLkOwcPswfAl01Lu3mbSEg0mcBlF3Jx3vesc064XSHZlNUumEb
         /TPsP8TucoTLSsQEtA45FS1J39xcZriDOOntZDEVTh9n+fRjN5CebnKph/W815LtOx63
         2Ecl1G/hBatP7pJcB9rgh5VuybQStIJmRpWNRnjjJhZWi73mtkSAQ07dHXr6t5W1Nzgm
         Nd/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YFd3Vp5rAEhdKg2CmKwIu98zcODxNk70s0e+dmEy6Zo=;
        b=L8oIfexzEw8JGrl5FlAVXmVnThpOPHr2bEtQC1S/wTtujmJ9d3vjJBUbIXSv9OdvrV
         Gd+8TF7L0Jpj5LKaenJKaMJcFdPtVdNHvSQ5wkifsGlUStovJtDho0MzweK1KfrEtRY6
         rUdCLahw1vA8+UyUbCx5mkFhAYrbD16bEQvmvT4z0l26WyaUv95tBhWC0n+SBvCwLd+V
         uDaCmkAWoCE7cvqjimTIwVztzLisQ33ygb9zUeBT7/HJheoyjAtG6JxNlhHPjLlC9dAE
         pl/3I6GL1TWRKgYXihPpzyN/smkHKBpuYnw58xV8YEdnUYED1fIeXoBJUbB3tJauFk82
         XtRw==
X-Gm-Message-State: AJaThX77ws2nZE+OzAxYRN/okNWh/iuMra7py8CiS39KmdOqcZBkxjJU
        ACf3fqw6tUOkDksciGG7q5Dpig==
X-Google-Smtp-Source: AGs4zMYZIWVMC0LS+9Q/7ed1dxtgcBuuCXYmrgm26jjKqT7hyTK+i/5JGOJ/VmbIgxlp8oL6wVjxFg==
X-Received: by 10.107.130.13 with SMTP id e13mr5218530iod.212.1511986330572;
        Wed, 29 Nov 2017 12:12:10 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([100.96.218.44])
        by smtp.gmail.com with ESMTPSA id 14sm1128277ior.48.2017.11.29.12.12.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Nov 2017 12:12:09 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     jonathantanmy@google.com, git@vger.kernel.org
Cc:     newren@gmail.com, jrnieder@gmail.com
Subject: [PATCH on en/rename-progress v2] diffcore-rename: make diff-tree -l0 mean -l<large>
Date:   Wed, 29 Nov 2017 12:11:54 -0800
Message-Id: <20171129201154.192379-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.15.0.173.g9268cf4a2.dirty
In-Reply-To: <20171129183200.178183-1-jonathantanmy@google.com>
References: <20171129183200.178183-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the documentation of diff-tree, it is stated that the -l option
"prevents rename/copy detection from running if the number of
rename/copy targets exceeds the specified number". The documentation
does not mention any special handling for the number 0, but the
implementation before commit 9f7e4bfa3b ("diff: remove silent clamp of
renameLimit", 2017-11-13) treated 0 as a special value indicating that
the rename limit is to be a very large number instead.

The commit 9f7e4bfa3b changed that behavior, treating 0 as 0. Revert
this behavior to what it was previously. This allows existing scripts
and tools that use "-l0" to continue working. The alternative (to have
"-l0" suppress rename detection) is probably much less useful, since
users can just refrain from specifying -M and/or -C to have the same
effect.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
There are multiple issues with the commit message, so I am sending this
new version out.

v2 is exactly the same as previously, except that the commit message is
changed following Elijah Newren's and Jonathan Nieder's comments.
---
 diffcore-rename.c      |  2 ++
 t/t4001-diff-rename.sh | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 9ca0eaec7..245e999fe 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -392,6 +392,8 @@ static int too_many_rename_candidates(int num_create,
 	 *
 	 *    num_create * num_src > rename_limit * rename_limit
 	 */
+	if (rename_limit <= 0)
+		rename_limit = 32767;
 	if ((num_create <= rename_limit || num_src <= rename_limit) &&
 	    ((uint64_t)num_create * (uint64_t)num_src
 	     <= (uint64_t)rename_limit * (uint64_t)rename_limit))
diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
index 0d1fa45d2..eadf4f624 100755
--- a/t/t4001-diff-rename.sh
+++ b/t/t4001-diff-rename.sh
@@ -230,4 +230,19 @@ test_expect_success 'rename pretty print common prefix and suffix overlap' '
 	test_i18ngrep " d/f/{ => f}/e " output
 '
 
+test_expect_success 'diff-tree -l0 defaults to a big rename limit, not zero' '
+	test_write_lines line1 line2 line3 >myfile &&
+	git add myfile &&
+	git commit -m x &&
+
+	test_write_lines line1 line2 line4 >myotherfile &&
+	git rm myfile &&
+	git add myotherfile &&
+	git commit -m x &&
+
+	git diff-tree -M -l0 HEAD HEAD^ >actual &&
+	# Verify that a rename from myotherfile to myfile was detected
+	grep "myotherfile.*myfile" actual
+'
+
 test_done
-- 
2.15.0.173.g9268cf4a2.dirty

