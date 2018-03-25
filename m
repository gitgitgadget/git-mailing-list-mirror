Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 485631F42D
	for <e@80x24.org>; Sun, 25 Mar 2018 06:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751154AbeCYGtZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 02:49:25 -0400
Received: from mail-qt0-f169.google.com ([209.85.216.169]:34592 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751029AbeCYGtZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 02:49:25 -0400
Received: by mail-qt0-f169.google.com with SMTP id l18so324114qtj.1
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 23:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=zUi+UTsS45V/ExIJPwQfP0wuMyPAS39O774VVLVze+U=;
        b=H9I1PoDsdCkr7bQ6Jkpar00ZxhxXUCBichZWGw4+gLYgel+7JibejQTWOc0I8VgsYI
         OdAZ2ay27btmrBjmT0/71QWFeGUZFFG3/5byYath9iBaK4WbPgP9gXF7FIs1vZwes1Js
         NunQOMQo9EXho+70XJPoj+iSkUCg8pa7gXJdx5KWcHElzaxLeuKAo+7rfOOn4pMJu7na
         +BHlYhlQ3R2iWXdhLsrpTyXxw7+UEtDLLfe+YyoICQMgAjmOG2Xn8sHRpx3jryQ4uyOQ
         pXvm9Ig+m4qzNqdKDc88qQ3tUdrAuCJ9PltdEJZOcCzR40MFFqUZInMSGq72e85O923E
         I5+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=zUi+UTsS45V/ExIJPwQfP0wuMyPAS39O774VVLVze+U=;
        b=mmd+2q7gboi+2pQtOryLFBuBOG9wa90qFbDLHolbQDwrECgsq6uoCEowIwQ2Z+0Qva
         n2d2ONUoFE4u0wiWij4rB9HSNqDP1VpbkknV8CixxD95FPnMgavj/xreYmTX5Tfvh/ek
         aKu2A5Llu1nFrgU6+fmgrzg8+azjmbjjFb22WNImXPIYJ8iobQDwqpHz+mQmX0tuC3Az
         GgMGoA/UqOACK/Y+PT1+tJRMW7hlCsGEocAP1dLnXRKKxofwxHf3aDR49Dr7o78hrzEz
         BnbpX9ZVY+7OgCLLbup8ICiKbNF/sGSRG7tcqr51jwjjk6XV0RIWEOnoKaaVgCt4lelZ
         WoXw==
X-Gm-Message-State: AElRT7GV68dxhq8HQjqMRHrYKvWI7m6tObANbWIjiFNuy7P1/HKA4Qg1
        qA5GPPS70AJC2A8s6ap1jCSuvy5mpbGieXQVSZw=
X-Google-Smtp-Source: AG47ELtQY+5/+rHZWbVRWCpRkhMyT/Uv7DC1c/3dAgeFyd9oJLEQ74S5itGhZSTutP0e0PrI9oBnudGxmlsYUuv8rv8=
X-Received: by 10.237.57.166 with SMTP id m35mr33194828qte.220.1521960564400;
 Sat, 24 Mar 2018 23:49:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Sat, 24 Mar 2018 23:49:24 -0700 (PDT)
In-Reply-To: <20180324173707.17699-4-joel@teichroeb.net>
References: <20180324173707.17699-1-joel@teichroeb.net> <20180324173707.17699-4-joel@teichroeb.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 25 Mar 2018 02:49:24 -0400
X-Google-Sender-Auth: HILHDr9X_HneWd5s1RZGnYcjcAU
Message-ID: <CAPig+cSC93bEoUZBtg3b+U_=3O+D2T1-0x-mH2LykyMsM2SROg@mail.gmail.com>
Subject: Re: [PATCH 3/4] stash: convert drop and clear to builtin
To:     Joel Teichroeb <joel@teichroeb.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 24, 2018 at 1:37 PM, Joel Teichroeb <joel@teichroeb.net> wrote:
> diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
> @@ -313,6 +348,60 @@ static int apply_stash(int argc, const char **argv, const char *prefix)
> +static int drop_stash(int argc, const char **argv, const char *prefix)
> +{
> +       const char *commit = NULL;
> +       struct stash_info info;
> +       struct option options[] = {
> +               OPT__QUIET(&quiet, N_("be quiet, only report errors")),
> +               OPT_END()
> +       };
> +
> +       argc = parse_options(argc, argv, prefix, options,
> +                       git_stash_helper_drop_usage, 0);
> +
> +       if (argc == 1)
> +               commit = argv[0];

Seems fragile. What if there are two arguments?

> +       if (get_stash_info(&info, commit))
> +               return -1;
> +
> +       if (!info.is_stash_ref)
> +               return error(_("'%s' is not a stash reference"), commit);
> +
> +       return do_drop_stash(prefix, &info);
> +}
