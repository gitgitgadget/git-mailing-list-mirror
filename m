Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCFBC83F15
	for <git@archiver.kernel.org>; Mon, 28 Aug 2023 13:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjH1Nw6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 09:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjH1Nwd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 09:52:33 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAC3BA
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 06:52:30 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31aeee69de0so2745852f8f.2
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 06:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693230748; x=1693835548;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdxksK/5ll/6y2KP9sAthF3BhoYDALdUNtoMmzgNuog=;
        b=EthNYw3aSKL3whMXbu+xxdglIMgpen7KErPJV1Vw+4bWhz1iqqw8Rd6ZpUQV+UpHHW
         9jad1Iipu3kKC/BMTgppUEZA9tyNgEHz5k7CzNgFU7MlRpvQaBAZkTJBQe3a1do4vD7e
         +nFl20mJEftYc6drYgYcaJc2BqEotCKbKwZ9LIP/y/TYqcZrWgg9QmgtOwlH9a//tBjn
         Hjc4YfkUALSmcOL3ttoNzvhyw6XzzSVaQsWIJqoF8y2GAjynVaVTqdx+QpwYXNOgIaqP
         yCxqgl/T3jQw8EYORlvswxEF8uTqP9kKSYVAYsBgPZ9n2tNm5YrIfMFhf2T+NBMUXdn7
         QKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693230748; x=1693835548;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cdxksK/5ll/6y2KP9sAthF3BhoYDALdUNtoMmzgNuog=;
        b=MrCJ16RfiegFLZ5VPQScZg7VxfnwO856nEnJcrOoHCHrg7tav9AKRhAnLsCeKyWAYy
         Q9npA4NXlNlUy+ddS5nHEHOXapIlUy3UTbeFLztbuXwOq1/GqaC/Vt4LfKPmYX/IQAIO
         rFiX11PII0wg2/idFSgRCZ35nSPBnLgTh9HsT7Iv+qRhoeYWAZv1LctXV7GoWb/hlg4b
         Rq7nDTFrLGETc8FEzgTqadwFkfzb1oS7W1PMYWzCM8ydBNG18028AbnFsGfLBsV2033N
         EQRVbMMh7Spoje8fwdyiKOzAMBY4ngxFSf6zEWb+H6r1HxktAsXqHdUZPhwdkh+lAwh+
         SUug==
X-Gm-Message-State: AOJu0YxWD/LS/MhTnJjMxoNMuF8LNhrnHjaoOl/Q0Zwmby0TIG2BchyB
        tE5g8f9VypibV1LQ0cx8uYGYxKnyfJI=
X-Google-Smtp-Source: AGHT+IHFjVzHKwQ7UmyW0AL6/DQUGOShn1NXzBmeVdD/o24RQWTp6njMcRqQ3wBFXgxG6VDt48JgSA==
X-Received: by 2002:a5d:5146:0:b0:319:666e:b466 with SMTP id u6-20020a5d5146000000b00319666eb466mr19028478wrt.42.1693230748091;
        Mon, 28 Aug 2023 06:52:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k21-20020a05600c0b5500b003feea62440bsm10680077wmr.43.2023.08.28.06.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 06:52:27 -0700 (PDT)
Message-ID: <pull.1569.v3.git.1693230746.gitgitgadget@gmail.com>
In-Reply-To: <pull.1569.v2.git.1692725056.gitgitgadget@gmail.com>
References: <pull.1569.v2.git.1692725056.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Aug 2023 13:52:23 +0000
Subject: [PATCH v3 0/3] scalar: two downstream improvements
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While updating git-for-windows/git and microsoft/git for the 2.42.0 release
window, a few patches that we've been running in those forks for a while
came to light as something that would be beneficial to the core Git project.
Here are some that are focused on the 'scalar' command.

 * Patch 1 adds a --no-src option to scalar clone to appease users who want
   to use scalar but object to the creation of the src directory.
 * Patches 2 and 3 help when scalar reconfigure -a fails. Patch 2 is a
   possibly helpful change on its own for other uses in the future.


Updates in V3
=============

 * Several commit message edits.
 * An important case that was dropped in v2's patch 2 is reintroduced (even
   though it is modified in patch 3).
 * An error message is added for corrupt Git repositories.


Updates in V2
=============

Thanks, Junio, for the helpful review!

 * In Patch 1, the '--[no-]src' documentation is tightened and the tests
   check the contents of the repository worktree.
 * In Patch 2, the commit message is reworded to be more clear about
   positive values of the enum.
 * In Patch 2, the GIT_DIR_NONE option of the enum is never returned, so it
   does not need to exist. A case in scalar.c referenced it, so it is
   removed as part of the patch (though that case was removed later by patch
   3 anyway).
 * In Patch 2, the discover_git_directory() wrapper is updated to return -1
   instead of 1, as it did before this patch.
 * In Patch 3, the 'failed' variable is renamed to 'succeeded' and the cases
   that update the value are swapped. The return code is set to -1 for any
   error instead of having a custom value based on the return from error()
   or error_errno().

