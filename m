Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A8B620401
	for <e@80x24.org>; Thu, 22 Jun 2017 02:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752098AbdFVCK2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 22:10:28 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36687 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751866AbdFVCK1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 22:10:27 -0400
Received: by mail-pf0-f179.google.com with SMTP id q86so1799685pfl.3
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 19:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=RRO943mGYerIKiriBYMRM4VVn+Y+ZhpGdP8XeNcX6dI=;
        b=Oq4YYWwUfLY1E2SMJn3lJ/XVtcEv1am3Kc2a4Sn7jDbn9VQxKAUoo2Ol/zy4cg5U7U
         FS+JN7HkMf7vE+9C17+UgJySAsQNnkjJBZ6OBxbxwjt70DKhowk1ztyThNwqCScxTlS1
         TNwinKcSz75eDhIazEGUfP8dt4jAA7s/Sgm/4YnRIchFaeuKqEKlP/B/CkMgh5X51ZPE
         3cmPX/pOzItqLj3cgHBZ6hTjY2ytGorVIhdYzuXpp5e9AtIfZ3StAUhTrkjSygaKy/0u
         6JaJ8bivNDNRGgssKAWyA6GIzwas2b1D+oiWmbFh1W/9TPKnGoymOUBWYl2KWowEm5EJ
         +g6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=RRO943mGYerIKiriBYMRM4VVn+Y+ZhpGdP8XeNcX6dI=;
        b=b26AdX4NpE5eUMhxsH34fsnjq4zxb40lzpZdMhFgOijOnfG+OeX8x3IwJqTZ2dlOoT
         QroVnHNtR8WN/A+QaQVxWT/qbbOBVgBsp5jCUh71NJpktCGbDr5q7pp/Hlu5Gui558AY
         hBqr71jSXSxCYIXYh0c4souE1cMmKl3HND9l2mPfo01lB7sVtwp/oYitpuDPUe69fuA7
         leIAZ8VAmkdHSep8tsWHC50fYZCWQMK/6qFCRbWdQ1MgIWMp7M4dlmjFzLjfaXZC9VaZ
         8L6WfmT1sCTfqWl1PvmWJTvJxj+r3Qj9gv7kjgjIKoObOVmw6R1VElXpcTmhg67Er3NZ
         dWnQ==
X-Gm-Message-State: AKS2vOwH8FqNG9AXP25lvPQpGw9cepvt5R/soPaP8zgFyfdNKp9zX1So
        s/bvSMvJvq+OhQ==
X-Received: by 10.98.252.77 with SMTP id e74mr258030pfh.42.1498097426658;
        Wed, 21 Jun 2017 19:10:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b0bd:d7d3:4f2e:5016])
        by smtp.gmail.com with ESMTPSA id n123sm141176pga.35.2017.06.21.19.10.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 19:10:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        peff@peff.net, git@vger.kernel.org
Subject: Re: [PATCH/FINAL] status: contextually notify user about an initial commit
References: <1498012463.1487.2.camel@gmail.com>
        <20170621023729.3200-1-kaarticsivaraam91196@gmail.com>
        <1498055714.20886.1.camel@gmail.com> <87fuet8kbs.fsf@gmail.com>
        <1498068974.32360.9.camel@gmail.com>
Date:   Wed, 21 Jun 2017 19:10:23 -0700
In-Reply-To: <1498068974.32360.9.camel@gmail.com> (Kaartic Sivaraam's message
        of "Wed, 21 Jun 2017 23:46:14 +0530")
Message-ID: <xmqq1sqcn568.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> The existing message, "Initial commit", makes sense for the commit template
> notifying users that it's their initial commit, but is confusing when
> merely checking the status of a fresh repository (or orphan branch)
> without having any commits yet.
>
> Change the output of "status" to say "No commits yet" when "git
> status" is run on a fresh repo (or orphan branch), while retaining the
> current "Initial commit" message displayed in the template that's
> displayed in the editor when the initial commit is being authored.
>
> Correspondingly change the output of "short status" to "No commits yet
> on " when "git status -sb" is run on a fresh repo (or orphan branch).
>
> A few alternatives considered were,
>
>  * Waiting for initial commit
>  * Your current branch does not have any commits
>  * Current branch waiting for initial commit
>
> The most succint one among the alternatives was chosen.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  Change(s): 
>  * Added the corresponding change to short status that was
>    missing in the previous patch.
>  * Fixed broken tests
>
>
>  Note: This is my last attempt to try sending patches using my
>  email client in case this one is also line wrapped, please let
>  me so that I could avoid sending through my email-client altogether.
>
>  I'm trying this because I forgot to turn off line wrapping in my 
>  email-client while sending previous patches. Hope it works!

You can check by downloading what you sent out (I showed you how in
the other thread).

It seems that there are funny non-breaking spaces in the additional
text below "---" but before the diffstat, but they are not part of
patch text anyway.

You seem to havespelled "Ævar" differently (perhaps difference
between NFD vs NFC ???) which seems to confuse mailinfo, but I don't
have time to dig into it myself (it is quicker for me to edit your
Signed-off-by: while queuing).

Ah, wait... it's not like Ævar is relaying your work; it's more like
some code / tests were given by him to you to incorporate into this,
so I suspect that two S-o-b: from you two should be in the reverse
order.  I'll swap them while queuing.

Thanks.
