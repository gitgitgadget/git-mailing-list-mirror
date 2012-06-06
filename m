From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/6] dir.c: make excluded() file scope static
Date: Tue,  5 Jun 2012 22:45:19 -0700
Message-ID: <1338961519-30970-7-git-send-email-gitster@pobox.com>
References: <1338961519-30970-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 06 07:46:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sc94O-0002JF-Pv
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 07:46:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753935Ab2FFFpt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jun 2012 01:45:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45664 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754030Ab2FFFpc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2012 01:45:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 642EA6015
	for <git@vger.kernel.org>; Wed,  6 Jun 2012 01:45:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=0pko
	XWE7f6CrOkmIpDWpI7NWEp0=; b=eXgnHrpFrI5yK2xCZrH6prhkro/wP7j0q7rF
	OWD15Knd6lk8vYdi3kt9KD/P/ATv/DDnhoSLEOmTdjbnpVkf0fv56MdxxkX7oaJI
	8xau2xLXkdeaGLvyy3f8KVbLZs6pS6vAe6BnfkeVqZpzUvOFbYkn7RdcDnKndrq6
	DD7L1TA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=KTt15L
	E2Xf1qrUvrI8Wh+l/BoJnmOhYcnU+OXvnmg+xx7oJRTvHXJ3ZHPbuZLH6v0OaCy1
	rzK8zyzuJt55g6HwSBfBhdysClD5sNfN1+X8UpA7inGqFZn0VpriEAwQ42xxlXgH
	UF7DQNlS3wEIFIFAxE+ThFiVl0+UZpVIGKcJo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B56B6011
	for <git@vger.kernel.org>; Wed,  6 Jun 2012 01:45:32 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DE4CE600B for
 <git@vger.kernel.org>; Wed,  6 Jun 2012 01:45:31 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.rc1.37.g09843ac
In-Reply-To: <1338961519-30970-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D448E48A-AF9A-11E1-8F0F-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199305>

Now there no longer is external callers of this interface, so we can
make it static.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 dir.c | 2 +-
 dir.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index 7ab7fc5..79e4337 100644
--- a/dir.c
+++ b/dir.c
@@ -560,7 +560,7 @@ int excluded_from_list(const char *pathname,
 	return -1; /* undecided */
 }
 
-int excluded(struct dir_struct *dir, const char *pathname, int *dtype_p)
+static int excluded(struct dir_struct *dir, const char *pathname, int *dtype_p)
 {
 	int pathlen = strlen(pathname);
 	int st;
diff --git a/dir.h b/dir.h
index 36a82b3..1a88a75 100644
--- a/dir.h
+++ b/dir.h
@@ -78,7 +78,6 @@ extern int read_directory(struct dir_struct *, const char *path, int len, const
 
 extern int excluded_from_list(const char *pathname, int pathlen, const char *basename,
 			      int *dtype, struct exclude_list *el);
-extern int excluded(struct dir_struct *, const char *, int *);
 struct dir_entry *dir_add_ignored(struct dir_struct *dir, const char *pathname, int len);
 
 /*
-- 
1.7.11.rc1.37.g09843ac
