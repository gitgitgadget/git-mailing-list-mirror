Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0377C19F28
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 01:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbiG1BaU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jul 2022 21:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiG1BaP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jul 2022 21:30:15 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB77CE010
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 18:30:14 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id w205so638515pfc.8
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 18:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JTpeqSv8qeVxo4soAVs9rvNu92y6RP1s+AepgoOT/dQ=;
        b=m5gpWoRHEwDvRjHI8ZkEm+0upfkl7cqMLZ/luZ9FJomLyFfj3kFB6PrqLxI8b99c0T
         Lwqrlzk4acb49Gp6CxmugVSPRy2HnGDWqHViYu9WcLbzPy0KSP764RhigOMRMnMxXFAA
         vfi5CPcHRLRSXTwBnBVztPB6LhR9n7tgxz1saE7qLJYFvddkPEU+2LtAjRAPUS3HsoGp
         1WOgDrrM/Iy42I8/vRMq3wz0yQRbzFUWOCr+5bvYaCbd8VrUPeIedcDNUx43iL0qpXPl
         HFMeV5IJEx0/mvl1Gy+vaEosvSWblFdjoOi8WFylh4VioGjLCA+np0VDZCA43xeh3N7i
         /62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JTpeqSv8qeVxo4soAVs9rvNu92y6RP1s+AepgoOT/dQ=;
        b=V7lguRMbJSaOkyogJo5/bcbC8CQkLj5T+bHnLWOIrNbeA40g7m4Hi2byqbOb3vd4CZ
         yy1zZfQAk+/TtSCsDa/M6qv/3B8Qxf74vp9SIK2y4kp712qaHTHe0vCtx56OopqRUaFe
         Io/64UU7pujH4pTz0ZG5t1kzU3jLyHV+ikAQuVjV7h9iJ67pqOfl223nIJBURU+KIFUz
         t8/ZooOxB6lZ1pxOptNGp+P3u508vHFGbjlVU5HGPQcWrgr7aarXhenOClro+3xqpr+P
         YaNcllXyUprcicHJnYr/n+7HL5JgIHROgUCJJ0Q9bTtnVZjyhcgYjLNh3ifuGGx/rgcA
         rRHA==
X-Gm-Message-State: AJIora++lJrFrAKr7WZkcPf97trnP3Z27Kz24In+EXlK7FtPNRA5xKAq
        A7+IBJbvAJhlSsDqpkoEvvQMw5720tQ=
X-Google-Smtp-Source: AGRyM1us0/wUsNhA0M9SXmS6b7DSF1uUtmPQH27soSoD8dUz/ulnMi/62L8pjlL04a7EBVRQxXClbQ==
X-Received: by 2002:a05:6a00:f85:b0:52a:c718:ff9 with SMTP id ct5-20020a056a000f8500b0052ac7180ff9mr24026702pfb.85.1658971814239;
        Wed, 27 Jul 2022 18:30:14 -0700 (PDT)
Received: from jrouhaud (2001-b011-1006-bd86-d4da-1bfc-774a-f424.dynamic-ip6.hinet.net. [2001:b011:1006:bd86:d4da:1bfc:774a:f424])
        by smtp.gmail.com with ESMTPSA id o27-20020aa7979b000000b0051bba89c2bcsm14511664pfp.58.2022.07.27.18.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 18:30:13 -0700 (PDT)
Date:   Thu, 28 Jul 2022 09:30:09 +0800
From:   Julien Rouhaud <rjuju123@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [RFC PATCH] gitweb: improve title shortening heuristics
Message-ID: <20220728013009.pqiobsquf7u6yyb4@jrouhaud>
References: <20220724061231.jddhqns7bqx5c2xm@jrouhaud>
 <xmqqfsiq6ksb.fsf@gitster.g>
 <20220725020534.x33hso22ab2dwyo7@jrouhaud>
 <220725.86czdtrayy.gmgdl@evledraar.gmail.com>
 <20220726135911.ycvgwbkixb3ei6w3@jrouhaud>
 <xmqq4jz3vzgb.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4jz3vzgb.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Jul 26, 2022 at 11:31:32PM -0700, Junio C Hamano wrote:
>
> When you are sending the patch in for real, after making a non-patch
> discussion (all of the above), you can write a "scissors" line
>
> ----- >8 -----
>
> right here, immediately before your "From:" and "Subject:".  What it
> does is to tell "git am" on the receiving end to ignore everything
> it saw up to that point and pretend the message starts there.
>
> You do not want to include "From <object name>" line that is used as
> an internal separator in the mailbox format.  You do not want to
> include the "Date:" in-body header, either.  "From:" and "Subject:"
> are used often because they are frequently different from the e-mail
> (e.g. in the message I am responding to, the sender is rjuju123@gmail,
> not julien.rouhaud@free.fr, and we want the latter on the From: line
> because that is what appears on the Signed-off-by: line).

Ok, got it.

> > From: Julien Rouhaud <julien.rouhaud@free.fr>
> > Subject: [PATCH v2] gitweb: Remove title_short shortening heuristics
> >
> > Those heuristics are way outdated and too general to be useful outside of
> > kernel.org.  Since kernel.org doesn't use gitweb anymore and at least one
> > project complained about incorrect behavior, entirely remove them.
> >
> > Signed-off-by: Julien Rouhaud <julien.rouhaud@free.fr>
> > ---
> >
> > Notes:
> >     Patch re-submitted inline rather than in attachment, sorry about the
> >     previous attachments.
>
> Thanks.  Will queue.

Thanks!
