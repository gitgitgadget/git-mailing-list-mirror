Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A663C433DB
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 14:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7AA92313C
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 14:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgLWOcU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 09:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgLWOcT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 09:32:19 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76D9C0613D3
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 06:31:39 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id d20so15168315otl.3
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 06:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=YNNEeVzHLJoT6+cHVh6LqAV9bJy3G7nBJyR8CFA0SuY=;
        b=UdxLVhgnRNo9Xr2tFmKM+p3XYTKSlp8d2NqmOEUQ2INvs+3wdBClnjCjfZ5SbrxD9r
         3eoAmryr6Sw83ewELBBJ5VD/ejNnCpSmG/541zjNKcf39ecK26KmaZWD9kNcrmbXtgZT
         egF3Tt6b4Qu/RNSVtFuSnY98Mn42t69a5Cp/yC9cuyWwo1AlK0qg4b4vcYWIPoZmtiru
         CJP8GhtDeYAMmYxy0oRA6nH2cXvK4r3FtrtZrJD7t5LhXX/dVcGfvrB3SmUxGB+FoOGO
         lx5r/lTqt926qpfhxRxU0L6bjEN85HKGUY3vqWDJHdqZyxgrADA5ziPI2wRotQ2m4BIL
         MSbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=YNNEeVzHLJoT6+cHVh6LqAV9bJy3G7nBJyR8CFA0SuY=;
        b=ggQJ+AtN3dVkyXSU1u5Zuv1Q7SF8avzS5ESW2lA2HZ1OWRM6bGsFKYJ1UTYdjRYAXD
         1rq7ebytjWiBTRIWuKdS2uh/7J3uLeH3t09HK4dnHC3ylgUuSS0sJ03kl6B1KY70oi87
         yoaaDN5bt0b8xqZEzBG7IRqHZeTWlgRGcbKLiQF1Jbrs1WpBbSHrMBBOKllEJnP4RdcK
         OUfRhIQ3yuHbkQ2JlAGVoStooJO4vEH1TzJjV9slhm95APlp61CGjlW/PPjr1DwxS5Bd
         9VGY5VQUPlnX0LP+BuWLce7/WEA1YGWFpIJ63Q9CCWHSSOtrnNbkjm1Ta61Gj7h2kC49
         hNYA==
X-Gm-Message-State: AOAM532xKptrv+tuAkDSC4GseJ7evsW63pzWjahu///1l+PVRGX4SkeO
        lhnaSSDxn98XCl1whmqzvB4tPtH6YyBE6g==
X-Google-Smtp-Source: ABdhPJznCi7mRXZ4/Tt/JavjjDh5iIzXN2qsDWaiMtDcjQwKlFhSP43Tw5CFS72TqqbnlzDLee8V9A==
X-Received: by 2002:a9d:3a2:: with SMTP id f31mr20215862otf.216.1608733899211;
        Wed, 23 Dec 2020 06:31:39 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id s17sm5326755otg.16.2020.12.23.06.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 06:31:38 -0800 (PST)
Date:   Wed, 23 Dec 2020 08:31:37 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?U1pFREVSIEfDoWJvcg==?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Message-ID: <5fe354c91a6f7_198be208d8@natae.notmuch>
In-Reply-To: <20201223141950.GA23264@szeder.dev>
References: <20201219140621.1961760-1-felipe.contreras@gmail.com>
 <xmqqy2hoanps.fsf@gitster.c.googlers.com>
 <5fe3484465fac_198be208bf@natae.notmuch>
 <20201223141950.GA23264@szeder.dev>
Subject: Re: [PATCH try2 0/4] completion: bash: a bunch of fixes
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor wrote:
> On Wed, Dec 23, 2020 at 07:38:12AM -0600, Felipe Contreras wrote:

> > and in zsh, this:
> > =

> >   local sfx
> >   echo "'${sfx- }'"
> > =

> > Prints an empty string.
> > =

> > That's because in zsh "local sfx" is effectively "local sfx=3D''" whi=
ch in
> > my opinion is a bug.
> =

> Bash versions up to 4.0-alpha suffered from this bug as well; I believe=

> the relevant changelog entry for 4.0-beta is this:
> =

>   e.  Fixed a bug that caused local variables to be created with the em=
pty
>       string for a value rather than no value.
> =

> So the default Bash version on macOS still has this bug, thus
> __gitcomp_nl_append() is invoked with an empty string sfx parameter
> instead of a space, causing the test failure.  I can reproduce the
> test failure on Linux using Bash v3.2 (and v3.1 and v3.0), and it
> passes with v4.0 and later versions.

Ahhh, interesting.

So I'm not the only one who considers it a bug.

> > I see 5 courses of action:
> > =

> >  1. Drop the offending patch: this is wrong because the bug is still
> >     there, we are just not checking for it.
> >  2. Add a BASH prereq just for that test, or test_expect_unstable (we=

> >     would need to add extra code for both of those).
> >  3. Add the fix, but not the test for the fix.
> =

> I'm for this option 3: this patch does fix a bug for users of Bash
> v4.0 or later, while it doesn't change the behavior with v3.2 or
> earlier (and with zsh, if I understand correctly).  OTOH, the test
> doesn't seem to be all that useful: while it does demonstrate the
> issue, it checks only one of those callsites that passed the wrong
> suffix, and, more importantly, it doesn't protect us from adding
> another callsites with similarly wrong suffex in the future.

I'm fine with that option.

> In any case, the commit message should note that the fix doesn't work
> with all Bash versions and why.

Yes. I will send a re-roll (unless somebody objects beforehand).

-- =

Felipe Contreras=
