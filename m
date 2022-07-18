Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6F4C433EF
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 19:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234653AbiGRTKZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 15:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbiGRTKY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 15:10:24 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000B92DA8F
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 12:10:23 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id fy29so21933293ejc.12
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 12:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=iEErxfbHvMlZ9E90qU/YhTt8rrzASLF/lrOpmBepTPM=;
        b=BHNS9f1bz6S4W6bBg/XJhkOLzNs6VhfnBKcWD91Sjnn2x25mnAllNSmeBhuUx9HmGf
         zUdITENJrecRSYXCiDwV1uCX7tmYILAuRBvf9FjHjQXjpWhXpce/a2H6zGiGl69PoPJt
         xkjO0iK8lCO/YT4I77drts0HP/+xVFMvENNAqwq6WeOVtL7YeI/eCk2ztTpj4K+0MZhE
         XGgOq4op+MHmHcA9+HGe5HMpOwUtK2dfUw9sIiss3JVgjGerzm6lFBPP8YXvt6xmv9Ne
         LFv/jsmPaR/3p+mM3885vFqPh/EILaFLxGxGaiSz0e7iQq4JepEgJzYL25yWV3OpHZlP
         QNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=iEErxfbHvMlZ9E90qU/YhTt8rrzASLF/lrOpmBepTPM=;
        b=yvPnCZEAeARDvTV5tsmYZ+p0NCXGdFI2Dm1PPv33BqdmsuKMgyPL5eHrGD4y7upDoG
         GXvprY/aWCz5ms9tC7JR3MTU7giFx+nU59tZx19V5w3Y2jSi9vAGznwFc/EPNdZDXhTx
         lVqRoN6SObfsNI8+h77HweQdIODinfyviZypZz5zZ7vwE9yjEo2m++rGTEOTJD2gqIE5
         i7vP7fJaefkLre7ayalLB0HA5kix40kj6dHA+QFZis4QkVPtkz2cy/PBR4QtmeuQImco
         vHpSrPed+aHIDttKF9tRk9tRExwsUI8rLndYTlW3B70xzEuvONDjaoibk+AKfAGwBA89
         bFLA==
X-Gm-Message-State: AJIora9ZEbiz9AuPmH/DpuJv7drQNJ3jJoQZaLjwTf/Ofsym85Uj85lO
        4qbCYb1T+HAKGL66zcqnlVQ=
X-Google-Smtp-Source: AGRyM1uMhkfB6XQ+wRff1ot2XLg5ecPANJrZwHTiqseER/KXZzQ7A2guqhD81RH3ZbwZ5HI/NmnISw==
X-Received: by 2002:a17:906:9c84:b0:6e0:7c75:6f01 with SMTP id fj4-20020a1709069c8400b006e07c756f01mr27459746ejc.103.1658171422460;
        Mon, 18 Jul 2022 12:10:22 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id j22-20020a170906051600b0072b36cbcdaasm5750757eja.92.2022.07.18.12.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 12:10:21 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oDW8K-003Kn4-PB;
        Mon, 18 Jul 2022 21:10:20 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Teng Long <dyroneteng@gmail.com>, derrickstolee@github.com,
        git@jeffhostetler.com, git@vger.kernel.org, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v7 0/7] trace2: dump scope when print "interesting" config
Date:   Mon, 18 Jul 2022 21:07:30 +0200
References: <cover.1657540174.git.dyroneteng@gmail.com>
 <cover.1658159745.git.dyroneteng@gmail.com> <xmqqa696fdva.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqa696fdva.fsf@gitster.g>
Message-ID: <220718.86edyiw82r.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 18 2022, Junio C Hamano wrote:

> Teng Long <dyroneteng@gmail.com> writes:
>
>> Changes since v6:
>>
>> 1. [1/7] Fixed the mistitled commit mesage.
>>
>>    [PATCH v6 1/7] "clean: fixed issues related to text output format"
>>
>>    to:
>>
>>    [PATCH v7 1/7] "pack-bitmap.c: fix formatting of error messages"
>>
>> 2. [4/7] replace "warning()" to "warning_errno()" and rewrite commit message.
>>
>> 3. [5/7] fix the logic error, move "error_errno()" before close(fd) to
>>    avoid errno lost.
>>
>> 4. [7/7] update Documentation/technical/api-trace2.txt here too.
>>
>> Thanks.
>>
>> Teng Long (7):
>>   pack-bitmap.c: fix formatting of error messages
>>   pack-bitmap.c: mark more strings for translations
>>   pack-bitmap.c: rename "idx_name" to "bitmap_name"
>>   pack-bitmap.c: do not ignore error when opening a bitmap file
>>   pack-bitmap.c: using error() instead of silently returning -1
>>   pack-bitmap.c: continue looping when first MIDX bitmap is found
>>   tr2: dump names if config exist in multiple scopes
>
> This has been "cooking" on the list for quite some time and I found
> that all parts that I had comments on earlier iterations are now in
> good shape.
>
> Fellow reviewers, how does this round look?  The only gripe I have
> is that the last one seems totally disconnected from the rest, but
> That's minor.

Yeah likewise, it even applies directly on master. But I can live with
it :)

One minor nit is that something like this (which needs to be fleshened
up) should be fixed up into 7/7 (and maybe we want to keep the "..."?):

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index 49bb1ca1924..ce544982a37 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -716,7 +716,7 @@ The "exec_id" field is a command-unique id and is only useful if the
 ------------
 {
 	"event":"def_param",
-	...
+	"scope": ...
 	"param":"core.abbrev",
 	"value":"7"
 }

And that the addition to api-trace2.txt seems to partially be something
that should just link to Documentation/config/trace2.txt, i.e. it's
generally documenting an existing facility.

I think it would be great in any case to have that 7/7 split into what
we do now & docs for that, and then the minor addition of "scope".

The rest all looks good to me, and seems to fully address the feedback
in previous rounds.
