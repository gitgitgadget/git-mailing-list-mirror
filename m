Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BE8C433F5
	for <git@archiver.kernel.org>; Thu,  5 May 2022 00:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiEEALO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 May 2022 20:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiEEALN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 May 2022 20:11:13 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D552C12601
        for <git@vger.kernel.org>; Wed,  4 May 2022 17:07:35 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id j4so4942114lfh.8
        for <git@vger.kernel.org>; Wed, 04 May 2022 17:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bwq33XycFYbQSNCpskyonezEjxjqDm9g0rjCKjege3w=;
        b=fmLei9P7Qtm2XIVb9y/dja1K4f3ew4SC10w8ssReVl0XM0tydXm2B2/gdiyuKcao/i
         HnC8pYEc3GBnWcew8etb376whh/i//zHalAQxLwrZyODbLIwBGJVD2CCK6gEtZea6GcX
         5s+Slb+ubcaWJUhFJlM57QsQYZV2X6AUNbPMIr868myO/kSCwrltzJza/D0vy2XhLMrr
         AtVJtkJR7OBuO7AiVPNFmACPsxlGm6lf5K9qx16jofqSgQbO5qjjzPZMgFYM/9HvmOz7
         SoZTRcmx6ztZPM/1eHOwHsvU8rt8dmYBmDIMHg2eLUoTwwhjPP9XvNiOYYudgK0jifGZ
         E82g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bwq33XycFYbQSNCpskyonezEjxjqDm9g0rjCKjege3w=;
        b=2Pl0Sor/3daU9ay9fiT8QQcYvSmxraYu3o4US+7HhVvOgSVH9JvinJne4T8fwyB+os
         83MPq9JOZNN6IgrUhdHtyf6FZcfIDotPAcYPEVdE9Oy5Hw4xsF4PVQ5NSG6/Xkx+Cs/6
         AM47dRnZSr/rGLlmTe3nHSn3+mPO53cpRWed63cWpWtOpAmuhmf+lZ+Z52eoptC0mv+A
         bpCdDAzmNx9u6s2nOzkIhODWZyBo+We57/She7DCQzUsgo1urUjMtF9VZEG3OXMiwmGF
         7byYaE/RWpOI+mNUUF8zdXYIKr6Z9Cf5Yebv8+lYnm5sR3SOoLurR6IY4I+FErC9Nkzi
         US8w==
X-Gm-Message-State: AOAM533j1/R/GC9L6IfKO2m17Yx7PR+Uqu88lAxipQaCihlfRle6WZOI
        aMUEyToiIWm0c6/mfRBF8No2h7KtGzqAi+ibqmw=
X-Google-Smtp-Source: ABdhPJxatPHWsAoUXZWSRg2A8MEBc0iYpCoKzJzA5VaUXL0t2aifxrEqC4rEECHe8J0sUhzXhm91Jl6zpOo1iVxo5J4=
X-Received: by 2002:a05:6512:12d6:b0:473:b308:ae0e with SMTP id
 p22-20020a05651212d600b00473b308ae0emr5890363lfg.664.1651709254095; Wed, 04
 May 2022 17:07:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220503132354.9567-1-worldhello.net@gmail.com> <xmqqtua5nz61.fsf@gitster.g>
In-Reply-To: <xmqqtua5nz61.fsf@gitster.g>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Thu, 5 May 2022 08:07:22 +0800
Message-ID: <CANYiYbF_UbVJJnaUD0nxgX6vkLA33Orn1947wAkyuxF+YGNQ8A@mail.gmail.com>
Subject: Re: [PATCH 0/9] Incremental po/git.pot update and new l10n workflow
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Fangyi Zhou <me@fangyi.io>, Yi-Jyun Pan <pan93412@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 4, 2022 at 10:35 PM Junio C Hamano <gitster@pobox.com> wrote:
> Allowing translators to pick a random point in the history and run
> the tool to generate .pot file locally creates that problem for us.
> It also means that various .po files would correspond to slightly
> different versions of the source tree.

As Peter said [^1], even keeping "po/git.pot" unremoved, we can always
regenerate the POT file locally instead of committing it, to update the
PO file.  We can add new checkpoints in l10n CI pipeline to check the
baseline for each PO file.

[^1]: https://lore.kernel.org/git/cb74f3b-c2e9-947f-8f89-f51e79b17825@softwolves.pp.se/

> The "only the coordinator updates .pot, everybody works off of that
> file" was one way to ensure that you do not have to worry about these
> two problems.

In the reply to Peter [^2], I demonstrated the effect of having a
POT/PO file with or without location line numbers on repository
size. We can mitigate the growth of the "po/" directory by removing
"po/git.pot" and committing the PO files without the location line
numbers.

[^2]: https://lore.kernel.org/git/20220504124121.12683-1-worldhello.net@gmail.com/

> I am not sure what your plans are to make sure everybody works off
> of the same version, though.  Even if you scrape the source tree for
> source files that may not be relevant to your build, if you do not
> start off of the same version, your set of sources may be a bit off
> compared to the other translators'.

We can use "msgcmp" to compare PO files from l10n contributors with
newly generated POT files and give suggestions in the l10n CI pipeline.

--
Jiang Xin
