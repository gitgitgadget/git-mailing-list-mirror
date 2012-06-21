From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/9] sha1_name.c: clarify what "fake" is for in
 find_short_object_filename()
Date: Wed, 20 Jun 2012 23:35:25 -0700
Message-ID: <1340260532-11378-3-git-send-email-gitster@pobox.com>
References: <1340260532-11378-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 21 08:36:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Shazk-0006l5-KP
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jun 2012 08:35:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755402Ab2FUGfl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jun 2012 02:35:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43863 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753225Ab2FUGfi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2012 02:35:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 991988B18
	for <git@vger.kernel.org>; Thu, 21 Jun 2012 02:35:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=I2tJ
	6pz7QSU76ZTMAeBEaGQVATo=; b=CQUnfXbDNxLbVkQuewsDfSRD6/ZnGsG//Wcf
	FHXnSGfiCIYts4mYNJmz+T2/87dFc9P5blhMJCfMmGfidfJZNhdxeJpduGIpblrC
	0uCoADnE92USB0KWwBJAd+ZvEHGJSNkG2x8kxyQNDLOeMpU3muULvPbPQIAq6k4o
	AoZd4pg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=BlcsZk
	EJGxA2sLfu4vr0/EB9E6VdPwZFwuN8TnWywa/G7G9x8cRbtYcZt23ACal+AvjYCx
	xce/DUcB4AdI2RsGUIX63VqzC1oq+ssMqSY+6kusNiRE6rKiIE0Srq4IvNBU7Xew
	uzFNtrKHqutKJohEkI0YiS39N97poMnyK1f3g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 905958B17
	for <git@vger.kernel.org>; Thu, 21 Jun 2012 02:35:37 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 283778B15 for
 <git@vger.kernel.org>; Thu, 21 Jun 2012 02:35:37 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.2.gd284367
In-Reply-To: <1340260532-11378-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 4FC0C7F0-BB6B-11E1-B2C5-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200389>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_name.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sha1_name.c b/sha1_name.c
index 5b0c845..4cbca34 100644
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
1.7.11.2.gd284367
