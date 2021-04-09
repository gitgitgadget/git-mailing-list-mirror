Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EF6C433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 19:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C34BC61184
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 19:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbhDIT7z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 15:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234457AbhDIT7w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 15:59:52 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FCAC061762
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 12:59:38 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id g5so3794248ejx.0
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 12:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6L6OsDdCpLi1YUj3pH+5aiuEgvc5Pr6JT6Q2+HpFwrg=;
        b=UAkLGkWH22ZY4WwUZODbMOP4WR3FHK4lXntIIouWTN92Gk5wAkRYNuH+kuZXP92u6C
         BK3He9a/8tuCR9OCkLJvEq8pb2EJrpEtSmGIrEscd4fTBSttxT+Rth1qtNXlNL+rOduf
         VYzVtCX0ynZROztRRdlW4pxarKZjLUwycXZ0G+K9SkRhb5AUMbMTWeqcMEU6sS0i57rf
         c3oEwge4ir4uCK982p1wlQFi0SqUygXXRikWYO96yctOl2OQCHAiFbb4tquAxzrcrU1S
         ct4E/2kq1ixQHBT6siuN08evoV4iyYgpUOlIkX7L0k7fcDLUEIkgJHmvuRvUlTbR4QWG
         RPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6L6OsDdCpLi1YUj3pH+5aiuEgvc5Pr6JT6Q2+HpFwrg=;
        b=qmPAG/mEY+TZTVOwBk2R8l8G0omA8fO4DfgSJk7YtpmWN2bjv/pYNxnFBDwJX0Of95
         aGbQefSPd2K67EIO68/0TT2xAlkmcVkaj5+aJEKA0WqSb2FLmhtAECpDj2xxUDxrRtkf
         r+YbAwfJbP3jNg1fvhREeNSc8OgvRmTMTQV/JW+CbqAEDt3aQl+7qA269KuxbNbQUFbi
         mOplab2ZF5K7vEGpk7N4bcgm8JfUXsdbi4L+NZnJOuUw0W9gxts31vcSNBqN3CXx8l6E
         G4hIHEy3eJxV/M/ePlK9gir/X8i9dtH+HCGtF8uKTywaLa4lUI81wNi5wje6LuTAORiJ
         GOsQ==
X-Gm-Message-State: AOAM530W+pzglMdpIMXLkxeKZqNN2qy9HVGYOHhA3plGfY9GeYeA2xFe
        MpVynDwrx//tBQs5sZeKsp8zhJ0ewVnIfpZqeoM=
X-Google-Smtp-Source: ABdhPJzeap9UUOtOBCvzNzQ7Trv+1jodhZEKTRC+78tc7elTl+b5M9qc8fCdzz4URGyz9P3uJ97uVT3P/TeO6qttP1k=
X-Received: by 2002:a17:906:b104:: with SMTP id u4mr17437086ejy.211.1617998377524;
 Fri, 09 Apr 2021 12:59:37 -0700 (PDT)
MIME-Version: 1.0
References: <pull.913.v7.git.1617541912381.gitgitgadget@gmail.com> <pull.913.v8.git.1617975462.gitgitgadget@gmail.com>
In-Reply-To: <pull.913.v8.git.1617975462.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 9 Apr 2021 21:59:26 +0200
Message-ID: <CAP8UFD3kyFe9KdXEu4R1prasnTVAoEW6YOQeA1YDm0k78M3zRQ@mail.gmail.com>
Subject: Re: [PATCH v8 0/2] [GSOC] trailer: add new .cmd config option
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 9, 2021 at 3:37 PM ZheNing Hu via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> In https://lore.kernel.org/git/xmqqv99i4ck2.fsf@gitster.g/ Junio and
> Christian talked about the problem of using strbuf_replace() to replace
> $ARG:
>
>  1. if the user's script has more than one $ARG, only the first one will be
>     replaced, which is incorrected.

Maybe: s/is incorrected/can be puzzling/

>  2. $ARG is textually replaced without shell syntax, which may result a

Not sure what "without shell syntax" means here.

Also: s/may result a/may result in a/

>     broken command when $ARG include some unmatching single quote, very

s/when/if/
s/include/includes/
s/some unmatching/an unmatched/

>     unsafe.
>
> Now pass trailer value as $1 to the trailer command with another
> trailer.<token>.cmd config, to solve these above two problems,

I think the important thing here is to explain that we want to
introduce a new 'trailer.<token>.cmd' config option, so that we can
start deprecating 'trailer.<token>.command' when people have started
using the new 'trailer.<token>.cmd' config option. Maybe something
like:

"To address these issues, let's introduce a new 'trailer.<token>.cmd'
config option that behaves in the same way as
'trailer.<token>.command' except that it passes the trailer value as
$1 to the configured command instead of textually replacing the first
occurence of '$ARG' in it. This will let us slowly deprecate
'trailer.<token>.command' in favor of 'trailer.<token>.cmd' in the
future."

> We are now writing documents that are more readable and correct than before.

I would suggest removing this sentence as I don't think it adds much
to the above.

> ZheNing Hu (2):
>   [GSOC] docs: correct descript of trailer.<token>.command

By the way the following title might be a bit better and shorter:

"[GSOC] docs: improve 'trailer.<token>.command' doc"

>   [GSOC] trailer: add new .cmd config option

Maybe we can afford: s/.cmd/'trailer.<token>.cmd'/

>      -    [GSOC] trailer: add new trailer.<token>.cmd config option
>      +    [GSOC] trailer: add new .cmd config option

Was the previous title too long? Or is there an issue with
GitGitGadget because it contains <token>?
