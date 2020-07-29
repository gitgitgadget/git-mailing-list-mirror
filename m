Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE26C433E0
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 21:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A82F2084D
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 21:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="H34h8B14"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgG2VKe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 17:10:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64599 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgG2VKe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 17:10:34 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6CBF180D27;
        Wed, 29 Jul 2020 17:10:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GB41pIUVIyYdUZgUSy13U0f214Y=; b=H34h8B
        14epq2P4UfjNnmJLM0xxTBIIX1RT9LERpgMqBo9kfueovK6p84aijZKw75cq/4tQ
        TXrut08L4dW+2fUzyPbsq7IRwqbbZprv37JEHQyROqNv7QUOtmMh7atm1lQGno0m
        vs7pYGtdC+1y0B+sHN6kfUVfdl2syHiQAmlmo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=C1wtXDBP7SA5OdIHLbiMPZHEYWFbWysq
        7E7iCLdbq+C7wsexcbHVLcKwYrVp+F3umZRUiwaYzJbn1twpInshLAhzPiGnvNuG
        xrVvKZdD/wLiQhcIxPQxy00l+UuZ4yXxZCguQgPFmqKVCBjM0iLbScnN2oFZEK6N
        p3Ty4bFWoB0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 659CB80D26;
        Wed, 29 Jul 2020 17:10:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E61A580D25;
        Wed, 29 Jul 2020 17:10:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 6/7] doc/git-log: move "-t" into diff-options list
References: <20200729201002.GA2989059@coredump.intra.peff.net>
        <20200729201210.GF2989342@coredump.intra.peff.net>
Date:   Wed, 29 Jul 2020 14:10:31 -0700
In-Reply-To: <20200729201210.GF2989342@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 29 Jul 2020 16:12:10 -0400")
Message-ID: <xmqqzh7i81tk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EFD0F376-D1DF-11EA-80B9-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The "-t" option is infrequently used; it doesn't deserve a spot near the
> top of the options list. Let's push it down into the diff-options
> include, near the definition of --raw.

True.  It does not have any effect unless --raw is in use (i.e.  it
does have an effect to "git show --patch-with-raw" or anything that
(also) shows "--raw" output), and it makes sense to have "-t" near
"--raw".
