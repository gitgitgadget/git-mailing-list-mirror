Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14FC11F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 02:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391129AbfJYCvi (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 22:51:38 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:41579 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732696AbfJYCvi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 22:51:38 -0400
Received: by mail-vk1-f201.google.com with SMTP id g144so231441vkf.8
        for <git@vger.kernel.org>; Thu, 24 Oct 2019 19:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=fd7P/2UlBSi4rrCo7SEvHSnXbnYFlsWpXuKJ5UXDryk=;
        b=Edu8FQKALOlv1peMwnKrwn6vd/oMxRARbkZM8qwPAAB7qVR43ttPB2M/xJEAy+CvSf
         zmMPx3PMiDsKA37a2LBLvrerE/g0C7I4RBevUPRR5F7AaY0qHyuFpKXFiO2Os7HoTrvg
         AQ9kL+li52R90EZK62yrvJ01woVwMIjiExwowGRGHU3vpmNTh5xLAs3LkOwyUnFdBJr/
         kyS2krP6lUWcmmsIcyV3Jw9f1SLA+nUg/CjUDwLs1hsr4cjDYFRr38kVRIzDwrgSxfYO
         031dN8oGHbxxS4Sfj+ZpOvGR2bNWI1OxwluTSzrnlzBdMpPXDJq/p0YfL3PR5s7WN2QQ
         fzug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=fd7P/2UlBSi4rrCo7SEvHSnXbnYFlsWpXuKJ5UXDryk=;
        b=PTbgIdA5ppx3CO16mvWObLJJ54CVKWd3RBkSg6ImBXQ+4Cd+P7zEKmXyktFYzMCoFq
         yvRFXV5opsZxSJPlmAgZRbRt6WyVnclLv36VY52doF0GvKVaNWER8f1uHDjwkNEXAmlw
         tN+zps4XXPvKtUr7aElZwEe2ov8vd2ljxt4xq0TvcrOKb281IG16aRp520o/G7x795Bw
         WMnrRTasydaqF0piHcsU52qDbEVAq45i6311Ot9DImKhpQSoIckOhRBVafHx+TeAl5ip
         1u+uu8eGRz/8ySfDYJjKyvwbPnaL39m/pnx2qo0WlKrwNHILqmR8F1nVkue/zGWF4xep
         Kxug==
X-Gm-Message-State: APjAAAUadHm6wjcJknxRWLPhn3j30skREOsTLyRBp+ol2iIm8I5oBDUZ
        UNV97sdy1BLGTj5zg9OvFBRxMiPKB59PXt0Bci07N3XD4R3VWbwJz+6zWrX/qqqm2MAzFDLakAX
        pm9fOxwbHQBxYKz/CpImnUE56zqCcmmz2KRNx8UqcFiB3TQIJhvl0wKTrEp6oTWJienUmZ423Rw
        ==
X-Google-Smtp-Source: APXvYqxmwPnVzVMPi4RvXcuq0DtQGRW+3ZHbsnDg2LaVH4eUJWnWkMr7ixaQYQ/tJe+GI713d7S9enkP87tr5AYmwRU=
X-Received: by 2002:a1f:a848:: with SMTP id r69mr903236vke.37.1571971896802;
 Thu, 24 Oct 2019 19:51:36 -0700 (PDT)
Date:   Thu, 24 Oct 2019 19:51:20 -0700
In-Reply-To: <20190817003926.102944-1-emilyshaffer@google.com>
Message-Id: <20191025025129.250049-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v3 0/9] add git-bugreport tool
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the patience with the long wait, all. Here's an attempt at
the rewrite in C; I think it does verbatim what the sh version did
except that this doesn't print the reflog - Jonathan Nieder was good
enough to point out to me that folks probably don't want to share their
commit subjects all willy-nilly if they're working on something
secretive.

For the most part I hoped to do this stuff stupidly - that is to say,
independent of the libraries within Git - in an effort to both avoid
bitrot, and see what is (as opposed to what the libraries think should
be).

The one common patch with v2 is "generate config whitelist based on
docs", which I have not changed at all.

I look forward to everyone's suggestions.

 - Emily

Emily Shaffer (9):
  bugreport: add tool to generate debugging info
  bugreport: generate config whitelist based on docs
  bugreport: add version and system information
  bugreport: add config values from whitelist
  bugreport: collect list of populated hooks
  bugreport: count loose objects
  bugreport: add packed object summary
  bugreport: list contents of $OBJDIR/info
  bugreport: print contents of alternates file

 .gitignore                             |   1 +
 Documentation/config/sendemail.txt     |  68 +++---
 Makefile                               |  11 +-
 bugreport-generate-config-whitelist.sh |   4 +
 bugreport.c                            | 314 +++++++++++++++++++++++++
 bugreport.h                            |  44 ++++
 builtin.h                              |   1 +
 builtin/bugreport.c                    |  90 +++++++
 git.c                                  |   1 +
 9 files changed, 499 insertions(+), 35 deletions(-)
 create mode 100755 bugreport-generate-config-whitelist.sh
 create mode 100644 bugreport.c
 create mode 100644 bugreport.h
 create mode 100644 builtin/bugreport.c

-- 
2.24.0.rc0.303.g954a862665-goog

