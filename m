Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E010C71155
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 23:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF454221E2
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 23:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgLAXEm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 18:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgLAXEl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 18:04:41 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A60C0613D6
        for <git@vger.kernel.org>; Tue,  1 Dec 2020 15:04:01 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id z7so5522035wrn.3
        for <git@vger.kernel.org>; Tue, 01 Dec 2020 15:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XHgWq2eht2+AtGkeUtZRDtkMEJi0SaeKPJlA6+Jm/YA=;
        b=IoO7FsGoxhhnfhwncWlQLnU11bTNYpKZ5F8x0HrXlVqV3zPH0QO7ix6pj5S9QIW05e
         DIJTL7dyWfk8zwyJKW7TAWegShq3Qvopd1t9rRPRI3gZjMd+/QNkLeMkdNBy//3PSq5A
         FrbjomQy/taOsQxuTPQSplcii9+FVQnTplW/uek9wFrR8tkvEN5uIhmfEczDRMRpALUu
         eR0/O+7FLb6W+n2q1Em8ikjL2rS6LBZLnT+SuaAWenI5m3W8MY31xlRlT7papv1n7uh8
         7CfQoVvTIIAlC7LnSjXA1upkR30eMckzYDKxKCWx5uJPfsAueRHKn/JgFbOTUKxJah9u
         blCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XHgWq2eht2+AtGkeUtZRDtkMEJi0SaeKPJlA6+Jm/YA=;
        b=gOBEqcYeSbZj5c7vfW7LTQhp/8JXRyDw/k37A8GGhHiojPjY25XKKkwpWhVGxumFF2
         V79oEdvBvaZ00LJFuc3DZnnzC8GueVl8v0tpaiPtIHo7edxpxJu0X9AGZaoij7kycIIf
         0hv8pJpPsOyptIgdYpuSlZTiM3MflC9c3o+xKhNQRUQlfnIZcY9PtjdqXBktjzEmjC6r
         Oi2+ZKZjHl1+qn7ywY3KBb5tSfk+rdZT91wUXsLdt583qMmZXmBqEHzCeIrqrPJ9tqMZ
         ZTl4myvBsXyjmVEt4IHbB5NqX7vKAGxG+NfLKDg4aalYRcOUNG+TUsM11LuZKV03r9JQ
         xQWw==
X-Gm-Message-State: AOAM532/4LcNcZf1sQiQxX40xX+5jzleUZmoOWXjwM4lMwj84whQJ3Hh
        h4ZLBgiAu3JOS5/PE/q8A9UlvWsY6F2AOrNHbLw=
X-Google-Smtp-Source: ABdhPJxhDDK8odY7uSjGafJswIMUM27546oQ0vQFfMBU/tpOs2PQuOawLjLMlxXVtUFC1JMEG1kKdWr3adaKe7K+1i4=
X-Received: by 2002:a5d:474f:: with SMTP id o15mr6976886wrs.100.1606863840184;
 Tue, 01 Dec 2020 15:04:00 -0800 (PST)
MIME-Version: 1.0
References: <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com>
 <pull.847.v3.git.git.1606419752.gitgitgadget@gmail.com> <91c3ac2449edc45db643b0ba6cba66ef31176600.1606419752.git.gitgitgadget@gmail.com>
 <87lfennln8.fsf@evledraar.gmail.com> <CAFQ2z_NEkJQM6xtppW9kkAyjFrBeEiXmhhiPB8A7pmssjXHhKg@mail.gmail.com>
 <CAFQ2z_MXF0wO76tVTcBuJJp0CwjVoVfE11BOYYQ7Y7h1h_VwJg@mail.gmail.com>
 <CAMP44s0zoekLZYQ=r516jjdsGGQ2Y7m1fXpwW2BBJsGjQ5sseA@mail.gmail.com>
 <CAFQ2z_PaPdiJC71WGdePFVgxyJFFHZY_DFbmLg9sRFm=vc7XYw@mail.gmail.com>
 <CAMP44s0v92C+uUwoeBJxRv2MPCd2RuCPn8FVBUztNM9VOdjJgA@mail.gmail.com> <87wny1vjg0.fsf@evledraar.gmail.com>
In-Reply-To: <87wny1vjg0.fsf@evledraar.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Tue, 1 Dec 2020 17:03:48 -0600
Message-ID: <CAMP44s1u6KENgb5vfp0s97cDoJD5On3_AN0H8Re5Kn3YgBJAXQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/16] reftable: add LICENSE
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 1, 2020 at 5:45 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:

> Assigning copyright to Google is a way around that. They own your work,
> and then they re-license it under whatever license those two projects
> use.

That's the default. Unless otherwise stated; you retain the copyright
while contributing code to open source projects.

Generally when open source projects want to change license they have
to get the agreement from the majority of copyright holders.

Some projects do ask you to give away your copyright, but I'm not
comfortable with that. If I want to contribute my code with GPLv2,
that's the license I want. If a project I contribute to wants to
switch to GPLv3, then they have to remove my code (or do something
illegal).

So I see nothing wrong with Google owning the copyright and
controlling under which license(s) their code is distributed. In fact,
I would see something wrong with the opposite; them giving away their
copyright.

Cheers.

--=20
Felipe Contreras
