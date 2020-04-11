Return-Path: <SRS0=KYeX=53=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532E0C2BB55
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 13:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22B9B20753
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 13:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiZnnZdH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgDKNk1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Apr 2020 09:40:27 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44504 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbgDKNk1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Apr 2020 09:40:27 -0400
Received: by mail-ed1-f67.google.com with SMTP id cb27so5724800edb.11
        for <git@vger.kernel.org>; Sat, 11 Apr 2020 06:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=I2QxD53Hek/27mu9hkcOwH5T6AhQIvsUkdp57UcarSM=;
        b=HiZnnZdH1S7HEl+bmKuoTqDfaPq8OeInEq3rHwj//jQ26iYZPVlfrTiiVKoceXHsjV
         3gleM/B1je8r9Mn4vBeFoyo2KtUvqFT8M2wJForHpisrYBkAs4iaEOM8dJqpRnkWe+ST
         ho7u/U6YWAMZL7WT4lIFvjcn99UUxdlPGk57dA0UbkzTs6g/RDHGhvFHpwOR3av++ZNA
         1IdLQmrjE1PFCXsiTa2K/tuVAoA23XOdedaju4hmeKu0UIOSh8eGpJCoonQTT5peSHrY
         upkw2JUviwnC81Ggs7SR3CxeNw5MtlGVsIRA6jKIxcKyWstYqSYSipBM+Fzs5jG3nBfr
         RaoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=I2QxD53Hek/27mu9hkcOwH5T6AhQIvsUkdp57UcarSM=;
        b=DlqJXz3ZtYYfrzFxBA7G4BJQGsm5MDPaTSNduc6gxeBsYPuR8+gvmM/Wftr7UHY4Ux
         M1WS9yF+IBeinGUrPUajKVf5XdBdqi5xfN0yGErCKvRhMHxTIjb7Ape4l32OXjY/SeI9
         OmBWxUQw3Hw9el22bk99CFN3YaeY2od7WC9Uf8zJpsDIaQ/ME8YjH5t31fpinS4t9pGO
         pdm5cH27oa6P9NAn6sUfiZcXyijMBJFopoorFomhhCTOA+Nal1jKGwWPaZwxELyFvXey
         zrphb2MgzmvbkL7i6jwfkG+lSW+zV0zRFlEqmVLMT2HU16hv1OwwwOJ7Zb4LwXelBdNa
         KeWw==
X-Gm-Message-State: AGi0PuYhsqU6VWTierTdQhz6/OVt9gsQUIOCcDSPmk5bSj3mPH0rYdK1
        zlphKb2YSFhvtYpWUomk5Nqziysc
X-Google-Smtp-Source: APiQypKu9UtmnaAsfRC7zyXe4lCORqCYJDLaeKu6mvzSWDIZ841SaqQ7+7Wu7+FxfFlClU/fv0Qqbw==
X-Received: by 2002:a17:906:a40f:: with SMTP id l15mr8184403ejz.74.1586612424684;
        Sat, 11 Apr 2020 06:40:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y25sm549703edl.29.2020.04.11.06.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2020 06:40:24 -0700 (PDT)
Message-Id: <pull.603.v3.git.1586612422.gitgitgadget@gmail.com>
In-Reply-To: <pull.603.v2.git.1586516583.gitgitgadget@gmail.com>
References: <pull.603.v2.git.1586516583.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 11 Apr 2020 13:40:19 +0000
Subject: [PATCH v3 0/3] Make the tests that test core.hideDotFiles more robust
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have this feature on Windows where the files starting with a dot can be
marked hidden (whether a file is hidden by default or not is a matter of
naming convention on Unix, but it is an explicit flag on Windows). This
patch improves the regression tests of this feature, and it has been carried
in Git for Windows for over three years.

Junio, I followed your advice, and did one more thing: the function is now
renamed also only in 3/3.

Changes since v2:

 * The first patch is now a true code move, no edits are snuck in.
 * The typo fix, the function rename, and the prereq check are now all done
   as a "cleanup" patch (the third one).

Changes since v1:

 * A preparatory patch now moves and renames is_hidden to 
   test-lib-functions.sh
 * A typo in the function's comment is fixed, while at it.

