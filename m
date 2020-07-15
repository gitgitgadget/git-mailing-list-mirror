Return-Path: <SRS0=3l3d=A2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C83C433E2
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 15:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BF9D206D5
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 15:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aKsS67sp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgGOPE5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jul 2020 11:04:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63672 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgGOPE5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jul 2020 11:04:57 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B0B4A6E0BE;
        Wed, 15 Jul 2020 11:04:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vSnfe+DeTfHt0KrIzNw9eA2rNNE=; b=aKsS67
        speuB/3sBExlgN/+Z0y7ssrWRn9IKgeH5XxTXuvDvtvxC7ZEETT613FJ9nIZQxcc
        UxrJOItrAp6HBKH3Fuw959lPGgqmKj8937IDxVQ7c0JYDv1X+LdfvSq3ZuJJaT4/
        vNBabibwWAI6FTXm863V7ZPMpCDC6CNKaTCGw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=W37Z/kbGbY0B1kx7PDd/ugF3v+m1cEi9
        5ru8Mu2wtYYHSCJIu+Rj4KmeXWYPksk4gAs+Mf5QYXVNiSiSGi5duwc6a2gfi56O
        E14xi4HMqp3z6lEqVs8AhX8I1t6TeIRNb2RrSiJiJ9u28xQN4s1GAAn57ws0DBTO
        +BTSXJLR+Aw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A81CC6E0BD;
        Wed, 15 Jul 2020 11:04:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 336386E0BC;
        Wed, 15 Jul 2020 11:04:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Wong <e@80x24.org>, git@vger.kernel.org,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 0/4] deterministic commit timestamps in tests
References: <20200709203336.GA2748777@coredump.intra.peff.net>
        <xmqqa707rpuu.fsf@gitster.c.googlers.com>
        <20200714123142.GA2587001@coredump.intra.peff.net>
        <20200714123334.GB2587001@coredump.intra.peff.net>
        <20200714214728.GA21660@dcvr>
        <20200715074250.GB3249056@coredump.intra.peff.net>
        <xmqqa700ltn2.fsf@gitster.c.googlers.com>
Date:   Wed, 15 Jul 2020 08:04:52 -0700
In-Reply-To: <xmqqa700ltn2.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 15 Jul 2020 07:50:25 -0700")
Message-ID: <xmqqwo34keej.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 89879E14-C6AC-11EA-BC5E-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Heh, it already is in 'next' and I do not think it is worth
> rewinding and rebuilding to cause downstream folks an additional
> trouble.  I however think this updated solution is nicer and do not
> mind building on top i.e. "while an earlier change did unbreak the
> svn tests, relying on the current timestamps is not nice and here is
> an update".
>
> Having said that, I think it is more urgent to address the "ouch, we
> made it clera that repos with extensions.worktreeconfig set without
> marking them as repoformat v1 are broken and without giving users
> enough hints to recover" issue discussed elsewhere before -rc1 (and
> for that reason I do not think I can tag -rc1 today), so I'd
> backburner it.  This topic won't merge down from 'next' until final
> anyway.

Before I forget, here is what could be applied on top of the "fix
the starting timestamp for the world" step as a "further polishing
on top of the completed series".

-- >8 --
From: Jeff King <peff@peff.net>
Date: Wed, 15 Jul 2020 03:42:50 -0400
Subject: [PATCH] t9100: stop depending on commit timestamps

An earlier "fix" to this script gave up updating it not to rely on
the current time because we cannot control what timestamp subversion
gives its commits.  We however could solve the issue in a different
way and still use deterministic timestamps on Git commits.

One fix would be to sort the list of trees before removing duplicates,
but that loses information:

  - we do care that the fetched history is in the same order

  - there's a tree which appears twice in the history, and we'd want to
    make sure that it's there both times

So instead, let's de-duplicate using a hash (preserving the order), and
drop only lines with identical trees and subjects (preserving the tree
which appears twice, since it has different subjects each time).

Signed-off-by: Jeff King <peff@peff.net>
Acked-by: Eric Wong <e@80x24.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t9100-git-svn-basic.sh | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index a89d338aa7..8dd9645ce5 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -8,10 +8,6 @@ GIT_SVN_LC_ALL=${LC_ALL:-$LANG}
 
 . ./lib-git-svn.sh
 
-# Make sure timestamps of commits created by Git interleave
-# with those created by "svn set-tree".
-unset GIT_COMMITTER_DATE
-
 case "$GIT_SVN_LC_ALL" in
 *.UTF-8)
 	test_set_prereq UTF8
@@ -204,8 +200,9 @@ GIT_SVN_ID=alt
 export GIT_SVN_ID
 test_expect_success "$name" \
     'git svn init "$svnrepo" && git svn fetch &&
-     git rev-list --pretty=raw remotes/git-svn | grep ^tree | uniq > a &&
-     git rev-list --pretty=raw remotes/alt | grep ^tree | uniq > b &&
+     git log --format="tree %T %s" remotes/git-svn |
+	awk "!seen[\$0]++ { print \$1, \$2 }" >a &&
+     git log --format="tree %T" alt >b &&
      test_cmp a b'
 
 name='check imported tree checksums expected tree checksums'
-- 
2.28.0-rc0


