Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C339AC433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 12:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236321AbhLIM7U (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 07:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235554AbhLIM7T (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 07:59:19 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B75C061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 04:55:46 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id r11so19002641edd.9
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 04:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=E5zH4ZQdcqN3dhXxunHkUNYhxm8OTKj2wW/3jVmWUgI=;
        b=CBbM1c1gE4+tLRmdOmTjgFDy6Okxjw/kcEI/4WFkcvQGJDROKMRbGfVKHTKzWxQiZX
         t1YafIp5JA2ChHnrZHhZ2woRtn0q2zzqRP9j6boIVOUBBT6bHi4IRCGjKG2lk0Gh5Vnr
         q3HhuSKsR7uSHjS+zvgkfDTPMkr2ETmwI/zLN2OEQczuG7/hWfthZ/cJejzmi6/jjRJA
         1pXUG7+40iT+By98uBfbfatc2YUv43BahAQFVL3O6KOy3qGX75gq4Q+wTRGZLR9Z4F6e
         Iq2+79U7w5novfew8pvAiUYyYm4kkKnGYIylc2KAONHqFZIF6XhVU6S78w0FO/F4JHgY
         ADog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=E5zH4ZQdcqN3dhXxunHkUNYhxm8OTKj2wW/3jVmWUgI=;
        b=U3/pcZ/JpK3bSY8wzwsAEPzuP40kyHAwRI8CmYQ1vTD0KuQ+/WbihnN0Ej4muwvR20
         0gHtIZdqTY5f0kdT5nTk6hTvrdElsYSLvPbcrXYzNTm0HEijD1aRsCDJTryVsnDIanlO
         82N2sCQ9n09ZPA/qCJQ58mVLtVK6U/loCDNqe4UtyGDgBPCueybKkw8LJ/T17e2p9OBi
         D3IqKNT+B4rssJVSB5CBiKat4LuWRxY9NBydVe+onLDtda5Bm2dEKp+awD/sXKPZ+fFY
         MHh+cVz//UzUDTJMVuPKInsSYedbWJPgmEIeNw8UwFyV0up6m75GFTYco5YFveNyWloC
         jNLA==
X-Gm-Message-State: AOAM5302ZLuZuBEEnE4/2NJgY9ovuMQ4OyXkBM2vojNbbBrTy60OoZYK
        XMUoxh8FkXb3N/jWTLPZnL4=
X-Google-Smtp-Source: ABdhPJxTD7aQE68spaC80/c2NEJh0WJkbjqkO3LY08617/VCv88tml0k8l46wys5hTpRCK6ERtKzTg==
X-Received: by 2002:a50:cdc8:: with SMTP id h8mr29040844edj.87.1639054544542;
        Thu, 09 Dec 2021 04:55:44 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id og14sm2717648ejc.107.2021.12.09.04.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 04:55:43 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mvIxa-0001oN-Aw;
        Thu, 09 Dec 2021 13:55:42 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 2/2] ls-files: add --sparse option
Date:   Thu, 09 Dec 2021 13:50:53 +0100
References: <pull.1080.git.1637077083.gitgitgadget@gmail.com>
 <e42c0feec94de0e4869cda1fc6b28bd7055774e3.1637077083.git.gitgitgadget@gmail.com>
 <211123.86h7c3wrg2.gmgdl@evledraar.gmail.com>
 <03a642fc-6310-1ea4-083e-9fe4530cf761@gmail.com>
 <CABPp-BGJJM757CoOPjP=XBK-cMMGJemaeruxXSN9TEGmk+NKvg@mail.gmail.com>
 <d1275b30-b9b0-a416-3300-9809d880eb55@gmail.com>
 <CABPp-BEyvkRdxJoJZcNF1VoQBcJajq1CVUrNTfHnHG433Q=cNQ@mail.gmail.com>
 <c8e22885-1759-d3d9-3944-2d70c70960e2@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <c8e22885-1759-d3d9-3944-2d70c70960e2@gmail.com>
Message-ID: <211209.86v8zydjjl.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 08 2021, Derrick Stolee wrote:

> On 12/8/2021 1:36 PM, Elijah Newren wrote:
>> On Wed, Dec 8, 2021 at 10:23 AM Derrick Stolee <stolee@gmail.com> wrote:
>>>
>>> On 12/8/2021 12:04 PM, Elijah Newren wrote:
>>>>
>>>> This actually looks quite nice, though the magic '16' is kind of
>>>> annoying.  Could we get rid of that -- perhaps using something to rip
>>>> out the diff header, or using comm instead?
>>>
>>> What I really want is "remove the first two lines of this file"
>> 
>> Is `tail -n +3` portable?  Looks like we have five uses of tail -n +N
>> in the testsuite, so it should be okay to use.
>
> Ah, that's the magic incantation. Sounds good.
>
>>> but perhaps "tail -n $(wc -l expect)" would suffice to avoid a
>>> magic number?
>> 
>> That works too.
>
> If the "-n +X" syntax works, then I'll opt for that.

I think it should be per
https://pubs.opengroup.org/onlinepubs/009695299/utilities/tail.html

But isn't that "diff -u" non-portable, per GIT_TEST_CMP. I.e. sometimes
we'll fall back on "cmp" etc.

Just pre-munging both "a" and "b" and doing a:

    test_cmp a b

Should work around that & make it portable.

I realize that's also a problem with my initial example, usually we'd
compare expected/actual, not the diff between the two.

But if that's more readable we could also just use "git diff --no-index
a b >actual" and "test_cmp" that v.s. "expected".

    
