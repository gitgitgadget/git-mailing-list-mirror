Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BA6C47083
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 00:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2FE361028
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 00:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbhFCA3e (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 20:29:34 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:36573 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhFCA3c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 20:29:32 -0400
Received: by mail-ot1-f45.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so4171993otl.3
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 17:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0gocKYWc1WsVNPnJ7JCdg77SirorM5Ez2tOCtbpT0l0=;
        b=BOwVC618a8upY1opcJM5o4CmhQxYp+uLv6uVaUBdBdGF0vEkqWsKal91RYjBILyK1J
         TNG+BJQqao/zXpr16/4AzfGN3xOkgZNEzdIX+pwjt9diyxIvRyVaZlmgC5t0qmBxv+jB
         qA86FotB2+0UDeMHC5LTK6tbcVfcEqHeWRU4evWsQs51NHro45VXp+cz26VzKh89iIyN
         IGxCXFtwTVyglh4FLwtQ5JMCAaSEVk0bNu4OoqCNNS0XThtE1JZw/j/wIBFbHwjktXxf
         cSuUmLhrWtbhINTKzq1/vN0NmBbYXfnsTaK/rM17IbGVrSEafQy21RgT2qwRTMR35sPl
         1M7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0gocKYWc1WsVNPnJ7JCdg77SirorM5Ez2tOCtbpT0l0=;
        b=WAdkhYArvg+Yna0LoWvJY0qx1xJsXj9v7h10nIHsXQKlOYSmaJ738M0OZSbwPvRv5t
         o+BpijyCuQqoXZUrmAqJ6U/tT0UDyycG1TMeT7kTRcoUk5qPFs19IJCJTQf8uzTOgfXP
         TsPYJYyzdXrhlHQ8VKOjRNewjmN4PFJFmSjs05DrxlA/yWScMm1786PwOIN8EOiD8Avu
         Eq3iO3nUQdoAvunZgsgxy+XQ8JcyrYTFWhLGaZWSUyiXnBEUv10Yh+EtbDjxD6KnxH2R
         aVNm8A+WG/O/tPxWCJCHo8LLUYPiWo+I0pWVerX64NOwBIte23qsd+aXnoZ9d3PD5Ucn
         ATWQ==
X-Gm-Message-State: AOAM533ZiqHdi5gkXsptNjtQV0NkF/qu+rwUzdrRrza4ymWvVhwfO/r9
        E4B8CFGSnDvFVeXhBn7KYBaCQbJBVz+2pe8MQ9T/DY+e+NrsPg==
X-Google-Smtp-Source: ABdhPJwbvllf6f/n/+zHFClT6twL79TBAiGRsaDd2sB79x62N9yxuPIBVrZWjwDMPPTB+HZngoD4395bEUNn6F/8Qhk=
X-Received: by 2002:a9d:7096:: with SMTP id l22mr28421186otj.345.1622680008861;
 Wed, 02 Jun 2021 17:26:48 -0700 (PDT)
MIME-Version: 1.0
References: <60b5d281552d6_e359f20828@natae.notmuch> <87wnrd6wqj.fsf@osv.gnss.ru>
In-Reply-To: <87wnrd6wqj.fsf@osv.gnss.ru>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 2 Jun 2021 17:26:37 -0700
Message-ID: <CABPp-BH7f+sM_POEsSSvmz_p=oEzHQcvTk_cEhTGeb-yq9fq_A@mail.gmail.com>
Subject: Re: The git spring cleanup challenge
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 1, 2021 at 3:39 PM Sergey Organov <sorganov@gmail.com> wrote:
>
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
> > Hello,
> >
>
> [...]
>
> > These are the configurations I've chosen:
> >
> >   [merge]
> >     conflictstyle = diff3
> >   [sendemail]
> >     smtpserver = /usr/bin/msmtp
> >
>
> [pull]
>         rebase = merges
> [push]
>         default = simple
> [rerere]
>         enabled = true
>         autoupdate = true
> [diff]
>         algorithm = patience

Any reason for patience vs. histogram?

> [merge]
>         conflictStyle = diff3
>

Anyway, here's my list to join in on the fun...

[branch]
        sort = authordate
[alias]
        brief = !git log --no-walk --abbrev=12 --pretty=reference
[log]
        mailmap = true
[merge]
        conflictStyle = diff3
        directoryRenames = true
[protocol]
        version = 2
[feature]
        experimental = true
[pull]
        twohead = ort
[diff]
        renameLimit = 3000

(I have branch.sort=committerdate on another machine; not sure why I
was inconsistent, and yes now that I look at it I'm pretty sure two of
these have since become the default.)
