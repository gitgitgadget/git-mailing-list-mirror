Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F5DE20248
	for <e@80x24.org>; Wed, 10 Apr 2019 12:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732241AbfDJM4t (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Apr 2019 08:56:49 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:45496 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729140AbfDJM4t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Apr 2019 08:56:49 -0400
Received: by mail-ed1-f41.google.com with SMTP id o26so1909926edv.12
        for <git@vger.kernel.org>; Wed, 10 Apr 2019 05:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=GGAF+HNJb0TglJsZxQVBjRMHFlRiaqypb0nwCfKYpDA=;
        b=RXKqRuuVhHASwII4aKpxQcqnyCc2sMlJsHhDEnqsO0k0UR9bHVbBuy4w3z5fz04Hf8
         ex5v2ucUUI0gDX4BgxremeUK/fg26HgS61ebuyT8YU0r2d8kcMP6HU/pjGy5JP3cIO8O
         jstb4et8202SONDzBMqADvCsI6s9zOH2kryVtLE6kzTcoFYgpbghm5XahgfJ0V1AMKGc
         NWY+/XA+S4zFZ0FlNg3neNo1K+Pi7eK8VGLA61CGYfXYMeDevklovY18k9iKtDHXc0hk
         3GtNmEec4m24JdXPU6CeVMM8OfvsRyMyIhRFyY9HnbjCXRzZejcLKVT+t37N59zvDRa6
         XM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GGAF+HNJb0TglJsZxQVBjRMHFlRiaqypb0nwCfKYpDA=;
        b=Zr61qrUNmmjQwuXyTzswBUVyuT/sZ9sdAA1aTdjzOVlqdveop3t+DmrFDJ5jMAIKXw
         iXZQxR5yu2M+wlUxZuhcicm4i70T8HPYOi06gpSRqY7RjsYGp3sfi85Iu5oIOia6VqAC
         LojnShpd5Gn6OHeZb5TLiEia/T8NyR0dcJQU3wLifGoNDPglyN9L5wltakIwtZjW0mNB
         wdB7YgYOja0pBhUfbFKLRXrw9f0CMJJmvsx4AF7rWloVVAQ7UYxPZqV5jYYs3ByyTgL4
         IzXDF23MBjSmggIklmQg77AFOyz6VsT0XTOnInycsH90QjvUEnAxsKaRxjxp5LzvNzmM
         nQcg==
X-Gm-Message-State: APjAAAWlWlRaLKlQE/defPXUgUq77jGeJesNSBeD79v85QEex0pREiDU
        l93xoFuD3roh+XPl/y2WyDCQXw0C
X-Google-Smtp-Source: APXvYqw8L9wQn1zz0CXRGiBl9BHu/4iuPNn/1udUolXlDUuAcpLz3GLpnstwJ5Fcq1YWL5+1vCJwHQ==
X-Received: by 2002:a17:906:278a:: with SMTP id j10mr24408999ejc.12.1554901007836;
        Wed, 10 Apr 2019 05:56:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c9sm5414813ejb.1.2019.04.10.05.56.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 05:56:47 -0700 (PDT)
Date:   Wed, 10 Apr 2019 05:56:47 -0700 (PDT)
X-Google-Original-Date: Wed, 10 Apr 2019 12:56:45 GMT
Message-Id: <pull.178.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Fix an off-by-one bug in the untracked cache code
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

Frankly, I am surprised it took me this long to discover this bug, as I am
running with the untracked cache for ages now.

But as of recent, I am running more and more long-running commands, mostly
rebases to keep what I call "ever-green" branches up to date, where Git for
Windows' patch thicket is rebased onto core Git's four integration branches,
and when there are no merge conflicts to stop the rebase early, I got this
really obscure crash (no error message, no nothing to indicate what it was).

It cost me two full work days to chase this one down.

Johannes Schindelin (1):
  untracked cache: fix off-by-one

 dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


base-commit: e35b8cb8e212e3557efc565157ceb5cbaaf0d87f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-178%2Fdscho%2Funtracked-cache-off-by-one-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-178/dscho/untracked-cache-off-by-one-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/178
-- 
gitgitgadget
