Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510F0C433FE
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 16:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239478AbiCaQEI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 12:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239471AbiCaQEG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 12:04:06 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1437CFBA1
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 09:02:18 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id r9-20020a1c4409000000b0038ccb70e239so1096040wma.3
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 09:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MpxVtijbAgUmE+r0Kmm6bxeZOJEDD8BPrPxfw984AQk=;
        b=YdpHYXIA/rqXsXfH7w2b81GwXhPI0qMmeo6ruhFlzeDI07HincqnNKoOpH/YThlOns
         tm1f1WId41jkzC94irQFPi+FwbiDX2uiF2zFrJP1gtTyHHG9W7hRbFRvHkUeh5d2hYz+
         p7Xpqbd4tKTXWW3rVNIgXeJvhfPKfNNxSShcJIo5aooYoOQ8qe06jCr1J953C8ouEEkL
         3Nz7FmaBzq9JaZtd1eCMpbVzTGrvaf4aVSpIO22N5iMSxVOI/wPngzlMBiy/VOJ3AK4n
         OzlYkjKfoGNi0Ocr94ndShdnLXq0eO+WGBNvlVHV35Lmrnp0LrAspOg48RBVZNHxmIGH
         ulcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MpxVtijbAgUmE+r0Kmm6bxeZOJEDD8BPrPxfw984AQk=;
        b=3KVAh3Hr0kj7ffUy3ckyg3GYqdJlwuuA/vQ5Ij79c+afQJf6sPemYa8YGVOjAtGnnw
         SXFsZ+gUTDIusBQWcBf3k6tN01yelBL+fMxUrVR2x016cgLcdbNx9YHEm44DwXzQNSib
         ++F63+hEj35vsUkx5B1ZBi1nzfAHqoXJgaoI1fmToi0jCmKCqRpU6gbQkcnypQhuHKtq
         UOrac0i/hGGYuUrBQeIiqQQd0fUANP/IBa/RlIRKdt9ymNDSwhuDRyNLzjF7MRmKEnLQ
         P0JXC65OP7JdqIfFohAozRq6H1V90fZrJoh3PWopO+VLTULqU5X1FCm59Cn4SprNV958
         4y6g==
X-Gm-Message-State: AOAM532PogZyWGjWPn1XDq43U7ERlrW7nNcMlTKETPW0BzsKbpSlNMcB
        oWToXLxwh9hQ/LrF7zS/tVQ3X7il/oA=
X-Google-Smtp-Source: ABdhPJyi7RLDZChxtGAHrsHbZ8g+cARC9BFXIcT5CHI3qwf9F2aC/GgYKm0FUGlTGFPDWlsQqe10hQ==
X-Received: by 2002:a05:600c:ac5:b0:38c:9a51:3059 with SMTP id c5-20020a05600c0ac500b0038c9a513059mr5407947wmr.2.1648742536699;
        Thu, 31 Mar 2022 09:02:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e15-20020adfe38f000000b00205dc79d5b7sm4172065wrm.30.2022.03.31.09.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 09:02:16 -0700 (PDT)
Message-Id: <pull.985.v6.git.1648742535.gitgitgadget@gmail.com>
In-Reply-To: <pull.985.v5.git.1648553134.gitgitgadget@gmail.com>
References: <pull.985.v5.git.1648553134.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 31 Mar 2022 16:02:13 +0000
Subject: [PATCH v6 0/2] Support untracked cache with '--untracked-files=all' if configured
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make it possible for users of the -uall flag to git status, either by
preference or by need (eg UI tooling), to benefit from the untracked cache
when they set their 'status.showuntrackedfiles' config setting to 'all'.
This is especially useful for large repos in Windows, where without
untracked cache "git status" times can easily be 5x higher, and GUI tooling
typically does use -uall.

In this sixth version, clarify the main commit message and some of the code
comments, and adjust the logic slightly such that an existing untracked
cache structure, when consistent with the requested flags in the current
run, can be reused even though the current config would set/store/use the
other set of flags on a new untracked cache structure.

I'm comfortable with this patch as-is, but am still interested in any
thoughts as to whether it makes sense and is likely to be accepted to do
this as a simple enhancement as proposed here, or whether people be more
comfortable with a new configuration option, given the potential for worse
performance under specific (and, I believe, vanishingly rare) circumstances.

