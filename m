Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE194C48BE8
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 16:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0A2F6191D
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 16:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhFOQrd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 12:47:33 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60079 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbhFOQrc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 12:47:32 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D820312AA5A;
        Tue, 15 Jun 2021 12:45:27 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=sasl; bh=cZWkcKwfQsGSgONt8cGP1kG5HqVRGJd1JPtoEs/UwXw=; b=AmVf
        2YoaxryjjzCXcdftBXFnKQeb/syAbxycD3418K9Ea0DL2HSd+QNpIcFMSAYcXj9k
        c5bK2WAChzA6twbiv2aKkFX1E6H4vq9uf1kjwOnTjxvUUZr46B3XfuO9zox/0oiC
        8Q+nxx+K3UKvaId8DNsV/xSLyEaBXkXjX/j3xSQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BFC5012AA59;
        Tue, 15 Jun 2021 12:45:27 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7597A12AA57;
        Tue, 15 Jun 2021 12:45:24 -0400 (EDT)
        (envelope-from tmz@pobox.com)
From:   Todd Zullinger <tmz@pobox.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] doc: builtin add -i is enabled by feature.experimental
Date:   Tue, 15 Jun 2021 12:45:22 -0400
Message-Id: <20210615164522.1079951-1-tmz@pobox.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Pobox-Relay-ID: 14FE1B54-CDF9-11EB-8C26-D5C30F5B5667-09356542!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Note that add.interactive.useBuiltin is enabled by feature.experimental.
It was added in 2df2d81ddd (add -i: use the built-in version when
feature.experimental is set, 2020-09-08).

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
I was checking my configuration to see if I still needed to have
add.interactive.useBuiltin set and noticed that it wasn't listed in the
settings enabled by feature.experimental.

Unless it's time to take this out of the experimental phase, it seems wor=
th
documenting -- if for no other reason than to keep fetch.negotiationAlgor=
ithm
from being lonely in the feature.experimental section. ;)

FWIW, I've had this enabled for perhaps a year or so and I don't recall a=
ny
instances where it hasn't worked well.  It has come in handy on some syst=
ems
where I can't easily install Perl but don't want to give up `add -[ip]`.
Thanks Dscho!

 Documentation/config/add.txt     | 3 ++-
 Documentation/config/feature.txt | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/add.txt b/Documentation/config/add.txt
index c9f748f81c..7d6d325571 100644
--- a/Documentation/config/add.txt
+++ b/Documentation/config/add.txt
@@ -9,4 +9,5 @@ add.ignore-errors (deprecated)::
 add.interactive.useBuiltin::
 	[EXPERIMENTAL] Set to `true` to use the experimental built-in
 	implementation of the interactive version of linkgit:git-add[1]
-	instead of the Perl script version. Is `false` by default.
+	instead of the Perl script version.  If `feature.experimental` is
+	enabled, this setting is `true`.  By default, it is `false`.
diff --git a/Documentation/config/feature.txt b/Documentation/config/feat=
ure.txt
index cdecd04e5b..caaa97dc61 100644
--- a/Documentation/config/feature.txt
+++ b/Documentation/config/feature.txt
@@ -12,6 +12,10 @@ feature.experimental::
 	setting if you are interested in providing feedback on experimental
 	features. The new default values are:
 +
+* `add.interactive.useBuiltin=3Dtrue` which enables the built-in impleme=
ntation
+of the interactive version of linkgit:git-add[1] instead of the Perl scr=
ipt
+version.
++
 * `fetch.negotiationAlgorithm=3Dskipping` may improve fetch negotiation =
times by
 skipping more commits at a time, reducing the number of round trips.
=20
 feature.manyFiles::
 	Enable config options that optimize for repos with many files in the
--=20
2.32.0

