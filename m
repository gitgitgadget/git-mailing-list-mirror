Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3931211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 14:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbeLFO6H (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 09:58:07 -0500
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:43108 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbeLFO6G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 09:58:06 -0500
Received: from [192.168.2.240] ([92.22.32.73])
        by smtp.talktalk.net with SMTP
        id Uv6JgfRF2AGVrUv6Jgr3V6; Thu, 06 Dec 2018 14:58:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1544108284;
        bh=ru/3GKMHnwnXDVximI/QrQ0gKn4F2JwiTMPHKEbCvoo=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=C3gNm3aQK0KssojaeZn7bWRpDXIWyVjRoY4PzfK66e49KjWZIRTWHAaWjWmC5NT4N
         2PEujz7JNNLmtetoGYOZ3h5lsTR2/RAwfxU8NzEpU9ae2UfNb39GmjNIhU1IMkYEtx
         wIfPZoM0FdxYoygbLcFCFxbt2QeDhl55SGQMPLOY=
X-Originating-IP: [92.22.32.73]
X-Spam: 0
X-OAuthority: v=2.3 cv=DtN4Bl3+ c=1 sm=1 tr=0 a=w3K0eKD2tyZHkEydg3BQCA==:117
 a=w3K0eKD2tyZHkEydg3BQCA==:17 a=IkcTkHD0fZMA:10 a=bdLQFzdxE6_yRmYOcToA:9
 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: A case where diff.colorMoved=plain is more sensible than
 diff.colorMoved=zebra & others
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
References: <87zhtiyd45.fsf@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <b23422fa-8a1d-e508-a008-a2fe27b7b49f@talktalk.net>
Date:   Thu, 6 Dec 2018 14:58:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <87zhtiyd45.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfCSIf59rFp8+jRWP7xFItrA4sf0D3QV8dAW4KFX934rq0rL+3mF+RfcMjDMfJJy+rDl5zV1T1jo+FOCJ0hQGh3RfJt7aSSm0sca4SbonhkKrKyJAqNxg
 sozLA/v6q1lfKABNQFw9eRMQWASl9U5jQIY6/T9kPcHjolAWIq5zyvpdLmVyLZgw4gafaAajFxLnkVSzAsQdE2eheM90qEp6vzs+5ashgySPqB4dEfXJW0HJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 06/12/2018 13:54, Ævar Arnfjörð Bjarmason wrote:
> Let's ignore how bad this patch is for git.git, and just focus on how
> diff.colorMoved treats it:
> 
>      diff --git a/builtin/add.c b/builtin/add.c
>      index f65c172299..d1155322ef 100644
>      --- a/builtin/add.c
>      +++ b/builtin/add.c
>      @@ -6,5 +6,3 @@
>       #include "cache.h"
>      -#include "config.h"
>       #include "builtin.h"
>      -#include "lockfile.h"
>       #include "dir.h"
>      diff --git a/builtin/am.c b/builtin/am.c
>      index 8f27f3375b..eded15aa8a 100644
>      --- a/builtin/am.c
>      +++ b/builtin/am.c
>      @@ -6,3 +6,2 @@
>       #include "cache.h"
>      -#include "config.h"
>       #include "builtin.h"
>      diff --git a/builtin/blame.c b/builtin/blame.c
>      index 06a7163ffe..44a754f190 100644
>      --- a/builtin/blame.c
>      +++ b/builtin/blame.c
>      @@ -8,3 +8,2 @@
>       #include "cache.h"
>      -#include "config.h"
>       #include "color.h"
>      diff --git a/cache.h b/cache.h
>      index ca36b44ee0..ea8d60b94a 100644
>      --- a/cache.h
>      +++ b/cache.h
>      @@ -4,2 +4,4 @@
>       #include "git-compat-util.h"
>      +#include "config.h"
>      +#include "new.h"
>       #include "strbuf.h"
> 
> This is a common thing that's useful to have highlighted, e.g. we move
> includes of config.h to some common file, so I want to se all the
> deleted config.h lines as moved into the cache.h line, and then the
> "lockfile.h" I removed while I was at it plain remove, and the new
> "new.h" plain added.
> 
> Exactly that is what you get with diff.colorMoved=plain, but the default
> of diff.colorMoved=zebra gets confused by this and highlights no moves
> at all, same or "blocks" and "dimmed-zebra".
> 
> So at first I thought this had something to do with the many->one
> detection, but it seems to be simpler, we just don't detect a move of
> 1-line with anything but plain, e.g. this works as expected in all modes
> and detects the many->one:
> 
>      diff --git a/builtin/add.c b/builtin/add.c
>      index f65c172299..f4fda75890 100644
>      --- a/builtin/add.c
>      +++ b/builtin/add.c
>      @@ -5,4 +5,2 @@
>        */
>      -#include "cache.h"
>      -#include "config.h"
>       #include "builtin.h"
>      diff --git a/builtin/branch.c b/builtin/branch.c
>      index 0c55f7f065..52e39924d3 100644
>      --- a/builtin/branch.c
>      +++ b/builtin/branch.c
>      @@ -7,4 +7,2 @@
> 
>      -#include "cache.h"
>      -#include "config.h"
>       #include "color.h"
>      diff --git a/cache.h b/cache.h
>      index ca36b44ee0..d4146dbf8a 100644
>      --- a/cache.h
>      +++ b/cache.h
>      @@ -3,2 +3,4 @@
> 
>      +#include "cache.h"
>      +#include "config.h"
>       #include "git-compat-util.h"
> 
> So is there some "must be at least two consecutive lines" condition for
> not-plain, or is something else going on here?

To be considered a block has to have 20 alphanumeric characters - see 
commit f0b8fb6e59 ("diff: define block by number of alphanumeric chars", 
2017-08-15). This stops things like random '}' lines being marked as 
moved on their own. It might be better to use some kind of frequency 
information (a bit like python's difflib junk parameter) instead so that 
(fairly) unique short lines also get marked properly.

Best Wishes

Phillip
