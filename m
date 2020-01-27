Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5526C2D0DB
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 11:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96B3820842
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 11:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gans+jYC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729800AbgA0LpA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 06:45:00 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:41943 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgA0Lo7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 06:44:59 -0500
Received: by mail-ed1-f49.google.com with SMTP id c26so10435030eds.8
        for <git@vger.kernel.org>; Mon, 27 Jan 2020 03:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7DH/PPYnAuveqYcqUCUZTxVFcHzO+CmGeT5llTvePP8=;
        b=gans+jYCNo3DnVpfbtByy3ZggzYrUuZ9PN/LSPRCzDfcVBGpsfdv/ONm0v1i29KFI0
         +HGuItYb7tj5TS6KASC8JX/FRniZgLNyjGIhMZYvPPJmN4XIZYbviTbd00gLbDa9UCx+
         uWX6kwMhEQxoMtxBprCuhvW0u+jwQPXatpMOcLzxCxsmV7jWWGdLqoaSZWKYW/0gNoat
         cM8bVvVWSddQ16YxR8U1TsDVX4MnCMldInYvajWKooXOIAfSod44q8I6WoJUYOBBncCA
         mQbXm87KfqFg5d75OPae+MsewPT5qrb6ytmScccDcu2oCJHC5w/GS609nc8mTdCMwZHX
         auzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7DH/PPYnAuveqYcqUCUZTxVFcHzO+CmGeT5llTvePP8=;
        b=t9HImNBz/nlpjFLH9uR5IeK0c8eIKxW8QsRWNIvolsqkmMuDp/f33BRkFEYSLwcqMt
         5B8D9XiBBsQJUllniWY6S2n9BXAxQcUj6bf2O56QB2BkaLPwbxmWwkOB3LiuJW7wpbRw
         GBNJmSvwCnUrFA0iEccGZXSwYNgnvodMvGpXYwtTYZDR9IzRvV9WTSuP/S3LG4pDGmSS
         /rjaJTNIUAVx9u2naSPgQngrAhieicGDy0xL80iy1ODcDcR5Xib4b9r8Ub8oPVBnrwoK
         mDiT+FWcwYEdeRZV9mX+xhMLbgWMlqYNPtPIBLphOPJHBCsTzQclW0OnrA/s9vxvGb2E
         i5/g==
X-Gm-Message-State: APjAAAVKiWSEnkmX2sT4NW09meon5f3VamTg3cbDaTROwEAECg4FPV7N
        jO071VjXeuV+W9nKBg3J/i1xxyHPaY3TwXkjHVs=
X-Google-Smtp-Source: APXvYqy95JfUL89CB/od/9ZFu+nTwni0P2VfxsyMqZuy3vLmqbAbhQhx5wpLTjY6fgyWrdWOaVqVd+HYTjva1hBy2ic=
X-Received: by 2002:a17:906:ce38:: with SMTP id sd24mr13203883ejb.237.1580125497681;
 Mon, 27 Jan 2020 03:44:57 -0800 (PST)
MIME-Version: 1.0
References: <20200127100933.10765-1-git@zjvandeweg.nl> <20200127100933.10765-2-git@zjvandeweg.nl>
In-Reply-To: <20200127100933.10765-2-git@zjvandeweg.nl>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 27 Jan 2020 12:44:46 +0100
Message-ID: <CAP8UFD1S9yE_SkxJbLWz=HHasYmJnDsR9MuefBsLkdWaYFdu-Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] config: learn the --stdin option for instructions
To:     Zeger-Jan van de Weg <git@zjvandeweg.nl>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 27, 2020 at 11:21 AM Zeger-Jan van de Weg <git@zjvandeweg.nl> wrote:

> +static void update_config_stdin()
> +{
> +       struct strbuf input = STRBUF_INIT;
> +       const char *next;
> +       const char *max_char;
> +
> +       if (strbuf_read(&input, 0, 1000) < 0)
> +               die_errno(_("could not read from stdin"));
> +       next = input.buf;
> +
> +       max_char = input.buf + input.len;
> +       while(next < max_char) {

Nit: space missing between "while" and "(".

> +               if (*next == term)
> +                       die(_("empty command in input"));
> +               else if (isspace(*next))
> +                       die(_("whitespace before command"));
> +               else if (skip_prefix(next, "set ", &next))
> +                       next = parse_cmd_set(next, max_char);
> +               else if (skip_prefix(next, "unset ", &next))
> +                       next = parse_cmd_unset(next, max_char);
> +               else
> +                       die(_("unknown command %s"), next);
> +       }
> +
> +       strbuf_release(&input);
> +}

Thanks,
Christian.
