Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6F0C38A02
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 19:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiJ1T2p (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 15:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiJ1T2o (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 15:28:44 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AB56BD78
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 12:28:42 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id v17so2653756plo.1
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 12:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FsSS/1C+kRvAqLQ59r9jMhY3Afd2f/zM2MGiE8xQMnA=;
        b=HReX2P3q5gvd40xc83Ic48AZDM/e8DCJyqdqtdZaB6nq7OTqK545qpo/YAnsvSHIWS
         55cDi77T9xs87SZGRWch9dOjtS02kHG5Bu2HygQ/BpCP+UIcxL5uEdLwOJInj06OYPUY
         ZuCP1OAprOvbo+e9K1HrrdB2ViHKOYGUQWtfvgsd6wlF793cqfji1I04Z9dbIb7ArIg0
         cM65TJ9KXLw6fQhY65apUX8R9Z64Za78lR6vlHVI9VzUa0FWqETHsOtsZYyuaeDTwfm1
         h14OF6LmFPPeDQAYBQM4yuHGTKGgOhU9lOFsV2u1dFGIENlneT8/D8aG3IV+tuvsdxbs
         uaQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FsSS/1C+kRvAqLQ59r9jMhY3Afd2f/zM2MGiE8xQMnA=;
        b=oOhZGCzQK6iC5zjRL+t5jk7VjzuI5M0zdDdkWq3MqklOyyNwm/bZkajlJrdruQY2PY
         FBh4OFTJt/RH97UvAA84S4ERkO+JLVVmda8NtUdtBXYTA85VSf9Smy4t63UZL7rVTid7
         Mb3NWpb3yq7RloupZUpgYPVU8lBY+nfbNtTlHdGrrUFLtlVe0QuHnoh889mt3KApYymO
         PTpnGICnjAC9UgCvd4TKTYKclNR2pC2IsUuNyqszMbEQRr6rT0Z/AJKg5TKk83eHxncg
         Zy+Qy8uJPySJ1bTfRsF+XcxiXtRS9hCqLDBE2ef4FXCvvHLBvx/XUdZsr/RMQjHauC0c
         2LNQ==
X-Gm-Message-State: ACrzQf3jVqHHtJW5ArI6BttSnd4P/zDwTwQqBmbOSYM5SdHoa8K1m9B2
        tU/Cp7wh2e1dLpCP1Djy6+U=
X-Google-Smtp-Source: AMsMyM45czk7MGiEi8ketMy+3oeU8aeCutnvFvtNn+hSySA8yVW3F/UILQcPWjWJjFZEoY4CZRnvrA==
X-Received: by 2002:a17:902:c944:b0:186:a7d7:c3b with SMTP id i4-20020a170902c94400b00186a7d70c3bmr533904pla.55.1666985322198;
        Fri, 28 Oct 2022 12:28:42 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id z6-20020aa79e46000000b0056cee8af3a5sm786118pfq.29.2022.10.28.12.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 12:28:41 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Simon Gerber via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Simon Gerber <gesimu@gmail.com>
Subject: Re: [PATCH 1/2] tests: add test case for autocorrect in work tree
 for bare clone
References: <pull.1373.git.git.1666970645.gitgitgadget@gmail.com>
        <d0a6eea93b58f5a267352690adde00a5b0f3f089.1666970645.git.gitgitgadget@gmail.com>
Date:   Fri, 28 Oct 2022 12:28:41 -0700
In-Reply-To: <d0a6eea93b58f5a267352690adde00a5b0f3f089.1666970645.git.gitgitgadget@gmail.com>
        (Simon Gerber via GitGitGadget's message of "Fri, 28 Oct 2022 15:24:04
        +0000")
Message-ID: <xmqq4jvniw7q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Simon Gerber via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  t/t9005-help-autocorrect-worktree.sh | 29 ++++++++++++++++++++++++++++

Don't we have existing test script for auto-correction?  Is it
sensible to waste a new fail for this single test?  I doubt it.

Perhaps appending after 9003 a new test instead?

> diff --git a/t/t9005-help-autocorrect-worktree.sh b/t/t9005-help-autocorrect-worktree.sh
> new file mode 100755
> index 00000000000..4fecc8a8e01
> --- /dev/null
> +++ b/t/t9005-help-autocorrect-worktree.sh
> @@ -0,0 +1,29 @@
> +#!/bin/sh
> +
> +test_description='test autocorrect in work tree based on bare repository'
> +. ./test-lib.sh
> +
> +test_expect_success 'setup non-bare' '
> +	echo one >file &&
> +	git add file &&
> +	git commit -m one &&
> +	echo two >file &&
> +	git commit -a -m two
> +'

Wouldn't "test_commit" be simpler to use than rolling our own here?
If we piggy-back on set-up in an existing test script, there
probably is already a history the single test to attempt running
'git staut' can use.  After all, that test does not care an iota
what is in the history.

> +
> +test_expect_success 'setup bare' '
> +	git clone --bare . bare.git &&
> +	cd bare.git

Do not chdir around in a test script, especially in separate steps.

> +'
> +
> +test_expect_success 'setup worktree from bare' '
> +	git worktree add ../bare-wt &&
> +	cd ../bare-wt
> +'

Ditto.

Either do it in a subshell in a single step, or

	(
		git clone --bare . bare.git &&
		cd bare.git &&
		git worktree add ../worktree &&
		cd ../worktree &&
		git -c help.autocorrect=immediate staut
	)

use "git -C <over-there>" form, e.g.

	git clone --bare . bare.git &&
	git -C bare.git worktree add ../worktree &&
	git -C worktree -c help.autocorrect=immediate staut

> +test_expect_success 'autocorrect works in work tree created from bare repo' '

When patch 1/2 is applied without 2/2, this test_expect_success will
not be satisfied, breaking future bisection.

For a small change like this, have the code change *and* test that
verifies the new behaviour in a single step.  That way

 * you do not break bisection.

 * if somebody wants to cherry-pick the fix to an older maintenance
   tracks, they can do so by picking a single unit, fix and
   verification combined together.

 * acceptance or review can be done by checking the end-result and
   then tentatively reverting only the code change with something
   like

	$ git show -- ':!t/' | git apply -R

   and see the test that expects success actually fails without the fix.
