Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 485AA1F51C
	for <e@80x24.org>; Sun, 27 May 2018 07:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933856AbeE0HSo (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 May 2018 03:18:44 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:42850 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932993AbeE0HSn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 May 2018 03:18:43 -0400
Received: by mail-qt0-f195.google.com with SMTP id c2-v6so11554636qtn.9
        for <git@vger.kernel.org>; Sun, 27 May 2018 00:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=mdycvGucX07OZmLyj7jfcgosw0m1EZFysRWrJaupkLI=;
        b=Y+Oe2lkQ0MRtcSDyuAs8kZoZcovve4KB4mljnZAaNM9uTZJakgCGFMbF10xFDnIZBT
         QI0gyQ7KTZWDaUIYCqpdcSxvQVAHhG1470O53YgzPZBQewidLrcnTWgXDExbMoaxD5Bl
         SUv9jsWOKv4fqhLBNswpOeC1C1UGZ3ppkMIBPMOzNhNVhIL0NgcpvFq2Eu9iarplzLPO
         CJ37AA5a7pDFP8FaNjEnqmwtwaAC/hALFO7nzahgEC53mjCCqSbkLjHext4fuxcqfzWN
         ml7+nCvj4lvLNbYZNIMOquvVCz365sGp5HPJtWhU49PguX4NDgIgEpD/gadW/U/miRFp
         5p/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=mdycvGucX07OZmLyj7jfcgosw0m1EZFysRWrJaupkLI=;
        b=LfReLSJSgoEJ/4Loc6esgknciMAimtJBqcZwL2p9mDU0abb2F05RnxgXsakCLI79J3
         cQIM/GknSob8meeh45K4TjnZjpPceXx6hs7xsuYHYGfJxCnWR+/UNlKR/NjB7XOATzJq
         XeMNfqPOPvSaQqaFFJBbcqDRl6/feGzGA6OMbclOqvO49rLKq4F3a1p769oBUlGwxkEf
         WBAlMmeWvw80rvhYdp1oNAwcsul686jCvbbxooKAqQrC0afxl69sXFtdXyKQmxGhI51T
         Vfa5iT7yT8Pr00OMX8Cy5t8rurHRq9XPOYBLlHlcSF8FGVdckL48yIZYFx3+XNtUoTIH
         32XA==
X-Gm-Message-State: ALKqPwd1jeneGUz85jZFgFMQYf/tTy/1RXXBa3eS4aDt6feg0zc6k4EZ
        Se/dY9nY9Q/7tldZgwQRSLnBLz2np1d7gZvvufk=
X-Google-Smtp-Source: ADUXVKJ9YVRIE4t9x2IGcHC0sB4ZbdNDmHK3g3mvkqDQX0vA/MozWKyzM0BMDyw/VliSEpSqt8Pt8qyMdYtkrMGv6Ys=
X-Received: by 2002:a0c:9e5a:: with SMTP id z26-v6mr8323129qve.109.1527405523050;
 Sun, 27 May 2018 00:18:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:aa4b:0:0:0:0:0 with HTTP; Sun, 27 May 2018 00:18:42
 -0700 (PDT)
In-Reply-To: <20180526120846.23663-2-pclouds@gmail.com>
References: <20180513175438.32152-1-pclouds@gmail.com> <20180526120846.23663-1-pclouds@gmail.com>
 <20180526120846.23663-2-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 27 May 2018 03:18:42 -0400
X-Google-Sender-Auth: h5f1amw5IJwn_FHCR9XrW6hkzoU
Message-ID: <CAPig+cTrsS6_f9jMx_EnJU9QY4qD12Lc=aM5XnQkheBsPW5zPQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] diff: ignore --ita-[in]visible-in-index when
 diffing worktree-to-tree
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 26, 2018 at 8:08 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> This option is supposed to fix the diff of "diff-files" (not reporting
> ita entries as new files) and "diff-index --cached <tree>" ( showing

s/(\s/(/

> ita entries as present in the index with empty content) but not
> "diff-index <tree>".
>
> When --ita-invisible-in-index is set on "git diff-index <tree>",
> unpack_trees() will eventually call oneway_diff() on the ita entry
> with the same code flow as "diff-index --cached <tree>". We want to
> ignore the ita entry for "diff-index --cached <tree>" but not
> "diff-index <tree>" since the latter will examine and produce a diff
> based on worktree entry's (real) content, not ita index entry's
> (empty) content.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
