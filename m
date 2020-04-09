Return-Path: <SRS0=Te6D=5Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D95C2BA19
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 21:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 335802072F
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 21:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fU0oe4cj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgDIV6h (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Apr 2020 17:58:37 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33376 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgDIV6h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Apr 2020 17:58:37 -0400
Received: by mail-oi1-f194.google.com with SMTP id m14so1277691oic.0
        for <git@vger.kernel.org>; Thu, 09 Apr 2020 14:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gedGrSDEHwVU6Kx2sriNPwmlF8SatychkJLQnVOS+Jc=;
        b=fU0oe4cjMSsySpaQk2fAjvQDSR1+D/qtAeARV4puqtAhGfhwWsI0G/tqPeubLCYLnX
         jqwmHqKhI9qj4+7ONYh2xRkcc8XiPrVjLpL+KzkSGm/fAooO8uGq/fKu2RfXXiyefR2g
         Wta4ZDzzIizWYfBAWuvOCdJWmP9KgQa4X86qCbQqBprR4dvEsq+z3fMybcTWF6XHSe9Z
         3X3ljlMmpyd/QSQLEtF4zUzE21DPFUhlYbj8HTHvsbrv9aGoQegvdyLg+9I8disDcQe+
         MgeUk4izwa2rnidYf8l52FiJu2l52UgPPRBVHYPlmIji8/Kpj5FNpO6SFIT+hTkqSmUN
         8t/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gedGrSDEHwVU6Kx2sriNPwmlF8SatychkJLQnVOS+Jc=;
        b=lNI5jjrv+zhpH9Aq/v5L7inJakHXrC0RXJO6mE92eAOjnS2La3K5a8+/NY2L8/dFJD
         /ylk8+UQSqb0V/D3oO7mN/TPfZww0PCbunI9KF7LkM/vi8B7BMPTjdYmmJTcGRKnRsri
         7yFqUqlvLD1m4bK8wdNr2c/ZQl7uJbVP+ZmJO+g5cmsVU850QjEQXQwGf30AmTTqqz4u
         e1B/dPqrrjqd5O9gQe62JoR9/sm4d0wrsrgi9hniL1NiQiIoV/GuVpkX3dx1fXBUvzqd
         o9sg6EbkG8e6GakOJo8/39bLSRnV3ELUYtdDYuF2wmm5Y/ki+PTBuSl2YZGe26KVB8CB
         +biA==
X-Gm-Message-State: AGi0PuaXtocXkt56bEqqndRdzf0bznhULHbi7pcwOIJzEz7/MWk2EW1J
        KYqc/KpnZ3l25uxueIf6bU5Z2y7K/yz2wiJU4eTK+44p
X-Google-Smtp-Source: APiQypKC8KEhGqgklehMVqzPbyubJ+WcudiHViA+FhQz6FZTGadvJLabDI3GIcA2fO+UOn106aCcTHw1GPbuJFgoHYA=
X-Received: by 2002:aca:df45:: with SMTP id w66mr1220226oig.76.1586469516985;
 Thu, 09 Apr 2020 14:58:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAM+g_Nv4UqQNAuYyo5zsTsiomCe4ueoM6ZGU1aqAjLGV9+jQJg@mail.gmail.com>
 <20200409135959.GB3494212@coredump.intra.peff.net>
In-Reply-To: <20200409135959.GB3494212@coredump.intra.peff.net>
From:   Norbert Kiesel <nkiesel@gmail.com>
Date:   Thu, 9 Apr 2020 14:58:25 -0700
Message-ID: <CAM+g_NuZ3pKAd80+HoR8-_0=N9wV28L-yyb1VhJhTbYH+RS0og@mail.gmail.com>
Subject: Re: [git 2.26] stat counts reported by commit and log are different
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the explanation. I still wonder why break-detection is by
default enabled for commit but disabled for log.  Is there any
rationale for this?

On Thu, Apr 9, 2020 at 7:00 AM Jeff King <peff@peff.net> wrote:
>
> On Wed, Apr 08, 2020 at 07:04:02PM -0700, Norbert Kiesel wrote:
>
> > % git commit -m 'major code cleanup for SCIMPatchOperationUtil'
> > [nkiesel/nextrelease/SCIM_2 d4db6f6d83f] major code cleanup for
> > SCIMPatchOperationUtil
> >  1 file changed, 2106 insertions(+), 3367 deletions(-)
> >  rewrite utils/SCIMPatchOperationUtil.java (74%)
>
> The commit summary diff is done with the break-detection option on. You
> can tell it kicked in here because of the "rewrite" line. What that
> means is that the changes to the file were so extensive that Git decided
> the file had been totally rewritten, and broke it into a separate
> add/delete. That has two implications:
>
>   - we'd consider it a candidate for rename detection; that didn't
>     happen here because there were no other files added or deleted to
>     serve as source/dest candidates
>
>   - the diff will be reported as a complete removal of the old content
>     and the addition of the new, _even for lines that were the same_
>
> > % git log --stat -1
> > commit d4db6f6d83f (HEAD -> nkiesel/nextrelease/SCIM_2)
> > Author: Norbert Kiesel <nkiesel@metricstream.com>
> > Date:   Wed Apr 8 18:49:27 2020 -0700
> >
> >     major code cleanup for SCIMPatchOperationUtil
> >
> >  utils/SCIMPatchOperationUtil.java | 3807
> > +++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------------------------------------------------------------------------------------
> >  1 file changed, 1273 insertions(+), 2534 deletions(-)
>
> But in git-log break-detection isn't on by default. Try adding "-B" and
> you will get the other numbers.
>
> Try also adding "-p" to see the whole-diff in action.
>
> -Peff
