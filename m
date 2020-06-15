Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76509C433E0
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 19:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BDC5206F1
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 19:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GF6JPmP/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730291AbgFOTpY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 15:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728773AbgFOTpX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 15:45:23 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC04EC061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 12:45:23 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id i16so13626851qtr.7
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 12:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kK0TaQDbh245KT4wKq5A6sW698XdtaoyWKGodN5ppKY=;
        b=GF6JPmP/p3LSu0BJIBJvq5tKsxMiHxG5i7n4p7oj629DcKaicThTg+wWUCB+4FLYan
         V+AuwoGeb+OHZMvUugFOPkN2gGPX5fljzqM8uAlNh6+ghOOkr3Re44OfXmN6kaEzV+A9
         46zcsetd7U/KbbK4XShfSvb8McoK1FEdnH9ZZ6KPxjKUsdF2kp8lG2uFzvntuHIwV71B
         kKiEtGkXRMaUh5oucugBEIZut7KhPtOMJu5MC8YQfxhk3wxrekkBqC3SIJe/Lz5CQMp3
         I0lCRftArcO8eow9eZIdt/a8Jn3Rnid69QapSvtAiVfYJEcziEHK551RKXk2t5ngCRIu
         2nGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kK0TaQDbh245KT4wKq5A6sW698XdtaoyWKGodN5ppKY=;
        b=kDJkjqSqOdL/TaoNUYaJw6HXPsTxODJWqcxR4lYpjAn5SBp7eaBjc1jU1cD3wy64Hq
         cMK1SpOozMIgXoybzNK8Lrry6f/lhn/Wjwi8uTmjMwpzWTxKmoxBfVCg7bFH6j7VNd72
         wfqSm9W3VtZoxNmJKK0WsKA+UKFsB5wBVFy6fKZIHSPOdYSBkUs7EhGNDQXfWbOo/w3/
         lmWLSWfvvvPWLBCjz39API7F3P6/WBDcfVI+FK2FIp1tq9ss5uhhpN/LOvTQxVawhOmn
         otHUfzZwuUM5jkFwiwTv1rmKGGcIk97fXgmYIDwmdnh4nTJFwKP74nVBrPzSXPFjHi6e
         c0VA==
X-Gm-Message-State: AOAM53234inE4EHd7jC1SeB0KvEaQ7aA4KTC9VrDPkPesRWH174/IIFQ
        DjKKrzOvESFIjANPVyLxpI6joZsBRiIXpCppmYA=
X-Google-Smtp-Source: ABdhPJyWIffI+B70PI3Fnu9MvKikqwZuK0eEKBEJgtvPKIPHMsj6kvg2Dpe0siR3KUdOWzjRG/PZblNBTHbwMLqmRg4=
X-Received: by 2002:ac8:1bd2:: with SMTP id m18mr17802303qtk.64.1592250322975;
 Mon, 15 Jun 2020 12:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <db05180e98af42b5d0887298adbb2f2db6c1d6e7.1591986566.git.gitgitgadget@gmail.com>
 <20200615140236.1707-1-oystwa@gmail.com>
In-Reply-To: <20200615140236.1707-1-oystwa@gmail.com>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Tue, 16 Jun 2020 01:15:12 +0530
Message-ID: <CAKiG+9XbpLpWWsEg+RCqxzJ70Hx-=qqxDL_Yy96weM5fLoVwuA@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] cmake: support for testing git with ctest
To:     =?UTF-8?Q?=C3=98ystein_Walle?= <oystwa@gmail.com>
Cc:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 15, 2020 at 7:32 PM =C3=98ystein Walle <oystwa@gmail.com> wrote=
:
>
> > +
> > +if(BUILD_TESTING)
> > +
>
> This variable should perhaps be declared as an option using option()[1] s=
ince
> it's a knob the user is supposed to be able to switch. This makes it list=
ed by
> `cmake -L`, and shown in ccmake and cmake-gui. In short, it's made more
> disoverable.
>

When you `include(CTest)` the option BUILD_TESTING is automatically added.

Thank You,
Sibi Siddharthan
