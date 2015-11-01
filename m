From: Lukas Fleischer <lfleischer@lfos.de>
Subject: [PATCH 1/4] Document the semantics of hideRefs with namespaces
Date: Sun,  1 Nov 2015 20:34:20 +0100
Message-ID: <1446406463-22527-2-git-send-email-lfleischer@lfos.de>
References: <1446406463-22527-1-git-send-email-lfleischer@lfos.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 01 20:34:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsyOl-0000LI-3E
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 20:34:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752814AbbKATee (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2015 14:34:34 -0500
Received: from elnino.cryptocrack.de ([46.165.227.75]:8371 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123AbbKATec (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 14:34:32 -0500
Received: by elnino.cryptocrack.de (OpenSMTPD) with ESMTPSA id d901d5b3;
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	for <git@vger.kernel.org>;
	Sun, 1 Nov 2015 20:34:30 +0100 (CET)
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1446406463-22527-1-git-send-email-lfleischer@lfos.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280658>

Right now, there is no clear definition of how transfer.hideRefs should
behave when a namespace is set. Explain that hideRefs prefixes match
stripped names in that case. This is how hideRefs patterns are currently
handled in receive-pack.

Signed-off-by: Lukas Fleischer <lfleischer@lfos.de>
---
 Documentation/config.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1204072..3da97a1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2684,6 +2684,13 @@ You may also include a `!` in front of the ref name to negate the entry,
 explicitly exposing it, even if an earlier entry marked it as hidden.
 If you have multiple hideRefs values, later entries override earlier ones
 (and entries in more-specific config files override less-specific ones).
++
+If a namespace is set, references are stripped before matching. For example, if
+the prefix `refs/heads/master` is specified in `transfer.hideRefs` and the
+current namespace is `foo`, then `refs/namespaces/foo/refs/heads/master` is
+omitted from the advertisements but `refs/heads/master` and
+`refs/namespaces/bar/refs/heads/master` are still advertised as so-called
+"have" lines.
 
 transfer.unpackLimit::
 	When `fetch.unpackLimit` or `receive.unpackLimit` are
-- 
2.6.2
