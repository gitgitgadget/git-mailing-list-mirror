From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] bash: support 'git notes' and its subcommands
Date: Thu, 28 Jan 2010 02:05:55 +0100
Message-ID: <1264640755-22447-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jan 28 02:06:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaIpr-00023Q-Vw
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 02:06:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754803Ab0A1BGL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Jan 2010 20:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753027Ab0A1BGK
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 20:06:10 -0500
Received: from moutng.kundenserver.de ([212.227.17.9]:61956 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610Ab0A1BGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 20:06:09 -0500
Received: from [127.0.1.1] (p5B1303A9.dip0.t-ipconnect.de [91.19.3.169])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0LtlI5-1NkEzz3W21-011i4D; Thu, 28 Jan 2010 02:06:07 +0100
X-Mailer: git-send-email 1.7.0.rc0.28.g3ad3d5
X-Provags-ID: V01U2FsdGVkX1/i4c5iCthkINhUMCubj84jyqPwzFPJTFZYryT
 Hy9M9teJvx//vzwHEnvhml0nNTHcdIuqrh4BjDT4qpln+vrAGM
 kZFvnJcE+9zrhxUnRz95g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138214>

=2E.. and it will offer refs unless after -m or -F, because these two
options require a non-ref argument.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 9651720..8b56c34 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1306,6 +1306,24 @@ _git_name_rev ()
 	__gitcomp "--tags --all --stdin"
 }
=20
+_git_notes ()
+{
+	local subcommands=3D"edit show"
+	if [ -z "$(__git_find_on_cmdline "$subcommands")" ]; then
+		__gitcomp "$subcommands"
+		return
+	fi
+
+	case "${COMP_WORDS[COMP_CWORD-1]}" in
+	-m|-F)
+		COMPREPLY=3D()
+		;;
+	*)
+		__gitcomp "$(__git_refs)"
+		;;
+	esac
+}
+
 _git_pull ()
 {
 	__git_complete_strategy && return
@@ -2218,6 +2236,7 @@ _git ()
 	merge-base)  _git_merge_base ;;
 	mv)          _git_mv ;;
 	name-rev)    _git_name_rev ;;
+	notes)       _git_notes ;;
 	pull)        _git_pull ;;
 	push)        _git_push ;;
 	rebase)      _git_rebase ;;
--=20
1.7.0.rc0.28.g3ad3d5
