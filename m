Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD451FA3740
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 20:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235962AbiJ0UMi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 16:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236754AbiJ0UMK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 16:12:10 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2B489906
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 13:12:09 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 78so2633169pgb.13
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 13:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZMWbn3pJxrzDXBjD7BNGl6VMTAn4B8Yh48WGd3Bf8Z0=;
        b=DaZ2BRDO6N5OsdxtUh65aWx8fudLIaZ8t935qjB/rXdJl29j2l0l7hdaiWW+HTjdBd
         IT/rGr5t9Y8mVLFnDov04KsxgeeIO5PWkc4ZvqX1ptCJR+L89zSo1ByYTyiqjhikAh4H
         GLyovSz7OoyQHfapNDhBVHuo+riDptsXyyryRH37jKMxYARN95ST0CjGwEr9o3VsXNtR
         M20fBh8GtvIPwzZ02wwlN5mHmFSuujf2KL0/CWd2VS7ja90jdgBF51OMJ/+fNDM0Sf7J
         GD9cgBh9jZBINs9Vm6Lu9RVtW38lr6H6bZqV/3HS2t9ERMPJ9NbU9OF9iNHpJKtfwS/1
         LMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMWbn3pJxrzDXBjD7BNGl6VMTAn4B8Yh48WGd3Bf8Z0=;
        b=WMDAClSjs/NQC0lDocjGSfC34KPKhgqvK1tYzyg2uBuHjx8aumuuT6xdoIHg3y4gmQ
         g7I6BQm++hw4t01VWPp9oV/Yml8Gj0LWJOrzm46rDCzVs4dI/Aq7AxevgbyDYfd8jHIG
         bBTMgnIT/Kn1XhrpPlRX1yMqCYsZE9RWzEXH7E8ZDcVaU4Z7OAk+SBN7Bshk3PtA7tZL
         L5yyOvrnvLrndPa/8gbr/4x0WGGWTdh6wlVU4yI/IwxGGqNZ9TkkgUBG6o453SktvWlE
         EOAjnufYEqskLyocnj8tgklwD5OgkPXyDevjMkD6mZGlj1I5BLvjCJ51VFsqwtY/Wkw+
         nwog==
X-Gm-Message-State: ACrzQf01AAt9kcsW2bDxEKGLa/yVTST80eg2am3Ha7A7G+fTIs+1aepP
        TkbeXbbjMdps8D2b2HVhgFg=
X-Google-Smtp-Source: AMsMyM64AzrpweS0Lx3j2JLIIdppkgHborAMN69Qobnw7OQzyl08fhd/LOHw/KEh5JhbHA6OiE1Dcg==
X-Received: by 2002:a65:6944:0:b0:43c:da07:5421 with SMTP id w4-20020a656944000000b0043cda075421mr44490334pgq.72.1666901529102;
        Thu, 27 Oct 2022 13:12:09 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902e80d00b001869394a372sm1591069plg.201.2022.10.27.13.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 13:12:08 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>
Subject: Re: [PATCH 00/10] config API: make "multi" safe, fix numerous
 segfaults
References: <cover-00.10-00000000000-20221026T151328Z-avarab@gmail.com>
Date:   Thu, 27 Oct 2022 13:12:08 -0700
In-Reply-To: <cover-00.10-00000000000-20221026T151328Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 26 Oct
 2022 17:35:13
        +0200")
Message-ID: <xmqqsfj9jaav.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> I also think that part of the config API is a wart, but that we should
> go for a different solution. It's the only config function that
> doesn't return an "int" indicating whether we found the key.

Overall I saw some things to like in the series, but was not
impressed by others.  The _multi() thing in the earliest patch is a
welcome change, giving an option to call nonbool() is a good idea
(but I have doubts about the exectuion), and "does the key exist?"
may be a good thing to have.  Others ranged between "Meh?" to "it
might be good, but why does it have to be done here now?".

Thanks.
