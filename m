From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH] git-gui: Fix use of renamed tag.
Date: Mon, 29 Nov 2010 09:21:57 +0100
Message-ID: <c24527d4bb9cdc1f72f27c2154d0320ee5579fa1.1291018765.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Mon Nov 29 09:22:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMz0T-0007MP-Se
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 09:22:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751607Ab0K2IWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 03:22:16 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:55444 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751546Ab0K2IWO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 03:22:14 -0500
Received: by eye27 with SMTP id 27so1762329eye.19
        for <git@vger.kernel.org>; Mon, 29 Nov 2010 00:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=1ICAd7wNoaO0LkwA/O9ojDWEOiszBLQroj5llu5N2ng=;
        b=eo6qbP0S057ArXOEIc20dIn+46OU8eNRVNAF/GVMPNi/P74wgMVdod0TLwJQbhUvHn
         o8pdokdh/E5IeKse3y1loSTB/b8tf1vPtuGHQSZ34gssdQFoo487NfZBvMTVN1y3pZps
         ldWx6UUTv00LOwUnK9h1A0gtTGd4ajSlsRqEw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=tTJW5/leEjx4gcwU+KGjm9Jra30erqWqWfXOl1oHharE5i0uqQaM9HJhOOQnShz7BP
         xS/M/F39HjrBFlg8bC+H0VJhaDhjcI1fTRRp3UK5l50kTC4kuujMvxggfb50dienrz8s
         z/cQ1LoVfaF7MVWN/JQnd/DhG9nbWOXvzY15Y=
Received: by 10.213.16.72 with SMTP id n8mr24783eba.38.1291018933058;
        Mon, 29 Nov 2010 00:22:13 -0800 (PST)
Received: from localhost ([109.250.138.95])
        by mx.google.com with ESMTPS id w20sm4904700eeh.6.2010.11.29.00.22.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Nov 2010 00:22:11 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.1200.ge4bf6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162375>

The d======= was renamed to d= in 4590307.

Fix this.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 lib/diff.tcl |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/diff.tcl b/lib/diff.tcl
index 8fea947..7b1fddf 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -122,22 +122,22 @@ proc show_unmerged_diff {cont_info} {
 	if {$merge_stages(2) eq {}} {
 		set is_conflict_diff 1
 		lappend current_diff_queue \
-			[list [mc "LOCAL: deleted\nREMOTE:\n"] d======= \
+			[list [mc "LOCAL: deleted\nREMOTE:\n"] d= \
 			    [list ":1:$current_diff_path" ":3:$current_diff_path"]]
 	} elseif {$merge_stages(3) eq {}} {
 		set is_conflict_diff 1
 		lappend current_diff_queue \
-			[list [mc "REMOTE: deleted\nLOCAL:\n"] d======= \
+			[list [mc "REMOTE: deleted\nLOCAL:\n"] d= \
 			    [list ":1:$current_diff_path" ":2:$current_diff_path"]]
 	} elseif {[lindex $merge_stages(1) 0] eq {120000}
 		|| [lindex $merge_stages(2) 0] eq {120000}
 		|| [lindex $merge_stages(3) 0] eq {120000}} {
 		set is_conflict_diff 1
 		lappend current_diff_queue \
-			[list [mc "LOCAL:\n"] d======= \
+			[list [mc "LOCAL:\n"] d= \
 			    [list ":1:$current_diff_path" ":2:$current_diff_path"]]
 		lappend current_diff_queue \
-			[list [mc "REMOTE:\n"] d======= \
+			[list [mc "REMOTE:\n"] d= \
 			    [list ":1:$current_diff_path" ":3:$current_diff_path"]]
 	} else {
 		start_show_diff $cont_info
-- 
1.7.3.2.1200.ge4bf6
