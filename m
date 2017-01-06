Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 303491FEB3
	for <e@80x24.org>; Fri,  6 Jan 2017 16:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967291AbdAFQXL (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 11:23:11 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:48251 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S966898AbdAFQXI (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 6 Jan 2017 11:23:08 -0500
X-AuditID: 12074414-78bff70000004a85-a1-586fc46135e3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 1F.DF.19077.164CF685; Fri,  6 Jan 2017 11:22:57 -0500 (EST)
Received: from bagpipes.fritz.box (p57906F4E.dip0.t-ipconnect.de [87.144.111.78])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v06GMmWr023262
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 6 Jan 2017 11:22:55 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        David Turner <novalis@novalis.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 03/23] t5505: use "for-each-ref" to test for the non-existence of references
Date:   Fri,  6 Jan 2017 17:22:23 +0100
Message-Id: <5744cbeeb6374fdb1f11a5eb9825a68034779a24.1483719289.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1483719289.git.mhagger@alum.mit.edu>
References: <cover.1483719289.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsUixO6iqJt4JD/CYEentkXXlW4mi4beK8wW
        uxf3M1vcXjGf2WLJw9fMFj9aepgtOqfKOrB7/H3/gclj56y77B7Ll65j9OhqP8Lm8ax3D6PH
        xUvKHp83yQWwR3HZpKTmZJalFunbJXBlXDhzmrlgLntF38fnTA2MLWxdjJwcEgImEqu7zjN2
        MXJxCAlcZpRY0HWdHcI5wSQx+ckNZpAqNgFdiUU9zUwgtoiAmsTEtkMsIEXMAh8YJX51zmIH
        SQgLxEv07ehhAbFZBFQlPty9ARbnFYiSeHt4P9Q6OYlL276ADeUUsJBo3PWNEcQWEjCX+DTx
        MPMERp4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3Qt9HIzS/RSU0o3MUJCTGQH45GTcocY
        BTgYlXh4I7zyIoRYE8uKK3MPMUpyMCmJ8oY55kcI8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuG1
        OwSU401JrKxKLcqHSUlzsCiJ835brO4nJJCeWJKanZpakFoEk5Xh4FCS4G08DNQoWJSanlqR
        lplTgpBm4uAEGc4DNLwDpIa3uCAxtzgzHSJ/ilGX48D7FU+ZhFjy8vNSpcR5t4BcIABSlFGa
        BzcHlhpeMYoDvSXM2wMyigeYVuAmvQJawgS0RNATbElJIkJKqoGx/2yvtW3xjYqPfIvkbbUU
        V4i+iE8Xec815Y2ZXfPd1Y+tEgrYXx2RZ60NmvP+Hc+bkKzOy8oarC2GLjsc3bnM26MeGsdO
        0hO1nf5VaFpU7ybDF7N4vD6E+X6KchHYmW6utcswx79RmGNfwv+M2cmb1M9WPnOUvnQ3v0ZU
        eealp08KmXY1XVRiKc5INNRiLipOBACo9CCb6AIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of looking on the filesystem inside ".git/refs/remotes/origin",
use "git for-each-ref" to check for leftover references under the
remote's old name.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t5505-remote.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 8198d8e..65030fb 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -725,7 +725,7 @@ test_expect_success 'rename a remote' '
 	(
 		cd four &&
 		git remote rename origin upstream &&
-		rmdir .git/refs/remotes/origin &&
+		test -z "$(git for-each-ref refs/remotes/origin)" &&
 		test "$(git symbolic-ref refs/remotes/upstream/HEAD)" = "refs/remotes/upstream/master" &&
 		test "$(git rev-parse upstream/master)" = "$(git rev-parse master)" &&
 		test "$(git config remote.upstream.fetch)" = "+refs/heads/*:refs/remotes/upstream/*" &&
-- 
2.9.3

