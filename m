Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FF0C433E0
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 958A664ED1
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbhBXT2l (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhBXT2j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 14:28:39 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA3FC061574
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:27:59 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id d9so3245882ote.12
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FEWQYaeDFyhpPAlrzZhKom9et4N3wGZ6Ka30ivsaZkM=;
        b=ORWjXyFkKFjUK+RyU7oqyPj0h0l0pewSHMyfMI4VeBogJO/aYSRWjxZWECeCHNNoeY
         GEADRWUV++DQLs/zQr/y4JpRNGlYpSl7SPDtjnPbQRRopx3Xl8+2Zwazf1NnMrxK0/HG
         dDLpDJKau27FvMYhfRwEOnWKtDQ960E2rYl8Ym7mgR5K9eiU74m6Z7nmDoGCPI/SzdEW
         Qq3tWoT6bxRpPuv5hBN/phq9xRdDel44g26WShK47k0vED4hyPTo6q3OPRt7ofsblTe7
         SsJdPharIoC4R+MthVeux01B3JOt9AKZEITjHpML3SEPgBu2oPBwB5aJNdUh0597pnZw
         iqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FEWQYaeDFyhpPAlrzZhKom9et4N3wGZ6Ka30ivsaZkM=;
        b=UgDf1gghgUpL7sJJAkT9918yNEqyYGlYe0AgJ9JQ7yWVfI8p6c6AbxbL9d5Jez7dCW
         YJTvKA5RU9izw7Ssl0TkAhMw81vZ6k41KR6gvXprqHi3QvnQDbQ2CmN82wDj2j27e+L4
         W+XkK0+X1heln/ftmQxBv5o4hZ2kzocpiBWHUnX+kZiFeN8d2f5IMz5KjB/Q5M+3Jqvu
         qVClKYlFZ6Xl9qiujzD6mT9RXKT7KUuCYvuYp1fMyqWt0weJXY/MnisPavUcLStVcwcS
         kodAHAeXlYQqKZr9rb0RtfwdHPOOcGZuuuyzYAccPvXCcwqDZVUIC/Y2AVNQOmKyI7L9
         pktQ==
X-Gm-Message-State: AOAM531ehpN87AIl6kTP93/291xXBMlbM0T+rjTWHtLKkmKGVI2lcu8C
        tu2f6MSFAQhfO8OEMs0gKQC0K45Xrg2jjwh5FDE=
X-Google-Smtp-Source: ABdhPJxJ9YWOF4U3JLWGY45d6MkQ5x7MAfvZV771YXSByzN0fxK0qCROFypE5U1U3VeT/nhYRo4FRvUZ0RfqgBjG0Js=
X-Received: by 2002:a9d:7459:: with SMTP id p25mr13829948otk.316.1614194878462;
 Wed, 24 Feb 2021 11:27:58 -0800 (PST)
MIME-Version: 1.0
References: <AM0PR02MB4081D3C17C53DB5CD9021C5E9C9F9@AM0PR02MB4081.eurprd02.prod.outlook.com>
In-Reply-To: <AM0PR02MB4081D3C17C53DB5CD9021C5E9C9F9@AM0PR02MB4081.eurprd02.prod.outlook.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 24 Feb 2021 11:27:47 -0800
Message-ID: <CABPp-BEKDOSac29vix0xsemYdBDL6h47TwFd+Q=sdD8_HDYLJA@mail.gmail.com>
Subject: Re: Ort-merge: What does "ort" mean?
To:     "Kerry, Richard" <richard.kerry@atos.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 24, 2021 at 2:17 AM Kerry, Richard <richard.kerry@atos.net> wro=
te:
>
>
> It's now been quite a few weeks, probably months, since the "ort-merge" w=
ork has been going one.

Years, actually.  See
https://lore.kernel.org/git/xmqqk1ydkbx0.fsf@gitster.mtv.corp.google.com/;
you could argue the work started before that or after that point, but
it gives a rough estimate of how long work has been ongoing (with
several stops and starts along the way).

>  However, I don't think I've ever seen an explanation of what "ort" means=
.  I know it means "place" in German, but that seems an unlikely usage beca=
use git project generally works in English.  I don't know of it as a word i=
n English.  So maybe it's an acronym - ORT.  But what does that mean?
>
> So, can someone please say what "ort" means?

Already responded down-thread so I won't repeat here.  :-)
