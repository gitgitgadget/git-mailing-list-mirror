Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37373FA3740
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 01:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiKABHk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 21:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiKABHj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 21:07:39 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789F515725
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 18:07:37 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id m29-20020a05600c3b1d00b003c6bf423c71so11931648wms.0
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 18:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ElUnClzVNiYBMAI4V1eFs+N/728XlqByhCdPE5DvoZk=;
        b=jTbakDo/VYTaGc5h5qV8sWbGZVB09BtjlvEsIUMeWVGBBpRumwSJjhBuFlGZSoG0Ek
         IfjuaViVNDNolj35PjzPqVsjtAbHism93svDvEtQelXBvZk6UBgbmwuoYpAY1oVGLugr
         2fnsloH4IpbjWuJ3rU7DQCcjRSzGgaVXJb9dOzidClFuJ6ZmyYGtOJnXLoE/Wq4j2grv
         47KkZSynXqGzTw6v3iWx9ePZ8yfCfFhN/LzxONy5r6H0L/Z52QBYzG9vFuEjQ0h7DKx2
         5AJjLBOMHTSj0IuHqHyWHuXjr3U85d/iZbwg0gWcaZDxzkndBTX1JjbGdJlyt/LWh8/I
         Io6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ElUnClzVNiYBMAI4V1eFs+N/728XlqByhCdPE5DvoZk=;
        b=bBjEg2h4GkCLZ9jkII7G84mK38k5gyRdr+HdeghDzuG+6nlWJWL+C+3uLR1ghbVinO
         N5HQledOjc64ussbWGLHGgmufDZv1ufPzFsBQSimEYtMZKItOYlwolHB7qqoyhsLIuhe
         ECNDwOnQOf1z3r06OSbqEb49JQ6X54QuC8TzJ8rv1QcMWTK9NmJ0LVOB26gx0c0fXhYT
         BzcO0xdevlFJNUPHjGoC31M4RE09iUYHxwZBJN3KBy55Jwd9omWN0t+welZrxtKcAR0Q
         qTgxMLCObNx2G479SZKW2KbtTG4oyrgnzkSa57wYqvgsEE+tpvCokFf4fkDTbQ3toLmi
         eeAQ==
X-Gm-Message-State: ACrzQf04Lly1dTj0zrvQOp/A13OsMtA6OVUbPTZcuvhs/3HSw+Mg1TbX
        cYr6J2ASh/ASKmUahGmbwZoPHyryeWE=
X-Google-Smtp-Source: AMsMyM6ZoeT214eKJZOsFQQrdVJ6VD7MnUZLY+2jGePYdLlN6aPyTfvosm7DCKvt1Fb76XC9DJOGyA==
X-Received: by 2002:a05:600c:a48:b0:3b9:af1f:1b38 with SMTP id c8-20020a05600c0a4800b003b9af1f1b38mr10169721wmq.185.1667264855771;
        Mon, 31 Oct 2022 18:07:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id fc6-20020a05600c524600b003c6bbe910fdsm10193001wmb.9.2022.10.31.18.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 18:07:35 -0700 (PDT)
Message-Id: <pull.1400.git.1667264854.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Nov 2022 01:07:25 +0000
Subject: [PATCH 0/9] Bundle URIs IV: advertise over protocol v2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        chooglen@google.com, jonathantanmy@google.com,
        dyroneteng@gmail.com, Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is based on the recent master batch that included ds/bundle-uri-....

Now that git clone --bundle-uri can download a bundle list from a plaintex
file in config format, we can use the same set of key-value pairs to
advertise a bundle list over protocol v2. At the end of this series:

 1. A server can advertise bundles when uploadPack.advertiseBundleURIs is
    enabled. The bundle list comes from the server's local config,
    specifically the bundle.* namespace.
 2. A client can notice a server's bundle-uri advertisement and request the
    bundle list if transfer.bundleURI is enabled. The bundles are downloaded
    as if the list was advertised from the --bundle-uri option.

Many patches in this series were adapted from Ævar's v2 RFC [1]. He is
retained as author and I added myself as co-author only if the modifications
were significant.

[1]
https://lore.kernel.org/git/RFC-patch-v2-01.13-2fc87ce092b-20220311T155841Z-avarab@gmail.com/

 * Patches 1-5 are mostly taken from [1], again with mostly minor updates.
   The one major difference is the packet line format being a single
   key=value format instead of a sequence of pairs. This also means that
   Patch 4 is entirely new since it feeds these pairs directly from the
   server's config.

 * Patches 6-9 finish off the ability for the client to notice the
   capability, request the values, and download bundles before continuing
   with the rest of the download.

One thing that is not handled here but could be handled in a future change
is to disconnect from the origin Git server while downloading the bundle
URIs, then reconnecting afterwards. This does not make any difference for
HTTPS, but SSH may benefit from the reduced connection time. The git clone
--bundle-uri option did not suffer from this because the bundles are
downloaded before the server connection begins.

After this series, there is one more before the original scope of the plan
is complete: using creation tokens as a heuristic. See [2] for the RFC
version of those patches.

[2] https://github.com/derrickstolee/git/pull/22

Thanks,

 * Stolee

Derrick Stolee (5):
  bundle-uri: serve bundle.* keys from config
  strbuf: reintroduce strbuf_parent_directory()
  bundle-uri: allow relative URLs in bundle lists
  bundle-uri: download bundles from an advertised list
  clone: unbundle the advertised bundles

Ævar Arnfjörð Bjarmason (4):
  protocol v2: add server-side "bundle-uri" skeleton
  bundle-uri client: add minimal NOOP client
  bundle-uri client: add helper for testing server
  bundle-uri client: add boolean transfer.bundleURI setting

 Documentation/config/transfer.txt      |   6 +
 Documentation/gitprotocol-v2.txt       | 193 +++++++++++++++++++++
 builtin/clone.c                        |  23 +++
 bundle-uri.c                           |  91 +++++++++-
 bundle-uri.h                           |  27 +++
 connect.c                              |  47 +++++
 remote.h                               |   5 +
 serve.c                                |   6 +
 strbuf.c                               |   9 +
 strbuf.h                               |   7 +
 t/helper/test-bundle-uri.c             |  48 ++++++
 t/lib-t5730-protocol-v2-bundle-uri.sh  | 229 +++++++++++++++++++++++++
 t/t5601-clone.sh                       |  59 +++++++
 t/t5701-git-serve.sh                   |  40 ++++-
 t/t5730-protocol-v2-bundle-uri-file.sh |  36 ++++
 t/t5731-protocol-v2-bundle-uri-git.sh  |  17 ++
 t/t5732-protocol-v2-bundle-uri-http.sh |  17 ++
 t/t5750-bundle-uri-parse.sh            |  54 ++++++
 transport-helper.c                     |  13 ++
 transport-internal.h                   |   7 +
 transport.c                            |  87 ++++++++++
 transport.h                            |  23 +++
 22 files changed, 1042 insertions(+), 2 deletions(-)
 create mode 100644 t/lib-t5730-protocol-v2-bundle-uri.sh
 create mode 100755 t/t5730-protocol-v2-bundle-uri-file.sh
 create mode 100755 t/t5731-protocol-v2-bundle-uri-git.sh
 create mode 100755 t/t5732-protocol-v2-bundle-uri-http.sh


base-commit: c03801e19cb8ab36e9c0d17ff3d5e0c3b0f24193
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1400%2Fderrickstolee%2Fbundle-redo%2Fadvertise-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1400/derrickstolee/bundle-redo/advertise-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1400
-- 
gitgitgadget
