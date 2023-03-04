Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8DDC678D5
	for <git@archiver.kernel.org>; Sat,  4 Mar 2023 20:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjCDUhC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Mar 2023 15:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjCDUhB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Mar 2023 15:37:01 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF480126D9
        for <git@vger.kernel.org>; Sat,  4 Mar 2023 12:36:59 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id bi9so7915854lfb.2
        for <git@vger.kernel.org>; Sat, 04 Mar 2023 12:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677962218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7CRbgaPLPczXrDyzRKVDFhvEBq/N2oQh8QFLvAccLOI=;
        b=Is9orLnI7+7JJSRm5UZ/7VyG+YNXjPmgAatFXxiTeAGUSF+omdq/6doz9D5zM0Fdr3
         V2rRXFBPNAIIJ18S5AfAe9aofsJ2omhTRtwCfvsnGMNlmE9IKcuoBnjRw7VJDjW8o7zk
         8XuHBPpeNB0oBHXEpetNuoi5aG75MhT709Lq373chEpOlEq1uN9jMPgXv+O+TIkXxYWs
         dVIxMloGKK3NbvHSzIv9NKCBmozZVLAmfFL00aLBiRchw4JgXraYGUkj7SSI/HkI9Q7Y
         lsVa+QR9jjdzxC17xI9qjXwC5z4mSuxctLQTpD2cP289/hCbE/z3l4U/KGWobYxQG3Tb
         u10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677962218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7CRbgaPLPczXrDyzRKVDFhvEBq/N2oQh8QFLvAccLOI=;
        b=Q+p5RUvysopsDE/8B2eVpDfMq86U1nJYze25Ousbyp4Rde5DMwvjIqUsELkR+bmpGA
         4M3gZK6NyRBfSAbBBoUaPsw2yy5xyhFfu2tdRItfE4AnvrYCY5blPYbgldSji91VtkXt
         kJRODosTq1exMWw47rbXowq6qAtZmmDAFyR69hsrqpAsKn065hKWkseQyg2+8IroJWQn
         SCrrOGQFPKvtXccftB4zozZJZ3zE1OnzGcjlWjGGxLi9A7u/RdRX5RxalkglYm2u3UB0
         vl3kHHz7YMt4Ho3zzr4bNBy2XELTf07FYxG01c+sDtiAZO0D2XJ6OZsB0vGzGkvXBhpn
         7B6Q==
X-Gm-Message-State: AO0yUKW03lguRai2XXG765B//4rsHdubhP2UIu2e1c9wwT3qF5K9FkcH
        3c/dj+gblyMLWaSl5v9hSlvrmr4wKAddCTsm38gH4DB+Qwk=
X-Google-Smtp-Source: AK7set/YeDObNfQB5MyG09mzJNrHB17E3gk9JLNxSK8AT99EDTkJsLuOsw5Np2M8zIWLJzeBkQM/0bE2xfQctVBHUyg=
X-Received: by 2002:a19:c20a:0:b0:4d5:ca32:7bbb with SMTP id
 l10-20020a19c20a000000b004d5ca327bbbmr1832506lfc.2.1677962217918; Sat, 04 Mar
 2023 12:36:57 -0800 (PST)
MIME-Version: 1.0
References: <20230303145311.513960-1-eantoranz@gmail.com> <xmqqcz5phjgz.fsf@gitster.g>
 <CAOc6etb9pCXx9S5jxk8Yex++_iai21THU74qdXmOm1XxjHx8Lw@mail.gmail.com> <CAOc6etaCz=JWPnk2Jv8KYG02xBN+jZG1EfbnwtKnq_A0UBUpEg@mail.gmail.com>
In-Reply-To: <CAOc6etaCz=JWPnk2Jv8KYG02xBN+jZG1EfbnwtKnq_A0UBUpEg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 4 Mar 2023 12:36:45 -0800
Message-ID: <CABPp-BFCNjMsxAcLOxr_9Rnu3n_KL5RMCfD_m7ytS+b_gbd3Xw@mail.gmail.com>
Subject: Re: [RFC PATCH] sequencer - tipped merge strategy
To:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 4, 2023 at 3:57=E2=80=AFAM Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
>
> On Sat, Mar 4, 2023 at 12:45=E2=80=AFPM Edmundo Carmona Antoranz
> <eantoranz@gmail.com> wrote:
> >
> > Usercase can be at the moment trying to rebase (with merges) on top of
> > an exact base copy. In cases like this, git just crashes on merge
> > commits. An easy example:
>
> I should have said _crashes on merge commits where there was a conflict_.

Crash tends to mean the program has done something not allowed by the
operating system.  I don't think that's what's happening here.  Do you
mean Git stops with conflicts?
