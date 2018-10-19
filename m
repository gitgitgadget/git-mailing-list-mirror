Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2581D1F453
	for <e@80x24.org>; Fri, 19 Oct 2018 23:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbeJTH1m (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 03:27:42 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:44511 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbeJTH1m (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 03:27:42 -0400
Received: by mail-qt1-f201.google.com with SMTP id q48-v6so38520616qte.11
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 16:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=9Ijr0LmVda4IEhkSXChi2WossRwrtUybF/wzO+mnnm0=;
        b=D3OIZ0tpwlnRndoyVy7og0Y3I2rwqMF4neb0Ha08THVjeoddtdlrHEr1Rpx7qMWCgL
         ZGUILi/08y3kPnTvktJklzabWqY58uQ3FmktlQVI6aUGYIBkRMfi6QgGYE1Qy+SjAewh
         hpAIQUSmnYr4osliCJ7VOX6ApacXhJEkSJRIJLFsRgFIzoVhvWSds153EUs/j0PUyXuK
         nUEZmJSdIVPCFel0pASWEIJmVokS7V5KoyWyS2fwUsBFJkTX6lzsTGa5C8B6XNzmUsMN
         CdDzDjtDu4HsT8u6W+4Ez4Rbe2YQ8SB+CRQhKJPb8uxU8H/KYYNlwNud6oG4BJSe7C4J
         vWSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=9Ijr0LmVda4IEhkSXChi2WossRwrtUybF/wzO+mnnm0=;
        b=RMfWN5GO5H5FhsaCzUnp20eT35bGukWZVfEyVrJt4g2gY5AcMo8k2KuIV3ze0uKwvW
         E0xN4d24OA9+XudOm2fyU+yVdiMDnzI2dOJbILKIFBA9UXaQrC28034CEUvFmqb+/XV6
         6uT4zx0ff0vRRltBkdq3lymVkSOFOoP1jA2P73CwvG9tIKZYodL7ORol+dSOdKWnjR+g
         /HIkIoMa1AKTaUzuXmc2iE9fv0t5E5jtITeNbuHCHC6yafmHvLNBuszhWzcTeHd1halj
         fiqp2jgcMsUnkW1SwOAv0CuvQw84urt1wCHOh1QPxMaqr6O0xbSN8ORAGhCUZOnju+eu
         PMtA==
X-Gm-Message-State: ABuFfogrg8FuKF+K0iU3t+USX5zQY4wkXUhWPT3Mp0LyCLaMX+jM/I7M
        XnUUXm8E4MYmEM4fWShAGv2F+r4ICVGmFR8NZ5m2uUCcbze2pTa1OpOxOklEqe21E1G4/b1oGFi
        AYcKWVncY3j9l2cx+nJXn2yFGS1sCZy6iZLh+GgcPjkMMfzUnAe000b0uNH3DltQ=
X-Google-Smtp-Source: ACcGV60T3paJN/sqJqle0X2Uz706204L4wSDKw3iDj3IEOUmuzI9fBYChNFDXiD1zjTCsyX+DbDoYqnwlg8yjQ==
X-Received: by 2002:a37:9943:: with SMTP id b64-v6mr3729315qke.35.1539991174221;
 Fri, 19 Oct 2018 16:19:34 -0700 (PDT)
Date:   Fri, 19 Oct 2018 16:19:28 -0700
In-Reply-To: <cover.1539990488.git.steadmon@google.com>
Message-Id: <b1f8e288dde9a9dd46386524189da66c7ad2c333.1539990488.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1539990488.git.steadmon@google.com>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
Subject: [PATCH 1/1] archive: init archivers before determining format
From:   steadmon@google.com
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When passing both --remote and --output to git-archive, initialize the
archivers before attempting to determine the format from the output
filename. Without initialization, the format cannot be determined.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 builtin/archive.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/archive.c b/builtin/archive.c
index e74f675390..dd3283a247 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -45,7 +45,10 @@ static int run_remote_archiver(int argc, const char **argv,
 	 * it.
 	 */
 	if (name_hint) {
-		const char *format = archive_format_from_filename(name_hint);
+		const char *format;
+		init_tar_archiver();
+		init_zip_archiver();
+		format = archive_format_from_filename(name_hint);
 		if (format)
 			packet_write_fmt(fd[1], "argument --format=%s\n", format);
 	}
-- 
2.19.1.568.g152ad8e336-goog

