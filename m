Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A35C001DC
	for <git@archiver.kernel.org>; Wed, 26 Jul 2023 05:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjGZFQ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jul 2023 01:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjGZFQz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2023 01:16:55 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB4A1FEF
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 22:16:54 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4E9203593C;
        Wed, 26 Jul 2023 01:16:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Rww6tjc0mCUkrQWJqOsjP+MxEXwkBstCE5OWlM
        pHIUc=; b=ew6WxNKP/PCrIdaGky9tRsnQdhsB65J2SEHtAzAOYj9b+uJwfoPPxN
        v76CGNCAzqc0hKkPPxDmHeCF7jtXcavGvWWfRW/LEzEDxkcj+1Eekfha92/saXSn
        oj7yqLA09euzvzvcYFp4pmXsenEbYE81nrkz1r0yhXvkWjtufXsrM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 47ABD3593B;
        Wed, 26 Jul 2023 01:16:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D7F563593A;
        Wed, 26 Jul 2023 01:16:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Linus Arver <linusa@google.com>
Subject: [PATCH v3 6/5] SubmittingPatches: choice of base for fixing an
 older maintenance track
References: <pull.1556.v2.git.1689314493.gitgitgadget@gmail.com>
        <pull.1556.v3.git.1690340701.gitgitgadget@gmail.com>
Date:   Tue, 25 Jul 2023 22:16:49 -0700
In-Reply-To: <pull.1556.v3.git.1690340701.gitgitgadget@gmail.com> (Linus Arver
        via GitGitGadget's message of "Wed, 26 Jul 2023 03:04:56 +0000")
Message-ID: <xmqqh6prfe0u.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A07F7EE6-2B73-11EE-8C42-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When working on an high-value bugfix that must be given to ancient
maintenance tracks, a starting point that is older than `maint` may
have to be chosen.

Helped-by: Linus Arver <linusa@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/SubmittingPatches | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index f1774c91e9..d1e3783978 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -46,7 +46,12 @@ latest HEAD commit of `maint` or `master` based on the following cases:
 * If you are fixing bugs in the released version, use `maint` as the
   starting point (which may mean you have to fix things without using
   new API features on the cutting edge that recently appeared in
-  `master` but were not available in the released version).
+  `master` but were not available in the released version). If the bug
+  exists in an older version (e.g., commit `X` introduced the bug, and
+  `git describe --containx X` says `v2.30.0-rc2-gXXXXXX` has it), then
+  use the tip of the maintenance branch for the 2.30.x versions in the
+  `maint-2.30` branch in https://github.com/gitster/git[the maintainer's
+  repo].
 
 * Otherwise (such as if you are adding new features) use `master`.
 
-- 
2.41.0-450-ga80be15292

