Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3027C4361B
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 04:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A710F23108
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 04:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbgLFEEP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 23:04:15 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37135 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgLFEEJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 23:04:09 -0500
Received: by mail-ed1-f67.google.com with SMTP id cm17so10075704edb.4
        for <git@vger.kernel.org>; Sat, 05 Dec 2020 20:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8vNm8C8pY+aniB0sfkO16uA6z6S5hZqeOass5olf65c=;
        b=sQ+rf4VpByQ3vs07bkzz1slUTXPyJahBKdvAHmDPBNK8kjbK8fvrqvHL82c5L1BMLa
         WCwbFBdWqS0cBJdvPtN8o2bCKP/fUm/J29Wny+1RE7lJUpNl/JFAcyhY630y+zzZv6sr
         7ZCdi3EUyDHDnBVYxYSdJte7WSLS2MJfxCfQS8J1gzD88nK11XG4TA+pi01ZYgS5AgrE
         XVZxmZzDe2I5cZJBnYkmdbvT1fat+SjlDKGb5Ks5fuP+haCsw4pMl3h+NFcTbRyWA1YL
         sCDk5u43L6CvLOX0seBd4c5jPAnBETWQgjgrBx1Z16jU4q7j9DMxxMLXyWy+JtgOmAsB
         DYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8vNm8C8pY+aniB0sfkO16uA6z6S5hZqeOass5olf65c=;
        b=KpEMKQREOIgpFxYjvuY+FLoFel1tX3r3yPLwTGh+IOZGSO9VranFbkB6d6eBFyjdJL
         c7QbveAZDMRWtmCkvFWSzpbhxMA87YZM/eooYF/QQFlRbZ8ijs1U9U3RQEKm9TufTFF7
         cJ34mM+CAXsAkCEtgQFUil+A2nQZyyxg509JV4p7b1xhs/YODSvX6bacZctKG2Cy031P
         vPW4PToGL2cUrRg9gqCoQs50bybDzmWQKqMVwHLDPDSz0pjFeGJxNIK84xrju6kQ7lmA
         qEueREdnMK+jylqXQEXwiEa4CWQHGwm+Nq9bclyQmAOUEKuTuG7qeaLWo0GlqOYf5+E1
         dT/A==
X-Gm-Message-State: AOAM532IuTvsio0W98d26NLuLrYDr6VwR71yOu1hEFijnFV3lt3yNPWS
        Qigp3iLLpOwN6twPwuosHW4B+6I1vHY=
X-Google-Smtp-Source: ABdhPJwF5O/WYfHiMtR65Xy+ySckTQnPjbBDCtdmvcDiTnLzzeydCurTazdUZqsV5VPDwoOynLHppw==
X-Received: by 2002:a5d:65c8:: with SMTP id e8mr13293281wrw.338.1607223282334;
        Sat, 05 Dec 2020 18:54:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u66sm9046441wmg.2.2020.12.05.18.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 18:54:41 -0800 (PST)
Message-Id: <77ca4656ed442321b41e653505c85d0be31b8045.1607223276.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.929.git.git.1607223276.gitgitgadget@gmail.com>
References: <pull.929.git.git.1607223276.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 06 Dec 2020 02:54:33 +0000
Subject: [PATCH 4/7] diffcore-rename: change a few comments to use 'add'
 instead of 'create'
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

As with the last commit, it feels odd to talk about "creation" (which to
me implies a brand new file, i.e. one not associated with an existing
file, and thus one that could not have been a rename) when we are using
the files to look for renames.  Use the term "addition" instead.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 655a67759c8..7270eb6af48 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -173,7 +173,7 @@ static int estimate_similarity(struct repository *r,
 {
 	/* src points at a file that existed in the original tree (or
 	 * optionally a file in the destination tree) and dst points
-	 * at a newly created file.  They may be quite similar, in which
+	 * at a newly added file.  They may be quite similar, in which
 	 * case we want to say src is renamed to dst or src is copied into
 	 * dst, and then some edit has been applied to dst.
 	 *
@@ -652,9 +652,9 @@ void diffcore_rename(struct diff_options *options)
 		}
 		else if (!DIFF_FILE_VALID(p->one) && DIFF_FILE_VALID(p->two)) {
 			/*
-			 * Creation
+			 * Addition
 			 *
-			 * We would output this create record if it has
+			 * We would output this add record if it has
 			 * not been turned into a rename/copy already.
 			 */
 			struct diff_rename_dst *dst = locate_rename_dst(p->two);
@@ -664,7 +664,7 @@ void diffcore_rename(struct diff_options *options)
 			}
 			else
 				/* no matching rename/copy source, so
-				 * record this as a creation.
+				 * record this as an addition.
 				 */
 				diff_q(&outq, p);
 		}
-- 
gitgitgadget

