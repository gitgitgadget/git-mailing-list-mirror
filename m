Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1ECC63777
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 03:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3876A2076E
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 03:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgLADEX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Nov 2020 22:04:23 -0500
Received: from mail-ej1-f68.google.com ([209.85.218.68]:36574 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbgLADEW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Nov 2020 22:04:22 -0500
Received: by mail-ej1-f68.google.com with SMTP id lt17so912003ejb.3
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 19:04:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nkc3lLIbGFEkMqjywVUx1DksQLNMKRLHTn1Iw9LfAqo=;
        b=twPyHl0GP67lnWmQgf3wB6EJ6oI8WfJEWrEeFTSCO+gLGeTm1c3XdfaGVpk9ZeDGyo
         2z5rUFBqrVZCeXezXWO75sLaHKcVZFeyGEDqdTpqxSZ/fsVUcg2rPj6hxqlFtUaHmWOj
         DAVgNGMO7KB1JxwJ4axkjJ3VIBme/dL2THZy8S6DQrNc8Tw3bdcxd8EJTsozoRgT1Bu3
         Lhuoq+bLuLspAjvM+ElfaR35TzEEv4g7uTcgFbRC5aI9eV8BO4/79nang5N5brbie3hq
         ton2Z4Qo3KZESZMf6w+VNeEx4N7BKt6J2Zye7PJH2RtsLq5xXAbDq58l+HuKpH2KW2C4
         nsmQ==
X-Gm-Message-State: AOAM5333RTSH1cxE/E+PIfDDm2C/HpBFzbhWZI3SkBcjLAQkvrLz2Wcb
        8mdmfq8OsJyjmtldvAabzaCs/cTBmzFRw3RFM9k=
X-Google-Smtp-Source: ABdhPJyzP72UbrRp8yOLXcAhCnDKnB7Nb7WEGCRDhPE4QxWaPSYNSpzYVgpz3fAaGqYcnqxjZ1lsyRZvl+svqfYutnU=
X-Received: by 2002:a17:906:614:: with SMTP id s20mr1012901ejb.202.1606791820707;
 Mon, 30 Nov 2020 19:03:40 -0800 (PST)
MIME-Version: 1.0
References: <20201130044224.12298-1-sunshine@sunshineco.com>
 <20201130044224.12298-3-sunshine@sunshineco.com> <e4647058-3bb6-7aa4-c245-95e3f4b3bc66@gmail.com>
In-Reply-To: <e4647058-3bb6-7aa4-c245-95e3f4b3bc66@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 30 Nov 2020 22:03:29 -0500
Message-ID: <CAPig+cSK4y2P2PUVnXyaB5T0y-RBJOsb-npwM_8Wnm7oqRQLGQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] t7900: make macOS-specific test work on Windows
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 30, 2020 at 8:12 AM Derrick Stolee <stolee@gmail.com> wrote:
> On 11/29/2020 11:42 PM, Eric Sunshine wrote:
> > +     # ensure $HOME can be compared against hook arguments on all platforms
> > +     pfx=$(cd "$HOME" && pwd) &&
> > +             PLIST="$pfx/Library/LaunchAgents/org.git-scm.git.$frequency.plist" &&
>
> This pair of changes make sense to get around the $HOME issue
> that caused me to surrender the effort.

In case it's not clear to other readers not familiar with Git on
Windows (or who have not read t/README), the magic here is that `pwd`
is overridden in t/test-lib.sh for MINGW to always return a
Windows-style path.
