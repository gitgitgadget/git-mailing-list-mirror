From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 4/7] remote: expose parse_push_refspec()
Date: Thu, 23 May 2013 20:42:47 +0530
Message-ID: <1369321970-7759-5-git-send-email-artagnon@gmail.com>
References: <1369321970-7759-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 23 17:11:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfXB4-0003im-NX
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 17:11:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759299Ab3EWPLV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 11:11:21 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:45475 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759133Ab3EWPLQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 11:11:16 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc17so3026149pbc.4
        for <git@vger.kernel.org>; Thu, 23 May 2013 08:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=udMT6NAdThennZ+2J8GZB7ayHAVA56REzhxOvzu0E2w=;
        b=LXSwKLSqzjnsolBkz8q7xi9T035g8cZ5SB8fHTC7psyvtHrefU7/VwNQ1ecxV3xv4k
         IOzI+8LgMyAJaDYbAAsDnNRLRaCk+JtBhfs+VC+9lmVSHFWh/grEeNYnsaBAAjY24j9N
         kqp9gOytaDRTnvpaYn1iFl1Hys24G/AYXhe/8WBQ/rXM4yERtCNib3L28vDLun8jfVvo
         Qt7pM1I5A/S9031NhWekN7X0AwCzlN3wdsOg4Weobdtoq180eySBSwDI8fgYmbsWzt9A
         okPbuim1kCRjnbFnSpYZYQIPQliJAobydanfs+A1EHe/EPSoPVy8RAd62Oxx6e1dgmwL
         qSTA==
X-Received: by 10.68.171.196 with SMTP id aw4mr13236535pbc.78.1369321875998;
        Thu, 23 May 2013 08:11:15 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id vb8sm12099173pbc.11.2013.05.23.08.11.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 23 May 2013 08:11:15 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.17.gd95ec6c.dirty
In-Reply-To: <1369321970-7759-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225255>

parse_fetch_refspec() is already available to other callers via
remote.h.  There's no reason why parse_push_refspec() shouldn't be.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 remote.c | 2 +-
 remote.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index 68eb99b..99c44da 100644
--- a/remote.c
+++ b/remote.c
@@ -660,7 +660,7 @@ struct refspec *parse_fetch_refspec(int nr_refspec, const char **refspec)
 	return parse_refspec_internal(nr_refspec, refspec, 1, 0);
 }
 
-static struct refspec *parse_push_refspec(int nr_refspec, const char **refspec)
+struct refspec *parse_push_refspec(int nr_refspec, const char **refspec)
 {
 	return parse_refspec_internal(nr_refspec, refspec, 0, 0);
 }
diff --git a/remote.h b/remote.h
index cf56724..2497b93 100644
--- a/remote.h
+++ b/remote.h
@@ -94,6 +94,7 @@ void ref_remove_duplicates(struct ref *ref_map);
 
 int valid_fetch_refspec(const char *refspec);
 struct refspec *parse_fetch_refspec(int nr_refspec, const char **refspec);
+struct refspec *parse_push_refspec(int nr_refspec, const char **refspec);
 
 void free_refspec(int nr_refspec, struct refspec *refspec);
 
-- 
1.8.3.rc3.17.gd95ec6c.dirty
