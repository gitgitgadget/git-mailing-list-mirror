From: Timo Hirvonen <tihirvon@gmail.com>
Subject: [PATCH 7/7] Remove awkward compatibility warts
Date: Sat, 24 Jun 2006 20:28:42 +0300
Message-ID: <20060624202842.61901710.tihirvon@gmail.com>
References: <20060624201843.a5b4f7b9.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 24 19:30:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuBy0-0001Zn-8D
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 19:30:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbWFXRad (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 13:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbWFXRad
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 13:30:33 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:17675 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750969AbWFXRac (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 13:30:32 -0400
Received: by nf-out-0910.google.com with SMTP id m19so402614nfc
        for <git@vger.kernel.org>; Sat, 24 Jun 2006 10:30:31 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=KqK9tMUi02Bji9ywNNpRrni5tF2pmYaC6ZDh3TvUGgVer8cNj+W0L6OdcpJsXBrivR4QJdMHVOmUNkoqIrfgefoUvkRQld/WdvQAaBIw3s8L55aWbnjvYw4s1ewDjddUjPWPo31kBUPGh6UWx/YXAr8V5AnEf6wDnxaSnMRvR1I=
Received: by 10.48.47.19 with SMTP id u19mr3516836nfu;
        Sat, 24 Jun 2006 10:30:31 -0700 (PDT)
Received: from garlic.home.net ( [82.128.229.197])
        by mx.gmail.com with ESMTP id r33sm4227734nfc.2006.06.24.10.30.30;
        Sat, 24 Jun 2006 10:30:31 -0700 (PDT)
To: junkio@cox.net
In-Reply-To: <20060624201843.a5b4f7b9.tihirvon@gmail.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22533>


Signed-off-by: Timo Hirvonen <tihirvon@gmail.com>
---
 builtin-diff-files.c |    7 -------
 builtin-diff.c       |    7 -------
 2 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/builtin-diff-files.c b/builtin-diff-files.c
index a655eea..3361898 100644
--- a/builtin-diff-files.c
+++ b/builtin-diff-files.c
@@ -47,12 +47,5 @@ int cmd_diff_files(int argc, const char 
 	if (rev.pending.nr ||
 	    rev.min_age != -1 || rev.max_age != -1)
 		usage(diff_files_usage);
-	/*
-	 * Backward compatibility wart - "diff-files -s" used to
-	 * defeat the common diff option "-s" which asked for
-	 * DIFF_FORMAT_NO_OUTPUT.
-	 */
-	if (rev.diffopt.output_format == DIFF_FORMAT_NO_OUTPUT)
-		rev.diffopt.output_format = DIFF_FORMAT_RAW;
 	return run_diff_files(&rev, silent);
 }
diff --git a/builtin-diff.c b/builtin-diff.c
index 47e0a37..076eb09 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -56,13 +56,6 @@ static int builtin_diff_files(struct rev
 	if (revs->max_count < 0 &&
 	    (revs->diffopt.output_format & DIFF_FORMAT_PATCH))
 		revs->combine_merges = revs->dense_combined_merges = 1;
-	/*
-	 * Backward compatibility wart - "diff-files -s" used to
-	 * defeat the common diff option "-s" which asked for
-	 * DIFF_FORMAT_NO_OUTPUT.
-	 */
-	if (revs->diffopt.output_format == DIFF_FORMAT_NO_OUTPUT)
-		revs->diffopt.output_format = DIFF_FORMAT_RAW;
 	return run_diff_files(revs, silent);
 }
 
-- 
1.4.1.rc1.g8637
