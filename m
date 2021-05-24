Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD087C04FF3
	for <git@archiver.kernel.org>; Mon, 24 May 2021 12:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CC6F60C3F
	for <git@archiver.kernel.org>; Mon, 24 May 2021 12:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbhEXMZG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 08:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbhEXMZG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 08:25:06 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAECC061574
        for <git@vger.kernel.org>; Mon, 24 May 2021 05:23:38 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id ot16so12794125pjb.3
        for <git@vger.kernel.org>; Mon, 24 May 2021 05:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8aM7aVeOb2MzQILh38gfhyXmwgWaUCczrfui0pVpFdI=;
        b=ra4hviNDyekPf5p0fsDLU83jyVMzBup1b65m+EQjVj4l618TXgYa1dKyIbt5ZPVkDC
         TVrGDJxku7HK47J2vaJ1fsZTH79fdJefEkImurgIdoRNui5nAReDl9MuAAcy8LFnNfWt
         PdRwIu8pmcfP5jcBJYZLohUc+58QeQkc2tgINBs2wZZCFBzkmt3YFiMzyV5aLjf3SdAA
         Y7jEZjlW9QjSI9lv2KD+PjX3p1gshqRuY/Jq1cbNjlW30MImopZ8i2MSNdIFQSSH+ArS
         99idS6piIoKnvi7Q+7pBmi6+GeAWX6TQVV5WHmumvh5DcFuqCyFGh3BJpafjXN+qAzRk
         96FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8aM7aVeOb2MzQILh38gfhyXmwgWaUCczrfui0pVpFdI=;
        b=Yam97PjoiM+teRZ/7n2yj1qh1ncE6wHoJ5Z6TwcqZ5R9j8zTZVT0rDG1Q8jEWosVMs
         dOMarXpNIsrRYIQhEKu8phF5pOOH/wils77DxClJVN2M4nEJcvtSMSjpWurV+6lzuogb
         Y29OLfESlnLJ/uqsFT9Jo+wz/OJ3qm0aojCdO+NtAww3B1f5tVNdU/IOHtLqV+Crq1mf
         oHMsK3QgD20s+jU5Ll6Py2kmypeSMIldbHWWLHPxatPcZZoWEz10OZ00/twbqnvm/eB5
         slOzGTqksJOKBJka+Sfo7RAm+hliPMUSUqMUKeugpX3iGfUBaTiKbLim3nFPH1f/uTJl
         IjJA==
X-Gm-Message-State: AOAM533p3LDPV4ZcANXrPAfS1zJOJCIdiaVmJA+pvjj7P8sb9ArnKMhy
        1XiJW3MWxSQ6ao32d2l5I2Q=
X-Google-Smtp-Source: ABdhPJwTD8pqAFnTo9nQxWFGusZ59xhHvV7b5JbQO+fGht8mAa841+iloi1N3CzFRFliVi95mT3o7w==
X-Received: by 2002:a17:90a:e014:: with SMTP id u20mr24981082pjy.200.1621859017884;
        Mon, 24 May 2021 05:23:37 -0700 (PDT)
Received: from localhost ([2402:800:63b8:812a:adcf:8995:bb0b:8236])
        by smtp.gmail.com with ESMTPSA id 194sm11239845pfy.146.2021.05.24.05.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 05:23:37 -0700 (PDT)
Date:   Mon, 24 May 2021 19:23:36 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 1/4] cache.h: =?utf-8?Q?Intr?=
 =?utf-8?B?b2R1Y2UgYSBnZW5lcmljICJ4ZGdfY29uZmlnX2hvbWVfZm9yKOKApik=?=
 =?utf-8?Q?=22?= function
Message-ID: <YKuayK+lmNfBoYWM@danh.dev>
References: <20210520221359.75615-1-lenaic@lhuard.fr>
 <20210524071538.46862-1-lenaic@lhuard.fr>
 <20210524071538.46862-2-lenaic@lhuard.fr>
 <120b6b5c-ab30-6985-d5af-a0b0290b864f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <120b6b5c-ab30-6985-d5af-a0b0290b864f@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-05-24 10:33:30+0100, Phillip Wood <phillip.wood123@gmail.com> wrote:
> Hi Lénaïc
> 
> This looks fine to me. I'm not 100% sold on calling the parameter prog as
> our program name later in the series ends up being "systemd/user" so
> something like "subdir" might have been better but that is not worth
> rerolling for.

I'll take the blame for that "prog".
I didn't think very hard at the time of writing :(

Yes, "subdir" is definitely better.
And it's aligned with the XDG Base Directory specifications:

	A user-specific version of the configuration file may be
	created in $XDG_CONFIG_HOME/subdir/filename

> On 24/05/2021 08:15, Lénaïc Huard wrote:
> > Current implementation of `xdg_config_home(filename)` returns
> > `$XDG_CONFIG_HOME/git/$filename`, with the `git` subdirectory inserted
> > between the `XDG_CONFIG_HOME` environment variable and the parameter.
> > 
> > This patch introduces a `xdg_config_home_for(prog, filename)` function
> > which is more generic. It only concatenates "$XDG_CONFIG_HOME", or
> > "$HOME/.config" if the former isn’t defined, with the parameters,
> > without adding `git` in between.
> > 
> > `xdg_config_home(filename)` is now implemented by calling
> > `xdg_config_home_for("git", filename)` but this new generic function can
> > be used to compute the configuration directory of other programs.

-- 
Danh
