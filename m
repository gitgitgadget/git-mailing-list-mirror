Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19333C2D0CE
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 08:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBDA92071A
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 08:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="RD7uCUm/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbgAXItV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 03:49:21 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:41501 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgAXItV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 03:49:21 -0500
Received: by mail-ua1-f67.google.com with SMTP id f7so515090uaa.8
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 00:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vpBP04dFn4llf/u1szAudmrqfDNm7haRlJ//qHjqpUI=;
        b=RD7uCUm/lSu4Drh1ewE/b6gMKtc/8GyJHY07CqGdzwS5g32cxlczdyCxgOOV3guhrI
         tSEa61LiJGn40ankA8S1D0sQiO7bUIDQku+7hZnnTOUSplaISwqkwGkPjCH/AUHW90B7
         fg0ltbPCjoaja/lVc3gzPB1iKzFkNUd8VSvUx2NoWRLztmWVEDntKyPDX7/KWsLiyNS6
         qbztqo9blNWUlcge8SI1L3lCG30UYlrfmJTQGwiGOcEvMn1LVDFX+gvyfzZHEkoPEysb
         dJYduVhBqZulUbBlBPymt6owkhLOi0S9UcXIWGUx2P9jbjJibwVyvNvob19KYQZnMixj
         OR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vpBP04dFn4llf/u1szAudmrqfDNm7haRlJ//qHjqpUI=;
        b=m22ZDM0GTcHVokS6LgEOLQmJA8b0Al4SCJ5wxeiGpE17ZbWBDSFnP8KovxtXf2JQYm
         oGvN9IIpOrzquSjCjkHTDKh196mubWZFZJwMOwukCkG/62ZbLCE7dqoQX43GzkYj9p/w
         kNKUdLrC88Y0SNWqkpz3kYnW7tVt9EaD6mXQw3icS4AgRNpf9YZxep8CwQoGChKthGTZ
         lnwqmQE1wZo2MabLGLAwT6/xnyqHAnjEt+TCLlDpJTUmvZ1XhJrD8TAQ9/zYf9AkTlOm
         MoPEn2PYYfs3jHtuIJ+Sd68DjH3VG/bJwf3ZgOm7s+nMg/q2Ts5h88MsYmHN5v/sH/LU
         k71w==
X-Gm-Message-State: APjAAAVUo367adKCCi96V/DsleaXS96l84ObMUCY8IACRlJphqYiYOiE
        Htar3oBxI1TEg3S1UZyZvj3k49mPUw6erA55VRg=
X-Google-Smtp-Source: APXvYqzyaEYMPCHP4K+bYkinaGggJa39NUX3kLd909CtJ76joGOpoHyEOb730WEXOrRstMYnYO5fvDSILgat6U/N+Og=
X-Received: by 2002:ab0:7219:: with SMTP id u25mr1208105uao.10.1579855760247;
 Fri, 24 Jan 2020 00:49:20 -0800 (PST)
MIME-Version: 1.0
References: <cover.1579598053.git.bert.wesarg@googlemail.com>
 <d10d3049ce9824f6925dddeb12cc130627a8c478.1579598053.git.bert.wesarg@googlemail.com>
 <xmqqftg53hdm.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqftg53hdm.fsf@gitster-ct.c.googlers.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Fri, 24 Jan 2020 09:49:07 +0100
Message-ID: <CAKPyHN3F-c6Uy18PMkZ0YpwngN5HMMZtM3pma_Vj-WXVtvFuxw@mail.gmail.com>
Subject: Re: [PATCH 7/7] remote rename: gently handle remote.pushDefault config
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Matthew Rogers <mattr94@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 24, 2020 at 12:03 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Bert Wesarg <bert.wesarg@googlemail.com> writes:
>
> > @@ -746,6 +769,26 @@ static int mv(int argc, const char **argv)
> >                       die(_("creating '%s' failed"), buf.buf);
> >       }
> >       string_list_clear(&remote_branches, 1);
> > +
> > +     struct push_default_info push_default;
>
> Likewise.  decl-after-stmt is not allowed.

thanks. Its time for a re-roll.

Bert
