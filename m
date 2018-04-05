Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8DAE1F424
	for <e@80x24.org>; Thu,  5 Apr 2018 08:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751779AbeDEI1c (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 04:27:32 -0400
Received: from mail-vk0-f45.google.com ([209.85.213.45]:46996 "EHLO
        mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751749AbeDEI1b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 04:27:31 -0400
Received: by mail-vk0-f45.google.com with SMTP id v205so12509904vkv.13
        for <git@vger.kernel.org>; Thu, 05 Apr 2018 01:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cVrcKBlNmZmuD1L8wX7886VGfHt05CMvM+6vp1NIKz0=;
        b=gq4g3LFZoK8HLeztPy4edre/wNwpCjJe650QiHVQo5GJ3YBGmx3kaO+so34uPEbvxX
         Jstg0EAlp1lW77vxuKwA2x4Q9yCo304vkgbD71l2ldW+lAO3oTEDyriLN2ytVwkbihMo
         BEJjk7deU8IQ5tDfjEUBFUK2IHtEhSRiRMs2q4cKwEYXmoDLxleJ5nA5SZsgcYWrzv6b
         X4pSAfKctynl/J38A1AOkmXqsPvz5SjbD11liZhap8A+1udEmyL/3a0PtImwSQD5Y3WD
         HXBLXTHOS3OkstalRrqOtPyPE2hQ2vJa8y2UuemeMo1hMgnUf1uyybf3GZsSGxlPvUIu
         rEBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cVrcKBlNmZmuD1L8wX7886VGfHt05CMvM+6vp1NIKz0=;
        b=TuFxH1wA3bbjd481GN9lFdefIG+gXjjgroS1NNt8gc+tWuwztD7KuaEJkBsHWxI7PX
         Isz0m+goEyQCnBRaHb2J/PIX0B/fWv/iBO2t29Jdao2fFW0/8tvPcLjUqAI1DlnarWFO
         NsaMgKa0FrUorOR11JFEMbg1C4ShTl/Gq94W06LjV0jqOA1Jc2tifh3mNyyEKE6L9nPB
         Sj5gX5RiUx0iNSyB4FGa7SvPizLY2TwuTBiFJxtJIBL9pjEny5QATcg2bw4SDxZksNAb
         fWDy6v4uNEP/PQ1uJbDcD02iv/YqlHGWjFsDwFn1/sYwRti6B3MKxhDRwxKPHkRZhrDO
         OCxQ==
X-Gm-Message-State: ALQs6tDf8d61YWbgGhdD3J4rQ9RzW4NFZZjxXoPROn7I5LTSR9NjCEIx
        UDXjK7NHgZcl9c0SF6ekDsj4U6KUueNYa5WReM4=
X-Google-Smtp-Source: AIpwx4/Xs1I2nD5unLbq4RW5+hHQYxR45Y9TpHEsiz92ex+2/85FpmVkgtXAXmu8KYEfElOHv90spWFCGahsr9VGbv4=
X-Received: by 10.31.107.15 with SMTP id g15mr12765454vkc.2.1522916850260;
 Thu, 05 Apr 2018 01:27:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.34.195 with HTTP; Thu, 5 Apr 2018 01:27:29 -0700 (PDT)
In-Reply-To: <20180402203427.170177-15-dstolee@microsoft.com>
References: <20180314192736.70602-1-dstolee@microsoft.com> <20180402203427.170177-1-dstolee@microsoft.com>
 <20180402203427.170177-15-dstolee@microsoft.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Thu, 5 Apr 2018 10:27:29 +0200
Message-ID: <CAM0VKjkbPz_73VX7nhhaep+Q+tTUo=-H2r6SyvcYUQQx4LVucQ@mail.gmail.com>
Subject: Re: [PATCH v7 14/14] commit-graph: implement "--additive" option
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 2, 2018 at 10:34 PM, Derrick Stolee <stolee@gmail.com> wrote:

> +With the `--append` option, include all commits that are present in the

> +$ git rev-parse HEAD | git commit-graph write --stdin-commits --append

> +       N_("git commit-graph write [--object-dir <objdir>] [--append] [--stdin-packs|--stdin-commits]"),

> +       N_("git commit-graph write [--object-dir <objdir>] [--append] [--stdin-packs|--stdin-commits]"),

> +               OPT_BOOL(0, "append", &opts.append,

> +       git rev-parse merge/3 | git commit-graph write --stdin-commits --append &&

I see '--append' everywhere in the code and docs, good.
Please update the subject line as well, it still says '--additive'.
