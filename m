From: apodtele <apodtele@gmail.com>
Subject: [PATCH 2/2] diff --stat: clean up unused code
Date: Thu, 12 Oct 2006 15:40:55 -0400
Message-ID: <d620685f0610121240h85d7a6eq2e3a2cf66a7643c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Oct 12 22:27:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GY6QO-0006k1-E8
	for gcvg-git@gmane.org; Thu, 12 Oct 2006 21:41:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbWJLTk5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Oct 2006 15:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbWJLTk5
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Oct 2006 15:40:57 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:41076 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750824AbWJLTk4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Oct 2006 15:40:56 -0400
Received: by wx-out-0506.google.com with SMTP id s14so646548wxc
        for <git@vger.kernel.org>; Thu, 12 Oct 2006 12:40:56 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=D7oUP0gWX8LJPj11V9Gnrv4/4eGF3yvFIOf5pdc7EVZAIsPOYZXG5DyuwWqQwy5KY7FCAicN66bXEiEDdwMQnPb2qmnI2g8CMbkV8+aK6y+t75jHU6JgA+DnIWTx0M8zi83dkf/O/zm34n1cvz/+zBARs8Hw/aCphxELHUoP2n8=
Received: by 10.90.118.12 with SMTP id q12mr1753840agc;
        Thu, 12 Oct 2006 12:40:56 -0700 (PDT)
Received: by 10.90.95.6 with HTTP; Thu, 12 Oct 2006 12:40:55 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28795>

Clean up unused code.

Signed-off-by: Alexei Podtelezhnikov

--- diff.c	2006-10-12 15:07:30.000000000 -0400
+++ diff.c	2006-10-12 15:17:15.000000000 -0400
@@ -660,8 +660,8 @@

 static void show_stats(struct diffstat_t* data, struct diff_options *options)
 {
-	int i, len, add, del, total, adds = 0, dels = 0;
-	int max_change = 0, max_len = 0;
+	int i, len, add, del, adds = 0, dels = 0;
+	int max_len = 0;
 	int total_files = data->nr;
 	int width, name_width;
 	const char *reset, *set, *add_c, *del_c;
@@ -706,8 +706,6 @@

 		if (file->is_binary || file->is_unmerged)
 			continue;
-		if (max_change < change)
-			max_change = change;
 	}

 	/* Compute the width of the graph part;
@@ -718,10 +716,7 @@
 	 * and width is the width of the graph area.
 	 */
 	name_width = (name_width < max_len) ? name_width : max_len;
-	if (width < (name_width + 10) + max_change)
-		width = width - (name_width + 10);
-	else
-		width = max_change;
+	width = width - (name_width + 10);

 	for (i = 0; i < data->nr; i++) {
 		const char *prefix = "";
@@ -766,13 +761,11 @@
 		 */
 		add = added;
 		del = deleted;
-		total = add + del;
 		adds += add;
 		dels += del;

 		add = scale_nonlinear(add, width / 2);
 		del = scale_nonlinear(del, width / 2);
-		total = add + del;
 		show_name(prefix, name, len, reset, set);
 		printf("%5d ", added + deleted);
 		show_graph('+', add, add_c, reset);
