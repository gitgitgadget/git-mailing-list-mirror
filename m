Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECCEC433F5
	for <git@archiver.kernel.org>; Fri, 21 Jan 2022 19:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbiAUTMd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jan 2022 14:12:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbiAUTM3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jan 2022 14:12:29 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18D1C061749
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 11:12:28 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id a13so1409692wrh.9
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 11:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3DjTSuxoeCeG9xk74b8MP4D3yFu5DTvO02bZbX9rQ60=;
        b=gzdQwQXSrCdkQ5dSzCN4tBuKc4+bk6EeIgLboYedKc0OSjoJDz+2VTNvEv0axL5Yb3
         WK0EaQ54IPQRaV2WqmNYMZt/g3z7t/TviMYr7YGgfG/wuPSWFn/ebQ+iWa3XQ+09cU3c
         CNDC7lwfi+OG2cpuz+oCjGdvpggnYkCpY0jaaC6tQ6MuowRiKZ0AkTOL9mPFVV2ULJMq
         ub9cdZnv3av06i7dp9jyBKKnXw8F09L8bP7CzTyk+YoYGuFSRd9R0dGUMN0WFxZjTTDn
         QnPunij+lvK5iiW0TvwP+4D5PhDMI9uRzkD/H1z5z1rTooGL/d+xzK+MKHkRhPvUqJSV
         sshg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3DjTSuxoeCeG9xk74b8MP4D3yFu5DTvO02bZbX9rQ60=;
        b=ritrDx7Adiej3aIucm2b+2BrZOcWh5rF5rC75hER9oZ11fHuV+fOKu+4cBriRxyd4q
         LHb6sx8IBxkXiDVXYLiA1v3Bdr15f8kdIxVm87kjxmtakEDhUFch2o/VRRc3H6qgtXAt
         aPx11VfhZjYrMi0QLoAeR+pqZPTwLk4ljcAvjmkwGMWkMW4Z5Gevn61rC0UIY1tT2W9B
         HHTq9cCq3fn51XfbDJ2NyTp87ycgJQRsylV1B/Bo6nRx+NHhg07r75+0Jzpxt8mgRbrh
         iav+fWc8lVczM3csXudQ8rMznkobC+FhLLDPKCvBuBy45y/AMuPrZyODW0cxKefACq5K
         P+1g==
X-Gm-Message-State: AOAM532gCUNK84EIJzL6hOxfZTmTgJJ6S7gKbhTTorvdE/D2JfkVX0Jd
        2rNBvy29VohN7wBalDK6rU/4W5xAnmo=
X-Google-Smtp-Source: ABdhPJynK0ctyByAJfgIDSu/xry2TRNT183MIQVuC35tvoIP+7iyYponrgg8I7mldBSWKyvfNkAtGg==
X-Received: by 2002:a5d:6da6:: with SMTP id u6mr5000789wrs.563.1642792347272;
        Fri, 21 Jan 2022 11:12:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m6sm7760247wms.34.2022.01.21.11.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 11:12:26 -0800 (PST)
Message-Id: <6b535a4d55a864a0294ed0e881ecd035bd685117.1642792341.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1103.v4.git.1642792341.gitgitgadget@gmail.com>
References: <pull.1103.v3.git.1640907369.gitgitgadget@gmail.com>
        <pull.1103.v4.git.1642792341.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Jan 2022 19:12:15 +0000
Subject: [PATCH v4 05/10] merge-ort: mark a few more conflict messages as
 omittable
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

path_msg() has the ability to mark messages as omittable, designed for
remerge-diff where we'll instead be showing conflict messages as diff
headers for a subsequent diff.  While all these messages are very useful
when trying to create a merge initially, early use with the
--remerge-diff feature (the only user of this omittable conflict message
capability), suggests that the particular messages marked in this commit
are just noise when trying to see what changes users made to create a
merge commit.  Mark them as omittable.

Note that there were already a few messages marked as omittable in
merge-ort when doing a remerge-diff, because the development of
--remerge-diff preceded the upstreaming of merge-ort and I was trying to
ensure merge-ort could handle all the necessary requirements.  See
commit c5a6f65527 ("merge-ort: add modify/delete handling and delayed
output processing", 2020-12-03) for the initial details.  For some
examples of already-marked-as-omittable messages, see either
"Auto-merging <path>" or some of the submodule update hints.  This
commit just adds two more messages that should also be omittable.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index a18f47e23c5..998e92ec593 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2420,7 +2420,7 @@ static void apply_directory_rename_modifications(struct merge_options *opt,
 		 */
 		ci->path_conflict = 1;
 		if (pair->status == 'A')
-			path_msg(opt, new_path, 0,
+			path_msg(opt, new_path, 1,
 				 _("CONFLICT (file location): %s added in %s "
 				   "inside a directory that was renamed in %s, "
 				   "suggesting it should perhaps be moved to "
@@ -2428,7 +2428,7 @@ static void apply_directory_rename_modifications(struct merge_options *opt,
 				 old_path, branch_with_new_path,
 				 branch_with_dir_rename, new_path);
 		else
-			path_msg(opt, new_path, 0,
+			path_msg(opt, new_path, 1,
 				 _("CONFLICT (file location): %s renamed to %s "
 				   "in %s, inside a directory that was renamed "
 				   "in %s, suggesting it should perhaps be "
-- 
gitgitgadget

