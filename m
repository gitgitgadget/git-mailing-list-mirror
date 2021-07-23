Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9A5C432BE
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 16:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FCBA60EB5
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 16:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbhGWPaL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 11:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhGWPaK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 11:30:10 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CE5C061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 09:10:42 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id u10so2352398oiw.4
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 09:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=r4C/Sf64RTUUYkdimsjxDnMAiCpj3TyjJ6FkcKPPw1s=;
        b=Rdev2kMeyylZVWHZHGxRUiHfNxFqvoDYskZFJ7A3wU0mXnmb8WpsztIGdRulqB6ivY
         d7kNbYPth+E4fo+l4QzdKWwx8482QWpkH/zRXw5nRKPHqik3y7GV42JbbTO/hoYm9tpg
         4udaCy9cY9eQbETRXN9LDGd3iSuYv7DfNU1oIUfL9wUeeOKMfJlRw4JpSfoThjNZMC8O
         FsiZP0wZ+qL0dj1Lo6Wp/R/WQ6Bpq0tpFF7XslOGgOH1hcmmUNXqf9scGD6cLLAOTIUB
         8hHxcEzE7WOKN8cTk526oViHv9EbzAEDwXLGj76OTeGpNr8F3oxd4LdRljkXE4OUqJH0
         Lyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=r4C/Sf64RTUUYkdimsjxDnMAiCpj3TyjJ6FkcKPPw1s=;
        b=BeyHoGPwQBqbvXOSAwtSwH6qBvN4L9Wn8Yb2lh4vLGlS34QDzlDd9UDLlONZCInHxx
         doaLISMrQ736sSYT/4mWbQsQbSrJumIlt9SXsrZjSR7tHksm6xTAxONN9Sp8bCZUQtqt
         p13LbFM8FL1749y9z1ghQ/H+YhsoBTIh7ZtEiAXFFkOb4ttj5OixknzQAwN07LcwlyP/
         OW/TKLDKEgL5102piNuh2j/ypdcI8u9eAd6cambRf/VanYpWem09pcy9NjrscNpLRuzJ
         EG5g21RT5b4Esywy+pWywhve9hZuny3HrmWCwQOtTKS3lxO329VM5xZ24+VQbJcbsmJc
         3cIA==
X-Gm-Message-State: AOAM530rhK/a5MwROiWA5rZG1qt4waxviy9to9hhA9OpLrWpnU46SXiD
        JJNFFvS1HnllHBRoDJ+VhYg=
X-Google-Smtp-Source: ABdhPJwZ88tLeLpTtjgJsYPSTCF8hGZBRWWjn8Z2x1lS0wTaYZQzIq5h7VjZzcyKJ9JF//99g6gM1Q==
X-Received: by 2002:aca:f497:: with SMTP id s145mr9487778oih.131.1627056642086;
        Fri, 23 Jul 2021 09:10:42 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id r24sm5784883otg.14.2021.07.23.09.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 09:10:41 -0700 (PDT)
Date:   Fri, 23 Jul 2021 11:10:40 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <60faea007b6ce_defb20871@natae.notmuch>
In-Reply-To: <pull.1002.git.1627042470.gitgitgadget@gmail.com>
References: <pull.1002.git.1627042470.gitgitgadget@gmail.com>
Subject: RE: [PATCH 0/4] [RFC] merge --autostash: apply autostash in more
 cases
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain via GitGitGadget wrote:
> This series aims to apply the stash created by 'git merge --autostash' in 2
> situations that were not covered by the code:
> 
>  1. If the merge is fast-forward but the fast-forward operation fails -
>     PATCH 3/4
>  2. If the merge strategy completely fails to handle the merge (exit code 2)
>     - PATCH 4/4
> 
> The first 2 commits are small improvements that I noticed while implementing
> the other two.
> 
> I'm marking it [RFC] because I'm not 100% sure that trying to apply the
> autostash in 3/4 and 4/4 is actually the best course of action (or if it
> would be better to call 'save_autostash' instead). That's because:
> 
> For 3/4 (fast-forward fails): I'm not sure if 'unpack_trees' (called by
> 'checkout_fast_forward') is guaranteed to fail atomically, or it might fail
> mid-way and leave the worktree unclean, in which case it might be better not
> to apply the autostash, but just save it instead (and tell the user). In the
> test case I'm adding, it does fail before starting to update the working
> tree, but I'm not sure if it's always the case.

I'm not familiar with unpack_trees, but sans that possibility the whole
series looks fine to me.

-- 
Felipe Contreras
