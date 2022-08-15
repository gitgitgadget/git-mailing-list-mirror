Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CEF5C00140
	for <git@archiver.kernel.org>; Mon, 15 Aug 2022 15:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbiHOPBo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Aug 2022 11:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbiHOPBd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Aug 2022 11:01:33 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E061403C
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 08:01:31 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id bs25so9392299wrb.2
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 08:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=FmFGv22VQSJ9gzveXHzZrC9j8/G2g6JKykLuepS7saI=;
        b=i0BAQKyn6o8Iq3Fq4JYqXFIK820aAYo/IFVJt/6+2aKE8kdC9a++Cei5raGBqN9bNf
         WpSmK/lQOz42S/cDVOp0jj9SleWFzXAEOFiy3fsM7FTMmQ7CDUII86nVO7XKoNjpmsZv
         K708ll/8Dj3t6qo/29YIhgVibd8yjshkjHQMGQVbpSdGNqqT7McbFzOr6TDbPFPsJPDZ
         hDpwmhVHOyqtgb+qURtRx3XFJnMya32gZ4io/RutOerfnYnKqw4Y46eyBLdlH+W7zWjm
         fb8LknSE2PzacqMN41KW1CXi17drS6XgPIhjXM9KBUcPqTZCWb/CjKRuw6BGXF3G76IK
         pk/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=FmFGv22VQSJ9gzveXHzZrC9j8/G2g6JKykLuepS7saI=;
        b=MNi/bIn9NuyCfqEFYD466MF+IpEYDr0vZXZwiHmsnIzLNF6V+NhDjGtHdUqMBpn8Kg
         802gIex9266BBHATbtL9VARrGuhSBFfqCvDuLQk9HOa/4laJ6Z6J09EqPsnHbcyW5qfA
         E3dO6rFnUwtUuKxKi+LDUZAXusudhNLaGJo3fm90d9LcVL40b4X/ZjO18vdnLTQEUIel
         tFA0zpP+UrmFxkJyrIGLYk1rfHRgZMniEXroyIxRCuG+uK+XlMQaio537GMrFGuV0fbk
         Ufn2FkngxTxTGQC/O03e2VvgMizVuloRn7Vkcga1CXlqPZf8iIL1hTmGY8gFMEhWrBRw
         IffQ==
X-Gm-Message-State: ACgBeo0tG1q5bwIDUHry4jevAOktt12o/0G4j1xBpQ7Rg00uk0iqvS0j
        gXDKvsIZKaq0XKS1wfrMFIOFKSE2I6s=
X-Google-Smtp-Source: AA6agR7B48ykO9jWJQAt+nHysZDWwcNX79v5eyf3xJohnN99vTapgv1A6UXFCRps+pfgPQ7ofKG17w==
X-Received: by 2002:a5d:6609:0:b0:21f:ff6:9090 with SMTP id n9-20020a5d6609000000b0021f0ff69090mr9586894wru.30.1660575689968;
        Mon, 15 Aug 2022 08:01:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j27-20020a05600c1c1b00b003a32251c3f9sm10511466wms.5.2022.08.15.08.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 08:01:29 -0700 (PDT)
Message-Id: <pull.1301.v4.git.git.1660575688.gitgitgadget@gmail.com>
In-Reply-To: <pull.1301.v3.git.git.1660575384.gitgitgadget@gmail.com>
References: <pull.1301.v3.git.git.1660575384.gitgitgadget@gmail.com>
From:   "Sun Chao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Aug 2022 15:01:25 +0000
Subject: [PATCH v4 0/3] hide-refs: add hook to force hide refs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sun Chao <16657101987@163.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Gerrit is implemented by JGit and is known as a centralized workflow system
which supports reference-level access control for repository. If we choose
to work in centralized workflow like what Gerrit provided, reference-level
access control is needed and we might add a reference filter hook hide-refs
to hide the private data.

This hook would be invoked by 'git-receive-pack' and 'git-upload-pack'
during the reference discovery phase, each reference will be filtered with
this hook. The hook executes once with no arguments for each
'git-upload-pack' and 'git-receive-pack' process. Once the hook is invoked,
a version number and server process name ('uploadpack' or 'receive') will
send to it in pkt-line format, followed by a flush-pkt. The hook should
respond with its version number.

