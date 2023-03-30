Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C418C761A6
	for <git@archiver.kernel.org>; Thu, 30 Mar 2023 18:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjC3SIb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Mar 2023 14:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbjC3SI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2023 14:08:29 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5BAEB45
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 11:08:25 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id kw3-20020a170902f90300b001a274ccf620so2940491plb.8
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 11:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680199705;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4uZ3xgam2kPUqv0m3jinN9axL8bF+G3Rnyh7wMCDWfk=;
        b=NDOM7+kIMAhKmQvj4FhmYAvA/FzChoHSGqZNjfF7clj+PevfwBbNXBIPAOCasYJdXu
         /NOkl9SGYXvL5wzgvjpEDvLvor7slZLN4i/2D8ErO3JbtJcK30IMmk2XL2zN6y13S7Cd
         UjlcIeBCgovzIImXEI6l8zKFimlFWbQPqBOeL+bJ0T/faWs66+utEF765qeKQgbWavpK
         YGv3pJ9OtvY5jzd0dtLkon6yN7InEVs8zUmlZ6okG+Owj62PbEmGzTTcLSL3grMu1ZFQ
         SdbyPN4ryGrs7wZc2dbg1ODJXcSaPJMOIBwcHHpotujXy4zaMqJ57dSdHWRp1YiBdASk
         ULPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680199705;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4uZ3xgam2kPUqv0m3jinN9axL8bF+G3Rnyh7wMCDWfk=;
        b=hmUi7XoAnK6yjmBeUvtRIIfFRl9h9zx4JKlB0PsixQDuTdENAwwVBxGsAzrRY2iG7K
         t01ZcL8+P3nNMfh++kUrI6g0G5vF+kCNioJSMarHdjwJlc9FLSMxPmDiGTHhL0+o8+ZS
         b1NK/H5mbc9TCDbvvczGwkM5SxDxaCJtzdrLrCcITtur4EUgxExzcN9tApiWqQWNFeZd
         DBXmhSFRDMmJz3cSgXcyCRyqiN1ZsD6bJ4cIzDP6Jd+AXT+PVloOrBPUg8GaiDSIpjqU
         cwWDcTZi7slEJ487/2cGrIBdGJ5J++xrozWW52hbx3ARkdvj8U5I0Xzj2+Z9tm91a402
         5WOg==
X-Gm-Message-State: AAQBX9dph+S3KuE6ZCyhiA3Je7qO/HcAIlpHLD/v2tnXojwKYQj8achI
        perxeqyup0kjmilqWiP6NHS8WSIAMBgX9w==
X-Google-Smtp-Source: AKy350Y5fPGnCZmmY0zTr8QKSgWUgk+qaR0VTrpfi38H+NPl6No9YHS/FkdTXPegMOTURhgoWWpIjqdcGF3TWg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a63:1f22:0:b0:50f:5f89:2a9d with SMTP id
 f34-20020a631f22000000b0050f5f892a9dmr6941046pgf.1.1680199705313; Thu, 30 Mar
 2023 11:08:25 -0700 (PDT)
Date:   Thu, 30 Mar 2023 11:08:23 -0700
In-Reply-To: <xmqq355n9y9m.fsf@gitster.g>
Mime-Version: 1.0
References: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com>
 <cover-v2-00.17-00000000000-20230328T110946Z-avarab@gmail.com> <xmqq355n9y9m.fsf@gitster.g>
Message-ID: <kl6la5zucdt4.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 00/17] cocci: remove "the_repository" wrapper macros
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>     +    Once we've fully applied "the_repository.pending.cocci" we'll k=
eep
>>     +    this rules around for a while in "the_repository.cocci", to hel=
p any
>>     +    outstanding topics and out-of-tree code to resolve textual or s=
emantic
>>     +    conflicts with these changes, but eventually we'll remove the
>>     +    "the_repository.cocci" as a follow-up.
>>     +
>>     +    So even if some of these functions are subsequently moved and/o=
r split
>>     +    into other or new headers there's no risk of this becoming stal=
e, if
>>     +    and when that happens the we should be removing these rules any=
way.
>>     +
>>          Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@g=
mail.com>
>
> Are people happy with the result?  I think the previous round was
> both read carefully on the central piece of the series, with some
> spot checks to mechanical parts, and with the above clarification
> the series is ready to be merged down to 'next'.

Likewise, I'm also happy to see this merged to 'next'.

My comments on v1 were sanity-checking how we use coccinelle in this
series, not any actual objection :)
