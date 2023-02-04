Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62241C61DA4
	for <git@archiver.kernel.org>; Sat,  4 Feb 2023 16:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbjBDQsY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Feb 2023 11:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbjBDQsW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2023 11:48:22 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042D5FF16
        for <git@vger.kernel.org>; Sat,  4 Feb 2023 08:48:21 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id n13so5929398wmr.4
        for <git@vger.kernel.org>; Sat, 04 Feb 2023 08:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7IQKj/20yJbsRFkOQakjlEXKLiAZ/MAAXhGKflB2ag=;
        b=BCZQt8mJz1uxAnLD0ZqvPn64yITQF+aWX6tetnRuzur9AkbFjf5ecQJKOwn3vbZ5XE
         /WJdGE8+YDkGjXFNBkmWUvl/pVWikOCXH5f/hdXWcn3hAuoS/zLHRekl9l0GXBLZ5ooO
         I90DB3KfDlf4TqUv1k0xO13JO6txyZIoxTIT1eXPTn0k6cCySGyQwHlbFOFmFk7Lz4Gu
         xygqky2XKT7dolC3heW/bvh6YHRkEA7cJElttIU3AMnwSq6Vdn8FVO3u9PSLtgq6XWYG
         VqfGlTXpJel+PNXFMyxNezBhBcHkJGjuIlRV45hERwHgc9aJd4V/TN8wzEJsICNpOnI4
         PjeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H7IQKj/20yJbsRFkOQakjlEXKLiAZ/MAAXhGKflB2ag=;
        b=K2Po3dgC4ozGHx6P6vSKu2paBADNMpvYmvRpUAKfZTy1lWvpjd+v5+D+XRS02CzTyR
         kc96do/tn1G8HShwuLAfMzmZo0leMKMfqYM/8temBQsWgwdoyyErMj86qDNH4ttKRtYP
         gieiGQcgsYHBMz7czWXjdGB/Vsu1k/3dYKmTc/sm++m5dtq44ziwy7fUm4DcJe5uTuMR
         /b9BhVYHKxuYe6zQXNV/+9PK0uwBelVODbHv7qOEaI1QS+I5rvcC7ihQtW4xjBNIFi5v
         3nrZo68Zsg0mGR+vA7bxfv7jQktyjT3IUw0blVXd0gyDDgBuQ7suvLUa3FwF+Y9XTYGa
         M+sA==
X-Gm-Message-State: AO0yUKVRkwwghbBlhNyKcFmx+Ag0A23mQ/p4+E6P84pTHRh3w+E4XA+r
        bN5tvMB1YPZd3aAaMaTZECy+QGnF578=
X-Google-Smtp-Source: AK7set8+ckF3Xrn3Ezno60I9O7PzIBe09+x7Pnz3Kc5BD+RG/QVwRvnqY8OKKxCXWqgN+Vu6V6L1Xg==
X-Received: by 2002:a05:600c:154e:b0:3df:eb5d:c583 with SMTP id f14-20020a05600c154e00b003dfeb5dc583mr5329041wmg.17.1675529299178;
        Sat, 04 Feb 2023 08:48:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v16-20020a05600c471000b003dd1bd66e0dsm6729796wmo.3.2023.02.04.08.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 08:48:18 -0800 (PST)
Message-Id: <pull.1465.v2.git.1675529298.gitgitgadget@gmail.com>
In-Reply-To: <pull.1465.git.1673951562.gitgitgadget@gmail.com>
References: <pull.1465.git.1673951562.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 04 Feb 2023 16:48:15 +0000
Subject: [PATCH v2 0/2] [RFC] push: allow delete one level ref
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

ZheNing Hu (2):
  receive-pack: fix funny ref error messsage
  [RFC] push: allow delete one level ref

 builtin/receive-pack.c |  6 ++++--
 connect.c              |  3 ++-
 t/t5516-fetch-push.sh  | 12 ++++++++++++
 3 files changed, 18 insertions(+), 3 deletions(-)


base-commit: a38d39a4c50d1275833aba54c4dbdfce9e2e9ca1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1465%2Fadlternative%2Fzh%2Fdelete-one-level-ref-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1465/adlternative/zh/delete-one-level-ref-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1465

Range-diff vs v1:

 1:  214a2b662e3 = 1:  214a2b662e3 receive-pack: fix funny ref error messsage
 2:  605b95bf8ab ! 2:  966cb49c388 [RFC] push: allow delete one level ref
     @@ builtin/receive-pack.c: static const char *update(struct command *cmd, struct sh
       	/* only refs/... are allowed */
      -	if (!starts_with(name, "refs/") || check_refname_format(name + 5, 0)) {
      +	if (!starts_with(name, "refs/") ||
     -+	    check_refname_format(name + 5,
     -+				 is_null_oid(new_oid) ?
     ++	    check_refname_format(name + 5, is_null_oid(new_oid) ?
      +				 REFNAME_ALLOW_ONELEVEL : 0)) {
       		rp_error("refusing to update funny ref '%s' remotely", name);
       		ret = "funny refname";
     @@ connect.c: static int check_ref(const char *name, unsigned int flags)
       
       	/* REF_NORMAL means that we don't want the magic fake tag refs */
      -	if ((flags & REF_NORMAL) && check_refname_format(name, 0))
     -+	if ((flags & REF_NORMAL) && check_refname_format(name, REFNAME_ALLOW_ONELEVEL))
     ++	if ((flags & REF_NORMAL) && check_refname_format(name,
     ++							 REFNAME_ALLOW_ONELEVEL))
       		return 0;
       
       	/* REF_HEADS means that we want regular branch heads */
     @@ t/t5516-fetch-push.sh: test_expect_success 'push --delete refuses empty string'
       
      +test_expect_success 'push --delete onelevel refspecs' '
      +	mk_test testrepo heads/main &&
     -+	(
     -+		cd testrepo &&
     -+		git update-ref refs/onelevel refs/heads/main
     -+	) &&
     ++	git -C testrepo update-ref refs/onelevel refs/heads/main &&
      +	git push testrepo --delete refs/onelevel &&
     -+	(
     -+		cd testrepo &&
     -+		test_must_fail git rev-parse --verify refs/onelevel
     -+	)
     ++	test_must_fail git -C testrepo rev-parse --verify refs/onelevel
      +'
      +
       test_expect_success 'warn on push to HEAD of non-bare repository' '

-- 
gitgitgadget
