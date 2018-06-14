Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 461371F403
	for <e@80x24.org>; Thu, 14 Jun 2018 19:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755280AbeFNTgX (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 15:36:23 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55123 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755261AbeFNTgV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 15:36:21 -0400
Received: by mail-wm0-f68.google.com with SMTP id o13-v6so12350677wmf.4
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 12:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Thi9eioletaSMnWEg+/oMJmEvOsQTLF5tpZa3IF4A8o=;
        b=Dw4JMmHN1A9ZYd4e0YLxrVYvR8Rhy1OVZXSghpJURaa4YXGDoDVTLwhI4k15AtnQ1+
         9fIYKtAzr8HSCOU/344I0GTNeyFymDg6QaIw7FpjLY/QZoYX+xpcGsWxPJkZeN0OlLtt
         6W/Q7Otj7683NEyTzaEFiuPOUNgTEN5eBtMxu5u41IMliwd6htleLxog6jj1Sh3SBYp7
         ifNRNW+97Lpix/gKk1b3awqyafzoP7Q5thY4xIMZUbqrpDreYcjJSOlZ8puSMoVgZPG3
         7TSQBSpxUR1WQWZp4jxQ7gzrmM9oa0vozevSsWngH4fmcJK5OJbfiWDPyBd6LZ0a4vGi
         GbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Thi9eioletaSMnWEg+/oMJmEvOsQTLF5tpZa3IF4A8o=;
        b=rcyWVheWZecf71X7aWbUICLNh+RPSoESEZcROPO1sgekbxrUdXCNqvUsz27kCn5d6Z
         KiwbQr6qj4N9e2MXLHAha0ITxpwPcKuqA9gHG7wqmY/c6CCXjVdPv3DC6Q06ED65hAgH
         K8TP2/u1FD7vOchip+2YZ0ak+88oPEAR1kwpip5JL0yjwwJli3deGjMu7L2bM5AFvRcO
         YA2IS58k0mJ5+dZd/J/CdW4pXJa823Ij04/BWQmXarDJFx923bmIR/NV73HSvrXFQfDd
         XXjq7+mrcC3GF7HTtTHGU9SeZFctot26zFxerBIzjNzVPsna5IPuhUtsUh93iN26xdDd
         SGyQ==
X-Gm-Message-State: APt69E0rm3KzHh6mVZMjIiWD2vQQ09gx2Gbf1uBgE3a2tsqFz/z+GwIo
        s/4sQB8CoHTrHEDh6aIfEoA=
X-Google-Smtp-Source: ADUXVKLcPk/hPNZhuytFJRjhlW5zGr3zitmfIk/+451Bfxjy/iynA0lvkwThHBBMNTiPhD4c1NRVtQ==
X-Received: by 2002:a1c:f513:: with SMTP id t19-v6mr3114148wmh.50.1529004980290;
        Thu, 14 Jun 2018 12:36:20 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id u70-v6sm9099419wmd.3.2018.06.14.12.36.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Jun 2018 12:36:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH v2 5/8] fetch-pack: make negotiation-related vars local
References: <cover.1527894919.git.jonathantanmy@google.com>
        <cover.1528317619.git.jonathantanmy@google.com>
        <955d9f62d2c8400791501d71c72fea4ef2dc1cff.1528317619.git.jonathantanmy@google.com>
Date:   Thu, 14 Jun 2018 12:36:19 -0700
In-Reply-To: <955d9f62d2c8400791501d71c72fea4ef2dc1cff.1528317619.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Wed, 6 Jun 2018 13:47:11 -0700")
Message-ID: <xmqq36xp40uk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> -static struct prio_queue rev_list = { compare_commits_by_commit_date };
> -static int non_common_revs, multi_ack, use_sideband;
> +struct data {
> +	struct prio_queue rev_list;
> +	int non_common_revs;
> +};
> +
> +static int multi_ack, use_sideband;

Aside from Brandon's comments, I think passing these throughout the
callchain instead of having them as static-globals is a step in the
right direction.  Could you, however, give the structure a bit more
descriptive name, than simply "data"?  Anything the computer works
on is "data", and there must be something more specific than that
about this particular struct ;-)

