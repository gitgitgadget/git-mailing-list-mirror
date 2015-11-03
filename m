From: Lukas Fleischer <lfleischer@lfos.de>
Subject: [PATCH v2 1/4] Document the semantics of hideRefs with namespaces
Date: Tue,  3 Nov 2015 08:58:14 +0100
Message-ID: <1446537497-13921-2-git-send-email-lfleischer@lfos.de>
References: <1446537497-13921-1-git-send-email-lfleischer@lfos.de>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 03 09:13:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtWiz-000157-To
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 09:13:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633AbbKCH6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 02:58:25 -0500
Received: from elnino.cryptocrack.de ([46.165.227.75]:44899 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112AbbKCH6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 02:58:24 -0500
Received: by elnino.cryptocrack.de (OpenSMTPD) with ESMTPSA id a684bcb9;
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	Tue, 3 Nov 2015 08:58:19 +0100 (CET)
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1446537497-13921-1-git-send-email-lfleischer@lfos.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280783>

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
