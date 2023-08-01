Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FC8C0015E
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 15:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbjHAPXx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Aug 2023 11:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbjHAPXr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2023 11:23:47 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613751FEE
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 08:23:39 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fba8e2aa52so63126145e9.1
        for <git@vger.kernel.org>; Tue, 01 Aug 2023 08:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690903417; x=1691508217;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kpkv+W1+9kkkw9zCWjfM6lpDPwaFN/ucdioyGSRow5Y=;
        b=ibQlQIGU0t8Oq1hWgftP/3foZeCN7GoDKpZw/w4JPzWx0yHWn2hWMbl255k3uqCCqQ
         rurWaN8ivKWjLTVq3IRcN8KRwVQQzgZ5aJF7Zg+y0fa0ZXW4gf5zTUUrQyAFS0VGeedV
         K/VrkdaxLlm8nOAaEMY7JTAFHmM2zoYWBS6K7Z4hbqE0Phjxi8TIy295uyKHUHJm4gcx
         +UjpP+iuJpOA/++RZLhqss5ZAWqIbScT/2a6Y1o45x15I3CzEtq0KW1DSOGGUdPkzXQz
         qmvkAhk+BIXmGQL2+QmVQKYTzhGBgLxFH90L2Dhcb9EyDjujknbE2/FsB/y7DAXC8h5T
         BSdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690903417; x=1691508217;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kpkv+W1+9kkkw9zCWjfM6lpDPwaFN/ucdioyGSRow5Y=;
        b=CI0o4dTAhvsXYvZ1jwiwOmWHo43KCRFs6sCIOsTogNER8cI9ZREQmadx1ae4VLY5RS
         6wREiN5EwWQtYiXQxDDeAXX4KcbnzQgRkNeKHrU+XXFKk28obazfm3oY78xhN4ReYAiE
         GcZ/NUIjmdwPmFRcw7y4BBsgH4rw+Z6Fo/aXKCUmwvXORFSlDB+ujVoe6xMaqeklX2QO
         lvE6CUJnJpHLImPh9HGk00kaCoIHKJwahMrCSzCLxq54foAOm8cTfQSRLilhjq+u+A30
         6oSIrWAcTN9/kxNY5ZfU0wrgeFBCSS3OVwfkdVzvDPpoGZYTyv4tXTSA8LbUUNEhCzkj
         mr7A==
X-Gm-Message-State: ABy/qLZ4oBphdJ3QzMm86IcVjeqJ+Mj4qmQ1mekIy4sKUquhcdMmLq+A
        CjnEPBK0XbMOJRYTFXQhqQ9F3ZE1eUk=
X-Google-Smtp-Source: APBJJlGTwgV4132ytpPvFKmL1YpG3BwvjxJBKSERzt5BeXNHPpO5skLxfRF3JY+TLpN5EYegna4vAA==
X-Received: by 2002:a05:600c:ad3:b0:3fe:173e:4a53 with SMTP id c19-20020a05600c0ad300b003fe173e4a53mr2859115wmr.0.1690903417155;
        Tue, 01 Aug 2023 08:23:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s15-20020a05600c044f00b003fbb1a9586esm17240394wmb.15.2023.08.01.08.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 08:23:36 -0700 (PDT)
Message-ID: <8f6c0e4056742951ce84acbdb07b0518f7607b2a.1690903412.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1492.v3.git.1690903412.gitgitgadget@gmail.com>
References: <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>
        <pull.1492.v3.git.1690903412.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Aug 2023 15:23:28 +0000
Subject: [PATCH v3 3/7] sequencer: use rebase_path_message()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Haller <lists@haller-berlin.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Glen Choo <chooglen@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Rather than constructing the path in a struct strbuf use the ready
made function to get the path name instead. This was the last
remaining use of the strbuf so remove it as well.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 70b0a7023b0..dbddd19b2c2 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3501,7 +3501,6 @@ static int make_patch(struct repository *r,
 		      struct commit *commit,
 		      struct replay_opts *opts)
 {
-	struct strbuf buf = STRBUF_INIT;
 	struct rev_info log_tree_opt;
 	const char *subject;
 	char hex[GIT_MAX_HEXSZ + 1];
@@ -3529,18 +3528,16 @@ static int make_patch(struct repository *r,
 		fclose(log_tree_opt.diffopt.file);
 	}
 
-	strbuf_addf(&buf, "%s/message", get_dir(opts));
-	if (!file_exists(buf.buf)) {
+	if (!file_exists(rebase_path_message())) {
 		const char *encoding = get_commit_output_encoding();
 		const char *commit_buffer = repo_logmsg_reencode(r,
 								 commit, NULL,
 								 encoding);
 		find_commit_subject(commit_buffer, &subject);
-		res |= write_message(subject, strlen(subject), buf.buf, 1);
+		res |= write_message(subject, strlen(subject), rebase_path_message(), 1);
 		repo_unuse_commit_buffer(r, commit,
 					 commit_buffer);
 	}
-	strbuf_release(&buf);
 	release_revisions(&log_tree_opt);
 
 	return res;
-- 
gitgitgadget

