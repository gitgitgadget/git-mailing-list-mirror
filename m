Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBBD120373
	for <e@80x24.org>; Mon, 13 Mar 2017 22:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754565AbdCMWg5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 18:36:57 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:33678 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753900AbdCMWg4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 18:36:56 -0400
Received: by mail-pg0-f54.google.com with SMTP id 25so71769012pgy.0
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 15:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Aojfmq/ns4ilRd4tZuYVdEUJnL8AzWMjiTOXJs24+6o=;
        b=sMB+lpvUeOl+KIV1gXp7T6SmTJ6xApunygYG3wcLEkukDn7mDHRoUzAW2fDO24jGHW
         bl9Xb3NL7R7dcK+KEvhAIeO/vVFnUrPPsNhKNxaK4FAIim9BVRILf3ARmEtosF3zHUMs
         WvQ4k6+fYpbEnCzVBDx7eOWI0rSwhbDAP4raiZQbbWgIKLTwU9CK8bBk5bTrhUNix5/B
         M2F5bwDJZiyiAn3Q6+ARxP5nOv+PyLpcX1Yd+RHsZWG42ArabM90UEtGTaFfk4JPMF94
         o1kz1EVPXo39qd1Y5lvZ9M8lk615pT1PJmj5FB8i/gJdHsgBBiNMxeKMki8KD+Dm/xyd
         ZE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Aojfmq/ns4ilRd4tZuYVdEUJnL8AzWMjiTOXJs24+6o=;
        b=F8VIVQeUTxrJpCzEDGeTCB+t4pYjCCJV20bOkQuwhOunVMhIlaZqSy1bHkGArSMsh5
         Tw9fZoaJt7tzNFpPGS6QxKmnD3FvHs9qJhNoVagUS5+3KQvvvxmY8AIRwNnUbpUHRlxm
         QqQuyV7YYiKvyUNQRaiG9orLS3nsMwxlqXRRz/1rhsvg1oarVNzJDaLe0W2Ef+kqxdKo
         GgWBefXcb2MkyK3w6vaDJ+wjEbkwHQQfgq1vWbOW3Og9DcFQOxvQa2NmVLBysunHtHx1
         wejUTPcpQLA6DUEqMlt7iTJjV0pPaFnsuL/QH6V61fE0SZQaICZz8VVd1TE+Ppv7Dffn
         OvzQ==
X-Gm-Message-State: AMke39ksG3smQd0UE4LzZB6GBvylMlyGRUmTrPQ6bnuzqskv4lneH3T9/ol08UM/ZyEP9m+SmSJetWrzUFIqqjBW
X-Received: by 10.98.149.80 with SMTP id p77mr40029047pfd.56.1489444615061;
 Mon, 13 Mar 2017 15:36:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Mon, 13 Mar 2017 15:36:54 -0700 (PDT)
In-Reply-To: <20170313214341.172676-2-bmwill@google.com>
References: <20170309012345.180702-1-bmwill@google.com> <20170313214341.172676-1-bmwill@google.com>
 <20170313214341.172676-2-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 13 Mar 2017 15:36:54 -0700
Message-ID: <CAGZ79kY_hPYT8hEbQ-S6ahitfU2d1GHwCz44UKVCHgCSRpHy0g@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] submodule--helper: add is_active command
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 13, 2017 at 2:43 PM, Brandon Williams <bmwill@google.com> wrote:
> There are a lot of places where an explicit check for
> submodule."<name>".url is done to see if a submodule exists.  In order
> to centralize this check introduce a helper which can be used to query
> if a submodule is active or not.

With this patch in mind, I need to take notes for rerolling
http://public-inbox.org/git/20170209020855.23486-1-sbeller@google.com/

>  #define SUPPORT_SUPER_PREFIX (1<<0)
...
> +       {"is-active", is_active, 0},

I think you can even mark it as SUPPORT_SUPER_PREFIX.
The only messages produced are from die()ing in git_config_get_string
in is_submodule_initialized.

This alone doesn't warrant a reroll though; just in case you do reroll, this
may be worth checking.
