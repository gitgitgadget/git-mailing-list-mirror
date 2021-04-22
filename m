Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D231CC433B4
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 12:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B364613F6
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 12:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237139AbhDVMki (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Apr 2021 08:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237379AbhDVMkT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Apr 2021 08:40:19 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A88C061345
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 05:39:43 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id j12so28238980edy.3
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 05:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Jf5rhGqu82NXEo//b9VJvUiJfVLg2C00BcKZ8VsOxDs=;
        b=OVznPKFmWEX9tMGwDLPT6yUV9iDjJvXhzxTWbIraejgNSb7zcaaHxVvI33t/IQ56a7
         sWu5OYatwHTWQ8v3vdqdiV/jq8Mxv4QTAf2pVTltCeWY05LSidLqrIhuVajs/WT8J/KZ
         m7SG+Nk8N038fsyIMDHxAYY52baaKmcqs4ZsWb/2pwlbH56fcOVFdzOl5Z3ApOUhQciI
         FD1IKFQ95QRMfNFclP9zZX4xUkStnhK1DYAUoxHNTh7FeuRqgbQr4kqf8r7zjrG/veAe
         EDYYtaigBrlBHlSmvx8Tytku2ET/Wq6oGs7qAtKBG/LnXwAzhQ9zcTDiGpaFvx+37kUA
         34JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Jf5rhGqu82NXEo//b9VJvUiJfVLg2C00BcKZ8VsOxDs=;
        b=GKx9jQVP9q31LzlFsoj4wXZzF8iOHygwr0ui8sZEDgEVq1uOYTtDJcSFVHzXAKkp5l
         2MEEW8+EgAbh4Q77T5D/VCanlq8e0VS27EA7XamZ+yDa+uv4k7NrPcnxszqQGjIVoysn
         hQFeCis2CiUCdhj0xD7bzt6/dvA7xlvezDX10jUfQk65xHW0inFS/uCRFC8VOGwg4Qnz
         Lp9ajuTKnG+P4Q/1nUqzNPhp6pM79T/fZWya5UgOCPphXNAGFiAZTXcm3sy3XdO/dz74
         2lKx1fpM9kIrgFPno+EmwWkhB0XaxUdW67aYEjK60TKXBtBIctzbzz9Fp2AaWBP6CI/V
         Q9Ig==
X-Gm-Message-State: AOAM532sQA+lFu7T9yqbr0Acex9cMxl1nOaFiLn8PxZ6sMeTMyvkeeKA
        SrlaBbloV3HIQgPGPWYQlH5KMJ7pnHQ9Pw==
X-Google-Smtp-Source: ABdhPJyg1FvlTkcOfhdplFOXt6EdZA/CqNslfKE42oBBmqF/vulELfWMPJpp0x6BOXAmumn/lRbj4g==
X-Received: by 2002:a50:9b12:: with SMTP id o18mr3678284edi.376.1619095181989;
        Thu, 22 Apr 2021 05:39:41 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id h16sm2210821edr.19.2021.04.22.05.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 05:39:41 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v4 11/11] test-lib: split up and deprecate
 test_create_repo()
References: <cover-00.12-0000000000-20210420T121833Z-avarab@gmail.com>
 <cover-00.11-0000000000-20210421T101156Z-avarab@gmail.com>
 <patch-11.11-311a9dba36-20210421T101156Z-avarab@gmail.com>
 <20210421164357.GZ2947267@szeder.dev>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210421164357.GZ2947267@szeder.dev>
Date:   Thu, 22 Apr 2021 14:39:40 +0200
Message-ID: <87v98e1oj7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 21 2021, SZEDER G=C3=A1bor wrote:

> On Wed, Apr 21, 2021 at 12:15:16PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>  5. Since we don't need to move the .git/hooks directory we don't need
>
> Again: Since we don't need to change directories....
>
>>     the subshell here either.
>>=20
>>     See 0d314ce834 for when the subshell use got introduced for the
>>     convenience of not having to "cd" back and forth while setting up
>>     the hooks.
>
> I think this is worse and even more misleading than even v2 was, for
> the reasons I mentioned earlier.

Between this & the thread at
http://lore.kernel.org/git/20210420212731.GY2947267@szeder.dev I'm not
sure what wording you'd be OK with, would you mind suggesting an
alternative?

As far as I can see it's some subtlety of how we explain the cd-ing &
subshelling we did as a combination of eedf8f97e58 (Abstract
test_create_repo out for use in tests., 2006-02-17) and my 0d314ce834d
(test-lib: use subshell instead of cd $new && .. && cd $old,
2010-08-30).

Maybe you'd be happy with this:

    In the code being removed here we both "cd"'d to the repository
    before calling "init", and did so in a subshell. It's not important
    to do either, so both of those can be removed. We cd'd because this
    code grew from test-lib.sh code where we'd have done so already, see
    0d314ce834d, and later "cd"'d inside a subshell since 0d314ce834d to
    avoid having to keep track of an "old pwd" variable to cd back after
    the setup.

    Being in the repository directory made moving the hooks around
    easier (we wouldn't have to fully qualify the path), but since we're
    not moving the hooks anymore we don't need it for that reason
    either.

?
