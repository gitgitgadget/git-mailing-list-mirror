Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885B5C4332F
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 19:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbiKVTTb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 14:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234754AbiKVTTY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 14:19:24 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B98E8D485
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 11:19:22 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id b131so18441346yba.11
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 11:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DbEY/9TktDPUOzr6QCAVMPLJBy1e2UBDQsrfH4NHiw0=;
        b=d7qelkQDJDU+oMPwow8qHGz/R1cJleeiR60vAaNNm3MFpkeXHu2xcVowB5fLhQZSU3
         w6P7RacKsyUXHrLRyRz1yCzOXHLY77/AciRwYFOfQa6IJM8mFwgRNH5X14Wt5ZtpgBiS
         1RUcJeFtcp5nBjOiNku84g//Hj1HEHAvFzejy0C+pxTCLXxoz1vieaQbRJnZMddzlXoy
         Y6uuGdQwRM8Ufuffhpmpf8Gl1lxNeKxfBfweLGase0spXL2s/wxyEcRZdWjt/oOwnzq6
         E2z43pszWez3E6tngwBi6RT6SdlLUmCE7Xk3x+c1xdmXsXgOeN4dHijQPal7uhCgy8ih
         NN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DbEY/9TktDPUOzr6QCAVMPLJBy1e2UBDQsrfH4NHiw0=;
        b=bLP+zSj7qlyQlniYjUNGj9Gztn/mZmCbxvaXp3kztUWec2FDjngqQjxFiKl+FhGY5x
         XY8gr4zvHoNP4aGzYluSciDNoXYhDEddhxmo2DMkCvA5YHgCNXe1B/56Wsm8u+3X/q8a
         3twtokl1M/LFpkdZyAXdcHUQdPAl+cWU9vzdXuhpVzPQrtkGFq+ol4Ou/9AS32jID7Oi
         fQOCy4pOaDyFMmyl6xa2UKQsNwZzj3vh7LtGHCtzT7W32rpLu1QtO+wJ22xZEdGR5yXo
         Y1NoscI1cqeyKyjAmmJQdIQ1AwRUuRh0mrx9vUQvDd8FoMr369D/HSjBelATmjvEBAaU
         3GTg==
X-Gm-Message-State: ANoB5plT09uMBw2cbs63RROm1tme8g7hjir7uOr7LWOthWo9CBR3ycwv
        hFuv8jY02uUV1j7Q0DqD42dNC9VXMH24RMpVbhc=
X-Google-Smtp-Source: AA0mqf6DVFmDZjgBLKzoqMaWmP3VwdcAXCRtqQwVBc40u/IBWdLVRPom+wYhEVByP/DC2j8lVs8qUnYot35eE0c+5NI=
X-Received: by 2002:a25:918c:0:b0:6cb:e6c1:ac06 with SMTP id
 w12-20020a25918c000000b006cbe6c1ac06mr4968494ybl.115.1669144761587; Tue, 22
 Nov 2022 11:19:21 -0800 (PST)
MIME-Version: 1.0
References: <pull.1384.v5.git.1668110679098.gitgitgadget@gmail.com>
 <pull.1384.v6.git.1668547188070.gitgitgadget@gmail.com> <CAPig+cRPQ7bmG6+U+oQGGUFiSiHoMMpMk8FDJ7GMJvwCXifa9g@mail.gmail.com>
 <CANaDLWJM1VRivm8VLqxg+w8K-+49E0km6AgOzWzN9X=TgzaEiA@mail.gmail.com>
 <CAPig+cQgu=i6pZTzoNYGZ_6X=DGdmwa=dPhSQVqD+eLCZCGJSg@mail.gmail.com>
 <CANaDLWJ+Suye98QKub9nfnknLEsyQ4PK1LxDkPmzGC_-hApkFw@mail.gmail.com>
 <CAPig+cTrpnVOW0Y2m5xtPhLudY=rPCn3qPQA0RSso7ueFytZbQ@mail.gmail.com>
 <CAPig+cQF8vjGNUux-ZMBRxbEd3V0p27oLWZ7k2=mf40kAkWVeg@mail.gmail.com> <CAPig+cSR0MAYRLtPS1YcegqMZn4FDbdRvbCbuDfXWR=wF_ofGw@mail.gmail.com>
In-Reply-To: <CAPig+cSR0MAYRLtPS1YcegqMZn4FDbdRvbCbuDfXWR=wF_ofGw@mail.gmail.com>
From:   Rudy Rigot <rudy.rigot@gmail.com>
Date:   Tue, 22 Nov 2022 13:19:10 -0600
Message-ID: <CANaDLW+3HfVDrXmqNwcmbdbfeYBvCAR2pjo4FSuiGn_S=sOL5g@mail.gmail.com>
Subject: Re: [PATCH v6] status: long status advice adapted to recent capabilities
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Rudy Rigot via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Holy snap it worked! Patch coming as soon as CI confirms it's good
everywhere. I believe I was able to integrate all of your advice.
Thanks a lot for your guidance!
