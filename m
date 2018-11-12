Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCBC11F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 20:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730445AbeKMGtp (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 01:49:45 -0500
Received: from mail-pg1-f172.google.com ([209.85.215.172]:41182 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbeKMGtp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 01:49:45 -0500
Received: by mail-pg1-f172.google.com with SMTP id 70so4583240pgh.8
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 12:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=r7UfXnK2rFN4auyQSCd7N1bf8j9wKVW7DrYsJaglRyY=;
        b=Z4wYalpRlyk8bY9YQlT2qXJ7lKn5q5M6lbxum/7EVQy5Tos3rJG8NIoFJd0vWuRy4W
         GZkA3ZTWEcjZ4DNA9xvQm5gZiqDRqruoxVCtZjE3z80Ere1xvALYsbBkGrhqjgPi1CtE
         B2EV5UVbh0Y03yMbLemr9NTzPkA9oviBcsLXz3Tf3hCNRH9wcTY5FRTmRh+93fJcLfPl
         J529NVgrNUY6U66CRM0cj4399AJrlr3P6kNoumtBrdUSkfm0HtvLy7cmDN46mmKwBtQ3
         X8tEmCIuPWBgb8/O2juBbBhkbKrY7yZ74iROv0xC8Dtyod2REgqCGlEQhEQWOqJbFJXF
         V//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=r7UfXnK2rFN4auyQSCd7N1bf8j9wKVW7DrYsJaglRyY=;
        b=iAVlmLdYaDNY031lml8xLWpOGElF8gkdwtEG6Ng2/MwjY3+XrbB59ydIzBsktjHN+M
         FW+rnwXGO7mkO9mCZ/97Xh9e/b9/Orw5uXU4PIMQMsf88mED7brVqij8y+os1vQxerLw
         pCDJhx9JxT9EDHY/Tuhq1zdF9CqCJkRBBwkoUZ23ToRnn8LdiifT7O6n0eug86QMd8+m
         GjDJAIRluaxqtfn1JQpONCw7EEC3Q4LZHtcOLjqM/TyylvaFRzzwr8BpMXFEEzIxO+3T
         iBDFdbAuvftmu3O7TbrrQUuFXvUjdJmRd1u6g5827tgNH/Kp0BsgbnweIj0dU7ikvfkh
         7Xpw==
X-Gm-Message-State: AGRZ1gIvfxujp60lmCd2DK4vv5K5Ba1MvdfAdLgFhLR6WjKCgldgT/NQ
        mDqSyXceQ6qu2mqIWupmwJYBZYji
X-Google-Smtp-Source: AJdET5c5PCgqgoul8/FLST/kPBgfv0bg9pKW1X7QvPJsub/dhl1bPOfEVR+HwYI5i8cnbbT+W4gE4Q==
X-Received: by 2002:a62:d452:: with SMTP id u18-v6mr2352875pfl.32.1542056088405;
        Mon, 12 Nov 2018 12:54:48 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id z191sm22517432pgd.74.2018.11.12.12.54.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 12:54:47 -0800 (PST)
Date:   Mon, 12 Nov 2018 12:54:47 -0800 (PST)
X-Google-Original-Date: Mon, 12 Nov 2018 20:54:44 GMT
Message-Id: <pull.74.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Allow "no-op hunks" when editing the diff in git add -e
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I use git add -e frequently. Often there are multiple hunks and I end up
deleting the + lines and converting the - lines to context lines, as I like
to stage massive changes in an incremental fashion (and commit those staged
changes incrementally, too).

Some time after I invented git add -e, this feature was broken, and I had to
start identifying and deleting those hunks with no changes.

I finally got around to find the regression, and to fix it. Here is the
outcome of this effort.

Johannes Schindelin (1):
  apply --recount: allow "no-op hunks"

 apply.c                |  2 +-
 t/t4136-apply-check.sh | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)


base-commit: 8858448bb49332d353febc078ce4a3abcc962efe
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-74%2Fdscho%2Fapply-recount-empty-hunk-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-74/dscho/apply-recount-empty-hunk-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/74
-- 
gitgitgadget
