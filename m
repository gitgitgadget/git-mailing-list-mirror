Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF44C433F5
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 03:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345770AbiCQDS3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 23:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244999AbiCQDSJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 23:18:09 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A8820F72
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 20:16:44 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id h15so5540760wrc.6
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 20:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mPAiyqo835M2uxqJtR+MfG9D42C4eMO+NIVmdLu4nz0=;
        b=NDjJi7pACvgRgF0q70FuC4QjGQsqRpeRP+Zi/hF5DRLIpOPfZmrc6hylWbffheqmIR
         6wCo1QJlSrhzfu91wCIdRPeqi/Dg45SXq09X18NQXGw+/f7UA7VRZFuH9bAVpKEYtMcQ
         gV3vWvnxTe8+n+5SHwLt1x8uOMgpS6zA1CMyf6m65fOq4a1Bznas+m4oDRJ/FslLNtNo
         0OHY6kiVi+X9mzTkRwqsR4BJ9sSuHJzs5QF7W791mhv4NmYxYC/B2MgM9iL2L64y5ufh
         MKBIgd/rNeBZAnT4HeNvFk8mjsW0HRG0fdCLaX+l3aupjD3lbwvNohYSbiFethxRTsp1
         j0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mPAiyqo835M2uxqJtR+MfG9D42C4eMO+NIVmdLu4nz0=;
        b=WlSDKpicSun+zgLpmZ5hSbL8zqD2BCfpWlU7XqLvi5y4cfW7UvTAtheAUdyXmfQk9+
         KAA5k6ng4tFHjs5M2EDEgPQWvqBkImv1np5vSmgNNaTyI8mrXLhOU2wWbIt2XWCJWgpV
         pgmcejZvZJJrmBlQ1Ap4TeZnTNx3ptMddbHh8IWHSnxn4efK9Tm1j79irv94DoTzLnfx
         Sy7YeWNjR6QmjJIMdZy6G1EkISrF6taKvY6ht1FgfiBBGZqqC2uhjs0d2Xb05Oed6RFG
         6YualdC1uNOiTok3kYrTr7PwPCcXVxc3HTTKAPAJ4Xta+uYaI/M3DzBXy4khdQp1IjDn
         7E1A==
X-Gm-Message-State: AOAM530D8byqMBcuVrM1zZ8BZwtPqpOWorPTWxovtnywbknIkkYP8oFG
        W3/flGHiwYJuzAtfNybfKQRHNuV3oA0=
X-Google-Smtp-Source: ABdhPJybTy5EoDBdPB1gyopylutH/lcZB0KS91DYE+Hppfr3VmQKxAbL53u1tE1jmevvW3GWOg/prA==
X-Received: by 2002:a5d:6102:0:b0:203:dcb8:2c6c with SMTP id v2-20020a5d6102000000b00203dcb82c6cmr2177491wrt.655.1647487002729;
        Wed, 16 Mar 2022 20:16:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p3-20020a05600c358300b00389f8158b6bsm6798282wmq.4.2022.03.16.20.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 20:16:42 -0700 (PDT)
Message-Id: <pull.1226.v3.git.git.1647487001.gitgitgadget@gmail.com>
In-Reply-To: <pull.1226.v2.git.git.1647019492.gitgitgadget@gmail.com>
References: <pull.1226.v2.git.git.1647019492.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Mar 2022 03:16:39 +0000
Subject: [PATCH v3 0/2] rebase: update HEAD when is an oid
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fixes a bug [1] reported by Michael McClimon where rebase with oids will
erroneously update the branch HEAD points to.

 1. https://lore.kernel.org/git/xmqqsfrpbepd.fsf@gitster.g/

This patch has two parts:

 * updates rebase setup test to add some tags we will use, while swapping
   out manual commit creation with the test_commit helper
 * sets RESET_HARD_DETACH flag if branch is not a valid refname

changes since v2:

 * remove BUG assertion

changes since v1:

 * only set RESET_HEAD_DETACH if is not a valid branch
 * updated tests to use existing setup

John Cai (2):
  rebase: use test_commit helper in setup
  rebase: set REF_HEAD_DETACH in checkout_up_to_date()

 builtin/rebase.c  |  5 ++++-
 t/t3400-rebase.sh | 18 +++++++++++-------
 2 files changed, 15 insertions(+), 8 deletions(-)


base-commit: b896f729e240d250cf56899e6a0073f6aa469f5d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1226%2Fjohn-cai%2Fjc%2Ffix-rebase-oids-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1226/john-cai/jc/fix-rebase-oids-v3
Pull-Request: https://github.com/git/git/pull/1226

Range-diff vs v2:

 1:  f3f084adfa6 ! 1:  f658eb00bcd rebase: use test_commit helper in setup
     @@ Commit message
          can use. This uses the test_commit helper so we can replace some lines
          that add a commit manually.
      
     +    Setting logAllRefUpdates is not necessary because it's on by default for
     +    repositories with a working tree.
     +
          Helped-by: Phillip Wood <phillip.wood123@gmail.com>
          Signed-off-by: John Cai <johncai86@gmail.com>
      
 2:  0e3c73375c1 ! 2:  bd1c9537ffc rebase: set REF_HEAD_DETACH in checkout_up_to_date()
     @@ builtin/rebase.c: static int checkout_up_to_date(struct rebase_options *options)
       	if (reset_head(the_repository, &ropts) < 0)
       		ret = error(_("could not switch to %s"), options->switch_to);
      
     - ## reset.c ##
     -@@ reset.c: int reset_head(struct repository *r, const struct reset_head_opts *opts)
     - 	if (opts->branch_msg && !opts->branch)
     - 		BUG("branch reflog message given without a branch");
     - 
     -+	if (switch_to_branch && opts->flags & RESET_HEAD_DETACH)
     -+		BUG("attempting to detach HEAD when branch is given");
     -+
     - 	if (!refs_only && repo_hold_locked_index(r, &lock, LOCK_REPORT_ON_ERROR) < 0) {
     - 		ret = -1;
     - 		goto leave_reset_head;
     -
       ## t/t3400-rebase.sh ##
      @@ t/t3400-rebase.sh: test_expect_success 'switch to branch not checked out' '
       	git rebase main other

-- 
gitgitgadget
