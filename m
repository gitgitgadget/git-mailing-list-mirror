Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 541C21FCA9
	for <e@80x24.org>; Wed, 14 Sep 2016 22:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756946AbcINWyn (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 18:54:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52623 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754934AbcINWym (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2016 18:54:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 438853A704;
        Wed, 14 Sep 2016 18:54:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3f39uRCbOzcGgIl1MDpqyE1pHew=; b=hMC/3B
        J7vIi02xdXMVVw4k0xWcIotOe0Gd4icL6lTuP6xhppBZ3cddy6Q5pUbQMv6DnoAA
        /E27BqSE58ajgQVT5Oa15iQjnhmhX6IlJVLXDmnP7pIW5Yb2Li/sV0JIwo+2tRdn
        nJjupKXbBQz6fQuxzHbETBFJtKcuZwGQv6ogw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VKpcoe3EP6BL4yEg5X9MZujZZhdJL+H5
        ucBxtR3i29k0IUOuHSuwmpKjAW634zlhDioYsJMXbZTQMPhHtnYG3R9otqAb38DR
        NkyB5ktFfvdEs1aubEkcqsQsCM9gp0hC7EWUkWP21IK+3IfPGtWkiUIv+KgRqyFY
        bOuncV6rj0Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3BE2E3A703;
        Wed, 14 Sep 2016 18:54:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B80033A701;
        Wed, 14 Sep 2016 18:54:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Jan Keromnes <janx@linux.com>,
        Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>,
        Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [PATCH v4 3/4] read-cache: introduce chmod_index_entry
References: <20160912210818.26282-1-t.gummerer@gmail.com>
        <20160914210747.15485-1-t.gummerer@gmail.com>
        <20160914210747.15485-4-t.gummerer@gmail.com>
        <xmqqbmzqqhm7.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 14 Sep 2016 15:54:38 -0700
In-Reply-To: <xmqqbmzqqhm7.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 14 Sep 2016 14:46:56 -0700")
Message-ID: <xmqqsht2ozwx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3854C52C-7ACE-11E6-971B-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've queued this trivial SQUASH??? on top, which I think should be
squashed into 3/4.

Thanks.


 read-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index 2445e30..c2b2e97 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -779,7 +779,7 @@ int chmod_index_entry(struct index_state *istate, struct cache_entry *ce,
 	default:
 		return -2;
 	}
-	cache_tree_invalidate_path(&the_index, ce->name);
+	cache_tree_invalidate_path(istate, ce->name);
 	ce->ce_flags |= CE_UPDATE_IN_BASE;
 	istate->cache_changed |= CE_ENTRY_CHANGED;
 
-- 
2.10.0-458-g8cce42d

