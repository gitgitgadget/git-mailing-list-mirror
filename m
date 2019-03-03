Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 936DF20248
	for <e@80x24.org>; Sun,  3 Mar 2019 01:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfCCBZU (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Mar 2019 20:25:20 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34479 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfCCBZU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Mar 2019 20:25:20 -0500
Received: by mail-wr1-f68.google.com with SMTP id f14so1718703wrg.1
        for <git@vger.kernel.org>; Sat, 02 Mar 2019 17:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=4qapdulagF4mAr65O6G6axRIBV6e17+PMY1fR5dWJps=;
        b=lRx8M+vyBKR8lzVv6+tg0q05fzsyN1pYrSDYRkZQP6ih+vHBvzVJYdWKKnUeeQIHH7
         rMKfzuTFbPjceL+7oaP/fu+X+tgrzBGKWrnKbDnhKA64FsTg96mhhG9Ma4hcff29UQI6
         ECLoc8ueaWMWUjs5QYXLaK6eM9BpGt59pEmgwZvvFEShsfGj7CIBVCFA3JocdzBBHaV8
         FM7jSvmVY6YE3nN6PizIM8+20pJJ0r3bycfSc0SXbo71zWWPzPV4ob/quM9H8csLWU6J
         AZPoHVh3BxKAnmrej5MSGgaJcuICOdgksIhoIhAh6HC9J7tNaQddhSB4MLgJWv+65XhQ
         upaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=4qapdulagF4mAr65O6G6axRIBV6e17+PMY1fR5dWJps=;
        b=PXkKe3bxsf9lDM3MZElQE51t/Tcx8UQUsBs27Spx3r3CgqAQUPkqDzMcJ4XLQzOGkD
         e9rm0/kAtmfPKm9GdYxaDI1TSAikeoU+rm8T9JM1if/yB2h2AIAbOamTeC2adTp6m9Po
         kZp+7fRV5ZRQnHH7cT1V1emt31+VzGk8eb0wcXcfVDaYvuFl4pdKmCn19PJA54Desr41
         mez/6xz2Uq7Su17oLrF19dDkUazilFLORUgGw9x6XLxKL63zpsgcSBpnRoYCS7MRIEP5
         X7aShE8eLfhSkTJA33lEeh95a+aX2BsadSgx3DeCNKE4gqtvc/WIWXszxTy5qoz2d4ow
         ewNw==
X-Gm-Message-State: APjAAAUmGV0E30+rjEPwPVD8KJrhefdlcyo7Ta3M2u5yYTBPn30MH+73
        tAeVPleDgOAsH8fzWaod9UI=
X-Google-Smtp-Source: APXvYqwKPaSCPg7mDXj8kj5qKrTGNbvzNtkqBBBAktJMa6bXHIsDox3Kyc99aTdq2dBQEmZtqINX/g==
X-Received: by 2002:a05:6000:124a:: with SMTP id j10mr7814163wrx.26.1551576318230;
        Sat, 02 Mar 2019 17:25:18 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w12sm2114993wrr.67.2019.03.02.17.25.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Mar 2019 17:25:17 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v13 00/27] Convert "git stash" to C builtin
References: <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet>
        <20190225231631.30507-1-t.gummerer@gmail.com>
Date:   Sun, 03 Mar 2019 10:25:17 +0900
Message-ID: <xmqqtvgk3g1u.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> As I was advocating for this series to go into 'next' without a large
> refactor of this series, I'll put my money were my mouth is and try to
> make the cleanups and fixes required, though without trying to avoid
> further external process calls, or changing the series around too
> much.

Thanks for a well-written summary.  One thing that is missing in the
write-up is if you kept the same base (i.e. on top of eacdb4d24f) or
rebased the series on top of somewhere else.  I'd assume you built
on the same base as before in the meantime (I'll know soon enough,
when I sit down on a terminal and resume working on the code ;-)




