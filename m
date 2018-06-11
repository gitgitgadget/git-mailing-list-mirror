Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A1B01F403
	for <e@80x24.org>; Mon, 11 Jun 2018 05:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932359AbeFKF20 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 01:28:26 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:35376 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932313AbeFKF2Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 01:28:25 -0400
Received: by mail-yw0-f193.google.com with SMTP id v131-v6so5940932ywg.2
        for <git@vger.kernel.org>; Sun, 10 Jun 2018 22:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=5hCt2m8KhaXfDCyWdF15kkJvGCp02AGTyO/CmCCEVXo=;
        b=RVcZhtKjUWaO1wNv5bjgDu52M/XOuv+KUtVY0vjTeUmQiVNXPh7cH/Vq3c4tdrZdba
         Mr/MY0jhoed2JjhiIDOe1NLDsVq5C0w92ztoW9cNyGTYq1ddnfIjI325ff6W5A/ahiBf
         sc7p1XYJbEB2e0g2tsipdda/YGk/AZ3qROSSBvC5zRgSSVkxdXFbr/1o8BRM78cb/x0O
         9FOj3J2etOi1weyZkwqty7JjgaKOYCJ0iRVvWuNzubeE+Dae3FLpf06PiNKFKTgaoeo4
         /u9TSNcb6aMUNA9oXfO5g3SmD3RchkD5OssoJkTtNzBzyvKfFePQpCprD0fbkO7vwEbF
         Lc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=5hCt2m8KhaXfDCyWdF15kkJvGCp02AGTyO/CmCCEVXo=;
        b=SwNH2tB3KrZXFnNqqQltCBYJcgKY4b2JbrNOxY8ZKCOyx1VbiX05NOpZsVwvSHOhJH
         fUEU/x//V5WqFKaeP20G7qid1VUKQDDgPh5i1CCEHAvoqrbvDwZUSoq2gxahts7n8WFS
         zLW/uIExPS4ndx+XyTMbRop2Yyy7LcyyvwKlgCgF3uublu1DBZLXn/xYzUy5FOVVRPpk
         ayAeTsf8YWsjD+mmzlonqUF/SbH1o2nrBy/CSM46nfd4E33lfUOpFLD5r++A5rHDg+4g
         +avbIG5bhAT3tLemJlKmXts60ogSV9cm5krotyZG6zPU77shYTa+ZChx/6GmmLLmaPQt
         j/Cw==
X-Gm-Message-State: APt69E0Gjvq1hjq/yu7j1gyFIXc1b16eMfbUjgicEOaeEmR9WH3YEX0r
        faZy+FkE6zEyTNwAeyhMwAaWiWdf7/aJ9zjCfD8=
X-Google-Smtp-Source: ADUXVKKk/qSZGjAYYVOlwN3aq4JySF2y8CF0PpXcKAo9RLzpqEoVrRvcI9Kjo+In6EId0OTUSUZqWUmv+e2OyTYVIJ4=
X-Received: by 2002:a81:4303:: with SMTP id q3-v6mr8990492ywa.98.1528694904632;
 Sun, 10 Jun 2018 22:28:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3dc7:0:0:0:0:0 with HTTP; Sun, 10 Jun 2018 22:28:23
 -0700 (PDT)
In-Reply-To: <20180611044710.GB31642@sigill.intra.peff.net>
References: <20180610143231.7131-1-kirr@nexedi.com> <20180611042016.GA31642@sigill.intra.peff.net>
 <20180611044710.GB31642@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 11 Jun 2018 01:28:23 -0400
X-Google-Sender-Auth: b7b4xFQog-eeUvXtX0mT9B040oA
Message-ID: <CAPig+cT73d0rYoSbt7oHVG4MYHVvjKidP0ogRwV+9F73jcjZEA@mail.gmail.com>
Subject: Re: [PATCH] fetch-pack: don't try to fetch peeled values with --all
To:     Jeff King <peff@peff.net>
Cc:     Kirill Smelkov <kirr@nexedi.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>,
        Takuto Ikuta <tikuta@chromium.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 11, 2018 at 12:47 AM, Jeff King <peff@peff.net> wrote:
> Subject: fetch-pack: don't try to fetch peeled values with --all
> [...]
> Original report and test from Kirill Smelkov.
>
> Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> @@ -506,30 +506,45 @@ test_expect_success 'test missing ref before existing' '
> +test_expect_success 'test --all wrt tag to non-commits' '
> +       blob_sha1=$(echo "hello blob" | git hash-object -t blob -w --stdin) &&
> +       git tag -a -m "tag -> blob" tag-to-blob $blob_sha1 &&
> +       tree_sha1=$(printf "100644 blob $blob_sha1\tfile\n" | git mktree) &&

Perhaps modernize these names to 'blob_oid' and 'tree_oid', or even
simpler, just 'blob' and 'tree'.

> +       git tag -a -m "tag -> tree" tag-to-tree $tree_sha1 &&
> +       mkdir fetchall &&
> +       (
> +               cd fetchall &&
> +               git init &&
> +               git fetch-pack --all .. &&

Simpler:

    git init fetchall &&
    (
        cd fetchall &&
        git fetch-pack --all .. &&

Although, I see that this script already has a mix of the two styles
(simpler and not-so-simple), so...

> +               git cat-file blob $blob_sha1 >/dev/null &&
> +               git cat-file tree $tree_sha1 >/dev/null
> +       )
> +'
