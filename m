Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5606C38A2A
	for <git@archiver.kernel.org>; Fri,  8 May 2020 14:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 970A02083B
	for <git@archiver.kernel.org>; Fri,  8 May 2020 14:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jetbrains.com header.i=@jetbrains.com header.b="cQnareTd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgEHOfP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 May 2020 10:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726689AbgEHOfP (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 8 May 2020 10:35:15 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F58C05BD43
        for <git@vger.kernel.org>; Fri,  8 May 2020 07:35:15 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id o10so1386388ejn.10
        for <git@vger.kernel.org>; Fri, 08 May 2020 07:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jetbrains.com; s=googleapps;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=5lIwUdxC9LDLCWmJ/mnWss84wKsP1g1adNA3wPjuvZk=;
        b=cQnareTdfzghqaxtMV1d4nOaZdfx3DnYlNTOgXdFrSTuGpsAP0+tp87hYxE7MCdIko
         4rUkczjGWTGnACz2Dc4VkGdzZ1RUOAtAUvwNTQcau8hRUdKGkdQ3s7nIPJTVIrF6s7hM
         AooCszQYnFHGmh6hOOMzlwd+d0NLriRvv+XLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=5lIwUdxC9LDLCWmJ/mnWss84wKsP1g1adNA3wPjuvZk=;
        b=E/BfMsTOX3QAVgFmJJ7LZNf8iLyo9GtmRE6WmyKdbGl8HJ5+oc/gExrneU2zwHztTO
         e4ef78e2HVJJfO+rGETzfUNR5ZulnmxH6gtmOuDYBXYmQyzPoMnmuOzT74UlEe9pD9Sy
         cPooUNxbcr1jqmPCoGKzcP3jDP//Qz1rrmwhUpjwadLE48uqPJg0K1yf4zHlV9DPQulu
         FQYtHZe8X2dV6snD0pyeTG7LVCP8A9jCMUmBvr10Ub9WJg/Lhf21TEOUJBThg0ej4ZUr
         9KMkBjovxegE6daHPGAR6j2rxgCdKsxE1aluihts3A6WC9JOTgmoloEIGGmjD0DJr+yB
         5PAA==
X-Gm-Message-State: AGi0Pub+R6oDQ9DFzl+RMKHNXlTx8D9lDKML6W+Pn9+Xp+940UQf8Mp8
        m7GA8Gbswhf6Xqf4wMZFF+DROx7uOxEc1W0J0rGPXFxmtQPKlQ==
X-Google-Smtp-Source: APiQypLdIFJrIT4Mizbb91MHLMzKfncUtaxbEoWzCBTuautIvN/SIa3Iez88mOvp1mz65HYyDXEFrudycNMbdTAAVtI=
X-Received: by 2002:a17:906:4a94:: with SMTP id x20mr2078434eju.306.1588948512312;
 Fri, 08 May 2020 07:35:12 -0700 (PDT)
MIME-Version: 1.0
From:   Nikolay Rykunov <nikolay.rykunov@jetbrains.com>
Date:   Fri, 8 May 2020 17:35:00 +0300
Message-ID: <CAES10x8wG_tBYZLrdyRAo=kU8B+gg65007Afs9jGdUUxL7kUBQ@mail.gmail.com>
Subject: Rebase merge backend
To:     git@vger.kernel.org
Cc:     Kirill Likhodedov <kirill.likhodedov@jetbrains.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git community,
Since git rebase was moved to merge backend I can=E2=80=99t find the way ho=
w
to get information that branch was fast-forwarded or it was up-to-date
(it was provided by the apply backend). And a similar issue: I can=E2=80=99=
t
get information about commits skipped during rebase because they
became empty. Using apply backend I could check that because `No
changes =E2=80=94 did you forget to use =E2=80=98git add=E2=80=99 ` line wa=
s printed. Can you
please help with these issues? Are there any ways to get such info?

Thank you!
Nikolay Rykunov
Software Developer in VCS
JetBrains
http://www.jetbrains.com
The Drive to Develop
