Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40D7C433E0
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 20:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD5662074B
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 20:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596055919;
	bh=TsDIRVbz3St7W1u6W8+swAXHlCDA+eCLyo8n6Rp3hrg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pIaFw0eFqvE/915X1gkyuG2en1uCJk4oCyxloFOgTYk4dVLigoUSJRTNunHLl6K5r
	 FkgaZ3zJ4aSkbaDqkGXURY/K07/PPryCcEPNWZd4DVGkzD+ucimHOecNWVHjsqz6bn
	 RZrWd28IHsUjRsD2CErmLIXxw5olencF1eg9zOQ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgG2Uv7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 16:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2Uv6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 16:51:58 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFE3C061794
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 13:51:57 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id i80so13768641lfi.13
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 13:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tFRCBQfaX8OpxWcwH1quou4ChAo7oe9BHGu8nAOIFZY=;
        b=KC0XTt57U+FckoRQIdDBdg+EsbLYC4ZQASW54Q8TgouHctEr0N4Jz7Hw5/KJ+Par7C
         s57BYcQYoBpuWFUGkf/5cPrWbs2cbillyc0dHdpWK5s9ou7QXJxBGG5IzOVfZf/k/SYV
         QpjWqk3npdcphYojSd+Z5kHZDdPb4JrfQegBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tFRCBQfaX8OpxWcwH1quou4ChAo7oe9BHGu8nAOIFZY=;
        b=stC66zAElL4LIgsuf0pXy4ZkbRDI0WDEcXYH4Cj5/pO39DDm65pcyPIyJRc8h0HPGQ
         hguplrxmwkMvJuuZhrj41Qfop5Et/oGsov6zh62MqTXd8OW2qnDvpPKwEy7Z7g7FsOqD
         y/ZEf15AOScQDeb58dYo7xUBtal4vbUrff47sVLhmfaydCM0iyuR0QSCBjz8Lwc6un/U
         mgrdhr/yS9qjDklc3cWZ/2D4mX27CfR9+WNu6bZ7G92AaH+Www5Whl9c2YwSzrUBx4jb
         IPiICIrGfTKNvQY/TsMZT/XSPQjYT+LJiL5dYDLM3w8hl1MMQlIUtHQPGLV+VkcN4r6b
         drbQ==
X-Gm-Message-State: AOAM532B8r9ec2aSamEt3M710muJDaWWkkyjOTVRxUYOLbgOCij3V7IQ
        A9Ut6aaZXhDqHLU+w7WM4leWkSRCOOk=
X-Google-Smtp-Source: ABdhPJzFW8aia9h+rWE7pY0JdwLxg6Ur4/j571bWrYEuffKm7U9lKFMGgoXqS13bUjThRQXrRCzgpQ==
X-Received: by 2002:a05:6512:312b:: with SMTP id p11mr21739lfd.202.1596055915289;
        Wed, 29 Jul 2020 13:51:55 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id l4sm595743ljc.83.2020.07.29.13.51.54
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 13:51:54 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id c3so6617423lfb.3
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 13:51:54 -0700 (PDT)
X-Received: by 2002:a05:6512:2082:: with SMTP id t2mr25781lfr.142.1596055914160;
 Wed, 29 Jul 2020 13:51:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgutLH=mPdJkLU_E6gO4q0FcG+=EEQJVVQeb+OxG9CfgQ@mail.gmail.com>
 <xmqqime69jfc.fsf@gitster.c.googlers.com> <CAHk-=wisOOrfEvab9S417MnPSY8dVkbDOKa6ccdi1Bg3X1PMaw@mail.gmail.com>
 <xmqqa6zi9hrt.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqa6zi9hrt.fsf@gitster.c.googlers.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 29 Jul 2020 13:51:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wixwAarobO2CaEBw16+A3ort4Qb7VcDkHT6uaa=07r5Cg@mail.gmail.com>
Message-ID: <CAHk-=wixwAarobO2CaEBw16+A3ort4Qb7VcDkHT6uaa=07r5Cg@mail.gmail.com>
Subject: Re: Avoiding 'master' nomenclature
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List Mailing <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 29, 2020 at 1:40 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> The original did two things wrong, i.e. treated one thing specially,
> and designated 'master' which has been declared a dirty word as that
> special thing.  Killing these two wrongs with one stone does not
> feel so stupid.

So here's basically the totality of the patch I just sent out, if you
ignore the reverts for all the side effects of the bad fix:

  -       if (!strcmp("master", current_branch))
  +       if (!strcmp(git_default_branch_name(), current_branch))

See? It fixes both issues, _and_ it doesn't break any test-suite or
any existing actual users.

So compare that one-liner fix with the commit I'm complaining about:

  git show 489947cee5

which broke actual existing users.

And then tell me which one is the proper fix.

Breaking existing users? Or just fixing the issue with a clean and
obvious one-liner?

           Linus
