From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 05/18] sha1_name.c: clarify what "fake" is for in
 find_short_object_filename()
Date: Mon,  2 Jul 2012 15:33:56 -0700
Message-ID: <1341268449-27801-6-git-send-email-gitster@pobox.com>
References: <1341268449-27801-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 03 00:35:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SlpD0-0003YV-MH
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 00:35:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391Ab2GBWev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jul 2012 18:34:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39712 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756238Ab2GBWeW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2012 18:34:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 51AD79075
	for <git@vger.kernel.org>; Mon,  2 Jul 2012 18:34:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=bsx2
	yRM24gs7UvufMNNdxc9eyAY=; b=sf4pXiy8R5einR4+19jdUJKUnhKH/px/QMmt
	55FeloJt+4i9AD5gCYPRTGaoXYSI1vWeisvbtzXhAp6AI8MsW1kmFZ1stx+B79YX
	PPzMs4DpJ7zw/ADBBxAtOxAxy6Z1yA5dg7mLtII/2QyqajMbhz36tThkxJLRuJ51
	iv0A7gQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=TpBZKl
	HUWB8TTPJlXTCVnvMk996vOXafvGe5lYXcjLU8C+Q7OgqWTddBBZ+AArvfW9lWWj
	gBDKV2xOEIAUpecZCy053ZnCKyRqrVupRHDRnDUHkbAuJw5+AYAgAEn4ZddHzWeY
	/hWBCw0S5yMb3lkuqTZoC3Sbn8F74tZSsL6Xg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4760C9074
	for <git@vger.kernel.org>; Mon,  2 Jul 2012 18:34:22 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C1EDF9073 for
 <git@vger.kernel.org>; Mon,  2 Jul 2012 18:34:21 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.212.g52fe12e
In-Reply-To: <1341268449-27801-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 11A5A902-C496-11E1-8C53-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200871>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_name.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sha1_name.c b/sha1_name.c
index de41177..6eb3280 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -17,6 +17,13 @@ static int find_short_object_filename(int len, const char *name, unsigned char *
 	static struct alternate_object_database *fakeent;
 
 	if (!fakeent) {
+		/*
+		 * Create a "fake" alternate object database that
+		 * points to our own object database, to make it
+		 * easier to get a temporary working space in
+		 * alt->name/alt->base while iterating over the
+		 * object databases including our own.
+		 */
 		const char *objdir = get_object_directory();
 		int objdir_len = strlen(objdir);
 		int entlen = objdir_len + 43;
-- 
1.7.11.1.212.g52fe12e
