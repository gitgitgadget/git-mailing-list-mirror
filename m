Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0CCC433F5
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 12:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71C2761390
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 12:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343909AbhI2Mvc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 08:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343901AbhI2Mvb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 08:51:31 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A2BC06161C
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 05:49:49 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id u1-20020a17090ae00100b0019ec31d3ba2so4140140pjy.1
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 05:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S9sMpn2AT50QiiopfkpCS3YxnHRa2/cuW+7M5TY2kUg=;
        b=Wf08zt6fhuWU65oBSYeZDVsw2RWTcIuooOpfF37zlobQ7K+cCAqpB0Z+JEeZW7ykPb
         lsQmD9w2FqZbYVy39XoGiEh9u97a/W1/ZAyYJCn7UL+boihP35bsYfLrDgZL882E4p7e
         9O3EzGOlm7ZgLix4YPjBmaCdGulObLg0TxZ75IrgOI0/nHodZhAE9kvrPc+KAldQBnL8
         +SPqQ/nBJQttOv42w19ibjsEIYZwMep29zHqG++N4enfLHYI338uf1LxEr5GeWjPmT0w
         OrzkNkB7dQTcCVodiD9oNQDScOYRjQUo3G6ai5n7XfIksMH5x/seoJ0rzVa7Vj/ckH01
         vkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S9sMpn2AT50QiiopfkpCS3YxnHRa2/cuW+7M5TY2kUg=;
        b=NIT5+NOgJ8aofc9aYMFaON5mo/3iQlfzn53uyITAu5pE3O/59e8jRm2vdaiXkEtmiU
         zW9iVBGjlHBlp5MXcV6ddB1VvDNEwdPCD5U6P743TUjZ1doYapHxOj//yfMMJP46GIdz
         mJidBHAwPMBTk3U+wGsX/lW50WUvqoY6gFP2Z4iTmucEumIhnjpm7SzlyMhnY6zhth1s
         S78sS86XVnh9OFgZaMSP9SggAUqAq6B1Ny6wddiKO6sesZ55vOrP2lQqXvJtH1sWNXPp
         Q2B1UkUSSms8ZrVtKpb1/nvp+NkQxvSgzdUSNhVbWcNiK7x2wmBNu1TJK2RVY8/3KMHI
         WNLQ==
X-Gm-Message-State: AOAM5308enCcMAaWej0SQHbUc+Gqo3b2/NG2JBbdfL/V6dCrF+3ygYve
        K4yc1niVaBOBpXgyMk9h6NK2GKqhdF/nKw==
X-Google-Smtp-Source: ABdhPJxjxHL03SZBU1ABdhwT4IJ2i1J+qDYYJKIbOVuIcwkJThBE+j0dLKigIKRr5IpbYvseK4+FQA==
X-Received: by 2002:a17:90b:3145:: with SMTP id ip5mr6360603pjb.161.1632919788662;
        Wed, 29 Sep 2021 05:49:48 -0700 (PDT)
Received: from ubuntu.mate (subs02-180-214-232-72.three.co.id. [180.214.232.72])
        by smtp.gmail.com with ESMTPSA id z9sm1974844pji.42.2021.09.29.05.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 05:49:48 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     "Dr . Matthias St . Pierre" <Matthias.St.Pierre@ncp-e.com>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v2 1/2] blame: Describe default output format
Date:   Wed, 29 Sep 2021 19:49:34 +0700
Message-Id: <20210929124935.41917-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210929124935.41917-1-bagasdotme@gmail.com>
References: <20210929124935.41917-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While there is descriptions for porcelain and incremental output
formats, the default format isn't described. Describe that format for
the sake of completeness.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/git-blame.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index 3bf5d5d8b4..284aa99942 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -93,6 +93,18 @@ include::blame-options.txt[]
 	is used for a caret to mark the boundary commit.
 
 
+THE DEFAULT FORMAT
+------------------
+
+When neither `--porcelain` nor `--incremental` option is specified,
+`git blame` will output inline annotation for each line with:
+
+- abbreviated SHA-1 of the commit the line is attributed to;
+- author name (or author email if `-e` or `--show-email` is specified);
+- author date; and
+- line number
+
+
 THE PORCELAIN FORMAT
 --------------------
 
-- 
An old man doll... just what I always wanted! - Clara

