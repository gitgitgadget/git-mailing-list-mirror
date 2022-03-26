Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939EEC433F5
	for <git@archiver.kernel.org>; Sat, 26 Mar 2022 01:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiCZBO5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 21:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiCZBO4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 21:14:56 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2C9CD8
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 18:13:18 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id bg10so18449230ejb.4
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 18:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=f4q7jz6UiV0iWNPgbgDRhG+hENySTf4RWZhJQ+Jmqog=;
        b=GF6bfKGqmhaF5UjT6/bomATPRfGl8LqorakiCbEhZXy5V0TI7iXjlf+e1YfrzFQANN
         MQpT7ChdRIx6+QtC9cyIaIASHVimtmXAMys0cNBG0FAw4HxCKJ92oe1dGaRjL2X77kcG
         UW3wRBKohGsB5EAto3DQwS3nmSML4e9V7AD1kJdJnmO/6XspfUg3wuR5BEp2eZHsQWYU
         ETXlfd25ou2OvusgtTbAjNFvB95Bzys2PYS9ArjjJ55QEO+Iho3t9XL5uFzu+XOLWteK
         YPOTtbSvbJRywUCJ2NAsJi7Xw6VhYioh5W7+nZ10ruDIkoEP6KZYCO0SLUSzVfhJD6yH
         gTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=f4q7jz6UiV0iWNPgbgDRhG+hENySTf4RWZhJQ+Jmqog=;
        b=QJYenCrucAFzhxJ8S4TIfSY8Q4AqZj2nRbT03ZSo+E5YA7htBKqcZJ0XEKaAc1Unfk
         3jUGCOkFhifGd3dSCq+HAwXpe+iJmjvfhzcM5p4VeJjpur0j/JnivduCisrjUWHE734s
         1RoxynKlgeDnxpbDrTBtz19CH76KmEE2gVkNUbASW3FJjQizAOk3OZKDYv9URvqE2J97
         I2LYy1KTF4GlXytW194g1wxnqx43UDI6F/PA+/MN9cWj0RS20df9eaqYU892jI0jkQ+V
         xTkPPA6CRjobTGeIwQZ8gUlnaTiPRYFmAn99fl6uKq/TE+na475CEE/HpJUo8eMLEBzi
         NXTg==
X-Gm-Message-State: AOAM530OUSzo35FDiW76vJMO2P7mF2eWHOSi+dfZ4N2+ySzmuQLyh/5r
        saI5VhHCs/dzF+nfqOdlRQ4=
X-Google-Smtp-Source: ABdhPJwBvTAt5IxsFt8ANqVaFEDxdnywFf0kjBTLh+RCBZBDrDHRT/WQK9+sDiimIY1N0hWtYTNt0Q==
X-Received: by 2002:a17:906:b052:b0:6ce:88a5:e42a with SMTP id bj18-20020a170906b05200b006ce88a5e42amr15155490ejb.237.1648257197019;
        Fri, 25 Mar 2022 18:13:17 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id b7-20020a509f07000000b00418f85deda9sm3402580edf.4.2022.03.25.18.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 18:13:16 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nXuzT-002L12-VP;
        Sat, 26 Mar 2022 02:13:15 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH] pack-objects: lazily set up "struct rev_info", don't leak
Date:   Sat, 26 Mar 2022 02:09:08 +0100
References: <pull.1186.git.1647970119.gitgitgadget@gmail.com>
 <patch-1.1-193534b0f07-20220325T121715Z-avarab@gmail.com>
 <xmqqmthdampa.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.10
In-reply-to: <xmqqmthdampa.fsf@gitster.g>
Message-ID: <220326.86wnghjz2s.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 25 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> In the preceding [1] (pack-objects: move revs out of
>> get_object_list(), 2022-03-22) the "repo_init_revisions()" was moved
>> to cmd_pack_objects() so that it unconditionally took place for all
>> invocations of "git pack-objects".
>>
>> We'd thus start leaking memory, which is easily reproduced in
>> e.g. git.git by feeding e83c5163316 (Initial revision of "git", the
>> information manager from hell, 2005-04-07) to "git pack-objects";
>> ...
>> Narrowly fixing that commit would have been easy, just add call
>> repo_init_revisions() right before get_object_list(), which is
>> effectively what was done before that commit.
>>
>> But an unstated constraint when setting it up early is that it was
>> needed for the subsequent [2] (pack-objects: parse --filter directly
>> into revs.filter, 2022-03-22), i.e. we might have a --filter
>> command-line option, and need to either have the "struct rev_info"
>> setup when we encounter that option, or later.
>>
>> Let's just change the control flow so that we'll instead set up the
>> "struct rev_info" only when we need it. Doing so leads to a bit more
>> verbosity, but it's a lot clearer what we're doing and why.
>
> Is this about "we take it as given that the use of rev_info leaks
> until we fix revisions API, so let's keep its use limited to avoid
> unnecessary leaks"?

Not exactly,. When you use the revisions API to do "filter" stuff in
this codepath it leaks both before & after Derrick's patches, so nothing
has changed in that case, but...

> If so, it sort-of makes sense, but smells like a roundabout way to
> address the issue.  An obvious alternative is to wait until both the
> topic and the "plug revision API" topic graduate and then add a
> "release" call to release the resource in the same sope as the
> unconditional call to init_revisions at the end.  I do not quite get
> what on-demand lazy set-up buys us.  What we need to lazily set-up,
> when we do lazily set-up, needs to be released either way, no?

...We were doing lazy setup of "struct rev_info" before the parent
series, and as a result it introduces a new memory leak. We do a
malloc() for some diff.c code that revisions.c uses unconditionally,
which then don't use at all in some common cases.

The patch I've submitted on top just restores the previous state of the
initialization being lazy, but in a way that has to be adapted for other
code changes the series made.
