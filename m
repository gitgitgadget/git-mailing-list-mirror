Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6041F1F453
	for <e@80x24.org>; Fri, 18 Jan 2019 17:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbfARRz7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 12:55:59 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51807 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728511AbfARRz6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 12:55:58 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so5322326wmj.1
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 09:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=mArH2xEsNvVb3FcDsVCryoxbHCqoPYh0UTuXjEQmWEI=;
        b=vTHWJd/LdiaoESfnwrzM8T3uNRayS+lbN2rFJ7ppPsg+A1BXhnFnYLAam9rnp7VnQO
         vE57JSzpg0zkjQ3VS01RgquNPsJ67tD4clw3ir835HKOZ0rMzuKoGccF5feXxGtZ9jGo
         Ygj/WEQ6sLOv3NXJqCtEEoGuttCtMn3HD+6Gitmt89D/EWFXLPB0uiNXqLiSdnps8yWl
         biyRof/QZ+GYjEd0D8hj8/UD4JQZwZ/+lpsdK2Mt1q5QfIaL8koMWglutyEwttj9KfkU
         z8lZ7lnku0iFJ7fyKexwHAN/owakCBtWuNCP4hy6L/kSC32ymCFlTPNBpI4vKDQzUTih
         vJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=mArH2xEsNvVb3FcDsVCryoxbHCqoPYh0UTuXjEQmWEI=;
        b=O0QeoJv4mTrwOCkV+40KHoW/jZ5Aj5fYf5YkOW6BcRICD4sQSoxFwMlASERtRIrQZ5
         4h/9oWikzsWiGvwiV/WCeo6BFrVahdoPH11Gpo4HJPeosS/npU7DSPKWIKfSo7K2XeMj
         RXWNWv9YIKOeeut0BaVQVjZdrLpoFbcFxr7GwKjIBZvflltI7MEe3G/e738+lCYQuSvH
         tV5v4jHl0U/wvICtG2TWGrOHJcf4+4+4wUdDGv/y2DlJ5K0d+gkSbFuIx2UhBErQxARj
         +UqgAPqijvOB8p1Tbwt0FAiwUb/yVVBouyW9G39H55A89R6dcyBqEAjr9dZU9xu6N4Sf
         87oQ==
X-Gm-Message-State: AJcUukf3SlIeHxfw1voSmvBiF9sQZhli+W2XyUbHZSxbjgmcfMn89QgR
        zBx+A2R1DO+KYrc3nO7BWV4=
X-Google-Smtp-Source: ALg8bN57pMgbQeWxdMrr1vH8UXda93wCI58NSAbnqeWkvuJchLdeRZU7j2yNcNNohQcecJvMUBmrRw==
X-Received: by 2002:a1c:c303:: with SMTP id t3mr15593158wmf.94.1547834156639;
        Fri, 18 Jan 2019 09:55:56 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o3sm68390438wrs.30.2019.01.18.09.55.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 09:55:56 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Pratik Karki <predatoramigo@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>
Subject: Re: [PATCH v4 0/8] Reimplement rebase --merge via interactive machinery
References: <20181122044841.20993-1-newren@gmail.com>
        <20181211161139.31686-1-newren@gmail.com>
        <CABPp-BE83Oe15U4yrkcV_-qzWocMS4UcVeG1VEoac-jXgw9Peg@mail.gmail.com>
        <xmqq4lak8d4g.fsf@gitster-ct.c.googlers.com>
        <xmqqzhsc6xdk.fsf@gitster-ct.c.googlers.com>
        <CABPp-BFckuONYcGGkCY3BuPypRULmhsk_OFHyYA2E4jM66BfeQ@mail.gmail.com>
        <nycvar.QRO.7.76.6.1901181434520.41@tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.1901181519230.41@tvgsbejvaqbjf.bet>
Date:   Fri, 18 Jan 2019 09:55:55 -0800
In-Reply-To: <nycvar.QRO.7.76.6.1901181519230.41@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 18 Jan 2019 15:22:36 +0100 (STD)")
Message-ID: <xmqqmunxluj8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I am about to submit a new iteration of my patch series, would it be too
> much trouble for you to rebase on top? If it would be, let me know, then I
> will rebase on top of yours.

Or both of you keep the topics as-is and self-consistent, and let
the rerere machinery to squash it in when the two topics gets
merged.

