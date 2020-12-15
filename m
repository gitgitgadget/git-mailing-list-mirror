Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292DFC4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 02:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE5E62231F
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 02:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgLOC6H (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 21:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbgLOC5v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 21:57:51 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB73FC06179C
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 18:57:10 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id j20so13504673otq.5
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 18:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=NJDRMcJKP77QIWf+f5rF+XPhVIb6Afh3L1Irs60VaJU=;
        b=u8neiBlYbkM/wNEe6Jy2lJaaC8FybrCfsuH1bFkOlES4Crs8WE73pxryHMGHPyF5x+
         Eur1sDkTi22hhqQBqQkV5OZ8Wh/v5xIhocETzDOmbES+ThLidfWhMuh4b/WpwdYXtHUW
         U65XOodTJ73oFuSBSAek1uolvG6ic2raHgL8+Yxkwf86dYu55TvHWlRY/oDtrg6p5O3o
         b+atUyW3VgZK3EITNSO2oHCPBnuSJmCNIDsr0SCLdR9uQjEFXa3rfDoA8HpthHkqZNPI
         yST/19Zgom/rzGlIJMXmrW+B9jeFL+Y3kscbH/gTtgDdjpqqV5yV/jYFVw4AF6CjgSTr
         XNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=NJDRMcJKP77QIWf+f5rF+XPhVIb6Afh3L1Irs60VaJU=;
        b=kXcZR8vTQf7nXMPIReLl96jE3hg0J5hv2cwA0ZCM4zJ7+ry4CcFfdauN1mSh/j8ysH
         kjpac3wcnHnsAZiNseqVvlRApZUrbYJyqRSyd4K9uPfaRuZAZyQNkVFnFGyfbD1Ymy8X
         0klammEK7OIWEyrQ2QhHh/p8eWvbjGu7ZJSi6gU34y/WQrW9d7OuiO802gQC3BlMwe0e
         bo8Ay4mx0tj3VePja/4klVNuD4DYkxyiJ9WDVytrk/rL6/ESgs/CUoHkamYEjzGc0nTb
         dLay/jbHVoeuVkgCYMv/ejmHhVNvwcOCqjmanUTP8l0EKblLBIcbrnqaGiD+EtuLEu7x
         ITkA==
X-Gm-Message-State: AOAM532dfreoE8N2kaxqFhnHDTeCdaqg8MAWFzJIbmBJWkJvRDXz98wR
        x33Mg2794/wY+7rTtuTz56Y=
X-Google-Smtp-Source: ABdhPJw0cUrQ98vU+ipwjT14f3jgXYNV47KkdbIXmUVb2K1KAal/pCkG/NXyPx/S4E8SlW6xJGew9g==
X-Received: by 2002:a05:6830:3106:: with SMTP id b6mr15651488ots.36.1608001030358;
        Mon, 14 Dec 2020 18:57:10 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id l132sm4715781oia.23.2020.12.14.18.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 18:57:09 -0800 (PST)
Date:   Mon, 14 Dec 2020 20:57:08 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Message-ID: <5fd8260432a08_d7c482083c@natae.notmuch>
In-Reply-To: <xmqqmtyg9dq0.fsf@gitster.c.googlers.com>
References: <20201214202647.3340193-1-gitster@pobox.com>
 <20201214202647.3340193-6-gitster@pobox.com>
 <5fd7d82a9b6ab_d44af208bb@natae.notmuch>
 <xmqqmtyg9dq0.fsf@gitster.c.googlers.com>
Subject: Re: [PATCH v7 5/5] pull: display default warning only when non-ff
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> > Junio C Hamano wrote:

> > I strongly predict the conditionals will end up looking similar to:
> >
> >   if (!can_ff) {
> >           if (rebase_unspecified && !opt_ff && opt_verbosity >= 0)
> >                   show_advice_pull_non_ff();
> >   }
> >
> > But OK.
> 
> I may have failed to mention this in the cover letter, but I think
> the placement of opt_ff in this part of the logic needs to be
> rethought, so I strongly predict that this part will have to further
> change ;-)

And precisely because I predicted the same is that I deliberately chose
not to preemptively organize the conditionals in any particular way.

Cheers.

-- 
Felipe Contreras
