Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E435C433EF
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 00:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345075AbiCaALI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 20:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343702AbiCaALI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 20:11:08 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19371C13B
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 17:09:20 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 99F1817E189;
        Wed, 30 Mar 2022 20:09:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=M
        W9VK/55EZCZKYN5/Ve89trC6Hx9ALWmc6l8N8lB9ME=; b=t8mK83erMyx1lsw+l
        0GYUbGTloOGbyEgi1zmht0qanJn/9KoyFhauMB1LGCDwBJ+a9eDpqbfJaMXZ9JZc
        +hIy/Vq280lQ5Y4WGK1rJpaIiAZrczudxalnQrqzIOYxmZBvO7dEAIuewnnjtEYF
        bBGGr0jLqAM9Snbb4sG7vwqbpo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9132817E188;
        Wed, 30 Mar 2022 20:09:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DF06C17E187;
        Wed, 30 Mar 2022 20:09:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] CodingGuidelines: give deadline for "for (int i = 0; ..."
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Date:   Wed, 30 Mar 2022 17:09:16 -0700
Message-ID: <xmqqy20r3rv7.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CE8FE2F8-B086-11EC-AD9C-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We raised the weather balloon to see if we can allow the construct
in 44ba10d6 (revision: use C99 declaration of variable in for()
loop, 2021-11-14), which was shipped as a part of Git v2.35.
Document that fact in the coding guidelines, and more importantly,
give ourselves a deadline to revisit and update.

Let's declare that we will officially adopt the variable declaration
in the initializaiton part of "for ()" statement this winter, unless
we find that a platform we care about does not grok it.

A separate weather balloon for C99 as a whole was raised separately
in 7bc341e2 (git-compat-util: add a test balloon for C99 support,
2021-12-01).  Hopefully, as we find out that all C99 features are OK
on all platforms we care about, we can stop probing the features we
want one-by-one like this (it does not necessarily mean that we
would automatically start using any and all C99 language features,
though).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/CodingGuidelines | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 0e27b5395d..f0475c1770 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -217,7 +217,10 @@ For C programs:
    the first statement (i.e. -Wdeclaration-after-statement).
 
  - Declaring a variable in the for loop "for (int i = 0; i < 10; i++)"
-   is still not allowed in this codebase.
+   is still not allowed in this codebase.  We are in the process of
+   allowing it by waiting to see that 44ba10d6 (revision: use C99
+   declaration of variable in for() loop, 2021-11-14) does not get
+   complaints.  Let's revisit this around November 2022.
 
  - NULL pointers shall be written as NULL, not as 0.
 
-- 
2.35.1-898-ge9d02b9944

