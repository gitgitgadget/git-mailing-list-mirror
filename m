Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8F8E1F424
	for <e@80x24.org>; Wed,  9 May 2018 13:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935043AbeEINQm (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 09:16:42 -0400
Received: from ao2.it ([92.243.12.208]:37147 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934594AbeEINQj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 09:16:39 -0400
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1fGOxM-0004uX-LR; Wed, 09 May 2018 15:16:32 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1fGOxP-0005Ev-Q7; Wed, 09 May 2018 15:16:35 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, Antonio Ospite <ao2@ao2.it>
Subject: [PATCH] doc: fix config API documentation about config_with_options
Date:   Wed,  9 May 2018 15:16:28 +0200
Message-Id: <20180509131628.20099-1-ao2@ao2.it>
X-Mailer: git-send-email 2.17.0
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In commit dc8441fdb ("config: don't implicitly use gitdir or commondir",
2017-06-14) the function git_config_with_options was renamed to
config_with_options to better reflect the fact that it does not access
the git global config or the repo config by default.

However Documentation/technical/api-config.txt still refers to the
previous name, fix that.

While at it also update the documentation about the extra parameters,
because they too changed since the initial definition.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---

Patch based on the maint branch.

Ciao,
   Antonio

 Documentation/technical/api-config.txt | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/Documentation/technical/api-config.txt b/Documentation/technical/api-config.txt
index 9a778b0ca..fa39ac9d7 100644
--- a/Documentation/technical/api-config.txt
+++ b/Documentation/technical/api-config.txt
@@ -47,21 +47,23 @@ will first feed the user-wide one to the callback, and then the
 repo-specific one; by overwriting, the higher-priority repo-specific
 value is left at the end).
 
-The `git_config_with_options` function lets the caller examine config
+The `config_with_options` function lets the caller examine config
 while adjusting some of the default behavior of `git_config`. It should
 almost never be used by "regular" Git code that is looking up
 configuration variables. It is intended for advanced callers like
 `git-config`, which are intentionally tweaking the normal config-lookup
 process. It takes two extra parameters:
 
-`filename`::
-If this parameter is non-NULL, it specifies the name of a file to
-parse for configuration, rather than looking in the usual files. Regular
-`git_config` defaults to `NULL`.
+`config_source`::
+If this parameter is non-NULL, it specifies the source to parse for
+configuration, rather than looking in the usual files. See `struct
+git_config_source` in `config.h` for details. Regular `git_config` defaults
+to `NULL`.
 
-`respect_includes`::
-Specify whether include directives should be followed in parsed files.
-Regular `git_config` defaults to `1`.
+`opts`::
+Specify options to adjust the behavior of parsing config files. See `struct
+config_options` in `config.h` for details. As an example: regular `git_config`
+sets `opts.respect_includes` to `1` by default.
 
 Reading Specific Files
 ----------------------
-- 
2.17.0

