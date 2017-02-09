Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A01A1FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 21:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753582AbdBIVRi (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 16:17:38 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35978 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754178AbdBIVRh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 16:17:37 -0500
Received: by mail-pf0-f194.google.com with SMTP id 19so935538pfo.3
        for <git@vger.kernel.org>; Thu, 09 Feb 2017 13:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=YfvhWU+hKbIb9q08ZLAjmOvgxLxkpkRvuGOxTREqV80=;
        b=Se+206IU3ezZBSnFr6PhrZmrP3v7ArAaEfC5RP2C1rSy4OgE146T5feh3yHmqiJtxm
         Rmk2LJxBrrqNqxG/3oa9dsUCPJe0bHEga36ab4nvqply+UbLrA5AnPaWi0olVfKHUWEf
         i2RENci1OyngEfe6Nvl17JGf4aWn5j3urr5URCUsgqsX72cEGSvsJmCLPdcMwUrrnWQa
         T9vnpE7SfqC9AtfhZ0XpqjPQ5mf5KMgZj+oketDtCdu+GUy75qJ7c/dJRTShJrCcjYna
         GVewx7FqIewl5knGNlUjeKKH0yXymdUaYfxKXTM9IJzXzyltVhuOho+4BU21OZtW3nt2
         RRVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=YfvhWU+hKbIb9q08ZLAjmOvgxLxkpkRvuGOxTREqV80=;
        b=dbkTC3h/AYc1lnKwb275Zcqt7W+GFwa275Hl5v3W9r61eWSB9sKdEY/AoQ2zkcamLi
         lsazMT7kfKdQQ1abdT9i/8rte39q05r0uA47LujZjVDeZgqaDDfO94YR4DdoIjiMI0Xy
         GLg16E6Aqa8oB2IW1Rs/TxmgZYXMEOE01AcZL8Phznc9HpFe8D0gxV81B3PDDuKc4XAb
         5Cer66zvS7KRETX/yO1uf9Le04zKDz0cOwk9SZCFDBo/GcjlHhGFIxZsVI7Cghtt/+fk
         NwYl1L44SS9cKAvMYYzeMKd6i7gP2I2n/ShMnld6k4nUl8kTCIEKcQ0+NUWAdROHEE7/
         XH3g==
X-Gm-Message-State: AMke39nLTIKjfWmJ6OCqq4vlOhAHexDANxYbju25ufWllQ/2R24LnFaxaSZZ8uUaonI0gw==
X-Received: by 10.84.194.129 with SMTP id h1mr6664891pld.70.1486675020607;
        Thu, 09 Feb 2017 13:17:00 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:704f:61dd:c9f4:9782])
        by smtp.gmail.com with ESMTPSA id c64sm31197462pfa.45.2017.02.09.13.16.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Feb 2017 13:16:59 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
Subject: Re: [PATCH 3/5] register_ref_store(): new function
References: <cover.1486629195.git.mhagger@alum.mit.edu>
        <ce326e17822184eff434b957d28f2233795162db.1486629195.git.mhagger@alum.mit.edu>
Date:   Thu, 09 Feb 2017 13:16:58 -0800
In-Reply-To: <ce326e17822184eff434b957d28f2233795162db.1486629195.git.mhagger@alum.mit.edu>
        (Michael Haggerty's message of "Thu, 9 Feb 2017 14:27:00 +0100")
Message-ID: <xmqq8tpfoyid.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Move the responsibility for registering the ref_store for a submodule
> from base_ref_store_init() to a new function, register_ref_store(). Call
> the latter from ref_store_init().
>
> This means that base_ref_store_init() can lose its submodule argument,
> further weakening the 1:1 relationship between ref_stores and
> submodules.

OK.  I think I am starting to get it.  I've always found it
disturbing that for_each_*ref*() has a "submodule" variant.
Instead, the plan (outlined in the discussion from yesterday that
triggered your posting this series) is to give an API to request a
"ref-store", and then ask that object to iterate over refs, and
these steps get us closer to that goal, because the "to enumerate
these" won't have to know what set of refs a ref-store contains.  If
you want to iterate over refs in a submodule, you grab a ref-store
for the submodule and ask it to iterate.  Iterating over refs in
another worktree, you grab a different ref-store and ask it to
iterate using the same API.

Sounds like a good direction to go.

