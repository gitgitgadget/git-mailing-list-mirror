Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724C1C6FA83
	for <git@archiver.kernel.org>; Mon, 12 Sep 2022 13:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiILNZx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Sep 2022 09:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiILNZv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2022 09:25:51 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C722F659
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 06:25:50 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id a20so3446139qtw.10
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 06:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=CDVbPy/r9bsSBsj+QNsqSdtDjwcZ/r8EphHq2hYjArY=;
        b=Igpd/A9P/7o2lEEuJnEMs9Pz5Vq6Zxsj32dHWPffFvFuu4L9Nn0LXKkBQ7QCevQ+7o
         F278DJEt/Afx2ZVGn86WQ8BNYctDDWyFo3wcllTjdl3qK8k62VfJYbN9ae5i/c9KhJpv
         4HLxkwv686KZ2ekbOLZD6IBQCHk9Vj7e2qTEg5FsSDftjnF+eAgFx5Sxd9g7xQXYMXmu
         knl2oQ4nN+42Ss4WxZtqgHs6Kp1rfFCmfy/zcZSF0SApqHh7Cd61Tdwx7TG5uZZO/3/i
         5/XjsqJQSvk2ch3xirsLINGODGpudTbL5avSVWz6jQydvMJ3n9sHXY3sHq+mjaILanZe
         xdyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=CDVbPy/r9bsSBsj+QNsqSdtDjwcZ/r8EphHq2hYjArY=;
        b=fpTNn+AWZR2ZCFYZxE2JynWw3CQLpbgdtG86S2kmCSlK1YPLQKZ8ylIs+qzComrtaw
         CRSK6dstZppknKZPKPi4Ezq1zLdpFKXZZH/nSzvTZvxUL1vEtPY1zpgWYF+uZ9ERIoci
         yp8iUETPnK6LxzhqbtaJ7ua0fRwj0NUmRPhy3wTawaQaiFuQBI1eFz6tqiQCO1Grl1FK
         ez0JnkbXrrcQsGh21C5myFGOlUTYSmYMTkk7kHWGvOPnR/IjgJ9RrKBo/qMZVZAO05UY
         qkUEp5ioMEB5vD/h6QcaSnGwe2oFpBO6zW6xBbBNDHn4GVjz/IW2L1Zvj4GlBy0v0FHK
         TZrw==
X-Gm-Message-State: ACgBeo2AkcSLWxsnfhbhIURh2NdNipV5m6qtqs+xuhjDiQoKaYZKoVWi
        +kSSXG4XXyV1jpPiVmZv8dJYHAwDmBImxB5l8aiwqE72hAc=
X-Google-Smtp-Source: AA6agR78l2cva9KHHsMXRIOxia8cRmBaxr1AE1wZskLP31r1yyBafOluyCADrCR06D3QNrZQarxl7GJICLNA/vuMK9I=
X-Received: by 2002:ac8:5753:0:b0:344:7fb3:3fa4 with SMTP id
 19-20020ac85753000000b003447fb33fa4mr23826759qtx.504.1662989149512; Mon, 12
 Sep 2022 06:25:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220912054515.29559-1-mail@rkta.de> <20220912054515.29559-2-mail@rkta.de>
In-Reply-To: <20220912054515.29559-2-mail@rkta.de>
From:   =?UTF-8?Q?=C3=98ystein_Walle?= <oystwa@gmail.com>
Date:   Mon, 12 Sep 2022 15:25:13 +0200
Message-ID: <CAFaJEquyFE86VVRy9jZ13xtjFpLbJaseFWf=Vo3CeKdnvScvcg@mail.gmail.com>
Subject: Re: [PATCH 1/2] blame: Make --show-name negatable
To:     Rene Kita <mail@rkta.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

That was me! :-)

Not long after I sent you a new link with the patch below, but I suppose
you missed it. My first rough attempt was incomplete, changing the
behavior from on/auto on to auto/off instead of the intended
on/auto/off.

The docs changes look good to me (but should perhaps be squashed into the i=
mpl
patch?). Not sure how many of the negatable long options that exist are
actually documented as such, but imho. they should be.

There are no added tests, but there are no tests for -f/--show-name in the
first place and I just didn't get around to writing one...

=C3=98sse

---
 builtin/blame.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index a9fe8cf7a6..cbaae91a8f 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -49,6 +49,7 @@ static int blank_boundary;
 static int incremental;
 static int xdl_opts;
 static int abbrev =3D -1;
+static int show_name =3D -1;
 static int no_whole_file_rename;
 static int show_progress;
 static char repeated_meta_color[COLOR_MAXLEN];
@@ -621,7 +622,8 @@ static void find_alignment(struct blame_scoreboard
*sb, int *option)
         if (compute_auto_abbrev)
             auto_abbrev =3D update_auto_abbrev(auto_abbrev, suspect);
         if (strcmp(suspect->path, sb->path))
-            *option |=3D OUTPUT_SHOW_NAME;
+            if (show_name =3D=3D -1)
+                *option |=3D OUTPUT_SHOW_NAME;
         num =3D strlen(suspect->path);
         if (longest_file < num)
             longest_file =3D num;
@@ -867,7 +869,7 @@ int cmd_blame(int argc, const char **argv, const
char *prefix)
         OPT_BOOL(0, "show-stats", &show_stats, N_("show work cost
statistics")),
         OPT_BOOL(0, "progress", &show_progress, N_("force progress
reporting")),
         OPT_BIT(0, "score-debug", &output_option, N_("show output
score for blame entries"), OUTPUT_SHOW_SCORE),
-        OPT_BIT('f', "show-name", &output_option, N_("show original
filename (Default: auto)"), OUTPUT_SHOW_NAME),
+        OPT_BOOL('f', "show-name", &show_name, N_("show original
filename (Default: auto)")),
         OPT_BIT('n', "show-number", &output_option, N_("show original
linenumber (Default: off)"), OUTPUT_SHOW_NUMBER),
         OPT_BIT('p', "porcelain", &output_option, N_("show in a
format designed for machine consumption"), OUTPUT_PORCELAIN),
         OPT_BIT(0, "line-porcelain", &output_option, N_("show
porcelain format with per-line commit information"),
OUTPUT_PORCELAIN|OUTPUT_LINE_PORCELAIN),
@@ -943,6 +945,9 @@ int cmd_blame(int argc, const char **argv, const
char *prefix)
     revs.diffopt.flags.follow_renames =3D 0;
     argc =3D parse_options_end(&ctx);

+    if (show_name =3D=3D 1)
+        output_option |=3D OUTPUT_SHOW_NAME;
+
     prepare_repo_settings(the_repository);
     the_repository->settings.command_requires_full_index =3D 0;

--=20
2.34.1
