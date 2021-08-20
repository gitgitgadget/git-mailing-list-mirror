Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A44CC4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 03:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6372A60EBC
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 03:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235305AbhHTDTt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 23:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234992AbhHTDTp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 23:19:45 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F738C061575
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 20:19:08 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id s19so5345445vsl.11
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 20:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VdGTW8uMF3DHeBxkbZzDDBi3EfBbmlpYDKTyZ5Tj4T8=;
        b=ZBX1XXy+poN4cuyQMg6WY3T/uX3qDH8AkuKimw4idqlkWLPRs3XnVpUCgIRCKTaVyT
         bG9SqAjaunioCZBeaFWt0nvoJ9SaVZx6Qe5YeuNZkADbQ2wXrx9bVFfvAJ10R/Jqzwg6
         f363DENLqDSX/FdWRmKyLf2Khg32v6RYZ0asdoxz2Pj6v+MFrBoGkjGFwIRExsQZ2u6V
         EbqlDirOQVcmPJE0E1Y3pie6qbKv0qBTdxXh6IfF1+h1KhUcchRQzhxnXuO/oxZ2nXJv
         heBMBCEXB7seVxkoZRUld3lyNRsVFhdV11blKEckyJqMDZWfRA+GycwQhcMPCAIQAI+g
         Y09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VdGTW8uMF3DHeBxkbZzDDBi3EfBbmlpYDKTyZ5Tj4T8=;
        b=l91TlnqqXJNnDwfqZtcu4pUW08c8ffNgqxOLsgdPPzBvUnUmi6RrGQasZQvRfS4t5l
         DSZdxcmZdMVBpDZhNM20PO2vPVjvELB5GYBZ+L8ydwzlji6JhSFcoRa7e/x3H/Pql1Zt
         HICkBs3GXWPSL8DnhoYlh7ZGAj4+kApudFyclz/qnzHFTjYUhwGBwTbDBQiAUyR/DyOp
         kijbp9GVcvd9BdqDxqF0z4CMdD/ICzhi2DEdBqDxvK/BMb/KtzATjoWE2+8Agw0FCEKi
         tJJliLLK4UumkRICEeU5t8mWzJCOTpVw92OTo0pnHKQ9sS7BFTOKdWxFNRvGcfVMoH9K
         uEwg==
X-Gm-Message-State: AOAM5326qvsKOMhM8kbug+YhcULAEtu0Hxbfd+aEigWgxiTqvCHu7es3
        C0+bxYvMM6Qqmc1aqsvcMJIPWeI++WKYKppKM6Y=
X-Google-Smtp-Source: ABdhPJyiTTZ8l49lVTys2NepsrkFiVxVZmIIm6qpqX5FC7h41ye2ThJqc+WH7eVyBOiXCeLtzZA13MiN9WYnhNAROQk=
X-Received: by 2002:a05:6102:3594:: with SMTP id h20mr15138757vsu.42.1629429547193;
 Thu, 19 Aug 2021 20:19:07 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1022.git.1629393395.gitgitgadget@gmail.com>
 <d51d0db6e250c118b2d0f6eff571e1a7642da00e.1629393395.git.gitgitgadget@gmail.com>
 <YR6v9yu3jpmRCZvy@nand.local>
In-Reply-To: <YR6v9yu3jpmRCZvy@nand.local>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Thu, 19 Aug 2021 20:18:53 -0700
Message-ID: <CAPUEsph3mAVWjJScpMrHObqAbmDnecc_e6K04cC2B6Q1NKqUzQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] test-lib-functions: use user's TERM and HOME for 'debug'
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 19, 2021 at 12:25 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Thu, Aug 19, 2021 at 05:16:35PM +0000, Philippe Blain via GitGitGadget wrote:
> > Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> > ---
> >  t/test-lib-functions.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> > index 662cfc4c3e0..86680b1177d 100644
> > --- a/t/test-lib-functions.sh
> > +++ b/t/test-lib-functions.sh
> > @@ -163,7 +163,7 @@ debug () {
> >               GIT_DEBUGGER=1
> >               ;;
> >       esac &&
> > -     GIT_DEBUGGER="${GIT_DEBUGGER}" "$@" <&6 >&5 2>&7
> > +     TERM="$USER_TERM" HOME="$USER_HOME" GIT_DEBUGGER="${GIT_DEBUGGER}" "$@" <&6 >&5 2>&7
>
> I also share some concerns about setting $HOME here (though less than in
> test_pause)

instead of changing $HOME the needed dot files could be as well linked
into the current $HOME.
this will of course need extra code and specific knowledge of the
debugger that was invoked but will be IMHO safer and accomplish the
same objective.

Carlo

PS. I remember once wondering what GIT_DEBUGGER=1 meant and how it was
meant to be used, AFAIK that and the first use case were always broken
otherwise, maybe someone who knows and uses this code better could
chime in.
