Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56385C19F2A
	for <git@archiver.kernel.org>; Thu, 11 Aug 2022 10:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234202AbiHKKvy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Aug 2022 06:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbiHKKvw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Aug 2022 06:51:52 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EED92F7D
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 03:51:51 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id w3so22497187edc.2
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 03:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=p4BxVqhxBLRDmTCQ1Ya1Hfnqy1pl+qHYkiOV5x55zy0=;
        b=IdX4V+1XAx6pxWdGSNnQLeGqGYEa7ACxz2FLYYqLKju/NBjuuLSGDy7Ht7NYsVsBUu
         zFZzchkkSyOnleJ+xTgubs6Wp4pLmmGkFuSOqcw8lQR9BjTqPDk0A7v9frIOxSOLFYZE
         xoVJilN0lHwzKE07IVS1pfsSHFA7z5QcexqL58eeelkALaslnJFZdJAr+HrpFNpsSAx6
         xTtYRhAJm7naptQXEhCJud5tD6bah3l3p8t75OGHZhJq68RdkvnSte4MCBl40RiTF8Er
         ZDfCa1mzE9np4M+MQg7MWQFF6cMMghVsB7DHSHBHwD7vn13r6amPqCRZerc7gYPEHFjv
         XAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=p4BxVqhxBLRDmTCQ1Ya1Hfnqy1pl+qHYkiOV5x55zy0=;
        b=ZP7iwq0swRMCpzHf1OuSxgvVXfcNeAXchiIBoGsQI652P/d5wQVXnfWKNJzjt+U32o
         mXlu+Q+sH2xKb/10xbgjW7AOjAJ/TgM/0iCCp9uVm6k590/FTYrwDaGlSwfdg2mwFL3j
         gqyvpnWZ50i9Lhl8/Jq+MwNySs/S4qpes+G4wN5h1EVBceA/lC+PE8LjVEmuYqQWehEY
         Er2rIB9e8Y1sgvuvAnrF++2QjW0ZUZUQYcPmEq2Qh25p79EqM0VDTIrbwBwoFIfxtjXC
         M8rNyeWvQ8xHhaH7HmjvhADtmNC8fRA5vTDPIiey+OJIJ++JJZ4/fb+EbBKJYJcgtOvR
         E/3g==
X-Gm-Message-State: ACgBeo3RV1w0gA+fHj3QOKoZlUh6qKAFFGUpJwlKjGMAzSJO+RtyZLi7
        hJRi71GcA/T231Yxj0h9RiQ=
X-Google-Smtp-Source: AA6agR4mT9g55papK4Ew9+HoHReewbsKlyu5REQ4k335wUV7uz9ou0l8fkHpbg8nQxDarxXN7iJIzw==
X-Received: by 2002:a05:6402:b88:b0:442:5d35:2133 with SMTP id cf8-20020a0564020b8800b004425d352133mr8909093edb.53.1660215109703;
        Thu, 11 Aug 2022 03:51:49 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id by5-20020a0564021b0500b0044235219c07sm3199591edb.73.2022.08.11.03.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 03:51:49 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oM5n2-001ATa-1w;
        Thu, 11 Aug 2022 12:51:48 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        johannes.schindelin@gmx.de, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v3 06/11] diagnose.c: add option to configure archive
 contents
Date:   Thu, 11 Aug 2022 12:51:28 +0200
References: <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
 <pull.1310.v3.git.1660174473.gitgitgadget@gmail.com>
 <0a6c55696d88cde666c11cd6b5d723c9e75a3b76.1660174473.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <0a6c55696d88cde666c11cd6b5d723c9e75a3b76.1660174473.git.gitgitgadget@gmail.com>
Message-ID: <220811.86ilmzqchn.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 10 2022, Victoria Dye via GitGitGadget wrote:

> index 06dca69bdac..9bb6049bf0c 100644
> --- a/diagnose.h
> +++ b/diagnose.h
> @@ -2,7 +2,14 @@
>  #define DIAGNOSE_H
>  
>  #include "strbuf.h"
> +#include "parse-options.h"

This is a stray include that isn't needed at this point, some mistake,
or needed by a subsequent patch?
