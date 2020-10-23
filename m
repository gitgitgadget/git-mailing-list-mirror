Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9986AC4363A
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 04:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 294C922206
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 04:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tH5S/jLI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbgJWEDX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 00:03:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55011 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbgJWEDX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 00:03:23 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ABA2A8E449;
        Fri, 23 Oct 2020 00:03:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=dOENaNt2wrPlvl5aNTGaiMJ1Q5o=; b=tH5S/jLIpLaeBIS74eNB
        dhOCLsFYqQ3UUW+avdPFcQ7w8/zbi2vEO1BtKWYZvQzeY3EEky8c4JS+NglZw22T
        XemvlJkkLMZ8hB4HB3ftvzzxq6mVArpSSJG6WY8OJWrQhiwLQshm+DlF28bobxcJ
        FZm9jtBDBikjqn8URIKcnK4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :references:date:message-id:mime-version:content-type; q=dns; s=
        sasl; b=TKkoNcrCoFvUGi5cKuSY65mWgZVmVhdCV6m9wduV9lX7fYMBk8E3GD3A
        n3S1PyOwoX4LJr5e80K8pqJEoIplu3sUcVWqhqPNbGw+hJH3UngMjpOazAORjLsZ
        v82m6CID0wHV6uakM3LCypKJ9R1n+DuqDiksa/d+mW0B7oDmQuw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 90E158E448;
        Fri, 23 Oct 2020 00:03:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0638A8E447;
        Fri, 23 Oct 2020 00:03:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] revision: wording tweak in comment for parsing "-m"
References: <20200829194634.23306-1-sorganov@gmail.com>
        <20200831201422.27189-1-sorganov@gmail.com>
Date:   Thu, 22 Oct 2020 21:03:20 -0700
Message-ID: <xmqqd019k2rb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B07481AA-14E4-11EB-9FAE-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We do not mean to say that the --ignore-merges (-m) option is to
show a patch with infinite number of context lines, but "show full
diff" can give such a wrong impression.  An alternative may be to
say "show diff with each parent for merges", but when combined with
the --first-parent option, the -m option does not mean that at all.
With these in mind, it seems that "do not hide" would probably be a
good enough compromise to clarify.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 revision.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index 73e3d14cc1..c34e1d0bed 100644
--- a/revision.c
+++ b/revision.c
@@ -2346,8 +2346,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "-m")) {
 		/*
 		 * To "diff-index", "-m" means "match missing", and to the "log"
-		 * family of commands, it means "show full diff for merges". Set
-		 * both fields appropriately.
+		 * family of commands, it means "do not hide diff for merges".
+		 * Set both fields appropriately.
 		 */
 		revs->ignore_merges = 0;
 		revs->match_missing = 1;
-- 
2.28.0-509-g776ef846e8

