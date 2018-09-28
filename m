Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68E2E1F453
	for <e@80x24.org>; Fri, 28 Sep 2018 15:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbeI1WPZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 18:15:25 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33999 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728765AbeI1WPZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 18:15:25 -0400
Received: by mail-qt1-f196.google.com with SMTP id x23-v6so7172226qtr.1
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 08:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=u5jOlfK35IjlQSLbFVwe00z4HMXRdaDbZc1OePvFWhY=;
        b=EZfCZdw/jZ1h+ladxTk9M5/W9bGBT2psyp6TMPo6oE7Ca+AQ1S5R50+fgsJK8Y8a1Q
         OWxJNrKFjEE/x7DigeFP38EgFEIdFZdA6o2NQ2TGxdciams2wSJ/Qyp0CJqhZlHpmv7H
         egiMVDlG3w6imwnhRTrjfxB++qYHse280AlGFJolj8TEhZQCdRnH+Nrs8ZDnS239L5P8
         7AGLf3Dv0ybYEq0uw24kXSVKS1tEOPJoURTeFvw65U1FHAi3tdWBfuebGVtieyvl0pyE
         GW371XfJETs2SrNCgJC0mIIoDrr7zsiKHpWl1HVcLZlYc8aoSxWBz0e2Xwbws+shFVXy
         NMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=u5jOlfK35IjlQSLbFVwe00z4HMXRdaDbZc1OePvFWhY=;
        b=Hv/ygJz0mK3u1TN+lswX+EeHqRzVHgiTGfr1/rwYvpR6dT3pcpcGQ/MbaO00coLfxp
         HAWfRhQkg21BodeZnoLJXskKLQTgGkTSzN+UVIpG9Vm9VD8zbPYY+n31bVOpH99aMBJz
         OcpJEF0uOgfZZqGN9ogRfiSI7z1Sm2kmNluRy4f/ds4OPW2hta1XhmUSf8VYA2KfYwCv
         fz4RL/JCM6W3fc6BkHHwJCwZoEA47mQzi/OWQRzs4i4TlwlVUJ+QCxRQFdyxb1s/yAYR
         bxEJ5cYWQYBjTcuU85E/kWj5HQcGQCxrNEe8UqSAoDi5tEoVYRPq0KjvBGsd2doLyEXB
         755g==
X-Gm-Message-State: ABuFfohxRqPM1yFKwJeXFSj5W9DAloEtPEPeGnsDOC3mmoC4GGvfgNcl
        mnUkErxLKL6saVYNmhGr6aZFuohsgLqPSq4n3Fg+7g==
X-Google-Smtp-Source: ACcGV61IrXe7Z0/FN9zugr7lxNupSvuu6IFhV9s82Di4klR7npiRvqU3oDQcP5uvYwsZiEcEO1cT0GXEcD5laQEAUWk=
X-Received: by 2002:aed:366a:: with SMTP id e97-v6mr1117061qtb.75.1538149861797;
 Fri, 28 Sep 2018 08:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAJoZ4U2G5rhZnOxsHjxByfYQvDCc-CJ=1-JjyrjW_B-CWForEA@mail.gmail.com>
In-Reply-To: <CAJoZ4U2G5rhZnOxsHjxByfYQvDCc-CJ=1-JjyrjW_B-CWForEA@mail.gmail.com>
From:   Kyle Hubert <khubert@gmail.com>
Date:   Fri, 28 Sep 2018 11:50:50 -0400
Message-ID: <CAJoZ4U1cKjbgYq3=S--KbV8Yhce83z1WhTQJHTFyBTRRe2-DHg@mail.gmail.com>
Subject: Re: [PATCH] Improvement to only call Git Credential Helper once
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry, this patch is damaged. I'm moving to `git send-email` now.

-Kyle

On Fri, Sep 28, 2018 at 11:10 AM Kyle Hubert <khubert@gmail.com> wrote:
>
> When calling the Git Credential Helper that is set in the git config,
> the get command can return a credential. Git immediately turns around
> and calls the store command, even though that credential was just
> retrieved by the Helper. This creates two side effects. First of all,
> if the Helper requires a passphrase, the user has to type it in
> twice. Secondly, if the user has a number of helpers, this retrieves
> the credential from one service and writes it to all services.
>
> This commit introduces a new field in the credential struct that
> detects when the credential was retrieved using the Helper, and early
> exits when called to store the credential.
> ---
>  credential.c | 8 +++++++-
>  credential.h | 3 ++-
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/credential.c b/credential.c
> index 62be651b0..79bf62d49 100644
> --- a/credential.c
> +++ b/credential.c
> @@ -280,8 +280,10 @@ void credential_fill(struct credential *c)
>
>   for (i = 0; i < c->helpers.nr; i++) {
>   credential_do(c, c->helpers.items[i].string, "get");
> - if (c->username && c->password)
> + if (c->username && c->password) {
> + c->retrieved = 1;
>   return;
> + }
>   if (c->quit)
>   die("credential helper '%s' told us to quit",
>       c->helpers.items[i].string);
> @@ -300,6 +302,10 @@ void credential_approve(struct credential *c)
>   return;
>   if (!c->username || !c->password)
>   return;
> + if (c->retrieved) {
> + c->approved = 1;
> + return;
> + }
>
>   credential_apply_config(c);
>
> diff --git a/credential.h b/credential.h
> index 6b0cd16be..d99df2f52 100644
> --- a/credential.h
> +++ b/credential.h
> @@ -8,7 +8,8 @@ struct credential {
>   unsigned approved:1,
>   configured:1,
>   quit:1,
> - use_http_path:1;
> + use_http_path:1,
> + retrieved:1;
>
>   char *username;
>   char *password;
