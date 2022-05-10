Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFEDC433EF
	for <git@archiver.kernel.org>; Tue, 10 May 2022 20:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbiEJUSl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 16:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiEJUSj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 16:18:39 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E62D562DB
        for <git@vger.kernel.org>; Tue, 10 May 2022 13:18:37 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id s23so8173383iog.13
        for <git@vger.kernel.org>; Tue, 10 May 2022 13:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7Chb0jC47TZCIaS9ZQJY7SrTFX5Pmx4H5V7HepaLBPw=;
        b=NNhg0+jeKvAnj0TVoByZgO5l1raoTVQMBhR37QBXlHmhQ22cQcsLXWVVwyS2oFqF7K
         OK+AlyJwvd2i5pe5jsED+CoKc5fiOix2CbLySVRvXkb+NzVhVzU9UI94glNmdLoh56YN
         YB0RNDzZrvJGX0AFxD/FnN+yK/B9TNuPFTfX8MVZTuJvqslr5Nq9PSvY/bfZ5AehSIly
         0Iiz1D7Fz6M6TPwMRg8TdIVjjZJeKDGQlsFKMkBOAHxhFyvdbzEig1wNqDd7h90FTvPL
         R3KrVi5dbYljHTh9yfymaW5s0N1sDOENXiszb6plz7SmiprXZKMmXQBfMaEWKoEqXA40
         Eg4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7Chb0jC47TZCIaS9ZQJY7SrTFX5Pmx4H5V7HepaLBPw=;
        b=4i9OdF3ZpIlNbTYCFtauGFZVBJVeeSKkQHVcU0r9Wu101v+AdPunvl8fnqzMz9+WRZ
         80GfiY4mVrEeqeCklYCTh2klAEt1lrTh7W870G605QCraOc5W64sJSOOlZFxEb4fwvaz
         P6/rNrX3XUdocMaN/czIpP0U+dENoU1H52UMObmsf55r0JFpzmUoFjr5F0BdShukekUD
         EU6DdPCs8s0LTytATT1eD95kLnUBqsa5vkGyveAEihFbrPY/8DejMOv4FRadRPYf3QGn
         35Rvq+IjpoEna1EGLbws4bCMKr0LJOxMaBWd7z1HEim2i4V4it/XfAFh8iuULTmRjLuk
         Ht9w==
X-Gm-Message-State: AOAM532E/7iPKxqBgh3NJwyl037ERr73on5C+hA/sWRL+osu+HF25zjZ
        92qh023M/qcIcw+lSOgbk+/BQwv1R+WnUg==
X-Google-Smtp-Source: ABdhPJzdMK9VzSx/XIJTsCawqREObRTj6Y7JnH48nNaLjwKmlrBdpbR4RhDWe4ibhk9ySOKdcMPoUQ==
X-Received: by 2002:a02:cf31:0:b0:32b:7d30:6b30 with SMTP id s17-20020a02cf31000000b0032b7d306b30mr10746993jar.247.1652213916691;
        Tue, 10 May 2022 13:18:36 -0700 (PDT)
Received: from [10.11.12.100] (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id a43-20020a02942e000000b0032b93db741bsm54162jai.19.2022.05.10.13.18.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 13:18:36 -0700 (PDT)
Sender: Eric Sunshine <ericsunshine@gmail.com>
Message-ID: <69897c46-abe7-f4d0-b43a-f60e0215927c@sunshineco.com>
Date:   Tue, 10 May 2022 16:18:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH 2/3] t0033-safe-directory: check when 'safe.directory' is
 ignored
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <pull.1215.git.1649863951.gitgitgadget@gmail.com>
 <20220427170649.4949-1-szeder.dev@gmail.com>
 <20220427170649.4949-3-szeder.dev@gmail.com> <xmqqr15il0uo.fsf@gitster.g>
 <a44b4f0e-038c-9bcd-80d6-f53c87bd7f2d@github.com>
 <xmqq8rrndb6h.fsf@gitster.g> <20220429190625.GA1626@szeder.dev>
 <b6deba3f-9019-fb6f-7bb3-cc2f647dcff6@github.com>
 <20220510183321.GA4408@szeder.dev> <YnrDK0wCV6taY1QX@nand.local>
From:   Eric Sunshine <sunshine@sunshineco.com>
In-Reply-To: <YnrDK0wCV6taY1QX@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/10/22 3:55 PM, Taylor Blau wrote:
> On Tue, May 10, 2022 at 08:33:21PM +0200, SZEDER Gábor wrote:
>> On Fri, Apr 29, 2022 at 03:19:01PM -0400, Derrick Stolee wrote:
>>> Would it be simpler to use this?
>>>
>>> 	GIT_TEST_ASSUME_DIFFERENT_USER=0 git config --unset safe.directory
>>
>> Oh, wow.  This is so obvious, no wonder it didn't occur to me :)
> 
> Don't we consider this one-shot environment variable to be sticky on
> some shells (i.e., that it persists beyond just the "git config"
> invocation here)?

Almost. Some old/buggy shells incorrectly allow the one-shot environment 
variable assignment to bleed past command invocation when the "command" 
is a shell function, like this:

     SOME_ENV_VAR=somevalue shell_function_call

We do "lint"[*] for that sort of problem in t/check-non-portable-shell.pl.

Stolee's example, however, is invoking a normal program (`git`, in this 
case), so isn't subject to that unwanted behavior from buggy shells.


[*]: a0a630192d (t/check-non-portable-shell: detect "FOO=bar 
shell_func", 2018-07-13)
