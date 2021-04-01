Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8C7C433ED
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 07:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE1286101E
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 07:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhDAH3U (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 03:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhDAH24 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 03:28:56 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD35FC0613E6
        for <git@vger.kernel.org>; Thu,  1 Apr 2021 00:28:55 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id ap14so1452302ejc.0
        for <git@vger.kernel.org>; Thu, 01 Apr 2021 00:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Azo1n2CTKd2HGn5McHWTo797PaqK1dEoLfIST30N9As=;
        b=heTkTZ6eYXVcFnWffOB0iguFSddyrHU92FvLJeLYVmFzuO+WkDRUlhIb7Y27ZvWLJf
         vmOeWDNwSx3ocAPIaFEOU6mgFhMNy4tHMfbeCac+U/a0DtDFao+xUB13tUY1a9a+r1J6
         /rqPMcOG1K59RFUkJP7tKv6Zl6QSA8X8ogWLr5q8+mDK+J2mfxq4xLPvomsr/3r2YstI
         XWjspRKsT9wbFdEFGSavYbAFE6kHBJMmNpGgGU/tTJ2ZoYTvfRI4j1j/gN/enFaJ+erf
         VXryN7c58uIUsQjb4pS6D1Jcyik5rVOxiu+pXTsuzy2VH53JygunhqchBCRppr+kGc92
         7vHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Azo1n2CTKd2HGn5McHWTo797PaqK1dEoLfIST30N9As=;
        b=B+9nOf2ovNIHEn+mBEyruZMRJazdgN6rvGmb1umQZMLRW2/vVz0NFc7oM43qLtes57
         7oyP/eD2flDYfprjO4ITTHSKHIPpB5MpiPyGZsFtH10u95YbSrniE2NW4eU0K2h5GJkO
         oyxw2rHZfDJmxdkMUjxy8fD60llQ5y3PlYlnNN6/Zb//VD2YRr7UEfRy9SVw4hj/AQty
         ZiTVI3kz78Q9aUtJKiwiPZmPyMDO/gc+EoW+Ej0xX+jGfcpYEf9jwFYqnUJG35gd6Ywm
         VMsJRSDe0ZtYa8mQA1FvOGxPYMqNy2fhVxH3NvU9tScRQYv8D5M1UeO/2KReqmpeENX1
         dADQ==
X-Gm-Message-State: AOAM531WcjAyo5upCFGj4RNmHlhLiTR3Qwz0oC2SwSgz2MzZsAYv0fcn
        zFkOn4JiZs4jnXpn2LDhN+MJHx9NEdJTYk+FOqQ=
X-Google-Smtp-Source: ABdhPJzFF9D1YRQq9q9gZJSbijPXPl6AFsSFF9Ik6j1YT1fQoYhI/dAp1CUayMGoMhN6ls3imftfAsuCIbjIyeDM1D8=
X-Received: by 2002:a17:906:2795:: with SMTP id j21mr7708792ejc.283.1617262134237;
 Thu, 01 Apr 2021 00:28:54 -0700 (PDT)
MIME-Version: 1.0
References: <pull.913.v4.git.1616775185562.gitgitgadget@gmail.com> <pull.913.v5.git.1617185147.gitgitgadget@gmail.com>
In-Reply-To: <pull.913.v5.git.1617185147.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 1 Apr 2021 09:28:43 +0200
Message-ID: <CAP8UFD0a_HQ9bEQLASn_D1jj+ut+okENJs=aENDxTDL1f2VZKQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] [GSOC]trailer: pass arg as positional parameter
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 31, 2021 at 12:05 PM ZheNing Hu via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> In https://lore.kernel.org/git/xmqqv99i4ck2.fsf@gitster.g/ Junio and
> Christian talked about the problem of using strbuf_replace() to replace
> $ARG.

It's better to sum up a bit the discussions. It's nice to provide a
link to the discussions though.

> Now pass trailer value as $1 to the trailer command with another
> trailer.<token>.cmd config.

If this patch series introduces a new trailer.<token>.cmd config
option, then I would expect one of the patch in the series to have a
subject like "trailer: add new trailer.<token>.cmd config option".

> ZheNing Hu (2):
>   [GSOC] run-command: add shell_no_implicit_args option
>   [GSOC]trailer: pass arg as positional parameter

I guess the "trailer: pass arg as positional parameter" is the one
introducing the new trailer.<token>.cmd config option.

Also it seems strange that there is no space between "[GSOC]" and "trailer".
