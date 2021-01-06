Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75AAC433E0
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 14:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7A9B22D01
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 14:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbhAFOQF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 09:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbhAFOQE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 09:16:04 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5F7C06134C
        for <git@vger.kernel.org>; Wed,  6 Jan 2021 06:15:24 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id n42so3030587ota.12
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 06:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=77LmjVLOWhOLcamLVuYWOkjyoUVG6Jf3tGnKtHywLvg=;
        b=CS+V7n6BSvfpoZZV4qZ5SGCsRiJ53qZt0LPO9bB39uIxQf1OHDAbQFuUeVQAyVriGs
         tKljc662VOrc5XmE0uwA6lv1/WLLVEcOdcpI9PUcAYx+JXGcUT8mvhsfEUrAGWyKkLAH
         yOmllwsbzrpazJXpDwAhKk5sFg9NVnvdMlNMiTqQMjj638mpX2MJ1mKU5U40aKRv5OOb
         BPFcb5Voh8uoG7xgNAZs+T38j48hmYIYf6A0EEccJyvbQo1+XwrCahyGn8WbmhwxPynO
         OYBon+Ij0U1TTjJjFUTGZLcpbWu//RBF7qCmQrV2Oi0cmD8vqms5PwdVXFYllpOr9P4j
         /Rpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=77LmjVLOWhOLcamLVuYWOkjyoUVG6Jf3tGnKtHywLvg=;
        b=S73Yy+hLIrgGYEH6sjU+NWXcOQmazhXF5n+YTmy0fYi3mwHubdC5U7eVuamaYHdTyE
         /toJxLkC26WMxdzv5hIbh1vwKnyU3LOgUnu7Jy3K1RiCHbLKcfKaqZWqvrafwrA8gb7v
         yLJEf9ls4Z9fQ/qXoJ8iy/ebH561lM0U13wxR2PYW6hYKeGoaFCw2HFGPQfM69BC1Kpn
         Vc0AjZ85Mj3EuUn5H+XB3fSyJgDPHuPRXwy8b451cT3K5QgRR28P8rU9XaIjM7Xq9d+N
         gcYyi+ChvjcJwTZ34kxPuGTz0Yxtc0KLtDSkW4dJcEFpRU+Nrpze9xdIpgwY05SJXAqo
         Z3+Q==
X-Gm-Message-State: AOAM530Ssq6KoINDMHD50P4h5MRxd/xsr49KlOLdc0liIRSqfec+U5Pb
        aoQqDcIRrX5S4Ne0kYcs/KEMDYHtEa1ozC2PYsY=
X-Google-Smtp-Source: ABdhPJzDljBO696x28s0sFM1BPZ1Bp1pV5Khk9uNqsq/0VzuT7PuGHKoOj3VPi0g9VE+NhFa4ahtiNS5ZE1ikH+iwOc=
X-Received: by 2002:a9d:6188:: with SMTP id g8mr3308467otk.299.1609942523729;
 Wed, 06 Jan 2021 06:15:23 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>
Date:   Wed, 6 Jan 2021 22:16:40 +0800
Message-ID: <CAOLTT8S4Le5d5nZi400xuQVkPJrcrHP0Lm7OSmXQFjN6rStxxg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] parse-options: format argh like error messages
To:     stolee@gmail.com
Cc:     adlternative@gmail.com, felipe.contreras@gmail.com,
        git@vger.kernel.org, gitgitgadget@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stolee,

Thank you so much for your reminder, I have already done this,
I feel that everyone is really enthusiastic and very moved.
I will continue to work hard.

--
Thanks,
ZheNingHu
