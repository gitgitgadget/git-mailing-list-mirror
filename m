Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 664931F461
	for <e@80x24.org>; Tue, 27 Aug 2019 09:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbfH0J0m (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 05:26:42 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33087 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfH0J0m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 05:26:42 -0400
Received: by mail-io1-f65.google.com with SMTP id z3so44776038iog.0
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 02:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v20zXHXZa98JNHGHE5szbwnCeaC4BO4ToWO2Q7qn3fA=;
        b=n0Jjxxen/2VfNE2OSaoMWIwo6ahrNhs6TAMn0RT+mwnmMK180OuAOPUbmgUVJnmGl8
         8Sni2xIU5qJr5kTwXXmS+Ax9gWZ52NoDto6Ou3UPDD7Cz0WXhuVQ3XdhqLWA9m9xyW8G
         hHfEiA4DQpo8ica8bmcGZYDpochg1prlPOFHxYtZdi1JzrkkDMVG05Ru/oyST5HWq0mv
         yrn9zJm6QPmVT+yyi6T1kTO05OkHbfJm2CsHMQqG9Pyt0QJC4T5g4oDZKbHwvD3iQszr
         K6c6g2jFo5I9QgeSPd5+2OiswR06iX33ea20RBq0cdJKCuxb1V9ig1fLOkF/bPqAS8kj
         uJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v20zXHXZa98JNHGHE5szbwnCeaC4BO4ToWO2Q7qn3fA=;
        b=Z6mrGVfKeAvNkmOu/GmGe/IxplH5AQ89ZnH1yQFpPF8zKXVN1M6jJG+zEQvMbHsNiA
         sDL3RUgXFbceHlQMpDzVS/wG9PkdbzAi0JHKFfj5a+R1/JX3jqZTE7Ab7MEd+lhjsYzH
         bLAjIgKbwgJVw12+7dJYAlrPGah8BY4QgdCkQhcOiUWbL4gX7BQAYVGux5QHeVpqwIZV
         WwUDsETKrbXhGWKz/a5/Mseri5hhZu0m9q+Ng8AZn9NkCeSKHWtM1vrfmTFqs2bs0aCO
         lvIVYc1gCSVGQf/oL/MH4fnwNlzywN2EoLkHYdhphijX6B4e6PK+2c1ZwdMrxHSjspzc
         0fog==
X-Gm-Message-State: APjAAAXal26wRstHff470laoSNZDJYn1WmzUT56inU/CBOLTthZvxRbZ
        5aqneL01axX85BO5ZkNFg1RVZ9FS459p8rDLokA=
X-Google-Smtp-Source: APXvYqzf1ZukbV6ZeFBmlSyZpJiZGD60nSEU4mczuUi+GW7t4UhBK3sPVKginV6qKfjwmgtrj8ayjdzQidRyxeFN1Ys=
X-Received: by 2002:a02:a792:: with SMTP id e18mr22882893jaj.64.1566898001397;
 Tue, 27 Aug 2019 02:26:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1566863604.git.matheus.bernardino@usp.br> <4920d3c474375abb39ed163c5ed6138a5e5dccc6.1566863604.git.matheus.bernardino@usp.br>
In-Reply-To: <4920d3c474375abb39ed163c5ed6138a5e5dccc6.1566863604.git.matheus.bernardino@usp.br>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 27 Aug 2019 16:26:15 +0700
Message-ID: <CACsJy8Dry7MfKBi5EKw4Ka9r63QVmDjPv9nAozS0mC6Z7-sG=w@mail.gmail.com>
Subject: Re: [PATCH 1/2] config: allow config_with_options() to handle any repo
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 27, 2019 at 6:57 AM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
>
> Currently, config_with_options() relies on the global the_repository
> when it has to configure from a blob.

Not really reading the patch, but my last experience with moving
config.c away from the_repo [1] shows that there are more hidden
dependencies, in git_path() and particularly the git_config_clear()
call in git_config_set_multivar_... Not really sure if those deps
really affect your goals or not. Have a look at that branch, filtering
on config.c for more info (and if you want to pick up some patches
from that, you have my sign-off).

[1] https://gitlab.com/pclouds/git/commits/submodules-in-worktrees

--
Duy
