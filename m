Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73E5320281
	for <e@80x24.org>; Tue, 23 May 2017 20:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033921AbdEWU5c (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 16:57:32 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36381 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032673AbdEWU51 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 16:57:27 -0400
Received: by mail-pf0-f169.google.com with SMTP id m17so125624417pfg.3
        for <git@vger.kernel.org>; Tue, 23 May 2017 13:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fQcvdFI4WmgQnie3LTXz8IJDgmB9lyIjwaTfgd+1e/Q=;
        b=JqSGfhDAywRAyvTk2u0hAXyoObFVI/2E3sRKerURylNFdUBcMeKmOlFX57LbqPYDVd
         S5+71CFWrqLwJAx6OM5et919mM3ssRCreCxs40cC8kldZJv0XItFfmRul9axLCddcnnt
         CHcGJR3cBUkG8vZJEEDoifPeXFL8Wd9Ui2+BfnexRY5IKAvoWP7xsPPq7rdg149AVSjg
         tFAjn5y9oE2TbOeH2cdzfhOi92L3eC5mgbWiqnFq6l5nY8exfeC6ckisqcD84JB4l+Gw
         OEmPccnwYz6mjNPYrPNzTBxrGLKNiWBlTbNSLLTwFCFUHfoERCdjMF/aOO3UqZgGWLEa
         myEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fQcvdFI4WmgQnie3LTXz8IJDgmB9lyIjwaTfgd+1e/Q=;
        b=JuPPwr4TZaL1TP/Ejmd+YeLBK2WKtPFYD1u4p3ebgLyQyQTUKq/DGemy/s2rZQ0bkY
         JwZ1evDTvV/KTRQvWMV4zdBkdqLebAXKPfXCdj52HN/gNERRRqDkUUTfm4elaW28xVXK
         AgSaZiOayvx+1tr4AIDgPDz16TSoRAvcYqlD6PqqNOZYM6HSthuDYUkH5K27tsUSXR/k
         GZ+yNB302z8IIf44l9/IxCBAqLpoJUnfQBzo3oDEVisFal8ih33VIoVm6okeMkpeoXGO
         ZDaeKu0Fv3K5M279A9eK5bnEDZDdLoQjl2OWIyNp8zvP15O3cjWNdpzT+0dA2TAmdEBz
         3YNg==
X-Gm-Message-State: AODbwcDbYCRQcG15baCyWLtsPK8vznKzfNACDjhDYSgcCLJkRuYNO35P
        iS83DeBrTbAg/LcUBbiswtQYY+n4M/w+
X-Received: by 10.84.248.73 with SMTP id e9mr38975039pln.76.1495573046510;
 Tue, 23 May 2017 13:57:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Tue, 23 May 2017 13:57:25 -0700 (PDT)
In-Reply-To: <20170523193627.GG115919@google.com>
References: <20170515183405.GA79147@google.com> <20170521125814.26255-1-pc44800@gmail.com>
 <20170521125814.26255-2-pc44800@gmail.com> <20170523193627.GG115919@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 23 May 2017 13:57:25 -0700
Message-ID: <CAGZ79kYPUO34YUVR_u4sRuYz+Geo=wxwNEfCnyx+NQWQCQTkaQ@mail.gmail.com>
Subject: Re: [GSoC][PATCH v4 2/2] submodule: port subcommand foreach from
 shell to C
To:     Brandon Williams <bmwill@google.com>
Cc:     Prathamesh Chavan <pc44800@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 23, 2017 at 12:36 PM, Brandon Williams <bmwill@google.com> wrote:
>
> You can set .git_cmd = 1 instead.
>
>> +             cpr.dir = list_item->name;
>> +             prepare_submodule_repo_env(&cpr.env_array);
>> +
>> +             argv_array_pushl(&cpr.args, "git", "--super-prefix", displaypath,
>
> And then you don't need to include "git" here.

even if git_cmd = 1 is set, you'd need a first dummy argument?
cf. find_unpushed_submodules, See comment in 9cfa1c260f
(serialize collection of refs that contain submodule changes, 2016-11-16)

>> +
>> +     info.argc = argc;
>> +     info.argv = argv;
>> +     info.prefix = prefix;
>> +     info.quiet = !!quiet;
>> +     info.recursive = !!recursive;
>
> If these values are boolean why do we need to do the extra '!!'?

Actually that was my advice. As we only have a limited space in a single
bit, strange things happen when you were to do:

    quiet = 2; /* be extra quiet */
    info.quiet = quiet;

This is not the case here, but other commands have evolved over time
to first take a OPT_BOOL, and then in a later patch an OPT_INT.
(some commands take a "-v -v -v")

And by having the double negative we'd have some defensive programming
right here. (To prove I am not telling crazy stories, $ git log -S \!\!)
