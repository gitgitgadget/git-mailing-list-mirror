Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A77AA1F731
	for <e@80x24.org>; Tue,  6 Aug 2019 17:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387432AbfHFR3P (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 13:29:15 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:42611 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729898AbfHFR3N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 13:29:13 -0400
Received: by mail-vs1-f65.google.com with SMTP id 190so58830836vsf.9
        for <git@vger.kernel.org>; Tue, 06 Aug 2019 10:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KPJQTYmOevglELLu2B2FbKvFoBBTsbcdrDQVMYMzyfk=;
        b=YXhnGtenXXjZDzE5I8A4dVNiOQIBgXQf69Vq5jsIDOguKYgGpT4wObl5QoKj1LPmus
         XdtaDEEYDl8mTNAn8wJqEev0CnOeDdOvEqP1C6GPo45CNxdHSh2poRTHPm/ukelRNt9J
         7WjmrRX/rNaX74/MocH8u05N2OgCVgI28S4yFuBvWRPfRk5rfsfFg4hM/xJYZLwD0Sn0
         u217QuHMKdNCaA6fJ3wJICLzv35/Hrfe8gVoCwnaYzPKTAkDUuFrfsgIPer0e6TGU+xw
         Q5oe7D6kmlyfBWA0OBJ4Hbiz6fTtNnpNFpk7Rvad5e3tWOV9EgrstxhcTNm/nsFlV100
         zrGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KPJQTYmOevglELLu2B2FbKvFoBBTsbcdrDQVMYMzyfk=;
        b=GQMt5v3A/u3aPIv4fju9HQyB6cDzGtM9Lf0Z5WceuDnjs7FARNmeHIlKUQhHZghipT
         xKlt6PdV4xwAVZLbvbzAgsV7/pxIwkgl5ugQulHUy6QH3qgsMiE0lVT3m06TfAxqGXB6
         clQUFLJifMIg8TRmv0p2ctCUZ++Mufbd9dk6gOdfPt7bz6fGidbL+6eVZRI9Qgn7ZSjh
         41HLRyR5nIBKMXV3oL87Uj0Ye5p6IBNpk1b7/lhZyG5cscjQwifizBfdI6M0DkRqGtaH
         vjG13Txj1MrRAadxODxCQkCtWQOVFz1FGbv9FtmR/KFUi7UjG9uoo7vZqUfWQYLVSrhS
         rQhA==
X-Gm-Message-State: APjAAAUXVKXA15TEycYLlVuBGgjZaYwQzqjhP6ugXbv7amSXz4PYHt6A
        PlPh5kr0fkniYBH19pYFkX3irfpOjYqRWIGnNvc=
X-Google-Smtp-Source: APXvYqx5+4xateQyLWCC+rByo7CzgiC+RPYEV6vIkKw06A927v6cFYCxVOO253Hi6orVfmWaen/uD5nLUIqlROGHi/o=
X-Received: by 2002:a67:8081:: with SMTP id b123mr3206555vsd.117.1565112552694;
 Tue, 06 Aug 2019 10:29:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190726220928.GG113966@google.com> <20190805223350.27504-1-newren@gmail.com>
 <xmqqwofqjjdh.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqwofqjjdh.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 6 Aug 2019 10:29:00 -0700
Message-ID: <CABPp-BEW4C__h+MVibmSNz3n3CaVDeDOxxYSfTgXj5NR_HfULw@mail.gmail.com>
Subject: Re: [PATCH 1/1] merge-recursive: avoid directory rename detection in
 recursive case
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 6, 2019 at 10:26 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > I know this bug doesn't satisfy the normal criteria for making it into
> > 2.23 (it's a bug that was present in 2.22 rather than a regression in
> > 2.23), but given that it's a BUG() condition, I was hoping it is
> > important and safe enough to include anyway.
>
> For maintenance and upcoming release, a safer "fix" to do might be
> to also (in addition to this patch) flip the default to no to revert
> to the stable state before "directory renames" was introduced, while
> still allowing those who want to help can explore the right fix to
> this codepath.

That might be a bit more jarring.  Directory rename detection did not
have this bug in git 2.18, 2.19, 2.20, or 2.21.  It was new to 2.22
with the 'conflict' setting
