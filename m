Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659B0C25B50
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 18:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbjAWSwX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 13:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjAWSwV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 13:52:21 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9771116E
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 10:52:20 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id qx13so32979109ejb.13
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 10:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fE0Ux+lbf57b8g4ORcAi9v+YiWUu2p3C37ZfxKip/vg=;
        b=EJESD2kjrXR131rN8hU3QvdzVPeuiD/hz8JD98mLDcCoFoQisHdMCa7HLZfoRxoe7j
         Dd8yH/gWr2mW1DAiBaBFOsjnAHBZh8fd6s9UM/kkQAWaouTuf4vvNk/dwcEH6x5/FeoG
         YFgt3bOvZCLU5mxUwwfRjf5nf1/fWYht7f4Qsn/B6SvK0tDm869Bea09hNWyklbqoZRS
         U6c3LeFmsexi91QdbO9oCjeCM+sFRSiAyAzsr/E3GvpDDhnks+TiDOMfjgZNbvCeCb1m
         KnuspHCTtOYE78aTXTBwS8uw9ViJtVTe1r9J7ZzzW5z6gHqtuRmhABf5Ms4CPU3EuUaO
         m0kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fE0Ux+lbf57b8g4ORcAi9v+YiWUu2p3C37ZfxKip/vg=;
        b=2UpvJ1iZnVlJyULzch2glaUpDQ+NNT1qRW14MdZjwHe+nqQ9BpoKoS0VCu2QIhHhar
         ecssJv/yPxvfOLo4raK+o3Srj0ilFarCZx/RqFRwwwTfIdd91Nznu2U97Z4d66bjF59S
         OeFtFR5sNuj7ze/aKeg9Ycqr4bB03BVO8OVSp89dXEMbVFaM6oa5/FNVsS7SQYj6MRqj
         toOMC1Jif7r5qwRYmGP6GhWVnzFm5EQRzqUoyMjDuPvep+VjdRLozVrQe8bFnFmH5KH4
         VsQqbTJc8WVxRo8ywrn/7abNaPUO26lqHHwNgW+Hr/4QvL7Jql2CJwBzO1bvE4VNwxNO
         CLXA==
X-Gm-Message-State: AFqh2krm36YVMJKhUw1X0AgzFyq4T3T0M10j/+XUSqqRUgKCsbB7v7tb
        Rt5HXV4LNvQ0pxb+zThMtWY=
X-Google-Smtp-Source: AMrXdXuZOyrV5WW19IilDI2/I732SRqf5H6ld0A1I+cJCiQ2V0utaaiAicltEM0LakF1MVxm86rgXQ==
X-Received: by 2002:a17:906:1b4a:b0:84d:4e4e:2c7b with SMTP id p10-20020a1709061b4a00b0084d4e4e2c7bmr39683560ejg.30.1674499938486;
        Mon, 23 Jan 2023 10:52:18 -0800 (PST)
Received: from [10.8.18.177] ([45.88.97.214])
        by smtp.gmail.com with ESMTPSA id kz11-20020a17090777cb00b007aece68483csm22596349ejc.193.2023.01.23.10.52.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 10:52:18 -0800 (PST)
Message-ID: <e3f57ef0-7544-8f35-fd97-fdcbe1144e7e@gmail.com>
Date:   Mon, 23 Jan 2023 19:52:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2] Documentation: render dash correctly
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <20230122165628.1601062-1-rybak.a.v@gmail.com>
 <20230123090114.429844-1-rybak.a.v@gmail.com>
 <CAN0heSogz0cdhVJdiZhCc2_fcHzJggPjbS0wCAQkRh1uZMxLig@mail.gmail.com>
Content-Language: en-US
From:   Andrei Rybak <rybak.a.v@gmail.com>
In-Reply-To: <CAN0heSogz0cdhVJdiZhCc2_fcHzJggPjbS0wCAQkRh1uZMxLig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/01/2023 12:04, Martin Ågren wrote:
> On Mon, 23 Jan 2023 at 10:01, Andrei Rybak <rybak.a.v@gmail.com> wrote:
> 
>>   highlighted with a `$` sign; if you are trying to recreate these
>> -example by hand, do not cut and paste them---they are there
>> +example by hand, do not cut and paste them--they are there
>>   primarily to highlight extra whitespace at the end of some lines.
> 
> OK, so this is one of the new ones compared to v1. I can see the
> argument for adding some spaces around the "--" for consistency and to
> make this a bit easier to read in the resulting manpage (which can of
> course be very subjective), but then I can also see that kind of change

There are some less subjective guidelines.  Asciidoc turns "--" into an
em-dash.[1]  In English, em-dash is almost always not surrounded by
spaces (it is in French, for example), while en-dash is spaced in
English when used instead of an em-dash.[2][3][4]

This means that it's all the other places that use " -- " with spaces
that are incorrect.

References:

1. https://docs.asciidoctor.org/asciidoc/latest/syntax-quick-reference/#text-replacements

2. English Wikipedia is clear about its usage of en- and em-dashes:
    https://en.wikipedia.org/wiki/Wikipedia:Manual_of_Style#Dashes

3. Chicago Manual of Style FAQ doesn't spell out the spacing, but it's
    clear from examples:
    https://www.chicagomanualofstyle.org/qanda/data/faq/topics/HyphensEnDashesEmDashes/faq0002.html

4. More confirmation on English Language and Usage Q&A website on Stack
    Exchange network: https://english.stackexchange.com/a/154998/54197

> being left out as orthogonal to this patch.

Indeed, correcting spacing around dashes is orthogonal.  Also, it might
not be very desirable to have so much churn for spacing issues.
  
> This v2 patch looks good to me.

Thank you for review.
  
> Martin

