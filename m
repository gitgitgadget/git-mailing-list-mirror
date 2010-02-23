From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 4/4] bash: completion for gitk aliases
Date: Tue, 23 Feb 2010 22:03:00 +0100
Message-ID: <45bffa3348f19ef549ec2fcae88da6f1ebb17f1e.1266958460.git.szeder@ira.uka.de>
References: <20100131191936.GA30466@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	David Rhodes Clymer <david@zettazebra.com>,
	Teemu Matilainen <teemu.matilainen@iki.fi>,
	git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 23 22:04:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk1vU-0002a5-8u
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 22:04:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753476Ab0BWVD7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2010 16:03:59 -0500
Received: from francis.fzi.de ([141.21.7.5]:22973 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753388Ab0BWVDy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 16:03:54 -0500
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 23 Feb 2010 22:03:51 +0100
X-Mailer: git-send-email 1.7.0.119.g9b76
In-Reply-To: <20100131191936.GA30466@neumann>
In-Reply-To: <cover.1266958460.git.szeder@ira.uka.de>
References: <cover.1266958460.git.szeder@ira.uka.de>
X-OriginalArrivalTime: 23 Feb 2010 21:03:51.0127 (UTC) FILETIME=[B3327670:01CAB4CB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140837>

gitk aliases either start with "!gitk", or look something like "!sh -c
=46OO=3Dbar gitk", IOW they contain the "gitk" word.  With this patch t=
he
completion script will recognize these cases and will offer gitk's
options.

Just like the earlier change improving on aliased command recognition,
this change can also be fooled easily by some complex aliases, but
users of such aliases could remedy it with custom completion
functions.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 8593fd7..3029f16 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -626,6 +626,10 @@ __git_aliased_command ()
 		config --get "alias.$1")
 	for word in $cmdline; do
 		case "$word" in
+		\!gitk|gitk)
+			echo "gitk"
+			return
+			;;
 		\!*)	: shell command alias ;;
 		-*)	: option ;;
 		*=3D*)	: setting env ;;
@@ -1087,6 +1091,11 @@ _git_gc ()
 	COMPREPLY=3D()
 }
=20
+_git_gitk ()
+{
+	_gitk
+}
+
 _git_grep ()
 {
 	__git_has_doubledash && return
--=20
1.7.0.119.g9b76
