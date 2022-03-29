Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F31C433F5
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 08:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234343AbiC2JAf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 05:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbiC2JAc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 05:00:32 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4139B1C9B4B
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 01:58:47 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id r13so33664678ejd.5
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 01:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ehEM6B+mQ2Q0BdQgXfgc0Xp8pwALaP2fc1MKqbANRaA=;
        b=KiPg+rx0MudfYWrZ/ArtgWs4fw5qdLC+LSkjAok7s516+ifSn3emfG2DO3mCnehIaM
         3UwDRQkbMbAmck6mK5X5nyMZoV8nHSeJxuJrhftb2W9xgi5C5oOr+ANfnnY+ZsylZtvM
         WHCP8hDaaUZ6RatyLatrbOHNcnV2C0+oKuZJmUmejKTpAqC02h83cwnImiNtZwcOZgm1
         pXWEUU05oeTgJstB4K90GMHQPpoOVUGRNVNK1YiS+4QN+zw3kKP2HX89TWGCARqzu6RJ
         mWCvY2jeHaElfB+LIwwI6OjUpvsTYMMLMS7R8AZabzaDDOxCIjwiMaiC6E8d0hxrIwPG
         5xNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ehEM6B+mQ2Q0BdQgXfgc0Xp8pwALaP2fc1MKqbANRaA=;
        b=22ck8rzrVQkbHQWW/VJJqTpX/Mn4nSrfWQkh9/jChtu5ojILUcpXXC4BRNH468J70e
         M0yUJXLsyxKkVdoyLyz85meNuAOV7W4OuzTXsnNEhEMwoINf4xI+bpWprs5TBy5GsPKE
         Cqki2crfmKAZMIakaIp+WYgQY3oD/1MLeqtvwizWAVFwd1eFQO5AlxX/jakD3AYVHWbW
         fLSmZJJiD5HL4h+LD3SJtE7JAMymBDNXwkTUT+/uHc4/j592e9WyZ2XUUdPAX3V0q7X6
         2UWD2H30cmTgFv+Gz19LO3FgPJGao0YF7s8VzFOetKPd3sXMUkKdx635bGuCfw5oVFNh
         70zg==
X-Gm-Message-State: AOAM532Nw/cTIcHkKlYzzaNq63WTw3HTqTRQtiWQkVyw69WakpBS5Byx
        APPp7NC9WaKtos91zknfXhQ=
X-Google-Smtp-Source: ABdhPJxlzG32kzFm/0UFtuaQL2cfHwVAhf5e3Q+ke9CK6S+cggIkuRzXoOklSEvMT8nhKwlJ2aRV1w==
X-Received: by 2002:a17:907:d02:b0:6e0:4f1d:7ab1 with SMTP id gn2-20020a1709070d0200b006e04f1d7ab1mr32462287ejc.716.1648544325559;
        Tue, 29 Mar 2022 01:58:45 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bx5-20020a0564020b4500b00418fca53406sm8085534edb.27.2022.03.29.01.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 01:58:44 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nZ7ga-003WOP-As;
        Tue, 29 Mar 2022 10:58:44 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     derrickstolee@github.com, git@vger.kernel.org, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: Teng Long
Date:   Tue, 29 Mar 2022 10:54:25 +0200
References: <220324.867d8jo45p.gmgdl@evledraar.gmail.com>
 <20220329073851.80702-1-dyroneteng@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.11
In-reply-to: <20220329073851.80702-1-dyroneteng@gmail.com>
Message-ID: <220329.86pmm52kzf.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 29 2022, Teng Long wrote:

>> Was there an on-list v0 (RFC?) or is this a range-diff against nothing?
>> Best not to include it until a v2 then.
>
> My careless, there's no RFC, actually this patch should begin with v0 and
> without range-diff.

No worries.

>> Sometimes it's better to split up patches, but I think these 3x should
>> really be squashed together. We make incremental progress to nowhere in
>> 1/3 and 2/3, and it all comes together in 3/3. The 1-2/3 are trivial
>> enough that we can squash them in.
>
> Sure.
>
>>	+	trace2_data_string("midx", r, "core.multipackIndex",
>>	+						   r->settings.core_multi_pack_index ? "true" : "false");
>>
>> Weird indentation here.
>
> Will fix.

*Nod*

>> I.e. surely you just want to create a region, and if you care enough to
>> log failure shouldn't we log that in open_midx_bitmap_1() if we care,
>
> Actually, I just want to use "trace2_data_string()" at first because which informations I
> want to append is not so many, or does "create a region" a preferred principle for using
> TRACE2 APIs?

I think a begin/end region gives you everything you want here and more, i.e.:

 * We'll get start/end times on this (potentially expensive?) operation
   automatically.

 * You just log a "failed", but as the RFC-on-top shows we can just log
   the specific reason instead, either via error(), warning() or perhaps
   even trace2_data_string(). because it's within a region it'll be
   clear from the data what failed.

B.t.w. I noticed after sending that that this ad-hoc patch fails the
tests, it passed the one bitmap test I hacked it up against.

It was just there to make the point/demo that it looked easier to do
this one function call above where you were adding this.

>> and perhaps error() there instead of silently returning -1?
>
> I think so, after I checked function "error_builtin()" and there is a "trace2_cmd_error_va()"
> usage in it which is already support to print some debug infos using TRACE2 envs.

Exactly.
