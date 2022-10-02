Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9D7C433F5
	for <git@archiver.kernel.org>; Sun,  2 Oct 2022 01:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiJBB0M convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 1 Oct 2022 21:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiJBB0D (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Oct 2022 21:26:03 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803D44D4E5
        for <git@vger.kernel.org>; Sat,  1 Oct 2022 18:25:52 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 126so9432183ybw.3
        for <git@vger.kernel.org>; Sat, 01 Oct 2022 18:25:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=suf1vYR33UxL8MmFbvQ/sHHKZ0gFsm1s3WdrKTJy47I=;
        b=UA+k4j+tSaCEcw/HC2ErJF0WkTA8X/E9NR1tlSyS7ZI82hhOveaEUXGJt2OHYZqE2p
         hqGyYb3xg3d5NXglam3xUDeP3hOlCI/HY5W0XJoYhWv8yGEF2aq35p89lNls6yBPq9rQ
         zZOC5vEQyghgG4MXwd6T7wze/Dy33k6dISpHFC8BAu9TZpYs9gwMOsjoP1G/4b0tfinf
         ywuizrEtttA6UiNS09C+L6s4AeLlt03EfgLnLkRxYOJ/rDYFUfSdH9fmLoC+Jdk9JkDe
         aFXbBgfhau+F+hOGzLuGzKqcIKhiEd8s56bTgA0D2/Y8BxrtEoF2W2qdGKzH6MeiFEMi
         byVQ==
X-Gm-Message-State: ACrzQf0c+dZAlz1GmqIMUO3slkdcbws0ClUs2zmZvK1q3w6OrvfSUj7f
        EqQl4K7vOC55Pw6sHUg1UY9qwupYp5UtXZNQpHL0cJ9C3bxNEw==
X-Google-Smtp-Source: AMsMyM7AqQBsi6/s4HgSB0961rwIEplEk3pzWxRE9XVOIvj5skmAjVQpZU/nTxK8fkp/rea2gNJuszz5V5fjsOpaUnU=
X-Received: by 2002:a25:94b:0:b0:68f:4e05:e8f0 with SMTP id
 u11-20020a25094b000000b0068f4e05e8f0mr14934091ybm.115.1664673950926; Sat, 01
 Oct 2022 18:25:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
 <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com> <patch-v3-35.36-22da68abce3-20220930T180415Z-avarab@gmail.com>
In-Reply-To: <patch-v3-35.36-22da68abce3-20220930T180415Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 1 Oct 2022 21:25:40 -0400
Message-ID: <CAPig+cRq_qdg_o9wgWszmagYNi+s=wkczng9+vHz31DiAhKE+A@mail.gmail.com>
Subject: Re: [PATCH v3 35/36] tests: start asserting that *.txt SYNOPSIS
 matches -h output
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>, Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 30, 2022 at 2:10 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> There's been a lot of incremental effort to make the SYNOPSIS output
> in our documentation consistent with the -h output,
> e.g. cbe485298bf (git reflog [expire|delete]: make -h output
> consistent with SYNOPSIS, 2022-03-17) is one recent example, but that
> effort has been an uphill battle due to the lack of regression
> testing.
>
> This adds such regression testing, we can parse out the SYNOPSIS
> output with "sed", and is turns out it's relatively easy to normalize

s/is/it/

> it and the "-h" output to match on another.
>
> Some of the issues that are left:
>
>  * "git show -h", "git whatchanged -h" and "git reflog --oneline -h"
>    all showing "git log" and "git show" usage output. I.e. the
>    "builtin_log_usage" in builtin/log.c doesn't take into account what
>    command we're running.
>
>  * Likewise "git stage -h" shows "git add" usage, but should be aware
>    of what command it's running. The same for "annotate" and "blame".

Is this mention of annotate/blame out of date? Doesn't [28/36] make
these commands emit the correct usage text? Or am I misunderstanding
what this is saying?

>  * Commands which implement subcommands such as like
>    "multi-pack-index", "notes", "remote" etc. having their subcommands
>    in a very different order in the *.txt and *.c. Fixing it would
>    require some verbose diffs, so it's been left alone for onw.

s/onw/now/

>  * Commands such as "format-patch" have a very long argument list in
>    the *.txt, but just "[<options>]" in the *.c.
>
>    What to do about these has been left out of this series, except to
>    the extent that preceding commits changed "[<options>]" (or
>    equivalent) to the list of options in cases where that list of
>    options was tiny, or we clearly meant to exhaustively list the
>    options in both *.txt and *.c.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
