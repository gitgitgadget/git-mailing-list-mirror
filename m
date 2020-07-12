Return-Path: <SRS0=l3cg=AX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6894C433DF
	for <git@archiver.kernel.org>; Sun, 12 Jul 2020 13:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D3DF206B6
	for <git@archiver.kernel.org>; Sun, 12 Jul 2020 13:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=edwardthomson-com.20150623.gappssmtp.com header.i=@edwardthomson-com.20150623.gappssmtp.com header.b="P8yMhw/t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbgGLNDv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jul 2020 09:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728735AbgGLNDv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jul 2020 09:03:51 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CE0C061794
        for <git@vger.kernel.org>; Sun, 12 Jul 2020 06:03:50 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id o18so11167539eje.7
        for <git@vger.kernel.org>; Sun, 12 Jul 2020 06:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edwardthomson-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=7CkGKdSX6YEVEcUdun3HF2w4pXFziiux4oHhqoYUAWk=;
        b=P8yMhw/tPLjrjcUUUXceUyhMwL0EK4LLtkTHA1XI6LpTSm9nNlZR3Rko2eOAfBBE7U
         dFpUSqXTZ/nC3Fc3sZr6aDjhyZXgRz5x+xhhuNGVb9fvhNyzfebqqkhtcciFFmj4REyJ
         7F2qhcaMV06OCJps3e2LJM24vRN3wK5cBRoH6VpXrGAupnZ0fZPpbseCdFtDBcVAqnqi
         6S56QsrdDjp4wEQGIZptwX5eHHL7vzzDVmH0TfUXSLCFN2BF38utc+dA9OvAPKfsEvhA
         yOa8yIVfCTnvFfZ+PIR8HB4212oLlFRiMTclnPYHSDtFKwJTvz50axK9ghL5GL8BVyka
         N0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=7CkGKdSX6YEVEcUdun3HF2w4pXFziiux4oHhqoYUAWk=;
        b=GQ7VmMsytxhMG0SKYxDQVVc4ubKQMo81FQVLFmk3o/XqIvjDA3MqpByOT7F13O497H
         NbENMm9wMmimY1tNY1YzjBhbuOs+0cW9GYIXlXrWyzdWYEnDkXKTGRaMFlBapo7MrF/z
         WKqjkl+ABhCuVYl+ZU4JHWjSXPKQfTC05/YeCeVnpHxZzXfT2HEzqhaNvOLNJcop8ujS
         WW8vUt4H8OuSOAcrHVTdZnek6VUXqeuNzNLUR13vmTxL7tI/huVgXlD6g72KANmYGj5t
         mV2syL0Ji8dytLVsoXJRAgLm4ci52gl+YWlKVo5/v/Hwcup6VGwkV5w/a+dszEUZnM2B
         kbew==
X-Gm-Message-State: AOAM532CdnrnzR3rxf2YIgTqx5JGYpsotPY456Fp3huAeautepraRXup
        x/YBXFL2csGNO2KMLDxhsDyYhWK0pewIIII65NQsug==
X-Google-Smtp-Source: ABdhPJxO25tjnnP7DlcmW+Z3YJnVxtNgo1CfgAcjGQxACqrmD38br9Lky0Cf/blOkw4sI5eBgGErQV79FqR1xCmwMv0=
X-Received: by 2002:a17:906:c14f:: with SMTP id dp15mr69708222ejc.454.1594559029149;
 Sun, 12 Jul 2020 06:03:49 -0700 (PDT)
MIME-Version: 1.0
References: <pull.656.v3.git.1592951611.gitgitgadget@gmail.com>
 <pull.656.v4.git.1593009996.gitgitgadget@gmail.com> <20200629224113.GC9782@camp.crustytoothpaste.net>
In-Reply-To: <20200629224113.GC9782@camp.crustytoothpaste.net>
From:   Edward Thomson <ethomson@edwardthomson.com>
Date:   Sun, 12 Jul 2020 14:03:38 +0100
Message-ID: <CA+WKDT2DV6ymu-AG9B2h34=K+4KW7tcCpAfTV-rTdifqfS7R=g@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] Allow overriding the default name of the default branch
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Don Goodman-Wilson <don@goodman-wilson.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 29, 2020 at 11:42 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> I'm very happy with this and the way it's progressed since v1.  This
> seems simpler than earlier designs, and I appreciate the improved focus
> on avoiding special-casing branches, since I think that will make it
> easier for folks to choose branch naming that suits them.
>
> Thanks for working on this.

I agree, this is an improvement.

One thing that isn't obvious to me, though, is why templates take
precedence over the command-line option.  I would expect the command-line
option to be the highest priority option given, just like configuration
values specified on the command-line override values from configuration
files.

Cheers-
-ed
