From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] docs/api-config: describe git_config_with_options
Date: Fri, 17 Feb 2012 03:18:45 -0500
Message-ID: <20120217081845.GB11418@sigill.intra.peff.net>
References: <20120217032325.GB5738@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 17 12:38:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyM96-0006CP-9T
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 12:38:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544Ab2BQLia (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Feb 2012 06:38:30 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41021
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751487Ab2BQLi1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2012 06:38:27 -0500
Received: (qmail 6401 invoked by uid 107); 17 Feb 2012 08:26:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 17 Feb 2012 03:26:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Feb 2012 03:18:45 -0500
Content-Disposition: inline
In-Reply-To: <20120217032325.GB5738@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190951>

This function was added recently but not documented.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/technical/api-config.txt |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/technical/api-config.txt b/Documentation/technical/api-config.txt
index 67984da..3dbf9fd 100644
--- a/Documentation/technical/api-config.txt
+++ b/Documentation/technical/api-config.txt
@@ -47,6 +47,22 @@ will first feed the user-wide one to the callback, and then the
 repo-specific one; by overwriting, the higher-priority repo-specific
 value is left at the end).
 
+The `git_config_with_options` function lets the caller examine config
+while adjusting some of the default behavior of `git_config`. It should
+almost never be used by "regular" git code that is looking up
+configuration variables. It is intended for advanced callers like
+`git-config`, which are intentionally tweaking the normal config-lookup
+process. It takes two options:
+
+`filename`::
+If this parameter is non-NULL, it specifies the name of a file to
+parse for configuration, rather than looking in the usual files. Regular
+`git_config` defaults to `NULL`.
+
+`respect_includes`::
+Specify whether include directives should be followed in parsed files.
+Regular `git_config` defaults to `1`.
+
 There is a special version of `git_config` called `git_config_early`.
 This version takes an additional parameter to specify the repository
 config, instead of having it looked up via `git_path`. This is useful
-- 
1.7.9.9.gcf58
