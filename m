From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 07/16] blame: document multiple -L support
Date: Tue,  6 Aug 2013 09:59:40 -0400
Message-ID: <1375797589-65308-8-git-send-email-sunshine@sunshineco.com>
References: <1375797589-65308-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 06 16:01:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6hoq-0003fH-MQ
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 16:01:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755069Ab3HFOAn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 10:00:43 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:40107 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754309Ab3HFOAj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 10:00:39 -0400
Received: by mail-oa0-f48.google.com with SMTP id o17so732961oag.7
        for <git@vger.kernel.org>; Tue, 06 Aug 2013 07:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HqK1BUitEjsrTOitMq02kbbJ2xlwWCHCDPWbh38Z8rM=;
        b=iefGmm+8qlfpA+NvP6b8CL/vMT+s2cJXi0wCeCkMFYCsLU1lEdpmNJK39yVtoKOUKF
         KuNPEEy1n0d0yrHzg6u70SbJ2Nc4m7luOPdE0gMncnM16PwqOf7o3V1Y1mPilobXfnIM
         eCB9V5OARhV67ESvK9GVMVVKjDp6GvVdXrEhLdX96wjFIBJ2srIkaw2g6FH5YEVYFOxD
         PFzPioWV5IRgyxG61vskiexDSQXkUrEAViIP7z1LRi0A5dWhNO/MzwKG+/xD753yhwBr
         EDGY0INGAgZhruzVlbh1W3TMDF2GDpHNSqIN9Q+xqLB2iJ9CY6CD8cFCO7lI12wL44aT
         0mqw==
X-Received: by 10.60.76.72 with SMTP id i8mr1166050oew.11.1375797639227;
        Tue, 06 Aug 2013 07:00:39 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id z2sm1380175obi.3.2013.08.06.07.00.37
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 06 Aug 2013 07:00:38 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc1.409.gbd48715
In-Reply-To: <1375797589-65308-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231747>

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/blame-options.txt |  8 +++++---
 Documentation/git-blame.txt     | 10 +++++++---
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index 489032c..0cebc4f 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -11,9 +11,11 @@
 
 -L <start>,<end>::
 -L :<regex>::
-	Annotate only the given line range.  <start> and <end> are optional.
-	``-L <start>'' or ``-L <start>,'' spans from <start> to end of file.
-	``-L ,<end>'' spans from start of file to <end>.
+	Annotate only the given line range. May be specified multiple times.
+	Overlapping ranges are allowed.
++
+<start> and <end> are optional. ``-L <start>'' or ``-L <start>,'' spans from
+<start> to end of file. ``-L ,<end>'' spans from start of file to <end>.
 +
 include::line-range-format.txt[]
 
diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index 6cea7f1..f2c85cc 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git blame' [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-e] [-p] [-w] [--incremental]
-	    [-L n,m | -L :fn] [-S <revs-file>] [-M] [-C] [-C] [-C] [--since=<date>]
+	    [-L <range>] [-S <revs-file>] [-M] [-C] [-C] [-C] [--since=<date>]
 	    [--abbrev=<n>] [<rev> | --contents <file> | --reverse <rev>] [--] <file>
 
 DESCRIPTION
@@ -18,7 +18,8 @@ DESCRIPTION
 Annotates each line in the given file with information from the revision which
 last modified the line. Optionally, start annotating from the given revision.
 
-The command can also limit the range of lines annotated.
+When specified one or more times, `-L` restricts annotation to the requested
+lines.
 
 The origin of lines is automatically followed across whole-file
 renames (currently there is no option to turn the rename-following
@@ -130,7 +131,10 @@ SPECIFYING RANGES
 
 Unlike 'git blame' and 'git annotate' in older versions of git, the extent
 of the annotation can be limited to both line ranges and revision
-ranges.  When you are interested in finding the origin for
+ranges. The `-L` option, which limits annotation to a range of lines, may be
+specified multiple times.
+
+When you are interested in finding the origin for
 lines 40-60 for file `foo`, you can use the `-L` option like so
 (they mean the same thing -- both ask for 21 lines starting at
 line 40):
-- 
1.8.4.rc1.409.gbd48715
