Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8244CC33CB6
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 08:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 589952087E
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 08:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rq4MAzdo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731158AbgAPIdM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 03:33:12 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40592 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgAPIdL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 03:33:11 -0500
Received: by mail-wm1-f67.google.com with SMTP id t14so2765045wmi.5
        for <git@vger.kernel.org>; Thu, 16 Jan 2020 00:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5APZvFH6yPRiygwE8RG2GnxJOUWt8BfnjFwWKpJfHeg=;
        b=Rq4MAzdonhpRc94y98BK2OIbCFM32SalwiGd9tzXfkG9Rt1JZnPFtyuC+pxMssMEnN
         4vrngWzepiKmASHuyMWWOTDIG1LOcp825h5fSCo9w3VqhRUDVE57/rMQC1YzFLAPB3cp
         xHU56FR+xNMs1z07+fT5wVQodhy4/cxz6fxx2j329GfnYzQivzxuORWu7sJgmHJIYBa0
         6w7GsT+Kp2sMxTBd4Xzv/74DIG56wRXFSkksyPML1zjyY3saG8SFRDU66nlSHqSrWa9F
         0vIr4AafOY6wKfm2qoBsL+8p4sQiIp683qNLxIH4s8tl+tqfN3zlh7TRDNV3PkPPtMlv
         HyhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5APZvFH6yPRiygwE8RG2GnxJOUWt8BfnjFwWKpJfHeg=;
        b=S3YNBLL7SLvy2rYj4r6LqLfT9ST7qpsnMLTjCWLaQiJ+TuUynhdWcTpl8XyaDyUSqy
         RbPjZb7AIc33JWKPpe+S4jzIGxFV7LzeM7O+PivaoXtbtjuEXhiqZQb9uCWRKRFGkXmO
         m2TK1fQxaVtYYDA5hEF5q0w27HywLYbW7k8X5wFbxOTn87BryLcmyEJbc+91poR1NpcD
         fbvbOAkJjWct4dk7yog7Y0cq0mRohmdx+Uyw8EG/cCCID8VC1OTImNcnlcIU0u8nLUeU
         s/zvctXJJfGoQkbHLlw1m4YR5NBKc5YFzVRcA6zdegTJ4NtQJxQdVHayLYIQmThQoMD7
         bzTg==
X-Gm-Message-State: APjAAAWi6YkUkjqEfLCwiHp8n7Ff4L3E07XLqRvb/ihNZ/8oqwANpKU2
        avyACUrcm8oe+dEh1UTZYLQM8C1g
X-Google-Smtp-Source: APXvYqy7RKm0/Vhpvfnx8uzeyesrWr/6RgUYzePpD2RIrQ3JVcjof7LX21OT+DhD5TsMb/sHp53/9w==
X-Received: by 2002:a1c:4c10:: with SMTP id z16mr5050639wmf.136.1579163589403;
        Thu, 16 Jan 2020 00:33:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b16sm29460916wrj.23.2020.01.16.00.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 00:33:09 -0800 (PST)
Message-Id: <353c748838d341bb325149234657c27215a9fab3.1579163587.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.528.git.1579163587.gitgitgadget@gmail.com>
References: <pull.528.git.1579163587.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Jan 2020 08:33:06 +0000
Subject: [PATCH 1/2] built-in add -i: do not try to `patch`/`diff` an empty
 list of files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When the user does not select any files to `patch` or `diff`, there is
no need to call `run_add_p()` on them.

Even worse: we _have_ to avoid calling `parse_pathspec()` with an empty
list because that would trigger this error:

	BUG: pathspec.c:557: PATHSPEC_PREFER_CWD requires arguments

So let's avoid doing any work on a list of files that is empty anyway.

This fixes https://github.com/git-for-windows/git/issues/2466.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index f395d54c08..14d4688c26 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -915,7 +915,7 @@ static int run_patch(struct add_i_state *s, const struct pathspec *ps,
 
 	opts->prompt = N_("Patch update");
 	count = list_and_choose(s, files, opts);
-	if (count >= 0) {
+	if (count > 0) {
 		struct argv_array args = ARGV_ARRAY_INIT;
 
 		argv_array_pushl(&args, "git", "add--interactive", "--patch",
@@ -953,7 +953,7 @@ static int run_diff(struct add_i_state *s, const struct pathspec *ps,
 	opts->flags = IMMEDIATE;
 	count = list_and_choose(s, files, opts);
 	opts->flags = 0;
-	if (count >= 0) {
+	if (count > 0) {
 		struct argv_array args = ARGV_ARRAY_INIT;
 
 		argv_array_pushl(&args, "git", "diff", "-p", "--cached",
-- 
gitgitgadget

