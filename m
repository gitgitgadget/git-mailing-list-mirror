Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36511C433E0
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 22:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6CDF23AA1
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 22:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbhAVWbS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 17:31:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729322AbhAVW3e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 17:29:34 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20E2C06174A
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 14:28:53 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id c2so8041378edr.11
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 14:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=hBDv23lTTPV+k7kdFyfHVtRxjPHVvsOA1B1gMYBRxWQ=;
        b=l6FpmG7RLlIVTc7/EHgXbi24K80A5jwKaTfteOu6IBTBRkhw622I+wmlHynyXV/pip
         Ji2fgWv0d0arHJMukQwLQhCdRuZL03tPX3x2JeJ1tzdCVXfUT4ZyxOLj+ioUbU+JYVN8
         EPTvLJ71bHC2loWbMxz1UI2lKy1jWeecxphweOVBqp4NKCRiMdqkwekFZQdtSTuLUc8z
         9p6XrwBOwOaL7BadBy0WuX5ZPjFB9n6/BSJ/+ys0hczcK6M/mqBX91i9v+R/1qzuM7LO
         3a6TWyKCjMjwJwnguOHLJ1OGuN62tqhOb6cdDNB6XvXOBoliec/bXf6tl92knuDs1tdL
         /HCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=hBDv23lTTPV+k7kdFyfHVtRxjPHVvsOA1B1gMYBRxWQ=;
        b=cD6Xa+K73mknR8ou47gCjyAy9JL0iT33mt32oW4B+2DILAXG82YzoczNmZ8vh0OqpA
         HaAIbK7FBYPLGbj6oz1Qo3Tj9ygihvBfSF3SRpKvLZu3RdgC+uQK3WYe92HXNwIBi6uV
         fbdfZx3ZyRsydZt3KQr5ru1RRSUWMvGyTF5rMR2lQUT9U3sqlkVlkIBEtNMxQHhvuyfw
         EmADiSyt3SZ5ZPEX93HrdtsvajT9Y+6YqyM04ZGmmSNVtRFlK/pzP3h5MUlEG8JYb5Cf
         A+aw/OWR0YIKg9z9dJE83bcihohl2KaNzUZ1ySoYVDUVfsyIMpZN4GDFDp3lVGJyAjtu
         +icw==
X-Gm-Message-State: AOAM533EpL5mCL/5opec3w6G+3NjE6XCjd4AKTsDW+vT5e4rTLtPHzcG
        pltLRzbz7ynHzJfmQJFBL6c=
X-Google-Smtp-Source: ABdhPJwyrF5PP4x/2+/CJ69hZAyYabhk7OyXKXqmslovZOTmn8y/xrXP+93w5iMHoNSvitgUPqun5A==
X-Received: by 2002:a50:8121:: with SMTP id 30mr37047edc.311.1611354532619;
        Fri, 22 Jan 2021 14:28:52 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id qk1sm5248909ejb.86.2021.01.22.14.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 14:28:51 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org
Subject: Re: git archive setting user and group
References: <043f01d6f0fe$d6ad7660$84086320$@pdinc.us>
 <cef51cd3-c6b5-ed24-f695-83be3a6743b4@web.de>
 <20210122213954.7dlnnpngjoay3oia@chatter.i7.local>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.14
In-reply-to: <20210122213954.7dlnnpngjoay3oia@chatter.i7.local>
Date:   Fri, 22 Jan 2021 23:28:51 +0100
Message-ID: <87v9bo7gik.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 22 2021, Konstantin Ryabitsev wrote:

> On Fri, Jan 22, 2021 at 10:00:04PM +0100, Ren=C3=A9 Scharfe wrote:
>> Adding support for using a custom user and group should be easy.  Is
>> this just a cosmetic thing?  Regular users would ignore the user info in
>> the archive, and root should not be used for extracting, and on systems
>> that don't have a logwatch user this wouldn't make a difference anyway,
>> right?
>
> Right now, "git archive" operations are bit-for-bit identical across all
> versions going back at least 8+ years. In fact, we've been relying on thi=
s to
> support bundling tarball signatures with git tags themselves (via git not=
es).
> E.g. you can see this in action here:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tag/?h=
=3Dv5.10.9
>
> If you click on "(sig)", you will download a signature that can be used to
> verify the tarball generated using "git archive".
>
> I would argue that adding user/group support to "git archive" operation is
> not really solving any problems other than "it's different from when I ru=
n it
> as a regular user" -- and can introduce potential compatibility problems =
if
> implemented.
>
> So, I would selfishly vote not to implement this.

It seems "logwatch" has the same situation, except their backwards
compatibility is with non-"git archive" tool that used user !=3D root.

If it solves a problem for some users and someone comes up with a patch
I don't see why it shouldn't be implemented, but I think it's important
that "root" is the default unless configured or the relevant option is
invoked.

Or do you mean that the kernel.org use-case is that users are expected
to run "git archive" on their own machines and upload the result to
kernel.org, and that kernel.org relies on two such files bit-for-bit
identical?
