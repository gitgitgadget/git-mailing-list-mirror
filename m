Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E36DC19F2A
	for <git@archiver.kernel.org>; Thu, 11 Aug 2022 10:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbiHKKyU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Aug 2022 06:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234480AbiHKKyT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Aug 2022 06:54:19 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5A193539
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 03:54:18 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id fy5so2029862ejc.3
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 03:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=O/iOdmo0wTsYu/ZPPXmYKUbHvsA5GUuDQ7QHBc/AEZE=;
        b=mqBFl90iZVkI4329Dz7zlDCraSd/bFRQG/NDx+eOUXjvAD4w9enhb7EceAZ3IDIFPr
         utXpyUPJKY0V4KUswahHgnX7/oYPHMru+0RCTjBuFSv07ltbItbsZ5ma7Ih/P1V2EF0f
         OAc7HwGrYW7VlZ1AmlQjXz6WiKbyzIjAauCocsT9ljsncJoxsuw+Lmr0IZLO2vqvzfoI
         Fhl1DSwF/FcZHL16BN54iaeWYm7fEp3ZT3h69HgC4mtv5SxyxixBvNItXdfdhIElazng
         EYHapjlYdj35kep/5YcRg78Af+iBWarPa9UBBqdPwFbQa3K2/g5oii7/0dR3/CcJv/p8
         9gAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=O/iOdmo0wTsYu/ZPPXmYKUbHvsA5GUuDQ7QHBc/AEZE=;
        b=ShqB/POT7oJ9kQT+oSsEALmwS+tnd2T1wOcyCvKjeBF8agVq6e0TEEnp8+5jNol2Je
         uA5mTTjjNEUskF0DlN5M0+3FlJ1BW7i2Ojq5v4Yot1ev34KfL69i/zWp3H+5X6h9VfIP
         XQ7Cv0vvGqqGdKWUpK4g9oIGzNR9jsizFf9AcoDKRzZIZnq5bLGgxa0qAqXC3RpjcJsC
         3mKPzyAjpxO/1Zlc6ECw7x8CDnQs9CmxhLfYYdD9D/rz2AGtd/ueT3Z4POQBHjvbSGJ0
         ZbEIGu0506+RJB9eEh8zyI28DR/E0VO20GzJCzXpWZ7ploDw/lkpnMMSGSC1Ml2kGWT5
         9qrw==
X-Gm-Message-State: ACgBeo1xfH7pV003syBDN/LiLSzt/UzCT+OLm75P1MscVOkiSsIVSm5y
        HDMPHynrUeNnGBauDkhs3LI=
X-Google-Smtp-Source: AA6agR6Zu+vLLErTI1AQF8fNL4CcS7/SdkHDasYCkh4qpXnrQQPRbNoJpscoiPCs+caJP+peMyIiiQ==
X-Received: by 2002:a17:907:9809:b0:733:1ce:9564 with SMTP id ji9-20020a170907980900b0073301ce9564mr6553408ejc.363.1660215256656;
        Thu, 11 Aug 2022 03:54:16 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id o7-20020a170906768700b007300d771a98sm3419213ejm.175.2022.08.11.03.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 03:54:15 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oM5pP-001Ab3-1E;
        Thu, 11 Aug 2022 12:54:15 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        johannes.schindelin@gmx.de, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v3 09/11] builtin/bugreport.c: create '--diagnose' option
Date:   Thu, 11 Aug 2022 12:53:48 +0200
References: <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
 <pull.1310.v3.git.1660174473.gitgitgadget@gmail.com>
 <1a1eb2c980635415c04d5c8d9a62bd972482d7dc.1660174473.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <1a1eb2c980635415c04d5c8d9a62bd972482d7dc.1660174473.git.gitgitgadget@gmail.com>
Message-ID: <220811.86edxnqcdk.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 10 2022, Victoria Dye via GitGitGadget wrote:

> From: Victoria Dye <vdye@github.com>
>
> Create a '--diagnose' option for 'git bugreport' to collect additional
> information about the repository and write it to a zipped archive.
> [...]
>  'git bugreport' [(-o | --output-directory) <path>] [(-s | --suffix) <format>]
> +		[--diagnose[=<mode>]]
> [...]
>  static const char * const bugreport_usage[] = {
> -	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format>]"),
> +	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format>] [--diagnose[=<mode>]"),
>  	NULL
>  };

This still has the SYNOPSIS v.s. -h discrepancy noted in
https://lore.kernel.org/git/220804.86v8r8ec4s.gmgdl@evledraar.gmail.com/
