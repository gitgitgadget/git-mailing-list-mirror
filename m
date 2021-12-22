Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77575C433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 15:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbhLVPpi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 10:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237238AbhLVPph (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 10:45:37 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892F3C06173F
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 07:45:37 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id a11so2635591qkh.13
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 07:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=IUrkKdtOzxSo98zMs0ovNAZ/Aovw4WSBEPDuVW3YuMI=;
        b=Cg5EmYFElRUjPsG5yBxvWK1H5kwJoV5OA/MAkcgo6uNjHlknp4mKRsry3qCdTgPFYI
         kHCSwz3mL5jjQ2zbCz96kdLI13mg3nlEhK/n0siq4oj0LdZojsRSQkmRWcylfiKLjwom
         NHwa79OoH+uB+Cx9SioephvuFql2Ouc0gx0P8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IUrkKdtOzxSo98zMs0ovNAZ/Aovw4WSBEPDuVW3YuMI=;
        b=MRf9slK3fqaZqButAaU2T/wK0+vzAylnfUpzcdcRPtRgwteTZ7273aeylDN24Vitsl
         h25eENfsLz86qMaagC4JvRXUozRC8sI5KBmqJUS1MzSH5QDzRcH0pXbHH7A9dhBPrRdG
         ks84ptNTddo1oR3h6JWl48iUNcQeSKPpYXk5uV9kfeL0pGjKcjOFBpNwdgyS+jeMgRam
         yOQ8U5GmKDlmNrAs/8NF/iUAvLpRHOusI/w9luoFq6Y+rpfg0YIwaglyUOJatTb1Veg9
         B95pILTp3c/o1rbv4XYKapJBBB4td8k+swvXqW5wMhfKfnFpDU0/h41sQitg2gUvUlqD
         Wkmg==
X-Gm-Message-State: AOAM530Q1oGlDmyt2vmk1DgVxN4LP/M0Pz6aw1fxl6oNumEv41mMahkN
        Jv4mYh+8UuoOxduA/Tlng/Q/X0SHsEr88A==
X-Google-Smtp-Source: ABdhPJz7OMysdxDff74KwYKfTOm3xyIt+wq1gxE4fvCbad8xy2Mtmucc779MicGahaPbiC/hbF5REg==
X-Received: by 2002:ae9:eb0a:: with SMTP id b10mr1365386qkg.291.1640187936669;
        Wed, 22 Dec 2021 07:45:36 -0800 (PST)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-181.dsl.bell.ca. [216.209.220.181])
        by smtp.gmail.com with ESMTPSA id y16sm1906680qki.41.2021.12.22.07.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 07:45:36 -0800 (PST)
Date:   Wed, 22 Dec 2021 10:45:34 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        jrnieder@gmail.com, jonathantanmy@google.com, steadmon@google.com,
        chooglen@google.com, calvinwan@google.com,
        workflows@vger.kernel.org
Subject: Re: Review process improvements
Message-ID: <20211222154534.b2gb22ghn2mpyeur@meerkat.local>
References: <YbvBvch8JcHED+A9@google.com>
 <20211217183942.npvkb3ajnx6p5cbp@meerkat.local>
 <211222.86ee65pb60.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211222.86ee65pb60.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 22, 2021 at 04:26:39AM +0100, Ævar Arnfjörð Bjarmason wrote:
> That GGG does this is one reason I haven't considered using it. It
> breaks all sorts of E-Mail workflow assumptions from polluting the
> address book for every person who uses it, to any "from:<addr>" search
> needing special consideration etc.
> 
> Of course you'd need authentication etc, but is there a reason for why
> such tooling can't work more like an SMTP relay and less like GGG which
> (for some reason) insists on taking over the "From" header?

This would require pretending that we're authorized to send mail from the
domain name of the commit author, so this unfortunately won't work (and hence
the reason why GGG does it this way). E.g. say you have:

From: foo@redhat.com
Subject: [PATCH] Fix foo

For DMARC policies to properly work, this message would need to have a DKIM
signature from redhat.com, so we'd need to have access to Red Hat's private
keys. If we don't use DKIM signatures, then the recipient SMTP gateways may
mark the message as spam (and they would be right, since we are pretending to
be foo@redhat.com, i.e. acting just like phishers).

The only way for this to work is to do the From / X-Original-From /
Follow-up-to / Reply-To header dance. Git does support this very well, and
most email clients do the right thing when encountering this situation, but
it's not going to have the exact same visual flow as patches sent directly via
SMTP.

However, we will also write these messages to a public-inbox repository before
making the From: substitutions, so if someone retrieves these patches with b4
or lei, as opposed to receiving them via their SMTP mailbox, they should be
able to get proper From: in the headers.

-K
