Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A9641F404
	for <e@80x24.org>; Fri, 23 Feb 2018 19:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754937AbeBWTwD (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 14:52:03 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55762 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754903AbeBWTwB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 14:52:01 -0500
Received: by mail-wm0-f65.google.com with SMTP id q83so6724933wme.5
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 11:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zJq+8ySnNp/VKfSYfE+QCei708213W/gWUKWhupK/+M=;
        b=gTS2FxmZqASOHgnVJRCr0ClwIvB8EdBUwyRMt/jSR1rD5VunIZlgT9PSG010t93/6+
         BDH5onBDJNIqRV9RuSII6GQoljvK+z8cpZOsdr58AtvKThDI9PJp6mKh4WB0ehw7tYFH
         rDgsDLqbxMonAzlzWdvRtUFgP9BPFWzyu7VEUK+H0aCaM5Dvxdf3yX6mE2KzkRdurU/h
         ElhGgZoku0veUFN58PU1PR6YbyviDPR1gvRJTnzYQLqobAEjEcYP0RmWL44FhwHNkI4m
         QGnbkF2PW3aLhQa5evlX68s0gsOpVGVZJ4etvqR+n9mtX7lyDXo1daN3a6Y46M7ZiMyO
         I9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zJq+8ySnNp/VKfSYfE+QCei708213W/gWUKWhupK/+M=;
        b=e6ap6VVJ4Xe2hdP4H303xIDG74weSCnKGaIXGY+yMbW+GsBavs2JcPGm53tzTvRy1o
         t9t3R3ItTHzAjMZ5j2QLo/YwtJPHHlLyfZQUbAIIJGhhtC+kpSLbkzZfp1AQqfW5VPnf
         JpC8Kmos1xIChQZ+BLHnUWRJlVxEokDkY5VMtiDG/F0yKy5AebqmVqSGk0Kn4C0MCDLy
         Xh54kH2od79R2fD3M96GzHW16VGGCmWfnDCDMbY2yqfzklVyz6r9LvJv4RE58F7lxlb/
         IP/stunXRlLIQVQIwSg3zcfqxCdy6ZGFbjfySK63Cuxq9F2nXDE3Sf4GT/2QGMPIcImx
         hUnQ==
X-Gm-Message-State: APf1xPAQhRKgZ8gP1smuOSYCCjr7xp5IpEnMveGLyvuWE42doThC3Xxn
        N4rOoRutzerGY8Fccns5RzM=
X-Google-Smtp-Source: AG47ELs0ABnRyxp/MwjKwLFPm9r1sjzif9feXiq5Y4nWV73wB4OpDsESGsLb76qMGo71Ql9FVU1Omg==
X-Received: by 10.28.108.6 with SMTP id h6mr2563883wmc.6.1519415519990;
        Fri, 23 Feb 2018 11:51:59 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id r1sm3048757wmg.22.2018.02.23.11.51.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 11:51:59 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, peff@peff.net,
        jonathantanmy@google.com, szeder.dev@gmail.com, sbeller@google.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 08/13] commit-graph: implement --delete-expired
References: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
        <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
        <1519066406-81663-9-git-send-email-dstolee@microsoft.com>
        <xmqqfu5sx3md.fsf@gitster-ct.c.googlers.com>
        <67871288-ea70-69d4-9c3d-5cc946d8dbe2@gmail.com>
        <xmqqo9kftsa5.fsf@gitster-ct.c.googlers.com>
        <8c958ada-b96b-cdc7-594c-c6f6cdb02b70@gmail.com>
Date:   Fri, 23 Feb 2018 11:51:58 -0800
In-Reply-To: <8c958ada-b96b-cdc7-594c-c6f6cdb02b70@gmail.com> (Derrick
        Stolee's message of "Fri, 23 Feb 2018 14:41:01 -0500")
Message-ID: <xmqqbmgftrfl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> My thought was that using a fixed name
> (e.g. .git/objects/info/commit-graph) would block making the graph
> incremental. Upon thinking again, this is not the case. That feature
> could be designed with a fixed name for the small, frequently-updated
> file and use .../info/graph-<hash>.graph names for the "base" graph
> files.

I guess that is in line with the way how split-index folks did their
thing ;-)
