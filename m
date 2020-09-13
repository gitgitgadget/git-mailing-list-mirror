Return-Path: <SRS0=WTnS=CW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827C5C43461
	for <git@archiver.kernel.org>; Sun, 13 Sep 2020 14:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3634A2151B
	for <git@archiver.kernel.org>; Sun, 13 Sep 2020 14:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sog3GqTh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgIMOsl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Sep 2020 10:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgIMOsj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Sep 2020 10:48:39 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B8EC06174A
        for <git@vger.kernel.org>; Sun, 13 Sep 2020 07:48:38 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id i1so15128864edv.2
        for <git@vger.kernel.org>; Sun, 13 Sep 2020 07:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WsWvn1LMV4zIwe8hRRVHyyCgJKiipHtHsHQua9Azxwc=;
        b=sog3GqThF0MCDftAsK1g/VUrO9Dksz88hXMbSTCYV6xtv8tNJ6FgOd5vYehIAo00Dn
         IGCA0yMRVG3EAghzBtiYgfUPR7KWw41SL/fSoLse8vB3U6gPf9jbdvKP1Qn49kFRbP/6
         c51OJaLzhKIOLQNnSSBtLe7qQ0Ck+2EbRqBWyk+Fq0+xaIAjajeiwuTBVxxIHEuztBgc
         /TNU/zyyOA+NyshB3KWlcwTvmJjG5n/QBSQQRCXnLDPCVX0qvc5c2yA1YsOgPul8GYg+
         ejgm4hsgwQZMx2g7JwixDasAowjzVdoNy0kHYC16vAHr6QD7m/HRKn4LqGwaDpGoWpqg
         AtSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WsWvn1LMV4zIwe8hRRVHyyCgJKiipHtHsHQua9Azxwc=;
        b=DRpNX2zuK4epQ1idgGmI5sCsQFDraHzPM4jVEXdG+rPDlTt+pCfjCmIT7I7NC4IiOF
         pP+5gbAc3Ls6hKAIx5iFaxLCgLb+Lfqd4X6EU8eiQeNLi2VQwwNiIjL4dxEewa+7huy5
         LpEh6pxGlUoi0zl+nkf9QZfGL8Y6OWF2tVww5XeFhj+h1a+TneUTqw9IL6xTLUP4ypAJ
         sLzeYDptAwHMJ7HZTzgE4jZLeMZmc2oxwAhsuJaK0Hai7JN2DVxffG2fN/fxafIJkl71
         slIdz6E6lf7omWpQD64eSZ8n/bwDBWRaxAYAOs9MdQcXlRE0XY9cHAnSp1mEC74MNwtq
         esHw==
X-Gm-Message-State: AOAM532jV9SmoRG/5ieey7U7olGSEJ9QgIaCYZb34TYlvs1NV7kolvEz
        IqQgcXzx2LPC9/3qTr493O5vLN2MS9liRPFJHpyzwvLiYyA8VQ==
X-Google-Smtp-Source: ABdhPJz5KABU9iiVj65oCbyC+8/p1/MBaZQNLBVenTUMXZdfy8EfTLO93TX6syIt1lRhdig07CF5rrLAM3v9VUTx3dE=
X-Received: by 2002:a50:c8cd:: with SMTP id k13mr13112263edh.387.1600008513639;
 Sun, 13 Sep 2020 07:48:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAMk6QYPgC1ch_umvGvYRa8F97iY6ynO-ApYC8zHwGzPY3TauDg@mail.gmail.com>
In-Reply-To: <CAMk6QYPgC1ch_umvGvYRa8F97iY6ynO-ApYC8zHwGzPY3TauDg@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 13 Sep 2020 16:48:22 +0200
Message-ID: <CAP8UFD1kiqJATVSnFSWueVR7ms=SVr=9UJoYQPp0+4ZDTKknXA@mail.gmail.com>
Subject: Re: Enterprise wide Git commit signing
To:     Ethan Rahn <erahn@arista.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, Sep 10, 2020 at 9:19 PM Ethan Rahn <erahn@arista.com> wrote:

> My name is Ethan Rahn and I lead Product Security at Arista Networks.
> I recently completed work on a project which I wanted to highlight for
> everyone on this list.

Thanks for the news!

Maybe you want to add a link to your tool and blog post to the "Git
tools and sites" section of the next Git Rev News edition:

https://github.com/git/git.github.io/issues/455

Best,
Christian.
