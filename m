Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FE1C2BA1A
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 07:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00E3420700
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 07:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+xiaelA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgDXHZN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 03:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbgDXHZM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 03:25:12 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC7FC09B045
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 00:25:12 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id e26so10845971otr.2
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 00:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=qNue1qVc/LLMZ1F8ZGQqzU/kiJ0a9KIA0/DA0aaiKdc=;
        b=B+xiaelA1X0dUYNb+GmClCAOSabnms+Yx1xhvHIlIV+o03GOQDPwB6iBae2nzGrDH2
         mwTchi+X/JT2uyxDlgRvTx1IUTNIrTpkYDYbDRNsRF6h+YQ7T3GZhwSWhnU3kFzvtzhN
         7hod9fHqWalfuk72AneMXuLBc0KXO22mixX5RHNcV+IhkaGc/ZygKvh94sL4GD9ccFrl
         UHmriMYKPUgOkBw/Cz0zgRgQA2n2yeBAYLzoNZdx1rDgkbEfi2jlBS6F1143kQzWyv0m
         2pjE10O6V/E1aLQG8s9GrQN2mOojC6O3fKS3Vem+Tki/lhgpB1myYt95qv337tZpwq70
         xtkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=qNue1qVc/LLMZ1F8ZGQqzU/kiJ0a9KIA0/DA0aaiKdc=;
        b=n89lTIZn7hwEaWfwHx2mEaCg9NBgyq3QejoFLdqtbusXT+rgCQIdtI3ygsnBlQ/GLb
         /s4jOLOOP8mEuNzHXlEL659hLeKI7r/TUhofwdKAzlEXtY6/I6cEiASWvOXZOBbnQphC
         5l1xuoNiE5OACb/KMCMpqHxjgjUrMuKWjMFcVXbMtA6fMjKRZiJXOzOCwdtJbvPSc/z3
         1H/zaFybZ+Nf0MC9m4ljTtjX4QN/liXzZxnhnGGnSNfR2iDVyQTL9rqYgxfrxFKHCTsl
         MSisvIkAvNAoqEpq3p9sHZgoVbAWRGQOX1lI0UvWOShQYzfC9rO3ANkr0chbGE39OgKW
         MJ1Q==
X-Gm-Message-State: AGi0Pubxd8zTZwAzdLwSS4qbcA1FR8opVw8617yubQhaSeLtisMMzsY7
        +RFY3KbiX6EDbBD1ObUQ4IIrw73gfgVaIgcpYEVr0bJ1
X-Google-Smtp-Source: APiQypLJ06PBhQFrIAVVma/o7dSgCtpXIXSMD6HUfLxKw0uliSCakb5yn/2W6w/qjZg7Elj1dS5ERA3vWYJqjGIyopM=
X-Received: by 2002:a9d:3623:: with SMTP id w32mr6835082otb.94.1587713112024;
 Fri, 24 Apr 2020 00:25:12 -0700 (PDT)
MIME-Version: 1.0
References: <CANYt6aFi+6vKRD71digEh-D0RKkLPBRtek5t8zA-8_cPzwexkQ@mail.gmail.com>
 <20200424064805.GB44448@Carlos-MBP> <CANYt6aFjp4wVzYk85Ag9mH3AWp4qUS3+4xsGioyQknKz9tmRUA@mail.gmail.com>
 <20200424072049.GC44448@Carlos-MBP>
In-Reply-To: <20200424072049.GC44448@Carlos-MBP>
Reply-To: lars.fricke@googlemail.com
From:   Lars Fricke <lars.fricke@gmail.com>
Date:   Fri, 24 Apr 2020 09:25:02 +0200
Message-ID: <CANYt6aF1o9fmK2rwAA-LPSbd3TeW+x+6LdUj99sg_ANy3Q0kJg@mail.gmail.com>
Subject: Re: p4merge no longer working after upgrade to 2.26.0
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Setting path explicitly does not help either. Some other colleagues
are having the same problem.
So it might be related to our OS (SLES 12 SP4)

Thanks for your help so far. As you said - the issue seems to be on our end=
.
I am currently digging through git-mergetool--lib.sh to find out why
it thinks that p4merge is not a valid tool.

Thanks again for your help
Lars

On Fri, Apr 24, 2020 at 9:20 AM Carlo Marcelo Arenas Bel=C3=B3n
<carenas@gmail.com> wrote:
>
> On Fri, Apr 24, 2020 at 08:57:27AM +0200, Lars Fricke wrote:
> >
> > git mergetool --tool-help indeed does NOT list p4merge.
>
> but does show if you run :
>
>   $ PATH=3D$PATH:/opt/perforce/bin
>
> > So support was discontinued?
>
> no; something else might be broken (hopefully only in your setup)
> it seems to work at least on mine :
>
>   $ git version
>   git version 2.26.2.266.ge870325ee8
>   $ git config --list | grep p4
>   merge.tool=3Dp4merge
>
> Carlo
