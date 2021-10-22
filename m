Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EC7C433F5
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 14:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3102960EBD
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 14:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbhJVOi0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 10:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbhJVOiZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 10:38:25 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86E0C061764
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 07:36:07 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id e19so3926204edy.0
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 07:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=4FDzM+AhFxi9v1B4TTcG41TiNLStAMBydQNqz7hJDcI=;
        b=VT+ycyyJL0NyFpM2bn43BhMEO7AvDhxwnqKlxt5yf6c+GBl/zwdsFho2W+ggltoFZv
         wr2MSZaIuo99WRRwXCAb9xbhOcS5oOoklKNeqNcDFuCoC4fC5BgK97WHkVdS7gSu8XRq
         uq0Qub7FFYECR7wFpaxtYOXod+s30njtoYYNAqEtmD5SO6D996hqlfWeElWGxJn3ez79
         y+PvGVWjzkBCOmsIn6gG5bvdjLmQpmAIfC36fNLqKLGAcfWTYwH+LktiUhlHl+K5ajym
         woxvuP2RWNrbsOvCxv4Pi9a6R2+xlQszMsSHmV/YNSIFwcSUBI268Gy3ureZV3OetCq+
         RDBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=4FDzM+AhFxi9v1B4TTcG41TiNLStAMBydQNqz7hJDcI=;
        b=ETf/wMnJfxfPiDdkVUeXHRn4HyBJ/jGnCJz43CRlFnglZkYC8C/9HVAeqiuewwHV29
         3SO/CEQvQFMAznjldEdmkJjAt/+9EKATHwJw01pwfAZplwjssmNongBVlL6gFx00Izzk
         J+H0wIcaOBGlQIwTRCHSshfkPqKgmQ6c02Czb4cCS3H3vIOZ+sQCvHE1y/8NUx89ZlIE
         0IKo1kB1975r5gXjpdBnFFfmqoiplkIiD9cOzvEeqEdm1zwir4fau6DXzUAsZ/Ovv90y
         I0TXjA7L9Adkxj3SmGZ1t7H1g8TD1VM7eFP+MPqwRicVqiIol7EXb00pDu4rI2X2G+18
         Qs4w==
X-Gm-Message-State: AOAM53248Uc2JVudHmvzuPyEbH6vpfzJhkdqWZxxOXHHxZRnbrkEEWx1
        g0PtoH/9noSNJXMf9DbyM2vDgA77jChtDQ==
X-Google-Smtp-Source: ABdhPJwQs37jnrI/MQeZQG7BspcJHLer6AH/EJx5WBp1d1fD6d+C7zIoxLtwT3EWMDJoS6pj7B/jlQ==
X-Received: by 2002:a17:906:c205:: with SMTP id d5mr15387255ejz.528.1634913366159;
        Fri, 22 Oct 2021 07:36:06 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id r26sm3960562ejd.85.2021.10.22.07.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 07:36:05 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mdveP-001FOV-FI;
        Fri, 22 Oct 2021 16:36:05 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Cc:     git <git@vger.kernel.org>
Subject: Re: [Summit topic] Documentation (translations, FAQ updates, new
 user-focused, general improvements, etc.)
Date:   Fri, 22 Oct 2021 16:31:46 +0200
References: <nycvar.QRO.7.76.6.2110211149000.56@tvgsbejvaqbjf.bet>
 <1c9adc5d-21ac-f6c6-8a87-959be5420636@free.fr>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <1c9adc5d-21ac-f6c6-8a87-959be5420636@free.fr>
Message-ID: <211022.86r1cdjfe2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 22 2021, Jean-No=C3=ABl Avila wrote:

> I'm sorry that my presence at this meeting could have helped a bit for
> some subtopics.
>
> Le 21/10/2021 =C3=A0 13:56, Johannes Schindelin a =C3=A9crit=C2=A0:
>> This session was led by brian m. carlson. Supporting cast: Jeff "Peff"
>> King, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason, Taylor Blau, Philip Oakley=
, Emily Shaffer,
>> CB Bailey, and Jonathan "jrnieder" Nieder.
>>
>> Notes:
>>
>>  1. Background: answering on StackOverflow, other avenues for user quest=
ions,
>>     even users from very large companies
>>
>>  2. How can we improve documentation?
>>
>>  3. Maybe even think about translating docs such as FAQs
>>
>>  4. Peff: there=E2=80=99s an effort to translate manpages
>>
>>     1. brian: Saw an announcement, haven=E2=80=99t seen what came of it
>
> The effort is still ongoing. Unfortunately, there aren't much outputs
> from it, only the inclusion on git-scm.com.
>
> A proposition was sent for Debian packages.
>
> I'm open for any help in packaging what's already available for whatever
> useful.
>
>
> For some statistics
>
> * there are 23 po files, "pt_BR" fully translated, "fr" half translated,
> "de" one third; most other languages have not really started (the
> portion already translated was made automatically for unmodified strings).
>
> * not all pages are included for translation; most porcelain pages
> available on git-scm.com are included, but for instance, not the config
> parts or the guides. That's already 10,687 source segments and 206,700
> source words, which is a volume similar to "Crime and Punishment" by
> Dostoyevsky. And it really looks like an punishment for most apprentice
> translators willing to start.
>
> In order to lower the barrier to translators, the project is relying on
> weblate: https://hosted.weblate.org/projects/git-manpages/translations/
> while still retaining a "Developer's Certificate of Origin".
>
>
>>
>>     2. Peff: Some translated pages are live on git-scm.com (a github rep=
o with
>>        translations)
>
> For instance, git init manpages is already available in 8 languages.
>
>
>>
>>     3. =C3=86var: It uses a third-party tool (po4a) that uses gettext by=
 making each
>>        paragraph a translated string. So it=E2=80=99s the same workflow =
as translating
>>        code changes
>
> Asciidoc support is "co-developed" in po4a in parallel with the
> translation: I fix bugs when they are found in the po files.
>
>>     4. Taylor: https://github.com/jnavila/git-manpages-l10n
>
>
> If it looks too personal, it can be moved into the git organization.
>
>
>>
>>  5. Philip Oakley: I see manpages used as reference material instead of
>>     educational documents
>>
>>
>>     12. In stackoverflow you can see how people answer questions, how mu=
ch less
>>         existing background they assume
>
> Version control is usually already in the culture of most users
> (writers, engineers in other fields have come to use them some 10 years
> ago). What their questions usually boil down to is: how can I use and
> customize git features for my field of expertise. When software editors
> include git support in their applications, it is usually with severed
> functions and users quickly have to get back to plain git when they want
> a little more.
>
> General rules can help start up with a new customization, but at some
> point, the customization is specific to the tool. A library of
> application oriented customizations, help files and FAQs may be of
> interest. Some customizations already exist, sometimes with errors
> (meaning the maintainer of the customization has not fully understood
> how git works) but they are scattered.

I'd very much support this living in-tree just as the po/* directory
already does. I.e. periodically pulled down.

There are many OS's that have something like "apt install
manpages-<lang>", so if we had these available they could be much more
useful to users.

E.g. I see I can "apt install manpages-pt", but if you're a Portuguese
speaker you probably won't chase down some third-party addition of
Portuguese manpages, and even if they're in Debian other package
maintainers might not add them if they're not in the "main" package etc.

What's standing in the way of us treating this in the same way as the
po/* directory, if anything?
