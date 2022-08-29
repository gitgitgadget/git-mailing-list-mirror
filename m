Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7B7ECAAA2
	for <git@archiver.kernel.org>; Mon, 29 Aug 2022 17:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiH2Rrd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 13:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiH2Rrb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 13:47:31 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C005721C
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 10:47:31 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id c2so8726140plo.3
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 10:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date;
        bh=jj9NvfPLNCKoHjewvOhO7AKDGnUNHJ2dw4t7afw5INQ=;
        b=jEgGLeVXt/xd/hKh5tcrIDwjY2E7wjsQrKsHp+kLS1y1grGBbbVEGOsvQwmFbmfl83
         ow/ndUwjgdtaswcpkU8BiXVl4WN7Cfw0wjDCs3wplKXpy5QrxjuOicUyyvtFyGLaVgJM
         J2u6AWttnKKYynC6lDOXo2zekusyZg8ODcgWIeNBV/WifHYGz9y2cJ3TlOdcEizhk84z
         KUx/FWI8u9Ge1nEEx6r6Rzmmk/Dv7qrZwNzEdF5nBRX4nMbgul4bbciHHG/e4oqDQ/7K
         gpRNgEDx9SQ0gFdqiEfzQF/xpbKY8ezKsq5q8f+Em7vKy9IzqKEk8OZuDWgfV5XCXxCk
         pTFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=jj9NvfPLNCKoHjewvOhO7AKDGnUNHJ2dw4t7afw5INQ=;
        b=bBWucrMvIF5p/qhmC03sCZZAGQV8cenY4GU6wwdHfqUm34wW0zbhcQVrxu4urjek8z
         DBn6NuTSOOYhfBDFgcTNOOewVWFfv1Q5QTHplCFDn8PvGvO9hGdpH0VGePoHTsCdL0BJ
         kyXNiYOi2Zx03XEL8qsZPqVOfbhHpctIP2O88qUsh6ITluFGAIH38GpmS/j8bRrfvwpv
         d9P1h0GuZ/CjPODYDXv3uDYf3AfMW3f6NI7X7E8Ird72T4DSVuEe1GP6R26y7VXakz4i
         vYE1bsWPlwH9yCdI4W9NIMB8JQQGzwbe41iNujj9FZ0LhnykLi27udiL7IUnRe7fJ1LS
         ijPg==
X-Gm-Message-State: ACgBeo2Evep7G7cgt82Xx+jED5KTSQZPuAtDycmQM0CbkxByg8iV6zs4
        ze6/p1OuGviwy4KydiVg8+U=
X-Google-Smtp-Source: AA6agR4j9XG4WOFXzzzX//8UM6j4MYJpnRZd8ACbbAUSTd+erVSDvOsXfTJWUaB3bB8dIVo5PISYCw==
X-Received: by 2002:a17:902:8ec8:b0:173:12cb:e6c1 with SMTP id x8-20020a1709028ec800b0017312cbe6c1mr17417890plo.64.1661795250507;
        Mon, 29 Aug 2022 10:47:30 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id b4-20020a17090a5a0400b001fda6f4d45esm3530188pjd.19.2022.08.29.10.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 10:47:30 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v5 05/16] bisect--helper: make `terms` an explicit
 singleton
References: <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
        <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
        <92b3b116ef8f879192d9deb94d68b73e29d5dcd6.1661604264.git.gitgitgadget@gmail.com>
        <220829.86o7w32vv2.gmgdl@evledraar.gmail.com>
Date:   Mon, 29 Aug 2022 10:47:29 -0700
In-Reply-To: <220829.86o7w32vv2.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 29 Aug 2022 12:20:13 +0200")
Message-ID: <xmqqedwzndqm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Sat, Aug 27 2022, Johannes Schindelin via GitGitGadget wrote:
>
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>> [...]
>> -	free((void *)terms->term_good);
>> -	terms->term_good = xstrdup(good);
>> -	free((void *)terms->term_bad);
>> -	terms->term_bad = xstrdup(bad);
>> +	free((void *)terms.term_good);
>> +	terms.term_good = xstrdup(good);
>> +	free((void *)terms.term_bad);
>> +	terms.term_bad = xstrdup(bad);
>>  }
>
> This is pre-existing, and dates back to 0f30233a11f (bisect--helper:
> `bisect_write` shell function in C, 2019-01-02), but it appears this
> cast to a "void *" was never needed. Perhaps some C++-ism that crept in
> here?
>
> As we're changing this all around perhaps it's worth droppping the cast,
> or it could be left for some other "remove redundant casts" series.

Nice to notice it.  I suspect that at some point in the evolution of
the offending patch in 2019 the members were of type "const char *"
and needed to cast the constness away, or something, perhaps?

In any case, such a change belongs to either preliminary clean-up
before the series, or post clean-up after the dust settles, not
something we'd want to see "while we are at it" to distract us.
