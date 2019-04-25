Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B3601F453
	for <e@80x24.org>; Thu, 25 Apr 2019 15:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbfDYP6B (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 11:58:01 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:47057 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfDYP6A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 11:58:00 -0400
Received: by mail-ua1-f65.google.com with SMTP id v7so130291uak.13
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 08:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3ug6x7KNjDXijc++BL6lvamPnPqhFnK6MZaSU3v4o1w=;
        b=BJQNFoaCyEgxFo1C+JiBj1LPJ/G5qP2lL8dQZmHQb7hrL6Pw07X04dUNWqvDCuVCkh
         zQDWtrc+xOJeO3GURo2QwP+Rlvq9DLaMQp3/dsxe8vxarCLGtXfeEcO8zMiBP7Ll2S7/
         9ShQN7C90GipCA6xUpfVSRRFwXl9Dxo0UZ41wPDFMrSTZtO7XeS9Ss0+8DKNmn6+Tlm2
         ArWlUJ9x2i/wCD1zJgTcy2m6kdEqvehQXSvR85BDmi/dVeWtSRJSjfQZr9WEFh70KVjQ
         PQzORxSeE2ANhALy1mj5t9mSRa/JvbZ0Ii5uSsuhakH/8L5SO4OBRevdvHF5VW0yQEo3
         M4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3ug6x7KNjDXijc++BL6lvamPnPqhFnK6MZaSU3v4o1w=;
        b=jhYEaLZqGT5Ln2Hf+S8+VCmIRsmuvx2vBcG21IhjcnemiS6ymKDpC9xDsn00oaoNcq
         FmwKgIeaN9TY/DLzsw/HaFOT+QnQRvUeoyuD7wKVEO6Draxs1hH5KTt1GyaT4oG5feyN
         V9eSuwsOcNuhjySi12JT2kJDPS4l/zuHkgWnGZ7XEKQUYmJoERjiBuBPZ33ZzyBiA9ES
         qC5vnwUwGCFS5azT/xegUQc+DPhZtPvBZz1JklG43r6m8/TRo85p+BXyVau1P9mGrN8P
         23x7Npz2meeGHjWg+Ptdz4g8oG488YAcAGFZyg1ZcMxmHmfgHW6AD6kyACrJFO3tVt9V
         2kgg==
X-Gm-Message-State: APjAAAVpRPLTsmgUw33mVesr4HNtoYXWLyWfZkjzx1kZvA/r4HtJJEP+
        9LtY2ynh+plv3iQPMaHh+SpITFiy8hCKHCaagvznZA==
X-Google-Smtp-Source: APXvYqweYX5AfgEb8ly17QApChPkG4Y0nawq8byXEqIgkQdHF1meXb8SVixa6ylAzB/zyddcQpZBk2145y3MdX6/pLM=
X-Received: by 2002:ab0:3058:: with SMTP id x24mr20558183ual.95.1556207878555;
 Thu, 25 Apr 2019 08:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190425155118.7918-1-newren@gmail.com> <CABPp-BEsSpFYVto2E998n-UUwD6UcVRVP61VPVg1nEgRUL1UzQ@mail.gmail.com>
In-Reply-To: <CABPp-BEsSpFYVto2E998n-UUwD6UcVRVP61VPVg1nEgRUL1UzQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 25 Apr 2019 09:57:47 -0600
Message-ID: <CABPp-BHLgTM50m4gVoLXWDZbHPojpOyigDnP7ux9zMHKzH2myQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] Fix and extend encoding handling in fast export/import
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 25, 2019 at 9:55 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Thu, Apr 25, 2019 at 9:51 AM Elijah Newren <newren@gmail.com> wrote:
> >
> > While stress testing `git filter-repo`, I noticed an issue with
> > encoding; further digging led to the fixes and features in this series.
> > See the individual commit messages for details.
>
> Whoops, forgot to cc Brian; I'm curious if my understanding is correct
> about the sha256sum transition plans that the intent in the short term
> is using fast-export & fast-import to transition to-and-from a
> sha256sum repo on the fly; if so, I believe that transition work
> should use the new --reencode=yes option in patch five.

I seem to be struggling with distractions this morning; I mean the
`--reencode=no` option from patch 5/5.
