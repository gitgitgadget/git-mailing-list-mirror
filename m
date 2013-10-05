From: Stefan Saasen <ssaasen@atlassian.com>
Subject: [PATCH] mergetools/diffmerge: support DiffMerge as a git mergetool
Date: Sat,  5 Oct 2013 01:29:01 -0700
Message-ID: <1380961741-85909-1-git-send-email-ssaasen@atlassian.com>
Cc: davvid@gmail.com, Stefan Saasen <ssaasen@atlassian.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 05 10:30:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VSNFT-0000Qe-HH
	for gcvg-git-2@plane.gmane.org; Sat, 05 Oct 2013 10:30:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411Ab3JEI3n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Oct 2013 04:29:43 -0400
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:44465 "HELO
	na3sys009aog128.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751302Ab3JEI3k (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Oct 2013 04:29:40 -0400
X-Greylist: delayed 64366 seconds by postgrey-1.27 at vger.kernel.org; Sat, 05 Oct 2013 04:29:40 EDT
Received: from mail-pa0-f47.google.com ([209.85.220.47]) (using TLSv1) by na3sys009aob128.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUk/N9LWInI7kun6oqpyHgMTKezlqyDRK@postini.com; Sat, 05 Oct 2013 01:29:40 PDT
Received: by mail-pa0-f47.google.com with SMTP id kp14so5106592pab.20
        for <git@vger.kernel.org>; Sat, 05 Oct 2013 01:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4sLyHpGOI8qIFLtaye8PFTW+HTogG7KjwQZppMaT/zs=;
        b=CqqfofXGJHh/HtlPyHlq25lOa1WGocSNLK1IzjG5ya1cQXWs1mBrsryhfprqF9HG7N
         59e9AU0czmbRs+Jz9xit6P08aaYzdyaCckU1qK2tNhJUek/ibv44wZFpIWVXsrS4EPl+
         BQGLjHe7dIuAO/YqlDDil+UsustIBuZN7hRK4BbXOYzU7vvPbr16UUAj1f4jIFQqKz/y
         xrW4Jsa2hAlDFZbdoBzidxZzD6w3XtfAxuWGAw17AWekGbMgKkGtxP7TFPOysguQ6YiH
         CbBkc1heKnvfeHcyrZasW+bHVH6loUVDTEIF90JHrB6j/pyhuQ8CwhOmiGtkvXqC7HVX
         r9Ow==
X-Gm-Message-State: ALoCoQk/ggvLPkGzB1uYLLi6tQI5dk+5rqK2kb6SionfRCneRMQCbmzBf7NVGhRgY9POJ8Vd4hK3/XHJlt8BC1JB+qjkU386jtiDlKMtfBeP7Z2R7fhH6AvHzoW4/b6BMkaf8iAvBWzimcw/Kuc/2l1H0w9rUm+xYQ==
X-Received: by 10.66.142.132 with SMTP id rw4mr20481267pab.6.1380961779719;
        Sat, 05 Oct 2013 01:29:39 -0700 (PDT)
X-Received: by 10.66.142.132 with SMTP id rw4mr20481259pab.6.1380961779610;
        Sat, 05 Oct 2013 01:29:39 -0700 (PDT)
Received: from monteiths.local ([69.38.217.3])
        by mx.google.com with ESMTPSA id yo2sm23751826pab.8.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 05 Oct 2013 01:29:39 -0700 (PDT)
Received: by monteiths.local (Postfix, from userid 501)
	id 524EB1E85B67; Sat,  5 Oct 2013 01:29:04 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.475.g3a5bb13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235725>

DiffMerge is a non-free (but gratis) tool that supports OS X, Windows and Linux.

    See http://www.sourcegear.com/diffmerge/

DiffMerge includes a script `/usr/bin/diffmerge` that can be used to launch the
graphical compare tool.

This change adds mergetool support for DiffMerge and adds 'diffmerge' as an
option to the mergetool help.

Signed-off-by: Stefan Saasen <ssaasen@atlassian.com>
---
 contrib/completion/git-completion.bash |  2 +-
 git-mergetool--lib.sh                  |  2 +-
 mergetools/diffmerge                   | 15 +++++++++++++++
 3 files changed, 17 insertions(+), 2 deletions(-)
 create mode 100644 mergetools/diffmerge

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e1b7313..07b0ba5 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1188,7 +1188,7 @@ _git_diff ()
 	__git_complete_revlist_file
 }
 
-__git_mergetools_common="diffuse ecmerge emerge kdiff3 meld opendiff
+__git_mergetools_common="diffuse diffmerge ecmerge emerge kdiff3 meld opendiff
 			tkdiff vimdiff gvimdiff xxdiff araxis p4merge bc3 codecompare
 "
 
diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index feee6a4..6d0fa3b 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -250,7 +250,7 @@ list_merge_tool_candidates () {
 		else
 			tools="opendiff kdiff3 tkdiff xxdiff meld $tools"
 		fi
-		tools="$tools gvimdiff diffuse ecmerge p4merge araxis bc3 codecompare"
+		tools="$tools gvimdiff diffuse diffmerge ecmerge p4merge araxis bc3 codecompare"
 	fi
 	case "${VISUAL:-$EDITOR}" in
 	*vim*)
diff --git a/mergetools/diffmerge b/mergetools/diffmerge
new file mode 100644
index 0000000..85ac720
--- /dev/null
+++ b/mergetools/diffmerge
@@ -0,0 +1,15 @@
+diff_cmd () {
+	"$merge_tool_path" "$LOCAL" "$REMOTE" >/dev/null 2>&1
+}
+
+merge_cmd () {
+	if $base_present
+	then
+		"$merge_tool_path" --merge --result="$MERGED" \
+			"$LOCAL" "$BASE" "$REMOTE"
+	else
+		"$merge_tool_path" --merge \
+			--result="$MERGED" "$LOCAL" "$REMOTE"
+	fi
+	status=$?
+}
-- 
1.8.4.475.g3a5bb13
