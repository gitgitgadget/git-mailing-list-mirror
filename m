Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3871EC43334
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 12:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236392AbiF0MlL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 08:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236174AbiF0MlJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 08:41:09 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17ACB4BD
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 05:41:08 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id q6so18806536eji.13
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 05:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=nkTlnUNoBg15I+zcQPDkOrGgkVyIEJYi61Ge5Vsxdp4=;
        b=KUfA8u1E16r/sixGV0WuOhfpJD+4XBiRhMmamwfA2SNZs5YmNKCHlyt/qwu4P9ecR8
         RwBLLM23KCKJ5h0pAWUJzvh9U0o0gHmAsinoOhGKuhROD6DeVLarDbIWkgh7V3LhOEhJ
         3bsCa3CIdvWjfiGoZTeZdHtK/58xu8D/76nT397QmI/nPfA+A7hwGd8MHOAPdaa4FH0U
         u7TM4rktcFpkcf51cluk8km6P9xivhFqDtiiU5q5PV8YYA5KFXhOZILQCfqq6F/udFvW
         T4XHdp7YxIuAvF0WHhA6MMyYI/lgqBNeL5BAf2e1di6TAyLwy9aF5effr4LlkCppuzgy
         UBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=nkTlnUNoBg15I+zcQPDkOrGgkVyIEJYi61Ge5Vsxdp4=;
        b=k2+YavPKEmic6nsjh/x69uVsXDOMm9fN2qYlJg+k9Yu0GWAcmxyrvEhKx4jkprqcVU
         1hIOEeeePty8JUrkWF8QbEx1bx4yCqgRtFkpT6Wyht2N2acwq6DbBd1DZAH3sRerOh0U
         zDseYU9VsfinoDQyeeW1u2lRosIR9ncLgyod342IzwIfxfaPNWOoaxN+trToc2/X1e+w
         huIjkybJg4H+1JB0/MiO0aQQ0XGPuB2cPRpNPRSWA+o8Vo4AARmHtdiluKrAW0dWJC+9
         XY5qosg/7x4Vv0YWEwNGJyQiNZpTq8lbXHxdbZbKLVO9efTjLEuvFy5Zc4xX4xzBmGRk
         8Bfw==
X-Gm-Message-State: AJIora+EDiaK1y7TE1ZEy9IA+lgXI/ClghlPNqnU6LssL8O0+CZ1RaBD
        /iasdY1fu3Q93IxYYyMmJVdxRyK92Eg=
X-Google-Smtp-Source: AGRyM1stw8L0JOEcA8/abOZf2HUM+h6sYLSenH9ifRfqAzuR2AjTb4CH0DHW0aqjFis7vpS4gb8udA==
X-Received: by 2002:a17:907:6294:b0:6e1:ea4:74a3 with SMTP id nd20-20020a170907629400b006e10ea474a3mr12858486ejc.168.1656333667337;
        Mon, 27 Jun 2022 05:41:07 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id bl24-20020a170906c25800b00704757b1debsm4963785ejb.9.2022.06.27.05.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 05:41:06 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o5o38-001VbX-0O;
        Mon, 27 Jun 2022 14:41:06 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: ab/test-without-templates
Date:   Mon, 27 Jun 2022 14:29:50 +0200
References: <xmqq7d584hqb.fsf@gitster.g>
 <220623.86sfnvk5rw.gmgdl@evledraar.gmail.com> <xmqqr13fxc5l.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqr13fxc5l.fsf@gitster.g>
Message-ID: <220627.864k06i8im.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 23 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Wed, Jun 22 2022, Junio C Hamano wrote:
>>
>>> * ab/test-without-templates (2022-06-06) 7 commits
>>>  - tests: don't assume a .git/info for .git/info/sparse-checkout
>>>  - tests: don't assume a .git/info for .git/info/exclude
>>>  - tests: don't assume a .git/info for .git/info/refs
>>>  - tests: don't assume a .git/info for .git/info/attributes
>>>  - tests: don't assume a .git/info for .git/info/grafts
>>>  - tests: don't depend on template-created .git/branches
>>>  - t0008: don't rely on default ".git/info/exclude"
>>>
>>>  Tweak tests so that they still work when the "git init" template
>>>  did not create .git/info directory.
>>>
>>>  Will merge to 'next'?
>>>  source: <cover-v2-0.7-00000000000-20220603T110506Z-avarab@gmail.com>
>>
>> Presumably the submitters vote doesn't count for much, but FWIW I think
>> it's ready & that there's nothing outstanding left to address.
>
> I do not think they make any particular test to break, but I do not
> think it is a good idea overall to give a false impression to the
> users that it is OK to use incomplete templates that lack things
> expected by Git in properly initialized repositories.  And these
> patches definitely take things in that wrong direction.

In the CL I mentioned some "future goals" goals that you may or may not
agree with, to elaborate on [1]:

 - Eventually running the whole test suite without "git init" creating
   repositories with templates.

 - Running without the bin-wrappers, which as mentions allows us to run
   faster, and improves our test coverage (it's hard to test some
   aspects of invoking "git", when really we're invoking a shellscript
   that invokes git).

 - Having some config option or other handy way to "git init" without
   templates (just formalizing the existing "--template=3D" invocation).

You may disagree with some or all of those, but this series doesn't try
to get you to agree with any of them. It's just making our tests more
sturdy and explicit in their intent by clearly declaring which parts of
them are relying on our default templates.

So it's helping us spot issues like the one fixed in 7f44842ac19
(sparse-checkout: create leading directory, 2022-01-21) earlier.

I really don't disagree with you per-se about us defining some minimum
viable template, and declaring that pointing --template=3D* to an empty
directory is unsupported.

But I think it's unarguable that the status quo is leaving our users in
limbo on that question. Neither git-init(1) nor gitrepository-layout(5)
etc. cover that question.

Now, I think based on unsubmitted patches I've wrote that just handling
those cases in code is easier. I.e. it's a small matter of adding a
"mkdir x/y" before we create "x/y", and almost all of that code is code
we have already, so we're mostly supporting the "empty dir" template
model.

But I'm not trying to argue for that here, nor is this series. What this
series does is make it easier to avoid bugs and unexpected behavior in
that are, whatever your position on the "minmum viable template"
question is.

1. https://lore.kernel.org/git/cover-v2-0.7-00000000000-20220603T110506Z-av=
arab@gmail.com/
