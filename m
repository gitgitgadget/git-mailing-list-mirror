From: Jon Forrest <nobozo@gmail.com>
Subject: [PATCH] For Real - Fixed pluralization in diff reports
Date: Sun, 31 Jul 2011 21:46:06 -0700
Message-ID: <4E362F8E.1050105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Aug 01 06:46:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnkOw-00018R-1i
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 06:46:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752212Ab1HAEqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 00:46:36 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:39327 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752195Ab1HAEqf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 00:46:35 -0400
Received: by pzk37 with SMTP id 37so10775958pzk.1
        for <git@vger.kernel.org>; Sun, 31 Jul 2011 21:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=9aDXnFnJ4Lk4jM2/mcaGHnuZD1hZ39U3lmTAt5K2ZbU=;
        b=Evo0JQTQWr6cbtmfevQ//SuSvz3UY5r31jcwItI5gwR6YCXUsuEEYGH3h4v8B/qhU8
         0WfjtA0GZwA0blSuO1RJEi0LZSNYA+BFmoLEW9+3JEkSvPoM2L0i87B57vuwR/STW+5b
         xkqkiiQ+WicLL+TxcvadDo4pTBeLc+JGLrqo4=
Received: by 10.68.7.1 with SMTP id f1mr7496861pba.304.1312173994806;
        Sun, 31 Jul 2011 21:46:34 -0700 (PDT)
Received: from [192.168.0.107] (c-98-248-228-150.hsd1.ca.comcast.net [98.248.228.150])
        by mx.google.com with ESMTPS id i9sm5094382pbk.84.2011.07.31.21.46.33
        (version=SSLv3 cipher=OTHER);
        Sun, 31 Jul 2011 21:46:34 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:5.0) Gecko/20110624 Thunderbird/5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178316>

[I must have accidentally removed the "s" in "deletions" before.
I just rebuilt everything and remade the patch. All looks well
this time. This is my first submitted patch to anything
so my fingers are still learning.]

I got irritated by the

      1 files changed, 0 insertions(+), 1 deletions(-)

lack of pluralization so I fixed it. Now it says

      1 file changed, 0 insertions(+), 1 deletion(-)

and so forth.

Signed-off-by: Jon Forrest <nobozo@gmail.com>
---
  diff.c |   10 ++++++----
  1 file changed, 6 insertions(+), 4 deletions(-)

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
-- 1.7.6.351.gb35ac.dirty
