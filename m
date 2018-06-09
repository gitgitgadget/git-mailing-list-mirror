Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB6751F403
	for <e@80x24.org>; Sat,  9 Jun 2018 08:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753158AbeFIIi4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 04:38:56 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:39138 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751581AbeFIIiz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 04:38:55 -0400
Received: by mail-yw0-f194.google.com with SMTP id 81-v6so4865086ywb.6
        for <git@vger.kernel.org>; Sat, 09 Jun 2018 01:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=UoEI/buuyA20isHywqNRJSRokNY33QoMKVnD3myEfCk=;
        b=JgIhwdQVgPGEZk5bQehd/KglvuOQsMTNFCd8SNQsW+x0NMPnMe74Tp330Xae23kSb6
         H+g7rMJMl82OKZ6l9F/SxrgL/awDBtVhcMAApOlojcvuPjGUzGn9xmKH6wtJp7NJapmq
         zW4gVdUa5oWBRcPKrSN9lEkT09LHIwZNHvBan4Z0ZVZDGw+44e2Yh7rkF/eMfIbfe1I3
         R8IDkOmDUTLSaxs0gP7hs5BkaT5yIFxJFeyjqnFP12Ox7NjucRKI6rY2tSdaWioJ9ZCV
         a1TtV4SoCb6a7o+BAFjhoJ23ATVYrrErA+RYOzBWPMY5N669L9RR3TVh5/NbGjW824+l
         PrmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=UoEI/buuyA20isHywqNRJSRokNY33QoMKVnD3myEfCk=;
        b=TNZx8bqoeuoMJyKzAPMojN1IId20my1GrazHNGE+EYQ1s1lbzWCU7vjn+EuZZaI8jE
         D+C9v2IAhezRiq/ZEUZp62OuCtwPmhkse57n5w7zpJxwrx0CH3m6mS5M1XgGf7Rv41+i
         4S9LMZpKc514qGm6lLORurzJzp4Od4xQihmJiVQiFiaa+m5wnqCmA+8p3VW1kGGiSbTp
         MVyt+Xa+RMZbe7MqIYQ7BSTousTYGUFtWl6IKoIzrSBB/Y1HmUodfGTS7piAx0BscAY9
         0HXdK9kDFCE+3RreVjTuf8tngRH+Qlj/I7Q2Gcyz7YCEllnhikAKXG08pLnL4Q70N6Ex
         qpdQ==
X-Gm-Message-State: APt69E3onJ1OlCdK9yfAdEtyYCj9/C05g34TMKqi7irG6kJlmjBe7GXM
        gNTTIW96SAtQrcbZiUuZn6rX7SM+wfQKLmugDuQ=
X-Google-Smtp-Source: ADUXVKJuUTURqB4HhfYVdfajatjK4T+LKHUSzdg+mgA4PRM//zrqH54jYspRqwsX/6KTnYeeaJEN9cq/vomUJzQFkTo=
X-Received: by 2002:a0d:c105:: with SMTP id c5-v6mr5427616ywd.131.1528533534878;
 Sat, 09 Jun 2018 01:38:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3dc7:0:0:0:0:0 with HTTP; Sat, 9 Jun 2018 01:38:54 -0700 (PDT)
In-Reply-To: <20180609083159.GA6158@sigill.intra.peff.net>
References: <20180609083159.GA6158@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 9 Jun 2018 04:38:54 -0400
X-Google-Sender-Auth: pVCflBKdneKDD2BH9B_FPzH3RqI
Message-ID: <CAPig+cTgCD5=96XG=Z5FwOsPbN409DxzAfPy0p=wnoLywu++dw@mail.gmail.com>
Subject: Re: [PATCH] fsck: avoid looking at NULL blob->object
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 9, 2018 at 4:32 AM, Jeff King <peff@peff.net> wrote:
> Commit 159e7b080b (fsck: detect gitmodules files,
> 2018-05-02) taught fsck to look at the content of
> .gitmodules files. If the object turns out not to be a blob
> at all, we just complain and punt on checking the content.
> And since this was such an obvious and trivial code path, I
> didn't even bother to add a test.
> [...]
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/t/t7415-submodule-names.sh b/t/t7415-submodule-names.sh
> @@ -151,4 +151,22 @@ test_expect_success 'fsck detects symlinked .gitmodules file' '
> +test_expect_success 'fsck detects non-blob .gitmodules' '
> +       git init non-blob &&
> +       (
> +               cd non-blob &&
> +
> +               # As above, make the funny directly to avoid index restrictions.

Is there a word missing after "funny"?

> +               mkdir subdir &&
> +               cp ../.gitmodules subdir/file &&
> +               git add subdir/file &&
> +               git commit -m ok &&
> +               tree=$(git ls-tree HEAD | sed s/subdir/.gitmodules/ | git mktree) &&
> +               commit=$(git commit-tree $tree) &&

I see that this is just mirroring the preceding test, but do you need
to assign to variable 'commit' which is never consulted by anything
later in the test?

> +               test_must_fail git fsck 2>output &&
> +               grep gitmodulesBlob output
> +       )
> +'
