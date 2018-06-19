Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54F821F403
	for <e@80x24.org>; Tue, 19 Jun 2018 14:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757299AbeFSO7n (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 10:59:43 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:41109 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756803AbeFSO7l (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 10:59:41 -0400
Received: by mail-oi0-f68.google.com with SMTP id a141-v6so18418349oii.8
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 07:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Na5081PGiP6MojlAeQsxiZd/rsCYzDbYPCFUq1DSaC8=;
        b=Izvt+TnQQOpfXNLB4gzskv64EXZQsCiSKQQRYV/s3Rpxc+S+v+CMmFvd1MyS4YmRJQ
         rdbfPYV3oOUvVxMRRfKQqoAodiu3uu8Fb1A02q2aqoLrwDP0PUUiu6j6nOB+Vw8SCiza
         Ru4jTR8GmFR9lObaG+c0uRYDrQ070MQvqlQ0SWJTN1bFQgsvwVK2sAhjf5eHWyM9S/oQ
         /6Gt6J6W9IX7sneXgVa8M535PHVWKC44UM2pyJ6s8tGdVIUEoRbY0HmM3H36OSwAMVgm
         R1m6LtCFGj+zdW07OWsZQMZVuofJAY9EQUhxAhIYa0IOWQAcZG2axzj22OcUTSAOp2d0
         5tYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Na5081PGiP6MojlAeQsxiZd/rsCYzDbYPCFUq1DSaC8=;
        b=NiuPyj5fQh1XIIlvSgPd+7Z0fh8aCBvMuesxBK3Vo4o9DG5pRibTjxdNWxExd8PpQ5
         oWa6Ndn1663uO3C9lBek54WmQEgjgs6CZnnPpObsXmkbAOZyFSIIZed/GN8/oVPUEq2/
         RjXF7b/5ZiHQQiPNbaWx9rZC125gsfKYPiJvYIYdFsX5qaKYW2WqiwiKi9Ey6YaAiUZr
         SkMTIf4JdaC6pqObUDx7oaA6hrGYhVIs7x+CQeLhE2CkhG1AnLVoNmOxWmzEvZfGBmY7
         +0Yh5yJSpfDG40CbKw3lqZ7tx5ewQlzEIb3BFgoTR6wB3FmjpBTvExAC3VVSJaDiL/BJ
         YD0w==
X-Gm-Message-State: APt69E1tD5XyQ28H8oATx7hUAxdZaqrKKibI0qQcQNde0R4ayl7QVc8t
        2qZOTrvOQaSNqqG8zpSHn1GBfXhYvaniTJp1d9I=
X-Google-Smtp-Source: ADUXVKLel1UCoR1+W12ZBgMaXoD5A3K1nxmmn34vMZI0o8WDSHO5/GvFKZiu3K3vfESSwqf3q8l2eFxm7krY69ENtQg=
X-Received: by 2002:aca:f02:: with SMTP id 2-v6mr10073119oip.216.1529420381311;
 Tue, 19 Jun 2018 07:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180607140338.32440-1-dstolee@microsoft.com> <20180607140338.32440-6-dstolee@microsoft.com>
 <CACsJy8ALMjiyjcEdFPnR7GTzBVpqVB72VQNkpUWrj9p4nm-OGg@mail.gmail.com> <fa036efb-2164-ee0a-8cbb-4144487b6617@gmail.com>
In-Reply-To: <fa036efb-2164-ee0a-8cbb-4144487b6617@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 19 Jun 2018 16:59:14 +0200
Message-ID: <CACsJy8B+9WnWJASkd19BSjRdpAECo7Kva8OTC_ZbjiMH4wXi-w@mail.gmail.com>
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

On Tue, Jun 19, 2018 at 2:54 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 6/12/2018 11:00 AM, Duy Nguyen wrote:
> > On Thu, Jun 7, 2018 at 7:01 PM Derrick Stolee <stolee@gmail.com> wrote:
> >> diff --git a/midx.c b/midx.c
> >> index 616af66b13..3e55422a21 100644
> >> --- a/midx.c
> >> +++ b/midx.c
> >> @@ -1,9 +1,62 @@
> >>   #include "git-compat-util.h"
> >>   #include "cache.h"
> >>   #include "dir.h"
> >> +#include "csum-file.h"
> >> +#include "lockfile.h"
> >>   #include "midx.h"
> >>
> >> +#define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
> >> +#define MIDX_VERSION 1
> >> +#define MIDX_HASH_VERSION 1 /* SHA-1 */
> > ...
> >> +static size_t write_midx_header(struct hashfile *f,
> >> +                               unsigned char num_chunks,
> >> +                               uint32_t num_packs)
> >> +{
> >> +       char byte_values[4];
> >> +       hashwrite_be32(f, MIDX_SIGNATURE);
> >> +       byte_values[0] = MIDX_VERSION;
> >> +       byte_values[1] = MIDX_HASH_VERSION;
> > Quoting from "State of NewHash work, future directions, and discussion" [1]
> >
> > * If you need to serialize an algorithm identifier into your data
> >    format, use the format_id field of struct git_hash_algo.  It's
> >    designed specifically for that purpose.
> >
> > [1] https://public-inbox.org/git/20180612024252.GA141166@aiede.svl.corp.google.com/T/#m5fdd09dcaf31266c45343fb6c0beaaa3e928bc60
>
> Thanks! I'll also use the_hash_algo->rawsz to infer the length of the
> hash function.

BTW, since you're the author of commit-graph.c and may notice it has
the same problem. Don't touch that code. Brian already has some WIP
changes [1]. We just make sure new code does not add extra work for
him. I expect he'll send all those patches out soon.

[1] https://github.com/bk2204/git/commit/3f9031e06cfb21534eb7dfff7b54e7598ac1149f

-- 
Duy
