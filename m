Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EDBC4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 08:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5740A20774
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 08:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uQtv8QGh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgJEIJd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 04:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgJEIJd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 04:09:33 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10103C0613CE
        for <git@vger.kernel.org>; Mon,  5 Oct 2020 01:09:33 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id az3so1891985pjb.4
        for <git@vger.kernel.org>; Mon, 05 Oct 2020 01:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Pf95ixpb2WqSDObe7Bw4ry3g8az671FwshR9VoEsHZU=;
        b=uQtv8QGhPNZuOqiJtaawyerd5IYBvZXRvTbKrQefuf3g9c9QSYtX/PApSvJ4n9/w1a
         xOEi54VMfdEGoOWDuKd8VgdCUCMHiJF6V3P4pMsjgl+QSdyF5fOMIBb+pHFYcuuBQVYG
         wA+5b0QpnfImCJJFWjpEuO9b+hc2VjQVNbLXg/ADK1IMC2+0xIK+A6ZOEap6GmAs6PpL
         4H+7tIKnPVxuZ7CF7vz4sZwhLkNBXvHjL1BIacGwiPHWOKBUVqBuTxXiujeSWv1i3zH5
         uIH8CFo/Gr5JQ2bdnBGTf+BmS753Vneu9OOS8s81dl7ClxFVTxrUFqLPQMxXgGDIx/dX
         gF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Pf95ixpb2WqSDObe7Bw4ry3g8az671FwshR9VoEsHZU=;
        b=FXaCoZ93sFpKoOTqKsQv/dIdUM0VTeDkKsThnQdygjKgNRcILEvZ6dPiN4l79Gf2aK
         wu2DhEhoKNeYDysvuNSM8HYMQMFRfCV1oe0aR+cx0Mn5KiJ0uAVFgROCDBts9znpC90g
         pkezqgZOYofvJegh/8tjG2/Fq2QHYfg1ptmq0Q/hu20I6m+poRCulztMjCmjtGhVCJeW
         b/vH8kg/z5baTfrauyXjg9qXiY9StchRBD63u1mTNfzntJl7sh8/vxWJdoNYZMd0Vosm
         EFtwbimdY4HwTceBLFFA/Z7+JbalZL7g3VyRBQnBtgx/Y57iIkh+fZDjTIV8FA9plfeK
         KSww==
X-Gm-Message-State: AOAM5310c54pyDWhg6umqsVPdLVKOiEcel9+cp866xYj616e5euSw5IL
        rEeOkmuOXi1l8+A6Ze2GZrE=
X-Google-Smtp-Source: ABdhPJzzpVDdg3SCYDMHpS4jWsoNf1v9z4PSbRJB82jzmGvDJTO689C4rAE7pcJUffjRojvQsc0rDA==
X-Received: by 2002:a17:90a:248:: with SMTP id t8mr17304337pje.64.1601885372598;
        Mon, 05 Oct 2020 01:09:32 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id i15sm11307354pfk.145.2020.10.05.01.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 01:09:32 -0700 (PDT)
Date:   Mon, 5 Oct 2020 01:09:30 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 6/7] verify_path(): disallow symlinks in .gitattributes
 and .gitignore
Message-ID: <20201005080930.GI1166820@google.com>
References: <20201005071751.GA2290770@coredump.intra.peff.net>
 <20201005072406.GF2291074@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005072406.GF2291074@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> However, it's still a reasonable idea to forbid symlinks for these
> files:
>
>   - As noted, they can still be used to read out-of-repo files (which is
>     fairly restricted, but in some circumstances you can probe file
>     content by speculatively creating files and seeing if they get
>     ignored)
>
>   - They don't currently behave well in all cases. We sometimes read
>     these files from the index, where we _don't_ follow symlinks (we'd
>     just treat the symlink target as the .gitignore or .gitattributes
>     content, which is actively wrong).
>
> This patch forbids symlinked versions of these files from entering the
> index. We already have helpers for obscured forms of the names from
> e7cb0b4455 (is_ntfs_dotgit: match other .git files, 2018-05-11) and
> 0fc333ba20 (is_hfs_dotgit: match other .git files, 2018-05-02), which
> were done as part of the series touching .gitmodules.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I note that neither these new tests nor the existing .gitmodules ones
> confirm that we catch the obscured ntfs/hfs forms in the actual code
> paths (instead, we feed them to a synthetic test-tool helper in t0060).
> I think that's OK, but if we wanted to be super-paranoid we could beef
> up these tests with trickier names.

I think being exhaustive wouldn't be worth it, but perhaps *one*
example (e.g., ".gitmodules ") would not be a terrible idea.

>  read-cache.c              | 12 +++++++++---
>  t/t7450-bad-meta-files.sh | 29 +++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+), 3 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

[...]
> --- a/t/t7450-bad-meta-files.sh
> +++ b/t/t7450-bad-meta-files.sh
> @@ -267,4 +267,33 @@ test_expect_success 'git dirs of sibling submodules must not be nested' '
>  	test_i18ngrep "is inside git dir" err
>  '
>  
> +test_expect_success 'create repo with symlinked .gitattributes file' '
> +	git init symlink-attr &&
> +	target=$(echo target | git -C symlink-attr hash-object -w --stdin) &&
> +	tree=$(
> +		printf "120000 blob $target\t.gitattributes\n" |
> +		git -C symlink-attr mktree
> +	)
> +'
> +
> +test_expect_success 'refuse to load symlinked .gitattributes into index' '
> +	test_must_fail git -C symlink-attr read-tree $tree 2>err &&
> +	test_i18ngrep "invalid path.*gitattributes" err

This tests that it fails but doesn't test that it had no effect.
Would that be straightforward to check as well (e.g. an "ls-files -s"
before and after)?
