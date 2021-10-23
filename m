Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024CDC433F5
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 20:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0D6C60F6F
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 20:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbhJWU6a (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Oct 2021 16:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbhJWU62 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Oct 2021 16:58:28 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE5CC061714
        for <git@vger.kernel.org>; Sat, 23 Oct 2021 13:56:09 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id r4so701852edi.5
        for <git@vger.kernel.org>; Sat, 23 Oct 2021 13:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=bsnrTX4/6q9J+qdot5ezY8IGOK+nWclOtJ6t3rt1l9k=;
        b=JTuMDq7ZjdyKyhbtrEPuH4sab6y1OTEN/0iwNno/ySs8qSeSg6G8lpygfJUvsPyyM9
         OCE07WyTyDRnm6hJZx0BFDazlUFGYvu5csSa0syjv3YJppw4POa70VYtlD98xVdC9uXo
         /cwxc0t5G1CtvJwcwEse3WGGDQyTyWm/W5q9UygLjPu4qiXWvG3EKLfmACY1XNexWNP0
         LBD2xqIR1L+Bnds4ffXgsOH7h/83iy+VgqSJQnVVXRoFI96bzfQ06O5/bcgVkYQyKRpu
         xufL7H3AWgLQVWLt7TnNYH3mzJV50/Ph6MDQ893iysagLpcGXcZRu5eOdwFqa0zympRT
         LPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=bsnrTX4/6q9J+qdot5ezY8IGOK+nWclOtJ6t3rt1l9k=;
        b=5GMI9BBfeiICWWsPpZsLsxWbFGTMffxngZaf6HZvPc2ASJyV4yUMRcMBMA56/lnkEz
         5TmODVFNmTZ3KLEjVutj8FEjx4baAQEmKmGsT37qRWPeaSx497BN+ne7ayZJcoVX3BQW
         LOyQ/na1paDEtaz8QbAQ0RuFF1UC139qwq9vC07Lzu3AWLXsTGDjTJsCxos9S/O0Rdcm
         dBbs0TUMYbK6vIsLcmQaMZpFmhdIHpJcCLASz97LAHGA5SLKbrXHYqKBRTiJ5L9hWg75
         hwVBTGSHpcGANjIrGuSP8fzVl4OSxWS9/l43Yb8TJr34RdMik2goWZnr2Ar+X/FnQyc/
         b2nA==
X-Gm-Message-State: AOAM5310CMRvuo1f3BFtku6WBGVlIWRnC0vpF+WIlwlvPWEh2ZN4Iy1q
        1A3dc2QkLUw9mguJIskeSTsEU+7hjQA=
X-Google-Smtp-Source: ABdhPJxXnvbYeXSSi8FtUxwDDWp+M01Zit1Y/t2iTymDjJiTGoyenFWJEbK2BzUE1k8nDZ9quF+Cog==
X-Received: by 2002:aa7:da14:: with SMTP id r20mr12086932eds.183.1635022567780;
        Sat, 23 Oct 2021 13:56:07 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id g21sm429060ejt.87.2021.10.23.13.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 13:56:07 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1meO3i-001ScW-RT;
        Sat, 23 Oct 2021 22:56:06 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org
Subject: Re: [Summit topic] Server-side merge/rebase: needs and wants?
Date:   Sat, 23 Oct 2021 22:52:27 +0200
References: <nycvar.QRO.7.76.6.2110211147490.56@tvgsbejvaqbjf.bet>
 <bdf47d51-9cf6-046d-fd97-aa35299daadd@gmail.com>
 <nycvar.QRO.7.76.6.2110221155460.62@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <nycvar.QRO.7.76.6.2110221155460.62@tvgsbejvaqbjf.bet>
Message-ID: <211023.86fssrihp5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 22 2021, Johannes Schindelin wrote:

> Hi Bagas,
>
> On Fri, 22 Oct 2021, Bagas Sanjaya wrote:
>
>> On 21/10/21 18.56, Johannes Schindelin wrote:
>> >   5.  The challenge is not necessarily the technical challenges, but t=
he UX
>> >   for
>> >       server tools that live =E2=80=9Cabove=E2=80=9D the git executabl=
e.
>> >
>> >       1. What kind of output is needed? Machine-readable error message=
s?
>> >
>> >       2. What Git objects must be created: a tree? A commit?
>> >
>> >       3. How to handle, report, and store conflicts? Index is not typi=
cally
>> >          available on the server.
>>
>> 1) I prefer human-readable (i.e. l10n-able) output, because the output
>> messages for server-side merge/rebase are user-facing.
>
> For server-side usage, a human-readable output _by Git_ would not make
> sense. It would be the responsibility of the server-side caller (which is
> usually a web application) to present the result, potentially translated,
> definitely prettified.
>
> So while I agree with you that the result should be made pretty on the
> server side, I disagree that this is Git's job. Instead, Git should
> produce something eminently machine-parseable in this context.

Our server-side already produces human-readable output via die()
messages or ERR packets.

To the extent that we need human-readable output in say protocol v2 I
think it makes more sense to start supporting passing over the user's
locale to look the appropriate thing up in our *.mo files. The
alternative is maintaining an exhaustive catalog of unique error ID's or
whatever.

Most things should of course have meaningful error codes etc., I'm only
referring to the output that has some human readable "we've failed, and
here's a text explanation for why" component, see the various places in
protocol v0..2 where we emit that, e.g. telling a user what went wrong
with the "filter" arguments they provided etc.
