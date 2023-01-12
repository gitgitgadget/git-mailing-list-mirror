Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DD4C54EBC
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 02:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbjALCsV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Jan 2023 21:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbjALCsT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2023 21:48:19 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832D31209C
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 18:48:18 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id w3so18837277ply.3
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 18:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JEUY9w5AdC/3R7DR4q8umZ26Uz/kn1mF+dIB15kXUFk=;
        b=opUUzvig1VwLqjgfdjQ9CfZ7CPdRHOSyXlNilrXTaamTfwKsdI6wY6pKJ//mRnaljS
         ZgmGFiz6/xEh11uuN/7aQE70syVJBqbwQZPN6cxYksPcmXnJPNJwZSqninVKWwNYjz76
         S/P9ZceiP9oqM7ur0FH/GQq/joRQJebxOiGX3tSod2mhHH1a3AYRUJnmGI56Qf9S3ZAN
         0wI7tMZjdgUtK4N2Da9xHZFJTih/BWL2IyLiPzpj/pkcbTdEhx+mPBJ51iMfFEatIg67
         QyoFRsWgB4h3NmFj38PAam/OUCyKYqhgr1WKVFmPJqVePaK+J8u88BPIQr/3+0rUMA5W
         8q0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JEUY9w5AdC/3R7DR4q8umZ26Uz/kn1mF+dIB15kXUFk=;
        b=ftAimOohZRFom/AZGquibZFFrCgsEtPf+iG4Zfp+HXXgQsI2/BTDlzq9KlRsU9Qduy
         VPW3qwmSnQwLGVs9z4o4McRl3U9oseaNiBqPeAVKTI0zGHU3sLz9osjMjkTI0GBuR+TF
         1QFcMYvpgocYOA2kKBNceJK+4jkbTmrFTX77wkrb6WSbHFNX8IrcqrXLJzvj4qayMbDF
         EW1kCnM/sy+MrFjXdGwNb5J/6Z9HPxPJdSa24DMJ0z+2e2o9twW/eS0R6nuKcDJB3myD
         81UX0wbA3ckj8Bi57Hioj1Ep7qVpDP9t8z39GUhvo96pOUE0XWS53HI8mc9CvNcoAifS
         kmaw==
X-Gm-Message-State: AFqh2kowIaKK0bwI53/5YQIaPS/hgqZuIwwg4xniKlBJZNvlt2Sb5jH/
        vBanLHnyI/zhYePvs3q+2fvPKqONX3Iobw==
X-Google-Smtp-Source: AMrXdXtV5UMjROneOOjINGas8EDcRh3IfDzMETwE0xq349JXqQyllYCovtexRyhGKU8oe7EjkRr0XA==
X-Received: by 2002:a17:902:b78c:b0:193:1fc5:f611 with SMTP id e12-20020a170902b78c00b001931fc5f611mr16823630pls.38.1673491697850;
        Wed, 11 Jan 2023 18:48:17 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.48])
        by smtp.gmail.com with ESMTPSA id u9-20020a170903124900b001926392adf9sm10855227plh.271.2023.01.11.18.48.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jan 2023 18:48:17 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, tenglong.tl@alibaba-inc.com,
        sunshine@sunshineco.com
Subject: [PATCH v4 0/5] notes.c: introduce "--separator" optio 
Date:   Thu, 12 Jan 2023 10:48:04 +0800
Message-Id: <cover.1673490953.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.38.1.386.g6952793f2d9.dirty
In-Reply-To: <cover.1667980450.git.dyroneteng@gmail.com>
References: <cover.1667980450.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

Sorry for the late patch, my family just recovered from COVID-19.

Diff from v3:

     * rename option name from '--blank-line' to '--separator'

Thanks.

Teng Long (5):
  notes.c: cleanup 'strbuf_grow' call in 'append_edit'
  notes.c: cleanup for "designated init" and "char ptr init"
  notes.c: drop unreachable code in 'append_edit()'
  notes.c: provide tips when target and append note are both empty
  notes.c: introduce "--separator" option

 Documentation/git-notes.txt | 18 +++++++++--
 builtin/notes.c             | 64 +++++++++++++++++++++++++++++--------
 t/t3301-notes.sh            | 64 +++++++++++++++++++++++++++++++++++--
 3 files changed, 129 insertions(+), 17 deletions(-)

Range-diff against v3:
1:  8ae58934a1 = 1:  f00a759658 notes.c: cleanup 'strbuf_grow' call in 'append_edit'
2:  a53576ea88 = 2:  29f7703b06 notes.c: cleanup for "designated init" and "char ptr init"
3:  62a952ba3e = 3:  7b756b4c60 notes.c: drop unreachable code in 'append_edit()'
4:  0d8ce0b14b = 4:  d41ba14050 notes.c: provide tips when target and append note are both empty
5:  196e80358e < -:  ---------- notes.c: introduce "--no-blank-line" option
-:  ---------- > 5:  f7edbd0e50 notes.c: introduce "--separator" option
-- 
2.38.1.386.g6952793f2d9.dirty

