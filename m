Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E342A1F453
	for <e@80x24.org>; Sun,  3 Feb 2019 11:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbfBCLIt (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Feb 2019 06:08:49 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36960 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfBCLIt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Feb 2019 06:08:49 -0500
Received: by mail-wm1-f68.google.com with SMTP id g67so10426691wmd.2
        for <git@vger.kernel.org>; Sun, 03 Feb 2019 03:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MV1BpLLd4DNYwQ/njxeCLFptvwInEgcxIp00Oo6xQgw=;
        b=EA90MZ4AVvvGHIzTr6Qc37mKlI3x+RsCoXDHB/2u3ve1GDlWkbBWmFDnAlZtrKI4zZ
         ay2eC6l4osHTZlrZA3bYBXsSKBZIBSb2bm2nJo8qA0546glT+fzC/px4KD3kj7k6+USV
         9ILTFbpGaD8BBMgCq7iZyYx8XhfyT+5W7KG/z3ZsQMuBr2ZiTyqi9qBEBU4Fc9aCRi8f
         x3Ffl5ujqDmmtyiy0us6IY2moUNLM1TZDUAuZv/CiW6Lnx97AT9RqcTOkyMfbN0nnUEe
         DHv63927cso6uwwYe0YSqcJL2nmr5OlWsK9ODZiqQYBnR8hWnh7n2vdXOmjoLJTNKYx5
         l8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MV1BpLLd4DNYwQ/njxeCLFptvwInEgcxIp00Oo6xQgw=;
        b=m5mY5uc6YStw8yXHRM34KpH9N6UB98Hu9vlkydHg0kC/LIqGNSfl1Yi/QqXOJbhXQf
         uIdCy0kuqglQyJsW0KNmXxdQ4R8+n8j5xehiNt2QYvg70X1rsXXkN03V1JS4ZJNXUoNl
         Y/mNNtImi6YMlC/d2nNppGAz9NyW1Zjuja+i/NTUSOg8/XG1BcI3un8lBkESC46jjCWR
         ad3IDUKra1joZw1NQKu4/n17HRVwe1zTZPPGVmepeXf/2mvGJT6bdH3qUhS5VXQcWt+q
         3oCxDNgndpbzkchkNKvjAHHvrJq9VAICTjlfeCk51lVTZuBjRFNpd4SvHOhV8aD6nPab
         WjhQ==
X-Gm-Message-State: AHQUAubLutRHfM5jTFEzI9naisVSfCdGDedYCgPXotNF6xslJB9DIovT
        NJASiQirZ3pC5kcHM6i9sVau2T2zzjg=
X-Google-Smtp-Source: AHgI3IYx+dbBMhItnqqaju/FG5e8BbtDq7eLOuxrfrchplzb0++O1wctGgwEdH8shdbKxcybtww8GA==
X-Received: by 2002:a1c:b1d5:: with SMTP id a204mr9777384wmf.32.1549192127490;
        Sun, 03 Feb 2019 03:08:47 -0800 (PST)
Received: from localhost.localdomain ([46.183.103.8])
        by smtp.gmail.com with ESMTPSA id m4sm8157113wmi.3.2019.02.03.03.08.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Feb 2019 03:08:46 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2] doc-diff: don't `cd_to_toplevel` before calling `usage`
Date:   Sun,  3 Feb 2019 12:08:17 +0100
Message-Id: <20190203110817.17242-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.20.1.309.g16a465bc01
In-Reply-To: <CAPig+cT32oi5HLe7tokghrCmaiECwAXxON8U7DrpMYb3GCSNyQ@mail.gmail.com>
References: <CAPig+cT32oi5HLe7tokghrCmaiECwAXxON8U7DrpMYb3GCSNyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`usage` tries to call $0, which might very well be "./doc-diff", so if
we `cd_to_toplevel` before calling `usage`, we'll end with an error to
the effect of "./doc-diff: not found" rather than a friendly `doc-diff
-h` output. Granted, all of these `usage` calls are in error paths, so
we're about to exit anyway, but the user experience of something like
`(cd Documentation && ./doc-diff)` could be a bit better than
"./doc-diff: not found".

This regressed in ad51743007 ("doc-diff: add --clean mode to remove
temporary working gunk", 2018-08-31) where we moved the call to
`cd_to_toplevel` to much earlier. Move it back to where it was, and
teach the "--clean" code to cd on its own. This way, we only cd once
we've verified the arguments.

A more general fix would be to teach git-sh-setup to save away the
absolute path for $0 and then use that, instead. I'm not aware of any
portable way of doing that, see, e.g., d2addc3b96 ("t7800: readlink
may not be available", 2016-05-31), so let's just fix this user
instead.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---

 > Punting and extending the commit message like that sounds reasonable.

 So here's a v2 doing exactly that.

 Documentation/doc-diff | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/doc-diff b/Documentation/doc-diff
index dfd9418778..f820febf8f 100755
--- a/Documentation/doc-diff
+++ b/Documentation/doc-diff
@@ -39,12 +39,11 @@ do
 	shift
 done
 
-cd_to_toplevel
-tmp=Documentation/tmp-doc-diff
-
 if test -n "$clean"
 then
 	test $# -eq 0 || usage
+	cd_to_toplevel
+	tmp=Documentation/tmp-doc-diff
 	git worktree remove --force "$tmp/worktree" 2>/dev/null
 	rm -rf "$tmp"
 	exit 0
@@ -66,6 +65,9 @@ to=$1; shift
 from_oid=$(git rev-parse --verify "$from") || exit 1
 to_oid=$(git rev-parse --verify "$to") || exit 1
 
+cd_to_toplevel
+tmp=Documentation/tmp-doc-diff
+
 if test -n "$force"
 then
 	rm -rf "$tmp"
-- 
2.20.1.309.g16a465bc01

