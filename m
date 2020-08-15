Return-Path: <SRS0=NddV=BZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EEDC433E4
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 21:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5993206B6
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 21:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tfnsA3zc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729502AbgHOV6C (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728219AbgHOVwA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:00 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAC2C02B8FB
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 06:46:54 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id s29so3466957uae.1
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 06:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i9FdPUMBeQswcBbmyjIIK9WeyQPQ2nf7SsmgKFdq9OI=;
        b=tfnsA3zcUUDZ4TOPAGbbfsWSy+muQpn+RpMFfdmQBOUGoTpT2GisYOXhdZByFdXtLu
         Ss6hIak9ZJAM29y5esVnkA8W83sd4UFlfn7ZseTVmZc79iN+9Wcl6mGpVq2ly71OPwLp
         LJ2uxzfPwNOQqZ6mahIhUcn2S4omYKdNRzfIEO99X2Bgac+J4M4bgQTnj8xkqG9K5Dt3
         Ek9CEwptv5z68UAq2j9krUPZRvDYv57VLLk6taRJLgGFNHjFhdhEVAhXWhw0OWyDugX2
         llLLQHZEvs5hWCBitAleF3+stq2AMvEFd6ikdhAOMgerZQ/jgJz8VQwC3gp03QcWKYif
         Cpdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i9FdPUMBeQswcBbmyjIIK9WeyQPQ2nf7SsmgKFdq9OI=;
        b=UBtj9AU0b2H3GBHSwICS3GYWFqWn/QCQXPcjYuuSn/oWNv0xcewBc9Jevqm8GuTK3i
         vasFEvYlvrrHu333iOXvUUghq/y/C3mr+ZaBsThlUvCSW1cLN8PXyqcpKxXJ+G6SHcO/
         3HTG+L4RaYybvpXr0dgk3pTQT7v3bfGSYKWteQmpMXwGVatS1OifMCCHbeh0FGW9yasW
         uHepUExJ8yWlLMHqszlM7XWaeIk7eJ352w/kJzmg4MF1VkqvV/rL24Df6N0AzVoX+6BS
         L6QCXv2wQACB3ypEtLfHfPAyDOMcd2lJmM0ScQ1LuU+3BLYdpFjx2NVs5brQEjnNiAQs
         JRzQ==
X-Gm-Message-State: AOAM530zWfkAuUNUzQhDvndQNIOISIYTsE8ZJfl5jE7gQh6T3sUWTP0z
        I2VWPrCZwQkaa/1htGLEJrdFgfwomghYqsji4lE=
X-Google-Smtp-Source: ABdhPJyAbmKURNw6svhhf4LZrvGEoAaMeiHpD753joWsebA7uomwj9eRp3NoNpuQX8qKwxtxAtqb+fv6nbZKiC5azXo=
X-Received: by 2002:ab0:49ed:: with SMTP id f42mr3838788uad.115.1597499212889;
 Sat, 15 Aug 2020 06:46:52 -0700 (PDT)
MIME-Version: 1.0
References: <pull.703.git.1597428440.gitgitgadget@gmail.com>
 <4bbfd345d16da4604dd20decda8ecb12372e4223.1597428440.git.gitgitgadget@gmail.com>
 <20200814201153.GK8085@camp.crustytoothpaste.net> <7082f3c9-652e-36d9-26ae-d1f86e872480@gmail.com>
In-Reply-To: <7082f3c9-652e-36d9-26ae-d1f86e872480@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 15 Aug 2020 15:46:41 +0200
Message-ID: <CAN0heSq3voEdae_qiFOx1D1X2qD-2QiOTb5f0Y750pC1UPdH-A@mail.gmail.com>
Subject: Re: [PATCH 2/3] commit-graph: use the hash version byte
To:     Derrick Stolee <stolee@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 14 Aug 2020 at 22:36, Derrick Stolee <stolee@gmail.com> wrote:
>
> I appreciate the suggested improvements here. I'm happy to do
> something more similar to other places in the code.
>
> These will be part of my v2 to be re-rolled early next week.

I have nothing to add to brian's great suggestions. I'll be very happy
to see this patch instead of my patch 5/5 'commit-graph-format.txt: fix
"Hash Version" description'.

Martin
