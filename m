Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D13C433E7
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 05:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA9C920878
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 05:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qvFuZzHW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbgJMF3H (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 01:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbgJMF3H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 01:29:07 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDEEC0613D0
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 22:29:05 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id f126so14191746qke.17
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 22:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=w1/djMaAlBOLKFz4RJVceoVb6tr7igDRVKi9QqaSCQQ=;
        b=qvFuZzHWeZp3X9lag5vbdoIn3dV1jd5rhjWYpWAYOGVWtXoA5mw37zH5/mswgQxkcm
         BQu1nmb0mc6VVrWbfZ+Kcg/uXDGOl+bdwZ8cVrffSxu5OyyvGkIaKsXac2lDYSEoiCXT
         JvxmVr+O9gCJ8VH8+QLCLMA/EjPu/9OxrT4MhWBNKbfwz5Yzhp8HVrbgqgeg9xi6buOK
         olR3aM41xy4WkZgP9BUFcPXcqEbWMRtBoc42nQU/ATwLBCLN0iEaDCF05pn5LmQlVnwu
         u5UlKHrkDunjaE2vNvHb2J4WVX853Cy9Q7zRZFFDu9qHXjiA5A8uin1mkJUCDKLlGb3W
         kyZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=w1/djMaAlBOLKFz4RJVceoVb6tr7igDRVKi9QqaSCQQ=;
        b=lR8Ezxt25PAl3m5druPL/bik58vkT1Y4RmMsuziqu4zOBq1lTL9jTmfVMm91oRtlDH
         tJo02NDnvwp8w6nB4EguOcCrPKkYFbhiXONDSX8Ih0u+tEFKLhvyBKhRcTvmDbeycDWp
         F9Pqn5MaGGZjIDWzVFdh5aRJULBPokyLnVmtT3gSIAlTvm5u+UrMKz024KmrXt5Grvz9
         AdW0FynIlMvIEqExDI2gdR1NPS0LGwes7Q8T31C3DaFh73S1AQabDSgcfLh5Lo6LoSdW
         qmcEiOW4vh8pwiSgfjJo10eOT7tItymPRWFMJBGMFPzubUVktE/jN3vumuYZcNsK9fC4
         qR8Q==
X-Gm-Message-State: AOAM531bKbigCp1TY3POCkFjnbQdpGudm8wwXXxyx/swazNt2cqG8Q9G
        1dcsP6FpbJj+EShu4aaet8kfhtphd6+WtPoJzWr5f//g6TmXvC77rI5pK4XuR5VgT2MRLlUOdAk
        BqBREc5P3Kz6S0RKXY2IxVEPZBeOA8IWLgVfvDK//oKa+hr4i6bm4jmyMven6
X-Google-Smtp-Source: ABdhPJxO4hiiAeERwzQdeofE6YK9g5Kr74+vAfcD9iVuhOgYAt7gz6mB4ItCo8rLgVe711kc69KQlFeJS0HY
Sender: "shengfa via sendgmr" <shengfa@lins.c.googlers.com>
X-Received: from lins.c.googlers.com ([fda3:e722:ac3:10:2b:ff92:c0a8:cb])
 (user=shengfa job=sendgmr) by 2002:a0c:8e0d:: with SMTP id
 v13mr26162129qvb.51.1602566944333; Mon, 12 Oct 2020 22:29:04 -0700 (PDT)
Date:   Tue, 13 Oct 2020 05:28:49 +0000
In-Reply-To: <CAEOYnAQYMrNAe9s1V-0DVLdL-B_KpHMDP5e=yRnbCkMWdrvFHQ@mail.gmail.com>
Message-Id: <20201013052851.373029-1-shengfa@google.com>
Mime-Version: 1.0
References: <CAEOYnAQYMrNAe9s1V-0DVLdL-B_KpHMDP5e=yRnbCkMWdrvFHQ@mail.gmail.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [WIP v2 0/2] experiment with commit option record-time-zone
From:   Shengfa Lin <shengfa@google.com>
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, gitster@pobox.com,
        jrnieder@gmail.com, nathaniel@google.com, rsbecker@nexbridge.com,
        santiago@nyu.edu, shengfa@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My current understanding is that we should start with providing command
options first and if they prove to be useful, we can progress with
config such as user.recordTimeZone. Also, we wanted to save the
timestamp as -0000 when user specify not to record time zone so to
distinguish with +0000(user from UTC time zone).

Experimenting to support command option --[no-]record-time-zone, currently only
added for commit command; the plan is to add it to other time zone
recording command such as rebase, pull and merge. Documentation change
is also missing.

I added three tests where the first two are failing. I am not sure why
they are failing. I am guessing the datestamp method is not called when
specifying the date or GIT_AUTHOR_DATE. Also, I am not sure the correct
handling of all the show_date calls yet. Anyway, I wanted to share WIP
before delaying longer.


Shengfa Lin (2):
  Adding a record-time-zone command option for commit
  Demonstrate failing and passing tests

 builtin/am.c            |  2 +-
 builtin/blame.c         |  4 +-
 builtin/commit.c        |  3 +-
 builtin/fast-import.c   |  2 +-
 builtin/show-branch.c   |  2 +-
 builtin/tag.c           |  2 +-
 cache.h                 | 10 +++--
 date.c                  | 96 ++++++++++++++++++++++++++++-------------
 http-backend.c          |  2 +-
 pretty.c                |  6 ++-
 ref-filter.c            |  2 +-
 reflog-walk.c           |  2 +-
 refs.c                  |  6 ++-
 sha1-name.c             |  2 +-
 t/helper/test-date.c    |  8 ++--
 t/t7514-commit-patch.sh | 28 ++++++++++++
 16 files changed, 126 insertions(+), 51 deletions(-)

-- 
2.28.0.1011.ga647a8990f-goog

