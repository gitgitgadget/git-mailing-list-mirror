Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 179301F406
	for <e@80x24.org>; Thu, 10 May 2018 16:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966509AbeEJQeQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 12:34:16 -0400
Received: from mail-yb0-f177.google.com ([209.85.213.177]:33298 "EHLO
        mail-yb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965017AbeEJQeO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 12:34:14 -0400
Received: by mail-yb0-f177.google.com with SMTP id y5-v6so864793ybg.0
        for <git@vger.kernel.org>; Thu, 10 May 2018 09:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fiqSmBjgJlfdtK3CkCvcu3f+7War+/RJB2POrpM+T6o=;
        b=mYvPKBBHmFnUcLp/2vgLXZfKv1lxIj4CNtfoNuHxdKXXmw6pF6QME6ZzFmk52IAIZy
         Psm0iiPqMzvd9fnB7vhvIFcL9ajWZQAgzQX8GWKQ83J1NS5RBlLSi3mtI7OAVWkyZFxG
         G9151ZF4J2gxRo0ML2AsEbFNa24Vsvr2VdhRaVg6MaZ27mEpTdkz9XX6LCezHEeHvZ4x
         4cGhX32bVoiKbrlXdtKWmqTn1Y5b+lTsYcCXXI4NXbNJ71OeRnDMqQK5Xm+sxKSmoI/q
         7zYuIce7PON6pCJMffhoY7eJEK8tIAudXTItllM/ElwZUusOoAmkRu2zavj5OKJ3Y44S
         ntoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fiqSmBjgJlfdtK3CkCvcu3f+7War+/RJB2POrpM+T6o=;
        b=b6S8ktZkkRFoc2a5XK2E3gBvBuNyQG/M64KDbcn155pzpb4mbVAx7i+Ms1Kj9JjOGT
         BenXjSLVbHkktnnI5zVwwrvQAbMIhT8jp8YDj/re8KPnwlqaGjUYMxBBL/g9gd61va07
         OPgjutaeXfvPoG8MATcJYCLOn1H6T82xlWek0CbIty/rc8car+SI7CQ3/7F2XuNhz8/m
         xzRDcoTVCKMKANNaTpYPHs6v/UvTtcYxVgIsee8IiA9MjptG4WOh41YYktA6MTMR2mFu
         aUlZk1g71enkHW60MX+znAG3tLevSNLqtPdNWzqsUKVmO0yXYGcDumxNUmVgNhWYJWUv
         R9PQ==
X-Gm-Message-State: ALKqPwcLqRtYiWKAd/LDSyqVM4axmxzocIO+xm/M6pQF7utTuKbd6tTT
        NN6ouU9pKOsM65Ptq5+dcVaeBNuEzenXnersM7auZQ==
X-Google-Smtp-Source: AB8JxZpnHLrLEx0anE8OPMlgG+Ks0Gxfij+B05PTWzcyfRQKp4AmUtAoeEoQCtqc17iFQM+no/+R3QYwg8eoRnuWgQA=
X-Received: by 2002:a25:a567:: with SMTP id h94-v6mr1096528ybi.515.1525970053401;
 Thu, 10 May 2018 09:34:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cfd8:0:0:0:0:0 with HTTP; Thu, 10 May 2018 09:34:12
 -0700 (PDT)
In-Reply-To: <xmqqbmdnkgh4.fsf@gitster-ct.c.googlers.com>
References: <20180509170409.13666-1-pclouds@gmail.com> <CAGZ79kbFiULj1NJARm6ObYrqv_Fu+U2sb8h_sNJwdWur+JqrvQ@mail.gmail.com>
 <xmqqbmdnkgh4.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 10 May 2018 09:34:12 -0700
Message-ID: <CAGZ79kaSu6a+yUqmpQ+EpWjQSp+8fahk8DgpfgwRPwybnRH=eA@mail.gmail.com>
Subject: Re: [PATCH] repository: fix free problem with repo_clear(the_repository)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, May 10, 2018 at 2:27 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> So this would go with the latest sb/object-store-alloc ?
>>
>> My impression was that we never call repo_clear() on
>> the_repository, which would allow us to special case
>> the_repository further just as I did in v2 of that series[1] by
>> having static allocations for certain objects in case of \
>> the_repository.
>>
>> [1] https://public-inbox.org/git/20180501213403.14643-14-sbeller@google.com/
>>
>> We could just deal with all the exceptions, but that makes repo_clear
>> ugly IMHO.
>
> So perhaps
>
>          void repo_clear(...)
>          {
>         +       if (repo == the_repository)
>         +               BUG("repo_clear() called on the repository");
>                 ...
>
> or something?

This would work, but Duy convinced me to have repo_clear working
on the_repository is a good idea by giving a minimal test helper[1],
which helped me to find leaks[2][3], so I'd rather go with the solution
by Duy in [4] from a developers perspective.

Stefan

[1] https://public-inbox.org/git/CACsJy8C7N2W821H8YR8VaKdCSOSCDtQi_YT7z8hHNDO-VxJmEA@mail.gmail.com/
    https://gist.github.com/pclouds/86a2df6c28043f1b6fa3d4e72e7a1276
[2] https://public-inbox.org/git/20180510001211.163692-1-sbeller@google.com/
[3] https://public-inbox.org/git/20180509234059.52156-1-sbeller@google.com/
[4] https://public-inbox.org/git/CACsJy8AdJcQpiGrR3p6xfuqU0=qoP3=StgbWRNCkdfka6di+5w@mail.gmail.com/
