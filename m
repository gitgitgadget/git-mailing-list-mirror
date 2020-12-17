Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A553C4361B
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 05:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 343A42360D
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 05:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgLQFmH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Dec 2020 00:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgLQFmH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Dec 2020 00:42:07 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764D2C061794
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 21:41:26 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id d189so30945701oig.11
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 21:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=bWDmeWM49doFmBSWYWwNE9uuIG6qbUYy9h+kW8ru4Is=;
        b=iQZn5Lzqr6efK0NgKtPTh3IPOEffDVD06XuMb55+PX/fLWMyAAJBHClwo1O8BNbjK5
         LlgOKuP2pGrGkxrpg708u7hTedVkIis0ZWx+H5k/u8PMgpMbM7U3/RnHrPrEn1o0wxSa
         PDIS1cQj7GYpcbVpsRqUwihkGY/tg2ki4YrjSsHEN884NB8Ew+HU+TN1Ud5587PEwf98
         H7n74fA+wmtsHyUaF373s8FI+HT5gcdEkF/sHoTYWX5AutIKbsCsjuvk0BD1zpdBsB6e
         x/Yf1YDK4g80y1EU7Dcvnr37X+ftbmnRLdgdO5T2UzywsWEBPQTe1zb+Z/DwO2iStkPf
         9oOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=bWDmeWM49doFmBSWYWwNE9uuIG6qbUYy9h+kW8ru4Is=;
        b=KYb9nRozlW6oL6+M1PaFn+uqYN3Wq3vNeCwUP8T9nnWxLWgtYY79hZI+ZHiTyj+ONE
         01K7FMJ2MXuxqsWLtOW/wuVtNAvtIM1ZylP3+ueFw4ALMFl+KBEHGPiIMEcT7bXoJVud
         itnTbboeuP5A1ktYMtTspC17+st/6zL9ykyAh9IH7ry/slJqoMcSH80c5ivFMQyZZQgB
         LFo07iJySKbK7vvSzk8zwESue/WzKKXvIKz+56wLtJvw9usKIDlFloQQ3vM7Z3pybWe5
         IVXCq9Z8tqVqxc7n9cn2duZe0CGtgRBgyCJbuBuxzsTuUpJr7Yi61pJOgwi+V3gTMv8h
         tm1A==
X-Gm-Message-State: AOAM531Kbnyx9IAERoGRUR/Ak+gpoBRlSTlMO7/FqLnKP1gTYiMX5hYY
        7fVy8fp9xWDsHrjReKmPqXQ=
X-Google-Smtp-Source: ABdhPJzC7ziA7CD3oKRYVhy+TLVh4ssFh+PvJsp5wJyiDIYhiIh7AwXqrg9VqY8+okb2AIEV7lD/GA==
X-Received: by 2002:aca:f289:: with SMTP id q131mr3786878oih.159.1608183685877;
        Wed, 16 Dec 2020 21:41:25 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id m81sm918921oib.37.2020.12.16.21.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 21:41:25 -0800 (PST)
Date:   Wed, 16 Dec 2020 23:41:23 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Seth House <seth@eseth.com>, Junio C Hamano <gitster@pobox.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        David Aguilar <davvid@gmail.com>, Johannes Sixt <j6t@kdbg.org>
Message-ID: <5fdaef83a40ba_d0e26208f6@natae.notmuch>
In-Reply-To: <105041520.23756286.1608159189934.JavaMail.zimbra@eseth.com>
References: <20201216174345.28146-1-felipe.contreras@gmail.com>
 <xmqqa6ud2xuw.fsf@gitster.c.googlers.com>
 <105041520.23756286.1608159189934.JavaMail.zimbra@eseth.com>
Subject: Re: [RFC/PATCH] mergetool: use resolved conflicts in all the views
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Seth House wrote:
> I appreciate Felipe getting the discussion started.
> 
> On Wed, Dec 16, 2020 at 02:24:23PM -0800, Junio C Hamano wrote:
> > If there is none, then what is the benefit of doing the same thing
> > without running 3 checkout-index?
> 
> I wasn't aware of this plubming when I wrote the initial shell-script
> version of the technique. This is a much better approach (even *if*
> there's a negligible performance penalty). This nicely avoids
> UNIX/Windows line-ending surprises, and instead leans on
> already-configured Git defaults for those. Plus the non-text files
> benefit you mentioned is also huge.

I think you misunderstood.

This command:

  git checkout-index --stage 2 --temp -- poem.txt

Will give you *exactly* the same output as LOCAL.

The context is "git mergetool", not the mergetool itself.

> > as I understand "mergetool" is handed an
> > already conflicted state and asked to resolve it, it would not be
> > possible without at least looking at the stage #1 to recover the
> > base for folks who do not use diff3 style.
> 
> I feel strongly that LOCAL, REMOTE, and BASE should be left intact for
> this reason, Also because they aid readers in understanding the
> pre-conflicts versions of the file.
> 
> Rather mergetools (that support it) should be given the stage 1-3
> versions of the file in addition to the usual, unmodified, above three.
> Then each tool can decide whether or how to show each. Some graphical
> tools might be able to make effective use of all five (six?).

Except as you stated in your blog post, not a *single* tool does this
correctly using LOCAL, REMOTE, and BASE.

 * Araxis: a mess of changes
 * Beyond Compare: a mess of changes
 * DiffMerge: a mess of changes
 * kdiff3: a mess of changes
 * Meld: a mess of changes
 * Sublime Merge: displays unnecessary changes
 * SmartGit: ignores the other files
 * Fork: displays unnecessary changes
 * P4Merge: displays unnecessary changes
 * IntelliJ: a mess of changes
 * Tortoise Merge: uncertain
 * tkdiff: displays unnecessary changes
 * vimdiff: so, so wrong
 * vimdiff2: displays unnecessary changes
 * diffconflicts: RIGHT!

So all tools would benefit from the patch (except yours).

Which tool would be negatively affected?

Cheers.

-- 
Felipe Contreras
