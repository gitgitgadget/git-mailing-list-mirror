Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B06F32027C
	for <e@80x24.org>; Wed, 31 May 2017 00:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751058AbdEaAlc (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 20:41:32 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36095 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751037AbdEaAlb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 20:41:31 -0400
Received: by mail-pf0-f169.google.com with SMTP id m17so1877174pfg.3
        for <git@vger.kernel.org>; Tue, 30 May 2017 17:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cdsfXMN+vvPSFD21t4xay/sbosDLVhiQovRB98l4LPQ=;
        b=Jvoz+q4fb8lr6WEzXMFjT0b+jPUv7esk5SQLtBrZ7gGWl/z0Ocd/YUKTlHWLOL8upW
         mPoXwqGzJc5ZH7Qh5xodaT3xwJPyrzuR0atYYeJtjGinTak/IYAY6J6PgyuWWJH39W21
         FxGotlVfmiDK4sToU5X4hOmE9E9WpCdf0SUQBhcf7p9giyUBhruhdyzexgdEKEVHFTw/
         jPpZ+xLknL8dS8ickLqHAzD8BXHbsg7w6rWWIvd9cwVZL/6fFZFuzpvRNFhSMitX++u2
         P2glg9tFS5p9JRLIVztqKZOMvUmbEK2zT25WMc39D+5ytNtaAM+1cfg1PDnqG2rwsavT
         Wsmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cdsfXMN+vvPSFD21t4xay/sbosDLVhiQovRB98l4LPQ=;
        b=hYPeIcpHu/FonLIttX10vjj5q9Y41hsJ7jpsOykLjhjNcW3+fU9a5EEf7CC2psVNl7
         tlPgNnuh1EWmJxUbQ7pYdJNHVC1pSOEBtHkeX/aMmsCXiRp5NhexhfnLnW+8z5WYPZg5
         IOijEIvnlm4h7MvU+kLcEKFy0x6vqA/aJsXcBM+eQPwjxpKsbmDT9GR4oB9ApkUH3/uI
         m/c13JYEWiUCwQSAUyxA/kbek36nT3fkZmZLDW+5tNhPww2A5ACAsOlwTmmmLl53tP1j
         6az0iHUxQEz+8JmvLXQSwmHMUkZTbZVe0HbZwXH+8YnXDvK3L7tyNgA1oQjfVnTP7AHk
         epeA==
X-Gm-Message-State: AODbwcCY9+N8jewoRYacWxEy2u9kTsUgZMA8U1l+oDRsQdNM1h4fd4dD
        1TT2yra4IYZFrqQP7ZFghHKrVATLxYwcFq8=
X-Received: by 10.84.248.73 with SMTP id e9mr86743045pln.76.1496191290802;
 Tue, 30 May 2017 17:41:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Tue, 30 May 2017 17:41:30 -0700 (PDT)
In-Reply-To: <20170530173109.54904-17-bmwill@google.com>
References: <20170530173109.54904-1-bmwill@google.com> <20170530173109.54904-17-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 30 May 2017 17:41:30 -0700
Message-ID: <CAGZ79kZsQCWkA+bSH2RSdHxiAX2KADJXqQGywmpP-t4BQYMCWw@mail.gmail.com>
Subject: Re: [PATCH 16/33] diff: finish conversion for prepare_temp_file to
 struct object_id
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 30, 2017 at 10:30 AM, Brandon Williams <bmwill@google.com> wrote:
> Signed-off-by: Brandon Williams <bmwill@google.com>

Up to (and including) this commit, the series looks good to me.
Will continue to review this series later.

Thanks,
Stefan

> ---
>  diff.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 084c8b2d0..a8ceeb024 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -3030,13 +3030,13 @@ static struct diff_tempfile *prepare_temp_file(const char *name,
>                         /* we can borrow from the file in the work tree */
>                         temp->name = name;
>                         if (!one->oid_valid)
> -                               sha1_to_hex_r(temp->hex, null_sha1);
> +                               oid_to_hex_r(temp->hex, &null_oid);
>                         else
>                                 oid_to_hex_r(temp->hex, &one->oid);
>                         /* Even though we may sometimes borrow the
>                          * contents from the work tree, we always want
>                          * one->mode.  mode is trustworthy even when
> -                        * !(one->sha1_valid), as long as
> +                        * !(one->oid_valid), as long as
>                          * DIFF_FILE_VALID(one).
>                          */
>                         xsnprintf(temp->mode, sizeof(temp->mode), "%06o", one->mode);
> --
> 2.13.0.219.gdb65acc882-goog
>
