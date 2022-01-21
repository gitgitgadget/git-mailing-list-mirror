Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55769C433F5
	for <git@archiver.kernel.org>; Fri, 21 Jan 2022 19:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbiAUTMn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jan 2022 14:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbiAUTMh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jan 2022 14:12:37 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDFAC061749
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 11:12:32 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ba4so1402496wrb.4
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 11:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rB1GXXgaPG4nqGNrl25zZ0WJDHbu4Z/7BmEvF3+puqs=;
        b=Netui/c1wW9OvewIOxyTIs8oXoryw5Bo7gYC0Yt9SNQjCPes0CwDaTYiqMboqTqKFI
         LSEw3EBcJi9sgZUMOzmDHj4WYxgssK5lfWo7/ffktMPqo+w0gxBUYlSrQxItXdeZF4Gm
         MtcD3ZQ5E6x1D5/lzBHU/HLivBzRrXsXl9fuw36jn8JWxfkKf4WQ6G8Hq9ZBa+PW6k0c
         jhQyMPpjpqvhogRy5ujjClu4a4AND+lhBeJP6MTW17FzzCQlQM7pwgQgEyHRECeHEbHW
         f1JAlJPu3m4CG3LpkK3xDjUT5561b4pJsQqgW1LRagwqqM+N7Hh+RHVDIwu31Xg7SgpR
         WWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rB1GXXgaPG4nqGNrl25zZ0WJDHbu4Z/7BmEvF3+puqs=;
        b=zE9VPrTDuWXe0QhAX2lll4kSw1M2LXFOVAHq3xgpIJVi7eztBGqUYOp5djNDcedXEp
         bvPIlFX8TPKRq+tudd8hHIc94OIAMFa2C7wiaSPft0SbJLMMhJBkt3H6ups/QHK2xJLl
         rYluIszTl6r9qeUD76KL3NcDJxSHfE/k5WO1MpflMsg2W5W+H9q0Q9ue+e1EoOKobj6k
         rPLLuH3EwkTrrCfR4DQT8ZdSfXPBKpj93mxiYG5HeNXh4t/ErLRB2Xcq0DqVu2PBvhqP
         tFtG8UzghZLzzoVYCuWjR4dZhDpWDbix55YZa3KDFPd5V245ZUUODNZQXicKtGkMb9+e
         Bmlg==
X-Gm-Message-State: AOAM532D9QD5I5q+1WCp4bosxq2eUr1KmaGpGKLjtkuATPEdWejC0FSS
        UGjatpzlTcJQZ7urEXi2NuKCcVsfy+Q=
X-Google-Smtp-Source: ABdhPJyeYSHVKTjMjdcVu2P0rSBIRXBwhVUBW2pMBuMc5WKRJMprt7HI424l2uBCsD2FX/ara+auHA==
X-Received: by 2002:a05:6000:1686:: with SMTP id y6mr5019950wrd.205.1642792351307;
        Fri, 21 Jan 2022 11:12:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z23sm5591990wmk.46.2022.01.21.11.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 11:12:30 -0800 (PST)
Message-Id: <b3e7656cfc6eee19c0868b94d69db0d7b622aedc.1642792341.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1103.v4.git.1642792341.gitgitgadget@gmail.com>
References: <pull.1103.v3.git.1640907369.gitgitgadget@gmail.com>
        <pull.1103.v4.git.1642792341.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Jan 2022 19:12:19 +0000
Subject: [PATCH v4 09/10] merge-ort: mark conflict/warning messages from inner
 merges as omittable
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Neeraj Singh <nksingh85@gmail.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

A recursive merge involves merging the merge bases of the two branches
being merged.  Such an inner merge can itself generate conflict notices.
While such notices may be useful when initially trying to create a
merge, they seem to just be noise when investigating merges later with
--remerge-diff.  (Especially when both sides of the outer merge resolved
the conflict the same way leading to no overall conflict.)  Remove them.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 43f980d2586..9bf15a01db8 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -638,7 +638,9 @@ static void path_msg(struct merge_options *opt,
 	struct strbuf tmp = STRBUF_INIT;
 
 	if (opt->record_conflict_msgs_as_headers && omittable_hint)
-		return; /* Do not record mere hints in tree */
+		return; /* Do not record mere hints in headers */
+	if (opt->record_conflict_msgs_as_headers && opt->priv->call_depth)
+		return; /* Do not record inner merge issues in headers */
 	sb = strmap_get(&opt->priv->output, path);
 	if (!sb) {
 		sb = xmalloc(sizeof(*sb));
-- 
gitgitgadget

