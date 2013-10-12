From: Stefan Saasen <ssaasen@atlassian.com>
Subject: [PATCH v3] mergetools/diffmerge: support DiffMerge as a git mergetool
Date: Sun, 13 Oct 2013 09:29:35 +1100
Message-ID: <1381616975-13582-1-git-send-email-ssaasen@atlassian.com>
Cc: davvid@gmail.com, git@vger.kernel.org,
	Stefan Saasen <ssaasen@atlassian.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Oct 13 00:29:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VV7h1-0002py-A9
	for gcvg-git-2@plane.gmane.org; Sun, 13 Oct 2013 00:29:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753355Ab3JLW3r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 18:29:47 -0400
Received: from na3sys009aog137.obsmtp.com ([74.125.149.18]:52784 "HELO
	na3sys009aog137.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752641Ab3JLW3q (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Oct 2013 18:29:46 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]) (using TLSv1) by na3sys009aob137.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUlnNWvlFExXqR6Lf8n3KXuXMVA7trRED@postini.com; Sat, 12 Oct 2013 15:29:46 PDT
Received: by mail-pd0-f171.google.com with SMTP id g10so5842226pdj.16
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 15:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WmmUfiWk6s7GDBY99SIdAWlK8agzWx/HV6VmVtsOEr4=;
        b=alLH/0Dhnw3rrvOMKIPPwA4EZbs3rg2c59RPkK6c0+SN1BDSuCCZfdgYJKhIlxP9YE
         A3QJXMXeSareQHb/o7CUbiHybZMf/T2CK8OhjK4NisAcFc7RVttl1gxce/kvV1vYu23h
         GpWinDf7sJmqUPMoRIkPUHLf2O0aGivpva8GfLWxViZDg2YNvdQKcXMAH+Aeervuj6ab
         Ek72uPwm7vt6QdNwfEW+n7g46FTFnw6dAF6Qit98CTUji9fnUFGUw29FqzWa145dWITO
         5Xabp5GBsYpfPHRZHi+TAGhmmupJbAPsphD9hB8YHkkujjSwSVSwfC+KUsMVvxcGZ9YP
         bQpA==
X-Gm-Message-State: ALoCoQnSB1wFGImqO77KM06qwIg1J7AqYGkj6lAeETYKEBl3ZS3njQEjeHl+yjO1FV/zvqSbnVf/SN9c/PW3UYyUGi7PlCaWr92Xxi4NyvL0vSbfqs0SZhbrSAf0WLZ7cRbfpP4eXp1fv0LpKKNqjtTc+Gh2we7+JQ==
X-Received: by 10.66.216.234 with SMTP id ot10mr29516741pac.122.1381616986022;
        Sat, 12 Oct 2013 15:29:46 -0700 (PDT)
X-Received: by 10.66.216.234 with SMTP id ot10mr29516727pac.122.1381616985880;
        Sat, 12 Oct 2013 15:29:45 -0700 (PDT)
Received: from monteiths.local (115-64-19-188.static.tpgi.com.au. [115.64.19.188])
        by mx.google.com with ESMTPSA id pu5sm80084820pac.21.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 15:29:45 -0700 (PDT)
Received: by monteiths.local (Postfix, from userid 501)
	id BB7AC1F27345; Sun, 13 Oct 2013 09:29:39 +1100 (EST)
X-Mailer: git-send-email 1.8.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236060>

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
index feee6a4..858bc37 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -250,7 +250,8 @@ list_merge_tool_candidates () {
 		else
 			tools="opendiff kdiff3 tkdiff xxdiff meld $tools"
 		fi
-		tools="$tools gvimdiff diffuse ecmerge p4merge araxis bc3 codecompare"
+		tools="$tools gvimdiff diffuse diffmerge ecmerge"
+		tools="$tools p4merge araxis bc3 codecompare"
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
