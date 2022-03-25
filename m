Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A79CC433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 09:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355167AbiCYJSD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 05:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356924AbiCYJSC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 05:18:02 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86DBCF48C
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 02:16:28 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id p15so14081790ejc.7
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 02:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=TEoz7tYxv5ddKCoo4ezmzOpa6UKSdkzLiPOK2UhT68g=;
        b=OuAhzSbSVily4BULSUqsrv5YHAJOPdxC3QjUuZkqdLmE/Bh7gQlZBwobzmc1bOjEqS
         N0W8pUmPvQ8chsqyRtG571NJ2F8mCOJIqJJQ2QcFKadyltpkaxr3xnPjozwuPq0AEtES
         MOu1r9eOtP8/CDkrYD9Zi5+IIL1x+sCbAyPW3Wd2ZGR7tyJM1Mti2F2cP/t7YpDcY8v8
         h6vIZxW+NckLmDZxcrLzyBDHfkpvST3riWadGt9Mz0w5T9WUcsEfmAy6E0RL6BMd9k3K
         pOw2KelHmky8yvpW79rsSG5FDsUtMkUjBQeAebfLJqubC+QhCr0OU+yroyZv2IAgyy90
         mmUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=TEoz7tYxv5ddKCoo4ezmzOpa6UKSdkzLiPOK2UhT68g=;
        b=VPVANy3zXBx8YvYCHa9QVAJUNOp1J05xVak6gU8DyGSGuvEqbYCNZAr0v9xDAUiTRb
         Iuu3gyvl1AIx2MZOCaa2meKA0ZIz2ZSYa85QZRSVNWXsC5spH0w7X4oumQAE1MTMi9Nv
         Vipz7fwzSluDlu6NIIRrOE7GMCgLH05KosFdILjJrui4ptFNxL5bcthyABnVbR76iOTa
         gvGps/tUWqBcYZlo6i4iyupYK7kfGzyA5fb9S3NIEbSU+L5U02sVAuWAIbpPYGic9ziv
         PtmyJ9FaYMwKo+A0gAtOnwTPG3MKzi57faEkxkFnUuP87Uu+Dog/l2ZK2H6JZGvSfgW7
         kipQ==
X-Gm-Message-State: AOAM530CB9fg+1A7OsAU6msdaCaZRcQm5957/hGvlme8C+1Wyfx0bs75
        vE4Ycfmv0T8JTamm92pkiOo=
X-Google-Smtp-Source: ABdhPJyvlKfzqXA8BFUma/ssmwOUKwWnoAsaVEDojlW8vLpUIdtOhXhA8Q9EP3ie+P1u8/kZwlX//w==
X-Received: by 2002:a17:907:7f8a:b0:6e0:c59:f387 with SMTP id qk10-20020a1709077f8a00b006e00c59f387mr6681464ejc.732.1648199787394;
        Fri, 25 Mar 2022 02:16:27 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id m21-20020a17090677d500b006df766974basm2184385ejn.3.2022.03.25.02.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 02:16:26 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nXg3W-001rIF-80;
        Fri, 25 Mar 2022 10:16:26 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 00/27] revision.[ch]: add and use release_revisions()
Date:   Fri, 25 Mar 2022 10:14:13 +0100
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
 <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
 <xmqqa6dedd1g.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.10
In-reply-to: <xmqqa6dedd1g.fsf@gitster.g>
Message-ID: <220325.86zglel7di.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 24 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> This is a re-roll of the v1 of [1] now that 7391ecd338e (Merge branch
>> 'ds/partial-bundles', 2022-03-21) has landed, which it had a conflict
>> with. I believe this v2 addresses all the feedback brought up on v1.
>
> Thanks.  It was mostly a pleasant read but with a huge caveat---I
> have no confidence in the code that would not try to release what it
> did not allocate (simply because I do not have time to audit all
> allocations to various members of rev-info structure).  But at least
> if we try to free something we borrowed from say command line, we'd
> immediately get a crash so with enough cooking and guinea-pig testing,
> such a bug would be easy to catch.

Yes, especially with SANITIZE=3Daddress and friends.

> I suspect cmd_show() still is leaky when fed a few commits.
> [...]
> There are ways to show different types of objects, but what we are
> interested in is what happens to commits.
>
>                     case OBJ_COMMIT:
>                             rev.pending.nr =3D rev.pending.alloc =3D 0;
>                             rev.pending.objects =3D NULL;

Yes, FWIW I know about that one, and will add some passing mention of it
to a commit message.

There's still a bunch of leaks related to the revisions.c code after
this series, which doesn't address all of them.

But since it's already getting up to ~30 patches I wanted to address the
most common ones, this and various other tricky edge cases have been
left for a follow-up.
