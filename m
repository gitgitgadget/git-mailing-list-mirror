Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50C4C25B4E
	for <git@archiver.kernel.org>; Sun, 22 Jan 2023 06:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjAVGMv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Jan 2023 01:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjAVGMs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2023 01:12:48 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7474CCDFD
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 22:12:44 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id y1so3615660wru.2
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 22:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nrU8/cEIN4YTgZgJeC3HdNmqU6n32Jpq7Vx6L2YCgrg=;
        b=DMi6FP0afybX2UUcbhDVMD5wYa8EjVi/Qk4ZOWffo+WVrklucQe84m8ZnUB/86nXhi
         RQMfONhoeWZn5h9rMvp/b9SgKSkGs9Md9k0DCocn/4DHz7o4cwdSJq+cErBwZl1o2kOW
         /gF9tQkHsNSUI/e/ucx744orpHz3Hnk86zsIcKy5kju77d6v3AF2RnUoR2HnhMpbz9ZN
         wj5QDrFrcEaj7RqzML2vPNUQPFg5ahbNBEpyW1/iokEuT4OgUNBrEHvp8Qp+mbArMDgK
         c4T7qtf7Qjn2MYkg0Y0IgU1JnZc4xIGDr79Qzy6sibWNCHwbbTdlGXACsiFHf+R4wB/k
         /NCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nrU8/cEIN4YTgZgJeC3HdNmqU6n32Jpq7Vx6L2YCgrg=;
        b=03Tv7f05vWfFi46GA5EwZj8/exxLUX5VfVxNy9yXYJFPJOZ/zrJggUffN8HmpHXxKS
         yiC7J/rc6KmxqyCmKrMctVY1klenUo+dyjXz29Tfp+3nddKgo1R80h+/O9fyuXZ9kTJe
         yENvEgmTfiMLXCWMdMN4wCVPH/mg6drvzz0KgXY+qUJZRfvyCZZ/w4RBCTxmlob5n3vc
         ymGzugEWFvBgbdQ+MqeN4+Ic7Xsd6+b2SvdPW3nToTj/uFveDQNAN+x4+lLTmyNNrzH2
         2ksoI/mGCilnC2wS6yAShUm4uZ3FUTP0P+DZOGBfhRgOnJNNZWqqGInAVQjJjw9WnEOc
         Q19Q==
X-Gm-Message-State: AFqh2koNU0rBOgxNVZOtL/EhTT/2FYl8RUIfCdTq/2AQe/YbQbWe5AYc
        UsOO6iZugqCZBfDyswA/EQ9QRSKcE94=
X-Google-Smtp-Source: AMrXdXueG9qTBHg4YpU6ljK5Ty0oM7TBEZQPTwWnrZU+n3/mM13WrYlRsU8+EoVxOAU89snlz1ls8g==
X-Received: by 2002:adf:ee10:0:b0:2bd:d5f5:8820 with SMTP id y16-20020adfee10000000b002bdd5f58820mr17634409wrn.27.1674367962350;
        Sat, 21 Jan 2023 22:12:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id az22-20020adfe196000000b002bddaea7a0bsm23816414wrb.57.2023.01.21.22.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 22:12:41 -0800 (PST)
Message-Id: <pull.1466.v4.git.1674367961.gitgitgadget@gmail.com>
In-Reply-To: <pull.1466.v3.git.1674266126.gitgitgadget@gmail.com>
References: <pull.1466.v3.git.1674266126.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 22 Jan 2023 06:12:31 +0000
Subject: [PATCH v4 0/9] rebase: fix several code/testing/documentation issues around flag
 incompatibilities
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We had a report about --update-refs being ignored when --whitespace=fix was
passed, confusing an end user. These were already marked as incompatible in
the manual, but the code didn't check for the incompatibility and provide an
error to the user.

Folks brought up other flags tangentially when reviewing an earlier round of
this series, and I found we had more that were missing checks, and that we
were missing some testcases, and that the documentation was wrong on some of
the relevant options. So, I ended up getting lots of little fixes to
straighten these all out.

Changes since v3:

 * Corrected the code surrounding --[no-]reapply-cherry-picks, and extended
   the testcases (Thanks to Phillip for pointing out my error)
 * I went ahead and implemented the better error message when the merge
   backend is triggered solely via config options.

Changes since v2:

 * Remove the extra patch and reword the comment in t3422 more thoroughly.
 * Add tests for other flag incompatibilities that were missing
 * Add code that was missing for checking various flag incompatibilities
 * Fix incorrect claims in the documentation around incompatible options
 * A few other miscellaneous fixups noticed while doing all the above

Changes since v1:

 * Add a patch nuking the -C option to rebase (fixes confusion around the
   comment in t3422 and acknowledges the fact that the option is totally and
   utterly useless and always has been. It literally never affects the
   results of a rebase.)

Signed-off-by: Elijah Newren newren@gmail.com

