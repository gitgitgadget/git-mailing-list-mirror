Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6194DC433E0
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 00:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DF5F2074B
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 00:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596068660;
	bh=GWnPR5zWmTmCsbDnlCGo50vKf9tCQ5N1eQI7V8uvhaA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ufuMvTFcjjsNCl30+Pdbfb0ys+qdUddEu2b0cI7rVFVRAuFWE9VzT90IjHfQKmBbQ
	 3IP5EbpXCpsini8+dR/A/MR03J/rPV9WC4hcCBnGnjwz9tJ9mKwG3Lm4gOLiAKhO2D
	 9YOkAVEc4a9QS5+AubTwBFTp7vGgi887HmphgQl4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgG3AYT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 20:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbgG3AYT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 20:24:19 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91740C061794
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 17:24:18 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id g6so14366884ljn.11
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 17:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8JKu7PfrP2E+maNMYTXEeXqlUo9PohRSqD7KRy3PPQc=;
        b=TGt6RY9c34lKKBDTbWjurAId6vA2Iw4m29rubZjpYGPwcCXPUnO+8lwnLWrCuGZ1Sd
         SgV45y9no5SUCHHlZZAf5iLm9ujk7bI2DvB9l8l6YqZYWtKRf9QGQ91bm6X6TWmF+Whu
         yLhY9RaetjVFK7ksdsZdoZuSXyX5nPjSXxvag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8JKu7PfrP2E+maNMYTXEeXqlUo9PohRSqD7KRy3PPQc=;
        b=m0ITgdCEekYhmGYaAp/EqvxxMTgmagD3imIZOCSeaocvprWGm/QVZNxYD8WDteW80L
         2smx9UnB0ZOnqOoycZJM9e9XKQzo1RYcGxVWDLwsLgriL9SalNM667Fg7HQI+Ql7brXP
         DorJWWJ8q0ObNSulBVAa7qF/mP19YDWlSybHmdmpM49GeW+hBOWi/YVWO8rIfaISZZ+A
         LrnUhcqOMHxZig6ja02d3OlC2Wgt0UdpxNRZX9WQzlW/RIGyqXzo6ck/G/rsTzp+lsVV
         4Nd+m/vNoq4Lmce3NxDEgflvIMVqEj/ovpi/W8+/exJD2OJn2t+FkWvR/eTuqlp55LHb
         l2lw==
X-Gm-Message-State: AOAM531JwSp+XbYo8hmOA9wCym/03+o+QRNfA1QMOLgWbrrF57JG5muY
        scMk/mQu1SbGt4RKKQktAdmKDaEHfUY=
X-Google-Smtp-Source: ABdhPJwTXIy3mbzXeS+0YYnE+EWGOJzyDXiDiTHb4DgJGdjWU0xYRY74bcHGmDOaDB/gG35yE5r/UQ==
X-Received: by 2002:a05:651c:110b:: with SMTP id d11mr181557ljo.245.1596068656604;
        Wed, 29 Jul 2020 17:24:16 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id h5sm791132lfm.70.2020.07.29.17.24.15
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 17:24:15 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id i19so14003087lfj.8
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 17:24:15 -0700 (PDT)
X-Received: by 2002:a19:c206:: with SMTP id l6mr246107lfc.152.1596068655079;
 Wed, 29 Jul 2020 17:24:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgutLH=mPdJkLU_E6gO4q0FcG+=EEQJVVQeb+OxG9CfgQ@mail.gmail.com>
 <xmqqime69jfc.fsf@gitster.c.googlers.com> <CAHk-=wisOOrfEvab9S417MnPSY8dVkbDOKa6ccdi1Bg3X1PMaw@mail.gmail.com>
 <CAHk-=wi2dsROeg=mij5C8O=UBVZGEpOUp=Bn-arQ7i+Wscynnw@mail.gmail.com>
 <20200729205846.GA2992025@coredump.intra.peff.net> <xmqqv9i6814y.fsf@gitster.c.googlers.com>
 <xmqqlfj27x7q.fsf@gitster.c.googlers.com> <20200730001442.GA2996059@coredump.intra.peff.net>
In-Reply-To: <20200730001442.GA2996059@coredump.intra.peff.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 29 Jul 2020 17:23:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjN0o-+OAn5wXMcshLGQ4H+CLJwq8+wRnaqzKMuhbmZqw@mail.gmail.com>
Message-ID: <CAHk-=wjN0o-+OAn5wXMcshLGQ4H+CLJwq8+wRnaqzKMuhbmZqw@mail.gmail.com>
Subject: Re: Avoiding 'master' nomenclature
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List Mailing <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 29, 2020 at 5:14 PM Jeff King <peff@peff.net> wrote:
>
> I'm on the fence on how magical to make the default. Having "master"
> there gets Linus's case back where he wanted without having to configure
> anything, which is probably reasonable. I'm not sure if people would
> want their init.defaultBranch in addition / instead.

Junio seemed to go for "instead", but I think it might be more natural
to just have "master" as the initial entry, and anybody adding entries
will add it to the list.

I do think it might be a good idea to make "git init" just add the
entry from whatever the default initial branch is.

And then the "empty entry to clear" can be used to _force_ a clean
slate, although I don't see why anybody would ever really want that.
If you make your default branch name be "develop", and you really want
to see the "into develop", you'd remove the entry that "git init"
would hypothetically add, you wouldn't necessarily want to do a "clear
list".

I assume that "clear list" was maybe done because somebody would put a
list of entries into their global .gitconfig file, and then a
particular repo would override it by clearing it? It might be better
to make it clear that it's just a bad idea to make some global list,
and this should normally just be a per-repo setting?

Git hasn't had that "into master" for a long time, and I don't think
anybody has ever asked for it, so I don't think that legacy entry is
something you'd find people wanting to clear just to see that message.

            Linus
