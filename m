Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A44AB1F403
	for <e@80x24.org>; Thu,  7 Jun 2018 17:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933651AbeFGR2I (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 13:28:08 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:40035 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932693AbeFGR2G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 13:28:06 -0400
Received: by mail-ot0-f194.google.com with SMTP id w9-v6so6962131otj.7
        for <git@vger.kernel.org>; Thu, 07 Jun 2018 10:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FtIloF8OWznXizC6IpjMMUuu/7OjalTUdmbiRqG3Vw0=;
        b=V4x+0H5bfUqlECbhPimNNMFw3PtR3Tdm3re6dXMtpDPRhHISNG7WAtadmw4NUvK6t6
         bZQwBV6fEDI0RrIJUJt3FVNGJE4sva3LUxmzBqyKRBRv6oKnsIpMcG8H3nq2W23jPez4
         K7Qtm9ahv6+yr8PGtzxG8Hkgopl3aPV4PZb+f3NQ+3rwMwDvRdI3ckNn+FhrKCNr3T7d
         DDpgikODH9feXLd3v01UHfV3PhCidZneh3e1uD1NzYcNh5qHpBNt6GTVCxiJ/7VD6kjm
         YVdwXOOWRtrIz5axlgYezUX/5itpVHQ9+Yqp3QT5C+q4RJXX/ypAsa5wlUtyEGukp4v4
         TTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FtIloF8OWznXizC6IpjMMUuu/7OjalTUdmbiRqG3Vw0=;
        b=myaIBX6UykCTz8k40EqmVVotkkzT2d5RkkHqg3nXdrGHKexns9HfQBDb1y+5KQwxcR
         od9qant3UB8Xui+dHU1Qg7P9vMdMjNEEo0kVJL+7P6fQHpmuPqEDnw+YGsseLFfLI4by
         yuROwB2wTThtoqmIVA3djXdCL8gTqcKtu3E3ttX7qxPsMcE77aQRh0h1rhEBSP8ydBWd
         xwntPLIdYzZfhdi2JH37lHApuKpzafb6+L8MHQiy04iYe43EP0F6pu7Bp7Jzugvc+ufZ
         h/PEbk1UujMyHYXUFe2Nvpz+yOufhXKbQwE3Pq+luTxSww2tlSEV00DOdWjtEwE2Hvcj
         ONkg==
X-Gm-Message-State: APt69E2Oy+Kbgo0X5fGhpA+mI0AEWEopsx9taVDvMc6h4IWjxVlRH5kK
        hb36fNXtGWRQsXJR8D5uem5qWsBre8Gv6Ki8Ci0=
X-Google-Smtp-Source: ADUXVKJYTsW11b0099ww5vIeAoj4DWfzOz8+i3SdjvQ6C16Hz1CXk3Mj0UghpsjcqNfQC4ukpcI+eBOyQc+J/j0dTjg=
X-Received: by 2002:a9d:2c94:: with SMTP id p20-v6mr1637710otb.14.1528392486357;
 Thu, 07 Jun 2018 10:28:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:2082:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 10:27:35 -0700 (PDT)
In-Reply-To: <20180607140338.32440-5-dstolee@microsoft.com>
References: <20180607140338.32440-1-dstolee@microsoft.com> <20180607140338.32440-5-dstolee@microsoft.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 7 Jun 2018 19:27:35 +0200
Message-ID: <CACsJy8DwNeYQUdJPnD694v3cEanq00f=zWz_bx53syJ47=ekyQ@mail.gmail.com>
Subject: Re: [PATCH 04/23] midx: add 'write' subcommand and basic wiring
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Martin Fick <mfick@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 7, 2018 at 4:03 PM, Derrick Stolee <stolee@gmail.com> wrote:
> diff --git a/builtin/midx.c b/builtin/midx.c
> index 59ea92178f..dc0a5acd3f 100644
> --- a/builtin/midx.c
> +++ b/builtin/midx.c
> @@ -3,9 +3,10 @@
>  #include "config.h"
>  #include "git-compat-util.h"
>  #include "parse-options.h"
> +#include "midx.h"
>
>  static char const * const builtin_midx_usage[] ={
> -       N_("git midx [--object-dir <dir>]"),
> +       N_("git midx [--object-dir <dir>] [write]"),
>         NULL
>  };
>
> @@ -34,5 +35,11 @@ int cmd_midx(int argc, const char **argv, const char *prefix)
>         if (!opts.object_dir)
>                 opts.object_dir = get_object_directory();
>
> +       if (argc == 0)
> +               return 0;

Isn't it better to die here when no verb is given? I don't see any
good use case for running a no-op "git midx" without verbs. It's more
likely a mistake (e.g. "git midx $foo" where foo happens to be empty)

> +
> +       if (!strcmp(argv[0], "write"))
> +               return write_midx_file(opts.object_dir);
> +
>         return 0;
>  }
> diff --git a/midx.c b/midx.c
> new file mode 100644
> index 0000000000..616af66b13
> --- /dev/null
> +++ b/midx.c
> @@ -0,0 +1,9 @@
> +#include "git-compat-util.h"
> +#include "cache.h"

Only one of the two is needed

> +#include "dir.h"

Not needed yet. It's better to include it in the patch that actually needs it.

> +#include "midx.h"
> +
> +int write_midx_file(const char *object_dir)
> +{
> +       return 0;
> +}
> diff --git a/midx.h b/midx.h
> new file mode 100644
> index 0000000000..3a63673952
> --- /dev/null
> +++ b/midx.h
> @@ -0,0 +1,4 @@
> +#include "cache.h"
> +#include "packfile.h"

These includes are not needed, at least not now. And please protect
the header file with #ifndef __MINDX_H__ .. #endif.

> +
> +int write_midx_file(const char *object_dir);
> diff --git a/t/t5319-midx.sh b/t/t5319-midx.sh
> new file mode 100755
> index 0000000000..a590137af7
> --- /dev/null
> +++ b/t/t5319-midx.sh
> @@ -0,0 +1,10 @@
> +#!/bin/sh
> +
> +test_description='multi-pack-indexes'
> +. ./test-lib.sh
> +
> +test_expect_success 'write midx with no pakcs' '

no packs


> +       git midx --object-dir=. write
> +'
> +
> +test_done
> --
> 2.18.0.rc1
>



-- 
Duy
