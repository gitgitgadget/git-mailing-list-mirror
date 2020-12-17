Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BECC4361B
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 08:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4349C23884
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 08:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbgLQIoi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Dec 2020 03:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbgLQIoi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Dec 2020 03:44:38 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08BBC0617A7
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 00:43:57 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id 11so26520432oty.9
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 00:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rBVIBtZIHIcDE5Zb1+4P7J50IN4acb3MzC4qzkkxWKg=;
        b=CBhlXRgba8qvXg7fS8G36Vnl+8JngFH9j52tldZKTO2Z+Rf/FUEFi/IRKs6A6Dqbyf
         V4XcLv2eji0xldedbUzyShzmmVAkzxTWyRetDIq9pVCZ+9iEmXSEXNJMzrt9lx+13DBA
         O1zDcPI7FJahiwaeg4m/NoJ+svgC39uPXjgjRSYFAeMkfP0i8Sf8/MJ7QeK0B1t+onCn
         FUkIvG6zR1oLJhxQ8doTdH+5Cq+leA95dg2zClfOcM2ktsO1WesW5OljDfrvPJFdwkjt
         B6/75GOv1Gcrs1FMkUST/aduoT71Q++ovJoPChHK24iTdxx4wHKYveS2WHGKSvZrysix
         luGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rBVIBtZIHIcDE5Zb1+4P7J50IN4acb3MzC4qzkkxWKg=;
        b=Y94zfg+Xk0/zv6ilFi66kK2iVlOi96WaUBFtJ8+Lf2OWKaNPiOz0PBZvfCqDEsXETh
         kXbJEFnImmG/bp8NUlGvodYhJYhX1AA22t4eVe3IYYJY1wGxK5G4yerRx4dCoV4m8mbj
         yAilS6nh9zQfhNiXILNaeLaZ2VpE5t+XlSIxpF7m3Xvay0qibAdXv7b9YlUVu810/ZmR
         9XTzL5jTsIfZGMEWPPZvrlgScPUraKDe2ov/8ch+8J4x6BkdoGM7Xc1N083JzmL/3uHm
         tws4iQsuOda3cmSd/HiRrE1pD+XL5Iy476d53TqBVE0EBblKGsV4Xz9nAYgkweckCVsd
         y3mQ==
X-Gm-Message-State: AOAM530GMw0pctVqVNWWdmA8PCgAEbs6u1E974LBXGJcxCFP8YTHnUjf
        YuPjhJ4lsuLmanMSii2d4+RGeVtzl7gmnr8WDiQ=
X-Google-Smtp-Source: ABdhPJzjuguHpoKtM2QbWgNpOQ7Jzu0/a6HaTw+3rv6wE9bDDoc2BDoPYcV3wdDzm7optLTJbb3hqP6R0y6kg0/kPtE=
X-Received: by 2002:a9d:a78:: with SMTP id 111mr28396035otg.94.1608194637061;
 Thu, 17 Dec 2020 00:43:57 -0800 (PST)
MIME-Version: 1.0
References: <CAHMHMxW-LwjLWF9PPuSJmbAafw37d_18j+HmOd4+8MKbajb_8A@mail.gmail.com>
 <CAHMHMxW_zwq_xK3Mh5QjC4dM1muVotESZdGQkRAx8xeKYmHzbw@mail.gmail.com> <xmqq1rfp4l35.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq1rfp4l35.fsf@gitster.c.googlers.com>
From:   =?UTF-8?B?zqPPhM6xz43Pgc6/z4Igzp3PhM6tzr3PhM6/z4I=?= 
        <stdedos@gmail.com>
Date:   Thu, 17 Dec 2020 10:43:20 +0200
Message-ID: <CAHMHMxUdt1cxE1UkjbjUxpL=4fcjrE64udR6YJidbzLJS0ca2w@mail.gmail.com>
Subject: Re: Fwd: Bug in `git add -N xyz ; git stash` command
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It seems like it, yes.

Not deciding to fix that (or not agreeing on how to fix it), should be
orthogonal from the "what does the error message says" about it.
I would expect something like "'xyz' is marked with intent-to-add;
either stage (git add xyz) or remove the file (git ... xyz); refusing
to stage."

With regards,
Ntentos Stavros

On Wed, 16 Dec 2020 at 21:17, Junio C Hamano <gitster@pobox.com> wrote:
>
> =CE=A3=CF=84=CE=B1=CF=8D=CF=81=CE=BF=CF=82 =CE=9D=CF=84=CE=AD=CE=BD=CF=84=
=CE=BF=CF=82  <stdedos@gmail.com> writes:
>
> > I think I have found a bug with the following series of commands:
> >
> > $ git add -N xyz ; git stash
> > error: Entry 'xyz' not uptodate. Cannot merge.
> > Cannot save the current worktree state
> >
> > It has bothered me that `git add -N xyz` "is not obvious that it is
> > done", unless you know that you did it - and now it seems that there
> > is some buggy behavior about that.
>
> Hmph, is this the same issue as what we discussed in
>
> https://lore.kernel.org/git/CA+dzEBmh4LdN-XFS9y9YKrDMzV_7+QpDzBA2uv9Xi80P=
gR5NTQ@mail.gmail.com/
>
> I wonder.
