Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB33C433EF
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 15:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C920C61AAA
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 15:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbhKOPWL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 10:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbhKOPWH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 10:22:07 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA0CC061570
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 07:19:11 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id z10so47038586edc.11
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 07:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Il6EKVv34RiK8wmmuwzggmDB1tpn9RaSiJfwvTDUDz4=;
        b=d/SnVOIdlYonjUguNjLYXlYNJakdPGg7c93UJc5gm+5FtTd8OxcR32Ugbx3twtvWho
         D3JLqWHz6jGfGv4GaOSuovWvYBFXXEOJkFnfrqPk280m1MwhbRGrwEXDVaAWA6fX2C+d
         gGySDdl0HZqxwcCxpOoqLg1ghgJ7LezJ8VFWTGvobpcTWMwl0mnNNsFsKDDf6YiKi6gX
         +7k5OMWI/EjYAxJKI1sgdnBikRvw+BrGvapRDAfgEFfuccIJsxVEPnOJN06ixLCNjwRN
         wykdiH56eIFUq2/Rxyi/6MY31Pd5ETPfjMNW0tLKqR9ZY4Xvdd3IX4kT8ZwDsJZk+dCQ
         Ag0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Il6EKVv34RiK8wmmuwzggmDB1tpn9RaSiJfwvTDUDz4=;
        b=PL2/P3r5NXF/kPMwxpp/JVivbq5aMgr09+qor53IGnX0PaDL/imBO4jhdAuPlif7ou
         RFwL0v6LFRBXKfo6a8YxQPVRfCEeU6EFKvN7Eug8DxWU7f25G810n5l/Y+AULeIh0LM2
         OubHP2B5bXXlkc3CLOmet2ytRyjY4GWNKFTWzLMHsVHCdtwcC1bYucyslPc40XQwIBki
         izXgXM3j9MdiaYC4K9LdSoSsNNVupDLHrSFQhOx3UKZBziX8vitFmU1h0rN/dOzRp01U
         RH3LEdhkxTuE7+k1dAywYACkPQIy2wTJtVL41yG3bfPCGKJw0FY+h2+OyEjx4mpntTEc
         9nyw==
X-Gm-Message-State: AOAM532ga9BY+n8rrJMQiEysN3347UWsSCrNrZSEpxk2C0KFQFOTnEYV
        TBDwnaBADm8+Z/t7cepiY1E=
X-Google-Smtp-Source: ABdhPJyHrBU920qCW86r9/KQtb0rT6G44d9efsVmioWgSCEB4DK4Sh0Gz+2mulf342JLr/AmHk0EBg==
X-Received: by 2002:a17:907:7255:: with SMTP id ds21mr14485729ejc.42.1636989550089;
        Mon, 15 Nov 2021 07:19:10 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id e26sm3785695edr.82.2021.11.15.07.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 07:19:09 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mmdlF-0018Hd-0j;
        Mon, 15 Nov 2021 16:19:09 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH 0/3] support `--oid-only` in `ls-tree`
Date:   Mon, 15 Nov 2021 16:13:24 +0100
References: <20211115115153.48307-1-dyroneteng@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211115115153.48307-1-dyroneteng@gmail.com>
Message-ID: <211115.86mtm5saz7.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 15 2021, Teng Long wrote:

> Sometimes, we only want to get the objects from output of `ls-tree`
> and commands like `sed` or `cut` is usually used to intercept the
> origin output to achieve this purpose in practical.
>
> The patch contains three commits
>
>     1. Implementation of the option.
>     2. Add new tests in "t3104".
>     3. Documentation modifications.
>
> I'm appreciate if someone help to review the patch.

I've looked it over, they look correct mostly, the test code in 2/3
looks a bit too complex (using find?).

But I'd much rather see this be done with adding strbuf_expand() to
ls-tree. I.e. its docs say that it can emit:

    <mode> SP <type> SP <object> TAB <file>

Or, with -l:

    <mode> SP <type> SP <object> SP <object size> TAB <file>

If you use strbuf_expand() you can just define a default format of:

    %(objectmode) SP %(objecttype) SP %(objectname) TAB %(path)

Then make the existing -l option a shorthand for tweaking that to:

    %(objectmode) SP %(objecttype) SP %(objectsize) SP %(objectname) TAB %(path)

Then you can get what you want out of this with a simple:

    git ls-tree --format="%(objectname)"

See e.g. git-cat-file for an existing use of strbuf_expand().
