Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F38EE14A9
	for <git@archiver.kernel.org>; Wed,  6 Sep 2023 15:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242557AbjIFPXF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Sep 2023 11:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242531AbjIFPXE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2023 11:23:04 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A062A1732
        for <git@vger.kernel.org>; Wed,  6 Sep 2023 08:22:58 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31f4950333cso2734881f8f.3
        for <git@vger.kernel.org>; Wed, 06 Sep 2023 08:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694013777; x=1694618577; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MsucW3xG5qOdWILsBi68x2JFSxc79J2vEF//FKIA6MI=;
        b=FSktGBeSl3J6yblQbWXlEEFHEEe6mwofIEssWiPC6iWCitZYsJ18Ylgw0pMAFtUMbe
         +fVdA6Lqfyc2WdHHb5tmiq7CekI/7fiSQ05zFtPsPajexlkIkGM/TCQuNY0yWwoCA8JX
         WE+TREUJh6BnsUCIFJnXfqobUhpKDsBfSgNP3JMTNAQ97khNiOvbJBep7gjz+pS5LWKB
         jVJ/iMctb64UZWaWZkQJTsy3kKngcqF47F0bY1Zu9C9NNmUAnGPUF/JE0ds41GgD1G8a
         f+d3KNRNgr6DkDL+4zEIw/4DENBVjh8RmkRMI78EsXSEzwILWR4Cuvoa0YFCl5koS1gp
         fGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694013777; x=1694618577;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MsucW3xG5qOdWILsBi68x2JFSxc79J2vEF//FKIA6MI=;
        b=bxonkGAGp72RRmW3GBpgLs/NRxgn6pK7OQxx/0EasDtBoO4fujoA0RvyRPSOiP8eC8
         6wIfGSLt2hb7Rv8o1GC6UQWGT/ruYvUUoX0PNGqKEUjr5dSTLXPQ5Y2WRfz9iCvLPRaP
         Mv0pE5gd/EJBWmtD6iNKRp1Ai0EjZ1TqM3PPcg/EO9LdHyDh9LjURHoJ7PZ/LFl7bYcN
         q3F7NS3lNsLy+eYEiPg5N/HxlPSyIQedYe7kTEmcnmNSjiKZfBfigxqW6NXUj9HqCS1U
         sgDP4kPhN6goKRrmZfUQ9ikBZWKw37j2QrpqX/IbcE7yqLailYqa3XpEZviQBj40mYJD
         cTAg==
X-Gm-Message-State: AOJu0Yz5vDA4x4dRja/MJyK0feDEUS3zWXe72bxdOCOBOK/EgvyJlUfF
        lD2kKkrSWoH/ak1bN45yrbe+f1OdpNA=
X-Google-Smtp-Source: AGHT+IF8hl8W0+ZCh+OC8tx7TWm3ZlJ6rh4k3aCr5fndkUNWM2BQEd1tc196VkjEtO0ofyBLXKL8Mg==
X-Received: by 2002:a5d:550e:0:b0:317:6704:72c with SMTP id b14-20020a5d550e000000b003176704072cmr2822858wrv.52.1694013776597;
        Wed, 06 Sep 2023 08:22:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w2-20020adff9c2000000b00317ddccb0d1sm20666440wrr.24.2023.09.06.08.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 08:22:56 -0700 (PDT)
Message-ID: <818bdaf772dc34ef7282deb2e78ad9a37fa792f8.1694013772.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1492.v4.git.1694013771.gitgitgadget@gmail.com>
References: <pull.1492.v3.git.1690903412.gitgitgadget@gmail.com>
        <pull.1492.v4.git.1694013771.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 06 Sep 2023 15:22:47 +0000
Subject: [PATCH v4 3/7] sequencer: use rebase_path_message()
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

As with the previous patch we now use a hard coded string rather than
git_dir() when constructing the path. This is safe for the same
reason (make_patch() is only called when rebasing) and is protected by
the assertion added in the previous patch.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index c1911b0fc14..83be8bf2b6d 100644
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
@@ -3532,18 +3531,16 @@ static int make_patch(struct repository *r,
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