During reference discovery phase, each reference will be filtered by this
hook. In the following example, the letter 'G' stands for 'git-receive-pack'
or 'git-upload-pack' and the letter 'H' stands for this hook. The hook
decides if the reference will be hidden or not, it sends result back in
pkt-line format protocol, a response "hide" means the references will hide
to the client and can not fetch its private data even in protocol V2.

            # Version negotiation
            G: PKT-LINE(version=1\0uploadpack)
            G: flush-pkt
            H: PKT-LINE(version=1)
            H: flush-pkt

            # Send reference filter request to hook
            G: PKT-LINE(ref <refname>:<refname_full>)
            G: flush-pkt

            # Receive result from the hook.
            # Case 1: this reference is hidden
            H: PKT-LINE(hide)
            H: flush-pkt

            # Case 2: this reference can be advertised
            H: flush-pkt


To enable the hide-refs hook, we should config hiderefs with force: option,
eg:

            git config --add transfer.hiderefs force:refs/prefix1/
            git config --add uploadpack.hiderefs force:!refs/prefix2/


the hide-refs will be called during reference discovery phase and check each
matched reference, a 'hide' response means the reference will be hidden for
its private data even if allowTipSHA1InWant or allowReachableSHA1InWant are
set to true.

Sun Chao (3):
  hide-refs: add hook to force hide refs
  t1419: add test cases for hide-refs hook
  doc: add documentation for the hide-refs hook

 Documentation/githooks.txt                    |  48 ++++
 Makefile                                      |   1 +
 builtin/receive-pack.c                        |   5 +-
 ls-refs.c                                     |   2 +-
 refs.c                                        | 221 +++++++++++++++++-
 refs.h                                        |   6 +
 serve.c                                       |   2 +
 t/helper/test-hide-refs.c                     | 152 ++++++++++++
 t/helper/test-tool.c                          |   1 +
 t/helper/test-tool.h                          |   1 +
 t/t1419-hide-refs-hook.sh                     | 142 +++++++++++
 t/t1419/common-functions.sh                   |  80 +++++++
 t/t1419/once-0000-abnormal-hide-refs-hook.sh  | 161 +++++++++++++
 ...test-0001-ls-remote-with-hide-refs-hook.sh |  77 ++++++
 ...st-0002-upload-pack-with-hide-refs-hook.sh | 122 ++++++++++
 ...t-0003-receive-pack-with-hide-refs-hook.sh |  87 +++++++
 upload-pack.c                                 |  32 +--
 upload-pack.h                                 |   1 +
 18 files changed, 1111 insertions(+), 30 deletions(-)
 create mode 100644 t/helper/test-hide-refs.c
 create mode 100755 t/t1419-hide-refs-hook.sh
 create mode 100644 t/t1419/common-functions.sh
 create mode 100644 t/t1419/once-0000-abnormal-hide-refs-hook.sh
 create mode 100644 t/t1419/test-0001-ls-remote-with-hide-refs-hook.sh
 create mode 100644 t/t1419/test-0002-upload-pack-with-hide-refs-hook.sh
 create mode 100644 t/t1419/test-0003-receive-pack-with-hide-refs-hook.sh


base-commit: afa70145a25e81faa685dc0b465e52b45d2444bd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1301%2Fsunchao9%2Frefs_advertise-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1301/sunchao9/refs_advertise-v4
Pull-Request: https://github.com/git/git/pull/1301

Range-diff vs v3:

 1:  01c63ea5fee = 1:  01c63ea5fee hide-refs: add hook to force hide refs
 2:  b8a490cb3df = 2:  b8a490cb3df t1419: add test cases for hide-refs hook
 3:  99755b377f0 ! 3:  8c5ae78de47 doc: add documentation for the hide-refs hook
     @@ Documentation/githooks.txt: If this hook exits with a non-zero status, `git push
      +'git-upload-pack' and 'git-receive-pack' process. Once the hook is invoked,
      +a version number and server process name ('uploadpack' or 'receive') will
      +send to it in pkt-line format, followed by a flush-pkt. The hook should
     -+response with its version number.
     ++respond with its version number.
      +
      +During reference discovery phase, each reference will be filtered by this
      +hook. In the following example, the letter 'G' stands for 'git-receive-pack'
     @@ Documentation/githooks.txt: If this hook exits with a non-zero status, `git push
      +	git config --add uploadpack.hiderefs force:!refs/prefix2/
      +
      +the `hide-refs` will be called during reference discovery phase and
     -+check each matched reference, a 'hide' reponse means the reference will
     -+be hidden for its private data and even the `allowTipSHA1InWant` and
     -+`allowReachableSHA1InWant` is set to true.
     ++check each matched reference, a 'hide' response means the reference will
     ++be hidden for its private data even if `allowTipSHA1InWant` and
     ++`allowReachableSHA1InWant` are set to true.
      +
       [[pre-receive]]
       pre-receive

-- 
gitgitgadget
