Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B358C2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 17:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC26F206D5
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 17:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gpG3pRSW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kyleam.com header.i=@kyleam.com header.b="bHocRRuk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgAaRIw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 12:08:52 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54276 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbgAaRIw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 12:08:52 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EB759B24E8;
        Fri, 31 Jan 2020 12:08:49 -0500 (EST)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=sasl; bh=MULW/792z53UaNw6GM7qUbQ2iNk=; b=gpG3pRSWkGeJK2q9CxPX
        J8PPkYSg3Xlv0YXgv+7oWniD+MOD7rBHp7sk0EEQ9VmHuS+CzkIL+ADCuYA5wT2S
        AbPcP9VgbiId0VO6+KsqMRgVISi80Jc/c4OCHMPdS1IZX1iNsHQHCAPvlxAMExhV
        FiQCcbWenJ+K0wakppyHaI8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E39D0B24E7;
        Fri, 31 Jan 2020 12:08:49 -0500 (EST)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:date:message-id:mime-version:content-transfer-encoding;
 s=mesmtp; bh=ieKPT2mCp4l9DWRcC2n7/d7Nq9vEhL5kJFQmPOXmSfg=;
 b=bHocRRukqplROrpIUShzS6XozirF/SiS2dX7KRG24CjpJuFD69SNvtVgqFoYVsgkUoeZ3h9XlbqN+8cy5v734U4a8JhGjymZCnJa0QLoHT3mvyEmFxOfRz2QxPWJ2wAuDmMRIBVXF7I3w9NOku6diLQQcXh+C/jR2Qy3scPxMig=
Received: from localhost (unknown [45.33.91.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 53816B24DF;
        Fri, 31 Jan 2020 12:08:47 -0500 (EST)
        (envelope-from kyle@kyleam.com)
From:   Kyle Meyer <kyle@kyleam.com>
To:     git@vger.kernel.org
Cc:     Kyle Meyer <kyle@kyleam.com>
Subject: [PATCH] submodule foreach: replace $path with $sm_path in example
Date:   Fri, 31 Jan 2020 12:08:43 -0500
Message-Id: <20200131170843.11130-1-kyle@kyleam.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
X-Pobox-Relay-ID: 580AECA2-444C-11EA-93AA-8D86F504CC47-24757444!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

f0fd0dc5c5 (submodule foreach: document '$sm_path' instead of '$path',
2018-05-08) updated the documentation to advise callers to favor
$sm_path over the deprecated synonym $path.  However, the example in
that section still uses $path.  Update it to use $sm_path.

Signed-off-by: Kyle Meyer <kyle@kyleam.com>
---
 Documentation/git-submodule.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodul=
e.txt
index 5232407f68..218942acd1 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -229,7 +229,7 @@ As an example, the command below will show the path a=
nd currently
 checked out commit for each submodule:
 +
 --------------
-git submodule foreach 'echo $path `git rev-parse HEAD`'
+git submodule foreach 'echo $sm_path `git rev-parse HEAD`'
 --------------
=20
 sync [--recursive] [--] [<path>...]::
--=20
2.25.0

