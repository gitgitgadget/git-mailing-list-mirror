Return-Path: <SRS0=b7P8=2X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F413C2D0DE
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 02:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3346520848
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 02:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJyWx08W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbgABCtv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jan 2020 21:49:51 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35110 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbgABCtu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jan 2020 21:49:50 -0500
Received: by mail-ed1-f66.google.com with SMTP id f8so38032590edv.2
        for <git@vger.kernel.org>; Wed, 01 Jan 2020 18:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=5CuPPFi9AksWwFh01uOmZsz3VRoA1ojvz4bl5Yrw1r4=;
        b=UJyWx08W87UO+scXK/DMrKoT2hIZtfqCD/DAeg6D0M26iC1BNIZRMC4SguuRdyBNbx
         gv5fhhoTwvMEWvYsGYuRlGAsfeFr5MuumE+Oz3b5YhxNP7/yFNa4Exq2IMGKXr5UXiQF
         /1OCjbspUPCKbCpAkXUywdFNnqxoLYtSsVufcxZ76wntuGRBnjnt/DgXa+PxJS4lxdaq
         mqkY3sZmUELpBkSkkG8YAjd6b8APwbGfo6e15eajSOUBWysvZQwppXnAdsSmXNfo4k/i
         6/EoYLWg8sT1QKcPFLGUU7U+Z7eAY1CPHU1rJqeg95kUgK5g8zWiXVoQl23UzHrpBKkS
         XDmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5CuPPFi9AksWwFh01uOmZsz3VRoA1ojvz4bl5Yrw1r4=;
        b=k4K4afvPLQGevc/Ah2dDZYxY7gTOkm7b1IO87WbyUnqnQQXvc6q+3TidimOSd4W/VT
         XUzvhthwX52o9HBvLf+Ae6bNmH6aDE29duwMjHge2hlqby3+LzBtQ0uzEkYqWJ7ovlCs
         g8zb66gwMMNZ8SM8oUJAXf7mn37XEfrXRM783CLPfebYiS5t7mDl72zB7dsgv/ZwCWJm
         Mv7PFuTmRYmEiK788FBvT+eNuF9T/qvFOqdBueHzD+1BmHDoHS9XZJLnjuNKoV4FZFtt
         T5yx+VwDz+HrVbA9Xp0UjV7kPi91DZ6LocGy9+HHD1DNragiNiVN8Te8aacgTlLnfrnp
         gewA==
X-Gm-Message-State: APjAAAVdK/gVsdO0rgZhGtENi0eHyDCNY/jwYZSbd4Y17Pi4uCqhZqDN
        fs9MPbSxiM8VZnQ4f0Wc92g0A7Iu
X-Google-Smtp-Source: APXvYqz9VLKan5ZFaWC9blLMGFLSdOsJtA5N/EbJ3tHIqoSGWvD9u3f+dU8OegzcRpLYgegyWpS7Bw==
X-Received: by 2002:a17:906:f1c2:: with SMTP id gx2mr84423195ejb.135.1577933389021;
        Wed, 01 Jan 2020 18:49:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h5sm7164355ejt.91.2020.01.01.18.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 18:49:48 -0800 (PST)
Message-Id: <pull.507.git.1577933387.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 02 Jan 2020 02:49:46 +0000
Subject: [PATCH 0/1] [Outreachy] [RFC] branch: advise the user to checkout a different branch
 before deleting
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a user attempts to delete a checked out branch, an error message is
displayed saying: "error: Cannot delete branch checked out at ". This patch
suggests displaying a hint after the error message advising the user to
checkout another branch first using "git checkout ".

Heba Waly (1):
  branch: advise the user to checkout a different branch before deleting

 builtin/branch.c  | 2 ++
 t/t3200-branch.sh | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)


base-commit: 0a76bd7381ec0dbb7c43776eb6d1ac906bca29e6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-507%2FHebaWaly%2Fdelete_branch_hint-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-507/HebaWaly/delete_branch_hint-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/507
-- 
gitgitgadget
