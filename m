Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07178C433B4
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 23:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC618610CA
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 23:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235744AbhDKXEm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 19:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235005AbhDKXEk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 19:04:40 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47D8C061574
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 16:04:23 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id e186so11543895iof.7
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 16:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=J1CjmmJJTTcXiK+k0Csms1rgiCUeKVY87gaxwoHyt+M=;
        b=Moyulf81MXX4Ug3i5CbydJq7/P6+xx/hA0oBnt3hGRwr17xgcCrEBE9p2iJ3jkV4I7
         Qfb7BHFYvvB9ULKohJ8JiUnKr3SFqE4P5KldNorl3sFnFf9r2TekAA4Yd6uozJyxf8uR
         0S3v66hTOCnZrd3+d8iRh7JeZ/gnMREsgHhChtVA0L79vn24kEwCIcuI/5alWosfZjGk
         8mqLZjNyXG+dy5yGep/u3HUlqKsrBmloFvfU2DkB/euVofk84j3OUiFD/Vb1nayo9LME
         hd6JSk+2wzy5C2FCyBxF9KGVCx4V6ySKADXMhzaSbLxcdN4UPob2EupVDZkV0SEAbHuG
         F/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=J1CjmmJJTTcXiK+k0Csms1rgiCUeKVY87gaxwoHyt+M=;
        b=bwH41cGGrmQ8QMFJJYv0jcAoJ3pNWkGMLGakgKeh3fDY0YpcF02toCOsGfCCjvY6jL
         sX/apdn76eEcYa+Bo5JqN9GaC6/GxGU9G0DWbtu86qN9gw/JC9Sgv9JYTP1wjHOZAZwb
         Mru0c1IYgr6wqeSSK1yUQGk71zhEz6QZxWmus/N/StlNJ/HWCRTXXtv+yjDcnDL2Z9CQ
         TEJ9ZeI0UYO3b5/Gl+ixhPz1VmLbREWa+BrXu39FgwhHTIwA+L/tIy02NBeeVQqcNqLE
         LII5Armtq1aNHfV5XYYgTqQeYEJWb4otmA9h6sdTlp5J4oW2jF4qFiEOEebrPj5zxMnP
         TBcA==
X-Gm-Message-State: AOAM530mGYgKh44Cd7idexIypVKlcG1Q3mDjrJiJW+P0FjhgS9xeGdOj
        C1M7IINnUuXkU8rG/VJb+FQ+7Jhr7md/F9JoOdi81MChtCo9Cg==
X-Google-Smtp-Source: ABdhPJylOf7xgKWyGRA69VqViMTkuZo/boOCBDZJlsier9zhSQsZ0RZ4EIVJS5+Z+WiRzYQnHp2zWbNUqEAMWDQsTcY=
X-Received: by 2002:a02:6a5a:: with SMTP id m26mr25254431jaf.17.1618182262958;
 Sun, 11 Apr 2021 16:04:22 -0700 (PDT)
MIME-Version: 1.0
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Sun, 11 Apr 2021 19:04:11 -0400
Message-ID: <CAH8yC8nT-68H9Vy=zxqsKeqpBqt-OJYCpVh53cm1KoeSbSVC-Q@mail.gmail.com>
Subject: How to checkout a branch (and not a tag)
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm trying to checkout a branch called REL1_35 from
https://github.com/wikimedia/mediawiki-skins-Cosmos. The repo also has
a tag called REL1_35.

When I perform the following I apparently get the tag (with old files)
and not the branch (with updated files):

    wiki_rel=REL1_53
    ...
    git fetch origin && git reset --hard "origin/${wiki_rel}" && \
        git checkout -f "${wiki_rel}" && git pull && git clean -xdf

I found https://groups.google.com/g/git-users/c/FfzGmqj6sNQ, but I am
not following it. My .git/config looks like it is using the proper
reference:

# cat skins/Cosmos/.git/config
[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
[remote "origin"]
        url = https://github.com/Universal-Omega/MediaWiki-Cosmos-skin.git
        fetch = +refs/heads/*:refs/remotes/origin/*
[branch "REL1_35"]
        remote = origin
        merge = refs/heads/REL1_35

How do I checkout the branch (and not a tag)?

Thanks in advance.
