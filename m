Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217A6C4707A
	for <git@archiver.kernel.org>; Fri, 21 May 2021 19:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF1F0613D1
	for <git@archiver.kernel.org>; Fri, 21 May 2021 19:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238393AbhEUTUr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 15:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234961AbhEUTUp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 15:20:45 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95888C061574
        for <git@vger.kernel.org>; Fri, 21 May 2021 12:19:22 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id v22so20664722oic.2
        for <git@vger.kernel.org>; Fri, 21 May 2021 12:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=CQx+4G4XhvRbsLIEUpUxgHN3t/u+ngRydMgjmPNWMmI=;
        b=Hmex1RH7dQv3rQTRSyknKwcsis4Va6PyVcYdNICIC+xr1NQNFPKcIOufaPhgyp/Gr3
         IblBnPMjvsmGv8DQFo/8pPFO2CWYOnNzGh5Qg88F1kDHhhEuM/1U2e/pQpEacuIWz9NJ
         n6zZUsmgqzatcAFpp8dTRWVZNo/vICOSQC58Hm5/j+aiblsNFLqBt2mXHUw4V97cy6Vt
         jNFSv6Q2eI1SRCnSP3gc/LMbfAKqjrsf2W94a8F0Iq+Yhby4QE14M/ln4dF7MJ5f4EV5
         EIIrDCuJWmY9QO1FuA5R88cnTCx8Fd3oQaoHI4NpilaT4rAu/796OUvJBXRJefQOp3aG
         k6tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=CQx+4G4XhvRbsLIEUpUxgHN3t/u+ngRydMgjmPNWMmI=;
        b=DlE66XsbIQAQwHoXInisXRx2kf4f8PGsD1aqTbSgK/nInT6FeaFj2SBEzXRSqTCft8
         KASJd/jYcXjd83yiMwNi1bQ315xowqlicLVH4rpEvZGjk8Z+xeTpLagvWBZfS+9QU0Yi
         m3L3QzqA8izyUG9eBll8trKs/NiqcZXtWuQdRYPvqbC1peUOx/w7ipE/Kn91wBePbCCd
         YAkm1D/72tOGtyyXmmnFTdSzwNvy4bG1uZ48BoogM3y8IRiuP1HgMNfKpV8qq6JnfEZG
         W1pSxhgocaeKd5YOFGraEb+Sh2f6aVxauLE/nAximBjAb6vvNsNs+We7gCc+dWUGyxRF
         s42g==
X-Gm-Message-State: AOAM530HOa3+WPLE7i+YlDRLY/Vtlt/xgCK/mvhMaM2vqclTBcb4D41Z
        1WgE8v7RoHgeFBevlqNMH3E=
X-Google-Smtp-Source: ABdhPJyWhxiSTWFQbn+slH8YrYAR3qncIcPaPI/47ThyqT0EmtSibpw/Hpzd/gUfO7KRwlUyc6g5Vg==
X-Received: by 2002:aca:44a:: with SMTP id 71mr3197226oie.39.1621624761814;
        Fri, 21 May 2021 12:19:21 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id s6sm1431737otk.71.2021.05.21.12.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 12:19:21 -0700 (PDT)
Date:   Fri, 21 May 2021 14:19:20 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Message-ID: <60a807b82f6aa_558062081c@natae.notmuch>
In-Reply-To: <xmqqv97g2svd.fsf@gitster.g>
References: <xmqqv97g2svd.fsf@gitster.g>
Subject: RE: [PATCH] revisions(7): clarify that most commands take a single
 revision range
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> +Commands that are specifically designed to take two distinct ranges
> +(e.g. "git range-diff R1 R2" to compare two ranges) do exist, but
> +they are exceptions.  Unless otherwise noted, all "git" commands

Not sure why "git" is in quotes.

> +that operate on a set of commits work on a single revision range.
> +In other words, writing two "two-dot range notation" next to each
> +other, e.g.
> +
> +    $ git log A..B C..D
> +
> +does *not* specify two revision ranges for most commands.  Instead
> +it will name a single connected set of commits, i.e. those that are
> +reachable from either B or D but are reachable from neither A or C.
> +In a linear history like this:
> +
> +    ---A---B---o---o---C---D
> +
> +because A and B are reachable from C, the revision range specified
> +by these two dotted ranges is a single commit D.

  For example, if you have a linear history like this:

    ---A---B---C---D---E---F

  Doing A..F will retrieve 5 commits, and doing B..E will retrieve 3
  commits, but doing A..F B..E will not retrieve 8 commits. Instead the
  starting point A gets overriden by B, and the ending point of E by F,
  effectively becoming B..F.

  With more complex graphs the result is not so simple and might result
  in two disconnected sets of commits, but that is considered a single
  revision range.

-- 
Felipe Contreras
