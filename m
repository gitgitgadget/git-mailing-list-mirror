Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE64CC43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 00:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B605720663
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 00:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIFtUcGY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbgC0AVr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 20:21:47 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40702 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgC0AVr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 20:21:47 -0400
Received: by mail-ed1-f65.google.com with SMTP id w26so9128773edu.7
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 17:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=boOua7fYjcy+Hcl3ycprRi1HO/DHVtrPiZoEnayXVvY=;
        b=GIFtUcGY8Yvn7H47iY7cFROcGlNb6Yg4AFqxFNFBDvXy1WjNc0l5m9IpFnujyKs2Ab
         /T1bwKpkO7WcDOK557HPrVnSpi1XKKqfZGjwFO7Y1Kl536XYqVv3I06MP0v33x3AFHJY
         PzpQ5gMCEMQ1U2v6pgH1Lk8JuR6dBB6+c7lr5xihymxIHk+WgZ9qO90nvZzaLw12rv21
         eDrMhL13Dpg42ldDvegpchxoqeSime0jo/L2MTMmiv7dTGBXeAuviZYowcz6nNyj2768
         EeiEx6zccph531X9CurOUE1HFcEtrU3HeyexToLaXfIeJsj3SG8rXorormAWKwpt/CgB
         a8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=boOua7fYjcy+Hcl3ycprRi1HO/DHVtrPiZoEnayXVvY=;
        b=gzpWEaE7q/Dtl7oGJC8fv0Hde9SmsOzgQXzZ7FcfyC6MYjinUG9NXULHJaRiGiFQtM
         LLnZ6W5uWYXroSPyqf3SVN7Tfc+rusFl/VJ4diC1DfIpXBbHLEcfBfgieyaIAMMzE4eE
         PMwwO/fLhIZhQ+rOuw3zzALYRKT211ZbR4Y5QmpCIkBr6mR/5+dYp9G9eeU0H2K1K0LP
         YAvFd3E8RYiJiFkcy7gKWswyJPsz/w9KTHo69xA3e7o9t9SoUEYNP/wkmn69gXRVW5/5
         9INSQACrNwDzLlxOw7r4tYcChFsQL2AyZoFU548IBdiLKGsKh+9TeWxGt7I7sDxgv+oA
         uSag==
X-Gm-Message-State: ANhLgQ1eSZFmyIMh1VXyMI/9sXyW3hvMCp/MI/CY4UVWI2n+/qUKgubZ
        DgKlD3q6pONaCkhxg2VT39IZ29KaKkwg3izRigs=
X-Google-Smtp-Source: ADFU+vvxQ4bbgSwMOCa50wxyxmIcA6mZUpI5T0BJhLGkh51oaXJUDn50daoqDvFLMlw+Y1+xpl2HqwWbgI8WMU0fgaI=
X-Received: by 2002:aa7:de13:: with SMTP id h19mr9211796edv.270.1585268505239;
 Thu, 26 Mar 2020 17:21:45 -0700 (PDT)
MIME-Version: 1.0
References: <pull.587.git.1584997990694.gitgitgadget@gmail.com>
 <pull.587.v2.git.1585143910604.gitgitgadget@gmail.com> <xmqqmu82izt4.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqmu82izt4.fsf@gitster.c.googlers.com>
From:   =?UTF-8?Q?Andr=C3=A1s_Kucsma?= <r0maikx02b@gmail.com>
Date:   Fri, 27 Mar 2020 01:21:33 +0100
Message-ID: <CANPdQvJk4kJSMitaV_cEk-xY3_a=o1VN4fAqFCPiXWJf2ahScw@mail.gmail.com>
Subject: Re: [PATCH v2] Fix dir sep handling of GIT_ASKPASS on Windows
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Andr=C3=A1s_Kucsma_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 26, 2020 at 10:14 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Andr=C3=A1s Kucsma via GitGitGadget"  <gitgitgadget@gmail.com> writes:
>
> > From: Andras Kucsma <r0maikx02b@gmail.com>
> >
> > On Windows with git installed through cygwin, GIT_ASKPASS failed to run
> > for relative and absolute paths containing only backslashes as director=
y
> > separators.
>
> > Subject: [PATCH v2] Fix dir sep handling of GIT_ASKPASS on Windows
>
> Isn't it curious that there is nothing in the code that was touched
> that is specific to GIT_ASKPASS?  We shouldn't have to see that in
> the title.

You're completely right, I'll rephrase the commit message based on
your suggestion and resubmit.

> Having said all that, I am not sure if we need to change anything.
>
> As Cygwin is about trying to mimicking UNIXy environment as much as
> possible, shouldn't "GIT_ASKPASS=3D//c/program files/askpass" the way
> end-users would expect to work, not the one that uses backslashes?
>
> And if the user pretends to be on UNIXy system by using Cygwin by
> using slashes when specifying these commands run via the run_command
> API, the code makes the decision for PATH-lookup quite correctly,
> no?
>
> So...

Cygwin provides a Unix like environment, while also maintaining
Windows compatibility, at least as far as path handling is concerned.
As a quick test, fopen can handle forward slashes, backslashes too.
These four all work under cygwin:

fopen("C:\\file.txt", "r");
fopen("C:/file.txt", "r");
fopen("/cygdrive/c/file.txt", "r");
fopen("/cygdrive\\c\\file.txt", "r");

There seems to be a precedent to support Cygwin as a kind of "hybrid"
platform in the git codebase. In git-compat-util.h, the
compat/win32/path-utils.h header is included, but GIT_WINDOWS_NATIVE
is not defined.

https://github.com/git/git/blob/a7d14a442/git-compat-util.h#L204-L206
https://github.com/git/git/blob/a7d14a442/git-compat-util.h#L157-L165

The compat/win32/path-utils.h header mostly provides utilities dealing
with directory separator related logic on Windows, but these utilities
are being used in the Unixy code paths on Cygwin.

The current version of the patch fits into this pattern. It only
changes behaviour under Cygwin, not touching pure Windows and
non-Cygwin Unix variants at all.
