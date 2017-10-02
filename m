Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E53EE20281
	for <e@80x24.org>; Mon,  2 Oct 2017 22:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750949AbdJBWhk (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 18:37:40 -0400
Received: from mail-qt0-f178.google.com ([209.85.216.178]:55271 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750770AbdJBWhj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 18:37:39 -0400
Received: by mail-qt0-f178.google.com with SMTP id i13so9814113qtc.11
        for <git@vger.kernel.org>; Mon, 02 Oct 2017 15:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=P98zobRlPgJwnvl0tCu3FU0iBqgRg1RtwUew1bSsHAs=;
        b=CiC7UUkXZEn9VRVWvOtqQ7WPGhUBl/ZpPQZlc/nx7RLEjwRBkwc5Sljfssh5IIrsbj
         n95bq9lQ8hMmaa7/SZuvc3lFTnXGToE9blkfkgryQeWcPZXnLpW/8iT/LTuLIxQiUzOf
         b8oSlIcqLrSpZsC6zxI8p2VItaixwXRJ3DdYgRe+mKBPbqezKHvSQqPiHTBZMLd1MzF/
         4j8pBKHRbhoVixaX9jWuitjHQgLac5EpjJg6ymvMnOoZqXFJ6Ik3nQ9JakNYYn0oSTxV
         En309jlo65WhTQ4PytvjwZqlhe94ksfU84w/ndMmzxoLPWsWTU0YjR+U5vFMIADH66XS
         lGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=P98zobRlPgJwnvl0tCu3FU0iBqgRg1RtwUew1bSsHAs=;
        b=PSNAqnqOj+/N30paBjC8/WbUuLzWjWHF9CFS9PuOT1wfPvxhpJPp6AGvt+pZM4OUbv
         qSujpsF/OuJC0W+TXLfevI+GURhIpUfuDKSL9BUt6osohk7gM36FpDeJ1JvhOOF6mU2/
         bhPzDTn6msr+1gZ293LCORotpr4MvRmSFm51XWKXmGF8E2Y6JSu3FNYFWCweyKxZyoRR
         P57Kan8on79VIvQRnyd4kFF3Y4ImT7lSd3AfS2w+yHlxojqsR/2WpGQBV4HBJJzZhHz/
         aPteoSMkWXJB23ZMbVE1X74k3GACycJz3+XNtkyYdHIEtoOfw3dZYnvq6vRQuhCUGlQ/
         5xKA==
X-Gm-Message-State: AMCzsaV1+T1rQx/I/Gu2ppIAqAgZPN+xlX99yJFsN2UAxWfNd8foyjFW
        IGXraB+WFVjcYUg/v/RHm0kqJ+3wLg4s0Lrj/GCdIEzp3i8=
X-Google-Smtp-Source: AOwi7QBM26RB+Go1ZnBBZh+QtMdIXr9vnvHFogUwCKsLV1p42GjPcYSe2QRLa8rf6D6ScioonlWJ7mYabPlgtgVvRp0=
X-Received: by 10.200.41.89 with SMTP id z25mr11718562qtz.79.1506983859129;
 Mon, 02 Oct 2017 15:37:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.46 with HTTP; Mon, 2 Oct 2017 15:37:38 -0700 (PDT)
In-Reply-To: <20171001220831.214705-5-sandals@crustytoothpaste.net>
References: <20171001220831.214705-1-sandals@crustytoothpaste.net> <20171001220831.214705-5-sandals@crustytoothpaste.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 2 Oct 2017 15:37:38 -0700
Message-ID: <CAGZ79kaY36mo2bpohO8cknPShOBbZt_tpi_kjoxLHE=cFJ3ROw@mail.gmail.com>
Subject: Re: [PATCH 04/24] refs: convert update_ref and refs_update_ref to use
 struct object_id
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/bisect.c b/bisect.c
> index 96beeb5d13..e8470a2e0f 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -685,11 +685,13 @@ static int bisect_checkout(const struct object_id *bisect_rev, int no_checkout)
>         char bisect_rev_hex[GIT_MAX_HEXSZ + 1];
>
>         memcpy(bisect_rev_hex, oid_to_hex(bisect_rev), GIT_SHA1_HEXSZ + 1);
> -       update_ref(NULL, "BISECT_EXPECTED_REV", bisect_rev->hash, NULL, 0, UPDATE_REFS_DIE_ON_ERR);
> +       update_ref(NULL, "BISECT_EXPECTED_REV", bisect_rev, NULL, 0,
> +                  UPDATE_REFS_DIE_ON_ERR);

The number of characters decrease, yet the line gets an additional
line break. While I don't mind this, the most interesting question that
comes to mind is whether you tried the new clang formatting options
in tree to adapt the indentation? ;)

> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -266,12 +266,12 @@ static int reset_refs(const char *rev, const struct object_id *oid)
>         if (!get_oid("HEAD", &oid_orig)) {
>                 orig = &oid_orig;
>                 set_reflog_message(&msg, "updating ORIG_HEAD", NULL);
> -               update_ref_oid(msg.buf, "ORIG_HEAD", orig, old_orig, 0,
> +               update_ref(msg.buf, "ORIG_HEAD", orig, old_orig, 0,
>                            UPDATE_REFS_MSG_ON_ERR);
>         } else if (old_orig)
>                 delete_ref(NULL, "ORIG_HEAD", old_orig, 0);
>         set_reflog_message(&msg, "updating HEAD", rev);
> -       update_ref_status = update_ref_oid(msg.buf, "HEAD", oid, orig, 0,
> +       update_ref_status = update_ref(msg.buf, "HEAD", oid, orig, 0,
>                                        UPDATE_REFS_MSG_ON_ERR);

At all the other places (of s/update_ref_oid/update_ref/) so far you re-indented
the second line to align. This doesn't align in the first place, so it
shall be good.
