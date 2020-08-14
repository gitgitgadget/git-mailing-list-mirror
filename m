Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9560C433DF
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 21:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AA9520768
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 21:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjF9p7oB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgHNVLr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 17:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgHNVLr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 17:11:47 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19533C061385
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 14:11:47 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id p8so5340816vsm.12
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 14:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=qElRhgFW6O3NLrFqH4Lp/T7sQbiF++pSvTBdt0cYgtc=;
        b=WjF9p7oBKgerFnZtCf5pLMvVu2U+Oh7tmvGAxrIPeV83Yl03a+cKNljF9CrS2nkwTc
         /Bw4nO5gtNFVr8VLWsK0eWV5qCwAcXZOWQE9KGZu9CJyDD1XUN7qUYb+v+nEcLWyzLSo
         hXTqhNfAMI/KJ7j0jmX82siFQZpfgBztj1qmEMR7YuTfpp5esYzfiPTeTWVExW0RFJls
         bD47R/UCktn+pZB1ACqlV6+bU06xejZDxJbY/oUVwF4dAqyhyhF4Fp16CsQt246/jiY8
         UkbR4GaHR0twWdJw2d5UU6Vxt5zZ/8YqYLAUHnrnw6IZg96oxIBkpK2A04YV43enjn3B
         t0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=qElRhgFW6O3NLrFqH4Lp/T7sQbiF++pSvTBdt0cYgtc=;
        b=jgskOHeEQp0SWVifC1XP0W/o+Et1NC2PKrXXwFg8uENZh7P9sSTURPlQpSQYpP5n0w
         SSdWiCbP4q17/fqgYtEHD/t38uNq/41SMxXaPGSGnuiP1ppY+BC4/o9lBnQojb8pAACG
         hg4I1keT76UJO9w57uFtjrmBS3eiYmGvVRE9xUXgd7/8vZbgykliaotTa8Yg3MSvRvbQ
         +kZAw1EJH3Xv1rmc9h2XMIwMTnxnbrAIfgOF5Vaz39bdQKxyFVYqolcgBp0yCVekBbf9
         LUpv0vOE7HfSIIblAnSQ4UTKc7+sJlLaajJRiFa/QVOIZlw5WoqkaOTmi0rPCknRH9yG
         qKpw==
X-Gm-Message-State: AOAM531dhL6C4l+gzdrvosvu6E6f9IQCwYlVs3XbjwXXoZtrRU9hqHB5
        pojwt8QmCdBJbTSSh17TaIAeu3qu3CDhD2+Obw84kwo+EOs=
X-Google-Smtp-Source: ABdhPJwqG7UQG24LIqg+6isWb81eSh2HD/dBzGLbw7IK5SSL7m9w1+SVPY00NpWEzCZE6s/qry0nxyunSljV74Hgmk8=
X-Received: by 2002:a67:fe15:: with SMTP id l21mr2760389vsr.78.1597439505683;
 Fri, 14 Aug 2020 14:11:45 -0700 (PDT)
MIME-Version: 1.0
From:   jim.cromie@gmail.com
Date:   Fri, 14 Aug 2020 15:11:19 -0600
Message-ID: <CAJfuBxw2KudBPfpmVqU9VOfnvrKdczU6Us5FWvpj50T88BarHw@mail.gmail.com>
Subject: git bisect enhancement request
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

please teach git bisect how to use 2 separate worktrees
for the bisection, toggling between them as bisection progresses,
so that the end result is 2 compiled kernels,
one broken, one good.

perhaps something like

git worktree add A
git worktree add B
git bisect worktrees A B
git bisect start

# and maybe
git worktree rename A ok
git worktree rename B meh

its a minor convenience, yes, but having it done once right,
is better than ad-hoc scripts doing it, each subtly different.
