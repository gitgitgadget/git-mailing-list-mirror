Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBB5C2D0E4
	for <git@archiver.kernel.org>; Fri, 27 Nov 2020 10:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02ECF2075E
	for <git@archiver.kernel.org>; Fri, 27 Nov 2020 10:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iizclCh6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbgK0KZ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Nov 2020 05:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgK0KZ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Nov 2020 05:25:58 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61E5C0613D1
        for <git@vger.kernel.org>; Fri, 27 Nov 2020 02:25:57 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id d17so4963142ejy.9
        for <git@vger.kernel.org>; Fri, 27 Nov 2020 02:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=rJGVX3H/0090OQtk2LCrRxxvW4Y/6pxzPaoOSMMlxV4=;
        b=iizclCh6/g5Ds2iS6Yo1xSmQ4ObH/IwbIAzJU+RlzZPUvRsdrI3pXLdsM7NA//QlTS
         aF+JpzlK3aD3OZPG33cxvx1BefnIBZ89TDyHo2nGaEqsKXMNnI0NMPZnK/ADaOwNUjUF
         nmzv7in+t6Z8iMk3a/LTL4tFXekfChjunz411BmyKYOBhze74lphfbuQudWB3xJlfyct
         rj5CsI+ipwEDD8zB3s0foK02I9RijCF69yXSPdp14Fn1vDySopNXIWtK3vXtYwkUGO6Z
         m7n/Ez2S/lThd38JqO6Nf4crSQKYhaPI3Ahpnl+3ah8L+V/y4pJPjm/WzGBZz+FJn9Gm
         PcYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=rJGVX3H/0090OQtk2LCrRxxvW4Y/6pxzPaoOSMMlxV4=;
        b=RSQh96FoKP30nttSXtYuB2NoODl2yCafyYaweNOKGLb/FDyqBUblP7ixslWd4LZcSC
         B1d8kt+IXkYJ/Jt+2JU5KoXcETrUkQlZE8gUqPS6wFfI01V6pAit4FR3J2WBrmf/dtfi
         NLlnV2eNmLmQRrQlnt4WH58/yJ5CpsCihC61Ir1IWbJvPjshyxk4C0SOPfR4HEy+7vB1
         hMKORR2ucobITvAKFA0s+4V5AGD6ZyTmkQD+tlRCs2EBnM/6e6LzBP2gwDHyb8v/fXwe
         HykxHnQz0bKN/LyAa+jkTJmmqKvGxZZvw7eMz7JbKQG7GaYVluffMgbogvRRNo6YqOWQ
         VmjA==
X-Gm-Message-State: AOAM5339xoETy/+ejZ64ET0H6bhl4+DvNAGyVzF7sKJkCLUBICTOMc6Y
        3CqabNpHTTtvUkGiLWQezFQUu8iBSQdSYA==
X-Google-Smtp-Source: ABdhPJwNfcz7XHy5oTJnPXrCsdi12JFsVm+By7rY8/O1NckG0mbnifp32Jcc6EgJvYhXCDQpnjqsbg==
X-Received: by 2002:a17:906:f905:: with SMTP id lc5mr4678929ejb.177.1606472756072;
        Fri, 27 Nov 2020 02:25:56 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id gf6sm4648878ejb.80.2020.11.27.02.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 02:25:55 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v3 04/16] reftable: add error related functionality
References: <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com> <pull.847.v3.git.git.1606419752.gitgitgadget@gmail.com> <2aa30f536fb7ce5501d1ecf0315cbcb1c1c5ce38.1606419752.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <2aa30f536fb7ce5501d1ecf0315cbcb1c1c5ce38.1606419752.git.gitgitgadget@gmail.com>
Date:   Fri, 27 Nov 2020 11:25:53 +0100
Message-ID: <87im9rnlji.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 26 2020, Han-Wen Nienhuys via GitGitGadget wrote:

> The reftable/ directory is structured as a library, so it cannot
> crash on misuse. Instead, it returns an error codes.
>
> In addition, the error code can be used to signal conditions from lower levels
> of the library to be handled by higher levels of the library. For example, a
> transaction might legitimately write an empty reftable file, but in that case,
> we'd want to shortcut the transaction overhead.
> [...]
> +	static char buf[250];
> +	switch (err) {
> +	case REFTABLE_IO_ERROR:
> +		return "I/O error";
> +	case REFTABLE_FORMAT_ERROR:
> +		return "corrupt reftable file";
> +	case REFTABLE_NOT_EXIST_ERROR:
> +		return "file does not exist";
> +	case REFTABLE_LOCK_ERROR:
> +		return "data is outdated";
> +	case REFTABLE_API_ERROR:
> +		return "misuse of the reftable API";
> +	case REFTABLE_ZLIB_ERROR:
> +		return "zlib failure";
> +	case REFTABLE_NAME_CONFLICT:
> +		return "file/directory conflict";
> [...]

Not for this series, but I wonder if the eventual integration into the
i18n framework in git needs some thought, seems all the (including
presumably stuff show to users) UI strings are hardcoded English at the
moment.
