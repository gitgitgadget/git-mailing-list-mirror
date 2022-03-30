Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B8FC433F5
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 22:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351575AbiC3WUq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 18:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351566AbiC3WUl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 18:20:41 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9033A286C6
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 15:18:51 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id bi12so44388222ejb.3
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 15:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=BO2tubvdcITZStcqMoUhN7PAaQqOGt7FefsCKbVghRw=;
        b=MHSXPHOkAMll66v2aRCbI7W8w4aMe4YdM3fJsT0xvBFNVkllj9ZqTHBluv5Z45XE/y
         tdZ33hIdsvZ+o491+KbZtUlJYnI4K4gX8u+nFecBm5CsAZoQaQLARuuj0iA0zAHtmsvm
         FAVhbSv16MF+x6rNgG6VT+aPyiOxXZ17N4m9SZOg0wTlrZnMAgVMyQxmmhnOrRBcJeO/
         ouOS5SKHCt6An43WL/XiXz7fMekyjNrARmvnj/Ki1t2NOFOmNntK/PlhrxnL5YUZJvrs
         WagUzM8koHDr+zril2tlB4ob8qwsQ4R/JkSs8frRAgbZ20OwQh7/liuIl2qHd4+eaPub
         KajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=BO2tubvdcITZStcqMoUhN7PAaQqOGt7FefsCKbVghRw=;
        b=76i7Xd0BdWB9UkSPLbkpLugJnnw10MbE/+hHJmXyWRATdBM0fQzmI+DcUtN5eD5lIc
         aggmbVw7YjZN1SAIY7rNPeFbClKD4O3zT5qTnsmbbzgFbWO8140S60UkhgnifkNSjPiR
         0b/jYNwV8gP7XljvE7A6jbngKeqCS2RkTk8nU89EUNCLPdaVcjh4jETvhvCJLj8cIip9
         FF7wTqlICZ4qut7Wtf7R8peYGI7WCGxkRxd+aa8ZQpPMEcpSlz5Q9nuibPBV7x4td6S3
         C5D4GOkShQ4Me+9XHelUo7LBjB5hhXWfDGx1zeiPKHEhVwXXGTAeAGxRsmHsXI03r2oY
         912Q==
X-Gm-Message-State: AOAM531SXKvXPTbV7OVmwUkZu1Pj+D9Ue4d/13dxDsr/a0JGdIs3E39a
        T4teu8YbpvW5Ab8Dgf5qTqr9gU+3EEw=
X-Google-Smtp-Source: ABdhPJz58do4krNitadfgQXPCELW41IXundbd07AXEWH+OmoPcpR5oD5GDmowJuj+Ro0Fl9WSuKP9A==
X-Received: by 2002:a17:907:6d9d:b0:6da:7d4c:287f with SMTP id sb29-20020a1709076d9d00b006da7d4c287fmr1840433ejc.741.1648678729902;
        Wed, 30 Mar 2022 15:18:49 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id sa32-20020a1709076d2000b006df935924c1sm8688299ejc.59.2022.03.30.15.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 15:18:49 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nZgeP-0003Pm-1W;
        Thu, 31 Mar 2022 00:18:49 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Labnan via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Labnann <khalid.masum.92@gmail.com>
Subject: Re: [PATCH] t3501: use test_path_is_* functions
Date:   Thu, 31 Mar 2022 00:11:48 +0200
References: <pull.1195.git.1648676585765.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <pull.1195.git.1648676585765.gitgitgadget@gmail.com>
Message-ID: <220331.86bkxnt77a.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 30 2022, Labnan via GitGitGadget wrote:

> From: Labnann <khalid.masum.92@gmail.com>
>
> Two test -f are present in t3501. They can be replaced with appropriate
> helper function: test_path_is_file
>
> Signed-off-by: Labnann <khalid.masum.92@gmail.com>

Thanks for contributing to git, this is a much needed area of
improvement.

> diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
> index 8617efaaf1e..45492a7ed09 100755
> --- a/t/t3501-revert-cherry-pick.sh
> +++ b/t/t3501-revert-cherry-pick.sh
> @@ -67,7 +67,7 @@ test_expect_success 'cherry-pick after renaming branch' '
>  	git checkout rename2 &&
>  	git cherry-pick added &&
>  	test $(git rev-parse HEAD^) = $(git rev-parse rename2) &&
> -	test -f opos &&
> +	test_path_is_file opos &&
>  	grep "Add extra line at the end" opos &&
>  	git reflog -1 | grep cherry-pick

While perfect shouldn't be the enemy of the good, I think it would also
be a very nice use of review bandwidth to end up with some good
end-state here if possible.

I.e. a pre-existing issue here is:

 * We are hiding the exit code of git due to using "test", see
   c419562860e (checkout tests: don't ignore "git <cmd>" exit code,
   2022-03-07) for one example of how to fixthat.

 * The "test -f" here is really redundant to begin with, because we'd
   get an error from "grep" if opos didn't exist.

 * Ditto ignoring the exit code of "git reflog -1".

> @@ -78,7 +78,7 @@ test_expect_success 'revert after renaming branch' '
>  	git checkout rename1 &&
>  	git revert added &&
>  	test $(git rev-parse HEAD^) = $(git rev-parse rename1) &&
> -	test -f spoo &&
> +	test_path_is_file spoo &&
>  	! grep "Add extra line at the end" spoo &&


Same issues here, except that the "test -f" aka "test_path_is_file"
isn't redundant, as the grep is inverted.

It seems to me (other issues aside) that what this test actually wants
to express is something like this:
	
	diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
	index 8617efaaf1e..00096b75376 100755
	--- a/t/t3501-revert-cherry-pick.sh
	+++ b/t/t3501-revert-cherry-pick.sh
	@@ -78,8 +78,9 @@ test_expect_success 'revert after renaming branch' '
	 	git checkout rename1 &&
	 	git revert added &&
	 	test $(git rev-parse HEAD^) = $(git rev-parse rename1) &&
	-	test -f spoo &&
	-	! grep "Add extra line at the end" spoo &&
	+	git rev-parse initial:oops >expect &&
	+	git rev-parse HEAD:spoo >actual &&
	+	test_cmp expect actual &&
	 	git reflog -1 | grep revert
	 
	 '

I.e. we did a revert of a file we had so that it's the same as in
"initial", but now it's at a different path, which we can exhaustively
do by checking the blob OIDs.

>  	git reflog -1 | grep revert
>  
>
> base-commit: 805e0a68082a217f0112db9ee86a022227a9c81b

