From: mhagger@alum.mit.edu
Subject: [RFC 05/13] receive-pack::update(): use check_refname_format(..., REFNAME_FULL)
Date: Wed, 19 Oct 2011 22:55:08 +0200
Message-ID: <1319057716-28094-6-git-send-email-mhagger@alum.mit.edu>
References: <1319057716-28094-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 19 22:55:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGdAn-0003UG-J4
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 22:55:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753926Ab1JSUz2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 16:55:28 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:60899 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753867Ab1JSUzY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 16:55:24 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RGd4e-000423-NN; Wed, 19 Oct 2011 22:49:16 +0200
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319057716-28094-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183949>

From: Michael Haggerty <mhagger@alum.mit.edu>

Replace local code with a use of check_refname_format()'s new
REFNAME_FULL option.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/receive-pack.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 261b610..508451b 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -401,7 +401,7 @@ static const char *update(struct command *cmd)
 	struct ref_lock *lock;
 
 	/* only refs/... are allowed */
-	if (prefixcmp(name, "refs/") || check_refname_format(name + 5, 0)) {
+	if (check_refname_format(name, REFNAME_FULL)) {
 		rp_error("refusing to create funny ref '%s' remotely", name);
 		return "funny refname";
 	}
-- 
1.7.7
