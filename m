Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94AF31F403
	for <e@80x24.org>; Tue, 12 Jun 2018 15:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754361AbeFLPAn (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 11:00:43 -0400
Received: from mail-oi0-f47.google.com ([209.85.218.47]:32923 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754056AbeFLPAm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 11:00:42 -0400
Received: by mail-oi0-f47.google.com with SMTP id c6-v6so20261531oiy.0
        for <git@vger.kernel.org>; Tue, 12 Jun 2018 08:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=39PLkt5XtmRKF52dWe1B5nD+FnsrbiijzFT1/49uNVY=;
        b=hrAXHKvyRPsh2pVuAG3Qts3aAF62JlZRXZA+KVRbtcqbGX2JYYURXhra1ymSWhuPld
         3i9Da/bHVO3syc7KcpxaMVI0MSyiJCBlAQOoNn06/33SQU3O561CVJKV8ytVnFF5BR72
         sEtXKRCzl081EBs1P5B5pwI5Vv7KmMin2/iB0rdCTBSauZsgHnRVI+s3ME3vlIFPIWvH
         wqKJPPTSu5E5d9CcNgHeklQKQOuMrKvHR5ZblHY4X9ZcFnjQBRrsbm6lpc/IPm68Ekpm
         v6oC42PYggXGlu9yvLBytx1+2Kb2TwgcqghdaTG2s/BDgiuJ9ZdXzWtoC8LefKSTtJVJ
         NvIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=39PLkt5XtmRKF52dWe1B5nD+FnsrbiijzFT1/49uNVY=;
        b=sXlmc9jixgYtKCYaG9DNIKXiLW1OgQCu2NywZp+jjvi42WA+INap+xuxncFVZjh25z
         Y5Ts2IpY5ccMtdC8kACRZAGYICNKEiXO49mVobjzJtGSSc8rKiguyxowmxrSr7ZBPvcK
         nG7YFnVrJTYcG8kdHHhC5SbeRG8xT6pmlohMiEifQ+BiERC8q3yWQ1vkEk3nw1irslu6
         lh7UQ09sDTJ/8HBTLDEdEVqAFOXhT6k551dPGK9S4b8BLry6n3BznZJmxV6MbBP/2B+Y
         7T4CNKSxavwFtOsOT5S2FLXOsg+KXf+7BLIr9ObSx3Ugumkz+xXnP+a9aEfnrXH+dpFN
         brgQ==
X-Gm-Message-State: APt69E3MrSglKk1EFiCkhoxXFz/YfbzQBBBwO2Ixkmk9+Fm1o5t/eURO
        462ErjkreZ2ZpYyp1BjnLwtbdmkl63EFsWEJQ+Q=
X-Google-Smtp-Source: ADUXVKI3ZkvcjLxk6eTSdJBou57KdhAZLgY///pH7HiSjJ+XbQiMoyv/Xnwb3xtsgDCzPY+BGNjPunwKTSByEuxjBPU=
X-Received: by 2002:aca:aa54:: with SMTP id t81-v6mr2262682oie.30.1528815641984;
 Tue, 12 Jun 2018 08:00:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180607140338.32440-1-dstolee@microsoft.com> <20180607140338.32440-6-dstolee@microsoft.com>
In-Reply-To: <20180607140338.32440-6-dstolee@microsoft.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 12 Jun 2018 17:00:14 +0200
Message-ID: <CACsJy8ALMjiyjcEdFPnR7GTzBVpqVB72VQNkpUWrj9p4nm-OGg@mail.gmail.com>
Subject: Re: [PATCH 05/23] midx: write header information to lockfile
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

On Thu, Jun 7, 2018 at 7:01 PM Derrick Stolee <stolee@gmail.com> wrote:
> diff --git a/midx.c b/midx.c
> index 616af66b13..3e55422a21 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -1,9 +1,62 @@
>  #include "git-compat-util.h"
>  #include "cache.h"
>  #include "dir.h"
> +#include "csum-file.h"
> +#include "lockfile.h"
>  #include "midx.h"
>
> +#define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
> +#define MIDX_VERSION 1
> +#define MIDX_HASH_VERSION 1 /* SHA-1 */
...
> +static size_t write_midx_header(struct hashfile *f,
> +                               unsigned char num_chunks,
> +                               uint32_t num_packs)
> +{
> +       char byte_values[4];
> +       hashwrite_be32(f, MIDX_SIGNATURE);
> +       byte_values[0] = MIDX_VERSION;
> +       byte_values[1] = MIDX_HASH_VERSION;

Quoting from "State of NewHash work, future directions, and discussion" [1]

* If you need to serialize an algorithm identifier into your data
  format, use the format_id field of struct git_hash_algo.  It's
  designed specifically for that purpose.

[1] https://public-inbox.org/git/20180612024252.GA141166@aiede.svl.corp.google.com/T/#m5fdd09dcaf31266c45343fb6c0beaaa3e928bc60

> +       byte_values[2] = num_chunks;
> +       byte_values[3] = 0; /* unused */
> +       hashwrite(f, byte_values, sizeof(byte_values));
> +       hashwrite_be32(f, num_packs);
> +
> +       return MIDX_HEADER_SIZE;
> +}
-- 
Duy
