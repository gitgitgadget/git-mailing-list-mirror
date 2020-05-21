Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679C3C433DF
	for <git@archiver.kernel.org>; Thu, 21 May 2020 00:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D7B0205CB
	for <git@archiver.kernel.org>; Thu, 21 May 2020 00:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqdOK2nb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgEUAYn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 20:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbgEUAYm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 20:24:42 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5A3C061A0E
        for <git@vger.kernel.org>; Wed, 20 May 2020 17:24:42 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id r3so2332593qve.1
        for <git@vger.kernel.org>; Wed, 20 May 2020 17:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B8MpFT/ONoyWpLSGakpgJnKC1iFx3nx5RH4qnyaA1G8=;
        b=mqdOK2nbkO134xRCF/f3A6G0XOf/hYdg+3wdbEyjYkKtN6Vp/0lxKrjOjABSpITSpN
         antwV3ixWMLt3TRIgRJ9JopC3FVDfbax9JKgapTkmlzY1K6nIRGGZwiYyynrwLcIsLlj
         7fwVQV6EG66lE8wUeUXI5L3AuvOeq1C5ACyxqP6GUueIz5oqYsC0i/HcvKSJB2b2BFEB
         KATh3hCF75MEkSuyzIJobJsLDJ4eylmKjoBcovYkHANVzjTKd3cOlyexP7G3vRgRak88
         9STrICbCOp/2ULld6bHPVF0MMViV30NHKlzY3V5kWCKyYQpEOwWmcxUrTfc6n1eH+UU6
         WjRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B8MpFT/ONoyWpLSGakpgJnKC1iFx3nx5RH4qnyaA1G8=;
        b=U4W9VZBJZlK5WcrBC3stSxEZzLuA/TfsryRGeE+F+hPnusmgYAijwMySIz3We1FaiH
         f4yZ02bK0JLwPy7niO2gy/IbWRIuGs79WOB3zDsesOYmnB+IVAGKZmiPy3KgYDxO9vaS
         FxUSaLMBQ3yJ1up7GfBBQQejTReMgqH0c/bjbi9hD3WylSQrXz3bvfj4BeugBbKt26f7
         S97pFmfdWTdkqU+JUIud2HnOX0CwRgf5yWBBy6XnkF2UV4TEbGk0vDNq2oqNmdV9xe3z
         SctOhAAYcsCPsZuVS0Ave6s7B0RbidRpXfb9mi1S1cHcf7W8TEuw0RDbxhoXtVSbwKuH
         r76w==
X-Gm-Message-State: AOAM530KC7p+oZmMxcoutgJMl0dv7bFrRpgnyR+zJRtr3EXhOgwx3hsu
        fsoys4b0Wg7eS0hcxqsoJ5vo8S0t
X-Google-Smtp-Source: ABdhPJy1g/1tzMYxDzXu2EpFMrI13rKZ4eghxaP31Oii3aMQTYhgXqDKKhQrPO6SPabcJuCvYwtGBg==
X-Received: by 2002:a0c:8168:: with SMTP id 95mr7707728qvc.68.1590020681356;
        Wed, 20 May 2020 17:24:41 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id w67sm3539023qkb.102.2020.05.20.17.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 17:24:40 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 0/4] t: replace incorrect test_must_fail usage (part 5)
Date:   Wed, 20 May 2020 20:24:14 -0400
Message-Id: <cover.1590019226.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.rc0.114.g141fe7d276
In-Reply-To: <cover.1588162842.git.liu.denton@gmail.com>
References: <cover.1588162842.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

This is mostly a resend of what's currently queued in
"dl/test-must-fail-fixes-5" except with a tiny bit of cleanup on the tip
patch. I'd appreciate a review on this series so that we can finally get
rid of that "Needs review" on the What's Cooking messages ;)


The overall scope of these patches is to replace inappropriate uses of
test_must_fail. IOW, we should only allow test_must_fail to run on `git`
and `test-tool`. Ultimately, we will conclude by making test_must_fail
error out on non-git commands. An advance view of the final series can
be found here[1].

This is the fifth part. It focuses on lib-submodule-update.sh and tests
that make use of it.

The first part can be found here[2]. The second part can be found
here[3]. The third part can be found here[4]. The fourth part can be
found here[5].

Changes since v1.2:

* In "lib-submodule-update: pass OVERWRITING_FAIL", use if-then return
  to reduce the amount of code churn

[1]: (may be rebased at any time) https://github.com/Denton-L/git/tree/ready/cleanup-test-must-fail2
[2]: https://lore.kernel.org/git/cover.1576583819.git.liu.denton@gmail.com/
[3]: https://lore.kernel.org/git/cover.1577454401.git.liu.denton@gmail.com/
[4]: https://lore.kernel.org/git/cover.1585209554.git.liu.denton@gmail.com/
[5]: https://lore.kernel.org/git/cover.1587372771.git.liu.denton@gmail.com/

Denton Liu (4):
  lib-submodule-update: add space after function name
  lib-submodule-update: consolidate --recurse-submodules
  lib-submodule-update: prepend "git" to $command
  lib-submodule-update: pass OVERWRITING_FAIL

 t/lib-submodule-update.sh        | 55 ++++++++++++++++++++++----------
 t/t1013-read-tree-submodule.sh   |  4 +--
 t/t2013-checkout-submodule.sh    |  4 +--
 t/t3426-rebase-submodule.sh      |  8 ++---
 t/t3512-cherry-pick-submodule.sh |  2 +-
 t/t3513-revert-submodule.sh      |  7 +++-
 t/t3906-stash-submodule.sh       |  8 +++--
 t/t4137-apply-submodule.sh       | 10 +++---
 t/t4255-am-submodule.sh          | 10 +++---
 t/t5572-pull-submodule.sh        | 16 +++++-----
 t/t6041-bisect-submodule.sh      |  8 +++--
 t/t7112-reset-submodule.sh       |  6 ++--
 t/t7613-merge-submodule.sh       |  8 ++---
 13 files changed, 92 insertions(+), 54 deletions(-)

