Return-Path: <SRS0=oqjl=22=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475B1C00523
	for <git@archiver.kernel.org>; Sun,  5 Jan 2020 04:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE48021582
	for <git@archiver.kernel.org>; Sun,  5 Jan 2020 04:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVTW3Xmm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgAEEY3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jan 2020 23:24:29 -0500
Received: from mail-vk1-f171.google.com ([209.85.221.171]:34860 "EHLO
        mail-vk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbgAEEY3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jan 2020 23:24:29 -0500
Received: by mail-vk1-f171.google.com with SMTP id o187so11705829vka.2
        for <git@vger.kernel.org>; Sat, 04 Jan 2020 20:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4aFlTk7LRUD+E7SvofaH2IjvByhQej8DbOxqZ3Ys6jo=;
        b=IVTW3XmmFR8mmiZOCc18GHXvmXZnUovg2w4mtdx+Ds2UXaPRdhOvWPJsOtuKfxhjPh
         VDdtArpu37eAAkR1b/XiQUtymy7Gk/a3hxps1OrrkI6V9yRjicc/RO2jmnSCNePnh0kO
         kNwA3T7vMiWcQ8ktsO3+Fb8/6OIbl6m6s0xdY28W8MV2kKFJCGSy9PpzE1wpS6muy/Uz
         bAkya+TfIeInP61fcGIhxEg9p9ZsYj5Xvq4lJ2fF2j2aPYCu9OPQqZMODwv6NJsR5Uxu
         NJsoLXvXoO2wEfnwvPdiUf/PsqV4OZcJK9TI9KWZf9zBeNtZHH3Dus06ZQRAK48eBsN4
         r8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4aFlTk7LRUD+E7SvofaH2IjvByhQej8DbOxqZ3Ys6jo=;
        b=UGH52Fu4ZV8AhWVrbU3Y6WUusbwWAe4MSTwa2+cqaUOXRW6RPx5T/ogau731Cd8S4i
         dqwz1c64otzXG5z1neuerkISJfOtGGjBvhx1X2PvtfFXoIzgQofxTogKwmTEvOHM2Tmk
         rVoMyvGW2wbpOqoiyHqgDrJwlzGagzqcKsaqwNF7/Cqbn5ULgMLN8YCZ74Y0MGrSSAFC
         hrHIpK5d1o/0SFWbCcL4NuIzQcH6YOWowjU9wWgZMCA2m3xfTCZK5E0MjTW0jx2FGkoq
         /iAqu1uKowu8z3mbixbRkfzD/+Woy+orgfdj5EVwn50FpIR8O1c7p2qrkP6MbKsbb8vg
         BR3A==
X-Gm-Message-State: APjAAAUAilJTY7aAVZCFYLI/YuexKLXCgcpPOOy62LTxiSpEGoY80Y4p
        UPJHBbI7S+3q5dSAJAeQ/HyPPYkjKtkWCEHFLzs=
X-Google-Smtp-Source: APXvYqzzx7+ERdw0/nI9xHfgpeYYGfauPjwkwXgBk7GXw2UTcRiWZO/kafZvOF8pIb7piGPweizZy+FuHhhr0ZNQ+CY=
X-Received: by 2002:a1f:e784:: with SMTP id e126mr56297443vkh.102.1578198268484;
 Sat, 04 Jan 2020 20:24:28 -0800 (PST)
MIME-Version: 1.0
References: <CAOAGZwEfMQ6F8t3a+jVDNrPd6ZWFfiHDU9z1srSHp575DmqcVQ@mail.gmail.com>
In-Reply-To: <CAOAGZwEfMQ6F8t3a+jVDNrPd6ZWFfiHDU9z1srSHp575DmqcVQ@mail.gmail.com>
From:   Matt Rogers <mattr94@gmail.com>
Date:   Sat, 4 Jan 2020 23:24:16 -0500
Message-ID: <CAOjrSZv-D6qsyd7mjAEAJ=6YVUTUupYLNdUkDTjbGkA_9eOfUA@mail.gmail.com>
Subject: Re: push --follow-tags not pushing tags ?
To:     Wes Hurd <13hurdw@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I believe --follow-tags only pushes annotated tags.  Does the issue
still persist when you use something like:

`git tag -a -m "I'm an annotation"`
