Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA30C43461
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 14:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 189C26144B
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 14:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243464AbhDUOUM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 10:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239469AbhDUOUL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 10:20:11 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DA1C06138A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 07:19:38 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id x20so36813576lfu.6
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 07:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=PcLLJxxyULy8Feiya2bpQCpmQNlHkrD+y91qpa5Xz14=;
        b=u+IU0r8oghEabUGjm8BlN7Xp1bIXUq40WbbLLKEFQcL68GIjYHlgPdF7RtW0drIDgQ
         qH9IX9uo+XvsCGEYFbw3u6m4vvmsB3K8KqNiYYofwjKtiL9RQPrJz4hZs0D9zfNsR/um
         RjJE+txqLUelX9t2x4gqW8liW7oQb6RuLdkYrv62bIQgj8ryMvx2dULzIsuWQJXbWvZR
         4KXUMIfsOpGufDND9/Z8cMYBRf6VgusrEtGUDiQEl2XFR8VAGfASY422TW7KUQ196aM0
         E4G2QGFBifMlyx9fjtj1zrTaGE5szajYbIpTFDa+bHEd/QBmFkj5I3TfVKM7tYKQQjBa
         JVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=PcLLJxxyULy8Feiya2bpQCpmQNlHkrD+y91qpa5Xz14=;
        b=abliqb/BEOC65YW7hDPf3ULwn1qNaU/TXq2UnBjDEhkylO04Dno7KXnT+ZZzJjfAYl
         QDini/65fIlDyEAiN/t7NdBrboWZu54C4HES8V78N4QG7y6Dhcy83+QfkWwvdCTLv940
         HqwZWLM3PQxkBnZCWvZKAGf7J2S2DTadFahJRU5XgK+jGQOoHCwNYhjvNds6IfUK8A0P
         Wb9PeAzlw+8smH8uvd6FR2XFf+u6X5xyW7c1VyAFjjGUwDcsIlOHwMrwpceOEYvMZZ46
         8DKm2yBQ8NeYIKuGao929p6X1I/swAnU24fmgG2/b7KZCPVafxL93B/ssCFmKNJv3R7K
         2HCQ==
X-Gm-Message-State: AOAM533srII9Del4GVxbmuzyS5bZ10pQ1PDcpOO6DuwXfXPQmJoNFM05
        avJUP6LAL0vxXcxRvvqJZTDIAksXQmmMmSculq46aI58QXnJas97
X-Google-Smtp-Source: ABdhPJytw96RMY9u7RYu47wl8r+HtIUx8tdHcaJDIiPKC8rk5zYjtOAI247TaNYmw3HcKfFVG1dQlSSsFEFgpBoFeeY=
X-Received: by 2002:a19:4cc2:: with SMTP id z185mr18818594lfa.461.1619014776381;
 Wed, 21 Apr 2021 07:19:36 -0700 (PDT)
MIME-Version: 1.0
From:   Hongyi Zhao <hongyi.zhao@gmail.com>
Date:   Wed, 21 Apr 2021 22:19:25 +0800
Message-ID: <CAGP6PO+6MA9J1LRgGn4rcz8DBcW-hht92p-ahFaM9g6tcNFh-Q@mail.gmail.com>
Subject: The meaning of the '+' before the submodule hash.
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

See the following output given below by `git submodule status`:

$ git submodule status
+c7b9787f0b7826a87f07ce00cbfe4947b8521101 external/devxlib (heads/master)
 d0197c76ae76bbf4d3fed20444fac31af550069d external/eigensolver_gpu
(v0.3.1-7-gd0197c7)
+6fef49bcfc4a380432f15734ed0ca1f0b0388977 external/fox (4.1.2-89-g6fef49b)
+4b3c7c249f6a2cfed76603d9987cf5164fa6f9e1 external/lapack
(v3.7.0-1026-g4b3c7c249)
+2899044d2a6828aa16e0189913662bc35ce8f645 external/mbd (0.12.1-43-g2899044)
+2b9973c12e85397fa9564370f6cced16f8428834 external/wannier90
(v3.1.0-35-g2b9973c)

What's the meaning of the '+' sign at the beginning? Why do some
submodules have this symbol, but some submodules don't?

Regards
-- 
Assoc. Prof. Hongyi Zhao <hongyi.zhao@gmail.com>
Theory and Simulation of Materials
Hebei Polytechnic University of Science and Technology engineering
NO. 552 North Gangtie Road, Xingtai, China
