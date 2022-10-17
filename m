Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9770C4332F
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 22:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiJQWOU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 18:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiJQWOT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 18:14:19 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6061C6C96D
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 15:14:16 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id h186-20020a636cc3000000b0045a1966a975so6987178pgc.5
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 15:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nP4rMIKzKBF63/Wv+/xbdO9L4i1QRGTdXvqztNFQwbE=;
        b=BAlGkihSLJzxX5nm3tuFe85yh+njntGbdpMeF9H6cEmYU0wk/WGme/9eSMw7O2LB0y
         v9nAAhfqmHdB02HThf++nPT/qHOUezwlWprZCyGSc5mgnfuL2bR9rRslL8ZL9A9ChWN6
         uG6+bgEbVFL6fd4OFJluXxWb4MdfbRb87aJodGFP89Xsd+ohTrPwJgmuSroUseC97XH6
         eLeEGh8zgItR9Fgc2DTI3HpaO4JVKYxTvS+8gfixmleCAjXxG36OzG7n0ij8wM1g92Zp
         EEA3G8ZMeyR63HUmFfDvIst8+FlKxQ1r/rRv710kqS25NyIdyHqpGFwZhMijnQWfZjLe
         sSCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nP4rMIKzKBF63/Wv+/xbdO9L4i1QRGTdXvqztNFQwbE=;
        b=E3yBaQVqmpCwpvM5Cyzo6tfsbKW03bnZFwlMPX/WCc2EZlAFnn5mqwAZoBcNzwA2oP
         VFURqy5+faQXhPSh/hBmck+JLvbnA34Ux5DGpWvGZOPoGttVMEYQIIpFuL+liFmkUjQb
         VAQLnZ1gA9FzkXZQMg4+7WVG4qPH9v83BlXMMvp3eYNUwT/cgWVr2kcEsus8fcGZp5KQ
         lUHJJ0mkPqxO0tosgDC7RyDajpWEQomjIrZLp4Z2G6TF8XQq+Y/D9G70yZpe8xyHUhMk
         1bph2k5oVpvEpbs+Jqv6FCwQFxMf4qHjcSsxaXl/5Z/r8K28D8V8XfmGNCh3kaIeKpf1
         ZHuQ==
X-Gm-Message-State: ACrzQf0vNIe0QWVX0g+VsN3oZN3uZChzhKiosSUUwBr3BX4gY8KfshUB
        Q+UiPm84CeePd5V7ERMJ4H2RwpLWzkTH+A==
X-Google-Smtp-Source: AMsMyM6LaSDJ9o/OF9C+FGsXQYKEEIyGDZy1QeLxhT+hQdL9RpRpyPqqADAuW2f1dq9b3ulIxwviwoteFGXwiw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:5408:b0:20a:d6b1:a2a7 with SMTP
 id z8-20020a17090a540800b0020ad6b1a2a7mr1506642pjh.2.1666044854485; Mon, 17
 Oct 2022 15:14:14 -0700 (PDT)
Date:   Mon, 17 Oct 2022 15:14:04 -0700
In-Reply-To: <pull.1352.v2.git.git.1665783944.gitgitgadget@gmail.com>
Mime-Version: 1.0
References: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com> <pull.1352.v2.git.git.1665783944.gitgitgadget@gmail.com>
Message-ID: <kl6l7d0yyu6r.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 00/12] fsmonitor: Implement fsmonitor for Linux
From:   Glen Choo <chooglen@google.com>
To:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason" 
        <avarab@gmail.com>, Eric DeCosta <edecosta@mathworks.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At $DAYJOB, we observed that this topic breaks MacOS builds with sha1dc:

  $ make NO_APPLE_COMMON_CRYPTO=1 DC_SHA1=1 NO_OPENSSL=1 compat/fsmonitor/fsm-ipc-darwin.o  

      CC compat/fsmonitor/fsm-ipc-darwin.o
    compat/fsmonitor/fsm-ipc-darwin.c:13:2: error: unknown type name 'SHA_CTX'; did you mean 'SHA1_CTX'?
            SHA_CTX sha1ctx;
            ^~~~~~~
            SHA1_CTX
    ./sha1dc/sha1.h:55:3: note: 'SHA1_CTX' declared here
    } SHA1_CTX;
      ^
    compat/fsmonitor/fsm-ipc-darwin.c:16:21: error: use of undeclared identifier 'SHA_DIGEST_LENGTH'
            unsigned char hash[SHA_DIGEST_LENGTH];
                              ^
    compat/fsmonitor/fsm-ipc-darwin.c:31:2: error: implicit declaration of function 'SHA1_Init' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
            SHA1_Init(&sha1ctx);
            ^
    compat/fsmonitor/fsm-ipc-darwin.c:31:2: note: did you mean 'SHA1DCInit'?
    ./sha1dc/sha1.h:58:6: note: 'SHA1DCInit' declared here
    void SHA1DCInit(SHA1_CTX*);
        ^
    compat/fsmonitor/fsm-ipc-darwin.c:32:2: error: implicit declaration of function 'SHA1_Update' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
            SHA1_Update(&sha1ctx, r->worktree, strlen(r->worktree));
            ^
    compat/fsmonitor/fsm-ipc-darwin.c:32:2: note: did you mean 'SHA1DCUpdate'?
    ./sha1dc/sha1.h:96:6: note: 'SHA1DCUpdate' declared here
    void SHA1DCUpdate(SHA1_CTX*, const char*, size_t);
        ^
    compat/fsmonitor/fsm-ipc-darwin.c:33:2: error: implicit declaration of function 'SHA1_Final' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
            SHA1_Final(hash, &sha1ctx);
            ^
    compat/fsmonitor/fsm-ipc-darwin.c:33:2: note: did you mean 'SHA1DCFinal'?
    ./sha1dc/sha1.h:100:6: note: 'SHA1DCFinal' declared here
    int  SHA1DCFinal(unsigned char[20], SHA1_CTX*);
        ^
    5 errors generated.
    make: *** [compat/fsmonitor/fsm-ipc-darwin.o] Error 1


