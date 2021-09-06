Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F37C433F5
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 08:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B92860F45
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 08:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240739AbhIFId1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 04:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbhIFId1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 04:33:27 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81581C061575
        for <git@vger.kernel.org>; Mon,  6 Sep 2021 01:32:22 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id 75so3405144uav.8
        for <git@vger.kernel.org>; Mon, 06 Sep 2021 01:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1LztksvY6jmcfE1Na1AUkMVrBHi7zllN6HhMXja2fvw=;
        b=MDU80uk/VP8aw7mk4ieklv9QnrTtHWnSLCipS96XSg3Om21IN/iMSVNLYqsEP2MiWD
         hL5rAb3/vNnHjhKYvjHzUkG8xAO9UnMut1ZZ78tU7x/M7Hk3eINxnn0gd+L4PRid7JCE
         G6dOE8+pGdlQwRwlDHs9Mor+/g3eEYJzg7cxm5n3QSqMPFd0x1qzsiKSfucDDtoknwG1
         IuLTgyRm9SKZTHHaE5vuFlrRtDoIrct9IdeRFKT2vB77oOoojMYKj0O7D1dg6LPDUKvq
         1ZUoIbtQEmt8s/JsyZn4kTXiDcE8RCMHdEJD4QmBk81wPFOASLAbFScaY4UXA5heZGoG
         4aFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1LztksvY6jmcfE1Na1AUkMVrBHi7zllN6HhMXja2fvw=;
        b=tNSYh3UKSjim0K15syt9sZ8S/BXFs7Khg3RzszyPKbH1eb41eREEH7FCUOID3qYlJx
         klOZsYs+Y9h3s94/Sc9O5zE+hymh0QJbAN6ZGQniqG3JKfGUk0gG1RZctZsTH9qMRkTa
         4vBwqvZRsd9HmURNkN/9XuQqCbC8IqDidsuf3L/BohIRNDNJo79Rf5riS6auS80eGne5
         PmhvmBwcIVR/KIsOoLNnVXF+Bew2zhXRAXB6gKDkeg+emTnaRohf8mzu00H7ijxSqLpr
         0IQR7+G3ldg6lAGQJmifa7GQHnnDHShefIyt2j5npE0LbpiVmSs49bvArX+aMM0xxfUU
         uuTg==
X-Gm-Message-State: AOAM533ZobkM/ZrcdQf0ARFTMjBS53JDclmmnF2b1mRP6jH7gRWAERkK
        1TXzVXqC0gD8hVVBHnbMRFEx6xffkxhY61htZYG2dqeZ
X-Google-Smtp-Source: ABdhPJwkKwP1ZEYhqPfm0mazwaAXx22dGIzXBhczfHYMkX34cu0OWPsvlUwFu51vbIoumixdy4pddJFQmiS3wL/LbnA=
X-Received: by 2002:ab0:3418:: with SMTP id z24mr4775436uap.96.1630917141512;
 Mon, 06 Sep 2021 01:32:21 -0700 (PDT)
MIME-Version: 1.0
References: <96814e5e-54be-1eca-0d75-68be53b1be3d@archlinux.org> <patch-1.1-ae6ff9f77f1-20210906T073306Z-avarab@gmail.com>
In-Reply-To: <patch-1.1-ae6ff9f77f1-20210906T073306Z-avarab@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 6 Sep 2021 01:32:10 -0700
Message-ID: <CAPUEspicOHC5W0pPFcAjQ6BfmLmcS-M8neDdLYWJuNO7fvpDVA@mail.gmail.com>
Subject: Re: [PATCH] send-email: fix a "first config key wins" regression in v2.33.0
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eli Schwartz <eschwartz@archlinux.org>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 6, 2021 at 12:35 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> This test fails without this bugfix, but not works.

s/not/now

Carlo