Range-diff against v1:
1:  f148526dae = 1:  ba2f642e0f lib-submodule-update: add space after function name
2:  b7d7d0d761 = 2:  16d0a3eb9a lib-submodule-update: consolidate --recurse-submodules
3:  4922e75f2a = 3:  578bab6f1a lib-submodule-update: prepend "git" to $command
4:  a0a8fbd881 ! 4:  48598e3f98 lib-submodule-update: pass OVERWRITING_FAIL
    @@ Commit message
         with a file buffer so that the return code of the first command is not
         lost.
     
    -    This patch can be better viewed with `--ignore-all-space`.
    -
      ## t/lib-submodule-update.sh ##
     @@ t/lib-submodule-update.sh: test_submodule_content () {
      # a removed submodule.
    @@ t/t3513-revert-submodule.sh: git_revert () {
      	git status -su >expect &&
      	ls -1pR * >>expect &&
      	tar cf "$TRASH_DIRECTORY/tmp.tar" * &&
    --	git checkout "$1" &&
    --	git revert HEAD &&
    --	rm -rf * &&
    --	tar xf "$TRASH_DIRECTORY/tmp.tar" &&
    --	git status -su >actual &&
    --	ls -1pR * >>actual &&
    --	test_cmp expect actual &&
    --	git revert HEAD
     +	$OVERWRITING_FAIL git checkout "$1" &&
    -+	if test -z "$OVERWRITING_FAIL"
    ++	if test -n "$OVERWRITING_FAIL"
     +	then
    -+		git checkout "$1" &&
    -+		git revert HEAD &&
    -+		rm -rf * &&
    -+		tar xf "$TRASH_DIRECTORY/tmp.tar" &&
    -+		git status -su >actual &&
    -+		ls -1pR * >>actual &&
    -+		test_cmp expect actual &&
    -+		git revert HEAD
    -+	fi
    - }
    - 
    - KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
    ++		return
    ++	fi &&
    + 	git checkout "$1" &&
    + 	git revert HEAD &&
    + 	rm -rf * &&
     
      ## t/t3906-stash-submodule.sh ##
     @@ t/t3906-stash-submodule.sh: test_description='stash can handle submodules'
    @@ t/t3906-stash-submodule.sh: test_description='stash can handle submodules'
      	git status -su >expect &&
      	ls -1pR * >>expect &&
     -	git read-tree -u -m "$1" &&
    --	git stash &&
    --	git status -su >actual &&
    --	ls -1pR * >>actual &&
    --	test_cmp expect actual &&
    --	git stash apply
     +	$OVERWRITING_FAIL git read-tree -u -m "$1" &&
    -+	if test -z "$OVERWRITING_FAIL"
    ++	if test -n "$OVERWRITING_FAIL"
     +	then
    -+		git stash &&
    -+		git status -su >actual &&
    -+		ls -1pR * >>actual &&
    -+		test_cmp expect actual &&
    -+		git stash apply
    -+	fi
    - }
    - 
    - KNOWN_FAILURE_STASH_DOES_IGNORE_SUBMODULE_CHANGES=1
    ++		return
    ++	fi &&
    + 	git stash &&
    + 	git status -su >actual &&
    + 	ls -1pR * >>actual &&
     
      ## t/t4137-apply-submodule.sh ##
     @@ t/t4137-apply-submodule.sh: test_description='git apply handling submodules'
    @@ t/t6041-bisect-submodule.sh: git_bisect () {
      	tar cf "$TRASH_DIRECTORY/tmp.tar" * &&
      	GOOD=$(git rev-parse --verify HEAD) &&
     -	git checkout "$1" &&
    --	echo "foo" >bar &&
    --	git add bar &&
    --	git commit -m "bisect bad" &&
    --	BAD=$(git rev-parse --verify HEAD) &&
    --	git reset --hard HEAD^^ &&
    --	git submodule update &&
    --	git bisect start &&
    --	git bisect good $GOOD &&
    --	rm -rf * &&
    --	tar xf "$TRASH_DIRECTORY/tmp.tar" &&
    --	git status -su >actual &&
    --	ls -1pR * >>actual &&
    --	test_cmp expect actual &&
    --	git bisect bad $BAD
     +	$OVERWRITING_FAIL git checkout "$1" &&
    -+	if test -z "$OVERWRITING_FAIL"
    ++	if test -n "$OVERWRITING_FAIL"
     +	then
    -+		echo "foo" >bar &&
    -+		git add bar &&
    -+		git commit -m "bisect bad" &&
    -+		BAD=$(git rev-parse --verify HEAD) &&
    -+		git reset --hard HEAD^^ &&
    -+		git submodule update &&
    -+		git bisect start &&
    -+		git bisect good $GOOD &&
    -+		rm -rf * &&
    -+		tar xf "$TRASH_DIRECTORY/tmp.tar" &&
    -+		git status -su >actual &&
    -+		ls -1pR * >>actual &&
    -+		test_cmp expect actual &&
    -+		git bisect bad $BAD
    -+	fi
    - }
    - 
    - test_submodule_switch_func "git_bisect"
    ++		return
    ++	fi &&
    + 	echo "foo" >bar &&
    + 	git add bar &&
    + 	git commit -m "bisect bad" &&
-- 
2.27.0.rc0.114.g141fe7d276

