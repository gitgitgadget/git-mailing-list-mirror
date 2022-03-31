Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47B0C433F5
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 22:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242404AbiCaWnL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 18:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbiCaWnK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 18:43:10 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9B72156E4
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 15:41:21 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7EF58126814;
        Thu, 31 Mar 2022 18:41:20 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=KaqhtwE+804U4nWWEtoJm00tG
        kYheuLEE0KhF35lRkg=; b=ZKeZ9ZirGPT59wCuARsStOgj97HQNKPxlF4VQL5BF
        jnldlmfuvtRZklWbtY3RCWKZjWqsWGbjWGEjlBzAfRijOuWDuYm5ZOYcYmnGDom9
        ANKR4iDoAPqk1EH8zlc7TmHHrxaYT450PUBsyg2AGD7AV8tdhu3jRVdkwX9wfL3u
        hk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 72343126813;
        Thu, 31 Mar 2022 18:41:20 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D5AC5126812;
        Thu, 31 Mar 2022 18:41:19 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>
Subject: [PATCH 1/2] branch: rework comments for future developers
Date:   Thu, 31 Mar 2022 15:41:17 -0700
Message-Id: <20220331224118.3014407-1-gitster@pobox.com>
X-Mailer: git-send-email 2.35.1-917-g7c4048624a
In-Reply-To: <xmqq7d89zqys.fsf@gitster.g>
References: <xmqq7d89zqys.fsf@gitster.g>
MIME-Version: 1.0
X-Pobox-Relay-ID: AF050F68-B143-11EC-A806-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

For two cases in which we do not explicitly pass --track=3D<choice>
option down to the submodule--helper subprocess, we have comments
that say "we do not have to pass --track", but in fact we not just
do not have to, but it would be incorrect to pass any --track option
to the subprocess (instead, the correct behaviour is to let the
subprocess figure out what is the appropriate tracking mode to use).

Signed-off-by: Glen Choo <chooglen@google.com>
---
 branch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/branch.c b/branch.c
index ed6f993aa6..8ee9f43539 100644
--- a/branch.c
+++ b/branch.c
@@ -549,9 +549,9 @@ static int submodule_create_branch(struct repository =
*r,
 		strvec_push(&child.args, "--track=3Dinherit");
 		break;
 	case BRANCH_TRACK_UNSPECIFIED:
-		/* Default for "git checkout". No need to pass --track. */
+		/* Default for "git checkout". Do not pass --track. */
 	case BRANCH_TRACK_REMOTE:
-		/* Default for "git branch". No need to pass --track. */
+		/* Default for "git branch". Do not pass --track. */
 		break;
 	}
=20
--=20
2.35.1-917-g7c4048624a

