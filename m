From: "Michael G. Schwern" <schwern@pobox.com>
Subject: [PATCH 1/3] Quiet warning if Makefile.PL is run with -w and no --localedir
Date: Tue, 24 Jul 2012 20:21:09 -0700
Message-ID: <1343186471-1024-2-git-send-email-schwern@pobox.com>
References: <1343186471-1024-1-git-send-email-schwern@pobox.com>
Cc: robbat2@gentoo.org, bwalton@artsci.utoronto.ca,
	normalperson@yhbt.net, "Michael G. Schwern" <schwern@pobox.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 25 05:21:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StsAS-0006Eo-Na
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 05:21:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756202Ab2GYDVj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 23:21:39 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:61261 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756139Ab2GYDVj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 23:21:39 -0400
Received: by yhmm54 with SMTP id m54so265784yhm.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 20:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=n5IG1L+UuRVDalZgHFudvJWjUfKzKkXlMCeuiYcWDwo=;
        b=nQuH589/IWBtRRP+7Mt53Uzz0CBIIoUYgJNTjd/023xXqZ0DuJpUqDJ8w1TMUUpxDn
         7KqH2VTI2zD4lbWjWyuChISkhZfB/90Enkz86+/sRyjGv8wyXeD1WbGcopMT6Nm9nnbk
         /HIVp7uAi2rDjKZpUSeLT6P5wDtfRyhyn9kbAzT+6kjkh2tyDLz89QAf6l4fqZurrkez
         ZoJZ6dK0DN0kmtEfqY3M0mGYpcv/CbuU7g7hnqb6Td5PEtSjUoRw/W6XTDCm3UngM9hT
         Zlb9PVvo1K9UlLCaH43T/ioBV7pqurjAQihi+In8aJgGCBAfFSA6sGLbvGNiQb+L7rap
         sApw==
Received: by 10.66.78.9 with SMTP id x9mr9323948paw.84.1343186498267;
        Tue, 24 Jul 2012 20:21:38 -0700 (PDT)
Received: from windhund.local.net (c-71-236-173-173.hsd1.or.comcast.net. [71.236.173.173])
        by mx.google.com with ESMTPS id hf5sm13423597pbc.4.2012.07.24.20.21.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 20:21:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1
In-Reply-To: <1343186471-1024-1-git-send-email-schwern@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202106>

From: "Michael G. Schwern" <schwern@pobox.com>

Usually it isn't, but its nice if it can be run with warnings on.

Signed-off-by: Michael G Schwern <schwern@pobox.com>
---
 perl/Makefile.PL | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/perl/Makefile.PL b/perl/Makefile.PL
index b54b04a..87e1f62 100644
--- a/perl/Makefile.PL
+++ b/perl/Makefile.PL
@@ -6,7 +6,8 @@ use Getopt::Long;
 # Sanity: die at first unknown option
 Getopt::Long::Configure qw/ pass_through /;
 
-GetOptions("localedir=s" => \my $localedir);
+my $localedir = '';
+GetOptions("localedir=s" => \$localedir);
 
 sub MY::postamble {
 	return <<'MAKE_FRAG';
-- 
1.7.11.1