Without NO_OPENSSL, this still fails, but with slightly different error
messages.

  $ make NO_APPLE_COMMON_CRYPTO=1 DC_SHA1=1 compat/fsmonitor/fsm-ipc-darwin.o

        CC compat/fsmonitor/fsm-ipc-darwin.o
    compat/fsmonitor/fsm-ipc-darwin.c:31:2: error: 'SHA1_Init' is deprecated [-Werror,-Wdeprecated-declarations]
            SHA1_Init(&sha1ctx);
            ^
    /opt/local/include/openssl/sha.h:49:1: note: 'SHA1_Init' has been explicitly marked deprecated here
    OSSL_DEPRECATEDIN_3_0 int SHA1_Init(SHA_CTX *c);
    ^
    /opt/local/include/openssl/macros.h:182:49: note: expanded from macro 'OSSL_DEPRECATEDIN_3_0'
    #   define OSSL_DEPRECATEDIN_3_0                OSSL_DEPRECATED(3.0)
                                                    ^
    /opt/local/include/openssl/macros.h:62:52: note: expanded from macro 'OSSL_DEPRECATED'
    #     define OSSL_DEPRECATED(since) __attribute__((deprecated))
                                                      ^
    compat/fsmonitor/fsm-ipc-darwin.c:32:2: error: 'SHA1_Update' is deprecated [-Werror,-Wdeprecated-declarations]
            SHA1_Update(&sha1ctx, r->worktree, strlen(r->worktree));
            ^
    /opt/local/include/openssl/sha.h:50:1: note: 'SHA1_Update' has been explicitly marked deprecated here
    OSSL_DEPRECATEDIN_3_0 int SHA1_Update(SHA_CTX *c, const void *data, size_t len);
    ^
    /opt/local/include/openssl/macros.h:182:49: note: expanded from macro 'OSSL_DEPRECATEDIN_3_0'
    #   define OSSL_DEPRECATEDIN_3_0                OSSL_DEPRECATED(3.0)
                                                    ^
    /opt/local/include/openssl/macros.h:62:52: note: expanded from macro 'OSSL_DEPRECATED'
    #     define OSSL_DEPRECATED(since) __attribute__((deprecated))
                                                      ^
    compat/fsmonitor/fsm-ipc-darwin.c:33:2: error: 'SHA1_Final' is deprecated [-Werror,-Wdeprecated-declarations]
            SHA1_Final(hash, &sha1ctx);
            ^
    /opt/local/include/openssl/sha.h:51:1: note: 'SHA1_Final' has been explicitly marked deprecated here
    OSSL_DEPRECATEDIN_3_0 int SHA1_Final(unsigned char *md, SHA_CTX *c);
    ^
    /opt/local/include/openssl/macros.h:182:49: note: expanded from macro 'OSSL_DEPRECATEDIN_3_0'
    #   define OSSL_DEPRECATEDIN_3_0                OSSL_DEPRECATED(3.0)
                                                    ^
    /opt/local/include/openssl/macros.h:62:52: note: expanded from macro 'OSSL_DEPRECATED'
    #     define OSSL_DEPRECATED(since) __attribute__((deprecated))
                                                      ^
    3 errors generated.
    make: *** [compat/fsmonitor/fsm-ipc-darwin.o] Error 1


"Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Goal is to deliver fsmonitor for Linux that is on par with fsmonitor for
> Windows and Mac OS.
>
> This patch set builds upon previous work for done for Windows and Mac OS
> (first 6 patches) to implement a fsmonitor back-end for Linux based on the
> Linux inotify API. inotify differs significantly from the equivalent Windows
> and Mac OS APIs in that a watch must be registered for every directory of
> interest (rather than a singular watch at the root of the directory tree)
> and special care must be taken to handle directory renames correctly.
>
> More information about inotify:
> https://man7.org/linux/man-pages/man7/inotify.7.html
>
> v1 differs from v0:
>
>  * Code review feedback
>  * Update how and which code can be shared between Mac OS and Linux
>  * Increase polling frequency to every 1ms (matches Mac OS)
>  * Updates to t7527 to improve test stability
>
