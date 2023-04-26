Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0467CC7618E
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 13:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240795AbjDZNTY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 09:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241118AbjDZNTW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 09:19:22 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837C41702
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 06:19:21 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6a60630574aso5636623a34.1
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 06:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682515161; x=1685107161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tsv9vHp7tXVJuVJ4C8MXtoB7xgW7xhQOyEC05wQtYa8=;
        b=GH9ESQfVojH6UcoqDSngD1UH5oxSNthUA726QyrEfjc/c1tQptQEl0eL5w7ToCBuZ1
         FHtNPGCTnwaCJaKibAYIk3gqW3KdjpHrkJ5VimbgiVYFeHqCSaCuZVjwTDefl5wIllnA
         2bbb97387Z0+WGVt3wmTjawCX8U5KCk+MU1YA5YvQNtlZtWpT1q5MVQjeUvkKwfW0SrA
         +h0e0H9bRDWy7IDL7b6tLIq9/rAY31RrvxX9KzR37YBSlq7owExV5LHtRoLazKGGox3d
         7JdAvCxZIlfvYv+YhBuLl6Rd100otCEgFEhdlBjLtgv/W4eD64+fnnbXKuFsWQVOCQIQ
         U7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682515161; x=1685107161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tsv9vHp7tXVJuVJ4C8MXtoB7xgW7xhQOyEC05wQtYa8=;
        b=jqnR7/RC7r2WnuFIfBNUQXA1U9ZmghCZAlgzbRD2Vv3jIJSwIcFpAjDIoRDqAAS96K
         YGlBmdkq8YvND/F6J0N4URTDEAAshCgljJcqBx3wnhj22Hf+br7Q3u0m5pBwI5d8SVtE
         oapYdA8Y49u5ggnhLYdt0kr6TtLhdzeA+sSFF6vzby95TYH4yqLymvPOUQ6n4CEPSAPI
         V3OoWg6BsMQx8eFTmTpBtPytZMeeXd8C7BaQ/RPKKwOdPMiMXtCfou4auPPsJzsh9nEt
         HRB3HCZ/oHbLtINOMCOrN/mI8mcNlnjU+IIc5Bwydz+VZPxaINGNzzeDk/1Tu3altBrF
         0Ovg==
X-Gm-Message-State: AAQBX9eUCWM8j7+Mh02SDSHJWgo5yp/l8emAbRMbwbXTR4Aqts6aOiZj
        DsDIhWPNzM0Lk/qKR6jovKPftpRIiwHNuAUFcomjEjUP
X-Google-Smtp-Source: AKy350Z5069jRHxTThlGhWPqNeHYDN3cAxyEJJ00Q+C+DoIhdQ13hmfdat7rsaYkkBf1X8d31T/nyY5iae4TBEhBLHY=
X-Received: by 2002:a05:6870:700f:b0:180:b716:9825 with SMTP id
 u15-20020a056870700f00b00180b7169825mr12816602oae.57.1682515160792; Wed, 26
 Apr 2023 06:19:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230421055641.550199-1-alexhenrie24@gmail.com> <20230421182556.xxd4vrcksr6634ao@tb-raspi4>
In-Reply-To: <20230421182556.xxd4vrcksr6634ao@tb-raspi4>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Wed, 26 Apr 2023 07:18:44 -0600
Message-ID: <CAMMLpeRWXCFxk1wCjLPizdgJLG8n0Hy0o+Gm849Ln85cZkkH8w@mail.gmail.com>
Subject: Re: [PATCH] docs: clarify how the text and text=auto attributes are different
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org, eyvind.bernhardsen@gmail.com,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 21, 2023 at 12:26=E2=80=AFPM Torsten B=C3=B6gershausen <tboegi@=
web.de> wrote:

> Using
> *.txt text
> in .gitattributes
> will convert CRLF into LF in the repo at the next git commit/git add
>
> When you create a file with CRLF (no atttibutes), commit it into the repo=
,
> and later add the attribute "text", the file may be reported as modified.
> Not always. A `touch file.txt` typically asks Git to re-investigate thing=
s,
> and it may show up as modified.
> After a `git clone` it may be shown as modified or not.
> End of side-note.

Thank you very much for pointing that out. I had assumed that "text"
and "text=3Dauto" behaved the same for text files, but they do not:
"text" normalizes line endings even if the file is already in Git.
That means that my proposed text is not correct, and I will have to
change it similarly to how you suggested below.

> >  Set to string value "auto"::
> >
> > -     When `text` is set to "auto", the path is marked for automatic
> > -     end-of-line conversion.  If Git decides that the content is
> > -     text, its line endings are converted to LF on checkin.
> > -     When the file has been committed with CRLF, no conversion is done=
.
> > +     When text is set to "auto", Git decides by itself whether the fil=
e
> > +     is text or binary.  If it is text, line endings are converted as
> > +     described above.  If it is binary, they are not.
>
> Here we need to have the lines from above:
>
> When text is set to "auto", Git decides by itself whether the file
> is text or binary.  If it is text, line endings are converted as
> described above.  If it is binary, they are not.
> However, if the file was already in Git with CRLF endings, no
> conversion is done.

Yes, the note about what happens if the file is already in Git with
CRLF endings applies specifically to text=3Dauto, so it needs to be in
the text=3Dauto section. The documentation of the eol attribute actually
explains it more clearly:

"Note that setting this attribute on paths which are in the index with
CRLF line endings may make the paths to be considered dirty unless
text=3Dauto is set. Adding the path to the index again will normalize
the line endings in the index."

I think that explanation needs to be moved from the eol attribute
documentation to the text attribute documentation and edited for
clarity. I will send a v2 that revises the documentation of both
attributes, taking into account your and Junio's feedback.

Thanks again,

-Alex