Elijah Newren (9):
  rebase: mark --update-refs as requiring the merge backend
  rebase: flag --apply and --merge as incompatible
  rebase: remove --allow-empty-message from incompatible opts
  rebase: fix docs about incompatibilities with --root
  rebase: add coverage of other incompatible options
  rebase: clarify the OPT_CMDMODE incompatibilities
  rebase: fix formatting of rebase --reapply-cherry-picks option in docs
  rebase: put rebase_options initialization in single place
  rebase: provide better error message for apply options vs. merge
    config

 Documentation/git-rebase.txt           | 77 +++++++++++++-------------
 builtin/rebase.c                       | 72 +++++++++++++++++++-----
 t/t3422-rebase-incompatible-options.sh | 71 ++++++++++++++++++++++--
 3 files changed, 162 insertions(+), 58 deletions(-)


base-commit: 56c8fb1e95377900ec9d53c07886022af0a5d3c2
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1466%2Fnewren%2Frebase-update-refs-imply-merge-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1466/newren/rebase-update-refs-imply-merge-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1466

Range-diff vs v3:

  1:  9089834adea =  1:  8a676e6ec1a rebase: mark --update-refs as requiring the merge backend
  2:  a8b5a0e4fb0 =  2:  cc129b87185 rebase: flag --apply and --merge as incompatible
  3:  f4fbfd40d45 =  3:  9464bbbe9ba rebase: remove --allow-empty-message from incompatible opts
  4:  a1e61ac8f21 =  4:  b702f15ed7c rebase: fix docs about incompatibilities with --root
  5:  48c40c0dda0 !  5:  5e4851e611e rebase: add coverage of other incompatible options
     @@ Commit message
          code checks for some of these, which could result in command line
          options being silently ignored.
      
     +    Also, note that adding a check for autosquash means that using
     +    --whitespace=fix together with the config setting rebase.autosquash=true
     +    will trigger an error.  A subsequent commit will improve the error
     +    message.
     +
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     + ## Documentation/git-rebase.txt ##
     +@@ Documentation/git-rebase.txt: are incompatible with the following options:
     +  * --exec
     +  * --no-keep-empty
     +  * --empty=
     +- * --reapply-cherry-picks
     ++ * --[no-]reapply-cherry-picks
     +  * --edit-todo
     +  * --update-refs
     +  * --root when used without --onto
     +
       ## builtin/rebase.c ##
      @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
       		if (options.fork_point < 0)
       			options.fork_point = 0;
       	}
      +	/*
     -+	 * reapply_cherry_picks is slightly weird.  It starts out with a
     -+	 * value of -1.  It will be assigned a value of keep_base below and
     -+	 * then handled specially.  The apply backend is hardcoded to
     -+	 * behave like reapply_cherry_picks==1, so if it has that value, we
     -+	 * can just ignore the flag with the apply backend.  Thus, we only
     -+	 * really need to throw an error and require the merge backend if
     -+	 * reapply_cherry_picks==0.
     ++	 * The apply backend does not support --[no-]reapply-cherry-picks.
     ++	 * The behavior it implements by default is equivalent to
     ++	 * --no-reapply-cherry-picks (due to passing --cherry-picks to
     ++	 * format-patch), but --keep-base alters the upstream such that no
     ++	 * cherry-picks can be found (effectively making it act like
     ++	 * --reapply-cherry-picks).
     ++	 *
     ++	 * Now, if the user does specify --[no-]reapply-cherry-picks, but
     ++	 * does so in such a way that options.reapply_cherry_picks ==
     ++	 * keep_base, then the behavior they get will match what they
     ++	 * expect despite options.reapply_cherry_picks being ignored.  We
     ++	 * could just allow the flag in that case, but it seems better to
     ++	 * just alert the user that they've specified a flag that the
     ++	 * backend ignores.
      +	 */
     -+	if (options.reapply_cherry_picks == 0)
     -+		imply_merge(&options, "--no-reapply-cherry-picks");
     ++	if (options.reapply_cherry_picks >= 0)
     ++		imply_merge(&options, options.reapply_cherry_picks ? "--reapply-cherry-picks" :
     ++								     "--no-reapply-cherry-picks");
     ++
       	/*
       	 * --keep-base defaults to --reapply-cherry-picks to avoid losing
       	 * commits when using this option.
     @@ t/t3422-rebase-incompatible-options.sh: test_rebase_am_only () {
      +		git checkout B^0 &&
      +		test_must_fail git rebase $opt --no-reapply-cherry-picks A
      +	"
     ++
     ++	test_expect_success "$opt incompatible with --reapply-cherry-picks" "
     ++		git checkout B^0 &&
     ++		test_must_fail git rebase $opt --reapply-cherry-picks A
     ++	"
      +
       	test_expect_success "$opt incompatible with --update-refs" "
       		git checkout B^0 &&
  6:  8664cce6cf7 !  6:  21ae9e05313 rebase: clarify the OPT_CMDMODE incompatibilities
     @@ Documentation/git-rebase.txt: See also INCOMPATIBLE OPTIONS below.
      @@ Documentation/git-rebase.txt: are incompatible with the following options:
        * --no-keep-empty
        * --empty=
     -  * --reapply-cherry-picks
     +  * --[no-]reapply-cherry-picks
      - * --edit-todo
        * --update-refs
        * --root when used without --onto
  7:  0e8b06163f2 =  7:  74a216bf0c0 rebase: fix formatting of rebase --reapply-cherry-picks option in docs
  -:  ----------- >  8:  a8adf7fda61 rebase: put rebase_options initialization in single place
  -:  ----------- >  9:  5cb00e5103b rebase: provide better error message for apply options vs. merge config

-- 
gitgitgadget
