Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5179AC2BB1D
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 18:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E7BB206C1
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 18:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJxrc6Gr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgDJSRA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 14:17:00 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38880 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgDJSQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 14:16:58 -0400
Received: by mail-ed1-f67.google.com with SMTP id e5so3401591edq.5
        for <git@vger.kernel.org>; Fri, 10 Apr 2020 11:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=AN1/wCrE9GKlqNjDshykXbSd8zEHbOe9EjwdHKBjjgY=;
        b=QJxrc6GrUFm8RaEDs0Sd2+FctCuDG2nwN0bMq9YS5OwCs9am3CASJ++b+WUmvmRakA
         kXmKOA8M+f3VuHVG5znsnuj0P7nn+jekLdF3MRHKBVnxMUBAeTc2EYJnTehyt0BYcEV7
         PE9yY1kmyWLkGkQU4BnSET/K4BhAvMTwMhJ9Objax4qFRBVMZ5wnpTFqVTxYusL7oG/Y
         iDpYf4VFfSQLdWUZK8e9EoYr8f3ZDaCk8wGoSSDdE8mGx7Lui3e+Z6PTAbvG/Chz+bA3
         gILNYF/HDiKsTtpKeqDPtYtIb8BggRwEvCbTgLkOQDhu4k3/TeRnll0IiykFy1+ohzGf
         C9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=AN1/wCrE9GKlqNjDshykXbSd8zEHbOe9EjwdHKBjjgY=;
        b=GzzbDuOiqUs4EHashlju4Hh6f+DLflOyM+6Bb+qeN6QencCcg1QwVXOp2szooB1Zeg
         i2rJQCDErBTJi9T7EeSXle79jaCZVI1nYTtT1kWmIYXb9bx/9vrvncEMKkvTntaJtoay
         oF2IinJCLLcvDIOu2v+9iyLkIPFQGPoEIT/DxD3oyWluTWbek9noHRDRq2SegMOkGxvb
         Z8sYCK6Dq2dlVlQUsNn6lwm7Q3FCNk1/CfOJw94+pRkWtzytFBj//bmUwQWpAxsnnMtV
         +r43k4ZThTm3MQHCHpJRyyE46iHQeoP0+Sa+CKLuQjwoLAiwQ1aRFQn4oEZhYAiK6k4D
         OvKw==
X-Gm-Message-State: AGi0PuaE3Y+yb4ueOS20wU+CiS76bjjXvWGHLk0P95c3YdNo/Q4zDD40
        6aciiLmd3ViFG05iz3TU0NtqUiTG
X-Google-Smtp-Source: APiQypImQtxM9aZibFvoLUJPVoJlp1mOYnDgsk/wJQXn7L5680ruFwJJqCY+EhQxSuIpGRhIOlpN/A==
X-Received: by 2002:a17:906:c150:: with SMTP id dp16mr404955ejc.331.1586542617817;
        Fri, 10 Apr 2020 11:16:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d23sm184552ejk.26.2020.04.10.11.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 11:16:57 -0700 (PDT)
Message-Id: <063d2aaa4016bd6d98d2ce6695e24865e93b0ed3.1586542614.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.755.v3.git.git.1586542614.gitgitgadget@gmail.com>
References: <pull.755.v2.git.git.1586518072.gitgitgadget@gmail.com>
        <pull.755.v3.git.git.1586542614.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=EB=A7=88=EB=88=84=EC=97=98?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Fri, 10 Apr 2020 18:16:54 +0000
Subject: [PATCH v3 2/2] Explicitly `fflush` stdout before expecting
 interactive input
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=EB=A7=88=EB=88=84=EC=97=98?= <nalla@hamal.uberspace.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?=EB=A7=88=EB=88=84=EC=97=98?= <nalla@hamal.uberspace.de>

At least one interactive command writes a prompt to `stdout` and then
reads user input on `stdin`: `git clean --interactive`. If the prompt is
left in the buffer, the user will not realize the program is waiting for
their input.

So let's just flush `stdout` before reading the user's input.

Signed-off-by: 마누엘 <nalla@hamal.uberspace.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 prompt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/prompt.c b/prompt.c
index 098dcfb7cf9..5ded21a017f 100644
--- a/prompt.c
+++ b/prompt.c
@@ -77,8 +77,10 @@ char *git_prompt(const char *prompt, int flags)
 
 int git_read_line_interactively(struct strbuf *line)
 {
-	int ret = strbuf_getline_lf(line, stdin);
+	int ret;
 
+	fflush(stdout);
+	ret = strbuf_getline_lf(line, stdin);
 	if (ret != EOF)
 		strbuf_trim_trailing_newline(line);
 
-- 
gitgitgadget
