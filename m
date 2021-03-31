Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749F3C43461
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 17:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40E4E60FEA
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 17:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234704AbhCaRw4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 13:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234623AbhCaRwf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 13:52:35 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F73C061574
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 10:52:34 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id j20-20020a4ad6d40000b02901b66fe8acd6so4804989oot.7
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 10:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=C9BWj6tzRGR/ihBgoNr16lqUny8gZl7gxSHhVryO+LU=;
        b=iheA0tr2RcRJ20Y2b7DmYcqCft6/yPRgd17DL/TIihcPVg24k44KkcoSlciB0rFNG0
         y30zaE9CVNo/7p0emTXOcn2KhQpuiwYIQYtqcbcvhKX/i+VNXgoZizwkGHTdKFkARVXs
         WWQySJCr/iXlNfM37alVg/g8wmGVWdpieEg0AO4uwxxdhgcHoy5uaJUZKvEZzFJ4H2Ky
         bjYjYXAm1jyOyvRD2eXyDyDGZLWSqAJrd8Zb3Ix4LC+Cfs6NmZljGxSnfOHllDDig2Cu
         3set8qjLxVdDBnt9P7QXStCC1/0f+S5lfI1DwsBOS551uSSH/o0iB42mF61tvcHASDzu
         NnWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=C9BWj6tzRGR/ihBgoNr16lqUny8gZl7gxSHhVryO+LU=;
        b=ktUmDe78Lpygd5QdwuaQG6aXQA3QKUcpvnfzEwehiitFkZlqEydQWoPgWc13tqVkJx
         DCboh/nNV9Rv2L4hUt2LWmmI9ZCpUkAqfs/isLOGGbw5hXF0lMnNGCXx99iVibOFpO2F
         x69OVPjFNa+TzZQbi9/D31O+OuAhaaodba7r8iVIQ4D0wCL5mdsE7ecOgn2qYTtRlQEy
         v1gYv0fsyHkb+Geb16p8AMjsNLGFEx4kWfpyVrFPfpV8O++7M3Z+8zztpNGIZ1xYzg0/
         StQbAarZd88agobWlLW0UJ11IsK88Jg0ikp7ddHO55RYz3YDWjrSjJiekkJ+4JbgW9a7
         LQlg==
X-Gm-Message-State: AOAM531T3LbEAaZJoqofHQ+C+CCPEt0i/b78NWfWUfRKJLA6asiaPZa/
        wZXiJH6M/36kaFJ3HNuEPQIbb2SjbLCIFpJfdP0=
X-Google-Smtp-Source: ABdhPJzlXFtfcaxaNB11xcqZBuyuafgMvXLu8lYvUdDd7zUxvDKgO9BQWuWZAWpgQFmW/QHfmCyw2PifQEv3gdEpcEM=
X-Received: by 2002:a4a:9101:: with SMTP id k1mr3581615oog.7.1617213153862;
 Wed, 31 Mar 2021 10:52:33 -0700 (PDT)
MIME-Version: 1.0
References: <pull.988.git.git.1616742969145.gitgitgadget@gmail.com>
 <pull.988.v2.git.git.1617070174458.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2103301200020.52@tvgsbejvaqbjf.bet> <xmqq7dloeawf.fsf@gitster.g>
 <CABPp-BErXWkEOCyZtYP9AHd9eP2osL4s1xjMZ_BRkGSktdFnKg@mail.gmail.com> <87mtujkyxb.fsf@evledraar.gmail.com>
In-Reply-To: <87mtujkyxb.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 31 Mar 2021 10:52:22 -0700
Message-ID: <CABPp-BGXW4=8Qb6w22mNCd8fuMs93Kztzavgdu7E--YkjMgmvQ@mail.gmail.com>
Subject: Re: [PATCH v2] sequencer: fix edit handling for cherry-pick and
 revert messages
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 31, 2021 at 10:36 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Tue, Mar 30 2021, Elijah Newren wrote:
>
> > In particular, for merge-ort, I think the second point is very
> > helpful.  What can achieve the "remove these now-unnecessary checks
> > from the code for production, but keep them there for future
> > development"?  I thought assert() was created exactly for this
> > purpose.  Would you rather I created an affirm() that does essentially
> > the same thing and is compiled out unless DEVELOPER=3D1?  That would
> > allow us to declare all assert() calls in the code as buggy, but I'm
> > not sure affirm() is as readily understood by developers reading the
> > code as "ooh, a reminder I get to assume these statements are true
> > while I'm reading the rest of the code".
>
> I don't mind the asserts, or to have them in the default build.
>
> But if you'd like to submit patches for asserts and can't otherwise get
> them accepted, then can we please not make DEVELOPER a thing that you
> can't turn on in production without thinking twice? Per my
> https://lore.kernel.org/git/87wnusj6gt.fsf@evledraar.gmail.com/

Fair enough; if we have to go the affirm() route, I should probably
just make it depend on NDEBUG.  :-)
