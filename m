Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E55CCA47C
	for <git@archiver.kernel.org>; Tue,  7 Jun 2022 19:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356571AbiFGTyX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 15:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358666AbiFGTwt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 15:52:49 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8554149C91
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 11:22:00 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id j11-20020a05690212cb00b006454988d225so15632450ybu.10
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 11:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MN1yQdLKDZs/vQEzI9xhZlRNP5e7QpSsqtJE7NzHvqQ=;
        b=MWgoZ2tobZV/dYlWUEYv8P5DvfsginRrcn/JWX0uds50J9Y1BPEeICorEpQDXeKGOU
         UAzxPg0mPdpqd3Cj9p/ZicwKiKxIJCmHMJm+a9SwElROgymDTA50p0fUr3nAt6tCEa/p
         tqCX9p1JarsGTuDUXFVgTzuUpzz1m2etgJV7Jsw/piBJkGQVITy4uJGlRhapj1gjwS9z
         WgSNpqJRgkAJsyGVRjHuugzlX7YvjtUx9wHQr/nfVwKxyd01X4PWcyCeSf3LXFNcrunI
         LV8fJCOww/WneB1huRRUzsFKJJ2JwAAkdnTyUmlS0XA0T200O4K0/Y5jlZI9sE51UCVu
         h2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MN1yQdLKDZs/vQEzI9xhZlRNP5e7QpSsqtJE7NzHvqQ=;
        b=K0Os2qerpP04S4DFMlRgsMWNygX9/JnJKL17lv0Zqq13of+LJOgVrAq/IMZZJAxmsU
         SR5lh+S1xLC559Uv+btlPwi8XfI4dnw7pnuEtZqvX1WGyynDs0Y9iqZDCBixciLTai60
         iR4M5zKvnEMBx/JzGZkRFM+5J56M+r9xklg2jVfgw+M5RR8kaEkRBmX9CA2/hWgFx3wT
         5jSTCcKd1lnNMscRmSb8YxrRPva0iPDi7QhmuN5to4ba8Uqd9v3u1HTiE/OvALV0cTYN
         NC9E00Bl8X45peU6bykPfYjezATxmIymrJxMkbp15UP9a7PCaMC8UfcLXWhGRyp46gDb
         5YIw==
X-Gm-Message-State: AOAM531x+s1MiyMiAT4lUluXntmjnX76ms6fz6bCu4p26LDmIvSGcu+/
        yWJaeuqEZUQJvZYe0Z6TUQLZS0kUYGhaeUrXhTYcTBuXYB2oGmJe2hMx4EX0OoYAv3V6keCdNYs
        OiWqSQgcK9mX2rohznmtmD8pP229OvcoXZytv3+vpX6DhvHdvfa/oJ3z37GD4eGM=
X-Google-Smtp-Source: ABdhPJzJosS/0+Jiu1pQ0ejw+IM0fwhMS76W91lKN29YS2R8bFfb2HEfyyjIMCy9OYXaqMaOjQoheN6I/TDiRw==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:f2b8:26fd:5644:ff19])
 (user=steadmon job=sendgmr) by 2002:a81:70c8:0:b0:313:350e:8a7e with SMTP id
 l191-20020a8170c8000000b00313350e8a7emr5767109ywc.491.1654626119599; Tue, 07
 Jun 2022 11:21:59 -0700 (PDT)
Date:   Tue,  7 Jun 2022 11:21:57 -0700
In-Reply-To: <4616d09ffa632bd2c9e308a713c4bdf2a1328c3c.1651179450.git.steadmon@google.com>
Message-Id: <50d872a057a558fa5519856b95abd048ddb514dc.1654625626.git.steadmon@google.com>
Mime-Version: 1.0
References: <4616d09ffa632bd2c9e308a713c4bdf2a1328c3c.1651179450.git.steadmon@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v2] run-command: don't spam trace2_child_exit()
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, git@jeffhostetler.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In rare cases[1], wait_or_whine() cannot determine a child process's
status (and will return -1 in this case). This can cause Git to issue
trace2 child_exit events despite the fact that the child may still be
running. In pathological cases, we've seen > 80 million exit events in
our trace logs for a single child process.

Fix this by only issuing trace2 events in finish_command_in_signal() if
we get a value other than -1 from wait_or_whine(). This can lead to
missing child_exit events in such a case, but that is preferable to
duplicating events on a scale that threatens to fill the user's
filesystem with invalid trace logs.

[1]: This can happen when:

* waitpid() returns -1 and errno != EINTR
* waitpid() returns an invalid PID
* the status set by waitpid() has neither the WIFEXITED() nor
  WIFSIGNALED() flags

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
Updated the commit message with more details about when wait_or_whine()
can fail.

 run-command.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index a8501e38ce..e0fe2418a2 100644
--- a/run-command.c
+++ b/run-command.c
@@ -983,7 +983,8 @@ int finish_command(struct child_process *cmd)
 int finish_command_in_signal(struct child_process *cmd)
 {
 	int ret = wait_or_whine(cmd->pid, cmd->args.v[0], 1);
-	trace2_child_exit(cmd, ret);
+	if (ret != -1)
+		trace2_child_exit(cmd, ret);
 	return ret;
 }
 

base-commit: faa21c10d44184f616d391c158dcbb13b9c72ef3
-- 
2.36.1.255.ge46751e96f-goog

