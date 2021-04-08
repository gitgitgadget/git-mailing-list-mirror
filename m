Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1A4C433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 23:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C11B6023C
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 23:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbhDHXkC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 19:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhDHXkC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 19:40:02 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C90C061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 16:39:50 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id q14so3541243ybk.22
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 16:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=gm80oqDCm1umLeklStIjVe8uxq7VMKYvoCn903semYs=;
        b=TEGREVwlzmPh5XIX6f+yQHEdO29GlYWnGoAQ/wQtiad+VC8n47x9sl7AfuDsM0Q118
         iJ9Gd9oAbKJc4hUQJ5v4HXMyuexwfbRMcMznnpQ9eBDgnzk2GoI+mT9ga1qZkLk08oL2
         DjwNR5yzvyzRix/+87i8WYEvz5GuiOMm1g0az4Sxk84FFkipEP7aYYWvjLULgsKmn4Cm
         869wUTJT/A5OgP/ek1vs1OQNN7JApu3Hxz+Vr+80GzhFB/Iyg0sXRJ5VBcJACTGEyf8+
         OxHOYHWSTCYbvBXL8bqw5KKBCHcybwGQGCDEe6DLrwZ0lXcxfHiGFuJF0KifJV0FIJv4
         4Mog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=gm80oqDCm1umLeklStIjVe8uxq7VMKYvoCn903semYs=;
        b=WfgArMVY0EpBVt0agTOWBo3byh39dqw8oXuIPbh/vdTDQIH4tldJTPbYCEVKrsiFNE
         xrHcqz8iLlIvwPT263MsglO/8gAWk7bPPmso4qzHQoKSS2k9n5vuCmSxFXgb5ZaW+Fla
         Q0J/1uN77qXV/ZIr7aaVMtQ6hwZ5wl8CTrK9geYiscmFYUHhH8uL+wpejgQHBX1UWhQ2
         Xc87ewnoQXvUQXEUUUlTv9CgUVEpIvsymt7aomlsQrpPV8HlalO6oOnm7hGDoOkdBV00
         8bmmt3hbBPjdudDTv2Cuy2FAHrHnFHQ79NTDMy7hoNSDoTyam7CWkhtm4UbO4JIPfrIY
         um8g==
X-Gm-Message-State: AOAM530tzxxr8v+AzuFCQCBIdRiWdOqI3IQS24AokKFA62T8hyznT3AJ
        wCi6iGOHFEVPESsc0Fe98x3qJKa0Q07Z6bKkGY23XO9YIrd2o6l+G8Mc8GVW6lLRoDDe6GBFgh2
        tVq0klwfg1enfPAQd4capjwf83hQwilFgZk1qt+FFlbRrnoPfvr0C1xPdo1KEtxEO14exxAfIHg
        ==
X-Google-Smtp-Source: ABdhPJxND6ONG028Bq6nmtmmyIwGlJvOv+dgP9iyixS3VIC2SXlL+6Khu7xkkxVUQPToZp6xyHT01CaxYXMOSWJKmJw=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:34d1:6a8d:be3e:615f])
 (user=emilyshaffer job=sendgmr) by 2002:a25:ba87:: with SMTP id
 s7mr14776548ybg.222.1617925189424; Thu, 08 Apr 2021 16:39:49 -0700 (PDT)
Date:   Thu,  8 Apr 2021 16:39:34 -0700
Message-Id: <20210408233936.533342-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [RFC PATCH 0/2] share a config between submodule and superproject
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

Especially after es/config-based-hooks makes its way to 'next' and
'master', we think it would be really useful to have a config that
applies to a whole "project" - where "project" means "superproject and
its submodules." There's a longer defense in patch 2, but that's the
speedy summary.

I'm not wild about the implementation of this solution as it calls out
to 'git rev-parse' and 'git ls-files' - not once, but twice! - and I
understand that is considerably slower on some platforms than others.
But I'm open to suggestions - I couldn't find any other examples of a
repo figuring out whether it's a submodule or not. (I thought there may
be some, as 'repository.submodule_prefix' exists, but it seems like
that's only set in some special cases during operations initated from
the superproject.)

I'm hoping to work on some other submodule-centric stuff over the coming
months, and it might end up being very useful to be able to tell "am I a
submodule?" and "how do I talk to my superproject?" more generally - so
I'm really open to figuring out a better way than this, if folks have
ideas.

Patch 1 is a small refactor that we can take or leave - I found
"SCOPE_SUBMODULE" to be pretty ambiguous, especially since it seems to
refer to configs from .gitmodules. Even though I decided that
"superproject" was a better name than "submodule" I still wasn't super
happy with the ambiguity. But we can drop it if folks don't want to
rename.

Thanks a bunch,
 - Emily

Emily Shaffer (2):
  config: rename "submodule" scope to "gitmodules"
  config: add 'config.superproject' file

 Documentation/git-config.txt   |  21 +++++-
 builtin/config.c               |  10 ++-
 config.c                       |  30 +++++++-
 config.h                       |   5 +-
 submodule-config.c             |   2 +-
 submodule.c                    |  29 ++++++++
 submodule.h                    |   6 ++
 t/t1311-superproject-config.sh | 124 +++++++++++++++++++++++++++++++++
 8 files changed, 220 insertions(+), 7 deletions(-)
 create mode 100755 t/t1311-superproject-config.sh

-- 
2.31.1.295.g9ea45b61b8-goog

