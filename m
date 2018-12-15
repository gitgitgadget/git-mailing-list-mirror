Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6244120A1E
	for <e@80x24.org>; Sat, 15 Dec 2018 00:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730162AbeLOAKj (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 19:10:39 -0500
Received: from mail-qt1-f202.google.com ([209.85.160.202]:56253 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730140AbeLOAKi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 19:10:38 -0500
Received: by mail-qt1-f202.google.com with SMTP id b16so7191201qtc.22
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 16:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=i8EpahsQxzhhhw8wlrISW123HOH1xuSdTKzvv2F7mf8=;
        b=OzLI2DAiLWJQYIzjT8icJcP9lTtN+P/Zm/ys0tPVhCNbljCdyoGhrnV4vuOz72d9+m
         MM8oTcEBlkVm9BsgTCDE9bugVw2vvaxXemsTQ+a9CLZeDXIPr6nCBBawLcoBpTN1pRk/
         kTv5J1yN7n5rG2j1K0umEd48CwgTJjSWMkvW+WtWvj2KFAqy63Azrd7gbqFsFhsYAUO/
         iB1MXdKaoVvieGwAOmzzIgbVmxsszqz8XQqdAyAaGjlpXQ0nmRKYwQpzeBNZN3jRksaY
         xOONyVZ20TsaqTrwPvXRfCHqYvBK5Bc3Lk0Ts/8HGYGqrXFKl/69B0p9jtyKD82L4dK3
         8NvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=i8EpahsQxzhhhw8wlrISW123HOH1xuSdTKzvv2F7mf8=;
        b=Qhrx6jREPRs/d+dmDDDFoxdcoU76JUPonDEUaZDOfBsR40q42sRHOFHO+AwYA8DLrl
         dkJLkrc+30W5pjZdSQONhu1AwJtohZBs7wEhzcBlbDam8w1eHDuX7Uc1/NpnfkIO9jnN
         QqgkEQdFvH9GuqsHWGPfFwvpn1aX3endnlB99xekQzR6NV5KyPoxefMDPNMUX2S5L6sU
         8yBe86bWVQIPU/WG4wEbWq3RqzkM0kWeWvb3n24fzeTn89TUpstHZEWTNrVkjUCCdhkV
         OT+FQcV8FJgIRdMOnvwGTBdcZ26f1oER6ebBLVCf+u21Yg3p6ArLujkw1ADceyoaQMDj
         c6vg==
X-Gm-Message-State: AA+aEWbPGx0lkDmMN3Rcpd2uifSp3NfsfHrfG3MMuo7AGNFh6kgzfltZ
        rzRxzYWI/M9vVv9+cpxTQ1Vnf0Dvj7zXtYeI2kQLztXgx7IaQo3G93xoCnk9rMxQtU14M1dIHPC
        rmtL7qNgQAGBmtgq/UbzNI0/A4e/w6xEuitPbcq2kEF8SVtZFrfxnUp6kMxrk
X-Google-Smtp-Source: AFSGD/WFHjcJDYUWi6xtHTs17aKVcm4TSyZjzghNDNqz3mn+tF8fbronEGKaH/L8JGsKdeUDzfchrPbnyrrz
X-Received: by 2002:a37:5246:: with SMTP id g67mr4793286qkb.40.1544832637992;
 Fri, 14 Dec 2018 16:10:37 -0800 (PST)
Date:   Fri, 14 Dec 2018 16:09:41 -0800
In-Reply-To: <20181215000942.46033-1-sbeller@google.com>
Message-Id: <20181215000942.46033-23-sbeller@google.com>
Mime-Version: 1.0
References: <20181215000942.46033-1-sbeller@google.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
Subject: [PATCH 22/23] path.h: make REPO_GIT_PATH_FUNC repository agnostic
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git_pathdup uses the_repository internally, but the macro
REPO_GIT_PATH_FUNC is specifically made for arbitrary repositories.
Switch to repo_git_path which works on arbitrary repositories.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 path.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/path.h b/path.h
index b654ea8ff5..651e6157fc 100644
--- a/path.h
+++ b/path.h
@@ -165,7 +165,7 @@ extern void report_linked_checkout_garbage(void);
 	const char *git_path_##var(struct repository *r) \
 	{ \
 		if (!r->cached_paths.var) \
-			r->cached_paths.var = git_pathdup(filename); \
+			r->cached_paths.var = repo_git_path(r, filename); \
 		return r->cached_paths.var; \
 	}
 
-- 
2.20.0.405.gbc1bbc6f85-goog

