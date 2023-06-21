Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C2DEB64D7
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 20:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjFUU7L (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 16:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjFUU7K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 16:59:10 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95EF19C
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 13:59:08 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-25eb55668b1so2744635a91.1
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 13:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687381148; x=1689973148;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MPRWorrxpWPAjL9ppgb/AO2D6nMM6aKd/fk+bcq/Pq0=;
        b=bQZuTjrHCghPDcHBdXbK7FOwcvS1rH3q+PyJ1mY8YH7q0jqUTqFEVFY76LSGuY1w+z
         29Qp4MXsTwu6FxRes9iT2ilWYDQYqd3MX3kn+pNfbxh9Iwaul+abFQeld222UmKaKkOR
         Q4DshwVzTDiLImi+sTcdMCRsszCGgqo3rBznCwp9bZSNQxUUqoX3/ZPpWsFeXLRu1Nm+
         yoTv/YokUC4zZn91YkPewCGohRoni7cukZauPtqV2uXyQhSCdkg+kjtffvcjtGweX8tJ
         y64MfUiUDFRESVb3iod/n6d6KsXRrxK5whqPAdJKczTWuwjjLLhilBysEP3SPgHP85iJ
         mGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687381148; x=1689973148;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MPRWorrxpWPAjL9ppgb/AO2D6nMM6aKd/fk+bcq/Pq0=;
        b=Bd3i753Qz0TSrwZWLG+cq2ALBT5vO1eHAfjr/2EZlEt9DsS8kmmxDdnmcYiuF5awU7
         mLLsKYQlCTi8tNJkx1Ms5foYCx+MvDsWFNyZvJtOPpCdn1Gpmj72ioXyUWjAhXcJVxm4
         s0mzWRLICC9udBCtu5psWKkzTeRrMOltiGOjUsjJphGyySQV+/hkbaJiHE09ZaWybS7i
         2+mjynLPdnQ+adnXOtnp3kGvY6R+ICW81w9Dwn1X1Kk9Cb+7NCmXLZgBCmfSMaQrp2p5
         0jL227hE/hhsRKrwzYSy7I3xJaPywg8ns5gyLNATIe/AAhkHDQMtNh7L73WEZcFkOnKU
         CZ4w==
X-Gm-Message-State: AC+VfDzP084hhQoWSa68duj5puLOjZ/8ndQhyVUqYgBAhuS41RAG8XPG
        +puQKZWJo+rucCLoWnAr/hEPkkXUKkSgfA==
X-Google-Smtp-Source: ACHHUZ7OKyCkcoFNY4C9/8ffLKrrKKMeSVv0ct+SkW54e4VsA57YgKtZeXntLDhBKZvOiCxy0EjLATlxKDb9Gw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:90b:a58:b0:260:d06c:2672 with SMTP id
 gw24-20020a17090b0a5800b00260d06c2672mr792333pjb.7.1687381148266; Wed, 21 Jun
 2023 13:59:08 -0700 (PDT)
Date:   Wed, 21 Jun 2023 13:59:06 -0700
In-Reply-To: <a836b049b900fa9d7c03ed5426a28b5cc754d4c5.1682089075.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
References: <pull.1492.git.1679237337683.gitgitgadget@gmail.com>
 <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com> <a836b049b900fa9d7c03ed5426a28b5cc754d4c5.1682089075.git.gitgitgadget@gmail.com>
Message-ID: <kl6ljzvwr0px.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 6/6] rebase -i: fix adding failed command to the todo list
From:   Glen Choo <chooglen@google.com>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Haller <lists@haller-berlin.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> When rebasing commands are moved from the todo list in "git-rebase-todo"
> to the "done" file (which is used by "git status" to show the recently
> executed commands) just before they are executed. This means that if a
> command fails because it would overwrite an untracked file it has to be
> added back into the todo list before the rebase stops for the user to
> fix the problem.
>
> Unfortunately when a failed command is added back into the todo list
> the command preceding it is erroneously appended to the "done" file.
> This means that when rebase stops after "pick B" fails the "done"
> file contains
>
> 	pick A
> 	pick B
> 	pick A
>
> instead of
>
> 	pick A
> 	pick B

It's very interesting that an _earlier_ line would get appended on the
_other_ side, I'd expect that even if lines get duplicated, their
relative order would be preserved. I was not able to trace the sequence
of events that got us here, so I could not make a connection from that
to the solution. I didn't dig deeply into this patch either, so I will
refrain from commenting on the solution.

> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index a657167befd..653c19bc9c8 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1276,18 +1276,23 @@ test_expect_success 'todo count' '
>  '
>  
>  test_expect_success 'rebase -i commits that overwrite untracked files (pick)' '
> -	git checkout --force branch2 &&
> +	git checkout --force A &&
>  	git clean -f &&
> +	cat >todo <<-EOF &&
> +	exec >file2
> +	pick $(git rev-parse B) B
> +	pick $(git rev-parse C) C
> +	pick $(git rev-parse D) D
> +	exec cat .git/rebase-merge/done >actual
> +	EOF
>  	(
> -		set_fake_editor &&
> -		FAKE_LINES="edit 1 2" git rebase -i A
> +		set_replace_editor todo &&
> +		test_must_fail git rebase -i A
>  	) &&
> -	test_cmp_rev HEAD F &&
> -	test_path_is_missing file6 &&
> -	>file6 &&
> -	test_must_fail git rebase --continue &&
> -	test_cmp_rev HEAD F &&
> -	rm file6 &&
> +	test_cmp_rev HEAD B &&
> +	head -n3 todo >expect &&
> +	test_cmp expect .git/rebase-merge/done &&
> +	rm file2 &&

I didn't look into how the test works, but I confirmed that it tests the
exact scenario described in the commit message.

