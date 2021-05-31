Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059CBC47082
	for <git@archiver.kernel.org>; Mon, 31 May 2021 05:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D11FE600D1
	for <git@archiver.kernel.org>; Mon, 31 May 2021 05:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhEaFnR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 01:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbhEaFnM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 01:43:12 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8834FC061574
        for <git@vger.kernel.org>; Sun, 30 May 2021 22:41:33 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 133so2486853pgf.2
        for <git@vger.kernel.org>; Sun, 30 May 2021 22:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0WBSaL0TXNPYalMGIsb/7Kqr5iofkePi/YTdVhFMMIY=;
        b=OvU9to2aZbrd40x3PHXBmoRSh0In+VpIDNEecr8HsnTxzT/ONP8J2jWx/7ERWEnOL0
         LBwLeB7OhYC+881Pug4oFA57QS7q7w5HmAfvQB9UsiZT8TY7cjaEz0LXoU+eLJY6B1GZ
         kBt+ry+2k9wAH3K2Ym8H4mSBd3GwMnbr1ugCvQOZI5yMY8+IeH6zqjMXyF8166aGo4Cz
         LMTYJa44IxMB3oe21l1Jy5VSL+KOxNC95RuWLBCa6scUwsODb3Ar9J7YmwloRHWVFghl
         Hq1yEgPsMejo6MHefQbowgn+zv5tEPhWpWEtY315RMmZJkUpOM3+Sx29qfSLoVomxX+3
         i6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0WBSaL0TXNPYalMGIsb/7Kqr5iofkePi/YTdVhFMMIY=;
        b=Unz+5pfj9BZW4q1CYApdjmGf2+BwH77aeqM04nradiE5/OMM+j5qtY6UhtWFciza8C
         0/vFM65TGvBguyaAKwvDjsduvQ7Yv1eqm8oIFfRu7jTjEwFYAwTL5YDrgA7uz4bpANrs
         NHvQ5VQ8RxHfP9EHL1wA7jh6ebvr3dq8/JA764aQpfYdx2yEVg4yc/oFL7XLMHvva7wA
         dneUOAgzYD+CQvu9SuZ2vZSGNwtzuYP8s2YHxo0kaYF+8rzAl5IxWagbUjHzlY14Xeuf
         hQSEygeFfCH6TG7t2Hh2sz1JQdPY1QxN1oKzloZLk9SU0Pi4iVTmWVNd8VxLbI85ehUw
         RYoQ==
X-Gm-Message-State: AOAM531wg59etSR38qkjK7o3/fUOgg473BtAOCBYY0aHIUoMDoF8a4jS
        lmE8pd/azqSU36kR0pLb9VQ=
X-Google-Smtp-Source: ABdhPJzWC9PxZXFt60XiQZK+MCGUMDr4CFHaVSsADJ9932pl62LpphdPtVhR7aPb+wDLL89McGeAEQ==
X-Received: by 2002:a62:a517:0:b029:2dc:9daf:5e91 with SMTP id v23-20020a62a5170000b02902dc9daf5e91mr15416511pfm.39.1622439692936;
        Sun, 30 May 2021 22:41:32 -0700 (PDT)
Received: from atharva-on-air.dlink ([119.82.107.60])
        by smtp.gmail.com with ESMTPSA id t1sm10532951pgl.40.2021.05.30.22.41.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 May 2021 22:41:32 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [GSoC] My Git Dev Blog
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <4d51b7bf-966c-c3fc-ce1a-62c0db4af29a@gmail.com>
Date:   Mon, 31 May 2021 11:11:29 +0530
Cc:     git <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <374870FA-CAAA-4027-9AD6-E08EF63D85CD@gmail.com>
References: <35493133-2504-4CAE-B700-79EAB990DD17@gmail.com>
 <B932C097-1B91-4D59-9CC7-1B91C86FA1A1@gmail.com>
 <4d51b7bf-966c-c3fc-ce1a-62c0db4af29a@gmail.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30-May-2021, at 23:00, Kaartic Sivaraam <kaartic.sivaraam@gmail.com> =
wrote:
>=20
> Hi Atharva,
>=20
> [...]
>=20
> Just one suggestion. While reading, I felt that it would've been
> nice if it had a few links. For instance,
>=20
>> The patch that I ended up sending this week is heavily based on
>> the work of two generations of GSoC programmers who struggled
> > over this problem.
>=20
> The text above could've had a link somewhere to the patch you sent
> to the mailing list:
>=20
> =
https://public-inbox.org/git/20210528081224.69163-1-raykar.ath@gmail.com/
>=20
>> I studied Shourya=E2=80=99s stalled patch, parts of which had already
>> been reviewed.
>=20
> ... and the above text could've had a link to Shourya's patch
> series you mention:
>=20
> =
https://public-inbox.org/git/20201214231939.644175-1-periperidip@gmail.com=
/

Sure. Thanks for saving me some of the effort to get the links :D


