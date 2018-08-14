Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C17641F404
	for <e@80x24.org>; Tue, 14 Aug 2018 01:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbeHNE0X (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 00:26:23 -0400
Received: from mail-it0-f74.google.com ([209.85.214.74]:36645 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbeHNE0X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 00:26:23 -0400
Received: by mail-it0-f74.google.com with SMTP id m185-v6so10985524itm.1
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 18:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=snebSF/Nv2tSH0Fm6pI/D+qJfZscdX/3eEeOj16HP/M=;
        b=q3/KqtXpHTOZG1ESXr9UnrFL4EY/A89AJ5xnjrbqN6cArzjkWpirkuglnc2rwB0L1Z
         qYfAihBiNt1ahJgrf2fiVJJkgUYCXSK5k9hiH+IXV73leUZWNlf7UPkP+Gx6hd6J/w8T
         IL1GOHl3f6wUTrJ6hMvpGtPac8LyXBwhW+Z28P4DNIlznTF1ev6DVE718jgJqlgqLg7x
         Q9+HgsEbxh/VyV1/0YcMUCZzTIgalzJmnaklQ606uXc9p7T61Zp+T9X64NwSQ+Jf2sYz
         5w+l/i5ay1CYe2M1h7/3LVclzyM95TU5UjsRQut/ommPz1rz8Huhcex9674Gmr5DLIJS
         PzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=snebSF/Nv2tSH0Fm6pI/D+qJfZscdX/3eEeOj16HP/M=;
        b=kBjTzzTBtmMehTyyFTeycRv102ymYNb/GS3EiKf7LZjDlm6mq8aM1g8xVd22h761cg
         2QiuYU188M1NZMu0XpJCHJorxi4i/s9kv3KiyrdYhLar+NbGUoB4bLvymjQdDmDDY4K9
         F8nndZ0m7JYoD7aZfibSavCaJ/HqOJNqJ9Vi/9EgnIzn/94npGpXW1xSFuy/kUpQlvei
         KSinStkaKs6xalDQaoSMV/Xd7V/fvrNwLaSnNvBw6EfE6WbLzvqHYgOq51S5r9aaJ521
         N/mgLsE4XLvRRtd4G6hBE9NPuf6F7IPQxaBvDopCLmgjM6gLx7qmAc6MNTeezxh2Vk5H
         gMTg==
X-Gm-Message-State: AOUpUlHh01Dwd+dX3c5TOmMj/u7WNpLTLyla16Oi3eydRNtruJ1VZgFa
        VvUVa75dmS2S2G/HXTfwBoQH0LKU8C6l
X-Google-Smtp-Source: AA+uWPyy7ZoLIZAq9ymcMQ4nl1SZfRg5vQfrSvWuERQc2k6/1ORDLrOmscvGFFBtyEsiOf7aCpM3PX09xRRB
X-Received: by 2002:a24:7f50:: with SMTP id r77-v6mr7565420itc.44.1534210892762;
 Mon, 13 Aug 2018 18:41:32 -0700 (PDT)
Date:   Mon, 13 Aug 2018 18:41:15 -0700
In-Reply-To: <20180814014122.30662-1-sbeller@google.com>
Message-Id: <20180814014122.30662-2-sbeller@google.com>
Mime-Version: 1.0
References: <20180810223441.30428-1-sbeller@google.com> <20180814014122.30662-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH 1/8] test_decode_color: understand FAINT and ITALIC
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/test-lib-functions.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 2b2181dca09..be8244c47b5 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -42,6 +42,8 @@ test_decode_color () {
 		function name(n) {
 			if (n == 0) return "RESET";
 			if (n == 1) return "BOLD";
+			if (n == 2) return "FAINT";
+			if (n == 3) return "ITALIC";
 			if (n == 7) return "REVERSE";
 			if (n == 30) return "BLACK";
 			if (n == 31) return "RED";
-- 
2.18.0.865.gffc8e1a3cd6-goog

