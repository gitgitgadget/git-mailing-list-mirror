Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF9EC433F5
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 13:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94666610CB
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 13:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbhJMNGV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 09:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234135AbhJMNGT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 09:06:19 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E687CC061570
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 06:04:15 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id g25so8214526wrb.2
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 06:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=H9GpBC6jtU5rRlGwWxTEyN9rDNTtAteuTdSOjdsFvQQ=;
        b=gXX5J/5QzrfeWbSzN9XQ1jUCRuJ3nSr1ui1dH31T+2BGCOeCDnHOEPT2NecOc9sBVK
         HoMWQsosO9Z0ESlETqNtG+hmlGBThFiMAF70mdo1lCBJINTXm7Jndvy7iR8izPJ15ZTP
         /qQtV/Iu67W7pAI6THINrmuZO/r6kHIjLEyDuGkhly5zqMl4stq+FvdnHINr8LV+Xbz6
         CuYs7ooVeG+O6Mp0sU4bQlMdrJTIes5Wnuh5Wyo6XC20zgcRoBkJh0EbQ0XjaoBA6ZJc
         +b7JIKC2LAD/5oTv+wYLnYCknrdjh7OTocqgfI+YC2i1JZcfwQTiF6L4I8HNCMXwIxTX
         VqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=H9GpBC6jtU5rRlGwWxTEyN9rDNTtAteuTdSOjdsFvQQ=;
        b=2Ema5hosl6yvQJDgR99IxRd3l77wDgcjComkGGieZHsZuvkLs+nyVTauB0CO5wRYno
         Q2UuDJZMzdV80TgjljpfnQjY4DH8FQePApUV6Z+jz3iAWo3YyPTqJdJp2svTaVDpmKUW
         N7LbUVjyW2x7kx7CpxRLUUOYI1q9V2+wJ8TGKtp+ZGISq2dQOnAac6Yk+JC6m3BfZpqI
         OxNHwNrDNSpKudMB6xEU77FenIy5LVSiKenVdMMnEcH+oHQSNQxSqiCbROYjinMplOW8
         GHznd3xwB1ibWKD4yjjPun0O3ZsUbkagC3QA+vMrA1kDngqTwMrAcZFh6NW0pYAPScBl
         r2rg==
X-Gm-Message-State: AOAM531VPmuHciXjU1SJAed6amUTkvF1GG4UAaYx7MgzsjyffUR++V/h
        28EbjQfv8lZyondrpgksFJdv/oENFtAKGQ==
X-Google-Smtp-Source: ABdhPJxiCIpXub6dp0xpfwPL+sXK/mnO/v9Pr+NquJgpEcAQfFlO6JbRR5fnuPBDP66dKSB1X0anYQ==
X-Received: by 2002:a5d:598a:: with SMTP id n10mr16401892wri.81.1634130253980;
        Wed, 13 Oct 2021 06:04:13 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id z8sm13373617wrq.16.2021.10.13.06.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 06:04:13 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH 01/13] hook: add 'run' subcommand
Date:   Wed, 13 Oct 2021 15:04:08 +0200
References: <cover-00.13-00000000000-20211012T131934Z-avarab@gmail.com>
 <patch-01.13-a39c0748d3f-20211012T131934Z-avarab@gmail.com>
 <32bd578c-0369-8efe-8a92-d9ec248c0e34@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <32bd578c-0369-8efe-8a92-d9ec248c0e34@gmail.com>
Message-ID: <87fst5hy9f.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 13 2021, Bagas Sanjaya wrote:

> On 12/10/21 20.30, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> +run::
>> +	Run the `<hook-name>` hook. See linkgit:githooks[5] for
>> +	the hook names we support.
>> ++
>
> Drop the first person, so it become `list of supported hooks`.
>
>> +Any positional arguments to the hook should be passed after an
>> +optional `--` (or `--end-of-options`, see linkgit:gitcli[7]). The
>> +arguments (if any) differ by hook name, see linkgit:githooks[5] for
>> +what those are.
>> +
>
> s/what those are/supported list of them/ (dunno?)

Thanks, will address both.
