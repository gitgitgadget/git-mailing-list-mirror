Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FC6C433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 18:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245420AbiCWSTf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 14:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbiCWSTe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 14:19:34 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A006EA8
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 11:18:03 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id b19so3291777wrh.11
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 11:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GJ+6lRJmRSUxADDnI/GFdLUbSMhq3gABBqnzpQqFYWY=;
        b=NN6SsuCpBxCBTC79nCYtOuHFHHVqNxbzSPywcXmbUHOq6X+CkZ6MsCZK4ajdNj45Us
         0WvkASocc2a6/Ee1UdX64FxEUzcHC9jfmF+bu+EHSw5l9A/FX0CntPJDyvMqCl55ErW/
         9/u5xNkur49nVto9E787BTTaxs93geFKic5Vu+snnVoVuDzjvLcgFbgd47cZNaMF2DWd
         WQazYGax+edapHnqGP+1YcTZdk1W2+86OzyVZqlkd08lnAx341UcXJz4zrvO6bF3hDDG
         9Lg3j+h3y8vKdBTvMTKdZb85eZ51KG0noQifjQaKiyHFpHL+Ug+lMQBwL9M3BjfqnT0o
         j6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GJ+6lRJmRSUxADDnI/GFdLUbSMhq3gABBqnzpQqFYWY=;
        b=L2VjnRM8tTbKHilMtbKi5Kr4GBEcje4Jl8h2mExdUmSoUCC6mw289QDFSzT0wPJRSH
         LNIDUk5x1QRUdxaCQe4rSIC0ZfYso11dPA/CXxacQN38M6Xfrg0WSvVDUW7j1IuEObW6
         LJFt1+H9D5t2cmLnP7tD9EfaH5B/XcaLes2Y85lpKfrfh+cwGb1P3hnh+0hE5LCLOWsf
         siAU9PuQNzdQ+RMKcY9DxV8N0zNO/wmBxZPdIXMFx0C39u15d7I1D9RvzR6Q+xEGr0Ki
         2AxMf19f64MLP71xBVsR6iDsnOfKKvtNo4yjYxNtfKjUMMuyTno4NOGqzVxeCixqTttw
         B+FA==
X-Gm-Message-State: AOAM531VHBWsFyz/1G88iobyh6NBBNcha74hz1kPtaEeQHtXSoPPCe2v
        40axm/7/EDNPVC4k1vjVfI/t0xSPTj0=
X-Google-Smtp-Source: ABdhPJxbEErD/EIXA2lpREaLg9mnSCW2xz9S+6ew/YmUHHMFA/axcx6bOiuKvZHdUVHloNYSwFG37w==
X-Received: by 2002:a05:6000:1010:b0:204:c3c0:ad93 with SMTP id a16-20020a056000101000b00204c3c0ad93mr1116164wrx.311.1648059481334;
        Wed, 23 Mar 2022 11:18:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u11-20020a056000038b00b00203e5c9aa09sm688712wrf.27.2022.03.23.11.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 11:18:00 -0700 (PDT)
Message-Id: <pull.1184.v2.git.1648059480.gitgitgadget@gmail.com>
In-Reply-To: <pull.1184.git.1647894889.gitgitgadget@gmail.com>
References: <pull.1184.git.1647894889.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Mar 2022 18:17:57 +0000
Subject: [PATCH v2 0/3] reset: make --no-refresh the only way to skip index refresh
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, phillip.wood123@gmail.com,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Maintainer's note: this is based on vd/stash-silence-reset (specifically,
4b8b0f6fa2 (stash: make internal resets quiet and refresh index,
2022-03-15)).

----------------------------------------------------------------------------

This is a follow-up to the changes in vd/stash-silence-reset [1], in which
index refreshing behavior was decoupled from log silencing in the '--quiet'
option to 'git reset --mixed' by introducing a '--[no-]refresh' option and
'reset.refresh' config setting.

After some discussion [2] on the mailing list, both the
backward-compatibility and use of global options in that series came into
question:

 * '--quiet' still skipped refresh if neither '--[no-]refresh' nor
   'reset.refresh' were specified, meaning that users could still be left
   with an incorrect index state after reset.
 * Having 'reset.quiet' and/or 'reset.refresh' potentially disable index
   refresh by default meant that developers would need to defensively add
   '--refresh' to all internal uses of 'git reset --mixed'. Without that
   option, different config setups could cause variability in index
   correctness from user to user.

