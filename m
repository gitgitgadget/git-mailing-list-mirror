Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E429C77B7A
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 13:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237489AbjFFNcT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jun 2023 09:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjFFNcR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2023 09:32:17 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78E1118
        for <git@vger.kernel.org>; Tue,  6 Jun 2023 06:32:16 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-bacfcc7d1b2so7046974276.2
        for <git@vger.kernel.org>; Tue, 06 Jun 2023 06:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1686058336; x=1688650336;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9XG5v7haeA3o9M9RXRTFk0ILGcjTLiDB2YCRD5HWQwo=;
        b=C/5LAxzGzNLXoT6tQj2bpLHtIyrxKinTfPxlPskEH400uXSn5nvt2MfdTL5+V3Z92q
         CQl2pbjA71oOwOGAKbwOs6lcKI6pDLd6eQgxpwER6keX1sMenAQhAs/o/pVZjk3lqonK
         j3fdhb6jJ02bGtb6GhTVxdEakACgIKiHRiMgHTRh/u8a56iFAMtTiDoLe+5dt+gGQqj7
         P1M7sHzLHCEDbuYHQyompbXb2hq69DpNdnu6fXplIfOSHrikxhLe0R2DDHF2OCgHzWK7
         /wDECe/NFMEFe4s+gO8+NMN/C/8NFM9S/nFLH1rk+lf3QwnuaxLD+F7WP56sWXGmI9TE
         Xqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686058336; x=1688650336;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9XG5v7haeA3o9M9RXRTFk0ILGcjTLiDB2YCRD5HWQwo=;
        b=ju0EXzytHJ4CoE0gzKHwl87a1/vzI0bzvczM2rqbEEvgJ9wkPxsK90XdYZEJsAQ2u/
         WWJmXlt/XB2pAFnPdzPilVGqry2S96K3G371+cvqhlWsa94KP6px36iEe9EWx/8TCXEu
         gUXiphkU7Kz3pn9Rmlx0BN6TEVjdCkRSqYybnRmAUPlQ0TIsMWe4BB7UVx8nRK6nI2H2
         cY33PonuuzUgX2Wcpg5j163sChoLY8XphNrrmNSOnQrLOi6VKC049zI+hxdWraLIsUAv
         J3C8Ffx+5bGm3p4aR8P14FPKhS0aBzaqjU07Dcboj1StOvxTycKTSUGN78Cay7/rfcFX
         ObjQ==
X-Gm-Message-State: AC+VfDxe5BGlWx6Vhqbk7fMrXvU3DPSdURXC3uU5scUEwTQ5pthISZ5h
        T268RU1hy0YAUSz+GsO/iyF9
X-Google-Smtp-Source: ACHHUZ4n7gji019KaAKRUkvL542TDeBtjuu8FpYYa23OncLnuD3CSbVDN1Q/kdgBNw/WApiyldDMww==
X-Received: by 2002:a81:688b:0:b0:569:ecfc:dd77 with SMTP id d133-20020a81688b000000b00569ecfcdd77mr1875520ywc.6.1686058335803;
        Tue, 06 Jun 2023 06:32:15 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:3d87:d951:da44:1f50? ([2600:1700:e72:80a0:3d87:d951:da44:1f50])
        by smtp.gmail.com with ESMTPSA id h66-20020a0dde45000000b0055d7f00d4f7sm4026444ywe.22.2023.06.06.06.32.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 06:32:15 -0700 (PDT)
Message-ID: <e6c9b1a4-4700-1205-9606-86f611a7f9c2@github.com>
Date:   Tue, 6 Jun 2023 09:32:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] add: check color.ui for interactive add
Content-Language: en-US
To:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de
References: <pull.1541.git.1685994164018.gitgitgadget@gmail.com>
 <20230606021349.GC89456@coredump.intra.peff.net>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20230606021349.GC89456@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/5/2023 10:13 PM, Jeff King wrote:
> On Mon, Jun 05, 2023 at 07:42:43PM +0000, Derrick Stolee via GitGitGadget wrote:
> 
>> The fix is simple, to use git_color_default_config() as the fallback for
>> git_add_config(). A more robust change would instead encapsulate the
>> git_use_color_default global in methods that would check the config
>> setting if it has not been initialized yet. Some ideas are being
>> discussed on this front [1], but nothing has been finalized.
> 
> I think it should be OK to load the color config here, but note...
> 
>>     This is also a reoccurrence of the "config not loaded" bug from [3].
> 
> ...that this case is a little different than the core.replaceRefs one.
> One of the reasons we don't just load all config by default is that it
> was an intentional scheme that not all programs would respect all
> config, and color in particular was one of the things that wasn't meant
> to be supported everywhere.

...snipping valuable context...

> So all of this is a big digression from your patch. I think for "git
> add" it is probably OK to enable color by default. But I mostly want to
> point out that trying to roll this into a more elaborate fix may run
> afoul of all kinds of rabbit holes.

Thank you for this context, which I will keep in mind as an important
feature in this space. The default config doesn't have this property,
so I'll remain focused on those values in the "lazy load" work.

Just riffing: it's likely that we could load the color config in git.c
based on the "porcelain" vs "plumbing" category of a builtin. We have
that specification in command-list.txt, but _not_ in 'struct cmd_struct'
so it would take some work to introduce that concept.

Thanks,
-Stolee
