Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CC7C6FD1F
	for <git@archiver.kernel.org>; Sun, 19 Mar 2023 06:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjCSG22 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Mar 2023 02:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjCSG2O (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2023 02:28:14 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D575FE7
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 23:28:13 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id p34so552830wms.3
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 23:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679207292;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xseF45rJFDsz6Zxllwj1WjCkE0KWXhmhICbtjGjrY3A=;
        b=fa4NjHvo04UqwmhT2kK5MbKCF4b2CJ2JPDfC5fXyTFMyUBvNexzxsaX7gtCGWJFUez
         xARB1zlUcfvkGrCRQ7YT1d8PIkVOVra11KsFEej0uCViY4AaBayPct82lw8GKUpNgy/b
         Mhjz2WogRgGTCuU8xgwPWk15i/NrsnY2vmh2CLbJRxqHvhH08Fbtafh1H28ftaRbacLD
         bbjq4ca6sHa+y3YDiMKN+SxtWQ8l4fvx0+ySJgWRQCgo+5TsPSccEAXT54TT5IxX6cgP
         4EvI23cqi+HnPcjwOBU0oTATQ2ADPBhLfG4iv0MWtofDidH7rklZ0zFlO8Q29of+ENpY
         JDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679207292;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xseF45rJFDsz6Zxllwj1WjCkE0KWXhmhICbtjGjrY3A=;
        b=lFFQx9pykMO8aEEDSgm6j7HOZ8sb9QlGjrhoDYtUxZz1DXjOtQ1M19RAfIgSMkUT6S
         CAzB1vvp3IZTIfoOGXHan2nK1aLlWAqvKGZzWwn3uubga0jhwXBKDuZkvB/uHqZ6uzIg
         KQpvtp3ykEwITpbuDcJUGGlyFoyZfc4G+UTXFeMR1LsaOflKTXGQlZzok2P+1dNaOhrX
         RTJOQ6g9DxQWiAMRWCqx2tzY+Gi9ZkfdH+OcdoduIfP0a+KxlrVQM+DMfJvwgKdyFKK2
         UvHUADinuzc8RQsscMV8GzQtoedPPF9eZv/SuClxiv2odk+KlfiHt8BL1Lh2I+mG+5mt
         qHTQ==
X-Gm-Message-State: AO0yUKWauoZtERkGVfT+X7BQpFWa0fKMEoNlRryLo+qLn3qcNgAq5Ygd
        kB6oXvbl4NxYN6qUa2pTG9gz+Yfh72U=
X-Google-Smtp-Source: AK7set9tEtyRYNi6sPPadJ9pYq1Lj2a0j+ANBgMXZ1ulUffXdyF1P6kZa4wiJZhrI8Huz0vYS8JVpw==
X-Received: by 2002:a05:600c:4e09:b0:3df:9858:c039 with SMTP id b9-20020a05600c4e0900b003df9858c039mr5570939wmq.14.1679207292014;
        Sat, 18 Mar 2023 23:28:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l13-20020a1c790d000000b003daf672a616sm6652818wme.22.2023.03.18.23.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 23:28:11 -0700 (PDT)
Message-Id: <a0fc4aa2470af2480945b20e905287c872472a1f.1679207284.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1493.git.1679207282.gitgitgadget@gmail.com>
References: <pull.1493.git.1679207282.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 19 Mar 2023 06:27:53 +0000
Subject: [PATCH 07/16] cache.h: remove expand_user_path()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

expand_user_path() was renamed to interpolate_path() back in mid-2021,
but reinstated with a #define and a NEEDSWORK comment that we would
eventually want to get rid of it.  Do so now.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 cache.h         | 2 --
 gpg-interface.c | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 260203c7a62..978aa01712b 100644
--- a/cache.h
+++ b/cache.h
@@ -1142,8 +1142,6 @@ enum scld_error safe_create_leading_directories_no_share(char *path);
 
 int mkdir_in_gitdir(const char *path);
 char *interpolate_path(const char *path, int real_home);
-/* NEEDSWORK: remove this synonym once in-flight topics have migrated */
-#define expand_user_path interpolate_path
 const char *enter_repo(const char *path, int strict);
 const char *remove_leading_path(const char *in, const char *prefix);
 const char *relative_path(const char *in, const char *prefix, struct strbuf *sb);
diff --git a/gpg-interface.c b/gpg-interface.c
index 632265691e5..f9c5b6c3f53 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -1049,7 +1049,7 @@ static int sign_buffer_ssh(struct strbuf *buffer, struct strbuf *signature,
 		ssh_signing_key_file = strbuf_detach(&key_file->filename, NULL);
 	} else {
 		/* We assume a file */
-		ssh_signing_key_file = expand_user_path(signing_key, 1);
+		ssh_signing_key_file = interpolate_path(signing_key, 1);
 	}
 
 	buffer_file = mks_tempfile_t(".git_signing_buffer_tmpXXXXXX");
-- 
gitgitgadget

