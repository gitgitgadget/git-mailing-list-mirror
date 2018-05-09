Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5B4B1F424
	for <e@80x24.org>; Wed,  9 May 2018 20:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964956AbeEIU4U (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 16:56:20 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40426 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935200AbeEIU4P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 16:56:15 -0400
Received: by mail-wm0-f66.google.com with SMTP id j5-v6so719852wme.5
        for <git@vger.kernel.org>; Wed, 09 May 2018 13:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0NEXkhCpjlucZxijRva6Yq0pu93/38nbJH0UawiQW74=;
        b=SjgDQ5hqdjTf5ahxVfvhOSOAZvS1CE1pAKKizfdstC8o06z5d4go+x/By2h3FB1Qph
         WX5fCupIeaOaXjQkFxGUyGpvLdkhq1d0j96KfbJArA8cJrXgvKhIAQBOm2002/8acFyM
         0BRCWV8leCzsVG4byqeRj5AEjfPBK5+OFeWJ18Y7vopHm5Ehd4pQWZEZ2CLUfy2TgGei
         jobrAK+X3vBkzaO7wAH/s8j6FcpD0Xfx9T5q2buhF/51HrFHGcmEv5SrtReRV/ncLVfM
         AKlr53j/jidh0uMDLX1f+2qBW4lgAh4jH3ZsLVitVzc+H1KZyu3PsZ9c3ghsLabs4RVR
         XUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0NEXkhCpjlucZxijRva6Yq0pu93/38nbJH0UawiQW74=;
        b=HwbJn2wwMgtsEWTl+s1A+Gsjq8/NlndPJbUsmuFAE1W01ab1eKMQGbzhsOGScOldsW
         uJ4ClfiQY4gJkaP7LtYGc+zb26T9bBdU7+504JNeDAxqVZRV5a6PKgWJy6rwi75w3dE3
         TooJslgaHHopT/FrZi/7RbCH3NQdbCtIq7BvIaZ2Xtl6A1y1NtjwzZSPLC8FPrdEUCuh
         aF0PcAHfJFRB3ozufxyEd0iL19bQGfKrW4T2CoxRov7czJ5DCwR7wwFnB2uNWU5EEdHq
         +EtkVxrxeavlkb6OpQXN0ySVnvn0yFrv/JXf9ZuGyc21mhcy1Am3WxYPFaCxN4gQroKO
         z55w==
X-Gm-Message-State: ALKqPwfdoM2NpCIHDkI+v0pVHJF1t47nn0iOVnBQF/MzheRCGKNd9rrK
        m9Blp1wZwas6n6XoaNipmi4jN+aZWN4=
X-Google-Smtp-Source: AB8JxZpP//WV6uHRZIlzBsHN3YTWCNswOD2LiMw58hP7nfBtHtu1N9ZKuqYvkkHkjCmFmJiSNtKJtw==
X-Received: by 10.28.16.71 with SMTP id 68mr6622185wmq.132.1525899374010;
        Wed, 09 May 2018 13:56:14 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id r14-v6sm40073008wra.41.2018.05.09.13.56.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 May 2018 13:56:12 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     David Turner <novalis@novalis.org>, Duy Nguyen <pclouds@gmail.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 0/5] getting rid of most "static struct lock_file"s
Date:   Wed,  9 May 2018 22:55:34 +0200
Message-Id: <cover.1525898125.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0.411.g9fd64c8e46
In-Reply-To: <20180508182548.GD7210@sigill.intra.peff.net>
References: <20180508182548.GD7210@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is take two of my attempt at making almost all `struct lock_file`s
non-static. All patches have been equipped with more detailed commit
messages. The only diff that has changed is patch 3/5, where I now take
a small step towards gentle error-handling, rather than going in the
opposite direction.

Thanks all for the valuable feedback on v1. I could have saved everyone
some trouble by writing better commit messages from the start, and
probably also by using `--thread` when formatting the patches...

Martin

Martin Ågren (5):
  t/helper/test-write-cache: clean up lock-handling
  refs.c: do not die if locking fails in `write_pseudoref()`
  refs.c: do not die if locking fails in `delete_pseudoref()`
  lock_file: make function-local locks non-static
  lock_file: move static locks into functions

 t/helper/test-scrap-cache-tree.c |  4 ++--
 t/helper/test-write-cache.c      | 14 +++++---------
 apply.c                          |  2 +-
 builtin/add.c                    |  3 +--
 builtin/describe.c               |  2 +-
 builtin/difftool.c               |  2 +-
 builtin/gc.c                     |  2 +-
 builtin/merge.c                  |  4 ++--
 builtin/mv.c                     |  2 +-
 builtin/read-tree.c              |  3 +--
 builtin/receive-pack.c           |  2 +-
 builtin/rm.c                     |  3 +--
 bundle.c                         |  2 +-
 fast-import.c                    |  2 +-
 refs.c                           | 16 +++++++++-------
 refs/files-backend.c             |  2 +-
 rerere.c                         |  3 +--
 shallow.c                        |  2 +-
 18 files changed, 32 insertions(+), 38 deletions(-)

-- 
2.17.0.411.g9fd64c8e46

