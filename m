Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B51CC43334
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 19:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346215AbiFCTnu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 15:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243277AbiFCTns (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 15:43:48 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89DA1C930
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 12:43:47 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id r82so15448781ybc.13
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 12:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h8Myi//0apTZh/vmv9DGPMf/cqgOizD5ce0PFmNwm3I=;
        b=Gl5o35CknA2ihIzH+8v2j10Sh+U4XbXVwydcZW7CNxxzqKzM4nhgt+xc6kCfmJx+/0
         GgOzcDKbpathKj/KeKUedtw/N8EUS8wxS7OQGDJGxWhPiwwstG5aDagCqkFXheUV9Fqz
         jjBxKCDRD7PLGGMLCx53z9Dgy/EwO4caWlTUr8ddWEpllvxLGrDMumWqGrFkPnpFGkEJ
         FxFiXoBDdwkyeWWh8EiWqZa3Yb4cSPjlLVqc/ccmJvgcKiOVXZ5MkDbQIhKDHQytIExI
         wpqLMokd5feYrtTE9JsvuyL4a0cJLBRvGsbVZo6Z5HbjEGpJBZI0J9T9v5A2TP2Vn8YH
         RQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h8Myi//0apTZh/vmv9DGPMf/cqgOizD5ce0PFmNwm3I=;
        b=bfCkcDenYUhHc56vOAr53WcqQZ/knxmUEc/qlTPt97inaSSH3zLnmv24OjdQvjaMLi
         Ug4JKlgWVXxRfD3WNlAArTJ4rbTkR6RdlzYxHXQdkdO9mVyXWq5KO0gTPdbq//6Bycu9
         EXcSV/n9qqA04WZC9SFc8I53AnukaapjpYF5devr1NpSmlt4uiFrCMY3lK61QvenZZgH
         yKh5nBgEmCd3g9ArFfwfL3GZe30/DXtqDrOOEgG5HEwwRyDnW46AXCZQ2M9qhVnOAwX9
         ix0t5ASbUmT8myS6RYQDHvUN76nNiVS+4moWTThyuFspmWOtnOHptsC4nFvUjxxxERTX
         RDQw==
X-Gm-Message-State: AOAM5328GxBgDaaqILphH/tw0tojur2hOMCQ75jokCNbm7+YW8EKpaXe
        W2GZ+p6wyMYGmLx1Vq9lbfqSPXfxuGnL3AypT7Y=
X-Google-Smtp-Source: ABdhPJzP8FtYBi5gezoJlveXLwyd/IPVUqjbNMxL7SnnN9LyE6GzcvCcM4pFpo2HyDihkJYreeYZjksJcjTVlb6obgk=
X-Received: by 2002:a25:9904:0:b0:64f:f06c:257e with SMTP id
 z4-20020a259904000000b0064ff06c257emr12144299ybn.438.1654285427123; Fri, 03
 Jun 2022 12:43:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220602145935.10512-1-joak-pet@online.no> <20220603142521.42863-1-joak-pet@online.no>
 <xmqqy1ydhfcc.fsf@gitster.g> <7d391d82-b15e-4a31-5207-c4037fec0bf9@online.no> <9fa34f22-3404-7bf8-6985-642c80634bf8@online.no>
In-Reply-To: <9fa34f22-3404-7bf8-6985-642c80634bf8@online.no>
From:   Justin Donnelly <justinrdonnelly@gmail.com>
Date:   Fri, 3 Jun 2022 15:43:11 -0400
Message-ID: <CAGTqyRxkiGt7CRggV7VeXNRK2VmDMxDX3EpOr5cPcc5AdH8ZaA@mail.gmail.com>
Subject: Re: [PATCH v3] git-prompt: make colourization consistent
To:     Joakim Petersen <joak-pet@online.no>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all. I'm the author of 0ec7c23c (git-prompt: make upstream state
indicator location consistent, 2022-02-27). Sorry I'm a little late
jumping in. I was also going to propose something more comprehensive
and future-proof than what's there (adding the applicable color
(including clear) to all the indicators), but I like Junio's idea
better. The only other thing I have to add is that it's probably a
good idea to include a comment in the function
`__git_ps1_colorize_gitstring` explaining the design so future
developers/reviewers know.

Thanks,
Justin


On Fri, Jun 3, 2022 at 2:52 PM Joakim Petersen <joak-pet@online.no> wrote:
>
> On 03/06/2022 19:23, Joakim Petersen wrote:
> > That does seem like a much better idea for maintainability, I can
> > change the patch to do this instead. I have one question, though: the
> > sequence $c$b (bare state and branch name) is a special case, where
> > they're intended to have the same colour, should I wrap both in colour
> > set, colour clear, or only clear after $b? The former requires rewriting
> > the tests or changing $gitstring to not include $c when $c is empty,
> > while the latter keeps the tests unchanged, but may pose a problem if
> > "BARE:" should at any point not appear immediately before the branch
> > name.
>
> Sorry, the former (colourizing and clearing $c and $b individually)
> requires rewriting tests no matter what.
