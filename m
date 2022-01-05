Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C2DC433F5
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 23:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245400AbiAEX3i (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 18:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245411AbiAEX3f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 18:29:35 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04635C061245
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 15:29:35 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id v10-20020a05600c214a00b00345e59928eeso2817770wml.0
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 15:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yy4Fpc3eTc13h/3zA/Ro3v1w93p9oTjJoCuGOiMAe8A=;
        b=OYpNKJ/mb0Zp5MECwGQBfCXToSFSXCD3XYjKe167pPn8i8i1lG0QN7gXMs1IbHTSjC
         vbyC1urvVGOTueuq1I4BegpK/o9D8BGkfMnU2w3HIzbxISQzxsptO7mZ+/xa9Uz+hMHE
         aDQxbsLvVzdkt9grTS2WHSzlWashqqO6oosjtpA4P9y8jb32sHT9osYpy+KREExDawa5
         wgwMaVo37qjX9bfiDojSfHpQh69sSx3L+MczwUE0WvrvsgPmJdloRGlC0LZxSvL2Iaw4
         cqB6yZryCyYjaWvL3cJGP1YDjna7HI16AFpxVNeCnEbQ1KgpDuvqm3VcJqADcoVohKle
         OZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yy4Fpc3eTc13h/3zA/Ro3v1w93p9oTjJoCuGOiMAe8A=;
        b=rvaG16GeHGnItTVQbGneoanGtRkn/1jBFlhUP+1DQ5883Ah4loss4XN2Q3jVX0t0mz
         5+mzqXYFRaCufRHiErEwSoKtq0J3OwgmsMjxGHU5Brw62mHPp3KJm7IEuBGfrnuUtPyM
         Ta7sEZFNf2hSGG1HdKi1F3ekJURpbecIpqKbSYArI8+cayLyaU/QSDNNxlBzlRtJUZyN
         hPoj5HoCeHNzaSyo25NBI2gSYpuG2n7miC5C1ZUo7KrRCq3CWz+1Qv4vEfB6MlQPAurp
         pZZzuv36z4nkybz1sZ6QzoWyXZ19K4FLRFQyju74gGduLQAIRuLPa7R4SjJS9UaP09z1
         AHUA==
X-Gm-Message-State: AOAM533c0YU6dAY3+/JIVkCfy22fsqCQNbQB8kB3qQShm5q7Nk9zB7iH
        ehyzyHKgJfx3Xd8dzx/HDGeU7zFc4uw=
X-Google-Smtp-Source: ABdhPJyTiiNMiQFE0PofYooK3di3Etd1IyMWCpwK72wo6vHl4OqPcszpuhSxfTXR9wUIVO62eYSQ+A==
X-Received: by 2002:a05:600c:a03:: with SMTP id z3mr4714138wmp.73.1641425373489;
        Wed, 05 Jan 2022 15:29:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p23sm244324wms.3.2022.01.05.15.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 15:29:33 -0800 (PST)
Message-Id: <pull.1171.v7.git.git.1641425372.gitgitgadget@gmail.com>
In-Reply-To: <pull.1171.v6.git.git.1641423600.gitgitgadget@gmail.com>
References: <pull.1171.v6.git.git.1641423600.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Jan 2022 23:29:30 +0000
Subject: [PATCH v7 0/2] name-rev: deprecate --stdin in favor of --annotate-stdin
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce a --annotate-stdin that is functionally equivalent of --stdin.
--stdin does not behave as --stdin in other subcommands, such as
pack-objects whereby it takes one argument per line. Since --stdin can be a
confusing and misleading name, the goal is to rename it to --annotate-stdin.

This is the first step in a process of eventually fully deprecating --stdin.
This change also adds a warning to --stdin warning that it will be removed
in the future.

See https://lore.kernel.org/git/xmqqsfuh1pxz.fsf@gitster.g/ for discussion.

changes since v6:

 * change OPT_BOOL from hidden back to normal mode

changes since v5:

 * fixed documentation example indentation (again)
 * moved initialization of strbuf from 1/2 to 2/2

changes since v4:

 * fixed documentation example indentation

changes since v3:

 * use strbuf_getline instead of strbuf_getwholeline (based on Junio's
   feedback)
 * fixed commit message s/annotate-text/annotate-stdin (based on Junio's
   feedback)
 * since strbuf_getline does not keep the trailing terminator, add back '\n'
   with strbuf_addchr
 * reordered documentation blocks based on (Philip Oakley's feedback)
 * fixed doc typos in example block

John Cai (2):
  name-rev: deprecate --stdin in favor of --annotate-stdin
  name-rev.c: use strbuf_getline instead of limited size buffer

 Documentation/git-name-rev.txt       | 30 ++++++++++++++++++++++++++--
 builtin/name-rev.c                   | 30 ++++++++++++++++++----------
 t/t3412-rebase-root.sh               |  2 +-
 t/t4202-log.sh                       |  2 +-
 t/t6007-rev-list-cherry-pick-file.sh | 26 ++++++++++++------------
 t/t6012-rev-list-simplify.sh         |  2 +-
 t/t6111-rev-list-treesame.sh         |  3 ++-
 t/t6120-describe.sh                  |  9 +++++++--
 8 files changed, 72 insertions(+), 32 deletions(-)


base-commit: c8b2ade48c204690119936ada89cd938c476c5c2
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1171%2Fjohn-cai%2Fjc%2Fdeprecate-name-rev-stdin-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1171/john-cai/jc/deprecate-name-rev-stdin-v7
Pull-Request: https://github.com/git/git/pull/1171

Range-diff vs v6:

 1:  3caf254a73e ! 1:  153f69ea9b6 name-rev: deprecate --stdin in favor of --annotate-stdin
     @@ builtin/name-rev.c: int cmd_name_rev(int argc, const char **argv, const char *pr
       		OPT_GROUP(""),
       		OPT_BOOL(0, "all", &all, N_("list all commits reachable from all refs")),
      -		OPT_BOOL(0, "stdin", &transform_stdin, N_("read from stdin")),
     -+		OPT_BOOL_F(0, "stdin", &transform_stdin, N_("deprecated: use annotate-stdin instead"), PARSE_OPT_HIDDEN),
     ++		OPT_BOOL(0, "stdin", &transform_stdin, N_("deprecated: use annotate-stdin instead")),
      +		OPT_BOOL(0, "annotate-stdin", &annotate_stdin, N_("annotate text from stdin")),
       		OPT_BOOL(0, "undefined", &allow_undefined, N_("allow to print `undefined` names (default)")),
       		OPT_BOOL(0, "always",     &always,
 2:  32ad96530b9 = 2:  19e7bf96557 name-rev.c: use strbuf_getline instead of limited size buffer

-- 
gitgitgadget
