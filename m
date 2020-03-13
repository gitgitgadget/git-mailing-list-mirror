Return-Path: <SRS0=VWjS=46=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2683C10DCE
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 18:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6C182072C
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 18:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXqgwdZ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbgCMSLf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Mar 2020 14:11:35 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37039 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgCMSLe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Mar 2020 14:11:34 -0400
Received: by mail-oi1-f194.google.com with SMTP id w13so10388656oih.4
        for <git@vger.kernel.org>; Fri, 13 Mar 2020 11:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OjLclSxmA+PyoHstXrn1C5vC10yQBblFKwXO6vylHPc=;
        b=jXqgwdZ89+nSCVb87Gk/0HCMm1xqiJfq3FatYLK9mHNsy0XGKy9OSXAHNSm1nhDVsC
         mDwsmFnTtngafbxZdvpDnzoUk00oOUHV5JlWRb9rG21JluiZdgS1wGkPRXotzvV1FyDD
         3kaZSMkZVRU5lFMfEX2hYHrP3EaEdTDemHnrgXfE+XTLxfm+R2QZkcI/47EUODQFEjp3
         P7EdWCaPKwsH++2UPcgt2t6UixoyyOsdOvrNOhYcg6SltdJOMCbqjuIxK2+8ofjYd+M3
         ve6rcFPlwBR1cdULcvbryH5m4zFzjitOzyDjtjmaKlUiAQksMwVi1g3Ma9QDTU7uf0C2
         eMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OjLclSxmA+PyoHstXrn1C5vC10yQBblFKwXO6vylHPc=;
        b=ZMdUHt8oi9BmgwtB9CpZEEBLsu1faoJ3Y1NnR8kiXNUlox9j2QVKzS6GpD6rA6GBcB
         XZ2cwq8mnKB98ZXZmQn49QMUneqziJHahjwYkMpgZvSmDYCNTWpbsuTIBZoB8X9g7oMP
         GrUH3SCSQN8gRE3/pjoLHLHPpmw+szcBvIPX52Spj6iVJM8z/pKSyLvnNDcLz4ym4LHX
         Qzp4Odvp/PJYtAmGRfWYUfgFHJ85ps0zJZNkrF0w0vHmwRXpQ46tCLc14y4XKj2Pehza
         d3YDR2Z20y3s7jhkO/pXYraGSyCPFf/2fLxvLswR+I30AUAHAm9fB5KLfwm9Z1V0OMN+
         uH0Q==
X-Gm-Message-State: ANhLgQ3HNiWpZSMcZHfXQYwahic/cjza+0r+ZL+REjKSg1khdXN4WpEI
        5vMD0xuCTtjdPpL7LO70FXfuW7Uvj84EEaymivX/gA==
X-Google-Smtp-Source: ADFU+vt2RV4T7VQ0vxn542AOZTJAwzNKtFpR1MfzKJwerdCwuFppbzAlgkCkQd/5ZpjZ08bqkUF8/f6xM0M0sWtpJSo=
X-Received: by 2002:a54:4416:: with SMTP id k22mr6687333oiw.167.1584123092159;
 Fri, 13 Mar 2020 11:11:32 -0700 (PDT)
MIME-Version: 1.0
References: <pull.716.git.git.1582762465.gitgitgadget@gmail.com>
 <26d0c34cd1d4a54dab28d0c9c2242336244e8a3c.1582762465.git.gitgitgadget@gmail.com>
 <20200313171248.GA613@szeder.dev> <CABPp-BGt4xaqG+3m3q=PfMTmfotjvze2TPp5JhthE2YHsLa=-Q@mail.gmail.com>
In-Reply-To: <CABPp-BGt4xaqG+3m3q=PfMTmfotjvze2TPp5JhthE2YHsLa=-Q@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 13 Mar 2020 11:11:20 -0700
Message-ID: <CABPp-BH71UVqf8X8Syx5PfhE+-htrwd8aCW87NzR9Kubxp9-xA@mail.gmail.com>
Subject: Re: [PATCH 4/5] t6022, t6046: test expected behavior instead of
 testing a proxy for it
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 13, 2020 at 10:18 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Fri, Mar 13, 2020 at 10:12 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com>=
 wrote:
> >
> > On Thu, Feb 27, 2020 at 12:14:23AM +0000, Elijah Newren via GitGitGadge=
t wrote:
> > > diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
> > > index 6f196aaf276..d97cf48495b 100755
> > > --- a/t/t6022-merge-rename.sh
> > > +++ b/t/t6022-merge-rename.sh
> > > @@ -242,12 +242,23 @@ test_expect_success 'merge of identical changes=
 in a renamed file' '
> > >       rm -f A M N &&
> > >       git reset --hard &&
> > >       git checkout change+rename &&
> > > +
> > > +     test-tool chmtime =3D31337 B &&
> > > +     test-tool chmtime --get B >old-mtime &&
> >
> > Here you compare the mtime of 'B' before ...
> >
> > >       GIT_MERGE_VERBOSITY=3D3 git merge change >out &&
> > > -     test_i18ngrep "^Skipped B" out &&
> > > +
> > > +     test-tool chmtime --get B >new-mtime &&
> > > +     test_cmp old-mtime new-mtime &&
> >
> > ... and after the merge.
> >
> > > +
> > >       git reset --hard HEAD^ &&
> > >       git checkout change &&
> > > +
> > > +     test-tool chmtime =3D-1 M &&
> > > +     test-tool chmtime --get M >old-mtime &&
> >
> > Here, however, you compare the mtime of 'M' before the merge ...
> >
> > >       GIT_MERGE_VERBOSITY=3D3 git merge change+rename >out &&
> > > -     test_i18ngrep ! "^Skipped B" out
> > > +
> > > +     test-tool chmtime --get B >new-mtime &&
> > > +     test $(cat old-mtime) -lt $(cat new-mtime)
> >
> > ... with the mtime of 'B' after the merge, i.e. the mtimes of two
> > different files.
> >
> > Is that right?
>
> No, sounds like a copy-and-paste-and-forget-to-update bug.  Thanks for
> spotting it.  Since you found it, do you want to submit a patch with
> the fix?

Actually, it wasn't wrong.  Definitely needs some comments explaining
the weird construct, though.
