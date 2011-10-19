From: mhagger@alum.mit.edu
Subject: [RFC 12/13] resolve_ref: use check_refname_format(..., REFNAME_FULL)
Date: Wed, 19 Oct 2011 22:55:15 +0200
Message-ID: <1319057716-28094-13-git-send-email-mhagger@alum.mit.edu>
References: <1319057716-28094-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 19 23:00:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGdFP-0005o7-Ot
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 23:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754060Ab1JSVAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 17:00:08 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:32783 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753892Ab1JSVAF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 17:00:05 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RGd4f-000423-3a; Wed, 19 Oct 2011 22:49:17 +0200
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319057716-28094-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183961>

From: Michael Haggerty <mhagger@alum.mit.edu>

...instead of own inline code.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index a40dfa5..67df3a6 100644
--- a/refs.c
+++ b/refs.c
@@ -548,8 +548,7 @@ const char *resolve_ref(const char *ref, unsigned char *sha1, int reading, int *
 			if (len < 0)
 				return NULL;
 			buffer[len] = 0;
-			if (!prefixcmp(buffer, "refs/") &&
-					!check_refname_format(buffer, 0)) {
+			if (!check_refname_format(buffer, REFNAME_FULL)) {
 				strcpy(ref_buffer, buffer);
 				ref = ref_buffer;
 				if (flag)
-- 
1.7.7
