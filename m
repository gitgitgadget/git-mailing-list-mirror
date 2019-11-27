Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD74DC432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 16:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9194E2073F
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 16:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSOPJK5v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfK0QnO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 11:43:14 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]:38419 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfK0QnO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 11:43:14 -0500
Received: by mail-wm1-f44.google.com with SMTP id z19so8327979wmk.3
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 08:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=k043pwtmcqvjt+MMKZt+AQtX47x3B/vuhosW5VFpmfc=;
        b=WSOPJK5vUZ64LuIooO+KnCErst6FFabHQ1Z3EHBMKu2ZHMkUkD1BMETxE6JsG/N0vy
         0pQTp87On4/axkoBq8O9dW/MI3/LlyyZ/8w/cRveIWfKd5KJ92XrQiITar92krRPCo4H
         RUX7K8VWvgKTH7m1YoWm/78MkpFGpcv1TTn3wSiMR2hNKV8OzRgpxLx5k/sVuJCFHGdS
         tgNdoaCgJj8CXv8+jYS17nz7KZmEVMBScN9dTBfgTOizlFyoVUZDJsepD8cJqC1qXBEK
         lI9O0DG6d7iMCjNOREvwC4hA8jmUSy+I0W/I15X1q+/zobuTQCbeGwCw9JUpr8h9pjOh
         og6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=k043pwtmcqvjt+MMKZt+AQtX47x3B/vuhosW5VFpmfc=;
        b=CI7PvYRjBfi4Nf2orZe+wKSupTV5GVyiIpOzz/E4ZTdmKx7vYvvSkk1KwAJhLxSnXN
         Kt+tWcl0tD3b+6mafA6ZlvSj2o7af0J3rsPh+HgWsV36YcnUVm8YWzBjfnKtsj04NH73
         WwheJFcKpVuVWi9haOQWr/IZpPHZYAXCEkmnMjcbSrpfQd9aqYmewFvfxqjhKl+CJBDV
         aup2QSi/pizll1nPt28EF/Xgd6z9cIBD9BaQrmGtrYEbFeGz6iL24IN1xvdY4nW/k022
         PusnppDjbO5aOtQi0djpauoMWvN6qo4zIDpQ1vJtDvV8rgvyFslrtBOHhREh8XpgBQW4
         Mzsg==
X-Gm-Message-State: APjAAAU3Uw6WJPPHi/eqd9B/VJolw74EbRr1OoHJeHcMkGuyOCHiuYxj
        mFqVVTamgmi05nOV7G8CPdBB2VSR
X-Google-Smtp-Source: APXvYqzDOAI1FtF+Q982nP2DDJ+6GCYQO06QJl/paNgNrPbuv0uELC2a0b3gM/fZz6cGjbcqrTPl0Q==
X-Received: by 2002:a7b:c216:: with SMTP id x22mr3650629wmi.51.1574872992003;
        Wed, 27 Nov 2019 08:43:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d16sm21627599wrg.27.2019.11.27.08.43.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2019 08:43:11 -0800 (PST)
Message-Id: <pull.477.v2.git.1574872991.gitgitgadget@gmail.com>
In-Reply-To: <pull.477.git.1574848137.gitgitgadget@gmail.com>
References: <pull.477.git.1574848137.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Nov 2019 16:43:08 +0000
Subject: [PATCH v2 0/2] checkout: die() on ambiguous tracking branches
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Please refer to commit messages for details.

Rationale: this issue was standing in my way while working on my 
--pathspec-from-file patches. Since this looks like an oversight, I decided
to fix it.


----------------------------------------------------------------------------

Changes from v1:

1) As suggested, removed parentheses in '&& (num_matches > 1)' 2) As
suggested, added additional checks in test. 3) Added some code comments in
test

Alexandr Miloslavskiy (2):
  parse_branchname_arg(): extract part as new function
  checkout: die() on ambiguous tracking branches

 builtin/checkout.c       | 71 ++++++++++++++++++++++------------------
 t/t2024-checkout-dwim.sh | 28 ++++++++++++++--
 2 files changed, 65 insertions(+), 34 deletions(-)


base-commit: d9f6f3b6195a0ca35642561e530798ad1469bd41
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-477%2FSyntevoAlex%2F%230224(git)_deny_ambiguous_checkout-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-477/SyntevoAlex/#0224(git)_deny_ambiguous_checkout-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/477

Range-diff vs v1:

 1:  c5b92ce3ed = 1:  1e40cc485b parse_branchname_arg(): extract part as new function
 2:  7dde1a3b4e ! 2:  575eeb97ba checkout: die() on ambiguous tracking branches
     @@ -54,7 +54,7 @@
       		    arg);
       	}
       
     -+	if (!remote && (num_matches > 1)) {
     ++	if (!remote && num_matches > 1) {
      +	    if (advice_checkout_ambiguous_remote_branch_name) {
      +		    advise(_("If you meant to check out a remote tracking branch on, e.g. 'origin',\n"
      +			     "you can do so by fully qualifying the name with the --track option:\n"
     @@ -174,17 +174,22 @@
       '
       
      +test_expect_success 'when arg matches multiple remotes, do not fallback to interpreting as pathspec' '
     ++	# create a file with name matching remote branch name
      +	git checkout -b t_ambiguous_branch_and_file &&
      +	>ambiguous_branch_and_file &&
      +	git add ambiguous_branch_and_file &&
      +	git commit -m "ambiguous_branch_and_file" &&
      +
     ++	# modify file to verify that it will not be touched by checkout
      +	test_when_finished "git checkout -- ambiguous_branch_and_file" &&
      +	echo "file contents" >ambiguous_branch_and_file &&
      +	cp ambiguous_branch_and_file expect &&
      +
     -+	test_must_fail git checkout ambiguous_branch_and_file &&
     ++	test_must_fail git checkout ambiguous_branch_and_file 2>err &&
      +
     ++	test_i18ngrep "matched multiple (2) remote tracking branches" err &&
     ++	
     ++	# file must not be altered
      +	test_cmp expect ambiguous_branch_and_file
      +'
      +

-- 
gitgitgadget
