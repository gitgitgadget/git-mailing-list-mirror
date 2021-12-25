Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBE3C433FE
	for <git@archiver.kernel.org>; Sat, 25 Dec 2021 07:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbhLYH7g (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Dec 2021 02:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbhLYH71 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Dec 2021 02:59:27 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503D1C061401
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 23:59:27 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id i22so21276093wrb.13
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 23:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3DjTSuxoeCeG9xk74b8MP4D3yFu5DTvO02bZbX9rQ60=;
        b=QspfHbKhUMxoU70N47+LSVMZ4E0ILssGM4HqLxkqxsO4K78c76zpE+u8TpPOZskn7Z
         Fxh7VmfNVG9z85qNJO95UsZpDaxVQpezM0pg5SeIeFRotRQtFW1rW/tCqcFEjktI4lhd
         TCqbVJrhm2/ydfZlN/nqzlCMwIMrXVs1eS4GszmvSa73ibq5FvW/K/CNYq9oEYozBVia
         x3UYVucW7ErWa7wa2c5deevu9onZTQxrzz2Kbsf1CCBmoFPhEwSCXQSyaosqXn1v4haX
         FT7PbVmBC5am0E73dmhxclWsxj+CWtMycDk2xS1CD9uPPIFeBwq3VKbmcuSQsGUytp9R
         DYEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3DjTSuxoeCeG9xk74b8MP4D3yFu5DTvO02bZbX9rQ60=;
        b=rRx1yzvSjagRRPoi1e1A3f8n0we1JZ2ABANpi/4SP+Dwu2Fi7bSD0VlF0fXs6ZmSup
         /j87wsMnfDk2Rmq8iFCAu1ba8rZIBlAhhHuLxxxQFCNszaDS/bhDK5iNCjoJuPDx5Ztg
         QAMkOLGTp9TDJm7jponBv58/7uu2s+9Sa4bZpZc2NMcFQl3GF4nhS5HtH/MqeJWGWXQA
         q9ZlJ0qj/FcegC/gvS+0KSeUN+ScQaRL2AUZpV6JhNmQyGUS05x1rJvpHCLrFAAe6gfi
         RP4hK2b9pF8Z/lmfd3NnAcoPyFE9D0yxdX0p1+/NLfVh5P/OIPZShtQZxgkH5mRsoqUX
         EyFg==
X-Gm-Message-State: AOAM531VYVlUfSydNp24Mn2gY2tg/shrrU5tZmv3FXpRLpdluZFaCeDH
        aJR2jLLvI5bECdy2BSJvWwXGbVJfdIo=
X-Google-Smtp-Source: ABdhPJy3G8GD7MCXn8Pej0VyAz4Gl+rcw6OF2ttXkozCGFRyNUSRm1pJRmpc52vJGw4xlCn7kPLFzQ==
X-Received: by 2002:a05:6000:156b:: with SMTP id 11mr6683097wrz.261.1640419165779;
        Fri, 24 Dec 2021 23:59:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o14sm9545372wms.4.2021.12.24.23.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Dec 2021 23:59:25 -0800 (PST)
Message-Id: <000933c5d7ffe3431b141ba3c9947ba62fab278d.1640419160.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1103.v2.git.1640419159.gitgitgadget@gmail.com>
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
        <pull.1103.v2.git.1640419159.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 25 Dec 2021 07:59:16 +0000
Subject: [PATCH v2 5/8] merge-ort: mark a few more conflict messages as
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

