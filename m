Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5430E1F462
	for <e@80x24.org>; Thu,  6 Jun 2019 17:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbfFFRSO (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 13:18:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39405 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfFFRSN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jun 2019 13:18:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id x4so3252307wrt.6
        for <git@vger.kernel.org>; Thu, 06 Jun 2019 10:18:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Iiv/oW89hQ8sO37W1mOot9iGzU03ZVR4d4It3YL5Xo=;
        b=rPij3NaaKfrOpnL2mkXUJsuQlSJjJTEx2sxHL8hZj42KQqGkuh0IqzF2SQDD2zXsSs
         4bJjGTjE5O8gsEnF1e4U+Wsh+7RCAUv9+Lg+cZoiEEmQkfKaj0fRhHjUvtdqG3ljD6PC
         EBhy9BEbSm0PjeQj+IhXjiHEpcEgoY3P/Q/EICkRmh7Uem6DaOi15QLU5MDPlJyEccSb
         VXjK8XLFTodQgYm5c8zMoh73Wh0G59pI4tvZnMswPKAyzdCCYlyyy0eLn5nuAweQzMSZ
         Eg6N1HNNYFLhgsZ1ahOwZ+6fL63PKSSYGVWsYOQQUXcvbHEhIR7RWn+op70X+SAjlfJz
         DOjg==
X-Gm-Message-State: APjAAAXN57hsNJ+5JEDyv0H0yD+94hY310Tj1LUq/5VF9PdiaqDacHOk
        Y4isqQPH4ph0ecoABnOocmZPEeJiZFJSWOqa4qdsYg==
X-Google-Smtp-Source: APXvYqwevw7vSb/bh8w4aPIk6VPF/tfZ34rxB2K4CcmUNf5gAcG/wmIomGUfAbr+OOBeEjsvIVgJBUSt2uzpLzHkng8=
X-Received: by 2002:adf:f84f:: with SMTP id d15mr30213343wrq.53.1559841492141;
 Thu, 06 Jun 2019 10:18:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAH8yC8kynjwT8wbHYV0DpDaMX=AnfmXeOci3uYUnnfsvbq4iRg@mail.gmail.com>
 <CAH8yC8knkXtBii9KhS2iUo908zTx_NyPUgXZhqdwmwEF7Gz8Jg@mail.gmail.com>
In-Reply-To: <CAH8yC8knkXtBii9KhS2iUo908zTx_NyPUgXZhqdwmwEF7Gz8Jg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 6 Jun 2019 13:18:01 -0400
Message-ID: <CAPig+cS98DeSaF6pNqKCn6bAy=jjiTuc3AZpPB2cXm6hQ6vcqQ@mail.gmail.com>
Subject: Re: Git self test failure on Solaris 11.3
To:     Git List <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[forwarding to the Git list]

On Sun, Jun 2, 2019 at 6:23 AM Jeffrey Walton <noloader@gmail.com> wrote:
> On Sun, Jun 2, 2019 at 5:09 AM Jeffrey Walton <noloader@gmail.com> wrote:
> > I'm catching a self test failure on Solaris 11.3. Git 2.21 from sources.
> >
> > ok 8 - check normal git operations: two packs
> > ok 9 - add more packs
> > ok 10 - check normal git operations: mixed mode (two packs + extra)
> > ok 11 - write midx with twelve packs
> > not ok 12 - check normal git operations: twelve packs
> > #
> > #                       midx_git_two_modes "rev-list --objects --all" &&
> > #                       midx_git_two_modes "log --raw" &&
> > #                       midx_git_two_modes "count-objects --verbose" &&
> > #                       midx_git_two_modes "cat-file
> > --batch-all-objects --buffer --batch-check" &&
> > #                       midx_git_two_modes "cat-file
> > --batch-all-objects --buffer --batch-check --unsorted" sorted
> > #
> > ok 13 - verify multi-pack-index success
> > ok 14 - verify bad signature
> > ok 15 - verify bad version
> > ...
>
> Ick, this is bad. Intermittent failure. The second time around it passed.

Jeff Walton reported this to me privately. I'm not familiar with this
code and don't have time presently to investigate it, so I'm
forwarding it to the list in the hope that someone who knows the code
intimately (Stolee) or someone who has touched this code (Peff) might
have some idea about it. The failure is intermittent, so perhaps the
output of some command is not stable sort-wise(?).
