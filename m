Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B206C34031
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 21:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FE182173E
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 21:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgBRVZi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 16:25:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:47296 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726339AbgBRVZi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 16:25:38 -0500
Received: (qmail 20435 invoked by uid 109); 18 Feb 2020 21:25:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 18 Feb 2020 21:25:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22696 invoked by uid 111); 18 Feb 2020 21:34:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Feb 2020 16:34:38 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 Feb 2020 16:25:37 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Drew DeVault <sir@cmpwn.com>
Subject: [PATCH] doc/config/push: use longer "--" line for preformatted
 example
Message-ID: <20200218212537.GA33327@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The example for the push.pushOption config tries to create a
preformatted section, but uses only two dashes in its "--" line. In
AsciiDoc this is an "open block", with no type; the lines end up jumbled
because they're formatted as paragraphs. We need four or more dashes to
make it a "listing block" that will respect the linebreaks.

Signed-off-by: Jeff King <peff@peff.net>
---
I noticed this as part our other discussion. The rendered output of
"./doc-diff HEAD^ HEAD" is:

  @@ -4143,15 +4143,20 @@ CONFIGURATION FILE
              repository) to clear the values inherited from a lower priority
              configuration files (e.g.  $HOME/.gitconfig).
   
  -           Example:
  +               Example:
   
  -           /etc/gitconfig push.pushoption = a push.pushoption = b
  +               /etc/gitconfig
  +                 push.pushoption = a
  +                 push.pushoption = b
   
  -           ~/.gitconfig push.pushoption = c
  +               ~/.gitconfig
  +                 push.pushoption = c
   
  -           repo/.git/config push.pushoption = push.pushoption = b
  +               repo/.git/config
  +                 push.pushoption =
  +                 push.pushoption = b
   
  -           This will result in only b (a and c are cleared).
  +               This will result in only b (a and c are cleared).
   
          push.recurseSubmodules
              Make sure all submodule commits used by the revisions to be pushed

 Documentation/config/push.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/push.txt b/Documentation/config/push.txt
index 54871f8213..0a7aa322a9 100644
--- a/Documentation/config/push.txt
+++ b/Documentation/config/push.txt
@@ -80,7 +80,7 @@ higher priority configuration file (e.g. `.git/config` in a
 repository) to clear the values inherited from a lower priority
 configuration files (e.g. `$HOME/.gitconfig`).
 +
---
+----
 
 Example:
 
@@ -97,7 +97,7 @@ repo/.git/config
 
 This will result in only b (a and c are cleared).
 
---
+----
 
 push.recurseSubmodules::
 	Make sure all submodule commits used by the revisions to be pushed
-- 
2.25.1.795.g3fd338b409
