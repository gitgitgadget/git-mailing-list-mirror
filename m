From: Jon Forrest <nobozo@gmail.com>
Subject: [PATCH] Fixed pluralization in diff reports
Date: Sun, 31 Jul 2011 21:00:57 -0700
Message-ID: <4E3624F9.7070406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Aug 01 06:01:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qnjh5-0006SC-PE
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 06:01:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797Ab1HAEB1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 00:01:27 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:34386 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699Ab1HAEB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 00:01:26 -0400
Received: by yia27 with SMTP id 27so3244388yia.19
        for <git@vger.kernel.org>; Sun, 31 Jul 2011 21:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=BQzH4xgJb4k1YRONRFSl5KcLtMKydNqKz+ewJDUuq4U=;
        b=gogrpEEUQMervfaSqXfH15ZsmRHIpiuj3qtZaxjlqjEBXF2s312lNjKM0sSk5PdfCz
         hWx3Bt9gTwgPyBccqWyMuh4D97/UA/lyI8aRz495YGLUooz8IlgPrhMoUxkjnOtPgXkc
         ycu6zOWV6lEk5BS1t+lHK6XgLshud+xkVvHME=
Received: by 10.142.171.2 with SMTP id t2mr261465wfe.25.1312171285067;
        Sun, 31 Jul 2011 21:01:25 -0700 (PDT)
Received: from [192.168.0.107] (c-98-248-228-150.hsd1.ca.comcast.net [98.248.228.150])
        by mx.google.com with ESMTPS id v17sm2829709wfd.17.2011.07.31.21.01.23
        (version=SSLv3 cipher=OTHER);
        Sun, 31 Jul 2011 21:01:24 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:5.0) Gecko/20110624 Thunderbird/5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178306>

I got irritated by the

	 1 files changed, 0 insertions(+), 1 deletions(-)

lack of pluralization so I fixed it. Now it says

	 1 file changed, 0 insertions(+), 1 deletion(-)

and so forth.

Signed-off-by: Jon Forrest <nobozo@gmail.com>
---
  diff.c |   10 ++++++----
  1 file changed, 6 insertions(+), 4 deletion(-)

diff --git a/diff.c b/diff.c
index 93ef9a2..a179b24 100644
--- a/diff.c
+++ b/diff.c
@@ -1465,8 +1465,9 @@ static void show_stats(struct diffstat_t *data, 
struct diff_options *options)
  	}
  	fprintf(options->file, "%s", line_prefix);
  	fprintf(options->file,
-	       " %d files changed, %d insertions(+), %d deletions(-)\n",
-	       total_files, adds, dels);
+	       " %d file%s changed, %d insertion%s(+), %d deletion%s(-)\n",
+	       total_files, total_files == 1 ? "" : "s", adds, adds == 1 ? "" 
: "s", dels,
+		dels == 1 ? "" : "s");
  }

  static void show_shortstats(struct diffstat_t *data, struct 
diff_options *options)
@@ -1496,8 +1497,9 @@ static void show_shortstats(struct diffstat_t 
*data, struct diff_options *option
  				options->output_prefix_data);
  		fprintf(options->file, "%s", msg->buf);
  	}
-	fprintf(options->file, " %d files changed, %d insertions(+), %d 
deletions(-)\n",
-	       total_files, adds, dels);
+	fprintf(options->file, " %d file%s changed, %d insertion%s(+), %d 
deletion%s(-)\n",
+	       total_files, total_files == 1 ? "" : "s", adds, adds == 1 ? "" 
: "s", dels,
+		dels == 1 ? "" : "s");
  }

  static void show_numstat(struct diffstat_t *data, struct diff_options 
*options)
-- 1.7.6.347.g4db0d.dirty
