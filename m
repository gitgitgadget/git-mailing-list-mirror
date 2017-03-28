Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A53981FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 18:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754438AbdC1Sfx (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 14:35:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61375 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753284AbdC1Sfw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 14:35:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1104876AF8;
        Tue, 28 Mar 2017 14:35:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=G
        4H4Z7L7ZEloXLZlnd8t720WssA=; b=LmH3J1kJQkQSiF6V2elcX8mQOm6Rhi2if
        em0WZYnf/YMNfUbqkbSGuHpoNCtkfW6Tl6lc93Op9FXKw5pu706iBuakQKA/qGKT
        z4ybOmJOFeOo/bSKQ2wDhCOmJtmOWfuiZwLHLPpQSjunkgsj3DqrNtdwDfbjcnKs
        0bIORt13hY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=sZ+
        s7ZR/cJBsj6uyz5aMlNmlW8ah0zWITCwRQONPoMnawO2nnTlKd0T79dYI15ALaCH
        L4J9EpeUTmLaFT1mfhEcXBOScYTgCSemibg4ErP0/XNKwGtMRi/g6SQd5QNAUWVA
        +hbihp8MBYuIddN6Aw/UZkii20oc8d+5EqcM18CA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 09DEE76AF7;
        Tue, 28 Mar 2017 14:35:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6571676AF6;
        Tue, 28 Mar 2017 14:35:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [RFC] should these two topics graduate to 'master' soon?
Date:   Tue, 28 Mar 2017 11:35:29 -0700
Message-ID: <xmqqshlxckr2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 521F4346-13E5-11E7-A612-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are two topics that are marked as "Will cook in 'next'" for
practically forever in the "What's cooking" reports.  The world may
have become ready for one or both of them, in which case we should
do the merge not too late in the cycle.

* jc/merge-drop-old-syntax (2015-04-29) 1 commit

  This topic stops "git merge <message> HEAD <commit>" syntax that
  has been deprecated since October 2007 (and we have issued a
  warning message since around v2.5.0 when the ancient syntax was
  used).

* jk/no-looking-at-dotgit-outside-repo-final (2016-10-26) 1 commit

  This is the endgame of the topic to avoid blindly falling back to
  ".git" when the setup sequence said we are _not_ in Git repository.
  A corner case that happens to work right now may be broken by a call
  to die("BUG").

I am leaning toward including the former in the upcoming release,
whose -rc0 is tentatively scheduled to happen on Apr 20th.  I think
the rest of the system is also ready for the latter (back when we
merged it to 'next' and started cooking, there were still a few
codepaths that triggered its die(), which have been fixed).

Opinions?



