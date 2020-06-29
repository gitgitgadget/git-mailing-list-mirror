Return-Path: <SRS0=sGv9=AK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2F4C433E0
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 22:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 553B620702
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 22:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="akXZxU09"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbgF2WyP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Jun 2020 18:54:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63943 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbgF2WyP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jun 2020 18:54:15 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9B60583035;
        Mon, 29 Jun 2020 18:54:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3rkCUuZNnZ/cvyGmSGZ1WE8AnJA=; b=akXZxU
        092Hc2AMEQwwG8yqHQjzjHaD7RGDqSQJYgKsbcVONJ5T0HFBF4fMx6CgGKxkULYb
        gwlJBUa/oRlXBsFWOH6gZwT75fj0I761ZzAjWeWNobOqQXtf3pYNMvIUu6fMDaBL
        KaZB4C+jPZmL3b1TV3sErWjQ4DxDhzm2JmiAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=k2/Xc01pE+UISjqQEVhPMn/sJHtIYnWl
        shimRkGipAxmTIAyeD88idqR5Hx9cc01/NlAI03CgbC+LY7VhDkxmVxuzqFIY5+u
        WqVHS7LAR6EQBPriX9sRS4CxfAZ8ftoapOI5Q/4vx9WFyJowLuM47XbIbw3ogCFL
        sdDPd3WLtWM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 93E7083034;
        Mon, 29 Jun 2020 18:54:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E20FA83033;
        Mon, 29 Jun 2020 18:54:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v19 00/20] Reftable support git-core
References: <pull.539.v18.git.1592862920.gitgitgadget@gmail.com>
        <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
Date:   Mon, 29 Jun 2020 15:54:12 -0700
In-Reply-To: <pull.539.v19.git.1593457018.gitgitgadget@gmail.com> (Han-Wen
        Nienhuys via GitGitGadget's message of "Mon, 29 Jun 2020 18:56:38
        +0000")
Message-ID: <xmqqimf9fppn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 74040332-BA5B-11EA-8E90-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> base-commit: b9a2d1a0207fb9ded3fa524f54db3bc322a12cc4

This is based on 'next', which usually is a sure way for a topic to
stay forever out of 'next', but we have impactful dependence only on
two topics, I think, and a good news is that both of them are in
pretty good shape.  I think Brian's part 2 of SHA-256 work should be
on the 'master' branch soon, and Dscho's "customizable default
branch" is also ready---it just would, like all other topics, want
to spend at least one week on 'next' to be safe.  And after that,
this topic can be directly on 'master' (there is another trivial
conflict around bisect--helper, but I am not worried about it),
which looks quite good.

Tentatively I've prepared a merge of bc/sha-256-part-2 and
js/default-branch-name on top of today's 'master' and these patches
applied cleanly on the result.  As you mentioned, we may want to
flip the orders of patches a bit to split uncontroversial ones out
to a separate preparatory topic and get them merged to 'next' and
then to 'master' earlier than the remainder.

Thanks.

-- >8 --
fixup! Reftable support for git-core

Noticed by the "make && make distclean && git clean -n -x" test.

diff --git a/Makefile b/Makefile
index d949b79720..c22fd41662 100644
--- a/Makefile
+++ b/Makefile
@@ -3153,7 +3153,7 @@ cocciclean:
 clean: profile-clean coverage-clean cocciclean
 	$(RM) *.res
 	$(RM) $(OBJECTS)
-	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(VCSSVN_LIB) $(REFTABLE_LIB)
+	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(VCSSVN_LIB) $(REFTABLE_LIB) $(REFTABLE_TEST_LIB)
 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) git$X
 	$(RM) $(TEST_PROGRAMS)
 	$(RM) $(FUZZ_PROGRAMS)
-- 
2.27.0-221-ga08a83db2b






