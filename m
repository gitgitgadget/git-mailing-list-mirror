Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C85FB1F406
	for <e@80x24.org>; Thu, 28 Dec 2017 19:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753698AbdL1TuH (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 14:50:07 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39649 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750854AbdL1TuG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Dec 2017 14:50:06 -0500
Received: by mail-wm0-f68.google.com with SMTP id i11so45185890wmf.4
        for <git@vger.kernel.org>; Thu, 28 Dec 2017 11:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=mNUVeJhGIUgiMyTAPkqgT6zT2qFC1IFeOXIdI3XNQBA=;
        b=AJGGNzcrXHC8CwgOtAHsC6PONKEL0t5mMle1FfzuE2KK53Kvwhp2EGqdVCZ40srJQs
         GWKlcCgkJD5QaErJGBCgDB0+0jBS+vSGIsBsO1hWE1YMusZvkRW3tCNYa/0sw65oq8sX
         LcavKxxDpKEJYrrdJdoCrnwgK8ly4Mpq5WY1cXZFY6IxT3Ft6vTO5/aoEqGJjUGxh9+3
         +Gzu7d5AvsiJOJ3q/5w0Eoc/en1RkO0eHF3xA0v6WqyJzqzuwfgvqJMINvKvoCT4fili
         mFINd6cCbpUPdssqkOcqp2xAXO77Haws5nBSTyxqB6ostXpHvgR7EtQDSNL0c7S17eVs
         k13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=mNUVeJhGIUgiMyTAPkqgT6zT2qFC1IFeOXIdI3XNQBA=;
        b=qu4euwT5TKJsBaltNLaErHjPNa74vMRLp+0NcjJE/vFogdowbahF0TYBb1KhyV7R2m
         rUEJlNCaFVCHit+Oe9Fm9ezY6a/DYq5Jp0V9plK/XQuaZ3UYUTs+8vFiZ1h6GhZIKizh
         rlxrc3GIAH9PMSQx7gMB4itrJrhl/ykjWV0gH3nNCSTo2ix61ubO4fCyFUvNIhr5GVCW
         oE/AXGC3H2rS6ZMwvNJoxP1M9wcLgfLjP9QTMn/TW7EZviNJsYGoPkOg+q0zLKx9pJMY
         AD1uftdyOeoMlfCKPBGzdW/aP8wuiUhcYi4nK6L3bMHk8CyrFnPw13vGKwukGEuJE1nP
         B8bw==
X-Gm-Message-State: AKGB3mJX7vqDee4noIJTZVJNqfqNIjoZm56+qmR2mYfN37AOw6MzE8vl
        uhm5vHQZSDgkUmGxxHWgByM=
X-Google-Smtp-Source: ACJfBotiOdw8U82bBNoIzFLbg7bKd5QLRfikzvxwOS8FQQcUOD/WR8Cynv2zKaFwZh3j7Yk44qc7nA==
X-Received: by 10.80.170.24 with SMTP id o24mr42782526edc.40.1514490604941;
        Thu, 28 Dec 2017 11:50:04 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id v15sm28040138edb.41.2017.12.28.11.50.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Dec 2017 11:50:03 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] dir.c: avoid stat() in valid_cached_dir()
References: <20171228002807.22388-1-pclouds@gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20171228002807.22388-1-pclouds@gmail.com>
Date:   Thu, 28 Dec 2017 20:50:02 +0100
Message-ID: <87h8sar5sl.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 28 2017, Nguyễn Thái Ngọc Duy jotted:

> stat() may follow a symlink and return stat data of the link's target
> instead of the link itself. We are concerned about the link itself.
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  I noticed this while looking at the untracked cache bug [1] but
>  because it's not directly related to that bug, I'm submitting it
>  separately here.
>
>  [1] https://public-inbox.org/git/CACsJy8AmbKSp0mDLRaDCWn45veeNc03B-Gq8r8PQPrDt9bM_EA@mail.gmail.com/

I'm slowly trying to piece together a re-submission of this whole
series, if this is a bug and not just an optimziation shouldn't there be
some test case that demonstrates this bug?

>  dir.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/dir.c b/dir.c
> index 7c4b45e30e..edcb7bb462 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1809,7 +1809,7 @@ static int valid_cached_dir(struct dir_struct *dir,
>  	 */
>  	refresh_fsmonitor(istate);
>  	if (!(dir->untracked->use_fsmonitor && untracked->valid)) {
> -		if (stat(path->len ? path->buf : ".", &st)) {
> +		if (lstat(path->len ? path->buf : ".", &st)) {
>  			invalidate_directory(dir->untracked, untracked);
>  			memset(&untracked->stat_data, 0, sizeof(untracked->stat_data));
>  			return 0;
