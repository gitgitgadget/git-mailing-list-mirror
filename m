Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AEAC2BB1D
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 17:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ABE120936
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 17:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJPgovI0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgDJRvi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 13:51:38 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36325 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgDJRvi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 13:51:38 -0400
Received: by mail-ed1-f67.google.com with SMTP id i7so3333537edq.3
        for <git@vger.kernel.org>; Fri, 10 Apr 2020 10:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2Z3XW4K5cHxnKvZ3zQyJmnYmdWXncIi0KiqB61H/bn8=;
        b=CJPgovI0P34MxuWPCrarc2+4GkFIne6FblbdOVzB7xMhlzpzBbbkIBUoDLUw65XzgM
         nYiCuULyZXFk89pdEeRJYc/oupdvF+0mPTKD0+2kvu230FhxUwY8b3bqfXX1iuS0OJ7T
         L03Ap7CUE8OXH8KRNu+9yaoHh+Hl0QIxE+tbcbUuWWLl/0K49O/v8scce2I2/GcdCQrr
         wZsQyEI+DtGirM7y1csMvZ1Q0fWZwXGNmismmUxi6pXhIPjcOhlIiCl12EhjzCTwJFK4
         aqKhL0YIPG7W83SiRBkIgZ4PRXMGkT0tt0O5HCb83JVhI6bKtMvRoiFRiEzdRTZhGoaH
         AeYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2Z3XW4K5cHxnKvZ3zQyJmnYmdWXncIi0KiqB61H/bn8=;
        b=Kq2eS4y/SzxnDcoCTMN/HwtMES9i6Y6Un9jjNmF971sQ0C8j32nx/APSo63KOZRvPD
         Jq0VSpizyT9rLEv8iWKyNt3CTwbgL93Xaeqa3+JJCt91bny3vJn+dx4ctR79Jdj8pYUf
         PhBuysARYiFqa9cpDsHGPRXRBsrZ+rIpqWwE0SUmF4tOx5RQ9YWo03apvy7wtywR7co+
         leF+sr2xSR4NWMz95Bbj0+TvdLxy3lHdEJpWI0/Q9R8IYHjf8pKD2zfxLS31GlrNmKI2
         +2vWNv9owLXkjKEvc97vNlfGhjX9uxZV9DOPwwH2fshsiJ293bBUuMyw7wZ6PINHdFlB
         C8TA==
X-Gm-Message-State: AGi0PubpwWFPzHSpNghJnwCfSG8cxlS1JpnTdaio6WjsEoA2MFQ3LsAl
        uB4gylDX2PUljGMcFiJsYYRhhhjP
X-Google-Smtp-Source: APiQypI1mrLmPwp5Tzsf6stBXL2H2+YDYMyQiDRuMrVc+Dk6U5CzKBaqqCaYEfMXxm3nQAuMovP+Yw==
X-Received: by 2002:a17:907:a89:: with SMTP id by9mr1512127ejc.289.1586541095365;
        Fri, 10 Apr 2020 10:51:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a24sm181779ejy.38.2020.04.10.10.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 10:51:34 -0700 (PDT)
Message-Id: <pull.757.v2.git.git.1586541094.gitgitgadget@gmail.com>
In-Reply-To: <pull.757.git.git.1586474800276.gitgitgadget@gmail.com>
References: <pull.757.git.git.1586474800276.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Apr 2020 17:51:31 +0000
Subject: [PATCH v2 0/3] rebase -i: mark commits that begin empty in todo editor
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de,
        bturner@atlassian.com, sami@boukortt.com,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v1:

 * Resurrect --no-keep-empty (for commits which begin empty), which can be
   used orthogonally to --empty (for commits which become empty). Docs
   updated as well
 * Add a commit improving the error message for --apply being used with
   non-apply arguments

I wanted to base this commit on jt/rebase-allow-duplicate, in particular to
add a patch moving his new --[no-]keep-cherry-picks arguments to be close to
the --empty={drop,keep,ask} and --[no-]keep-empty flags, since all three are
related. But unfortunately that series was based on 2.25, and my series
needs to be based on 2.26. So, for now, I'm just keeping the two series
independent and will submit a fixup patch after these two are both merged
down to move all the arguments near each other.

Elijah Newren (3):
  rebase -i: mark commits that begin empty in todo editor
  rebase: reinstate --no-keep-empty
  rebase: fix an incompatible-options error message

 Documentation/git-rebase.txt      | 36 +++++++++++++++++--------------
 builtin/rebase.c                  | 17 +++++++++------
 sequencer.c                       | 11 ++++++++++
 sequencer.h                       |  2 +-
 t/t3421-rebase-topology-linear.sh | 10 ++++-----
 t/t3424-rebase-empty.sh           | 36 +++++++++++++++++++++++++++++++
 6 files changed, 82 insertions(+), 30 deletions(-)


base-commit: 274b9cc25322d9ee79aa8e6d4e86f0ffe5ced925
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-757%2Fnewren%2Frebase-mark-empty-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-757/newren/rebase-mark-empty-v2
Pull-Request: https://github.com/git/git/pull/757

Range-diff vs v1:

 1:  0d94eea376a = 1:  0d94eea376a rebase -i: mark commits that begin empty in todo editor
 -:  ----------- > 2:  e15c599c874 rebase: reinstate --no-keep-empty
 -:  ----------- > 3:  ee5e42361fc rebase: fix an incompatible-options error message

-- 
gitgitgadget
