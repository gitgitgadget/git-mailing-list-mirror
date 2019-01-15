Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FDA41F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 18:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730483AbfAOSum (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 13:50:42 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45301 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729019AbfAOSum (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 13:50:42 -0500
Received: by mail-wr1-f68.google.com with SMTP id t6so4140224wrr.12
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 10:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7QNxHh0V6NZ4OhELttapB91UreQq1biUiIsXZXWNpow=;
        b=nFLEtuMVlid49yMXhElsgXUWj5I8RrXTB1iV27hGn6r/bVWyhubrw3lHCN0NTRus++
         pEpuzy5sPvrNhR/pm43CIKE+Tam6DcRGKnJoQwZANs4rHOHAVFFDDJT0x/0M2SV2rjST
         lXJx8cfAkjWPtFeVzOVOFzmCmK4g3SSOUuO4RlvmWoMaWqX7+bGOOTPXmfLf7lx5zhlP
         8OZ2AksTt/KjpNk4PPb0v3OZVFVAQ3Qrd6js7BfhNbPWpxlevQ2KS2sRT4L1pMlXpzqj
         YhwZbDxOlmhZUoDx+V4h7taUV5F988rAT1uylAF874KBd7TFEKhZjG5p1usWKzbZ43lZ
         NOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7QNxHh0V6NZ4OhELttapB91UreQq1biUiIsXZXWNpow=;
        b=hj7+24MXp5wqPMeZKcgfQ4Fqtct2zdM1FFq9AJ1HHLVzpO/gmzXozf2dUBs4wODWv+
         y3ZryQfKCcjxlhrUEmejyHF3hXtCE/422RSIpMSiY7yZkLEnb686gFKX7APfTpg15uUo
         +HWMiB95y6zYNCexq3j3Po+oZXLMJseqPSze9ucOVEZ1bkTKwJulaUtVCixw5jYnnNxc
         jtC//KfUE8oPQeyCWsq51QoUxM7Q2s2NfDTFjV04F+znTMPwFRqTHEoEXKkBWgJtM65K
         DKczg5XGtV6oTZbPBrKHhioSunLPu4kXGE7KpS/4SLQ1EIrdRgLoYhVZD0G+cQT7zPyN
         aAmw==
X-Gm-Message-State: AJcUukdOvSW5jk1DgqHXoMv4Q7ADkS0tAoI1OWHG5hKQoMkfVl8sCwC9
        rlGRxoJVuwIl9YizhBGyiV8=
X-Google-Smtp-Source: ALg8bN6Mvb10FySbMGFY13m4Y5atw9ZtSApi8ESUT6vS3dmHVBej6d7LtxulUgXX1t3AIgisp6ahHg==
X-Received: by 2002:adf:dcd0:: with SMTP id x16mr4238698wrm.143.1547578239927;
        Tue, 15 Jan 2019 10:50:39 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id s132sm15853544wmf.28.2019.01.15.10.50.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 10:50:39 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/1] Be careful about left-over files from git add --edit runs
References: <pull.107.git.gitgitgadget@gmail.com>
Date:   Tue, 15 Jan 2019 10:50:38 -0800
In-Reply-To: <pull.107.git.gitgitgadget@gmail.com> (Johannes Schindelin via
        GitGitGadget's message of "Tue, 15 Jan 2019 07:42:51 -0800 (PST)")
Message-ID: <xmqqef9dsqkh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> J Wyman reported almost a year ago (and I fixed this issue in Git for
> Windows around that time) that the .git/ADD_EDIT.patch file might still lie
> around at the beginning of git add --edit from previous runs, and if the new
> patch is smaller than the old one, the resulting diff is obviously corrupt.
>
> This is yet another Git for Windows patch finally making it to the Git
> mailing list.

Good, finally ;-).  

I didn't realize that "add -e" codepath was so old until today to
check with "git blame" to see how old this bug was (it predates the
transition from builtin-foo.c to builtin/foo.c); it seems that it
was from day one of the feature.

>
> Johannes Schindelin (1):
>   add --edit: truncate the patch file
>
>  builtin/add.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
>
> base-commit: ecbdaf0899161c067986e9d9d564586d4b045d62
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-107%2Fdscho%2Fadd-e-truncate-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-107/dscho/add-e-truncate-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/107
