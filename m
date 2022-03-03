Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4596CC433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 22:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236854AbiCCWZI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 17:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbiCCWZH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 17:25:07 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98E010C52F
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 14:24:20 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id y1-20020a17090a644100b001bc901aba0dso2957049pjm.8
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 14:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=Wu0hemQASFYkkNlTQPYrFrrMvoRnzLJ5paYsnGrjA+U=;
        b=ZZaKFAmDQuBpb2SlNK/XFTZXJn17OOugqNWyGoQ0Q0eF8T64ddb9v9GE6tlj82sjHM
         7AjiF+m3BdRU4AH3dZyRz1THJXuPtEYJC2EuFXgRUXSf9xWyhYU63GIxsglEBqAfrIRF
         2LbyrO2jRhb/BOag0STbD9SMBCCPQfmq1XzearrRGmj0l4SKVhbbKy0N6+7GljxWXG2R
         4NGFkxxsXzLEb9M6CsLKD+x4R+0dKEfgtw010hMdK9YXtaHvPj8dbaUsmDJP9C25TmW7
         J2ChNmwfn8TIG7Q1VriOdh373zrQQKXyhisQhYtzckfz5LKAIrszdFILh0keQG+QQmBR
         0YeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=Wu0hemQASFYkkNlTQPYrFrrMvoRnzLJ5paYsnGrjA+U=;
        b=PVvdQW/yLY0JnRDFfFQhfP4e5oIA1sHCi6GoKdxD8X2ErZtV5CGWh+0fLWqKctEWit
         FG5XmRGP+y/E2NYQjKf9f3VnuEctb8KxDKTpGQ+jpeUlsh87KNGguWvpExoy01UpiGMO
         rTtLxmAn6qxyiLfsolf8qr0l4oLtEFoL89iRy2t3W4E2n5jX5Co5WcxINsBCo6UQHqGI
         4G3gXVRj6MSCiPKCeGIhda8gFIkM4Nxh6mYeszVQQwDRKjVKyoCGUjWy5ASxRqciGMHJ
         fJGTi/IlsjlA+Lx2uw4TU/BsTjlxD/BEJRcxLuIFtjy2UsioOk310S1LivytgnoIKrxQ
         wWcA==
X-Gm-Message-State: AOAM533JZXKUxNrV6nydxf3kn3AMX2xMCFCbaEdXicZt+EEHoxAU1lIU
        o3e1GaQiwzE9MB5QA/c4QLp63oq8qziMDQ==
X-Google-Smtp-Source: ABdhPJyal03+1j9zF0zLZ4uISa7YOWbp2bYadYpvHd/aEtmrseFiqE5/Zt6DmUht/I4Ulcqoi4CpJE+YB5TciA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:d882:b0:14f:efee:6de0 with SMTP
 id b2-20020a170902d88200b0014fefee6de0mr39559990plz.116.1646346260306; Thu,
 03 Mar 2022 14:24:20 -0800 (PST)
Date:   Thu, 03 Mar 2022 14:24:11 -0800
In-Reply-To: <220303.868rtr42mg.gmgdl@evledraar.gmail.com>
Message-Id: <kl6l4k4ek73o.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <CAPMMpoiTJAuadBEOPWOVa-kguSXMDvAhvD22B63QwYpu=H7xEw@mail.gmail.com>
 <220303.868rtr42mg.gmgdl@evledraar.gmail.com>
Subject: Re: What does it mean to have multiple upstream tracking branches?
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Tao Klerks <tao@klerks.biz>
Cc:     git <git@vger.kernel.org>, Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Thu, Mar 03 2022, Tao Klerks wrote:
>
>>  Hi,
>>
>> In my recent attempt to create a "simple" branch.autosetupmerge
>> option, I have repeatedly been confused by the enforced rules around
>> what is and isn't valid for the branch.<name>.merge and
>> branch.<name>.remote configs.
>>
>> Until Josh Steadman's recent work on --track=3Dinherit, the "automatic"
>> addition of branch.<name>.merge could only ever result in a single
>> entry.
>>
>> Now we support multiple entries being added as a perpetuation of an
>> existing branch's setup - but what does it *mean*? I could understand
>> if the idea was to have transparent tracking across multiple remotes
>> that are supposed to have the same content (eg a single server set up
>> over multiple protocols), but that does not appear to be possible -
>> branch.<name>.remote can only have one value.
>>
>> Is there any documentation (or could someone provide pointers) as to
>> when multiple branch.<name>.merge values can make sense and what that
>> means / what it does?
>
> Can you point out some existing tests where we end up with multiple
> *.merge values? I looked a bit and couldn't find any.
>
> Or maybe it's only possible to get into that state with some command we
> have a test blind spot for?

Based on the discussion on that thread you mentioned, I don't think we
have any such tests. I think the only way to get into this state is to
manually modify the config.

The only docs I could find on 'multiple values' are from
Documentation/config/branch.txt:

  branch.<name>.merge::
    [...]
    Specify multiple values to get an octopus merge.

So I'd imagine a use case would be something like:

- I'm preparing a feature on the branch 'topic'
- It will get merged into 'origin/master'
- The feature also depends on 'origin/other-topic'

I'd have entries like:

branch.topic.remote =3D origin
branch.topic.merge =3D master
branch.topic.merge =3D other-topic

That way, if either 'origin/master' or 'origin/other-topic' changes, I
can pull updates into 'topic' with "git pull".

Not that I would ever _recommend_ someone to work like this though.
Junio also wondered whether anyone uses this [1].

[1] https://lore.kernel.org/git/xmqqbl2hw10h.fsf@gitster.g
