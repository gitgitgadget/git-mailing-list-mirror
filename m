From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: [PATCH 2/2] completion: add git status
Date: Wed, 1 Jun 2016 01:42:18 +0200
Message-ID: <b881e8b7-8364-f78b-d7ac-817850783c6e@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	=?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 01 02:04:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7teZ-0003Kl-73
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 02:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755911AbcFAAEw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 20:04:52 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:44526 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752711AbcFAAEv (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2016 20:04:51 -0400
X-Greylist: delayed 1123 seconds by postgrey-1.27 at vger.kernel.org; Tue, 31 May 2016 20:04:51 EDT
Received: from p4fc87c53.dip0.t-ipconnect.de ([79.200.124.83] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1b7tMM-00085y-MQ; Wed, 01 Jun 2016 01:46:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1464739491;fd0ee496;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296038>

Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
---
 contrib/completion/git-completion.bash | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 57a0acc..96b7d86 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1782,6 +1782,35 @@ _git_stage ()
 	_git_add
 }
 +_git_status ()
+{
+	case "$cur" in
+	--ignore-submodules=*)
+		__gitcomp "none untracked dirty all" "" "${cur##--ignore-submodules=}"
+		return
+		;;
+	--untracked-files=*)
+		__gitcomp "$(__git_untracked_file_modes)" "" "${cur##--untracked-files=}"
+		return
+		;;
+	--column=*)
+		__gitcomp "
+			always never auto column row plain dense nodense
+			" "" "${cur##--column=}"
+		return
+		;;
+	--*)
+		__gitcomp "
+			--short --branch --porcelain --long --verbose
+			--untracked-files= --ignore-submodules= --ignored
+			--column= --no-column
+			"
+		return
+		;;
+	esac
+	__git_complete_file
+}
+
 __git_config_get_set_variables ()
 {
 	local prevword word config_file= c=$cword
-- 
2.8.3.windows.1
