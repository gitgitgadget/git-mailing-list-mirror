Return-Path: <SRS0=oWbz=C5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A045C43465
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 16:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05FEC20EDD
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 16:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuvGwEpv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgITQbo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Sep 2020 12:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgITQbn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Sep 2020 12:31:43 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06D1C061755
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 09:31:43 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id kk9so5703691pjb.2
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 09:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2ut4pCLPzCHHcAgBS+MJEeumkzQClvSpNmvy00f+mKQ=;
        b=kuvGwEpv7q7yQakElBKs5YuVxkQiAW8bXEavjEIIE8FW4bFdw1UHxH96G3t1dwzVfc
         jQoqD7HdSVjOEA4oQTnq2dTw8cHFXbBfdYkEQYHKNayPTedr1fQ+W/e7pz8ZAc7mqcpa
         dmZv7vV8L15mHgRgFOYv0PjY+0SmuHqHgR1/vWaRHOMFvS1L6BDDtfl3IfmvJOCpJeRQ
         Zzk4xTfrWjWtNYEq68K3ZwWbH0KU+fxiL8rrZzep8vTtAUQPuHTryiaYjfag3eWVP2yz
         j/OwM8Dithg+YwcVOR1ULRQ1s1T6F1gq576kLJAfN4MKtMAVgXEJc+by3RTw2yTXjlaM
         LbBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2ut4pCLPzCHHcAgBS+MJEeumkzQClvSpNmvy00f+mKQ=;
        b=XAp8Kt8CBEkAHPX2e5V2Ygeyb+WRJEYXh/yFGJRF5XrqRZsBFZqI9+eRuHerTO+OlN
         /3W5iaL/t99XJO5I4K60ufPhh4yZP7J+oIqama6/6tgWH2FlhXgqvdhQ0vkuf4X5J5do
         c0nWHWNg4/VwIblANF11c7FhorQd5Sszbg2/NTpxNCqhIIzxIWrwQU3ZoNLwln1bS8c3
         Ui28L0tUXU81ZoiuKL10nhVEe9Qo7XzjL8E6IxRO/Yo/cEEOuCftFiKNk+6DATL0HOx6
         PR5sOL67ntvwFIbDfWEKKWo3Ztl5xgB7cO4G7CukcvaacmiS2HMv4Jt/qQY8JGaSR6kN
         j3qw==
X-Gm-Message-State: AOAM531m+uKxPBuL7AA3edEEU1TIlSbrY+2BL1lFldi1wLWb5mCrIuOf
        Eu77yN0m+MRR8zgxlTbbvD0=
X-Google-Smtp-Source: ABdhPJwu7Sm+rLk+3hab9towO+qtR9pgtO5jpltMbyD2hWe4xCQLn7SDadrUjyY662f53QHrno1bSQ==
X-Received: by 2002:a17:90a:5a:: with SMTP id 26mr21014872pjb.0.1600619502984;
        Sun, 20 Sep 2020 09:31:42 -0700 (PDT)
Received: from [192.168.208.37] ([49.205.85.152])
        by smtp.gmail.com with ESMTPSA id b20sm10121684pfb.198.2020.09.20.09.31.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Sep 2020 09:31:42 -0700 (PDT)
Subject: Re: Git in Outreachy?
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
References: <20200828065609.GA2105118@coredump.intra.peff.net>
 <441bd08b-ca7d-5977-a455-c4c2a4bd4bc9@gmail.com>
Message-ID: <a9b7cac1-1993-dbf9-a048-a81c2c39a906@gmail.com>
Date:   Sun, 20 Sep 2020 22:01:38 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <441bd08b-ca7d-5977-a455-c4c2a4bd4bc9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07-09-2020 00:26, Kaartic Sivaraam wrote:>
>> I would appreciate help to find project ideas though. Are there still
>> scripts that are worth converting to C (excluding git-bisect.sh and
>> git-submodule.sh that are still worked on)? 
> 
> I think Dscho's e-mail linked below gives a nice overview of the various
> scripts and their likely status as of Jan2020:
> 
> https://lore.kernel.org/git/nycvar.QRO.7.76.6.2001301154170.46@tvgsbejvaqbjf.bet/
> 
> I'm guessing only the status of submodule has changed as it's being
> worked on now.
> 

After giving it a second thought, I believe I should take back my word
about the git-submodule status changing. There still seems to be some
work left for it. To be clear,

- there's 'add', whose conversion is currently stalled [1]
- there's 'update', which still has a decent amount of code [2]
  in the shell script.
- we still have to complete the conversion completely converting
  moving the rest of the bits from `git-submodule.sh` to C which is
  mostly just the option parsing. This might be more trickier than
  it sounds as we would've to ensure the we don't accidentally
  change behaviour of the options when moving the option parsing to C.

  There's also an e-mail from Junio which is relevant [3]

I'm not sure if this would be enough for a complete project on it's own.
I'm also not sure whether 'add' would get converted in the meantime. In
any case, I believe we could add a few other small refactoring projects
to make up for the rest of the period. For instance,

- Replace more instances of `the_index` and `the_repository`
  (https://github.com/gitgitgadget/git/issues/379)

- Turn the `fetch_if_missing` global into a field of `struct repository`
  (https://github.com/gitgitgadget/git/issues/251)

- Possibly others from #leftoverbits

Thoughts?


References
===
[1]:
http://public-inbox.org/git/20200824090359.403944-1-shouryashukla.oo@gmail.com/
[2]: https://github.com/git/git/blob/v2.28.0/git-submodule.sh#L554-L713
[3]: https://lore.kernel.org/git/xmqqtuzrrk8r.fsf@gitster.c.googlers.com/

-- 
Sivaraam
