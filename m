Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7720FC433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 01:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiCIBOK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 20:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbiCIBNy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 20:13:54 -0500
Received: from mail-oi1-x249.google.com (mail-oi1-x249.google.com [IPv6:2607:f8b0:4864:20::249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACA913195F
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 17:01:49 -0800 (PST)
Received: by mail-oi1-x249.google.com with SMTP id r4-20020aca4404000000b002d4f32967bdso746259oia.12
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 17:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=XI0MqVfnjGh5oWzNtiZ/pY2y3UOqZJtfxhgNz2lpUBI=;
        b=GLbatThhD0+ow62cnpYEHZ64oBrp+lQC6rtrfGTXARA0rckNFu17arORH7Y+kS+xU/
         EpZdeMRoNXC6aUlcRt01/tWVe06V4df2xFKmWivyKLI8tnmrw/nNGUCJj/PVHc5EkDpX
         xZ6n9CSpgasasODWCFLkb4t5eSolJNjp9eHnTaVMhRsX0mio6wfQlYEbfP1kJ+oRwkc+
         Wj6LqaeujG3XbKvPMBxFcTl6pzzwnGr2/KC4qNpf/Frvsfb25wtcX0tJGA+6tt6P5wVH
         d4JMExZ54OqhX/NYrnvIPoNL2OfeKKH/cHNxLjMK8TaovAfR6USQKUVwcpSwKN8DApgo
         OyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc:content-transfer-encoding;
        bh=XI0MqVfnjGh5oWzNtiZ/pY2y3UOqZJtfxhgNz2lpUBI=;
        b=EpYArmXkjUZoJ8pAG5NWjfktpX3hfukPK1JcUjagMQGK+o32v27FfFiuftLMOyKumV
         AC0pCrkC1ZdFtm4/0n7gDfMk/Xi1Y8Ab1IS16rxaBuGDIPkz/u2oOMjWv3QXiC1yaeco
         zjZRCa6mUOxxaSWW11vaUi+LupZR6WtJJgDB4ybgIccaE9tVOMJJnlQlHQhUxMq5jyCw
         rMgvPoAWBUcve/QF6/ijO+i4i2v6CANZv7JCWYKr388NnSIHEzfzwUOGzVSGahbguJ1y
         h0z/AP1q4E3AnK/QMIqQvHo8Vm2qAQgLkWevA7L4qU3uVvSjCoC6IYDw9p607WeDYN+k
         qFzg==
X-Gm-Message-State: AOAM5336Siefk/qh5+RBF3M0vhHvsmwWoX2WIOUmAOCeZQ7LsAcTMZRW
        +0U2j5bJ2YupRPgGaTgeCWuOK6brDS/6mhQ=
X-Google-Smtp-Source: ABdhPJyfBcH26tGlC5/3O9jpDlmIRKHz6fwDLdNBU74wwt5aMAgb11cq/u8iojlpDZgR/qHDFdxfhXd2qNogtm0=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:90b:1a8b:b0:1bf:89c2:3a0f with SMTP
 id ng11-20020a17090b1a8b00b001bf89c23a0fmr6341000pjb.215.1646785660427; Tue,
 08 Mar 2022 16:27:40 -0800 (PST)
Date:   Wed,  9 Mar 2022 00:27:29 +0000
In-Reply-To: <pull.1138.v3.git.1646406274.gitgitgadget@gmail.com>
Message-Id: <20220309002729.3581315-1-calvinwan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.664.g0785eb7698
Subject: Re: [PATCH v3 0/7] fetch: add repair: full refetch without
 negotiation (was: "refiltering")
From:   Calvin Wan <calvinwan@google.com>
To:     Robert Coup via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "=?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason" 
        <avarab@gmail.com>, Robert Coup <robert@coup.net.nz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert Coup via GitGitGadget" <gitgitgadget@gmail.com> writes:
> If a filter is changed on a partial clone repository, for example from
> blob:none to blob:limit=3D1m, there is currently no straightforward way t=
o
> bulk-refetch the objects that match the new filter for existing local
> commits. This is because the client will report commits as "have" during
> fetch negotiation and any dependent objects won't be included in the
> transferred pack. Another use case is discussed at [1].
>=20
> This patch series introduces a --refetch option to fetch & fetch-pack to
> enable doing a full fetch without performing any commit negotiation with =
the
> remote, as a fresh clone does. It builds upon cbe566a071 ("negotiator/noo=
p:
> add noop fetch negotiator", 2020-08-18).

Hi Robert,

This is my first time sending a review to the list, so forgive me for any
mistakes I make or conventions missed. Feedback about my review would be we=
ll
appreciated!

Overall I think your patch is well written and the implementation accomplis=
hes
what you describe in your cover letter, however, I would like to discuss an=
other
possible design I thought of. Currently, the user has to know to run =E2=80=
=98--refetch=E2=80=99
after changing the partial clone filter configuration in order to fetch the
commits that match the new filter. Ideally I believe this behavior should b=
e
default so therefore instead of adding an option, if git knew what filter w=
as
last used in the fetch, it could automatically =E2=80=98refetch=E2=80=99 ev=
erything if there is
a change between the last used filter and the default filter. I=E2=80=99m n=
ot sure if
the config is the best location to store the last used filter, but we can u=
se it
as an example for now. The tradeoff here is balancing between having an
additional config variable and having the user know to specify a parameter =
to
fetch after changing the config. And in the future, if there are other use =
cases
for needing a fetch that bypasses commit negotiation (I know you described =
one
such possible use case in v2), the =E2=80=98--refetch=E2=80=99 option can e=
asily be readded to
hook into this patch.

Looking forward to hearing your thoughts!
