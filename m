Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79D601F667
	for <e@80x24.org>; Sat, 19 Aug 2017 20:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751660AbdHSUaW (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Aug 2017 16:30:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64257 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751535AbdHSUaV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Aug 2017 16:30:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7FA64AB58F;
        Sat, 19 Aug 2017 16:30:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=4y+r
        AuYkE6EeyjImRM47aOnZwrQ=; b=DZozwecADE0tC5pmnci4qaZJt059q9Ns2Tbs
        qOLHFlOVnY3a1K1z5AsgH0yVoxPwu8/iIFE+HRbk1v7Hry2hKgbY1wtmnxa7d+/4
        s/QUZLKK0AJkvYq3Kaj1qjW8a7K/SOEbZAtA0CMTqQhfdhXHzKj7iKhP1HceNTl2
        nCeyaIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        pseKqPxyJZ63ttWuXs5GBAvhhsuJuijkGlctWxpTiUnFPtaY5F2/nxpZWnw3QTVY
        hQMcamBGiOa2UslNw0GxXU/My/EXfcjaCs7+Gnl1Kb84FneUWXLvrzRyBrz/Z6+I
        njxkHC/teAXcjV4NdqbbXxlU+ZLU7OCVxfOUXf4wC8A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7946FAB58E;
        Sat, 19 Aug 2017 16:30:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E2527AB58C;
        Sat, 19 Aug 2017 16:30:14 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Uwe Hausbrand <uwe.hausbrand@gmx.de>
Subject: [PATCH 0/2] accept non-integer for "this many days" expiry specification
Date:   Sat, 19 Aug 2017 13:30:11 -0700
Message-Id: <20170819203013.3053-1-gitster@pobox.com>
X-Mailer: git-send-email 2.14.1-405-g52c75fc716
In-Reply-To: <xmqqfudpj1vo.fsf@gitster.mtv.corp.google.com>
References: <xmqqfudpj1vo.fsf@gitster.mtv.corp.google.com>
X-Pobox-Relay-ID: 3518122E-851D-11E7-B57A-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

About a month ago, we wondered why

	[gc]
		rerereResolved = 5.days

does not work and if we want to do something better.  

Here is a pair of patches that attempt to improve the situation.

Junio C Hamano (2):
  rerere: represent time duration in timestamp_t internally
  rerere: allow approxidate in gc.rerereResolved/gc.rerereUnresolved

 Documentation/config.txt |  2 ++
 config.c                 |  4 ++--
 config.h                 |  3 +++
 rerere.c                 | 46 +++++++++++++++++++++++++++++++++-------------
 4 files changed, 40 insertions(+), 15 deletions(-)

-- 
2.14.1-405-g52c75fc716

