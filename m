Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C00C81F404
	for <e@80x24.org>; Tue, 14 Aug 2018 22:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732516AbeHOB1p (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 21:27:45 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:43570 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732444AbeHOB1p (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 21:27:45 -0400
Received: by mail-ua1-f74.google.com with SMTP id k5-v6so11232449ual.10
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 15:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=c+5u6IXIxSNhOpf57A9RqD1BBu5f/7RYTnQPrkHircY=;
        b=GGJ+YjP8dCK1Xsd4L6PiJg66+mELT3+x4XE2tIa6YqIIL2262+4dNwZjUB88dF0ex1
         yCohjJj36zvwJqYuSdXfMIKQKTwt9i3bP6D7wD3UXv7r5lLyF593YiDVi22bTA3W+FOp
         HGmgOU1UUFdMHMovabB2Wg7UcXFxNJM5TluW6nadcSefeZT4YH7eGkg3rpdIDF6gBaBH
         opnslVUArmqxQy5qvVPDSsasjS3hGVim7g+svbhrvTBXMBz4seiHUS2xgfKbPadEFUYJ
         hI5SMIYMPSy8nFJcntLMO9ljcf2YaG56OtSU6dE++i/PsuR1d/VCBQH8eNbf3Lpxtt9y
         +zeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=c+5u6IXIxSNhOpf57A9RqD1BBu5f/7RYTnQPrkHircY=;
        b=N7ZotDT+JDTkDYV0/q5CX1LhpHzq2OtAoWOhFidzRUuQ4cQamdOk4KJ2F8L+PyvqEy
         N9QcEthTEU7sJIutf11/1YCPOJZEFoFgS0JtO0yIf4AKJKgQYwDXQEFI7pkBgH2YP1eQ
         SW+N6ZtGOmk09TR5HLgy+n9PYgWnWTs+IKBdPkYXBEbR6hScAS3dbSCMaIT9L9YNu+4S
         UFvDbGz6p0k9zmN8UWh4490iyXmbz8Fdsxo4MeIv+6P5cLhqSQHsLQVuD+YaIjm7LxIj
         KQVJEn6jqbvq4FT6d8xxczGpPJYz7gyJnoas9v0m2VHVW+VRPJv0QiXdASmZwSCHT7kw
         gATA==
X-Gm-Message-State: AOUpUlGT9ih3XJfsT8H7Tf4qzW1TCG7hLAyJhVslNVAL5b5OyAqQyVK5
        2HDWDoFvcZ/UMHQiszicv0sF9F+z6MvP
X-Google-Smtp-Source: AA+uWPxSatZxJoXGGdDRZ/LJ45X1aLJgrfGSP4LXC/x22NAzGDvT0vhnbS+XZKQwdIwCs+vBtYCCoVjaPjEO
X-Received: by 2002:ab0:3098:: with SMTP id h24-v6mr11591783ual.108.1534286305452;
 Tue, 14 Aug 2018 15:38:25 -0700 (PDT)
Date:   Tue, 14 Aug 2018 15:38:20 -0700
In-Reply-To: <95e4f9df528a40bf3f3e648318904500343abf9a.camel@infinera.com>
Message-Id: <20180814223820.123723-1-sbeller@google.com>
Mime-Version: 1.0
References: <95e4f9df528a40bf3f3e648318904500343abf9a.camel@infinera.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH 1/2] store submodule in common dir
From:   Stefan Beller <sbeller@google.com>
To:     joakim.tjernlund@infinera.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 path.c | 1 +
 1 file changed, 1 insertion(+)
 
On Tue, Aug 14, 2018 at 3:27 PM Joakim Tjernlund <Joakim.Tjernlund@infinera.com> wrote:
>
> I am trying to create 3 submodules from the same git repo, each pointing to a different branch.
> Since the repo is somewhat large, I don't want the 3 submodules to clone the same repo 3
> times, I want one clone and then have the 3 submodules to point to different commits.
>
> Is this possible? If not, could it be added?

yup.

According to recent discussions, it would be just this patch.
(plus some unspecified amount of work, TBD).

I thought about proposing something proper later, but here is the WIP patch.

Thanks,
Stefan 

diff --git a/path.c b/path.c
index 34f0f98349a..64c9821b834 100644
--- a/path.c
+++ b/path.c
@@ -115,6 +115,7 @@ static struct common_dir common_list[] = {
 	{ 1, 1, 1, "logs/HEAD" },
 	{ 0, 1, 1, "logs/refs/bisect" },
 	{ 0, 1, 0, "lost-found" },
+	{ 0, 1, 0, "modules" },
 	{ 0, 1, 0, "objects" },
 	{ 0, 1, 0, "refs" },
 	{ 0, 1, 1, "refs/bisect" },
-- 
2.18.0.865.gffc8e1a3cd6-goog

