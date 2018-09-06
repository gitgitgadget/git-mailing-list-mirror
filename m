Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23BBE1F404
	for <e@80x24.org>; Thu,  6 Sep 2018 18:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbeIFWlL (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 18:41:11 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:41176 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbeIFWlL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 18:41:11 -0400
Received: by mail-wr1-f51.google.com with SMTP id z96-v6so12342914wrb.8
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 11:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/7hrALSPtrO6duOBdscpKKz6CmLHPnL227SInG3IML4=;
        b=aG4pba2P+XkGojmP6IBVADyky2koi0Rg14Ret+gAdB/GyNEJJKI8MqwXyUkq83nOT0
         SUoRQvrexNT3GKpcPVa5MQOg2VbmU5MOvIGRiRKQJd2+UMDy7Bfu2jQXmpXBm1KpzaF9
         ZYFThGVCMxu26QKAXwY8H4Y/bvHmHeGTtXCzqt5XFf5ld93ikrKGe/9jtJP3Fr6ESLa1
         Z0KNHWp+UhEzxuaVA35mXl1IjfnMbd+JbaMkwWA1t8phWzuMuGI0ZYe/5UBjXQSyRRur
         86KieSC5wqTslMn3FzKHCgvbWL4jaKCuYELnLrEDqpIsIQv2u/2pVMbY8ID7ycfB0JHj
         jB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/7hrALSPtrO6duOBdscpKKz6CmLHPnL227SInG3IML4=;
        b=Fs2yvN/5WCXL8OGo3i/q7lpp5QmK6Un8FR7bfOkYC7SpMjLBqaM1UMFtceD2QTpE+N
         UDhnFWOhA4PCz91xZZYhYdutouWZLJFosZuYNeMX7IED0Vu05p58mcGfcL70KQUgXBUX
         DyKF6HTSLxDU+pm8dHXB9cDa4G23imLze0dpvFoyrDbGK2W0n3Pa7Wv33lt/3sKRoJcN
         /DgcpVx62+fpjqhu3RQIYPM8RGtO8cd+sQwbdbeahgiwBQmrP/4HNkbbOq+8bjQhKfCT
         4m5CoH8FFWfDQxn61an4bsi6RAI4N5WqH5MszfD7BlCcKv1IJkNJhMJbotqCpiInC1oS
         dtnQ==
X-Gm-Message-State: APzg51BJqEzijNcVklQtQA6k8pIhQzrmEIJYYVMvlG5O4HziFz0lhAD4
        kKkzPv/VuDQGHXzjIJodQGOkedvF
X-Google-Smtp-Source: ANB0VdYxdYn3M2zono4HhbVljEtpvJ3DHMGHgFpfQq3B9A6dMtqBjK5R88fCbr6P5LV2EtivnavsFA==
X-Received: by 2002:adf:a599:: with SMTP id g25-v6mr3377915wrc.88.1536257072736;
        Thu, 06 Sep 2018 11:04:32 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n14-v6sm3786234wmc.14.2018.09.06.11.04.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 11:04:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 07/11] submodule: move global changed_submodule_names into fetch submodule struct
References: <20180904230149.180332-1-sbeller@google.com>
        <20180904230149.180332-8-sbeller@google.com>
Date:   Thu, 06 Sep 2018 11:04:31 -0700
In-Reply-To: <20180904230149.180332-8-sbeller@google.com> (Stefan Beller's
        message of "Tue, 4 Sep 2018 16:01:45 -0700")
Message-ID: <xmqq7ejy1p00.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> The `changed_submodule_names` are only used for fetching, so let's make it
> part of the struct that is passed around for fetching submodules.

Yay.
