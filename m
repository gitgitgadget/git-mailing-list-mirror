Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECB131F516
	for <e@80x24.org>; Mon,  2 Jul 2018 17:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753130AbeGBRxV (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 13:53:21 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:43057 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752808AbeGBRxV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 13:53:21 -0400
Received: by mail-yw0-f195.google.com with SMTP id l189-v6so563564ywb.10
        for <git@vger.kernel.org>; Mon, 02 Jul 2018 10:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wCQJU/H21G4jhhYBR3zxtQA3mLyWdVDHaqF/Nl3327s=;
        b=c/gbpYhFz+SszveDnwFZt7Eg5I7t6YP4TNOIqVkoyIU4/tPXbZpiRZ8uRB1FJ1qci1
         /hHNlfUlWFJNxI1YOU59U9XG9MoB428qD4367QJahrmV1fexdmmMUPcLGooC4jtBMfXc
         9Z5Ykz5R0zLYJiqMIQL4CeAJr9yTNU4X9XeVg9ggk4ZKsaN3D/3ztQjWgxCByL4X0j7R
         4UIVk7LMF7ZjOsLSqUklb1KcxsoaE4bPm/d3mx/I7A3effsBEGapKdKbTf+rjKnoqZCx
         dueKtm1EOwXl+L1vWvLq2FlJy3TAbkF2JGlgfW5OzQYdCIW0oNTElOvNd07OFfFNCfdQ
         DX9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wCQJU/H21G4jhhYBR3zxtQA3mLyWdVDHaqF/Nl3327s=;
        b=TKDBjkGZ2R9yAe+5/O5SUq5pNEZ08pA1HfPC+vLhQLTZOfGUqTQlIgws5Vlrz1XkMO
         8EMJRdKBNKMKvJj6s90NS5VeNAAiRYNItoijgqoZYkGXpWGchd8G5IVuYrQ2tXoOrQ3G
         feLElftLmOJhOrg06cFIxOyC57jgeBYS1EPOc0Ir0rwHi5OMBKC/MqhfTtPChR+3r0JV
         vwXTkeiZWe3DOeGZcwQMrWwGvOYfdFP/ZlWvzjZPWnnVaYX4C1/4HONMfi50Xz7M4Duj
         ECqlEMsKMdXpv+xo/anQCyVdEWkOd3Z31lg23UxCbeE+58Vd75PrEO1hjLmW4I6pdiEL
         Qdjw==
X-Gm-Message-State: APt69E0XFYp75Ar5gy4bJ9hFHlzh+6FgFEJf1jWZQMqBK1d1yxN7p4Yy
        ammVa6ZdtDBLM0ulYgXgTZdIKG95iSkF2V2WiaEf7Q==
X-Google-Smtp-Source: AAOMgpdEQ+kUXlxywH7cDkmPt0f9RIC7q9EF776PcLsv+UGzWebNkSGK+AIkSjNKpivXAEZpqKO/5qadkYZiDufZmwM=
X-Received: by 2002:a81:3758:: with SMTP id e85-v6mr4812993ywa.340.1530554000263;
 Mon, 02 Jul 2018 10:53:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180702002405.3042-1-sunshine@sunshineco.com> <20180702002405.3042-3-sunshine@sunshineco.com>
In-Reply-To: <20180702002405.3042-3-sunshine@sunshineco.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 2 Jul 2018 10:53:09 -0700
Message-ID: <CAGZ79kamB-bid=RhDj1_vviHtD=5KCWaRJAFXh1RtwGdXgPTWA@mail.gmail.com>
Subject: Re: [PATCH 02/25] t: use test_write_lines() instead of series of
 'echo' commands
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 1, 2018 at 5:24 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> These tests employ a noisy subshell (with missing &&-chain) to feed
> input into Git commands or files:
>
>     (echo a; echo b; echo c) | git some-command ...
>
> Simplify by taking advantage of test_write_lines():
>
>     test_write_lines a b c | git some-command ...

...
and as piped commands only return the exit code of
the last command in the piping structure this is ok,
as all git commands are the last command here.

If any of the non-last commands are failing (which
are the test_write_lines after this patch), we would
only care if the git command fails any way, as there is
no benefit in testing the correctness of test_write_lines.

This is why we chose to go this route instead of
writing the output to a file and then taking the file
as input for the git command. Although this alternative
might be easier to debug, we choose to not use that
as it would complicate this patch even more and these
tests did not need debugging for a long time.

Makes sense.

Stefan
