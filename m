Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D77A01F406
	for <e@80x24.org>; Tue, 12 Dec 2017 18:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752745AbdLLSgu (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 13:36:50 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61886 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752585AbdLLSgp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 13:36:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AA1D3BF663;
        Tue, 12 Dec 2017 13:36:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8YXQ7zz/q1rp2u6SgXs5vEDofu0=; b=DWjpfw
        D7NkxuoLjYRJtgtUU1c5AmpSlxvMBOn3jSSSFnTLR/KBxseMSkJYX4Ms1agb9hol
        piQ1g2d/iBX1EexQO/XCgBWRArwVpiAQzQbTPb4HplfA+9wMXmC5aBY9RReyAQ60
        uWVwZ0A5opVZr+Ln3DfGylJUo9f/7wd8IR/X4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=s1Z8yJ8P9uexu3t58kuBipidId4EKGIC
        FRpmxskjAa7N+Qw827yyp5rddmKD/ZcPyDA/q/1tKKLb9vwNTOXuwYr13sdriXws
        ApoHwuYbj0gToD1xKg3NiGXDrcPL2VIPdYppHMuWCeCEITP3f6zHRhaf/jWs41L+
        hdjXaqxkxm0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A221BBF662;
        Tue, 12 Dec 2017 13:36:44 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 17B12BF660;
        Tue, 12 Dec 2017 13:36:44 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH] diffcore: add a filter to find a specific blob
References: <CAGZ79kaJgCchQKcRMkW-cjRmx_7eYQDqLs5GgDOgLEb1H=w-0g@mail.gmail.com>
        <20171212012422.123332-1-sbeller@google.com>
Date:   Tue, 12 Dec 2017 10:36:42 -0800
In-Reply-To: <20171212012422.123332-1-sbeller@google.com> (Stefan Beller's
        message of "Mon, 11 Dec 2017 17:24:22 -0800")
Message-ID: <xmqqpo7j3i9x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6707A472-DF6B-11E7-8A00-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Sometimes users are given a hash of an object and they want to
> identify it further (ex.: Use verify-pack to find the largest blobs,
> but what are these? or [1])
> ...
>  Documentation/diff-options.txt |  6 ++++
>  Makefile                       |  1 +
>  builtin/log.c                  |  2 +-
>  diff.c                         | 20 ++++++++++++-
>  diff.h                         |  3 ++
>  diffcore-objfind.c             | 42 ++++++++++++++++++++++++++
>  diffcore.h                     |  1 +
>  revision.c                     |  5 +++-
>  t/t4064-diff-oidfind.sh        | 68 ++++++++++++++++++++++++++++++++++++++++++
>  9 files changed, 145 insertions(+), 3 deletions(-)
>  create mode 100644 diffcore-objfind.c
>  create mode 100755 t/t4064-diff-oidfind.sh

Thanks.  Will drop an asdf and queue.  

I think this is ready for 'next'; I'll wait for a day or two just to
give us a final chance to spot and save us from minor embarrassments,
but I expect anything we'd spot from here on would be so minor that
we can go incremental.

