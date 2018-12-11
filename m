Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EA1120A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 08:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbeLKIwG (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 03:52:06 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:41260 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbeLKIwF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 03:52:05 -0500
Received: by mail-wr1-f48.google.com with SMTP id x10so13152209wrs.8
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 00:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=nEXpCBemJM/ycmEatHJMDlyh9jQoiWeAWUqk2SkAayI=;
        b=Z5XYwskHCirfZ3rk2OG+JF+LjtWfQkusAgSRNddEI/Nc+nG3CE5LVY7/dhls6fi8KX
         wSYDtICFgvTMQlovHPrg5quEGDaBvheY2ulCLDi76Up1Ckdp2Of4jmwejvi8kR4NMBUO
         4C0NqmBGFrpJ07Y5JbIQowlRmzl10+QtEDW7rjtv2OtXn4NtnEYkIrCVqzJQ+2Q1RgpH
         9KW7xq3d0AhApQLZwS5FNTetXiByihMXs40i1e5T3j4vz3Yk1of3Z5s/CURdNOcmrM6C
         jeftOARMG1BljDeOV3Et1ORwer26ojfr8HIgVZof/mshFw9pVyPliln+gTk8vf+otRwB
         awqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=nEXpCBemJM/ycmEatHJMDlyh9jQoiWeAWUqk2SkAayI=;
        b=djUOAlRUUEI6xGLNQWLU8sd9Pc5GIz+s5hEmIe81FjKRJEokTeo+pOIsEQap3PmCkl
         lWaE8vPBjEyeSnNCPBSCxuk1eysR5s9s+//SqoOlTfYpXeLBs5cekbNy5VMTlX+Z4NMB
         4r6X1bHF7oEj1Vm5SsOZIi1bzfUdMgKwvVws4ZTcMd5RU8i7xG35ujjREA2VmPjZQ70X
         OcVze2vfW10uY1f36AnQIWwFoebcf8wTTqw6QQI8Mk3T2tc0FSfS58bYaFi0PGZJJQTc
         ZhV8y+g1GYeDggKZy7pbFoNXR38ouBUUQpzOZmyXcmpVStuQ20sUtnC2qtfDdQm/pgnl
         GzMg==
X-Gm-Message-State: AA+aEWZFVGhoMM8RmWI5IP+cachUOUjZA9i7izZwk1PkZEWdDV4Tk7VV
        lsmf8kGyQlR6/zW4S3ufg7U=
X-Google-Smtp-Source: AFSGD/XgeYnUhm3xwhzC5y8u/zyr6PdIB8znFz9jtstqG589oX640+n9M8woyatqjSliS5kff6ffrg==
X-Received: by 2002:adf:f605:: with SMTP id t5mr11876335wrp.229.1544518323581;
        Tue, 11 Dec 2018 00:52:03 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h4sm12882727wrt.66.2018.12.11.00.52.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 00:52:02 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?6K646ZOW?= <thexuc@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] git help -a should no use page when in pipe
References: <CALmyJ=OaZAgr1i1DXMRQqCVWnKvO=QZH6AeGj8YfKMxAnRz6GA@mail.gmail.com>
Date:   Tue, 11 Dec 2018 17:52:02 +0900
In-Reply-To: <CALmyJ=OaZAgr1i1DXMRQqCVWnKvO=QZH6AeGj8YfKMxAnRz6GA@mail.gmail.com>
        (=?utf-8?B?IuiuuOmTliIncw==?= message of "Tue, 11 Dec 2018 14:26:42 +0800")
Message-ID: <xmqqwoogjvil.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

许铖 <thexuc@gmail.com> writes:

> Since git 2.20.0, invoking `git help -a` will cause git using page (e.g. less)
> to display help message.
> ...
> I would suggest `git help -a` only invokes page when stdout is a tty.


It already does so for me.  "GIT_PAGER=uc git help -a | cat" where
"uc" is a custom "pager" that is "tr '[a-z]' '[A-Z]'" does not show
things in ucase, but without piping to cat, the output is in ucase
as expected.  Perhaps there is something different between what we
are doing.

FWIW, I am not on Windows or on a Mac.