Thanks, -Stolee

Derrick Stolee (3):
  scalar: add --[no-]src option
  setup: add discover_git_directory_reason()
  scalar reconfigure: help users remove buggy repos

 Documentation/scalar.txt |  8 ++++-
 scalar.c                 | 70 +++++++++++++++++++++++++++++-----------
 setup.c                  | 34 +++++++------------
 setup.h                  | 35 ++++++++++++++++++--
 t/t9211-scalar-clone.sh  | 12 +++++++
 5 files changed, 115 insertions(+), 44 deletions(-)


base-commit: a82fb66fed250e16d3010c75404503bea3f0ab61
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1569%2Fderrickstolee%2Fscalar-no-src-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1569/derrickstolee/scalar-no-src-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1569

Range-diff vs v2:

 1:  0b6957beccb ! 1:  e9858b31db6 scalar: add --[no-]src option
     @@ Commit message
          scalar: add --[no-]src option
      
          Some users have strong aversions to Scalar's opinion that the repository
     -    should be in a 'src' directory, even though it creates a clean slate for
     -    placing build outputs in adjacent directories.
     +    should be in a 'src' directory, even though this creates a clean slate
     +    for placing build artifacts in adjacent directories.
      
     -    The --no-src option allows users to opt-out of the default behavior.
     +    The new --no-src option allows users to opt out of the default behavior.
      
          While adding options, make sure the usage output by 'scalar clone -h'
          reports the same as the SYNOPSIS line in Documentation/scalar.txt.
 2:  787af0f9744 ! 2:  3c16fa6897f setup: add discover_git_directory_reason()
     @@ Commit message
      
          Callers attempting to set up a Git directory may want to inform the user
          about the reason for the failure. For that, expose the enum
     -    discovery_result from within setup.c and into cache.h where
     +    discovery_result from within setup.c and move it into cache.h where
          discover_git_directory() is defined.
      
          I initially wanted to change the return type of discover_git_directory()
     @@ Commit message
          It is worth noting that GIT_DIR_NONE is not returned, so we remove this
          option from the enum. We must be careful to keep the successful reasons
          as positive values, so they are given explicit positive values.
     -    Further, a use in scalar.c was previously impossible, so it is removed.
      
          Instead of updating all callers immediately, add a new method,
          discover_git_directory_reason(), and convert discover_git_directory() to
     @@ Commit message
      
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
     - ## scalar.c ##
     -@@ scalar.c: static int cmd_reconfigure(int argc, const char **argv)
     - 				warning(_("removing stale scalar.repo '%s'"),
     - 					dir);
     - 			strbuf_release(&buf);
     --		} else if (discover_git_directory(&commondir, &gitdir) < 0) {
     --			warning_errno(_("git repository gone in '%s'"), dir);
     --			res = -1;
     - 		} else {
     - 			git_config_clear();
     - 
     -
       ## setup.c ##
      @@ setup.c: static const char *allowed_bare_repo_to_string(
       	return NULL;
 3:  7ac7311863d ! 3:  ac234b15755 scalar reconfigure: help users remove buggy repos
     @@ scalar.c: static int cmd_reconfigure(int argc, const char **argv)
      +				succeeded = 1;
      +			}
       			strbuf_release(&buf);
     +-		} else if (discover_git_directory(&commondir, &gitdir) < 0) {
     +-			warning_errno(_("git repository gone in '%s'"), dir);
     +-			res = -1;
      -		} else {
      -			git_config_clear();
      +			goto loop_end;
     @@ scalar.c: static int cmd_reconfigure(int argc, const char **argv)
      +			warning(_("repository at '%s' has different owner"), dir);
      +			goto loop_end;
      +
     ++		case GIT_DIR_INVALID_GITFILE:
     ++		case GIT_DIR_INVALID_FORMAT:
     ++			warning(_("repository at '%s' has a format issue"), dir);
     ++			goto loop_end;
     ++
      +		case GIT_DIR_DISCOVERED:
      +			succeeded = 1;
      +			break;
     @@ scalar.c: static int cmd_reconfigure(int argc, const char **argv)
      +			warning(_("repository not found in '%s'"), dir);
      +			break;
      +		}
     -+
     -+		git_config_clear();
     -+
     -+		the_repository = &r;
     -+		r.commondir = commondir.buf;
     -+		r.gitdir = gitdir.buf;
       
      -			the_repository = &r;
      -			r.commondir = commondir.buf;
      -			r.gitdir = gitdir.buf;
     -+		if (set_recommended_config(1) >= 0)
     -+			succeeded = 1;
     ++		git_config_clear();
       
      -			if (set_recommended_config(1) < 0)
      -				res = -1;
     ++		the_repository = &r;
     ++		r.commondir = commondir.buf;
     ++		r.gitdir = gitdir.buf;
     ++
     ++		if (set_recommended_config(1) >= 0)
     ++			succeeded = 1;
     ++
      +loop_end:
      +		if (!succeeded) {
      +			res = -1;

-- 
gitgitgadget
