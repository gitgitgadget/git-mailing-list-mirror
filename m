Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2A1C636CD
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 10:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjBGKVR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 05:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjBGKVP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 05:21:15 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E81C22A17
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 02:21:14 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so12793788wmb.2
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 02:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wNF6c+0A4+xPJmZxjeqrBLzhMITYaetkE6BrBpcLvj0=;
        b=A5TAt0n5mDC302Agoi1E4Trxbw6YX6qlVCkeeYYOArsKmqTHSpzE4N/QiMNqdQn+S6
         ZIPbvItpYA6q9h6FAoF7ZoJcpxtOIXidPLwEItlnReSSUIVCjJcId0uuGZBG3g++vas1
         Hz3v4F6RgQ5Svgnb4AQ3bc8V4yUnCd29XvGtIJE0L6Pq3DquP01daabGTXTffqhanpV6
         pDGM25kOdpZF9/3TdOzq8vR92cypnvfL7uWcWZpsnsytXQYLp6R/+53lBnCqovh5bPM2
         FYeu/MNI8Bj4G+Hgk+Wx/E+qYjvpzOx0SGvZ20295MoCsZUPpFFtbusvlMO3AjeqTq0q
         GuXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNF6c+0A4+xPJmZxjeqrBLzhMITYaetkE6BrBpcLvj0=;
        b=5i6Vjr+ynS/WWxoYTpQF69ykduAlR5mMIOFm4OdYlkTn6fdDe7vkKranIyrVg3Q574
         bP1YmnRPVNaqQN7sXZ9LKn7xmFBigaTFkxIUeVb7uffI1kPjZoeOzy0IVF/1WC/Dpd10
         5MQV/nznexUNGH20qoQcGpDusX2BfaltOxh542UZDY6P0xrw9kr8rHQojqBQbKwBGQwD
         L8P3ZoMtCnzOvSL0HzOS/TqOqxP9e+29L40mjXJ0iNMJl4jvy6XxMGTYd4B9qbwoqzZ4
         lofPc+IWdtrulmzImh664uzAJAjj+gqgXp8IXSGdmjAV7Q/LIO6KVFScapKeQqeIS+X1
         UqPw==
X-Gm-Message-State: AO0yUKX4Qx3aXyCORzLvuXDztAW/L6NG3aL7t4tCoIHUrNUgPHTTuZZL
        Lu2r848kk3rgKAQX9wka24s=
X-Google-Smtp-Source: AK7set/bnNJNd4LgaO19ItDofQsNjJVJSD8ERoy81NISodFTBinxQvROIe3pv5DEHUZ7AwulTwMokg==
X-Received: by 2002:a05:600c:a294:b0:3e0:10d:f1c with SMTP id hu20-20020a05600ca29400b003e0010d0f1cmr2679676wmb.37.1675765273100;
        Tue, 07 Feb 2023 02:21:13 -0800 (PST)
Received: from [192.168.1.212] ([90.248.183.175])
        by smtp.gmail.com with ESMTPSA id p10-20020a05600c358a00b003db1d9553e7sm20014572wmq.32.2023.02.07.02.21.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 02:21:12 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <25ce4764-177b-c961-9df2-1543a4e9e149@dunelm.org.uk>
Date:   Tue, 7 Feb 2023 10:21:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/3] add: remove Perl version of "git add -[pi]"
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?U2xhdmljYSDEkHVracSH?= <slawica92@hotmail.com>,
        Jeff King <peff@peff.net>,
        Philippe Blain <levraiphilippeblain@gmail.com>
References: <cover-0.3-00000000000-20230203T125859Z-avarab@gmail.com>
 <cover-v2-0.3-00000000000-20230206T225639Z-avarab@gmail.com>
In-Reply-To: <cover-v2-0.3-00000000000-20230206T225639Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 06/02/2023 22:58, Ævar Arnfjörð Bjarmason wrote:
> We've given the "git add -i" migration away from Perl to a built-in
> enough time to remove the old Perl code.
> 
> For v1, see:
> https://lore.kernel.org/git/cover-0.3-00000000000-20230203T125859Z-avarab@gmail.com/
> 
> Branch & CI for this at:
> https://github.com/avar/git/tree/avar/nuke-perl-add--interactive-2
> 
> The only change from v1 is to squash in a suggested change from
> Philippe Blain, thanks!

Thanks for doing this, it will be nice to only have a single 
implementation to worry about.

Best Wishes

Phillip


> Ævar Arnfjörð Bjarmason (3):
>    add: remove "add.interactive.useBuiltin" & Perl "git add--interactive"
>    add API: remove run_add_interactive() wrapper function
>    docs & comments: replace mentions of "git-add--interactive.perl"
> 
>   .gitignore                   |    1 -
>   Documentation/config/add.txt |    7 +-
>   Documentation/git-add.txt    |    6 +-
>   INSTALL                      |    2 +-
>   Makefile                     |    1 -
>   builtin/add.c                |   61 +-
>   builtin/checkout.c           |   12 +-
>   builtin/clean.c              |    2 +-
>   builtin/reset.c              |    4 +-
>   builtin/stash.c              |    3 +-
>   ci/run-build-and-tests.sh    |    1 -
>   commit.h                     |    2 -
>   git-add--interactive.perl    | 1920 ----------------------------------
>   pathspec.c                   |    2 +-
>   t/README                     |    4 -
>   t/t2016-checkout-patch.sh    |    6 -
>   t/t3701-add-interactive.sh   |   29 +-
>   t/t6132-pathspec-exclude.sh  |    6 +-
>   t/test-lib.sh                |    4 -
>   19 files changed, 50 insertions(+), 2023 deletions(-)
>   delete mode 100755 git-add--interactive.perl
> 
> Range-diff against v1:
> 1:  f39dde93011 ! 1:  71c7922b25f add: remove "add.interactive.useBuiltin" & Perl "git add--interactive"
>      @@ Documentation/config/add.txt: add.ignore-errors (deprecated)::
>       +	interactive mode, which then became the default in Git
>       +	versions v2.37.0 to v2.39.0.
>       
>      + ## INSTALL ##
>      +@@ INSTALL: Issues of note:
>      + 	  for everyday use (e.g. "bisect", "request-pull").
>      +
>      + 	- "Perl" version 5.8 or later is needed to use some of the
>      +-	  features (e.g. preparing a partial commit using "git add -i/-p",
>      ++	  features (e.g. sending patches using "git send-email",
>      + 	  interacting with svn repositories with "git svn").  If you can
>      + 	  live without these, use NO_PERL.  Note that recent releases of
>      + 	  Redhat/Fedora are reported to ship Perl binary package with some
>      +
>        ## Makefile ##
>       @@ Makefile: SCRIPT_LIB += git-mergetool--lib
>        SCRIPT_LIB += git-sh-i18n
> 2:  fb0dafaf4a4 = 2:  9299f22cc2c add API: remove run_add_interactive() wrapper function
> 3:  6ee56de1371 = 3:  09bece75c22 docs & comments: replace mentions of "git-add--interactive.perl"
