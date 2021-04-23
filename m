Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C388CC433ED
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 08:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EE35613F6
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 08:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241361AbhDWIft (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 04:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbhDWIfs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 04:35:48 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2997EC061574
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 01:35:12 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id 2so24273387vsh.4
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 01:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PoNiDq48ZhDxZRL0BSbsPJHuP/dORAu9eCqWT7ZJj0g=;
        b=nhLFjxZY/WDzYJ/dlkLmvBQdaTJEBhqox+Zjbs+L5riDB4Dg9f4zSsTbgR0rqAWrQN
         XCgQlp7M+hOOFUOtgB8oW9kYESbVmD8BlwvrWQJseIFmqaTCJGyBr6qjtLjJC6Y+e3w8
         F9Me5Pt3Im+QZ+oMwrfJKQhuNexjEZ92hkSc7jdpkCisFHCeYRvg5ytazvUP996cQd5y
         RxwO3AQVZQfI1N2xVpkZ6eKZmPAIoef/0/NA9sEp6sZPVFYKexSnRS/v0QufXmBVvU0t
         1jIadcB0zzmJtLux9PBnMTwHTktmW1XZCY/Rn0+JKvJVo0UOBgIS0fJ4mQBOMV/JcuMi
         SZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PoNiDq48ZhDxZRL0BSbsPJHuP/dORAu9eCqWT7ZJj0g=;
        b=kQocPE0Szano/03QZyydhguwtPPqhZdtbRH5LRiHFW8/zIjaNKZqCruyhoTIJT34YM
         Kv6va5xTwL2cYZnuY9SY9E6cnH0Zxc5Y9ZmxmOhrN99KEzebqiM3zubpOLbXwpEZEOQo
         iqTp6RWMpA74PDy4lUI8yu7E+2pgQ92CgJkmeljO4KnxfNtiK6+no9GrSo9BCi5rtTEB
         9DNwz8jtPB4LfDYRbHDzU9UfQUL61Y71vxmCK0x4gT0y7+xyx1Qh53BhJhA3GQKG1+Of
         sjUg7TfrRolrRG5z0lLi88XDzObB+vq2Nt0UFikNZhtpWqJ5BwB4oQSjgsUlMzlDIsnC
         liOQ==
X-Gm-Message-State: AOAM5303PmCQ1fd1c06dPYqOVt25P3GizofDz3Gk0LknluJXeuda9uQe
        1vKoq6EStkji5zIPV0oxuSr6p2fVpbC2Q5E6D4F7zQ==
X-Google-Smtp-Source: ABdhPJzdr2pCG+TFSi8+H7IdTO+fLDzcRJEo1iNZy1F9jODeOs5dO2f2xqq8Hd34UXk5qDDEAnNvpYdXnop4Bn5VmLo=
X-Received: by 2002:a67:7d42:: with SMTP id y63mr2396415vsc.5.1619166911246;
 Fri, 23 Apr 2021 01:35:11 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1002.git.git.1618255954484.gitgitgadget@gmail.com>
 <xmqq4kgbb2ic.fsf@gitster.g> <CAFQ2z_MnZOfo4Bt6SsRJnL+F70r9wr_jYSf2KGvcvyX-8PfVRQ@mail.gmail.com>
 <xmqqy2dmkkvo.fsf@gitster.g>
In-Reply-To: <xmqqy2dmkkvo.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Fri, 23 Apr 2021 10:34:59 +0200
Message-ID: <CAFQ2z_PhkOEnKNFZ29R5x9rttO+3POT8Tdx9stcQ__oNG=wQsA@mail.gmail.com>
Subject: Re: [PATCH] refs: print errno for read_raw_ref if GIT_TRACE_REFS is set
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 13, 2021 at 10:08 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Han-Wen Nienhuys <hanwen@google.com> writes:
>
> >> I do wonder if we want strerror(errno) instead of the number, but I
> >> can go either way (it's just a trace output).
> >
> > For tracing, it would be most useful if we got the actual symbol (eg.
> > ENOENT). Is there a way to get at that?
>
> I do not think there is.
>
> And that is the reason why we see everywhere calls to die_errno(),
> error(..., strerror(errno)), etc.
>
> As this is interpolated into trace with untranslated string,
> I suspect that strerror() is not a good match, so let's live with %d
> for now.

Great!

This topic is marked as

Waiting for reviews to conclude.
cf. <xmqq4kgbb2ic.fsf@gitster.g>

but I don't know what is left to do. Oversight?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