Tao Klerks (2):
  untracked-cache: test untracked-cache-bypassing behavior with -uall
  untracked-cache: support '--untracked-files=all' if configured

 dir.c                             |  88 ++++++++++++++++++-----
 t/t7063-status-untracked-cache.sh | 113 ++++++++++++++++++++++++++++++
 2 files changed, 185 insertions(+), 16 deletions(-)


base-commit: 805e0a68082a217f0112db9ee86a022227a9c81b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-985%2FTaoK%2Ftaok-untracked-cache-with-uall-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-985/TaoK/taok-untracked-cache-with-uall-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/985

Range-diff vs v5:

 1:  98a4d8f35c5 ! 1:  f27f018493a untracked-cache: test untracked-cache-bypassing behavior with -uall
     @@ Commit message
          '--untracked-files=normal', and it gets ignored when
          '--untracked-files=all' is specified instead.
      
     -    Add explicit tests for this behavior.
     +    Add explicit tests for this known as-designed behavior.
      
          Signed-off-by: Tao Klerks <tao@klerks.biz>
      
     @@ t/t7063-status-untracked-cache.sh: test_expect_success 'untracked cache after se
      +?? three
      +EOF
      +
     -+# Bypassing the untracked cache here is not desirable, but it expected
     -+# in the current implementation
     ++# Bypassing the untracked cache here is not desirable from an
     ++# end-user perspective, but is expected in the current design.
     ++# The untracked cache data stored for a -unormal run cannot be
     ++# correctly used in a -uall run - it would yield incorrect output.
      +test_expect_success 'untracked cache is bypassed with -uall' '
      +	: >../trace.output &&
      +	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
 2:  f60d2c6e36c ! 2:  0095ec49c5f untracked-cache: support '--untracked-files=all' if configured
     @@ Commit message
          untracked-cache: support '--untracked-files=all' if configured
      
          Untracked cache was originally designed to only work with
     -    '--untracked-files=normal', but this causes performance issues for UI
     -    tooling that wants to see "all" on a frequent basis. On the other hand,
     -    the conditions that prevented applicability to the "all" mode no
     -    longer seem to apply.
     +    "--untracked-files=normal", and is bypassed when
     +    "--untracked-files=all" is requested, but this causes performance
     +    issues for UI tooling that wants to see "all" on a frequent basis.
      
     -    The disqualification of untracked cache has a particularly significant
     -    impact on Windows with the defaulted fscache, where the introduction
     -    of fsmonitor can make the first and costly directory-iteration happen
     -    in untracked file detection, single-threaded, rather than in
     -    preload-index on multiple threads. Improving the performance of a
     -    "normal" 'git status' run with fsmonitor can make
     -    'git status --untracked-files=all' perform much worse.
     +    On the other hand, the conditions that altogether prevented
     +    applicability to the "all" mode no longer seem to apply, after
     +    several major refactors in recent years; this possibility was
     +    discussed in
     +    81153d02-8e7a-be59-e709-e90cd5906f3a@jeffhostetler.com and
     +    CABPp-BFiwzzUgiTj_zu+vF5x20L0=1cf25cHwk7KZQj2YkVzXw@mail.gmail.com,
     +    and somewhat confirmed experimentally by several users using a
     +    version of this patch to use untracked cache with -uall for about a
     +    year.
     +
     +    When 'git status' runs without using the untracked cache, on a large
     +    repo, on windows, with fsmonitor, it can run very slowly. This can
     +    make GUIs that need to use "-uall" (and therefore currently bypass
     +    untracked cache) unusable when fsmonitor is enabled, on such large
     +    repos.
      
          To partially address this, align the supported directory flags for the
          stored untracked cache data with the git config. If a user specifies
     @@ dir.c: static void new_untracked_cache(struct index_state *istate)
       		}
       	}
       }
     -@@ dir.c: void remove_untracked_cache(struct index_state *istate)
     - }
     - 
     - static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *dir,
     --						      int base_len,
     --						      const struct pathspec *pathspec,
     --						      struct index_state *istate)
     -+							    int base_len,
     -+							    const struct pathspec *pathspec,
     -+							    struct index_state *istate)
     - {
     - 	struct untracked_cache_dir *root;
     - 	static int untracked_cache_disabled = -1;
      @@ dir.c: static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
       	if (base_len || (pathspec && pathspec->nr))
       		return NULL;
     @@ dir.c: static struct untracked_cache_dir *validate_untracked_cache(struct dir_st
       		return NULL;
       	}
       
     -+	/*
     -+	 * We don't support using or preparing the untracked cache if
     -+	 * the current effective flags don't match the configured
     -+	 * flags.
     -+	 */
     -+	if (dir->flags != new_untracked_cache_flags(istate))
     -+		return NULL;
     -+
      +	/*
      +	 * If the untracked structure we received does not have the same flags
     -+	 * as configured, but the configured flags do match the effective flags,
     -+	 * then we need to reset / create a new "untracked" structure to match
     -+	 * the new config.
     -+	 * Keeping the saved and used untracked cache in-line with the
     -+	 * configuration provides an opportunity for frequent users of
     -+	 * "git status -uall" to leverage the untracked cache by aligning their
     -+	 * configuration (setting "status.showuntrackedfiles" to "all" or
     -+	 * "normal" as appropriate), where previously this option was
     -+	 * incompatible with untracked cache and *consistently* caused
     -+	 * surprisingly bad performance (with fscache and fsmonitor enabled) on
     -+	 * Windows.
     -+	 *
     -+	 * IMPROVEMENT OPPORTUNITY: If we reworked the untracked cache storage
     -+	 * to not be as bound up with the desired output in a given run,
     -+	 * and instead iterated through and stored enough information to
     -+	 * correctly serve both "modes", then users could get peak performance
     -+	 * with or without '-uall' regardless of their
     -+	 * "status.showuntrackedfiles" config.
     ++	 * as requested in this run, we're going to need to either discard the
     ++	 * existing structure (and potentially later recreate), or bypass the
     ++	 * untracked cache mechanism for this run.
      +	 */
      +	if (dir->flags != dir->untracked->dir_flags) {
     -+		free_untracked_cache(istate->untracked);
     -+		new_untracked_cache(istate, dir->flags);
     -+		dir->untracked = istate->untracked;
     ++		/*
     ++		 * If the untracked structure we received does not have the same flags
     ++		 * as configured, then we need to reset / create a new "untracked"
     ++		 * structure to match the new config.
     ++		 *
     ++		 * Keeping the saved and used untracked cache consistent with the
     ++		 * configuration provides an opportunity for frequent users of
     ++		 * "git status -uall" to leverage the untracked cache by aligning their
     ++		 * configuration - setting "status.showuntrackedfiles" to "all" or
     ++		 * "normal" as appropriate.
     ++		 *
     ++		 * Previously using -uall (or setting "status.showuntrackedfiles" to
     ++		 * "all") was incompatible with untracked cache and *consistently*
     ++		 * caused surprisingly bad performance (with fscache and fsmonitor
     ++		 * enabled) on Windows.
     ++		 *
     ++		 * IMPROVEMENT OPPORTUNITY: If we reworked the untracked cache storage
     ++		 * to not be as bound up with the desired output in a given run,
     ++		 * and instead iterated through and stored enough information to
     ++		 * correctly serve both "modes", then users could get peak performance
     ++		 * with or without '-uall' regardless of their
     ++		 * "status.showuntrackedfiles" config.
     ++		 */
     ++		if (dir->untracked->dir_flags != new_untracked_cache_flags(istate)) {
     ++			free_untracked_cache(istate->untracked);
     ++			new_untracked_cache(istate, dir->flags);
     ++			dir->untracked = istate->untracked;
     ++		}
     ++		else {
     ++			/*
     ++			 * Current untracked cache data is consistent with config, but not
     ++			 * usable in this request/run; just bypass untracked cache.
     ++			 */
     ++			return NULL;
     ++		}
      +	}
      +
       	if (!dir->untracked->root) {
     @@ t/t7063-status-untracked-cache.sh: test_expect_success 'untracked cache remains
      +	test_cmp ../trace.expect ../trace.relevant
      +'
      +
     -+# Bypassing the untracked cache here is not desirable, but it expected
     -+# in the current implementation
     ++# Bypassing the untracked cache here is not desirable from an
     ++# end-user perspective, but is expected in the current design.
     ++# The untracked cache data stored for a -all run cannot be
     ++# correctly used in a -unormal run - it would yield incorrect
     ++# output.
      +test_expect_success 'if -uall is configured, untracked cache is bypassed with -unormal' '
      +	test_config status.showuntrackedfiles all &&
      +	: >../trace.output &&

-- 
gitgitgadget
