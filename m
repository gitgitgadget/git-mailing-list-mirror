Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FE331FBB0
	for <e@80x24.org>; Wed,  7 Dec 2016 10:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752421AbcLGKij (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 05:38:39 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:34723 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751993AbcLGKii (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 05:38:38 -0500
Received: by mail-io0-f196.google.com with SMTP id r94so12500047ioe.1
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 02:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=i6W01d9c49yoOYQzmfEua3M9iSKtVFZd1RExBcK6QXA=;
        b=CltIIPjD/UBi9/5NDu0aJXc5h1ZsxgXBIxkjTPgSiLFDfjh3Ua+Kyq3mSAvL+DAfQD
         Kb17uTZBvOSLyQ6AxI0swILRY37WR3ku7FWAh+RiZeLabyexP4TryNoaSKDpi9oRQvWQ
         XS5n2kc1t7nwc6PzAvBUgPYZTNYh84UgEw3g+2SwkldzLa6uUN7ZGExbnqrGQfJc2ZTS
         nbZC4vy+z9BANb189lJU4BwcKeWrRxpU5kaMvPhA+2jNK3fi9JsHsUbzWVAyaFN01HhC
         /Q8O7so0Q7zH9Ne1PBbQZM+chDoYCTEDcQX9KCVTMZ7oawDX75+NXUP0IIUq+Zd5Gqm5
         HoBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=i6W01d9c49yoOYQzmfEua3M9iSKtVFZd1RExBcK6QXA=;
        b=eyD1uZNNVtFvcrtrOdRiNPr2M5FEImGl9eTyseSDQlBap4o6UpyGUfZ43rsz8exyQh
         N6OkrPem8cc9lYDbQCmeebUymUAzIzRbS9gDNRV4mqMtHFlxLGFOSaMjTQQkCRcF1SUh
         3RbjlzVVL2/dTUXPyYrij40tD0MH3XYMmH9d3E1DdbCQydL2LFXezqER7/Uh2hPb2DSn
         UoeK+nLDt0IRS/tVaiXID82KaOyEQ6n5YBic0/7FkF9aEA2bAe7gALqLiX7a5F9o1xGO
         tkyGPEwFDEgW0CGF76lPU76sE0NmxElEcUr6iWlFNcmLYSeOrx1dU0CccffL9HLG1mHm
         fOuw==
X-Gm-Message-State: AKaTC01tEpfkcCdeQXUZimj8NYCn5p+J7lHYm5xFSR3RM35bTSKXzO9bh9uTxrqn6zMYDFRdxdACrszmRC0Hdw==
X-Received: by 10.36.90.72 with SMTP id v69mr1466994ita.74.1481106276346; Wed,
 07 Dec 2016 02:24:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Wed, 7 Dec 2016 02:24:05 -0800 (PST)
In-Reply-To: <1481061106-117775-4-git-send-email-bmwill@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com> <1481061106-117775-4-git-send-email-bmwill@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 7 Dec 2016 17:24:05 +0700
Message-ID: <CACsJy8BsGVrUoFFFEqdLS-h4XYCkFg-gbx+BeWmGd8srupNWqw@mail.gmail.com>
Subject: Re: [PATCH 03/17] dir: convert fill_directory to use the pathspec
 struct interface
To:     Brandon Williams <bmwill@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 7, 2016 at 4:51 AM, Brandon Williams <bmwill@google.com> wrote:
> Convert 'fill_directory()' to use the pathspec struct interface from
> using the '_raw' entry in the pathspec struct.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  dir.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/dir.c b/dir.c
> index 7df292b..8730a4f 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -188,7 +188,8 @@ int fill_directory(struct dir_struct *dir, const struct pathspec *pathspec)
>         len = common_prefix_len(pathspec);
>
>         /* Read the directory and prune it */
> -       read_directory(dir, pathspec->nr ? pathspec->_raw[0] : "", len, pathspec);
> +       read_directory(dir, pathspec->nr ? pathspec->items[0].match : "",
> +                      len, pathspec);

Or even better, use common_prefix()'s return value here. I took me a
while to realize this code was not buggy. It is fine to just pick the
first item because the first <len> characters of _all_ pathspec items
must be the same. Something like this

prefix = common_prefix(..)
read_directory(..., prefix, strlen(prefix), pathspec);

expresses it much better. Yeah one extra mem allocation, no big deal
since fill_directory() is not called very often.

>         return len;
>  }
>
> --
> 2.8.0.rc3.226.g39d4020
>
-- 
Duy
