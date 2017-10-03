Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCC5320281
	for <e@80x24.org>; Tue,  3 Oct 2017 04:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750787AbdJCEHk (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 00:07:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56234 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750708AbdJCEHj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 00:07:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 78C1DB5211;
        Tue,  3 Oct 2017 00:07:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=OCTz
        V4/tfHVyF4vo0/lleB7Nf14=; b=mpi29yAf8Y0xWt3QojX3L4H/0UcxtvaOhgWi
        qEPijsjuzz2pX/E9m3Ggh15HQSWZVHVdFnG089ZeIb/N5ML5JCSTyLDAJQjV2Wq2
        F1OsnK7qcoJoRollHrqWatvsuhETBaG9OXpdyi5b2HJQGnupY3Xmw0s2UHKeaI0F
        vfjWrlU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        mQVHl1JmTD3ftaxaOpZqXL6gdp0mxG0Z4E8AxDF+i0ctrV7xmo3cT+dOSjK/QjOo
        YdxkrTdc/D+qo9kd+8+0tZvv8teBXBCz3ixN+3hpuzwuR7KMP7MSOjKHsX1nidQY
        dsPuNEm+5mWqgCNcXbbrHeyfO3VOkDJqxSDpGzymTso=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 70C3FB5210;
        Tue,  3 Oct 2017 00:07:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DC045B520F;
        Tue,  3 Oct 2017 00:07:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH 0/2] fixing "add -p" regression
Date:   Tue,  3 Oct 2017 13:07:35 +0900
Message-Id: <20171003040737.2336-1-gitster@pobox.com>
X-Mailer: git-send-email 2.14.2-882-gfe33df219d
In-Reply-To: <20171002230017.GT19555@aiede.mtv.corp.google.com>
References: <20171002230017.GT19555@aiede.mtv.corp.google.com>
X-Pobox-Relay-ID: 6527BE24-A7F0-11E7-ADFF-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We were a bit too agressive in pushing color.ui configuration to
plumbing commands.  A real fix must be found to override the default
"auto" use of colors for any color-capable plumbing commands, but
let's leave that to a later round and concentrate on fixing the
regression first.

Junio C Hamano (2):
  Revert "color: check color.ui in git_default_config()"
  colors: git_default_config() does not read color.ui

 builtin/branch.c       | 2 +-
 builtin/clean.c        | 3 ++-
 builtin/for-each-ref.c | 3 ++-
 builtin/grep.c         | 2 +-
 builtin/show-branch.c  | 2 +-
 builtin/tag.c          | 2 +-
 color.c                | 8 ++++++++
 config.c               | 4 ----
 diff.c                 | 3 +++
 9 files changed, 19 insertions(+), 10 deletions(-)

-- 
2.14.2-882-gfe33df219d

