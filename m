Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC51C433EF
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 21:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C32F611C1
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 21:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233869AbhKEVDZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 17:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbhKEVDY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 17:03:24 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96145C061570
        for <git@vger.kernel.org>; Fri,  5 Nov 2021 14:00:44 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id e64so5238217vke.4
        for <git@vger.kernel.org>; Fri, 05 Nov 2021 14:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uPDO4e8wmGHTgoLbBRh7FWAREjYuFmuzhtXdSt2EG0I=;
        b=ehEn48frCddhqUsKXWOYQ6GncrPWYiPtEjSnRWfybc0lPT2SYv4d3b781zXEQh6yLP
         c/40vgqL032n5XdF8XRUA3wg9/FXOFSK9nkE0EPkHBq4nKhIiGVAZj0bXeKnOjVcEEdQ
         i/DM9TP8CFtVFy3JYi9ejBwZ+lu/ZJLTksWjF8RKnx/sM12X61RuswT8n9emktJ22HSY
         42vDDSSAjMIFZiGM7CtKPIBBe0+euTR1knfAIOgTg8CbMquwugZAaxNSC3TneXclDnd/
         XY7w6uqubvVYDOXg8hepn9LZZGJ8EihkiFEpQ0Zsw7i1rZ+OoE15Mytb1fHEs0P22Qwo
         xiYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uPDO4e8wmGHTgoLbBRh7FWAREjYuFmuzhtXdSt2EG0I=;
        b=NSpDyv7Sciwhn9YCJS/IYW6ns4zwoYykej3fHR6t1PSCub468nzgmNfVCoHeb2/YO9
         H2qV3zP/BDlEvHoFG1GOmZ7EK2H5dCtJPoHSFv5aW3zK3MwsvGq161aYl51upBRtpETn
         h0y3eiG1CRqbgr/gbVT4UlU99ZCnaCEwi6R19doiBETyXL0WrA2rlFlY8k74TmjP88JG
         GAlk/z+Uoa2pYsXpXgMs2nd2LdpJqDJN/XdXSSiog00RBGpxMK5CRz/2kVn4QfhnfZLx
         E9C0AbSAoMfRPibbVIOxuOofI9juMhl8Wycp0C0TdNsOUmIAZoBx4iUWi46InU/QhUpK
         HX1Q==
X-Gm-Message-State: AOAM531hKbeaQNlA3LH6e3lpF3hnWw92An3/aIalCCxrniKOeBw7hUNw
        VXCs7jYD4slSuAUeQghJz/aHGh/Q22ho8hx63zI=
X-Google-Smtp-Source: ABdhPJz43cpJ8r/bcJuPdgGosE8g9rZdX78aIr14tnucPoCcFqhp4l3pJudSwZX6oObiKWjxvjQqdviMslYjRBMMGXc=
X-Received: by 2002:a05:6122:2201:: with SMTP id bb1mr73686265vkb.19.1636146043637;
 Fri, 05 Nov 2021 14:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <20211104192533.2520-1-adam@dinwoodie.org> <xmqq7ddn3dlt.fsf@gitster.g>
 <20211105112525.GA25887@dinwoodie.org> <YYUeKt0xQm/6QT+w@coredump.intra.peff.net>
 <xmqqk0hmxyw0.fsf@gitster.g> <CA+kUOa=vqFNXe2QKc8K31OLL0zkEsK7wAk6hPMxjQJNVM7PsGQ@mail.gmail.com>
 <xmqqv916wh7t.fsf@gitster.g> <CA+kUOamwQmK6te66sE+EVLPhwmBFZ+CXC9p=HJ4y0KC0wnkNsQ@mail.gmail.com>
In-Reply-To: <CA+kUOamwQmK6te66sE+EVLPhwmBFZ+CXC9p=HJ4y0KC0wnkNsQ@mail.gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 5 Nov 2021 14:00:32 -0700
Message-ID: <CAPUEsphasEqT=qfHgO1o4LpzFSWcdhmtTk3o+hYaGNTs35EQKw@mail.gmail.com>
Subject: Re: [PATCH] t/lib-git.sh: fix ACL-related permissions failure
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, Fabian Stelzer <fs@gigacodes.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 5, 2021 at 1:16 PM Adam Dinwoodie <adam@dinwoodie.org> wrote:

> If OpenSSH were not installed on my system, Git would be compiled
> without this function and the tests would be skipped.

that is correct for the http dependency (because it is a library that
gets linked in), but not for the OpenSSH dependency, which is just
invoking the binary at runtime.

Regardless of what you have in your build environment the code will be
compiled in (and tested or not), and will fail instead at runtime if
OpenSSH is not installed.

Carlo
