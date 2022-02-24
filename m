Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE40C433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 09:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbiBXJXB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 04:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbiBXJWu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 04:22:50 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87AB20D516
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 01:22:16 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id p9so2957507ejd.6
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 01:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=/vRtuhAhwa9pOEGL2ptt+4eQZqVNurcJAfQg7RCYPSU=;
        b=LRanEklI4/BcG4JSLhOjUUyQzyJkcD1cbVr/8sDpoydh8vZAOztUdI2h6iVdPNRhBZ
         Dz3SWz22clmkzx6PMv9W6UJlOu2Ddu65g+YjQUbEDh4txz56sAnjGAH7gRBt0AqBqn/E
         ryWA93X22XN3onXsbjPqm9Z/fyYfRKcQ8OA6cE0LqfUlHXFAAh8dvtAdMNzj8exY9unw
         JG1HRairKw0Bso1oBPuUWavJeb77U5a2CLFysoupWgm9wu6xekMlkrxM29JbzWQu0Fpm
         YC8H49F+xdRyyCfRoctB3TwvNi5oMIF2sPXi0SRB8amAMMLjlZ1Zj+ZKWKD46u+UkAEU
         ingg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=/vRtuhAhwa9pOEGL2ptt+4eQZqVNurcJAfQg7RCYPSU=;
        b=f9/KdPWoW8rm2eHFKAS1ykVxzr0K+xfUVK2GedN4hmG/wUsdXcmNWtkze6NrI4NPJh
         /IPSb56tlTVWlcRK/E9q0zN/CzE4V5BJXwYb4N3deViCxfmmV3zay62NCQT8hvJy8Kee
         z2VwD+rXWISuk+FSfJHTA5zcZt64B1EY/0afn5CZgnGNSwEAAKQsXdchhef85JEABz1d
         yGQBD4mOwSqDkDTxsN9Neh5oeCb1a3bjHBmkfSaEtGQmgOOjMVj4a1NH0WE4UvIqCJV4
         WZOMVAe5jQQt4pO4iERQzhnXvswVZmnnPmuy2KMON/vf0gVRaZ5ks5sVyPenPOz72yv6
         EwdA==
X-Gm-Message-State: AOAM531Op64zT9unrlNqyRY7SlTXs6lGBapl47GhwVAt+paeXc9gf/xo
        KDn40fz030+AnapuvI98noY=
X-Google-Smtp-Source: ABdhPJwKyUpQbx0ml+nFYsV5CzzcDeQ+6QjOM36ZeWtLr7kUpG5Stg9G4IWfpSvaoeGQAKoUIwmuBQ==
X-Received: by 2002:a17:906:26d8:b0:6d2:515:9bdb with SMTP id u24-20020a17090626d800b006d205159bdbmr1474263ejc.261.1645694535080;
        Thu, 24 Feb 2022 01:22:15 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id x14sm1026587edd.63.2022.02.24.01.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 01:22:14 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nNAKE-000DWG-11;
        Thu, 24 Feb 2022 10:22:14 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>
Subject: ab/object-file-api-updates (was: What's cooking in git.git (Feb
 2022, #06; Wed, 23))
Date:   Thu, 24 Feb 2022 10:18:43 +0100
References: <xmqq1qztortk.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqq1qztortk.fsf@gitster.g>
Message-ID: <220224.867d9kaabe.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 23 2022, Junio C Hamano wrote:

> * ab/object-file-api-updates (2022-02-04) 11 commits
>  - object-file API: pass an enum to read_object_with_reference()
>  - object-file.c: add a literal version of write_object_file_prepare()
>  - object-file API: have hash_object_file() take "enum object_type"
>  - object API: rename hash_object_file_literally() to write_*()
>  - object-file API: split up and simplify check_object_signature()
>  - object API: make check_object_signature() oideq()-like, move docs
>  - object API: correct "buf" v.s. "map" mismatch in *.c and *.h
>  - object-file API: have write_object_file() take "enum object_type"
>  - object-file API: add a format_object_header() function
>  - object-file API: return "void", not "int" from hash_object_file()
>  - object-file.c: split up declaration of unrelated variables
>
>  Object-file API shuffling.
>  source: <cover-v2-00.11-00000000000-20220204T135005Z-avarab@gmail.com>

There's an outstanding v3 of this that hasn't been picked up & addresses
earlier feedback of yours[1].

I think with that v3 this should be ready to advance.

Jiang Xin had feedback in [2] about avoiding some casts by having the
added functions take a "void *" insted of a "char *", which as I replied
to I think we'd like to not do, and is consistent with how we tend to
handle those casting issues in existing code.

1. https://lore.kernel.org/git/cover-v3-00.12-00000000000-20220204T234435Z-avarab@gmail.com/
2. https://lore.kernel.org/git/20220217045943.30223-1-worldhello.net@gmail.com/