Johannes Schindelin (3):
  t: consolidate the `is_hidden` functions
  mingw: make test_path_is_hidden more robust
  t: restrict `is_hidden` to be called only on Windows

 t/t0001-init.sh         |  9 +--------
 t/t5611-clone-config.sh | 13 +++----------
 t/test-lib-functions.sh | 10 ++++++++++
 3 files changed, 14 insertions(+), 18 deletions(-)


base-commit: 9fadedd637b312089337d73c3ed8447e9f0aa775
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-603%2Fdscho%2Frobustify-is-hidden-tests-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-603/dscho/robustify-is-hidden-tests-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/603

Range-diff vs v2:

 1:  dd81ea68d6b ! 1:  f13f9f78cda t: consolidate the `is_hidden` functions
     @@ Commit message
          This function is duplicated between two test scripts. It is better to
          move it into `test-lib-functions.sh` so that it is reused.
      
     -    To make it safer to use, we specifically test for the `MINGW` prereq
     -    now, so that it is not used on a non-Windows platform by mistake.
     +    This patch is best viewed with `--color-moved`.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     @@ t/t0001-init.sh: test_expect_success SYMLINKS 're-init to move gitdir symlink' '
       test_expect_success MINGW '.git hidden' '
       	rm -rf newdir &&
       	(
     -@@ t/t0001-init.sh: test_expect_success MINGW '.git hidden' '
     - 		mkdir newdir &&
     - 		cd newdir &&
     - 		git init &&
     --		is_hidden .git
     -+		test_path_is_hidden .git
     - 	) &&
     - 	check_config newdir/.git false unset
     - '
      
       ## t/t5611-clone-config.sh ##
      @@ t/t5611-clone-config.sh: test_expect_success 'clone -c remote.<remote>.fetch=<refspec> --origin=<name>' '
     @@ t/t5611-clone-config.sh: test_expect_success 'clone -c remote.<remote>.fetch=<re
       test_expect_success MINGW 'clone -c core.hideDotFiles' '
       	test_commit attributes .gitattributes "" &&
       	rm -rf child &&
     - 	git clone -c core.hideDotFiles=false . child &&
     --	! is_hidden child/.gitattributes &&
     -+	! test_path_is_hidden child/.gitattributes &&
     - 	rm -rf child &&
     - 	git clone -c core.hideDotFiles=dotGitOnly . child &&
     --	! is_hidden child/.gitattributes &&
     -+	! test_path_is_hidden child/.gitattributes &&
     - 	rm -rf child &&
     - 	git clone -c core.hideDotFiles=true . child &&
     --	is_hidden child/.gitattributes
     -+	test_path_is_hidden child/.gitattributes
     - '
     - 
     - test_done
      
       ## t/test-lib-functions.sh ##
      @@ t/test-lib-functions.sh: test_bitmap_traversal () {
     @@ t/test-lib-functions.sh: test_bitmap_traversal () {
       }
      +
      +# Tests for the hidden file attribute on windows
     -+test_path_is_hidden () {
     -+	test_have_prereq MINGW ||
     -+	BUG "test_path_is_hidden can only be used on Windows"
     -+
     ++is_hidden () {
      +	# Use the output of `attrib`, ignore the absolute path
      +	case "$(attrib "$1")" in *H*?:*) return 0;; esac
      +	return 1
 2:  fc4202cb548 ! 2:  8650936b8d4 mingw: make test_path_is_hidden tests in t0001/t5611 more robust
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    mingw: make test_path_is_hidden tests in t0001/t5611 more robust
     +    mingw: make test_path_is_hidden more robust
      
          This function uses Windows' system tool `attrib` to determine the state
          of the hidden flag of a file or directory.
     @@ Commit message
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## t/test-lib-functions.sh ##
     -@@ t/test-lib-functions.sh: test_path_is_hidden () {
     - 	BUG "test_path_is_hidden can only be used on Windows"
     - 
     +@@ t/test-lib-functions.sh: test_bitmap_traversal () {
     + # Tests for the hidden file attribute on windows
     + is_hidden () {
       	# Use the output of `attrib`, ignore the absolute path
      -	case "$(attrib "$1")" in *H*?:*) return 0;; esac
      +	case "$("$SYSTEMROOT"/system32/attrib "$1")" in *H*?:*) return 0;; esac
 3:  d0c0767a2aa < -:  ----------- t: fix casing of the operating system `Windows`
 -:  ----------- > 3:  b2604459917 t: restrict `is_hidden` to be called only on Windows

-- 
gitgitgadget
