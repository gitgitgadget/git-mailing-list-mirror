Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL,WEIRD_PORT
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 509771F404
	for <e@80x24.org>; Tue, 14 Aug 2018 18:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbeHNVKd (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 17:10:33 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:41939 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbeHNVKc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 17:10:32 -0400
Received: by mail-ua1-f73.google.com with SMTP id c13-v6so10536191uao.8
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 11:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=828pzcEPb9AccWy1QpK/H70v37+Ss/xNDgajcrPo+Z0=;
        b=OZwwRHvHeekGVODUvMVoajUjunYqYO3aOytYjv7IsXlvptg67B7TsJXUpj4kston5t
         N4EoCQzBE5XNd16FNe9g1PHl2Awkq9n0NOuJANTYG8xDvupfbqnOf7uOyxAd8CB/vq/k
         LKBTjZrkGHOqUMlViazfqkXfGsiKSKsbCkBOc62hbWyNn42Z6+CMHeIdhoxujBSBND/i
         suVfdcPsq9HrJqYnhq0BR99/bI5tlGSzx3HO1NEvWGWLBLK4DqnHqQZgMJdWPburcYtt
         /Ro/Vh93YvANWyIz4uPgQobgFwG51iYSOZdC51TV7wnwB9xKCrJvzBiW8vsf8mBKOGYp
         +UYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=828pzcEPb9AccWy1QpK/H70v37+Ss/xNDgajcrPo+Z0=;
        b=QN3KlrQquWb9aSf3OvY6TVWyL+2Z/GUHF9epniTmy1s2jeht8+02hFjsEopWP2+kR/
         XB0Yadsn09aR2hPUaKQ8LlSipn3ynIjiFWQyGYBqJxcTMHiYPTN4GtAIQDdTn3udfTjF
         4qHjgYH2dHLvBkMFqwtHo5deFwJrIH4MNzvLmWK82KN7stSU3a0fdpTPIMcjhyLH4Ku3
         XaIb+hpSQJa0xlq0GdtNaAxG25MtYIXSKZSoeN+vmCbjIKK6vyBUrHi9ubOVTK2ltMDT
         wfDMlQV7nFkZyBaMkJiq9BiA/BDt/BGFx4w17cKexFbM6lXEndQVMFd+gpRnVxPcbUCl
         7Fbg==
X-Gm-Message-State: AOUpUlFa7pAlTW100BRo7CpFKMxGJni9/daTv1vQvT8ZYqTMb2KZD7nT
        fux80P7xkpkaOmFA/kQdaIyJ/wKflki5
X-Google-Smtp-Source: AA+uWPx1oMDWy8FyJxbYBh5XWVP1s2NZqBT8fP1y3OKunIQPgTScATumXbLPHpET9YZOIpWFqqkSpmTPrkaC
X-Received: by 2002:a1f:2a86:: with SMTP id q128-v6mr12906784vkq.62.1534270928274;
 Tue, 14 Aug 2018 11:22:08 -0700 (PDT)
Date:   Tue, 14 Aug 2018 11:22:02 -0700
In-Reply-To: <929572FA-6B1D-4EC7-825B-93B96053A82C@gmx.de>
Message-Id: <20180814182202.59442-1-sbeller@google.com>
Mime-Version: 1.0
References: <929572FA-6B1D-4EC7-825B-93B96053A82C@gmx.de>
X-Mailer: git-send-email 2.18.0.265.g16de1b435c9.dirty
Subject: [PATCH] git-submodule.sh: accept verbose flag in cmd_update to be non-quiet
From:   Stefan Beller <sbeller@google.com>
To:     jochen.kuehner@gmx.de
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a56771a668d (builtin/pull: respect verbosity settings in submodules,
2018-01-25), we made sure to pass on both quiet and verbose flag from
builtin/pull.c to the submodule shell script. However git-submodule doesn't
understand a verbose flag, which results in a bug when invoking

  git pull --recurse-submodules -v [...]

There are a few different approaches to fix this bug:

1) rewrite 'argv_push_verbosity' or its caller in builtin/pull.c to
   cap opt_verbosity at 0. Then 'argv_push_verbosity' would only add
   '-q' if any.

2) Have a flag in 'argv_push_verbosity' that specifies if we allow adding
  -q or -v (or both).

3) Add -v to git-submodule.sh and make it a no-op

(1) seems like a maintenance burden: What if we add code after
the submodule operations or move submodule operations higher up,
then we have altered the opt_verbosity setting further down the line
in builtin/pull.c.

(2) seems like it could work reasonably well without more regressions

(3) seems easiest to implement as well as actually is a feature with the
    last-one-wins rule of passing flags to Git commands.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

On Tue, Aug 14, 2018 at 10:54 AM Jochen K=C3=BChner <jochen.kuehner@gmx.de>=
 wrote:
>
> If I set=20
> git config --global submodule.recurse true
> and run git via:
> git pull --progress -v --no-rebase "origin"
> The command will fail with following output (Errorlevel is 1)
> Fetching submodule submodules/tstemplates
> From http://10.0.102.194:7990/scm/mcc/tstemplates
> =3D [up to date]      feature/robin -> origin/feature/robin
> =3D [up to date]      master        -> origin/master
> Already up to date.
> usage: git submodule [--quiet] add [-b <branch>] [-f|--force] [--name <na=
me>] [--reference <repository>] [--] <repository> [<path>]
>    or: git submodule [--quiet] status [--cached] [--recursive] [--] [<pat=
h>...]
>    or: git submodule [--quiet] init [--] [<path>...]
>    or: git submodule [--quiet] deinit [-f|--force] (--all| [--] <path>...=
)
>    or: git submodule [--quiet] update [--init] [--remote] [-N|--no-fetch]=
 [-f|--force] [--checkout|--merge|--rebase] [--[no-]recommend-shallow] [--r=
eference <repository>] [--recursive] [--] [<path>...]
>    or: git submodule [--quiet] summary [--cached|--files] [--summary-limi=
t <n>] [commit] [--] [<path>...]
>    or: git submodule [--quiet] foreach [--recursive] <command>
>    or: git submodule [--quiet] sync [--recursive] [--] [<path>...]
>    or: git submodule [--quiet] absorbgitdirs [--] [<path>...]
>
> seams that the =E2=80=9Cverbose=E2=80=9D parameter =E2=80=9C-v=E2=80=9D i=
s also sent to =E2=80=9Cgit submodules=E2=80=9D wich does not support it.
>
> If I remove =E2=80=9C-v=E2=80=9D it will work.
>
> Problem is, I use TortoiseGit, wich will automatically create this comman=
d!

 git-submodule.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/git-submodule.sh b/git-submodule.sh
index 8b5ad59bdee..f7fd80345cd 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -438,6 +438,9 @@ cmd_update()
 		-q|--quiet)
 			GIT_QUIET=3D1
 			;;
+		-v)
+			GIT_QUIET=3D0
+			;;
 		--progress)
 			progress=3D1
 			;;
--=20
2.18.0.265.g16de1b435c9.dirty

