Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B535C20958
	for <e@80x24.org>; Thu, 23 Mar 2017 13:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753440AbdCWNGN (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 09:06:13 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36455 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753174AbdCWNGL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 09:06:11 -0400
Received: by mail-wm0-f65.google.com with SMTP id x124so16492418wmf.3
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 06:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rTySXPoAE4JFQqMnzfgOwSDn1jLpZf405cxkoeJliKc=;
        b=OObStiq++sgp2vFjwyQ2IVztWd6z7cWipvsQ+PBPPbT8AY1yvSK90y2ftGLza6jqEP
         XomQoFBaeS5LCoV4l4gbFJMVQy7YpYkc+d7lTjHnZUwsn3++PJcKg3UOucgDt4qSDtO6
         sYMGpS0UqOIGNkROn/2doLhFtVbQi89IiSFkgYFppZ/RuX1fe4yyKIlhVblh3oruIEfb
         mYLOksyiS+RdoQwuHqwzubO3KZg3DggBVj9drUODHCmcyWSDJDrKt6bpWzh1BpqLzqsp
         J0zmvxa+9tIziLP41NhLxmeIvYsbx4dMd3HCH6RiAkdhSnaK5EuHF0vib/3TpSNsX/+k
         JWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rTySXPoAE4JFQqMnzfgOwSDn1jLpZf405cxkoeJliKc=;
        b=GM4FX+1wSsgdZ8y+nLGhXMJBisneHWlEcHJmjOXIinp5xMb1kF5VVBSMF6kO5OpQ/8
         pJIdDR1SrbNpHLbKLWu8gyvkhj6sbpk3iPiICs4G9xoC5HZpDzVtpcXVFXjj1VApjEpt
         Awg4WaynIpGQleCXroKToyfUkFgGwJV9cDr5rSoIxAmAxaZdPxvgU8xtos537bpvPV0t
         g4d19UbMO6dG6poXckn/I7azeWzenFOQcWTyip3TbZ77pcpoggUipcXBi3/992Cv/DRY
         EC96U0axy8t7rE6TZ+vbUxdn9jm32lWsIsw9ToWHo67dCuHTl98jnx1Ew2zfFpnhoUQE
         x2ZA==
X-Gm-Message-State: AFeK/H2hnfq5OoKoVg4EZaBafUdi1ZLg4XAXo9/ZDRSwQS8l04TaayE9VoCQi756D+ltYQ==
X-Received: by 10.28.156.140 with SMTP id f134mr2749716wme.40.1490274369991;
        Thu, 23 Mar 2017 06:06:09 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id h3sm5810071wrb.6.2017.03.23.06.06.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Mar 2017 06:06:08 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 02/16] tag doc: split up the --[no-]merged documentation
Date:   Thu, 23 Mar 2017 13:05:15 +0000
Message-Id: <20170323130529.11361-3-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170323130529.11361-1-avarab@gmail.com>
References: <20170323130529.11361-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Split up the --[no-]merged documentation into documentation that
documents each option independently. This is in line with how "branch"
and "for-each-ref" are documented, and makes subsequent changes to
discuss the limits & caveats of each option easier to read.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-tag.txt | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 33f18ea5fb..68b0ab2410 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -124,10 +124,13 @@ This option is only applicable when listing tags without annotation lines.
 	Only list tags which contain the specified commit (HEAD if not
 	specified).
 
---[no-]merged [<commit>]::
-	Only list tags whose tips are reachable, or not reachable
-	if `--no-merged` is used, from the specified commit (`HEAD`
-	if not specified).
+--merged [<commit>]::
+	Only list tags whose tips are reachable from the specified commit
+	(`HEAD` if not specified).
+
+--no-merged [<commit>]::
+	Only list tags whose tips are not reachable from the specified
+	commit (`HEAD` if not specified).
 
 --points-at <object>::
 	Only list tags of the given object.
-- 
2.11.0

