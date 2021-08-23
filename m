Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BF1C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 06:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C92F2611EF
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 06:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234535AbhHWGn3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 02:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234861AbhHWGn0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 02:43:26 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8221EC061575
        for <git@vger.kernel.org>; Sun, 22 Aug 2021 23:42:44 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id n126so18804074ybf.6
        for <git@vger.kernel.org>; Sun, 22 Aug 2021 23:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gKhhxEgUu0DlplNHe2cHic60vQ20v1lLDJsqxMzVALE=;
        b=BLgSVzrSLglnVWBrGBlIVWiIsxOtY6n+cK0VCEHszph4aPzMYpTChi4kquOUx9Mubi
         r1Dlf/7riH+0Iy8GPEXKxz5nF0IOdEhdaFDz5gg3RETzKVdVSnS8yQj/STukHuAbLwOf
         mzG6/m9i+u2x//Xx/+O8tL4X+opUaJo4pWgxRJ5FToANIfq1murCyH07sYY5RE9uGyiz
         BKjo260k7+WSk03mxwcAa9o3QyO6mNdTzjvQGZjCcR2XcUXvAMjnpp2rPhRKw/I/L7oo
         lQHOOq2+rq1A8Bj8n6J/ADKeUPboJjYyfwBKIn6C4zn8tTltTrg6siHlnY6qzv8eDsP8
         6CyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gKhhxEgUu0DlplNHe2cHic60vQ20v1lLDJsqxMzVALE=;
        b=sPZmkzPPQnR0P/pvql41DNpLm/4WJruIYFd9mce+3iycxXoWAwwI9RbT5Qb3MaYOfa
         XbhT05+wGiyPu0Q05wu3sBgzMfyvQ0qjzTs++rbpAffwrHU6eTZ5nE2z67nZoxAu4JjF
         rbI75Ycyz3J5h7rQ0a3DfwW7JYlAODwrpvfcocc4E87QBI+drKDq1KqADUKYPFqYUToW
         QJerNL2Ai76vvr8+uGW+xs/fmyJlOPkAYtwDdt9aJmebGoapO6yON0ErgNTV9E6x9FRd
         oShH0AaEnVeFLPwUUfgQxv0skcAioV7bG2jOh8ofPyCohXIs+3kO6pF+yFCMeuvt6Tpa
         BO4A==
X-Gm-Message-State: AOAM532vfd9s4Pa5kShO8UCjvpgAnf1zrW8vrRueq2LwprUepxEauwMi
        dYtjmeSpiIvxWE+WQfOCmGNNG1IsZaLlM+Dw2zc=
X-Google-Smtp-Source: ABdhPJycpqVB42YEvDHxpc5cZZgMQj9gQMT8Sl3frftTb7UCn5T9R+BFK95PmY8MeV9CwwBi1KfiBhdNH3uGJ/VWL/Y=
X-Received: by 2002:a25:2e49:: with SMTP id b9mr39577446ybn.41.1629700963265;
 Sun, 22 Aug 2021 23:42:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210822161325.22038-1-worldhello.net@gmail.com>
 <20210822161325.22038-2-worldhello.net@gmail.com> <70420665-c276-b18d-72fe-1b54609c1c46@gmail.com>
In-Reply-To: <70420665-c276-b18d-72fe-1b54609c1c46@gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Mon, 23 Aug 2021 14:42:32 +0800
Message-ID: <CANYiYbGYS1iy41o7r1aHhyfrOo5WEXB5kr7S2eqKtA_98oc9pQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] ci: new github-action for git-l10n code review
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <hello@brighterdan.com>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Fangyi Zhou <me@fangyi.io>, Yi-Jyun Pan <pan93412@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 23, 2021 at 2:28 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On 22/08/21 23.13, Jiang Xin wrote:
> > +    - uses: actions/setup-go@v2
> > +      with:
> > +        go-version: ">=1.16"
>
> Currently there is newer Go (1.17) [1], why don't you update to it?

Only go 1.16 and above can install a go package in "path@revision"
format. Use semversion ">=1.16" fits my needs and makes this workflow
file stable. It's not good to upgrade this yml file regularly.  And
I'm not sure "action/setup-go" has a cache for go 1.17.

--
Jiang Xin
