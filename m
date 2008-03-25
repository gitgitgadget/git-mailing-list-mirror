From: Teemu Likonen <tlikonen@iki.fi>
Subject: [PATCH] bash: Add long option completion for 'git send-email'
Date: Tue, 25 Mar 2008 21:15:55 +0200
Message-ID: <1206472555-9593-1-git-send-email-tlikonen@iki.fi>
Cc: gitster@pobox.com, spearce@spearce.org,
	Teemu Likonen <tlikonen@iki.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 20:17:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeEdl-0007Ko-Gc
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 20:16:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757325AbYCYTQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 15:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755988AbYCYTQA
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 15:16:00 -0400
Received: from pne-smtpout4-sn2.hy.skanova.net ([81.228.8.154]:51146 "EHLO
	pne-smtpout4-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754793AbYCYTP7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Mar 2008 15:15:59 -0400
Received: from mithlond.arda.local (80.220.180.181) by pne-smtpout4-sn2.hy.skanova.net (7.3.129)
        id 478BE663003D107B; Tue, 25 Mar 2008 20:15:58 +0100
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1JeEcl-0002V3-UK; Tue, 25 Mar 2008 21:15:55 +0200
X-Mailer: git-send-email 1.5.5.rc1.6.g5cc8f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78207>

Add the following long options to be completed with 'git send-email':

--bcc --cc --cc-cmd --chain-reply-to --compose --dry-run
--envelope-sender --from --identity --in-reply-to --no-chain-reply-to
--no-signed-off-by-cc --no-suppress-from --no-thread --quiet
--signed-off-by-cc --smtp-pass --smtp-server --smtp-server-port
--smtp-ssl --smtp-user --subject --suppress-cc --suppress-from
--thread --to

Signed-off-by: Teemu Likonen <tlikonen@iki.fi>
---

The shorter options like '--to' and '--cc' are not useful for actual
completion because there are longer options which start with same
letters (--thread, --cc-cmd). It's still useful to have these shorter
ones shown when user presses TAB key after typing two dashes (--).


 contrib/completion/git-completion.bash |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 5046f69..38a5cdc 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -871,6 +871,24 @@ _git_rebase ()
 	__gitcomp "$(__git_refs)"
 }
 
+_git_send_email ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$cur" in
+	--*)
+		__gitcomp "--bcc --cc --cc-cmd --chain-reply-to --compose
+			--dry-run --envelope-sender --from --identity
+			--in-reply-to --no-chain-reply-to --no-signed-off-by-cc
+			--no-suppress-from --no-thread --quiet
+			--signed-off-by-cc --smtp-pass --smtp-server
+			--smtp-server-port --smtp-ssl --smtp-user --subject
+			--suppress-cc --suppress-from --thread --to"
+		return
+		;;
+	esac
+	__git_complete_file
+}
+
 _git_config ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
@@ -1325,6 +1343,7 @@ _git ()
 	rebase)      _git_rebase ;;
 	remote)      _git_remote ;;
 	reset)       _git_reset ;;
+	send-email)  _git_send_email ;;
 	shortlog)    _git_shortlog ;;
 	show)        _git_show ;;
 	show-branch) _git_log ;;
@@ -1377,6 +1396,7 @@ complete -o default -o nospace -F _git_rebase git-rebase
 complete -o default -o nospace -F _git_config git-config
 complete -o default -o nospace -F _git_remote git-remote
 complete -o default -o nospace -F _git_reset git-reset
+complete -o default -o nospace -F _git_send_email git-send-email
 complete -o default -o nospace -F _git_shortlog git-shortlog
 complete -o default -o nospace -F _git_show git-show
 complete -o default -o nospace -F _git_stash git-stash
-- 
1.5.5.rc1.6.g5cc8f
