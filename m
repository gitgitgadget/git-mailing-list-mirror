Return-Path: <SRS0=LMRs=AT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C80C433DF
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 17:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEA6D20658
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 17:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmbvDwFg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730818AbgGHRF4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730294AbgGHRF4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jul 2020 13:05:56 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC909C061A0B
        for <git@vger.kernel.org>; Wed,  8 Jul 2020 10:05:55 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g75so4007616wme.5
        for <git@vger.kernel.org>; Wed, 08 Jul 2020 10:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KOZtZwJEsAJfgZzfELGbroTLNHrnIE3GkMlMDq14ZG4=;
        b=LmbvDwFgSHbQKGDAgVlbaqOxsiqSKRFpC8IuwgGuvOrhGdp9rCRbEVtWyfW874t7tP
         XRcY+Vs4x3O8W7mYBwO6RgJQgN9xS3T1gQSCz84ru7gPWsCvXOmppTtemNTku74fDKxw
         4Qj1vVCb5F4ZbBy7CHx2pJi7kEZSjRrZB0Yeb4t3bcgagiNaPO56IOUou5w6YkTgNPzz
         e8dqcb7/rqk2eNbIgFfvlHpEAoqHd+g+mu6ueichJcop3a+8t/9l8iOuBUVBsp+hj+pH
         OxzuvEqoowjdxJCrDS5FeV4DZ12DLxz7Cc+3BPSV2kUTNdOo23ud68oUWEZgOZq87v3x
         mUMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KOZtZwJEsAJfgZzfELGbroTLNHrnIE3GkMlMDq14ZG4=;
        b=RfacIEJ7ijO1YRRHhQVNmNrHN5YOSP8V8gWBDrLkiGe71ymlQg85KPz067YM6pd0L3
         V5W7U28z+hIqh46tZ4v6znQHm6cwgE42oyEQ0oJ+zamJjtJa2br4uoSxNRIQA3Q947C1
         oPeX467snaKwnhwzsmBiJCl6k3ea0cVDNrDfj8uDWymLA5eRxnBQfrfPHgvKv2ah/NL3
         Uvs5eiTarLlgeyxvpQE1wz/2Mt3V+Ll9ZsFZi52VsBVdXrLVYGmFASWJF73hgWTqdp9b
         wv1J6wnW0NnD0CMUY7P9wn7daf6oqmv62mGy5agUv0Fmfvm0bn4Ief79OttnZNWXf6a6
         5zJQ==
X-Gm-Message-State: AOAM532nH3IxUKNw2adgc4qI5zV/P1MvyxoXLyrrkBcIRXgGUle1lcpm
        DHaGhiL4AOgYLR4qJeT2OC+awAKPAiCQwoJQlEU=
X-Google-Smtp-Source: ABdhPJzbAYd7FwQ4N8H9qOIHM7JUyr4wM0JzooCZfHDijgX6YWWRqYVP13zxhONYg/br0A0RuB3Sy1kTk0W1LiKGwUw=
X-Received: by 2002:a05:600c:241:: with SMTP id 1mr10138022wmj.119.1594227954623;
 Wed, 08 Jul 2020 10:05:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200707235436.GH9782@camp.crustytoothpaste.net> <20200708043819.GA2303891@coredump.intra.peff.net>
In-Reply-To: <20200708043819.GA2303891@coredump.intra.peff.net>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Wed, 8 Jul 2020 10:05:44 -0700
Message-ID: <CAPx1GvfLpTR-weVQcWm5iX59cmCh2Gad+vU=ESqqLkCq-O5RmA@mail.gmail.com>
Subject: Re: [PATCH] diff: check for merge bases before assigning sym->base
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 7, 2020 at 9:38 PM Jeff King <peff@peff.net> wrote:
> I suspect the solution is [to call die one line earlier]:

Oops, yes.

> I don't see anything within this function guaranteeing that rpos is set,
> either, though I suspect it is OK due to how the revision parser works.

Yes, I am depending on the revision parser to balance the left and
right items.  I thought about having a BUG check but it seemed
unnecessary.  On the other hand, I'm avoiding depending on its
*placement* of left and right items.  Being more defensive might
be good here.

(I had a version of this that also implemented Junio's suggestion
of not first marking all bases, then unmarking the chosen base,
but in the end it came out to the same amount of code.  I could
resurrect that if anyone cares.)

Chris
