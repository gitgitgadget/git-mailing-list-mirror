Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A8CC433DF
	for <git@archiver.kernel.org>; Mon, 18 May 2020 11:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72F40207F5
	for <git@archiver.kernel.org>; Mon, 18 May 2020 11:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sh2UxeBw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgERLPi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 07:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgERLPi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 07:15:38 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121A2C061A0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 04:15:38 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id u7so2042890vsp.7
        for <git@vger.kernel.org>; Mon, 18 May 2020 04:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sPtECUQb5lV7r1/JASucMpYNfztHZlJsKVfOCHfZ5+E=;
        b=sh2UxeBwFLDVjLPSn73+NuzPkfI9+gKdZcADq8r8OGn9cOMReqkOiFwNrwwPG7J+s/
         ZiXV+3Gn04DxlZDRXgrJ3p5q/UY294QDYFVpcX4uiFR9gItBGZFbcrbdSvQX5CuUZC33
         d12Bx7qMhxigze8qc9Pn1+QXNr6n7JaNlCawGmvnC6/gz2hdmBaGPm5nkzWGr6yJQG1d
         3XoxNH322ddY9sUw/+u+i5jKmC3McodEPbBDVvRUMGZjcAVsBfTr9Y/iMt0L8UlwGsaW
         t66V3KyxghIvuCFGkFCKnJazv1OWdSciEjjQwdanwZGzL6jVLwVbYABtM36uE77sWCbX
         bOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sPtECUQb5lV7r1/JASucMpYNfztHZlJsKVfOCHfZ5+E=;
        b=YBOM955d3x0xz2rUw9BTt/OHqLMg5phZwVI/5ubAH6NhV4rkvjvUe1w6NNRi01Ujz3
         cC/8M4auP6BbeQjwJNSqV0hgdETwp43fuf8tdWUH6EniCak3KrZ8nzDaDTrsl1HxYeCM
         42BrSC/Ncy79/nyetaj7TBK0JsAaRXc7hoAiWgTNFbz2XE1jNSJkt/1TuObtqDKwBMTB
         +wLBbvRZwPqVvVk6+xtB3Q0tpyDIhC+xYiRhmBegBTA1MgnaTQ3OYmIcVtxevVqyKBxz
         6RUtdics6wOZijSVFAtGaYVqP6CZ1PcXhY/TTuJ9PsIBTDtsBZ0/oNHTf86aTAVX0/lJ
         VF4g==
X-Gm-Message-State: AOAM530cAlGxs8XHTTvedLzG9+B8EKpY+lfr3o20xNTOEOSvViG99lsk
        FnZ+2jC0onXLX7lW+n9MVXP+ty62SMJ620PAxB6d7CW7
X-Google-Smtp-Source: ABdhPJyS0V0Sp0TwMwBcdMu3OhsdEvtVBltz/M07ESEXaipEe4nOrNk8NSrZMy1BzdrtJ/mvuhMF+WlKSkZOGcf3hHw=
X-Received: by 2002:a67:f1da:: with SMTP id v26mr3125307vsm.46.1589800537058;
 Mon, 18 May 2020 04:15:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1589739920.git.martin.agren@gmail.com> <4753804d23ba7b1b267b6557077c80f3a8891712.1589739920.git.martin.agren@gmail.com>
 <CAPig+cTMrdeBLzUKKpkuZgSbXULhQb4epNC5qMMTUgqfZ1a0bA@mail.gmail.com>
 <CAN0heSqkGnYpOvzym+fv6_2_791j6jRwyWMpG9hG4H2KfY6BRQ@mail.gmail.com> <96735cc6-35d6-f94d-75d5-d6d4df1aefa0@gmail.com>
In-Reply-To: <96735cc6-35d6-f94d-75d5-d6d4df1aefa0@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 18 May 2020 13:15:49 +0200
Message-ID: <CAN0heSpu7yjB0aJRuRhU+dncDryTRkMq4+B_D4BHBav5YoD1gw@mail.gmail.com>
Subject: Re: [PATCH 2/7] git-bugreport.txt: fix reference to strftime(3)
To:     =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <avila.jn@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 18 May 2020 at 12:54, Jean-No=C3=ABl Avila <avila.jn@gmail.com> wro=
te:
>
> On Mon, 18 May 2020, Martin =C3=85gren, Eric Sunshine wrote:
> > On Sun, 17 May 2020 at 21:23, Eric Sunshine <sunshine@sunshineco.com> w=
rote:
> >> On Sun, May 17, 2020 at 2:52 PM Martin =C3=85gren <martin.agren@gmail.=
com> wrote:
> >>> When we say "link:strftime[3]", it ends up rendered as "3[1]" and we
> >>> produce a footnote referring to the non-existing
> >>> file:///.../git-doc/strftime. Make sure we use gitlink, not link, to =
get
> >> s/gitlink/linkgit/

> > Oops, thanks! At least the diff is correct.
>
> Not even sure of that: strftime is not an internal manpage, so for html
> target, we will end up with a hyperlink to an non-existing file
> strftime.html. So I would keep it as simple text.

That's a good point. I don't use the HTML versions myself, so I haven't
thought about the *linking* nature much -- I just see the formatting.
But you're right. Grepping around, we only seem to use linkgit to refer
to our own docs. So this should probably just be "strftime(3)" as you
say.

Thanks,
Martin
