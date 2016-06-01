From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: [PATCH v2 2/2] completion: add git status
Date: Wed, 01 Jun 2016 11:37:37 +0200
Message-ID: <1464773857.4315.1.camel@virtuell-zuhause.de>
References: <20160601040542.GA18978@sigill.intra.peff.net>
	 <6e722a5fb64b73373ac6450ec9600e98745df29d.1464769152.git.thomas.braun@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	SZEDER =?ISO-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 01 11:37:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b82az-0000OS-Em
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 11:37:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758053AbcFAJhm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 05:37:42 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:33842 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757708AbcFAJhk (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Jun 2016 05:37:40 -0400
Received: from p4fc87c53.dip0.t-ipconnect.de ([79.200.124.83] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1b82ao-0001la-C3; Wed, 01 Jun 2016 11:37:38 +0200
In-Reply-To: <6e722a5fb64b73373ac6450ec9600e98745df29d.1464769152.git.thomas.braun@virtuell-zuhause.de>
X-Mailer: Evolution 3.12.9-1+b1 
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1464773860;26a483d3;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296072>

Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
---
 contrib/completion/git-completion.bash | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index addea89..77343da 100644
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
+		__gitcomp "$__git_untracked_file_modes" "" "${cur##--untracked-files=}"
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
