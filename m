Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEAAEB64D9
	for <git@archiver.kernel.org>; Fri,  7 Jul 2023 22:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjGGWVY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jul 2023 18:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjGGWVW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2023 18:21:22 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCE21BE1
        for <git@vger.kernel.org>; Fri,  7 Jul 2023 15:21:21 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3006029FD9;
        Fri,  7 Jul 2023 18:21:21 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=sasl; bh=1kyRReoilGny2/SaWUQzO6vU99EGEsC1ZgirM1oaDmc=; b=NRR5
        Nv93jidii6HTQsOskndti6tzRxrbFWwCqHbQ9Kt/2MSqDfPBV4iHj7ncyAxVfVWw
        p3FMXfggec4QnVpih0HXHCZE/3qgvEG5UBqzJumAJUKJQVkhydIXKtlW4iGWm0d8
        XO9Eb52c0mb8yuJUpuTZS4bVj5KCJkHluw+IEKA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 28DFD29FD8;
        Fri,  7 Jul 2023 18:21:21 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AEFDC29FD5;
        Fri,  7 Jul 2023 18:21:17 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 0/2] remove unused "base-offset" from tree-walk codepath
Date:   Fri,  7 Jul 2023 15:21:14 -0700
Message-ID: <20230707222116.4129415-1-gitster@pobox.com>
X-Mailer: git-send-email 2.41.0-318-g061c58647e
MIME-Version: 1.0
X-Pobox-Relay-ID: 97BC42A2-1D14-11EE-A810-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are a few bonus patches I came up with while working on the
"hmm, attr magic does not seem to work with pathspec patterns?"
topic to remove a parameter that is passed around without getting
any value other than 0 (hence nobody knows if the code is correct
when the parameter is set to non-zero).

It turned out that they do not interact with the main topic in any
way, so I made it into a separate and indenendent series.

Junio C Hamano (2):
  tree-walk: lose base_offset that is never used in
    tree_entry_interesting
  tree-walk: drop unused base_offset from do_match()

 builtin/grep.c |  2 +-
 list-objects.c |  2 +-
 tree-diff.c    |  2 +-
 tree-walk.c    | 36 ++++++++++++++++++------------------
 tree-walk.h    |  2 +-
 tree.c         |  2 +-
 6 files changed, 23 insertions(+), 23 deletions(-)

--=20
2.41.0-318-g061c58647e

