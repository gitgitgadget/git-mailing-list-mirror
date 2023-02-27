Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EB3C64ED6
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 01:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjB0B5K (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Feb 2023 20:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjB0B5H (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Feb 2023 20:57:07 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAE412F17
        for <git@vger.kernel.org>; Sun, 26 Feb 2023 17:57:05 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id h14so4634591wru.4
        for <git@vger.kernel.org>; Sun, 26 Feb 2023 17:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pRoI7wKXk2DDeWintRwAthVRGvW5ruIe/TNWpaYDzcU=;
        b=j1TUbIrsJY6PPpVZI8uJXzIMbiP9fvpkMC6A9VU3QfhVQ2sZc0txrLONcLbTP3ptzk
         g+WS1z7wm41BcLkAaBfyN/nTwy/aK7DAjpgZlTFyrlmB6u7VeQQ6q7KLgJGW3MDXZBPr
         KUVXQTS8C9ITIaJHpsi8kyp7RRp8XY8aHAenCcv/FhkIRdnPWcOXxKN3ekHRDbA2Hg5Q
         HCBo3oiIUBT5XYRs3jvlKltymzUThwolqX3HNAtw+7gxaUoGN7OzkNYBYQ31hZ0dq7kF
         ZehpsmjA9JKIzsJRWZStCil/vfpvGZKueQkn2D5szG3PRr3MM6o85ZguJGC5O/qMUGJr
         AJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pRoI7wKXk2DDeWintRwAthVRGvW5ruIe/TNWpaYDzcU=;
        b=NdztmoZpjdzDp3/H5C9nhpBHkbEpL3CxkM9vSXbHSrdHwdEe+XbWWxZGLiJrF2OgYT
         FE1vJFKCha9K/F3+jxegRnKCiimSgCP40z9j0/TfDLK3VPQwtB/MkEiR1Di4mn56b9GJ
         OViMQh2dIaJwEJcpCnpGqAxFYZdg+thX8Hkry3stnE87MgLdJl1VA/nAV628dQu4XkUg
         v8WdgzJHkpsJxvTldGbCDHozN0lDei5FtLbmD7j30sMBJID9we8w8RAlpnXtJxW/9TrJ
         Q0y9LP5iT/Ferr4cm6MyWyQS7sxt9YjlDlhpIxrRr/NXxEqduo2W8LIYRFN/VugSJ4UO
         KsSg==
X-Gm-Message-State: AO0yUKVGY/17pJuT78ekl9Ce68QfNRDRI+giIb+Z+xuP7lScQYQqAYD4
        ATwsh2C1WPHaiPKTN+g0G9S5FZt4qC4=
X-Google-Smtp-Source: AK7set/NPCmlerj2GxmOuwtHCeDVuW8EWeqMqp3k9A1o9RU5MKvNHE/emIJxLghOlaCKBB/oACWEvg==
X-Received: by 2002:a5d:4b03:0:b0:2c9:3f36:73e3 with SMTP id v3-20020a5d4b03000000b002c93f3673e3mr4722470wrq.17.1677463023754;
        Sun, 26 Feb 2023 17:57:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m9-20020a05600c4f4900b003dec22de1b1sm7852000wmq.10.2023.02.26.17.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 17:57:03 -0800 (PST)
Message-Id: <pull.1465.v3.git.1677463022.gitgitgadget@gmail.com>
In-Reply-To: <pull.1465.v2.git.1675529298.gitgitgadget@gmail.com>
References: <pull.1465.v2.git.1675529298.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Feb 2023 01:57:00 +0000
Subject: [PATCH v3 0/2] [RFC] push: allow delete one level ref
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This might be an odd request: allow git push to delete one level refs like
"ref/foo".

Some users on my side often push "refs/for/master" to the remote for code
review, but due to a user's typo, "refs/master" is pushed to the remote.

Pushing a one level ref like "refs/foo" should not have been successful, but
since my server side directly updated the ref during the proc-receive-hook
phase of git receive-pack, "refs/foo" was mistakenly left at on the server.

But for some reasons, users cannot delete this special branch through "git
push -d".

First, I executed git update-ref --stdin inside my proc-receive-hook to
delete the branch. As a result, update-ref reported an error: "cannot lock
ref 'refs/foo': reference already exists".

So I tried GIT_TRACKET_PACKET to debug and found that git push did not seem
to pass the correct ref old-oid, which is why update-ref reported an error.

"18:13:41.214872 pkt-line.c:80           packet: receive-pack< 0000000000000000000000000000000000000000 0000000000000000000000000000000000000000 refs/foo\0 report-status-v2 side-band-64k object-format=sha1 agent=git/2.39.0.227.g262c45b6a1"


Tracing it back, the check_ref() in the git push link didn't record the
old-oid for the remote "refs/foo".

At the same time, the server update() process will reject the one level ref
by default and return a "funny refname" error.

It is worth mentioning that since I deleted the branch, the error message
returned here is "refusing to create funny ref 'refs/foo' remotely", which
is also worth fixing.

So this patch series do:

v1.

 1. fix funny refname error message from "create" to "update".
 2. let server allow delete one level ref.
 3. let client pass correct one level ref old-oid.

v2.

 1. fix code style.

v3.

 1. clarify in the docs why single-level refs are allowed to be deleted but
    not created/updated.

ZheNing Hu (2):
  receive-pack: fix funny ref error messsage
  [RFC] push: allow delete single-level ref

 builtin/receive-pack.c |  6 ++++--
 connect.c              |  3 ++-
 t/t5516-fetch-push.sh  | 12 ++++++++++++
 3 files changed, 18 insertions(+), 3 deletions(-)


base-commit: dadc8e6dacb629f46aee39bde90b6f09b73722eb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1465%2Fadlternative%2Fzh%2Fdelete-one-level-ref-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1465/adlternative/zh/delete-one-level-ref-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1465

Range-diff vs v2:

 1:  214a2b662e3 = 1:  857d2435caf receive-pack: fix funny ref error messsage
 2:  966cb49c388 ! 2:  4dc75f5b961 [RFC] push: allow delete one level ref
     @@ Metadata
      Author: ZheNing Hu <adlternative@gmail.com>
      
       ## Commit message ##
     -    [RFC] push: allow delete one level ref
     +    [RFC] push: allow delete single-level ref
      
     -    Git will reject the deletion of one level refs e,g. "refs/foo"
     -    through "git push -d", however, some users want to be able to
     -    clean up these branches that were created unexpectedly on the
     -    remote.
     +    We discourage the creation/update of single-level refs
     +    because some upper-layer applications only work in specified
     +    reference namespaces, such as "refs/heads/*" or "refs/tags/*",
     +    these single-level refnames may not be recognized. However,
     +    we still hope users can delete them which have been created
     +    by mistake.
      
          Therefore, when updating branches on the server with
          "git receive-pack", by checking whether it is a branch deletion
          operation, it will determine whether to allow the update of
     -    one level refs. This avoids creating/updating such one level
     -    branches, but allows them to be deleted.
     +    a single-level refs. This avoids creating/updating such
     +    single-level refs, but allows them to be deleted.
      
          On the client side, "git push" also does not properly fill in
     -    the old-oid of one level refs, which causes the server-side
     +    the old-oid of single-level refs, which causes the server-side
          "git receive-pack" to think that the ref's old-oid has changed
     -    when deleting one level refs, this causes the push to be rejected.
     -
     -    So the solution is to fix the client to be able to delete
     -    one level refs by properly filling old-oid.
     +    when deleting single-level refs, this causes the push to be
     +    rejected. So the solution is to fix the client to be able to
     +    delete single-level refs by properly filling old-oid.
      
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>
      

-- 
gitgitgadget
