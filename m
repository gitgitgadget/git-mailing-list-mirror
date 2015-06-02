From: Stefan Beller <sbeller@google.com>
Subject: [RFCv2 05/16] remote.h: Change get_remote_heads return to void
Date: Mon,  1 Jun 2015 17:02:07 -0700
Message-ID: <1433203338-27493-6-git-send-email-sbeller@google.com>
References: <1433203338-27493-1-git-send-email-sbeller@google.com>
Cc: pclouds@gmail.com, gitster@pobox.com, peff@peff.net,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 02:04:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzZfQ-0000iz-BU
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 02:02:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754553AbbFBACr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 20:02:47 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:38440 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754326AbbFBACi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 20:02:38 -0400
Received: by igbjd9 with SMTP id jd9so74727376igb.1
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 17:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EytYifRzfsb7M+574A4B1OKWvI9RAZo/RNxmfdC76nQ=;
        b=EipHYFuqng6gbckOLaKcALNtvjPVvQmiHwWMGBbE+c1S1c1AGFGVp3Dnn7UJyYCH8G
         sCkWOLRzPLyLIqX7o2eEk/kpJJqv9496eqrfKn0eajqZjZ0T++hIQpDjHy4CPyyuNImV
         5TbAAe2xAf2JcZwxkIUehWDIXO3EhtHakoRFbX1MKO6GtV7pjLDX3zpl5Bgj2ykmQWA4
         gpcXOtsNUO6zc+OmqLwMSCnwGyf+MtMxNWFHs+muTc7trO8YntIvnKgc0hVMzoYwRLtI
         Gh7abU+IQSTnr9fn+p6WkqCuVvrSx+rOUEU4XU91mGJhnDvhfBhKl/edBBj8BcfkgDXJ
         c2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EytYifRzfsb7M+574A4B1OKWvI9RAZo/RNxmfdC76nQ=;
        b=EsC+og74m4Xt2W8rx5zHhk9nAXbnvtgsifVHLUt57fG0bcJVuSffaNw4PTuLwB8vYQ
         byBhzNRQx4xBFO5E3oPslhHQOWQ+RMlIOXBeICF4Gz9QuaTOYaloYq7jwUg6144cAemt
         DFIUNa0wCESK+KXIgfxzjCQS2pgyoZi5LhyKbyom9yD99sx246+7eVcUmbjpX84J1rhr
         3fvJ8jzRnDwxe7e8yEDRRC/cD7t3J6Pg893LgbD0gp3ohSTN5p67PS2NjJeqayxgtacX
         YtsLxi8ultLHXdiWb4/piuLqRFnGdV/9Z2CpxUCSIpXrLVsON6JB4Thcf/VqbQP3vkue
         uWJQ==
X-Gm-Message-State: ALoCoQk4NI+9CgiTSNJ3JIiDAQlFemoHqI3wVVdwUS01EGAJvAT7Y/nBPUUPdYf0d2m+SowfLf3x
X-Received: by 10.42.176.8 with SMTP id bc8mr21006212icb.22.1433203358090;
        Mon, 01 Jun 2015 17:02:38 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:3900:deed:b754:addb])
        by mx.google.com with ESMTPSA id rr5sm8914005igb.7.2015.06.01.17.02.37
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Jun 2015 17:02:37 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.345.gab207b6.dirty
In-Reply-To: <1433203338-27493-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270490>

No function uses the return value of get_remote_heads, so we don't want
to confuse readers by it.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 connect.c | 10 ++++------
 remote.h  |  8 ++++----
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/connect.c b/connect.c
index 4295ba1..a2c777e 100644
--- a/connect.c
+++ b/connect.c
@@ -108,10 +108,10 @@ static void annotate_refs_with_symref_info(struct ref *ref)
 /*
  * Read all the refs from the other end
  */
-struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
-			      struct ref **list, unsigned int flags,
-			      struct sha1_array *extra_have,
-			      struct sha1_array *shallow_points)
+void get_remote_heads(int in, char *src_buf, size_t src_len,
+		      struct ref **list, unsigned int flags,
+		      struct sha1_array *extra_have,
+		      struct sha1_array *shallow_points)
 {
 	struct ref **orig_list = list;
 	int got_at_least_one_head = 0;
@@ -172,8 +172,6 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 	}
 
 	annotate_refs_with_symref_info(*orig_list);
-
-	return list;
 }
 
 static const char *parse_feature_value(struct string_list *feature_list, const char *feature, int *lenp)
diff --git a/remote.h b/remote.h
index 02d66ce..d5242b0 100644
--- a/remote.h
+++ b/remote.h
@@ -144,10 +144,10 @@ int check_ref_type(const struct ref *ref, int flags);
 void free_refs(struct ref *ref);
 
 struct sha1_array;
-extern struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
-				     struct ref **list, unsigned int flags,
-				     struct sha1_array *extra_have,
-				     struct sha1_array *shallow);
+extern void get_remote_heads(int in, char *src_buf, size_t src_len,
+			     struct ref **list, unsigned int flags,
+			     struct sha1_array *extra_have,
+			     struct sha1_array *shallow);
 
 int resolve_remote_symref(struct ref *ref, struct ref *list);
 int ref_newer(const unsigned char *new_sha1, const unsigned char *old_sha1);
-- 
2.4.1.345.gab207b6.dirty
