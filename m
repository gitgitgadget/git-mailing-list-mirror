Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516FCC433FE
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 21:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiKOVkU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 16:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiKOVkS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 16:40:18 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DF2FE0
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 13:40:16 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id r81so11796915iod.2
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 13:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tfuN71KgTcj6ceuDIOm3CbjIn67NfH+qQJ+oWPTJBc4=;
        b=3a8bXFH1eZp/xPxCLXb2VEUjcHzPRoC+dg97DkEyrvTT80IQpBf02eS/7B6TCOIoe/
         HjKxsHr2cuJX3y3oXEEbhUiKiJ2GQf1VWhXS2iQyhl2NGzeca+q4gHtT1AM1Wur75F+k
         02chyEdHVhcG4wfsRro2+639C27u8r+rHv6axjbQnr+NnYGzZ2uWuauJ2AbY55zEG8oM
         BRGxv1mlF24QsSgjODRAQ2zFbcB+CU88TCRYIIgv7yFHpOUPl1wzC6mzLcABS8o9iPOO
         WelDaEqVty9v9fTCBh0OR/DZE2Oqsc46ARhQKEwJvxPg/iB6tHpfnk2zIYDN4dmKOgw4
         VUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tfuN71KgTcj6ceuDIOm3CbjIn67NfH+qQJ+oWPTJBc4=;
        b=ic/GSK6+w9jDapqGdFizJJhDX67muJK3ONwckli0e20aOY269geVukGuh2Sb1FJ9pd
         thGqyQXEk1rqA9hCn6VzpnQg1ULO6+aTVOg2QJzrNkEPN57C+2sutEyMAQJ9hbmHn2C+
         jJ/vObXKxFE5d7UMHUjISA/HcxNlyHZBnI89Z/Jigt9pSFiRtN2ZBy4awYyj+jewOl0b
         gr5x75qfTJL/gwyAhew/brrPCaMDJExSyT/2KnvsF6qDYcbji0v24FemV2zm4JKLhNZc
         8saHtvB4ddQLOzZv+bVNiW8BXQM6xSqELB3Ot463H73bVlmNm+g949gUZwfbd0UybHXP
         Wqmw==
X-Gm-Message-State: ANoB5pmmwO3EPu2v3GY4rnrqGeUoHvaZC0MYsPhXcn+8bvrlKxCNkp57
        JxLMG7Os7dgYNnEdeMgXLSrvQA==
X-Google-Smtp-Source: AA0mqf5h09U1UmLbhcwvDhuAVauvUCtAxnQaQJvmMN4HdV+ItX9ze1HttKSFQCDSHBneCNAClfxZ3w==
X-Received: by 2002:a05:6602:482:b0:6c4:ad4d:b23a with SMTP id y2-20020a056602048200b006c4ad4db23amr8197339iov.2.1668548415515;
        Tue, 15 Nov 2022 13:40:15 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o15-20020a056602124f00b006bba42f7822sm5680238iou.52.2022.11.15.13.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 13:40:14 -0800 (PST)
Date:   Tue, 15 Nov 2022 16:40:13 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Siddharth Asthana <siddharthasthana31@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
        johncai86@gmail.com, Johannes.Schindelin@gmx.de, avarab@gmail.com
Subject: Re: [PATCH v4 2/3] cat-file: add mailmap support to --batch-check
 option
Message-ID: <Y3QHPYiZl7PbyFhP@nand.local>
References: <20220916205946.178925-1-siddharthasthana31@gmail.com>
 <20221113212830.92609-1-siddharthasthana31@gmail.com>
 <20221113212830.92609-3-siddharthasthana31@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221113212830.92609-3-siddharthasthana31@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 14, 2022 at 02:58:29AM +0530, Siddharth Asthana wrote:
> @@ -1051,4 +1051,34 @@ test_expect_success 'git cat-file -s returns correct size with --use-mailmap for
>  	test_cmp expect actual
>  '
>
> +test_expect_success 'git cat-file --batch-check returns correct size with --use-mailmap' '
> +	test_when_finished "rm .mailmap" &&
> +	cat >.mailmap <<-\EOF &&
> +	C O Mitter <committer@example.com> Orig <orig@example.com>
> +	EOF
> +	cat >expect <<-\EOF &&
> +	92d99959b011b1cd69fe7be5315d6732fe302575 commit 209
> +	92d99959b011b1cd69fe7be5315d6732fe302575 commit 220
> +	EOF
> +	echo "HEAD" >in &&
> +	git cat-file --batch-check <in >actual &&
> +	git cat-file --use-mailmap --batch-check <in >>actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git cat-file --batch-command returns correct size with --use-mailmap' '
> +	test_when_finished "rm .mailmap" &&
> +	cat >.mailmap <<-\EOF &&
> +	C O Mitter <committer@example.com> Orig <orig@example.com>
> +	EOF
> +	cat >expect <<-\EOF &&
> +	92d99959b011b1cd69fe7be5315d6732fe302575 commit 209
> +	92d99959b011b1cd69fe7be5315d6732fe302575 commit 220
> +	EOF
> +	echo "info HEAD" >in &&
> +	git cat-file --batch-command <in >actual &&
> +	git cat-file --use-mailmap --batch-command <in >>actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done

These two tests (and the -s ones above it) are not going to work when
run under SHA-256 mode, i.e., with 'GIT_TEST_DEFAULT_HASH=sha256' in the
environment:

  not ok 66 - git cat-file -s returns correct size with --use-mailmap
  not ok 67 - git cat-file -s returns correct size with --use-mailmap for tag objects
  not ok 68 - git cat-file --batch-check returns correct size with --use-mailmap
  not ok 69 - git cat-file --batch-command returns correct size with --use-mailmap

Thanks,
Taylor
