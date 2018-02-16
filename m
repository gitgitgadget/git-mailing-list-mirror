Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C5ED1F404
	for <e@80x24.org>; Fri, 16 Feb 2018 02:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423101AbeBPCqG (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 21:46:06 -0500
Received: from genki.is ([159.203.135.224]:55752 "EHLO genki.is"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423086AbeBPCqG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 21:46:06 -0500
Received: from localhost (c-73-47-239-165.hsd1.nh.comcast.net [73.47.239.165])
        by genki.is (Postfix) with ESMTPSA id 164574000E;
        Fri, 16 Feb 2018 02:46:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 genki.is 164574000E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genki.is;
        s=genkimail; t=1518749165;
        bh=MDynMyc2KEG6rjoN/KFYi/DrI+7m4F4VYqWFfLT3gtY=;
        h=Date:From:Subject:To:Cc:From;
        b=Z5zNF94sUB8NZZ+iEKn+5pQwozIZC3GKlv66rERHw7cLqDUKa2VjmcYNRXokz3ZTZ
         Jr+mxF0D+ooz59htS+RCL2NVuS6kZ9mJLQHouWaWr0aJxTMe58eceB+HZpXRvRGHOv
         vL/NgJeLb+1yJ7u+tzz9a/+XmO6CPGEHytK9FeuA=
Date:   Thu, 15 Feb 2018 21:46:04 -0500
Message-Id: <6f102a37a06940f6feeeb0c8807ac98a850b7a3b.1518748907.git.sky@genki.is>
From:   Genki Sky <sky@genki.is>
Subject: [PATCH] test-lib.sh: unset XDG_CACHE_HOME
To:     git@vger.kernel.org
Cc:     sky@genki.is, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git respects XDG_CACHE_HOME for the credential cache. So, we should
unset XDG_CACHE_HOME for the test environment, lest a user's custom one
cause failure in the test.

For example, t/t0301-credential-cache.sh expects a default directory
to be used if it hasn't explicitly set XDG_CACHE_HOME.

Signed-off-by: Genki Sky <sky@genki.is>
---

Notes:

  This is the XDG_CACHE_HOME version of 5adf84ebb ("test-lib.sh: unset
  XDG_CONFIG_HOME", 2012-07-24).

 t/test-lib.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 9af19055b..001ef6b64 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -116,6 +116,7 @@ unset VISUAL EMAIL LANGUAGE COLUMNS $("$PERL_PATH" -e '
 	my @vars = grep(/^GIT_/ && !/^GIT_($ok)/o, @env);
 	print join("\n", @vars);
 ')
+unset XDG_CACHE_HOME
 unset XDG_CONFIG_HOME
 unset GITPERLLIB
 GIT_AUTHOR_EMAIL=author@example.com
--
2.16.1.195.g373da842b

