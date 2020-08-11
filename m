Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6F5C433DF
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 20:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 302372076C
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 20:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDnDGvF6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgHKUjQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 16:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgHKUjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 16:39:16 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEA3C06174A
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 13:39:15 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id b26so6680088vsa.13
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 13:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2gmML0pfSKComBef/TzlS9hekEa9LYRWyyFVOR+P/Jk=;
        b=HDnDGvF6qWRP6fas7/tTJ9hX1BvWow1QhSvuRKk0kzmMU+QfujLGCJ50mKiMqSW3Pi
         RN1tf6E5tsYc2t5YQgUSvACfZVZmqQZboW+UJ2ZWgNePs0UKGi7eA4K3nyA1zuB4W/iC
         geC9Ia/6bmtoIiViFNT++C9jLDqgv4NfkYz/NpxyNxHu4y3LFK0RbSZ20m7jV1ZLLk1C
         2psF7GT0S+tOHdURbJmbfoLqph47vmtzvfH2FYPoulRi71Qocwr8uMACcZWhVp9VWnnl
         AYZcVyQa9MscK4DPntIIflzXpuwFQPyGgErJeF6R/RLC1mBEwojq9YcBGbmAMsUJNm+r
         gK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2gmML0pfSKComBef/TzlS9hekEa9LYRWyyFVOR+P/Jk=;
        b=JKYkxVCy3UgSTrEmeHuLmBURjaNGLJcSTT7bXg/qH/QSuAW/LM6KCcX6ZrAADGW0gs
         H3a+aw9TeJTOXRH3r1oGbrIuYA7mlnpugsKB8oZCoDXVLXKRMjXuGui9yj4jM0cnKcNa
         T1dzqQDfq2Fy4MKbjp+/2CoUvHss7qeEPSNz8o5NRs7rhekw9CXHtFhn9UdlnvT9pw6t
         f9sk0JNL4pu5X3676J9ddqHAJOHc5Es8gdfQhzIiqgR2n/8Zmr0OvXdeyjreDJ6X7N2V
         QHkX6UKAj6yf1dB6K9Rch0/8IBZs7pQ46TGxvxw8PcPVAx68k4Yigxe3WfaDaexl94dn
         eK/Q==
X-Gm-Message-State: AOAM530mZrUK/nxdmA5jTtDAXRg5m4SngWMVF9xGXr81xkK1TwLLKArn
        aIgTHX1FQkg/9dL4ARrQ1lzcQ5ftt3B8MwZokONWN7fs
X-Google-Smtp-Source: ABdhPJzTDiMTsiyNL4nB5zjtwMeeEjoam9wTWjGYvlKatxdLL2QVp9BLQwF7D1mz0pvd9M9YjmfrBSkurHfVoJTRq7Q=
X-Received: by 2002:a67:bb06:: with SMTP id m6mr27084248vsn.54.1597178354886;
 Tue, 11 Aug 2020 13:39:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200728202124.GA1021264@coredump.intra.peff.net>
 <82991f30-fe37-d6d2-ffd5-8b0878f46c83@web.de> <xmqqk0y59fdg.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqk0y59fdg.fsf@gitster.c.googlers.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 11 Aug 2020 13:39:03 -0700
Message-ID: <CA+P7+xq_eGaGNXd+0Ggxzofa5M_uESVXDaA-0ktH34fuONya0g@mail.gmail.com>
Subject: Re: [PATCH 0/11] renaming argv_array
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 11, 2020 at 12:02 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
> > 7.31.13 goes on: "Function names that begin with str, mem, or wcs and a
> > lowercase letter may be added to the declarations in the <string.h>
> > header."  So the names of the strvec functions are reserved.
>
> Ugh, strbuf functions are reserved, too?

At least that paper is proposing a better solution in the long term...
