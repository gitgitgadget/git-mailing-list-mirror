Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D9B91F406
	for <e@80x24.org>; Wed, 17 Jan 2018 18:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932081AbeAQScf (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 13:32:35 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56956 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753526AbeAQSce (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jan 2018 13:32:34 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B9277C7002;
        Wed, 17 Jan 2018 13:32:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NZZok8uYFAKqUOdgmzAFibnBsM8=; b=GCr6pS
        6GRb2RUXWSmUrJ0CZksYkFRSYqKUBy+etD4t/OD5FI6ZfU1sTjU3ZOo4znOYDC/q
        FA4vQkJqoDHTOaKnEndGgZ9N46mqVtdN71w/9dCiTqDk4Ge/iSh5zBMnApBwFFY2
        1N+wbTib7Iu0keNYJbEU2ZQjFP5O/8ZIj3TGU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WhGp+jpC1MTg3vmQXHugcwUdNY9gO0B0
        PTu6lhjSqm+7R2k4Y7PFpBfTXWOi0REz2m5HiDnV2I5XMFFBZdEr7WRbXgmaDK6+
        j08MmuJl5Pxy2TyC/BCAwcsGJM7L4xDT/tFATz33Iy7m4oTYyDEBcP3msoPjiJBt
        /YKwRjlQpNk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B0520C7001;
        Wed, 17 Jan 2018 13:32:33 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 30DC3C7000;
        Wed, 17 Jan 2018 13:32:33 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re* misleading "man git-worktree", is last "add" argument necessarily a "branch"?
References: <alpine.LFD.2.21.1801170455380.16166@localhost.localdomain>
        <CACsJy8A0BcdqwkDDd0Fx_8DDCgJc6gZaXkcYqysdv8BH1nvibQ@mail.gmail.com>
Date:   Wed, 17 Jan 2018 10:32:32 -0800
In-Reply-To: <CACsJy8A0BcdqwkDDd0Fx_8DDCgJc6gZaXkcYqysdv8BH1nvibQ@mail.gmail.com>
        (Duy Nguyen's message of "Wed, 17 Jan 2018 20:34:14 +0700")
Message-ID: <xmqqh8rks5dr.fsf_-_@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C85A4968-FBB4-11E7-B5F4-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Jan 17, 2018 at 7:58 PM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>>
>>   perusing "git worktree", and man page reads:
>>
>>   SYNOPSIS
>>        git worktree add [-f] [--detach] [--checkout] [--lock]   \
>>                         [-b <new-branch>] <path> [<branch>]
>>                                                  ^^^^^^^^^^
>>
>> however, can't that last optional argument be any arbitrary commit,
>> not just a "branch"?
>
> It's been changed to commit-ish about two months ago in c4738aedc0
> (worktree: add can be created from any commit-ish - 2017-11-26)

Indeed "git worktree --help" is more up to date, but "git worktree
-h" is stale.

-- >8 --
Subject: worktree: say that "add" takes an arbitrary commit in short-help

c4738aed ("worktree: add can be created from any commit-ish",
2017-11-26) taught "git worktree add" to start a new worktree
with an arbitrary commit-ish checked out, not limited to a tip
of a branch.  

"git worktree --help" was updated to describe this, but we forgot to
update "git worktree -h".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/worktree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 7cef5b120b..9efdc22466 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -14,7 +14,7 @@
 #include "worktree.h"
 
 static const char * const worktree_usage[] = {
-	N_("git worktree add [<options>] <path> [<branch>]"),
+	N_("git worktree add [<options>] <path> [<commit-ish>]"),
 	N_("git worktree list [<options>]"),
 	N_("git worktree lock [<options>] <path>"),
 	N_("git worktree prune [<options>]"),


