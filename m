From: Stefan Saasen <ssaasen@atlassian.com>
Subject: [PATCH v2] mergetools/diffmerge: support DiffMerge as a git mergetool
Date: Sat, 12 Oct 2013 16:01:10 +1100
Message-ID: <1381554070-12241-1-git-send-email-ssaasen@atlassian.com>
Cc: git@vger.kernel.org, Stefan Saasen <ssaasen@atlassian.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Oct 12 07:01:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUrKe-0006t2-5t
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 07:01:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766Ab3JLFBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 01:01:31 -0400
Received: from na3sys009aog136.obsmtp.com ([74.125.149.85]:46944 "HELO
	na3sys009aog136.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750727Ab3JLFBa (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Oct 2013 01:01:30 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]) (using TLSv1) by na3sys009aob136.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUljXqjcmlhj7qiCg/V5JE/g0St6eIiIU@postini.com; Fri, 11 Oct 2013 22:01:30 PDT
Received: by mail-pb0-f54.google.com with SMTP id ro12so5134534pbb.27
        for <git@vger.kernel.org>; Fri, 11 Oct 2013 22:01:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yg8FbpmWDJO03uZ8Xj+gDo3sdXDY6an03MS2f6Imnso=;
        b=QKbIlhGEB8xVoL3hWTx5LWFtcJzP3GhRze7c11/Ym8m1D23XwJbQgn5Oo3rAoGGoh2
         o7ecrjXrBFe6ynWWUKVPkIs04d/dtlJGqiYgIW/3IR5Xwirm+sURzY3nYffNcoc+PCi0
         h+dl0htuu7BVjpVlGAf26FonVThTwr5rAPO47LU7WXP1u7e+gr6iPtJQdXJHuLUjVENh
         hS8FY3gSeQ/LaT/Byuh8b/jXs5NXtTO7GidxRekjaHo80M35CVlJKVgLrmcynn2cx6CP
         kg2seafhx05/DokhVMSISy6UckaD+ssQ1iIoYjZFFEF8XIsiuXBvRXvxC74FF4SBhUXx
         TGEw==
X-Gm-Message-State: ALoCoQmt4CQAeEUFb57wzzN/80TU7xi1ygQ9Qp5Rr4QFYCFuBT1OQjA2Imh0pLg9EZgWRLcR77eYg1+6LsLTK18rVTimfDRWLCJkWSINI4gggeJYYKFQ9xOD9u8EVlcrMKjaoSYtMdFQH7w2g5rC4xACU2KBWRyIlA==
X-Received: by 10.66.234.131 with SMTP id ue3mr24920386pac.35.1381554089720;
        Fri, 11 Oct 2013 22:01:29 -0700 (PDT)
X-Received: by 10.66.234.131 with SMTP id ue3mr24920381pac.35.1381554089569;
        Fri, 11 Oct 2013 22:01:29 -0700 (PDT)
Received: from monteiths.local (115-64-19-188.static.tpgi.com.au. [115.64.19.188])
        by mx.google.com with ESMTPSA id ve9sm63608611pbc.19.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 11 Oct 2013 22:01:28 -0700 (PDT)
Received: by monteiths.local (Postfix, from userid 501)
	id 824AF1F25186; Sat, 12 Oct 2013 16:01:23 +1100 (EST)
X-Mailer: git-send-email 1.8.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235942>

DiffMerge is a non-free (but gratis) tool that supports OS X, Windows and Linux.

    See http://www.sourcegear.com/diffmerge/

DiffMerge includes a script `/usr/bin/diffmerge` that can be used to launch the
graphical compare tool.

This change adds mergetool support for DiffMerge and adds 'diffmerge' as an
option to the mergetool help.

Signed-off-by: Stefan Saasen <ssaasen@atlassian.com>
Acked-by: David Aguilar <davvid@gmail.com>
---
 contrib/completion/git-completion.bash |  2 +-
 git-mergetool--lib.sh                  |  3 ++-
 mergetools/diffmerge                   | 15 +++++++++++++++
 3 files changed, 18 insertions(+), 2 deletions(-)
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
index feee6a4..0fcb253 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -250,7 +250,8 @@ list_merge_tool_candidates () {
 		else
 			tools="opendiff kdiff3 tkdiff xxdiff meld $tools"
 		fi
-		tools="$tools gvimdiff diffuse ecmerge p4merge araxis bc3 codecompare"
+		tools="$tools gvimdiff diffuse diffmerge ecmerge "
+		tools+="p4merge araxis bc3 codecompare"
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
1.8.2.3
