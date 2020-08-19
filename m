Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4536BC433E3
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 10:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 235C620786
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 10:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEGnU4Sm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgHSKWy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 06:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbgHSKWt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 06:22:49 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479E7C061342
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 03:22:49 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id p20so20965140wrf.0
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 03:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=VEQuEVyTsK8LBex28eVNNy3iU8h18wVz4s60HUwxleI=;
        b=WEGnU4Sm/9FjKGmaY4ZE6JjE5aHWRyJiCySFAc3Y6mIB7/VHL0ziRrKnl0hb2zMpgA
         145rAUag67GI7XsO/NQhDiUw6LnVqkXxsv3nzehFErf9/js0coXLvtvZbMM/7CYOCsVp
         5P3hAGJ0WPFcrgLxPLENgsz4X2LSe7t1B4Tdb36es7l3hd6Vrx3W7aQXnlAh7louieCG
         bkaIFFQE1ZweSq9/+YPHrl76XhVa5sCniWlk+fnxW3lPfQuJ0Ni+ysELCmelvEv4WCju
         jdgw5Av3Kyt2JR/U0LJQ5D/DtKHgMnMCmCajArirliIIrVffwIM0mDz2AOSNcIUt4vJu
         661g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VEQuEVyTsK8LBex28eVNNy3iU8h18wVz4s60HUwxleI=;
        b=QDGdAp4imsgB3JRPcDtXegAJ91isMrI09gZqHULzOHMWLJ0WStmxGBVnA6qfxyIuDK
         tK6MOmZlmBAkhtDWmLgkHKY7z0GLom059gkt15yPFvGb3dtOywVa4/zd2Q1v+jHLHxMV
         ZzXWp1Khe9yNKJmrxYI5b8xQojeeblzGhUbjFhhEbAehsq9O5RvqDC+Adywbi82hENZD
         VCNnoGHuxU1KzlCMdFIQqyxhbGXIraf23f6af5xEJkMA2QnwoQoOHJj1Z9tqjGuUjptr
         pVWPW44TtdBWW2x8mdj9KkzXSq/hLgcUU/ZlAUvC7rzLkA2vH/O1dlBLxt9T//6brzvI
         ua9w==
X-Gm-Message-State: AOAM533jlNjtMy8cBQkDcFvDxJTV7TaXlrfAGPztSEMhwgkhIRmMxkVG
        mpYGYp7M4CaDzqvlzG2rGYhqZG5lXcw=
X-Google-Smtp-Source: ABdhPJzoTVbRCDYhZgkmK/W8ZkVImTU2Nz3lXanMcjiA1qkR1Q/1sprTTW/9qG3900ZF2HBT+7031g==
X-Received: by 2002:a5d:4802:: with SMTP id l2mr23243165wrq.183.1597832567749;
        Wed, 19 Aug 2020 03:22:47 -0700 (PDT)
Received: from [192.168.1.201] (192.252.189.80.dyn.plus.net. [80.189.252.192])
        by smtp.googlemail.com with ESMTPSA id l1sm42158377wrb.12.2020.08.19.03.22.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 03:22:47 -0700 (PDT)
Subject: Re: [PATCH v8 4/5] rebase -i: support --ignore-date
To:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
 <20200817174004.92455-1-phillip.wood123@gmail.com>
 <20200817174004.92455-5-phillip.wood123@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <88535175-0540-c96d-24b5-c4d407422a8c@gmail.com>
Date:   Wed, 19 Aug 2020 11:22:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200817174004.92455-5-phillip.wood123@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/08/2020 18:40, Phillip Wood wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> Rebase is implemented with two different backends - 'apply' and
> 'merge' each of which support a different set of options. In
> particular the apply backend supports a number of options implemented
> by 'git am' that are not implemented in the merge backend. This means
> that the available options are different depending on which backend is
> used which is confusing. This patch adds support for the --ignore-date
> option to the merge backend. This option uses the current time as the
> author date rather than reusing the original author date when
> rewriting commits. We take care to handle the combination of
> --ignore-date and --committer-date-is-author-date in the same way as
> the apply backend.
> 
> Original-patch-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  Documentation/git-rebase.txt   |  7 ++--
>  builtin/rebase.c               | 13 ++++---
>  sequencer.c                    | 66 +++++++++++++++++++++++++++-------
>  sequencer.h                    |  1 +
>  t/t3436-rebase-more-options.sh | 56 +++++++++++++++++++++++++++++
>  5 files changed, 123 insertions(+), 20 deletions(-)
> 
>  [...]
> diff --git a/t/t3436-rebase-more-options.sh b/t/t3436-rebase-more-options.sh
> index 50a63d8ebe..0ede2b8900 100755
> --- a/t/t3436-rebase-more-options.sh
> +++ b/t/t3436-rebase-more-options.sh
> @@ -108,6 +108,62 @@ test_expect_success '--committer-date-is-author-date works when committing confl
>  	test_ctime_is_atime -1
>  '
>  
> +# Checking for +0000 in the author date is sufficient since the
> +# default timezone is UTC but the timezone used while committing is
> +# +0530. The inverted logic in the grep is necessary to check all the
> +# author dates in the file.
> +test_ctime_is_ignored () {
> +	git log $1 --format=%ai >authortime &&
> +	! grep -v +0000 authortime
> +}


I don't know what I was thinking when I wrote that - it should be called
test_atime_is_ignored() as it's testing the author date

Best Wishes

Phillip