In response, this series removes all methods of skipping index refresh in
'git reset --mixed' except for '--no-refresh' itself:

 * Patch [1/3] removes the "fallback" behavior of 'reset.quiet' and
   '--quiet' implying '--no-refresh' if neither '--[no-]refresh' nor
   'config.refresh' were specified. In other words, '--quiet' no longer does
   anything other than log silencing.
 * Patch [2/3] removes 'reset.quiet', since its main use was to disable
   index refresh until that behavior was removed in [1/3].
 * Patch [3/3] removes 'reset.refresh' to avoid users accidentally ending up
   with an incorrect index state after all resets as a result of a global
   setting's passive effects.


Changes since V1
================

 * Dropped patch that removed '--refresh', again allowing both
   '--no-refresh' and '--refresh' as valid options.
 * Updated documentation of "--refresh" option to remove unnecessary
   "proactively".
 * Reworded commit titles to change "deprecate" to the more accurate
   "remove".

[1]
https://lore.kernel.org/git/pull.1170.v3.git.1647308982.gitgitgadget@gmail.com/
[2]
https://lore.kernel.org/git/80a2a5a2-256f-6c3b-2430-10bef99ce1e9@github.com/

Thanks! -Victoria

Victoria Dye (3):
  reset: do not make '--quiet' disable index refresh
  reset: remove 'reset.quiet' config option
  reset: remove 'reset.refresh' config option

 Documentation/config.txt       |  2 --
 Documentation/config/reset.txt |  2 --
 Documentation/git-reset.txt    | 12 ++-------
 builtin/reset.c                | 14 ++---------
 contrib/scalar/scalar.c        |  1 -
 t/t7102-reset.sh               | 45 +++++-----------------------------
 6 files changed, 10 insertions(+), 66 deletions(-)
 delete mode 100644 Documentation/config/reset.txt


base-commit: 877d90220e42b40cf5b899dc36a13c348220b54c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1184%2Fvdye%2Freset%2Fclean-up-refresh-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1184/vdye/reset/clean-up-refresh-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1184

Range-diff vs v1:

 1:  f89e9b4ae24 ! 1:  1b607e0610b reset: do not make '--quiet' disable index refresh
     @@ Commit message
          behavior from '--quiet' because it is completely unrelated to the stated
          purpose of the option: "Be quiet, only report errors."
      
     +    Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
          Signed-off-by: Victoria Dye <vdye@github.com>
      
       ## Documentation/git-reset.txt ##
     @@ Documentation/git-reset.txt: OPTIONS
       	Pathspec is passed in `<file>` instead of commandline args. If
      
       ## builtin/reset.c ##
     +@@ builtin/reset.c: static int git_reset_config(const char *var, const char *value, void *cb)
     + int cmd_reset(int argc, const char **argv, const char *prefix)
     + {
     + 	int reset_type = NONE, update_ref_status = 0, quiet = 0;
     +-	int refresh = -1;
     ++	int refresh = 1;
     + 	int patch_mode = 0, pathspec_file_nul = 0, unborn;
     + 	const char *rev, *pathspec_from_file = NULL;
     + 	struct object_id oid;
      @@ builtin/reset.c: int cmd_reset(int argc, const char **argv, const char *prefix)
       						PARSE_OPT_KEEP_DASHDASH);
       	parse_args(&pathspec, argv, prefix, patch_mode, &rev);
 2:  d9bebd4b4e0 ! 2:  a25aff3ac7c reset: deprecate 'reset.quiet' config option
     @@ Metadata
      Author: Victoria Dye <vdye@github.com>
      
       ## Commit message ##
     -    reset: deprecate 'reset.quiet' config option
     +    reset: remove 'reset.quiet' config option
      
          Remove the 'reset.quiet' config option, remove '--no-quiet' documentation in
          'Documentation/git-reset.txt'. In 4c3abd0551 (reset: add new reset.quiet
 3:  ecd3296fd25 ! 3:  597aa82851c reset: deprecate 'reset.refresh' config option
     @@ Metadata
      Author: Victoria Dye <vdye@github.com>
      
       ## Commit message ##
     -    reset: deprecate 'reset.refresh' config option
     +    reset: remove 'reset.refresh' config option
      
          Remove the 'reset.refresh' option, requiring that users explicitly specify
          '--no-refresh' if they want to skip refreshing the index.
     @@ Documentation/git-reset.txt: OPTIONS
      -	Proactively refresh the index after a mixed reset. If unspecified, the
      -	behavior falls back on the `reset.refresh` config option. If neither
      -	`--[no-]refresh` nor `reset.refresh` are set, refresh is enabled.
     -+	Proactively refresh the index after a mixed reset. Enabled by default.
     ++	Refresh the index after a mixed reset. Enabled by default.
       
       --pathspec-from-file=<file>::
       	Pathspec is passed in `<file>` instead of commandline args. If
 4:  dbb63c4caa8 < -:  ----------- reset: deprecate '--refresh', leaving only '--no-refresh'

-- 
gitgitgadget
