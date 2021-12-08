Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEE7C433F5
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 06:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbhLHGQL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 01:16:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhLHGQK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 01:16:10 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A484C061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 22:12:39 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id g18so1565368pfk.5
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 22:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BwtV9WvFT21W5T6ogvkbzDzD9hjsWlhXuy1ktsrAzSc=;
        b=O0Twopt1NdJuXvyXLxYfg1EhHVKxc6Tu6kNHRUKoQ0z6ao4uf4LPdLoQpqMGu9zSSX
         1rvPE3Af6ShNTBgH12UwmdQ9Vfscdi8DN1xU2U4fqyBo2Y01s6+huZ8KhV6MqztFR89e
         gvGRHOIlwna/4IruDXJ+LEHDuTgrOzuCwvMR++/OxnJPb45ldTMqmCA0veEUMje2lXUp
         q7S2Be2OxMrn/r86DD2zaw0/zImVYrjk4ynvbsM+cxC+CBAm4gUSs+IY3JUjLd5SXTto
         aj2Gb8eNOemc4MbD/upV6zhZR1XVj9qnliu7CXmmJHZXo36JGJrrl7hNNBEzqRGtxOTy
         6sGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BwtV9WvFT21W5T6ogvkbzDzD9hjsWlhXuy1ktsrAzSc=;
        b=NheLgAL6GMvCyeBS0uJm2dwQPBo6ZOAVZNya9CXhOF4Ph529p6MKlVxp28lu4Ex1QA
         /9s/Ey6eL+J1Sgl+MLeKXtuj7fzniJ8JRCQrJHmEkC7dEp4QK4+2Fb62J1dRQoytYDPo
         2H+6mOA4Uy67lsKrlurav42Tr8gQbaAuuxbYKpEpedNWuWoPMoaiRoecIOxJDgaDboip
         CX/5W9REpw8zi0MSfdJk2ce9x8qNd3TxipblqQ6lQkJObphaMrsVrYMqwGZExGRSGBnh
         4QphKP/kAb4CrWAn6nbL4tA27fx5gy18jJ192i7ZoZ47OQWj6hv1gs8ZMA8S2NaVdyIz
         C7zg==
X-Gm-Message-State: AOAM532Kn33C+4U7PkyrDDQr99xE2yeMpJzajBqunyefvd4M77X9UOcy
        hK2paTZSplQtqnB26IAfyYuSyKGOPno=
X-Google-Smtp-Source: ABdhPJxw97NO5IYYEFMkdVgdM3sZFiaB101bRq2p5ipGEs8y9vYr7z0yUP9xRRoRhosVsEWqe22tKQ==
X-Received: by 2002:a05:6a00:2387:b0:49f:af00:d5d0 with SMTP id f7-20020a056a00238700b0049faf00d5d0mr3851772pfc.1.1638943958689;
        Tue, 07 Dec 2021 22:12:38 -0800 (PST)
Received: from LAPTOP-FJDAS7G4.localdomain ([157.40.78.135])
        by smtp.gmail.com with ESMTPSA id on5sm1515580pjb.23.2021.12.07.22.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 22:12:38 -0800 (PST)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH v2 1/1] push: make '-u' have default argument
Date:   Wed,  8 Dec 2021 11:42:21 +0530
Message-Id: <20211208061221.133-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAPig+cRxU=pT-qCp-xpHcoae45oxz1d-eRh+QF-SJFM3B-6KyQ@mail.gmail.com>
References: <CAPig+cRxU=pT-qCp-xpHcoae45oxz1d-eRh+QF-SJFM3B-6KyQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> wrote:

> As above, because calls to this function are part of the &&-chain in
> test bodies, it is important for the &&-chain to be intact in the
> function too. It's especially important in this case since this
> function is actually checking for specific conditions. As it's
> currently written -- with a broken &&-chain -- if the first
> test_expect_code() fails, we'll never know about it since that exit
> code gets lost; only the exit code from the second test_expect_code()
> has any bearing on the overall result of the test.

Thanks so much for all the suggestions! I am little beginner in shell
scripting. It would help me a lot!

> s/messagesdo/messages do/

oops :|

> The captured stdout in `out` doesn't seem to be used, so it's probably
> better to drop that redirection.

okay.
