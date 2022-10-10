Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0BEC433FE
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 20:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiJJUi2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 16:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiJJUiM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 16:38:12 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC0D1FE
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 13:38:11 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A078215E3D5;
        Mon, 10 Oct 2022 16:38:10 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=kyg7o9ekyunt
        7pnx69oJaubCNVMDblsjog6zYpJM+08=; b=xd2B3zNN/QrBMk4ewdCH4Ot5tNGF
        4MglWlXN9foH5Pdek/gRwSxVpH0A13FDvX38+pECKK/2stf4wUwZRSQjeu3tLnvJ
        0wKLzn6Ve+XgxSkVclrBXmz0U5+wZxyUd+VJON2Jf1AdGQpue9UOZ6Jtug3LmrKX
        W+SdMcnfvhy5FiI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 98AEB15E3D4;
        Mon, 10 Oct 2022 16:38:10 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E83EE15E3D3;
        Mon, 10 Oct 2022 16:38:09 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/5] CodingGuidelines: allow declaring variables in for loops
Date:   Mon, 10 Oct 2022 13:37:58 -0700
Message-Id: <20221010203800.2154698-4-gitster@pobox.com>
X-Mailer: git-send-email 2.38.0-140-gc6454a6c7f
In-Reply-To: <20221010203800.2154698-1-gitster@pobox.com>
References: <cover-0.5-00000000000-20221007T092505Z-avarab@gmail.com>
 <20221010203800.2154698-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Pobox-Relay-ID: 74026368-48DB-11ED-A041-307A8E0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

Since 44ba10d6712 (revision: use C99 declaration of variable in for()
loop, 2021-11-14) released with v2.35.0 we've had a variable declared
with in a for loop.

Since then we've had inadvertent follow-ups to that with at least
cb2607759e2 (merge-ort: store more specific conflict information,
2022-06-18) released with v2.38.0.

As November 2022 is within the window of this upcoming release,
let's update the guideline to allow this.  We can have the promised
"revisit" discussion while this patch cooks, and drop it if it turns
out that it is still premature, which is not expected to happen at
this moment.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/CodingGuidelines | 10 ++--------
 revision.c                     |  7 -------
 2 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuideli=
nes
index 8afda28cfc..f9affc4050 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -232,18 +232,12 @@ For C programs:
    . since early 2021 with 765dc168882, we have been using variadic
      macros, mostly for printf-like trace and debug macros.
=20
-   These used to be forbidden, but we have not heard any breakage
-   report, and they are assumed to be safe.
+   . since late 2021 with 44ba10d6, we have had variables declared in
+     the for loop "for (int i =3D 0; i < 10; i++)".
=20
  - Variables have to be declared at the beginning of the block, before
    the first statement (i.e. -Wdeclaration-after-statement).
=20
- - Declaring a variable in the for loop "for (int i =3D 0; i < 10; i++)"
-   is still not allowed in this codebase.  We are in the process of
-   allowing it by waiting to see that 44ba10d6 (revision: use C99
-   declaration of variable in for() loop, 2021-11-14) does not get
-   complaints.  Let's revisit this around November 2022.
-
  - NULL pointers shall be written as NULL, not as 0.
=20
  - When declaring pointers, the star sides with the variable
diff --git a/revision.c b/revision.c
index 36e31942ce..8f2623b3b5 100644
--- a/revision.c
+++ b/revision.c
@@ -47,13 +47,6 @@ static inline int want_ancestry(const struct rev_info =
*revs);
 void show_object_with_name(FILE *out, struct object *obj, const char *na=
me)
 {
 	fprintf(out, "%s ", oid_to_hex(&obj->oid));
-	/*
-	 * This "for (const char *p =3D ..." is made as a first step towards
-	 * making use of such declarations elsewhere in our codebase.  If
-	 * it causes compilation problems on your platform, please report
-	 * it to the Git mailing list at git@vger.kernel.org. In the meantime,
-	 * adding -std=3Dgnu99 to CFLAGS may help if you are with older GCC.
-	 */
 	for (const char *p =3D name; *p && *p !=3D '\n'; p++)
 		fputc(*p, out);
 	fputc('\n', out);
--=20
2.38.0-167-gf9a88ca9e9

