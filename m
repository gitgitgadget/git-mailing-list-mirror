Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74858C43460
	for <git@archiver.kernel.org>; Wed, 12 May 2021 06:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34142617C9
	for <git@archiver.kernel.org>; Wed, 12 May 2021 06:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhELHAq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 03:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhELHAp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 03:00:45 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CB6C061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 23:59:37 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id z3so20170536oib.5
        for <git@vger.kernel.org>; Tue, 11 May 2021 23:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=qZX/phKJV9WGNuCYcYUR5vVccwRWifT3D4zginnl+hE=;
        b=uTaTqk247cL87+gbOnC5Vd1vORer6Cag99QzUtDEkM4OLGW7aNqqtJ8/xxPltlMu5p
         u9FaysVOKWuOL4Oa6iQO8wh76I7YtaNEamu2LHrCpxhEl6chrx6jzHXnIzgbIAl4Hn1v
         cEYLZDVNQgmLL1dcMu/oAddV0qpDOabWKqNCDurBcl0kGiXtq4YtgNfuFHRxycxu509l
         nJGtGil+Ir0kbyIe+onuCij6P4p1m1YLzATB3U8zNYkH30TL2fZR3YgqLEiOAeOaaQfr
         65aPBXtcqWWMpPKJSdsHUfkSTWtcZAevU8/RajmfLGznteQgwOEBEt7ubimQmmu1AXQC
         srLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=qZX/phKJV9WGNuCYcYUR5vVccwRWifT3D4zginnl+hE=;
        b=PsYCJME4wGhau33IqOidUpDAD4RK2o7jQ5TfC/vm6ZSYUgwtcUxtf95QMbt1vprtg2
         NEPbqjPfLXBsygmbBbr5O3OMKVgNWgUOWMBqPuERquZLX/GmLYSH3kRoWQaIkDoX+rj5
         WRRuAuxo+/JFS4cO3gJA1xlRQreMbRXcEd+u7MzD+gmePkRX/9sWvmySUbQ1TFtSbymL
         Tr2uHuRQOEq2KlmCZzXtmbFg6i2L2/MGar+iSnHM0JtWoajFJ+SnONUYF6G/MhIBrdzt
         YJOSZX5ZpatrOlZxb3UI7tJiQeUbDN/Qf8r2mQCLS4LGxJ/u5JiyaTffenvy7jfVi3RC
         IftA==
X-Gm-Message-State: AOAM533BhT+50ceHkv55PPs77IGbNjEU3EkBzMc50bm7IjGyAx+XJ8ss
        29AnjuDBoCrB5TYyHLnF/qs=
X-Google-Smtp-Source: ABdhPJyCSuVDGeQ2P2Ga6mTFdwkRlI5r0/gVIxCfuIgBeTMuOe7vKS9XT8yn+nNP3ER8QjkVgw9NkQ==
X-Received: by 2002:aca:aa12:: with SMTP id t18mr2513962oie.141.1620802776586;
        Tue, 11 May 2021 23:59:36 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id l131sm3569464oia.0.2021.05.11.23.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 23:59:36 -0700 (PDT)
Date:   Wed, 12 May 2021 01:59:31 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <609b7cd397063_6e0fc2082c@natae.notmuch>
In-Reply-To: <YJsheKt/UBJNtgv1@danh.dev>
References: <20210501145220.2082670-1-lenaic@lhuard.fr>
 <20210509213217.449489-1-lenaic@lhuard.fr>
 <20210509213217.449489-2-lenaic@lhuard.fr>
 <YJiKXRywBhhGXC5Q@danh.dev>
 <CAPig+cQdU_0uPKDkbuz3XqdYePAMNPcF_u+Enx+qfgRGvtiseA@mail.gmail.com>
 <xmqqtunbqf5o.fsf@gitster.g>
 <YJsheKt/UBJNtgv1@danh.dev>
Subject: Re: [PATCH v2 1/1] maintenance: use systemd timers on Linux
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:
> Yes, dependence on systemd should be strictly opt-in.
> Although, I don't use systemd-based distro, so it is irrelevant to me.
> I think it's none of Git (the project) business to decide which
> scheduler should be given higher priority. It's crontab when
> maintenance was introduced, it should be crontab, now.

I do use a systemd-based distro, and I like the option to use systemd
units, but let's be honest...

100% of systems with systemd have cron... So...

-- =

Felipe Contreras=
