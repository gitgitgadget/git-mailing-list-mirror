Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9624BC33CB1
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 13:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DAA3214D8
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 13:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="MqAZR1eL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbgA0N5V (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 08:57:21 -0500
Received: from lb2-smtp-cloud9.xs4all.net ([194.109.24.26]:48385 "EHLO
        lb2-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726303AbgA0N5V (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Jan 2020 08:57:21 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179])
        by smtp-cloud9.xs4all.net with ESMTPSA
        id w4t9iLaCGT6sRw4tDi8FIv; Mon, 27 Jan 2020 14:57:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1580133439; bh=Y6Y8sL5/0DOSYGz4vJAZeR+jS8wZ9RJccbyXqFgLccE=;
        h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type:From:
         Subject;
        b=MqAZR1eLaMGnkyh7zg872Aax8pzbzDTkh7HfpSf60Yg2Vpnwf8Csx5i4rNUBPU64C
         J91cPH1JyEdWIFbhfnotGtybo0Jx0TF2/kl3KFibY8m2e3gXKSxLEBZGCNt/yZtj+j
         U6rKQDPQEiOQS4jkbsw4kNl5O3VyBI5+2EZKtVmENBrZZHPVRwr1E5JtSP+9hPajSl
         ft/MsdaF59C1BL054vCVP3ErFBrd3dsegedNr8O5a0hrTPo3CnGD7wDSkBsKut7VsY
         +OX1MUQvg9d8bW9FpozoVqxL+OXpm6EtRGZgXmj1nHzaMFB6tXzpI0I8Fx6EChEhq6
         9usbTLyt7dBoA==
Received: by mail-oi1-f179.google.com with SMTP id c16so6706958oic.3
        for <git@vger.kernel.org>; Mon, 27 Jan 2020 05:57:19 -0800 (PST)
X-Gm-Message-State: APjAAAVro8iWj+yxyUl7FnJZR91hkQLSNVXpRET9UgIRbZrnc3JMhpGx
        MpE04158MQaFHcP6WRF/LliguvkJeN7R7XJalOI=
X-Google-Smtp-Source: APXvYqxMLuCPpimJ0DCG/+8lKFV1cwAqiWRV5Fya2WCprU74hfoWNtPWxABmhMTcgoro0//XkV4XDE8/8oUi3YA+VfA=
X-Received: by 2002:aca:503:: with SMTP id 3mr7585780oif.106.1580133435571;
 Mon, 27 Jan 2020 05:57:15 -0800 (PST)
MIME-Version: 1.0
References: <pull.539.git.1579808479.gitgitgadget@gmail.com> <cdf5fd5a-49ac-cc0c-8da4-68c82cdd883c@gmx.net>
In-Reply-To: <cdf5fd5a-49ac-cc0c-8da4-68c82cdd883c@gmx.net>
Reply-To: hanwenn@gmail.com
From:   Han-Wen Nienhuys <hanwen@xs4all.nl>
Date:   Mon, 27 Jan 2020 14:57:04 +0100
X-Gmail-Original-Message-ID: <CAOw_e7askCpVH-7Bsnsp+t_u8VZz2Y=ZtfB9m-O1-Jva2hj8cQ@mail.gmail.com>
Message-ID: <CAOw_e7askCpVH-7Bsnsp+t_u8VZz2Y=ZtfB9m-O1-Jva2hj8cQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] Reftable support git-core
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CMAE-Envelope: MS4wfJ1pmOXcaNenKGh9rwWARchu7Ya0AtXvtb0Ldi6h5f/STcvnH7plGls+bUwGbO0DmzX6trc7tDpRMFfANzDRiVPXuX3LFj8LWNcbzxsF4djz6/nvDXpd
 5p9nHxGSHJKBsLwC2nrS77heIEOsI0hnQJOa3qYzlo51V3uVFT45+XFyJjd/Yf4WiV6acO3FmoQWFw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I added some more background in one of the commit messages. You can
find extensive discussion here:

  https://github.com/google/reftable#background-reading


On Thu, Jan 23, 2020 at 11:45 PM Stephan Beyer <s-beyer@gmx.net> wrote:
>
> Hi Han-Wen,
>
> On 1/23/20 8:41 PM, Han-Wen Nienhuys via GitGitGadget wrote:
> > This adds the reftable library, and hooks it up as a ref backend.
> >
> > Han-Wen Nienhuys (5):
> >   setup.c: enable repo detection for reftable
> >   create .git/refs in files-backend.c
> >   Document how ref iterators and symrefs interact
> >   Add reftable library
> >   Reftable support for git-core
>
> I am most of the time just a curious reader on this list but as someone
> who has no idea what the reftable library does (except that it can serve
> as a "ref backend"), I would expect much more elaborate commit messages.
> In particular, patch 4/5 (i.e. the commit message of the "add reftable
> library" commit) should describe the purpose of the reftable library at
> least briefly; and patch 5/5 should not contain shell commands and
> output without context but a short description why the patch is doing
> what it is doing. For example, if the use of the reftable library makes
> certain git commands a lot faster, it should state that.
>
> Thanks.
>
> Stephan
