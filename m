From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/9] sha1_name.c: clarify what "fake" is for in
 find_short_object_filename()
Date: Mon, 18 Jun 2012 15:05:31 -0700
Message-ID: <1340057139-8311-3-git-send-email-gitster@pobox.com>
References: <1340057139-8311-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 19 00:08:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sgk7s-00062U-6o
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 00:08:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753886Ab2FRWIp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jun 2012 18:08:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57334 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752132Ab2FRWFo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2012 18:05:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B7F197DE
	for <git@vger.kernel.org>; Mon, 18 Jun 2012 18:05:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=JIqK
	Fev0H1IZO5tNSLwbhy5I7jM=; b=r3DK4i2Cnclha2KGixjFjJL1zDuZ10AW0rkm
	/n2UvaWiev7L/G1W4t3VPUMbpmnMY5MHO5+QPNh4vtVUvFCfJNNeQGL9naU4EWMg
	ePAR30obzpWsKkakSaIg1zhj4gYz1K/84EYcBzD+WUUQsMO3e6CYgrE8jK2/oblF
	UqQ++rI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=i6Bn+4
	sVEB+iex9H9wBVbLGZi9xm65hzHV8CZvpj4ZpoT+3+erh7Ol7WLXVAge8LNmLmUZ
	Ey19pyN/gxGrhH0esaawenCEJwan7Xwn/qHw1oKPS7YBPszWzVg6pK8fJW1i3s93
	Jsb4csxMDj6NZeP5v7KGPX/8kxfEG53uYHbMg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8335697DD
	for <git@vger.kernel.org>; Mon, 18 Jun 2012 18:05:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 199D597DC for
 <git@vger.kernel.org>; Mon, 18 Jun 2012 18:05:44 -0400 (EDT)
X-Mailer: git-send-email 1.7.11
In-Reply-To: <1340057139-8311-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C00AAC46-B991-11E1-82AA-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200175>

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
1.7.11
