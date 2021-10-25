Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD2CC433EF
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 21:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC61761073
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 21:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhJYV0W (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 17:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbhJYV0V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 17:26:21 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D68C061745
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 14:23:56 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id a16so14003712wrh.12
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 14:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=i+byR5cDE9X2XgWjIyXryVvqpDwZkNLQbhYF6EtX9Zw=;
        b=d8czYFBhdVixV/ByTljYpmwtnFHYPhiCWyN6C2gTH0Igwwa05w40pAY+i02aJ3jyND
         5Oa80QgJxLPXTi/TwafefebC5qXf5c93ayTquYb49500je+OgF0LDLt+MYUiNLJ4pMZC
         ADNFuZecmKxN2/YPt7UFp4lQ/TSqKy0fl2m2ClvOPqaThS1OWMLX76wsn+mjaJutteJ2
         GPaTCdqJ5y2jPO8lf2dQF35AvIqXF1D87V3NbbCObRaMdnP4rCa6jA41LaWrsjwtqtxR
         0Hm5WS5dCPlu5LhukeCkMP52/F3nf5TE0OWxVkBLUShaeBDAXHX7wLt52MUMUtlKph6h
         oDFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=i+byR5cDE9X2XgWjIyXryVvqpDwZkNLQbhYF6EtX9Zw=;
        b=YAg+LzCpzRNE+iifZBnbjgNoZSflrUl1lslhdJ6bz1MSUM25v1Qe+kgS53n+c0erFA
         xwjz6QaMYIoVEFXecGrkDBUYtP7Sk2Qww7CsZOBwwayLG49+Bk+Qocj0IyREFuTGdd9i
         qRBlYAp9sYGyZNxNzmqZloF8wW26Vw+FOUUohX9uoY8jBnbo6FH058Rj+9210guUCpKf
         5Q2DEroW4TVUhHJrsBGoj9Bw+j2UFRNguGu7RWqiZJkDoOfBcAff/nt8mH+zhN2oA42v
         9ahSOQfKi6k8+9lr0CvTfI3PDQA2Dcc/MZtFposlg3S/9UggEBXuU4LGFq5aNtArr6vz
         4GJw==
X-Gm-Message-State: AOAM533KMHyjQGNZ0v7PDYzVDxpV/4zun3yPuE3LSrWWMk26UiCzfniU
        YsDd/VrI/0DotlxAJ84pJl+/1KkqpvtNUA==
X-Google-Smtp-Source: ABdhPJxYKtsfgPnAoMYXofWjEdCemy9FTD+rWXj7ce1v5HqTIcaryhDP8IQnYKMpDnkPndZgYOtkuw==
X-Received: by 2002:a5d:588a:: with SMTP id n10mr15398736wrf.285.1635197035301;
        Mon, 25 Oct 2021 14:23:55 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id i24sm17477713wml.26.2021.10.25.14.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 14:23:54 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mf7Ri-001fNe-97;
        Mon, 25 Oct 2021 23:23:54 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 01/10] command-list.txt: sort with "LC_ALL=C sort"
Date:   Mon, 25 Oct 2021 23:22:09 +0200
References: <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com>
 <cover-v2-00.10-00000000000-20211022T193027Z-avarab@gmail.com>
 <patch-v2-01.10-96885282988-20211022T193027Z-avarab@gmail.com>
 <xmqqfssp0xge.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <xmqqfssp0xge.fsf@gitster.g>
Message-ID: <211025.861r483ij9.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 25 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> We should keep these files sorted in the C locale, e.g. in the C
>> locale the order is:
>>
>>     git-check-mailmap
>>     git-check-ref-format
>>     git-checkout
>>
>> But under en_US.UTF-8 it's:
>>
>>     git-check-mailmap
>>     git-checkout
>>     git-check-ref-format
>>
>> In a subsequent commit I'll change generate-cmdlist.sh to use C sort
>> order, and without this change we'd be led to believe that that change
>> caused a meaningful change in the output, so let's do this as a
>> separate step, right now the generate-cmdlist.sh script just uses the
>> order found in this file.
>
> Hmph, I do not mind sorting this file bytewise like this at all, but
> does the justification above still apply to this round?  I had an
> impression that we lose the sorting altogether in the end...
>
> Also, I am not sure where that "led to believe" comes from---do we
> have a test that checks the output from generate-cmdlist somehow?

We end up unsorting the categories we bitwise-OR together. I.e. the
CAT_* on a line like this:

        { "git-whatchanged", N_("Show logs with difference each commit intr=
oduces"), 0 | CAT_ancillaryinterrogators | CAT_complete },

But we'll still sort the actual command list, and spew it out as-is in
some places "git" and "help" output. So having it be unsorted or
shuffled wouldn't be nice.
