Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE4BC433EF
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 18:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36A1D61056
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 18:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350813AbhICSuv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Sep 2021 14:50:51 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55273 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235938AbhICSuu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Sep 2021 14:50:50 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A1D2015F788;
        Fri,  3 Sep 2021 14:49:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=n
        GV74ouXranw6jRRz3NYK2gQxKYKA5KLWrXWwC0vZxc=; b=F8bxsiE6kMvbykuwW
        Fi+1g1y1Ws2r2CWH79SgVwX5YvhANF2UbdLk7O0rWJf4ImDmiNsqm/pfn/jx259Y
        Emc74CtynQXG5wJIZbzy+dDP9y1ElYErxTXHA4uFIy2I8tcCD9OmwRDBv5OBfOM3
        d0ovKjbubLMmwdNmIbxnhX1qi0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9B0C615F787;
        Fri,  3 Sep 2021 14:49:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D0DD715F785;
        Fri,  3 Sep 2021 14:49:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [BUG?] git range-diff -Ix @{1}... segfaults
Date:   Fri, 03 Sep 2021 11:49:45 -0700
Message-ID: <xmqqbl59fq9i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B6651CB8-0CE7-11EC-A9D2-9BA3EF469F85-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It does not seem to trigger with an empty range, e.g.

    $ git range-diff -Ix HEAD...
    $ git range-diff -Ix HEAD~...
    -:  ---------- > 1:  0a0bc7d03a scalar: accept -C and -c opt...

but when it needs real comparison, the -I seems to kill the command
quite easily.

THanks.

    
