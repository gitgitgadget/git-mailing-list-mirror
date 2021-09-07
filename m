Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72F4C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 20:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3DEC60E52
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 20:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345844AbhIGUmK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 16:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235991AbhIGUmJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 16:42:09 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BF7C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 13:41:02 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id s16so140666qvt.13
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 13:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=peM+HGe2LFlrcD54RlbXLSf759p+E78mwQeheXjKi6Y=;
        b=XmAtNb7Ckc89X/k3pNK4GDK9RUpgW4C07VITm9kfxwkJ8tfPoQBe9J/vfu2/bap2s9
         gFlt++d5XsZWqpMeq6+Ejv5uWR3c+JSXBOEZunQDcKiuMou8M4V36YZ26UmwBH+eGoXK
         9u6bxJG8qwz1vh8E6WI2HI7nA64oc319EfUn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=peM+HGe2LFlrcD54RlbXLSf759p+E78mwQeheXjKi6Y=;
        b=POR3QH1Akr5ivdaL9ZIN7wIJLlUaoREzFZgjX+PGZNNF9NB7Fg6NCADTQOWNfZiqY4
         s4sHo25KG3yFOr64OKMD01GQZdKKJjXmUDCEZLQuRejHiomap5YJ7ETHQUlIqnwqE/N3
         4CIMgn/ibunaDPLU5f/LzcOVmOJ46JXEHVb05TgBhvonCg/T9W5hW9LcK8f+AarY0P1d
         93tfiCFUneYlaz4qrcQfW9rzBvOYsfNvqhnP1iynQkRq9tU8wLcayMXrZMOeGg0Gs+d1
         exWrMOTwEBE6hXAymD+ofKFUY4BMdVK4g+4AuCOy99/7v6Oci85p2ZVFx4egDub9Xvbu
         rAmA==
X-Gm-Message-State: AOAM530y/ncjOEEGJ4Ok+nqbyIhYJNpd7lGLuB1/XNrJ9BreRRRVuPa/
        8uMGmEwNvVXkozsCrAf07RHMHg==
X-Google-Smtp-Source: ABdhPJw7zejm+jiHnDF1I/LEie+rd+WEPPUxP0WPjuSEVDVDlwO1RaKTboEiKlKa0TsA4/PonBjAuQ==
X-Received: by 2002:a05:6214:a94:: with SMTP id ev20mr19346242qvb.53.1631047261927;
        Tue, 07 Sep 2021 13:41:01 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-181.dsl.bell.ca. [216.209.220.181])
        by smtp.gmail.com with ESMTPSA id d129sm92337qkf.136.2021.09.07.13.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 13:41:01 -0700 (PDT)
Date:   Tue, 7 Sep 2021 16:41:00 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: expired key in junio-gpg-pub
Message-ID: <20210907204100.ptapvn4wrqn3qrzq@meerkat.local>
References: <YTerpXCxYx+f+8ws@coredump.intra.peff.net>
 <xmqqbl54b1zn.fsf@gitster.g>
 <YTfL/eLKOiJdpH1c@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YTfL/eLKOiJdpH1c@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 07, 2021 at 04:30:53PM -0400, Jeff King wrote:
> > I am reasonably sure that I've done update with pgp.mit.edu when I
> > refreshed the expiration last time, but apparently I didn't update
> > the in-tree copy.  I doubt that it is a good practice to ship the
> > public key used to sign things in the repository in the repository
> > itself, but if are not dropping the tag, I agree I should keep it up
> > to date.
> 
> Yeah, I agree that the is potentially problematic: it's a circular
> dependency, plus updating tags is awkward, per Ævar's other message.

It's not really as circular as it would appear at the outset -- at least not
any more circular than any other situation, in reality. E.g. my favourite
example:

1. you should verify the checksum of your distro's ISO before installing it
2. the checksum is available over a trusted https:// connection
3. the trust anchors for that https verification come with the browser package
4. which was installed from the ISO you downloaded the last time
5. goto 1

Bootstrapping trust is a hard problem and no matter how you look at it, at
some point you have to just close your eyes and hope that the adversary isn't
one step ahead of you.

So, I'd say putting the key into the git repository itself is fine. After all,
it gets imported into the local PGP keyring on someone's workstation, where it
gets a separate life of its own.

-K
