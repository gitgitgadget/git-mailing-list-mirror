Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17E92208E9
	for <e@80x24.org>; Sat,  4 Aug 2018 01:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732163AbeHDDwR (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 23:52:17 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:53933 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731986AbeHDDwR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 23:52:17 -0400
Received: by mail-qt0-f202.google.com with SMTP id d18-v6so5751063qtj.20
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 18:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hq3gCUDEbFtpvaJgOKzgSkVQZziiHy6wtu2X4xaCaW0=;
        b=pczelfQZqk4vNSWi63ZgJsZnUot5cSW6Q587HmiWY3R7JU46WufQeIXCBG1AVwnssx
         oCPhp+vD7cWWFTeWxjDZ+nlZZJTK84COtPmntSh6sQErMNb4VgkT8rH/wX8ZT1XyyJUK
         StnlLnITcmohsHrVtdQjgySa0CYSf3Ocpnzxk6qIW1po9gs2GyJhfYMJ9jJLXyUONZLk
         EWdOiV6v/ZbvaM7raXECpcEH2kCMs3nxMvIY/3AqcmHRmHJaQy9xw8UGA+k+CFbj4MYH
         L2nQkhUWHaPHYUn62mknaO4yL4m9wvvNZPQpG8WoOk8jai6GdXVfrt6aGmnCReZjSWMB
         BoEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hq3gCUDEbFtpvaJgOKzgSkVQZziiHy6wtu2X4xaCaW0=;
        b=sP6yNKETXC8QZAFfVcqam0RFsostZdjPqZAf0odQ/jbUYrcidR0ZeF4Ntm5zx+y3fa
         gIXz7w9ZIdN7MRYtdOrJmcpX6609Nrr9UEBtCMpPd0KAjR33jDnDJfEGHsVABQ8KwtkD
         dnWPkU+cRXqPXnm1TL0AZrXXsDW6tq5aQRp6ghsQw5Tinzxeh18kJMAC+CkhEpTSTJP8
         eCRoGPosmY9zMRm1fS8qmWlHDlmBJWcIZrybUmYbJEu/5wA9+ajiY/rL94Qax8kwJxbp
         moQ2DLKxdYV61rv48SNIyIs9jK6IrSozMVGyhMyyLSBMU3L2H4nl/pDvkIna1RS8aDvf
         WiZg==
X-Gm-Message-State: AOUpUlGyLf4eQ1rknReIHLCReyUU2fGi2qxJ2v/jahCI2hDbUx5I0YHm
        M0Ma/Ev+N7Vv4F7QCEUY1c0svL6TUeoPNN55akpDtCPyDSqMMplJ934gBAOpufvt2H9L9eAwXzf
        uNmvFdXFsK3kcdBkDL+zzNgL2F85NBnPk+ARkln52AU4cBYrT/360NtVMxcok
X-Google-Smtp-Source: AAOMgpdc4+h5icDGOCD5dq0lg/GAfwi0BhMGZKbOEB43GSSX5n1F0lHTCpY5eYIgtCWrDQMEKB79W5L+Oe8J
X-Received: by 2002:a0c:d78c:: with SMTP id z12-v6mr4842767qvi.60.1533347608680;
 Fri, 03 Aug 2018 18:53:28 -0700 (PDT)
Date:   Fri,  3 Aug 2018 18:53:13 -0700
In-Reply-To: <20180804015317.182683-1-sbeller@google.com>
Message-Id: <20180804015317.182683-4-sbeller@google.com>
Mime-Version: 1.0
References: <20180804015317.182683-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH 3/7] range-diff: make use of different output indicators
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This change itself only changes the internal communication and should
have no visible effect to the user. We instruct the diff code that produces
the inner diffs to use X, Y, Z instead of the usual markers for new, old
and context lines

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 range-diff.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/range-diff.c b/range-diff.c
index 347b4a79f25..a4ff945427e 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -38,6 +38,9 @@ static int read_patches(const char *range, struct string_list *list)
 
 	argv_array_pushl(&cp.args, "log", "--no-color", "-p", "--no-merges",
 			"--reverse", "--date-order", "--decorate=no",
+			"--output-indicator-new=X",
+			"--output-indicator-old=Y",
+			"--output-indicator-context=Z",
 			"--no-abbrev-commit", range,
 			NULL);
 	cp.out = -1;
@@ -108,8 +111,18 @@ static int read_patches(const char *range, struct string_list *list)
 			 * we are not interested.
 			 */
 			continue;
-		else
+		else if (line.buf[0] == 'X') {
+			strbuf_addch(&buf, '+');
+			strbuf_add(&buf, line.buf + 1, line.len - 1);
+		} else if (line.buf[0] == 'Y') {
+			strbuf_addch(&buf, '-');
+			strbuf_add(&buf, line.buf + 1, line.len - 1);
+		} else if (line.buf[0] == 'Z') {
+			strbuf_addch(&buf, ' ');
+			strbuf_add(&buf, line.buf + 1, line.len - 1);
+		} else {
 			strbuf_addbuf(&buf, &line);
+		}
 
 		strbuf_addch(&buf, '\n');
 		util->diffsize++;
-- 
2.18.0.597.ga71716f1ad-goog

