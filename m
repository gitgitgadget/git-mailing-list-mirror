From: David Barr <davidbarr@google.com>
Subject: [PATCH v2 5/6] vcs-svn: fix signedness warnings
Date: Fri,  1 Jun 2012 00:41:29 +1000
Message-ID: <1338475290-22644-6-git-send-email-davidbarr@google.com>
References: <1338475290-22644-1-git-send-email-davidbarr@google.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 31 16:42:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa6aA-0003gL-LV
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 16:42:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449Ab2EaOmc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 10:42:32 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50238 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932389Ab2EaOma (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 10:42:30 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so1551829pbb.19
        for <git@vger.kernel.org>; Thu, 31 May 2012 07:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=jWgXtjQ3KRf2Qm8FjE37Iw1liQKN6Rl+t5X5Snng1J0=;
        b=krKOMLOV1By7Mlg6ixbVS7IEt7P+A0bNjZEF2tVK69nUFs2YiUFCX5fTy82StYAP8g
         Sy/E9zJudor2TFUGB1Ox7A12tjKAZKaf1Yi5HdjcWtuQ6TFS9A8h8KfShXLnkh+cro9b
         Gds3BhBzwIOPpAa4VLZnPWrDyY4WgWxPv7+w3QcNZfNqd2gbejB0NR6z+y4gKrMGvQuo
         1GuNLDCOQ8geRV9E9rK6DLn41OD9x6bnmbwhNRhXBlyMmYhIf3wu789o0Gwz5b4kZ4l/
         V0HTnn8yaY7lFpWZpgsiDEPryoJuo5xO8gIB1pFI5XFWJ96YHlCl1wwBoFhaj9Koj0YV
         fyEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=jWgXtjQ3KRf2Qm8FjE37Iw1liQKN6Rl+t5X5Snng1J0=;
        b=QTEp130RjajeqsoFum2yeOMovxWzMhw9OOMK6NM7ty5rStpZMIa7GbuD4XaENaHZif
         j6Af2rjvZVuGS3PDl5rGyTlxffJYhUXBhIGqgjK0lvztoXl2c0PD9wgUgZd8bMPGA1pB
         H5kKqUDnQm6wG4iMZbxTRUdzVpvxdQ+vl3HtDOjP9mqbowu0+0TS4skGWF4Rxnao9m1e
         JFn4kboXuqmpSFpLLZpHtI79e2lj+OTXGuPSuDj8QxqxUm05G7MIaxcItx7qPVznQWUM
         Z+CKLtucs6lE6OnK2tJi5QmK8frub6cd4felreaIgv6gVhh7BNHl04G+4kKii/ZV2M5/
         3l+Q==
Received: by 10.68.138.161 with SMTP id qr1mr539890pbb.37.1338475350281;
        Thu, 31 May 2012 07:42:30 -0700 (PDT)
Received: by 10.68.138.161 with SMTP id qr1mr539856pbb.37.1338475350016;
        Thu, 31 May 2012 07:42:30 -0700 (PDT)
Received: from localhost.localdomain (c122-107-58-35.blktn5.nsw.optusnet.com.au. [122.107.58.35])
        by mx.google.com with ESMTPS id og6sm4376720pbb.42.2012.05.31.07.42.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 31 May 2012 07:42:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2
In-Reply-To: <1338475290-22644-1-git-send-email-davidbarr@google.com>
X-Gm-Message-State: ALoCoQkO/yeiFdpiBd+lkG/Dg4PNZWNXDOVgXqLbUkj4+DcSoPjO+Ddneh8KqSuLVVHPaCPvkenK3mQoW+FyTBvtXzr4BWgPnkJhS/OIgBA0u2pZQfbbfyi8n/KvSF57x4PAyA5JIx5U5yhX66kmWF2r0Xe9iY6YmLxyeXORUMm4yEJufcSSkHE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198914>

Stop mixing off_t and size_t.

Signed-off-by: David Barr <davidbarr@google.com>
---
 vcs-svn/fast_export.c    |    4 ++--
 vcs-svn/sliding_window.c |    2 +-
 vcs-svn/svndiff.c        |    2 +-
 vcs-svn/svndump.c        |    4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index cda37dd..6ded98b 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -259,7 +259,7 @@ static int parse_ls_response(const char *response, uint32_t *mode,
 	}
 
 	/* Mode. */
-	if (response_end - response < strlen("100644") ||
+	if (response_end - response < (signed) strlen("100644") ||
 	    response[strlen("100644")] != ' ')
 		die("invalid ls response: missing mode: %s", response);
 	*mode = 0;
@@ -272,7 +272,7 @@ static int parse_ls_response(const char *response, uint32_t *mode,
 	}
 
 	/* ' blob ' or ' tree ' */
-	if (response_end - response < strlen(" blob ") ||
+	if (response_end - response < (signed) strlen(" blob ") ||
 	    (response[1] != 'b' && response[1] != 't'))
 		die("unexpected ls response: not a tree or blob: %s", response);
 	response += strlen(" blob ");
diff --git a/vcs-svn/sliding_window.c b/vcs-svn/sliding_window.c
index ec2707c..f11d490 100644
--- a/vcs-svn/sliding_window.c
+++ b/vcs-svn/sliding_window.c
@@ -54,7 +54,7 @@ int move_window(struct sliding_view *view, off_t off, size_t width)
 		return -1;
 	if (off < view->off || off + width < view->off + view->width)
 		return error("invalid delta: window slides left");
-	if (view->max_off >= 0 && view->max_off < off + width)
+	if (view->max_off >= 0 && view->max_off < off + (off_t) width)
 		return error("delta preimage ends early");
 
 	file_offset = view->off + view->buf.len;
diff --git a/vcs-svn/svndiff.c b/vcs-svn/svndiff.c
index 11a0e38..f061fae 100644
--- a/vcs-svn/svndiff.c
+++ b/vcs-svn/svndiff.c
@@ -78,7 +78,7 @@ static int read_chunk(struct line_buffer *delta, off_t *delta_len,
 		      struct strbuf *buf, size_t len)
 {
 	strbuf_reset(buf);
-	if (len > *delta_len ||
+	if ((off_t) len > *delta_len ||
 	    buffer_read_binary(delta, buf, len) != len)
 		return error_short_read(delta);
 	*delta_len -= buf->len;
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 8d0ae9c..6d1e3cd 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -40,8 +40,8 @@
 static struct line_buffer input = LINE_BUFFER_INIT;
 
 static struct {
-	uint32_t action, propLength, srcRev, type;
-	off_t text_length;
+	uint32_t action, srcRev, type;
+	off_t propLength, text_length;
 	struct strbuf src, dst;
 	uint32_t text_delta, prop_delta;
 } node_ctx;
-- 
1.7.10.2
