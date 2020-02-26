Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B58EC4BA1D
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 16:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C878021556
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 16:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7tsgUjw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgBZQ7u (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 11:59:50 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:44417 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727922AbgBZQ7t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 11:59:49 -0500
Received: by mail-ot1-f44.google.com with SMTP id h9so40140otj.11
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 08:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bva5x2tvm8B9u5csZYW3oE3yHorr0diuN7n9tZLuQOs=;
        b=i7tsgUjwL1ZAOFVzHPMo5Mfp8m6AaqmSfr+pnFFfRNDpeDOgU/5S2zlqLpyCYJcRE1
         JKl6xhiittgNjUO7hodRPi5EaB7lYwbxNmnYz4S+mhSxr6Hu0u4zScesjjVcdFfdf5jp
         +jfyV19CroKj+g9w8EmipNvaexdT+jrVhh4oOm5a98rGDWi3uBlstt21JNKdAXTyajG2
         MGxZD8vqwCswB8nLsY+FKf74pi10pqc8INqJjb+irfllJVFMDQcBGBqotxXD+cx8pG0q
         7Fxs/2t/bBSJ8sGSa9Fjs7375CmzCFbv0qagZLnPcDl2VKXDxbTUa9MLyI51s9Rhu85v
         mSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bva5x2tvm8B9u5csZYW3oE3yHorr0diuN7n9tZLuQOs=;
        b=snaI16bDysQxE3tN50r1OG+xRDCvM4RUcp7bEmASwPVZ+ujAc7KzlphIkaGSd3mokC
         87SfoWUHTpiH/WdGlsuILYdcWuo2S9tCZVgSSI4QQlZxuv64+8hVwClFBtJawsZj7K5g
         G6yQoUGlwBgD1yhemP2U18kcoQnwimUqDr2Ej26RE2Rvtab6HZxGwddhrP4KfFTqe1uh
         sUujgGo1bfejuQCNMsqVHrnEyNvpLvB1R/zo55F6B4IosbiV5icYM7n5Rim8lKhCug+c
         gXw5NDWO//u1jD5I3YoFlWXj4mb97U7+T4mNaorKzOisGI8LfcrzQac0CkgFnuFgkT78
         SM7A==
X-Gm-Message-State: APjAAAWBKdElaFQIUfYPEmfs8OCtJC+XDouiBlOhHNeADLV4+UW/Tpud
        cHJ08SRZ/n//J5bUTYGyPG+57dYys9u0GNIgnnJtKep5rdGuVA==
X-Google-Smtp-Source: APXvYqxD5Piz2xWAaayO0387uAcgmErt91lC3OhZ032p9SWkR/u2n6kMDMRpmYR/7wSGvkNRlCyX2VFGl9dGmKCmSX4=
X-Received: by 2002:a9d:ecc:: with SMTP id 70mr3779590otj.182.1582736388518;
 Wed, 26 Feb 2020 08:59:48 -0800 (PST)
MIME-Version: 1.0
References: <CAHk66fszhTMWa14rpupbwDak=t4=svcHr=1CMBBSt8MQbEUqmQ@mail.gmail.com>
In-Reply-To: <CAHk66fszhTMWa14rpupbwDak=t4=svcHr=1CMBBSt8MQbEUqmQ@mail.gmail.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Wed, 26 Feb 2020 22:29:37 +0530
Message-ID: <CA+CkUQ-QtJfRp_PcOUT37oOVnoBJFqaPPZk5JufZHBwWcSdAzw@mail.gmail.com>
Subject: Re: [GSoC][RFC][PROPOSAL v1] Unify ref-filter formats with other
 --pretty formats
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Abhishek,

On Wed, Feb 26, 2020 at 1:00 PM Abhishek Kumar
<abhishekkumar8222@gmail.com> wrote:
>
> Olga has worked on migrating the formatting logic from cat-file, log
> and for-each-ref to ref-filter as a part of Outreachy 2017-18. Look up
> her patches and proposal.

That is already on my to-do list. Still thanks though ;)

> She, along with Christian and Thomas were the possible mentors for last year.
> They are the best people to ask to learn from.

Regards
Hariom
