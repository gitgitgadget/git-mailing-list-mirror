Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA92C433F5
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 23:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242381AbhL3XgV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 18:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242359AbhL3XgQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 18:36:16 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF23C06173F
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 15:36:16 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id n10-20020a7bc5ca000000b00345c520d38eso14006838wmk.1
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 15:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3DjTSuxoeCeG9xk74b8MP4D3yFu5DTvO02bZbX9rQ60=;
        b=H3Pi5AsPdU+txc1lD2o6fzItr2WLiuYsqjSKJ2ACQ8iD8bWPPkfpCYTa92ylI+eiba
         6sByyNE+L3Mi/Px/YLZrMzscOcB5mZg10L5UydAcYnxdqysY/MwCB4AGEB6s7nHf4FQN
         I6ErCL2F6WjEaUbADEEetZ0/z1W2w29danjkO23n647EA76VunidxkhSPAejC5kAgmvb
         kAXdf8Ksdbzq2Ox0D0tBLJQQ4AJwV9poL0f/if53SAdDU9jKMK2kwlCA7AkRqho2F2iw
         K1+DhhwucY++CCYMwHamqrHuBt8ki2+YeWQDtBZ6kJdRqUDRlh+xFsMYMxikwK6gxtuI
         53WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3DjTSuxoeCeG9xk74b8MP4D3yFu5DTvO02bZbX9rQ60=;
        b=Alptwtqjk+kxnux3EtBg0wzXSmprJaFJ3tCbCGzkjAuIAbTzToTJ1B17FUvOy6fmLW
         JU2pDzIuNpwZLQIxgc3vLa5XElimsMx6jHO/EiP4K5sIWyB+CMnou2yamJnlkV2uawYk
         PPeqdP4z6V9HJza6g378KSi2cEmoccyF9cfKb9MX7jDbN7AsbagICF1fIdwQOzGlKRkA
         4SCp8aGjW8GBb1bQw4FD8bodAmM+oifXsqNsBELKI3YGSf5T9TGwlytdgeUAvX22aGP/
         vpltSug41EIAylnoYFoO4eLf5jv3Qt+RyvlpEBFNIjb0R/xmMxmYim7drHIAhdebNNqD
         XUxw==
X-Gm-Message-State: AOAM530RphVnFJZImyh4eW26khNlSevYQJhdqH6JpMSGqZjFYJGgt7jf
        P6ZWWVnBsXzfP5TS3PvdEv9fz8DMtkg=
X-Google-Smtp-Source: ABdhPJydGezqkUWSe5W06GoUGkrQ6NG88uIVx3Kq2OVG2/dDHx33z/et1J131WRlKLtcBM2mu1X38g==
X-Received: by 2002:a05:600c:190b:: with SMTP id j11mr27120298wmq.182.1640907374784;
        Thu, 30 Dec 2021 15:36:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 1sm17901530wrb.13.2021.12.30.15.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 15:36:14 -0800 (PST)
Message-Id: <4d1848c8a29b9cbbc62f9f928f94f0cf931106e1.1640907369.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1103.v3.git.1640907369.gitgitgadget@gmail.com>
References: <pull.1103.v2.git.1640419159.gitgitgadget@gmail.com>
        <pull.1103.v3.git.1640907369.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Dec 2021 23:36:05 +0000
Subject: [PATCH v3 5/9] merge-ort: mark a few more conflict messages as
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

