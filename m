Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E41C47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 16:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FD0461352
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 16:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbhFGQX2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 12:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbhFGQV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 12:21:28 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07C3C061157
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 09:16:20 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id v22so18633439oic.2
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 09:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=1E/6MRrnN0okuEZg+QfgxiFXico8WIGsGUzU6qNFn/4=;
        b=gPlzIituM57xj87CYbzKvW7WCMRU5lkBagj/8oLCUD/KgRCe4hKFPsC6OEwL7NI4AW
         XZLFpSe9eDEMUFwGTvAbG8fqEV4nYOwo2R7b4SOPZOk/igGGpLi7iAtuCupvt42YrWYU
         gRyblR7j09mdbX84hg6BDdkrL4iH7m5h/2Zldn57P5WNXp/82BtuXErQrY4lgkSvSqXe
         bcYLV7oHbLDr5jcJx0ALwA5RcGwmUZ2KMLr2puERzq7SnZgWStzS8hY7OZiok8tdweKD
         kelHQt+jrglO2oZVic5U2rlMK4HriOgrt1RtkEKQ+MeH3XOK4KrpQV7o2im2n2iTKcCo
         2I6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=1E/6MRrnN0okuEZg+QfgxiFXico8WIGsGUzU6qNFn/4=;
        b=O/lioi5K0Uvm4KnbxLY0XlryKVzmR6UVmkKrYchkp+ftkB+HS5G18Hrpeok5Tv4LYE
         azTNMP/sUumL9e2nyzwkTsiX3OrT/CYDEakPWdb9z563zc/BMOjYApO0tYSxs7hjSzqG
         X72iv3OYp1xwfwWoMkV6kKzA2MO83Pyxx78ySJVKjPOPECcKsEcYoiRvNm2WkL49VhX3
         8eb5XXfthskzrY5ie7JhJzCa5ID/LNudJSdiOiqi+oTMaL1Kw7PXlN3wKlFqFTs7yMPW
         gwOTf7N3Gdz0UFPqMHT/a09i9YRXBTxJv490H3dwghvf1nNzSZ0lsl30g+bF0wRdjHDc
         nWjw==
X-Gm-Message-State: AOAM531b6yuyRHU/4XDYa9146Cv3vHubKQqjh4vuJnVUb597L5kPKUKl
        VJeZL6xj8OnuMjfgb0+fmiY=
X-Google-Smtp-Source: ABdhPJwsL99TvtQyojanu46kbDDhbRWwu2OTccpMR9piLyYX8Y4B2xwMIre0FtNjCSMCYj64Pj4l7A==
X-Received: by 2002:aca:2318:: with SMTP id e24mr20338698oie.179.1623082580160;
        Mon, 07 Jun 2021 09:16:20 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id w20sm799433otl.51.2021.06.07.09.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 09:16:19 -0700 (PDT)
Date:   Mon, 07 Jun 2021 11:16:18 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Dave Huseby <dwh@linuxprogrammer.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Message-ID: <60be465278003_39c0a2084d@natae.notmuch>
In-Reply-To: <874kea543g.fsf@evledraar.gmail.com>
References: <cover-0.3-0000000000-20210512T084137Z-avarab@gmail.com>
 <patch-1.3-d18a3caa07-20210512T084137Z-avarab@gmail.com>
 <609ba00a1c03b_6e87020886@natae.notmuch>
 <874kea543g.fsf@evledraar.gmail.com>
Subject: Re: [PATCH 1/3] SubmittingPatches: move discussion of Signed-off-by
 above "send"
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Wed, May 12 2021, Felipe Contreras wrote:
> =

> > So:
> >
> >> To improve tracking of who did what, we ask you to certify that you
> >> wrote the patch--or have the right to pass it on under the same
> >> license as ours--by "signing off" your patch.
> >
> > Cheers.
> =

> I think these are good notes, but in this commit I'm merely moving
> existing lines around in the file so that 2/3 and 3/3 make sense, so
> I've left any change to the existing text out of v2 of this series.
> =

> I welcome an effort to improve the existing wording, but I think it's
> better if you submit your own patch-on-top for that, I'd rather not get=

> bogged down in that any more than I already am :)

All right. Fair enough.

-- =

Felipe Contreras=
