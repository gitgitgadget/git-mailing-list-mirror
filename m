Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D4B02095B
	for <e@80x24.org>; Sat, 18 Mar 2017 20:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751174AbdCRUXG (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 16:23:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54350 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751023AbdCRUXF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 16:23:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AC82388AE8;
        Sat, 18 Mar 2017 16:18:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+nkZpUeROhfY1Vs3Lr6cQBv8bgI=; b=NGUzaJ
        cEHss41eiiJjK1koFZP8kwp6dbUsNzG6PGqEOXuHaxHjWuu4eh+fL9FTM9rMEgtT
        ttGtwlTAvQTHB70Qq/FB+xcGOyZ9qZPElbWAQj67rVDczgkOmjw0moGatPcZiNNv
        WN1v4Q9KVlZhpjBlkzMzvUIqgat7shwVO2QDw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wTA3Xc4feu0JWcKJrdXZ7iy0ABrDqlwL
        rgK0wRTEEc377We44yA0pWJ3n6/oFH8CnrkQ3R3JXs75MBisHvnHaPAXGZQjKRvd
        vGqjhPGlZKFnjl23f8F2TjUY4zyVZSNmsIxJ3+8qtff5RnjeiGYdga/ftPYU/URx
        AaMQ0/4RKZg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A5F1C88AE7;
        Sat, 18 Mar 2017 16:18:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1700D88AE6;
        Sat, 18 Mar 2017 16:18:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     git@vger.kernel.org, Jonas Fonseca <jonas.fonseca@gmail.com>
Subject: Re: [PATCH] Inconsistency between git log and git rev-parse for ^HEAD^@
References: <1489866696-17487-1-git-send-email-agruenba@redhat.com>
Date:   Sat, 18 Mar 2017 13:18:18 -0700
In-Reply-To: <1489866696-17487-1-git-send-email-agruenba@redhat.com> (Andreas
        Gruenbacher's message of "Sat, 18 Mar 2017 20:51:36 +0100")
Message-ID: <xmqq7f3m1gqd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0767F35E-0C18-11E7-BD3E-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Gruenbacher <agruenba@redhat.com> writes:

> Hello,
>
> the log and rev-parse commands both support the rev^@ syntax which stands for
> all parents of rev.  The log command also supports ^rev^@ to exclude all of the
> parents of rev, but rev-parse does not.  Should this be fixed?
>
> If so, the following patch would be a start.

Hmph, would ^A..B and ^A...B also be turned into B..A and B...A in a
similar way?  I think the latter would not make much sense but ^A..B
might.

In any case, accepting ^rev^@ may make sense nevertheless.

