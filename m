Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C48C433E7
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 06:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8249A208D5
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 06:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389584AbgJMGh1 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 13 Oct 2020 02:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389470AbgJMGh0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 02:37:26 -0400
Received: from mx.pao1.isc.org (mx.pao1.isc.org [IPv6:2001:4f8:0:2::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E937AC0613D0
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 23:37:26 -0700 (PDT)
Received: from zmx1.isc.org (zmx1.isc.org [149.20.0.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.pao1.isc.org (Postfix) with ESMTPS id C1B413AB0B1;
        Tue, 13 Oct 2020 06:37:26 +0000 (UTC)
Received: from zmx1.isc.org (localhost [127.0.0.1])
        by zmx1.isc.org (Postfix) with ESMTPS id 945FA160053;
        Tue, 13 Oct 2020 06:37:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zmx1.isc.org (Postfix) with ESMTP id 866CD16003E;
        Tue, 13 Oct 2020 06:37:26 +0000 (UTC)
Received: from zmx1.isc.org ([127.0.0.1])
        by localhost (zmx1.isc.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id S8nYJUYSn5Eb; Tue, 13 Oct 2020 06:37:26 +0000 (UTC)
Received: from larwa.hq.kempniu.pl (unknown [212.180.223.213])
        by zmx1.isc.org (Postfix) with ESMTPSA id 6FBD0160090;
        Tue, 13 Oct 2020 06:37:25 +0000 (UTC)
Date:   Tue, 13 Oct 2020 08:37:22 +0200
From:   =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <michal@isc.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] diff: add -I<regex> that ignores matching changes
Message-ID: <20201013063722.GC3278@larwa.hq.kempniu.pl>
References: <20201001120606.25773-1-michal@isc.org>
 <20201012091751.19594-1-michal@isc.org>
 <20201012091751.19594-3-michal@isc.org>
 <nycvar.QRO.7.76.6.2010121315170.50@tvgsbejvaqbjf.bet>
 <xmqqo8l7nrjc.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2010122236130.50@tvgsbejvaqbjf.bet>
 <xmqqpn5nm87u.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpn5nm87u.fsf@gitster.c.googlers.com>
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > the use of `xcalloc()`, and now that I think further about it, an
> > `xmalloc()` should be plenty enough: `regcomp()` does not need that struct
> > to be initialized to all zero.
> 
> Yup, I think it makes sense.

Sure thing, I will switch to xmalloc() in v3.  xcalloc()'s semantics
("allocate one structure of this size") appealed to me, but there is
indeed no need to zero-initialize the allocated memory before passing it
to regcomp().

-- 
Best regards,
Michał Kępień
