Return-Path: <SRS0=VWjS=46=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFB4C10DCE
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 17:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F2A206B7
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 17:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ssgxZk1q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgCMRSn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Mar 2020 13:18:43 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42667 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgCMRSn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Mar 2020 13:18:43 -0400
Received: by mail-oi1-f194.google.com with SMTP id 13so1242607oiy.9
        for <git@vger.kernel.org>; Fri, 13 Mar 2020 10:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0gGcDqd/5sGD8fyf8SzWoaUod//e2PxNQm9c2Majpxw=;
        b=ssgxZk1q3AJ5xx8srdAHExMhyT63KnK0FSpC8CtNSF7wwJn+m+QqLwjPSEAPbmFZ/r
         etJFUxY8A57Fkr2hwXsMjVG1c8fkAlCTU5xkRLkDLKYAVJcttg2uF9qMpp8vyD3jMEVL
         hAuiTo+2FfxRDSOt7xTu7ZCCXxRO7wJx8h4+x+NeeOnt8t70hRw+BsHN2AgolwA3C+KZ
         FDd4QhskvdycoKiFKtou3vvBJeiZiJEPGuh6zluKKIL41Mhhk1fzi6L1Gx9RDdH1SQyv
         eNjrlr19jC2sX3Z/wuFWNpXIXfD2UEgkCf1g4dZVJ0eFrqXMSOsM3cgRKWc0JAH7YQ5g
         zvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0gGcDqd/5sGD8fyf8SzWoaUod//e2PxNQm9c2Majpxw=;
        b=S3MIJNEPOnJzuQ58e3CsEWQhh4Oz/ar6wIsG4C7b0jyKE6Gm9B3B/UayyoRewA3QkS
         911Wm5+04U5oXzAOnUv92dEMnz1bpKpW3XaSj+FU2GbY0TnoZ6TeuJ7ImlnEcN0FWUKd
         tjBDPxj6Tl9RrOnk7ciShS8naUfe6XhBM5osbTyC8cLKkhv7W2L06Q3TRxjifOBoL10s
         bD/BUasBWfSnUPEPx67FNAnbrCJzQfobvx8hhiM7E7CMh15+CWyuEOUQ8HaNtcM1oT75
         80U2WDwNawkgMLfy/5qWiCFyTZzE7Tp4QleY/wADxPy5tTNBL+kumDbAZE1aOM+ymOQo
         9tEA==
X-Gm-Message-State: ANhLgQ00t98Efi4WIrlt4+FMlBJVtkUozBXPXfAgxZ+nac9Q6LVKimIp
        LBbYxgotDKBjEPl0cTTu9WQt+L9LX0uMHxHCuxfiOQ==
X-Google-Smtp-Source: ADFU+vttM89epB10YW6olHnK1V28DlpU5bGdv5KlNDkS8mr006YYhkNFQHupNDtVPjHY1emyEVpSEZHYcT4latUbh68=
X-Received: by 2002:aca:dc45:: with SMTP id t66mr8027176oig.39.1584119920960;
 Fri, 13 Mar 2020 10:18:40 -0700 (PDT)
MIME-Version: 1.0
References: <pull.716.git.git.1582762465.gitgitgadget@gmail.com>
 <26d0c34cd1d4a54dab28d0c9c2242336244e8a3c.1582762465.git.gitgitgadget@gmail.com>
 <20200313171248.GA613@szeder.dev>
In-Reply-To: <20200313171248.GA613@szeder.dev>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 13 Mar 2020 10:18:29 -0700
Message-ID: <CABPp-BGt4xaqG+3m3q=PfMTmfotjvze2TPp5JhthE2YHsLa=-Q@mail.gmail.com>
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

On Fri, Mar 13, 2020 at 10:12 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
>
> On Thu, Feb 27, 2020 at 12:14:23AM +0000, Elijah Newren via GitGitGadget =
wrote:
> > diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
> > index 6f196aaf276..d97cf48495b 100755
> > --- a/t/t6022-merge-rename.sh
> > +++ b/t/t6022-merge-rename.sh
> > @@ -242,12 +242,23 @@ test_expect_success 'merge of identical changes i=
n a renamed file' '
> >       rm -f A M N &&
> >       git reset --hard &&
> >       git checkout change+rename &&
> > +
> > +     test-tool chmtime =3D31337 B &&
> > +     test-tool chmtime --get B >old-mtime &&
>
> Here you compare the mtime of 'B' before ...
>
> >       GIT_MERGE_VERBOSITY=3D3 git merge change >out &&
> > -     test_i18ngrep "^Skipped B" out &&
> > +
> > +     test-tool chmtime --get B >new-mtime &&
> > +     test_cmp old-mtime new-mtime &&
>
> ... and after the merge.
>
> > +
> >       git reset --hard HEAD^ &&
> >       git checkout change &&
> > +
> > +     test-tool chmtime =3D-1 M &&
> > +     test-tool chmtime --get M >old-mtime &&
>
> Here, however, you compare the mtime of 'M' before the merge ...
>
> >       GIT_MERGE_VERBOSITY=3D3 git merge change+rename >out &&
> > -     test_i18ngrep ! "^Skipped B" out
> > +
> > +     test-tool chmtime --get B >new-mtime &&
> > +     test $(cat old-mtime) -lt $(cat new-mtime)
>
> ... with the mtime of 'B' after the merge, i.e. the mtimes of two
> different files.
>
> Is that right?

No, sounds like a copy-and-paste-and-forget-to-update bug.  Thanks for
spotting it.  Since you found it, do you want to submit a patch with
the fix?
