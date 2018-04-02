Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2467F1F404
	for <e@80x24.org>; Mon,  2 Apr 2018 21:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754442AbeDBVd0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 17:33:26 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39339 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754304AbeDBVdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 17:33:25 -0400
Received: by mail-wm0-f65.google.com with SMTP id f125so30134004wme.4
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 14:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=pNIiV4r0UIWTLRt22U/MMHtZcbT0epExwKEugmp4JQ8=;
        b=oRoxTPqY4sAhSNpDNvyKK65E5cNjc7jtQL0hYHKtMARe/zbsngzG44wLdb9X9PMatl
         TF4FLNAeEFni8/fzsFXUeStBCSIBr3Wp0ig/kAI0mehC7XMms5WUbnHfg4ZJ6EhKRB8p
         3orrW0rvPnXo0VYR3w8r2ylN8pR8NTxckz/ON+ecuoVkBrUpB1wuj17XOefYRGOGExYk
         OXS/VOMO9nsNbT+hjjjWv/T78zjc+C/QLns9rzW9sl3O3253IKYg119GS767JVtPT9le
         0gtFD72tMfQ0wvOUDOBaBjvam7G93xKzSTU+2UXnPOmEPyMlfJbVFnPXD7Z4Kb7se+ii
         2G6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=pNIiV4r0UIWTLRt22U/MMHtZcbT0epExwKEugmp4JQ8=;
        b=l0TVoziH/bW9+UMi1Vt97IB5VZI/hdxTNCJEShDi0T/I2bW6FbXB1ElgWn7l4qKoxy
         JgoX/GX1YOQ8LLJKafxc7hzxZEdvrGClBXkViRSMR13QxpuxEYzilu7dTpD8JYrxgoKS
         ktYkz8p3xMsPmmrUK+tHHTudsgJaYLo3q/H93JDjW3T63bFeAeqwVmRCvGZksvUhwyEI
         5yPIWcv3XSZtpF7f8sam2ceIX2aj210srICvbWeMzu6AP7I9qkl95CR+wwaUXF6oQXIB
         8s5unjbkWIE9gQxnvmBltrH6eT0GX4HrBHsulyrA9CCWPxnLgiE0/FEdCYgmGV+dzOxI
         u0YA==
X-Gm-Message-State: AElRT7HAjD18XECqEkzhT8GeKf/aONEfLo1DGVd4YfesJ35s6+MGg7Om
        ed3hbYcwioP6bCqzFFm8sbw=
X-Google-Smtp-Source: AIpwx4/kyHzivMO61HQBKrGFwwBJxOlDeA6pMfgTAZ158dizDBg7d1UdFiW7NiuP2u+DE1j+G+HUzA==
X-Received: by 10.28.226.138 with SMTP id z132mr1810564wmg.101.1522704803784;
        Mon, 02 Apr 2018 14:33:23 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 96sm1013497wrk.54.2018.04.02.14.33.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Apr 2018 14:33:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, szeder.dev@gmail.com,
        ramsay@ramsayjones.plus.com, git@jeffhostetler.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v7 08/14] commit-graph: implement git commit-graph read
References: <20180314192736.70602-1-dstolee@microsoft.com>
        <20180402203427.170177-1-dstolee@microsoft.com>
        <20180402203427.170177-9-dstolee@microsoft.com>
Date:   Mon, 02 Apr 2018 14:33:22 -0700
In-Reply-To: <20180402203427.170177-9-dstolee@microsoft.com> (Derrick Stolee's
        message of "Mon, 2 Apr 2018 16:34:21 -0400")
Message-ID: <xmqqo9j1xpi5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
> ...
> +static int graph_read(int argc, const char **argv)
> +{
> +	struct commit_graph *graph = 0;

The previous round said NULL above, not 0, and NULL is the better
way to spell it, I would think.
