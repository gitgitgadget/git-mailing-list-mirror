Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 809EB1F404
	for <e@80x24.org>; Tue, 14 Aug 2018 01:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbeHNE0j (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 00:26:39 -0400
Received: from mail-qk0-f202.google.com ([209.85.220.202]:44394 "EHLO
        mail-qk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbeHNE0j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 00:26:39 -0400
Received: by mail-qk0-f202.google.com with SMTP id w126-v6so18648416qka.11
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 18:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EefIuxpf0ur0hPl47RVK2xGtJsZm9YNkd6gv7e3PYzw=;
        b=PhuVlnG1D3mXwfDvV96B6qgVp80PWXrJn6FD8F5jfg1svPP6F240TcDZP6Qx2GgeZu
         l/Yxj77e3VScj5auQ53L1RB84bYteE0bsQ96XGxRtu+cw+M6npDY+c3vPRiNVfTjmIuG
         5/Rg16HG/DYC8cpQsxzqi9hTQa7D+uXvd5epOp/+O8YiJZUEkGf2GHw3Sqx2xJOKDbwi
         ost2Ab+I+/+7p3CFAP6uDvxDVCnVSIauVU0LIbcOZg1eUsnRZZFNlg/CB4X7OOgkBekr
         yC1/VIGUb62tSm3V4hOgmIIOTBIPxBzWS4QZ2GgXEu79dBxHBDYmSckCmOyTZenuc7kX
         il9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EefIuxpf0ur0hPl47RVK2xGtJsZm9YNkd6gv7e3PYzw=;
        b=rGFglvbthBmo0r+dbwTzyvKv4ewlKyVnJGQaYpXp1T8wPD4k0Vb59xY0Rw9HfmEpXm
         lv5OkbzqPz8ttGpl+H6qMFpFjvSxN3MfFade0y/BfOsRqPIh2LChj6E/iV3dXyEvVZrm
         7L/dk28eNP45vxviMO0w3MSTQkt9sfEX8X6RZ7jDMe6mApNHLGYUw/Q2l3gfoG579STW
         DWFyCxbF8QR9Ceqt8LlmaC+uT9nNqfmyF/cl/n1KLzMa3ZfGEmHFLa3m5dsu/kttO2dz
         rfJJ+bAVPNBT+ALA+gSRKkv7f9b9KtGCx/70AR12vU5JCLTg49/3/iznHDg1cDPF4Mvm
         9ERQ==
X-Gm-Message-State: AOUpUlFz+PwQnZfA14GAzTnckeLSqfYiCVX0BS5rZMlDe2ATn3BiwVLA
        Piz1fd73S+haNs79zJ+k9ZW5gqwzBSsv
X-Google-Smtp-Source: AA+uWPx2I9jv05XcG2COXrekQmVw7Rn3hoYffEtKdabC5KluVBAb9L9aMC8LC9VWM+WP1tweBU0oV4O1wzXy
X-Received: by 2002:a0c:ba0e:: with SMTP id w14-v6mr10605614qvf.46.1534210908247;
 Mon, 13 Aug 2018 18:41:48 -0700 (PDT)
Date:   Mon, 13 Aug 2018 18:41:21 -0700
In-Reply-To: <20180814014122.30662-1-sbeller@google.com>
Message-Id: <20180814014122.30662-8-sbeller@google.com>
Mime-Version: 1.0
References: <20180810223441.30428-1-sbeller@google.com> <20180814014122.30662-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH 7/8] diff.c: omit check for line prefix in emit_line_0
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As the previous patch made sure we only call emit_line_0 once per line,
we do not need the work around introduced in f7c3b4e2d8c (diff: add an
internal option to dual-color diffs of diffs, 2018-08-13) that would ensure
we'd emit 'diff_line_prefix(o)' just once per line.

By having just one call of emit_line_0 per line, the checks are dead code.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 4f430f44e64..7a23adf254d 100644
--- a/diff.c
+++ b/diff.c
@@ -629,10 +629,7 @@ static void emit_line_0(struct diff_options *o,
 	int nofirst;
 	FILE *file = o->file;
 
-	if (first)
-		fputs(diff_line_prefix(o), file);
-	else if (!len)
-		return;
+	fputs(diff_line_prefix(o), file);
 
 	if (len == 0) {
 		has_trailing_newline = (first == '\n');
-- 
2.18.0.865.gffc8e1a3cd6-goog

