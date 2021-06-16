Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EC9C48BE6
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 20:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83DCF6109D
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 20:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbhFPVBi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 17:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbhFPVBh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 17:01:37 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E71AC061574
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 13:59:30 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id x196so3952561oif.10
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 13:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=h5GY5ktj3e3Hieqb2Y35mWgNVmjw4lr/QAZHrsIA71w=;
        b=aT7/QSKiphj8DqAECkI/Z3UTMy9VhwFO9zqFIwh5bsXv0t2/Zzg30PcN7BmGVUetfN
         Z1+Mr/Sj1pAUG+6trOLdA/sHKx3TUVRFD0Y4DwSJmZ0fo/n3d54tBn5fKDZn0txXCLQz
         1x2wABefUaD1ZRSuvdgmXlOjoCoQW1MlDhQQEUwBFAlj5wkd+RFLCcB2BXAGdAd5B6KF
         TIHEkYTcWtEdGX2pL3wksULFAAryzmHBiJAqGxXJh+1WO0lT1BIuSk53oE5Ugpjsrjxf
         2Wc/DEHDaJjjy9T4E2UkHvfbNtLDSHQNawqOCYM1H3Ywed8ib6AH6ccNH55g+jO3O7qq
         Dcog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=h5GY5ktj3e3Hieqb2Y35mWgNVmjw4lr/QAZHrsIA71w=;
        b=Of8FoXxywxdZPWsxqujbpE+12Hrnfmt/ef0+EKueAEquiVexJzOVtaCHv/OpiZyn7D
         6OAWnGmYxXTm0v5XNI9pACrFC5c1py6HW69gtgXzFy327HIGQjEUau8c3yj0cQlfCaxt
         d7tVXmOAWD/KLfHSAfbYTsZIas1sGZWST8mfl0qX5oH17nRztXGXwIrnhz+jZ/FNw7aO
         8Xp4ZsecrmMKy8SqR25LAyZdMFver5HIPaTM6W1I8TuaP9KFx0jhcHISie+IFGILGQeX
         /xjA/kX4ZQvfvF+JhF++tGmLKP7aLoMJYDAi/n8O8lDZLHmfxz/Hcfrv7ZgHavkQbUU4
         +wmw==
X-Gm-Message-State: AOAM533kyJfA8BvjTMLlvGl3RyW0gRr8XFzaqdqKoaW5NBECbPSITuQb
        2a/k7kUtknozFIaFJ4FlLz4=
X-Google-Smtp-Source: ABdhPJyEM9Vl8Zxbwfv1dUWwIg6NsrmKZC8LZ/pC41BOhjto9BAc2DwFh9yVu5uPj0HM6hm+7SwfrA==
X-Received: by 2002:aca:ac47:: with SMTP id v68mr986548oie.160.1623877169827;
        Wed, 16 Jun 2021 13:59:29 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id x7sm764763ooc.23.2021.06.16.13.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 13:59:29 -0700 (PDT)
Date:   Wed, 16 Jun 2021 15:59:28 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Emily Shaffer <emilyshaffer@google.com>
Message-ID: <60ca66304a0a0_6027208c8@natae.notmuch>
In-Reply-To: <xmqqfsxitw2n.fsf@gitster.g>
References: <cover-0.6-00000000000-20210615T161330Z-avarab@gmail.com>
 <xmqqfsxitw2n.fsf@gitster.g>
Subject: Re: [PATCH 0/6] doc: replace "alice" and "bob" examples
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
> =

> > I suggested in [1] that the "alice" and "bob" examples in our
> > documentation would be better written without a reference to such
> > fictional characters, for reasons that have nothing to do with trying=

> > to bend over backwards to avoid any reference to people's gender. It
> > just makes for better documentation.
> =

> I actually do not mind cast of characters with concrete names,
> especially when there are more than three parties involved and
> having names for them help clarify the description.  But I agree
> with you that Alice and Bob should be reserved for situations where
> appearance of Eve would reasonably be anticipated, or the use of
> these two names become distracting to those who happen to be aware
> how these characters are often used in CS literature.
> =

> Perhaps s/Alice/Tabby/ and s/Bob/Fido/ or something like that ;-)?

I don't know anybody named Tabby or Fido (or at least any human).

Maybe Mary and John, or Linda and James.

-- =

Felipe Contreras=
