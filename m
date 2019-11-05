Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 409811F454
	for <e@80x24.org>; Tue,  5 Nov 2019 21:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387395AbfKEV7X (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 16:59:23 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43757 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729970AbfKEV7X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 16:59:23 -0500
Received: by mail-wr1-f66.google.com with SMTP id n1so23306746wra.10
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 13:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=TzgdS+q4a6I/shfyAggROvX6SiNKojha6exuc3BRfYA=;
        b=YIHHc2UVkFhynahI3P7K5CKPFZ8lXOeSQ049c5oNnSGkgHMEOPktUjM27CstVb6xpF
         h3S9gJCTngZOEHCj/vg4UwtG0Qn8aZCQZpfQNxS+9r+xb4BXacM8VCF4ThU3ikrO7Fr6
         KjTMgOdljQSVq0PsfVivvvpTLzR6NqOs/2g4W5N/6cdlM0+YZfB4S1EGSZtNGd5i9Iv+
         DQEspCz/vaJyQedEhO0oowlpUzmkJ3kZiZAhvjC3LqPPd3qPKoaeN9/X0M6eEEEOVW5W
         vts5/1DPAZ/I96uamnEvjS7ouh1eV9PHhaMf9BsDvWtTQnAK2ehIEBDBWIPcUQxhsQAZ
         mSdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TzgdS+q4a6I/shfyAggROvX6SiNKojha6exuc3BRfYA=;
        b=prZJekjO3gnk0MBpiNqFvQyWYmFcbeWCv5UN8hNCsj6qnGNY2AJlS7BRudIMr3GZwM
         yZj8jtwo4IaJquoGXhI3iFxr0RD27CNVPhYK0uozp+Ca3jvGYuca40Vuy8E9udt6oDbv
         glW6fR1pZj6HlJutprMwGis2BIZU7ZiIJs7+H4O1mebQvmsyOkOSxiFswky57rAF1be3
         nYShPW/nkXMWW+6S5TNiJhad+rMl65gRdhqsZpLPuEdBLMUgZjG3BKHW8J34xcPwMQLR
         4NOF514nW8fJqPCVxCADJWagt4PBtUUR73B3S+WNVPSBG1bY0l3gQ75t6mvQJvWR9cJ5
         /lig==
X-Gm-Message-State: APjAAAX5I/nZMon/nlACYQYUqeRk6v+Afe8P1vW9v1dz6hxg+CVz/hUe
        v2OiqIXsg0A+WyMCx5CfzmNXL9Y2
X-Google-Smtp-Source: APXvYqxmOfyNlolAWWxr8xbjPWjqzy3DtBodFw73B6L9TuLEZTBt0ndJIOm1lcmOEFGuDbBKfTP0dQ==
X-Received: by 2002:a5d:6203:: with SMTP id y3mr30318634wru.142.1572991159362;
        Tue, 05 Nov 2019 13:59:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w9sm23617062wrt.85.2019.11.05.13.59.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 13:59:18 -0800 (PST)
Message-Id: <pull.453.git.1572991158.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Nov 2019 21:59:17 +0000
Subject: [PATCH 0/1] remote-curl: unbreak http.extraHeader with custom allocators
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is one of those bugs that can cost entire days of work.

The symptom of this bug is that git -c http.extraheader push ... will fail
frequently in Git for Windows v2.24.0, but not always. When it fails,
though, it will cause a segmentation fault in git remote-https while calling 
http_cleanup() and leave no visual indication of that problem, the only
indication of a problem will be the exit code of the caller (in this
instance, git push will fail with exit code 1).

In my tests during the pre-release period, I pushed many a time, it probably
failed a lot, in the way indicated above, and due to the absence of any
error message, I failed to realize that there was a problem in the first
place.

Fun side note: this bug haunted me for the best part of yesterday, when I
tried to get Git for Windows v2.24.0 out the door. Large parts of Git for
Windows' release management are scripted, and that script failed, claiming
to have been unsuccessful in pushing the tag v2.24.0.windows.1, just after
printing a message to the extent that the tag is already up to date (except
in the first attempt, when it reported to have been successful in pushing
the tag). My attempts to fix the release script were doomed to fail because
the root cause was not a bug in the script, but the bug fixed in this patch.

Johannes Schindelin (1):
  remote-curl: unbreak http.extraHeader with custom allocators

 http.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)


base-commit: 93b980e58f5624ee4e3b2dc0d0babaa97ef66d19
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-453%2Fdscho%2Ffix-curl-xmalloc-regression-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-453/dscho/fix-curl-xmalloc-regression-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/453
-- 
gitgitgadget
